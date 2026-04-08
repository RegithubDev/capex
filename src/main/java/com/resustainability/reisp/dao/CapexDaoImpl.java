package com.resustainability.reisp.dao;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import com.mysql.cj.log.Log;
import com.resustainability.reisp.model.CapexProposal;
import com.resustainability.reisp.model.IRM;
import com.resustainability.reisp.model.SBU;

@Repository
public class CapexDaoImpl implements CapexDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

   
    
    public void insertCapex(CapexProposal c) {
    	c.setProject_manager_designation("Project Manager");
        String sql = "INSERT INTO capex_proposal (capex_title, capex_number, department, business_unit, plant_code, location, " +
                     "asset_description, basic_cost, gst_rate, gst_amount, total_cost, roi_text, roi_file_name, roi_file_path, " +
                     "timeline_text, timeline_file_name, timeline_file_path, reason_text, reason_file_name, reason_file_path, " +
                     "prepared_by_name, prepared_by_designation, prepared_by_date, prepared_by_signature_path, " +
                     "project_manager_name, project_manager_designation, project_manager_signature_path, " +
                     "requested_by_name, requested_by_designation, requested_by_signature_path, " +
                     "head_of_plant_name, head_of_plant_designation, head_of_plant_date, head_of_plant_signature_path, " +
                     "status, created_by, phase_one, phase_two, phase_three,phase_four,current_pending_at,requested_by_date) " +
                     "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,GETDATE())";

        int count =   jdbcTemplate.update(sql,
            c.getCapex_title(), c.getCapex_number(), c.getDepartment(), c.getBusiness_unit(), c.getPlant_code(), 
            c.getLocation(), c.getAsset_description(), c.getBasic_cost(), c.getGst_rate(), c.getGst_amount(), 
            c.getTotal_cost(), c.getRoi_text(), c.getRoi_file_name(), c.getRoi_file_path(), 
            c.getTimeline_text(), c.getTimeline_file_name(), c.getTimeline_file_path(), 
            c.getReason_text(), c.getReason_file_name(), c.getReason_file_path(), 
            c.getPrepared_by_name(), c.getPrepared_by_designation(), c.getPrepared_by_date(), c.getPrepared_by_signature_path(),
            c.getProject_manager_name(), c.getProject_manager_designation(), c.getProject_manager_signature_path(),
            c.getRequested_by_name(), c.getRequested_by_designation(),c.getRequested_by_signature_path(),
            c.getHead_of_plant_name(), c.getHead_of_plant_designation(), c.getHead_of_plant_date(), c.getHead_of_plant_signature_path(),
            c.getStatus(), c.getCreated_by(), c.getPhase_one(), c.getPhase_two(), c.getPhase_three(),c.getPhase_three(), c.getProject_manager_name()
        );
        
        if (count > 0) {

            BigDecimal deductionAmount = BigDecimal.ZERO;

            // Prefer proposed_price first (as it's the final approved amount), fallback to total_cost
            String amountToDeduct = c.getProposed_price() != null && !c.getProposed_price().trim().isEmpty() 
                                    ? c.getProposed_price() 
                                    : c.getTotal_cost();

            // Safely parse the amount
            try {
                if (amountToDeduct != null && !amountToDeduct.trim().isEmpty()) {
                    // Remove commas and trim spaces
                    String cleanAmount = amountToDeduct.replace(",", "").trim();
                    deductionAmount = new BigDecimal(cleanAmount);
                }
            } catch (Exception e) {
                deductionAmount = BigDecimal.ZERO;
                System.err.println("Invalid amount format for deduction: " + amountToDeduct);
            }

            // IMPORTANT: Prevent negative deduction (safety check)
            if (deductionAmount.compareTo(BigDecimal.ZERO) < 0) {
                deductionAmount = deductionAmount.abs();   // convert negative to positive
            }

            String updateBudgetSql =
                "UPDATE plant " +
                "SET total_available_budget_fy = CAST( " +
                "       (ISNULL(TRY_CAST(total_available_budget_fy AS DECIMAL(18,2)), 0.00) - ?) " +
                "     AS VARCHAR(50)) " +
                "WHERE plant_code = ?";

            jdbcTemplate.update(updateBudgetSql, deductionAmount, c.getPlant_code());

            System.out.println("Budget Deduction Applied | Plant: " + c.getPlant_code() 
                               + " | Deducted: " + deductionAmount 
                               + " | Original Input: " + amountToDeduct);
        }}
    
    
	@Override
	public List<CapexProposal> getCapexList(CapexProposal obj) throws Exception {
		 List<CapexProposal> resultList = new ArrayList<>();
	        try {
	            StringBuilder sql = new StringBuilder();
	            List<Object> params = new ArrayList<>();
	            
	            // Build query with optional filters
	            sql.append("SELECT \r\n"
	                    + "    c.[id],\r\n"
	                    + "    c.[capex_title],\r\n"
	                    + "    c.[capex_number],\r\n"
	                    + "    c.[department], d.department_name,\r\n"
	                    + "    c.[business_unit],\r\n"
	                    + "    c.[plant_code],\r\n"
	                    + "    p.[plant_name],\r\n"
	                    + "    c.[location],\r\n"
	                    + "    c.[asset_description],c.remarks,\r\n"
	                    + "\r\n"
	                    + "    CONVERT(varchar(30), c.[basic_cost],1) AS basic_cost,\r\n"
	                    + "    CONVERT(varchar(30), c.[gst_rate],1) AS gst_rate,\r\n"
	                    + "    CONVERT(varchar(30), c.[gst_amount],1) AS gst_amount,\r\n"
	                    + "    CONVERT(varchar(30), c.[total_cost],1) AS total_cost,\r\n"
	                    + "    CONVERT(varchar(30), c.[total_budget],1) AS total_budget,\r\n"
	                    + "    CONVERT(varchar(30), c.[proposed_price],1) AS proposed_price,\r\n"
	                    + "    CONVERT(varchar(30), c.[available_balance],1) AS available_balance,\r\n"
	                    + "\r\n"
	                    + "    c.[roi_text],\r\n"
	                    + "    c.[regional_director_name],\r\n"
	                    + "    CAST(c.[regional_director_date] AS DATETIME2) AS regional_director_date,\r\n"
	                    + "    c.[roi_file_name],\r\n"
	                    + "    c.[roi_file_path],\r\n"
	                    + "\r\n"
	                    + "    c.[timeline_text],\r\n"
	                    + "    c.[timeline_file_name],\r\n"
	                    + "    c.[timeline_file_path],\r\n"
	                    + "\r\n"
	                    + "    c.[reason_text],\r\n"
	                    + "    c.[reason_file_name],\r\n"
	                    + "    c.[reason_file_path],\r\n"
	                    + "\r\n"
	                    + "    c.[prepared_by_name],\r\n"
	                    + "    c.[prepared_by_designation],\r\n"
	                    + "    CAST(c.[prepared_by_date] AS DATETIME2) AS prepared_by_date,\r\n"
	                    + "    c.[prepared_by_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[project_manager_name],\r\n"
	                    + "    c.[project_manager_designation],\r\n"
	                    + "    CAST(c.[project_manager_date] AS DATETIME2) AS project_manager_date,\r\n"
	                    + "    c.[project_manager_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[requested_by_name],\r\n"
	                    + "    c.[requested_by_designation],\r\n"
	                    + "    CAST(c.[requested_by_date] AS DATETIME2) AS requested_by_date,\r\n"
	                    + "    c.[requested_by_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[head_of_plant_name],\r\n"
	                    + "    c.[head_of_plant_designation],\r\n"
	                    + "    CAST(c.[head_of_plant_date] AS DATETIME2) AS head_of_plant_date,\r\n"
	                    + "    c.[head_of_plant_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[finance_department],\r\n"
	                    + "    c.[finance_category],\r\n"
	                    + "    c.[finance_status],\r\n"
	                    + "    c.[finance_name],\r\n"
	                    + "    c.[finance_designation],\r\n"
	                    + "    CAST(c.[finance_date] AS DATETIME2) AS finance_date,\r\n"
	                    + "    c.[finance_comments],\r\n"
	                    + "\r\n"
	                    + "    c.[head_projects_name],\r\n"
	                    + "    c.[head_projects_designation],\r\n"
	                    + "    CAST(c.[head_projects_date] AS DATETIME2) AS head_projects_date,\r\n"
	                    + "    c.[head_projects_comment],\r\n"
	                    + "    c.[head_projects_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[business_head_name],\r\n"
	                    + "    c.[business_head_designation],\r\n"
	                    + "    CAST(c.[business_head_date] AS DATETIME2) AS business_head_date,\r\n"
	                    + "    c.[business_head_comment],\r\n"
	                    + "    c.[business_head_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[finance_controller_name],\r\n"
	                    + "    CAST(c.[finance_controller_date] AS DATETIME2) AS finance_controller_date,\r\n"
	                    + "    c.[finance_controller_comment],\r\n"
	                    + "\r\n"
	                    + "    c.[cfo_name],\r\n"
	                    + "    c.[cfo_designation],\r\n"
	                    + "    CAST(c.[cfo_date] AS DATETIME2) AS cfo_date,\r\n"
	                    + "    c.[cfo_comment],\r\n"
	                    + "    c.[cfo_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[ceo_name],\r\n"
	                    + "    c.[ceo_designation],\r\n"
	                    + "    CAST(c.[ceo_date] AS DATETIME2) AS ceo_date,\r\n"
	                    + "    c.[ceo_comment],\r\n"
	                    + "    c.[ceo_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[status],\r\n"
	                    + "    c.[created_by], u.user_name,\r\n"
	                    + "    CAST(c.[created_at] AS DATETIME2) AS created_at,\r\n"
	                    + "    CAST(c.[updated_at] AS DATETIME2) AS updated_at,\r\n"
	                    + "\r\n"
	                    + "    c.[phase_one],c.reject_remarks,c.send_back_remarks,\r\n"
	                    + "    c.[phase_two],\r\n"
	                    + "    c.[phase_three],\r\n"
	                    + "    c.[phase_four],\r\n"
	                    + "    c.[current_pending_at],\r\n"
	                    + "    u1.user_name AS pendingAt,\r\n"
	                    + "    u1.role_type AS role_type,\r\n"
	                    + "    u1.role_type AS role\r\n"
	                    + "\r\n"
	                    + "FROM [capexDB].[dbo].[capex_proposal] c\r\n"
	                    + "LEFT JOIN [dbo].[plant] p ON c.plant_code = p.plant_code\r\n"
	                    + "LEFT JOIN [dbo].[user_profile] u ON c.created_by = u.user_id\r\n"
	                    + "LEFT JOIN [dbo].[department] d ON c.department = d.department_code\r\n"
	                    + "LEFT JOIN [dbo].[user_profile] u1 ON c.current_pending_at = u1.user_id "
	                    + "WHERE 1 = 1\r\n");
	            List<Object> paramList = new ArrayList<>();

	            if (obj != null && !"Admin".equals(obj.getRole())) {

	                sql.append(" AND ( ");
	                sql.append(" c.prepared_by_name = ? ");
	                sql.append(" OR c.project_manager_name = ? ");
	                sql.append(" OR c.requested_by_name = ? ");
	                sql.append(" OR c.head_of_plant_name = ? ");
	                sql.append(" OR c.finance_name = ? ");
	                sql.append(" OR c.regional_director_name = ? ");
	                sql.append(" OR c.head_projects_name = ? ");
	                sql.append(" OR c.business_head_name = ? ");
	                sql.append(" OR c.finance_controller_name = ? ");
	                sql.append(" OR c.cfo_name = ? ");
	                sql.append(" OR c.ceo_name = ? ");
	                sql.append(" OR c.current_pending_at = ? ");
	                sql.append(" OR c.created_by = ? ");
	                sql.append(" ) ");

	                for(int i=0;i<13;i++){
	                    paramList.add(obj.getUser());
	                }
	            }

	            sql.append(" ORDER BY c.created_at ASC");

		        // Debug logs
		        System.out.println("SQL = "+sql);
		        System.out.println("Params = "+paramList);


		        resultList = jdbcTemplate.query(
		                sql.toString(),
		                paramList.toArray(),
		                new BeanPropertyRowMapper<>(CapexProposal.class)
		        );
	        } catch (Exception e) {
	            e.printStackTrace();
	            throw new Exception("Error fetching SBU list: " + e.getMessage(), e);
	        }
	        return resultList;
	}


	@Override
	public CapexProposal getCapexEditFormPage(CapexProposal obj) throws Exception {
		CapexProposal capex = null;
		try {
			 StringBuilder query = new StringBuilder();
	            List<Object> params = new ArrayList<>();
	            
	            query.append("SELECT \r\n"
	                    + "    c.[id],\r\n"
	                    + "    c.[capex_title],\r\n"
	                    + "    c.[capex_number],\r\n"
	                    + "    c.[department],\r\n"
	                    + "    c.[business_unit],\r\n"
	                    + "    c.[plant_code],\r\n"
	                    + "    p.[plant_name],\r\n"
	                    + "    c.[location],\r\n"
	                    + "    c.[asset_description],c.remarks,\r\n"
	                    + "\r\n"
	                    + "    CONVERT(varchar(30), c.[basic_cost],1) AS basic_cost,\r\n"
	                    + "    CONVERT(varchar(30), c.[gst_rate],1) AS gst_rate,\r\n"
	                    + "    CONVERT(varchar(30), c.[gst_amount],1) AS gst_amount,\r\n"
	                    + "    CONVERT(varchar(30), c.[total_cost],1) AS total_cost,\r\n"
	                    + "    CONVERT(varchar(30), c.[total_budget],1) AS total_budget,\r\n"
	                    + "    CONVERT(varchar(30), c.[proposed_price],1) AS proposed_price,\r\n"
	                    + "    CONVERT(varchar(30), c.[available_balance],1) AS available_balance,\r\n"
	                    + "\r\n"
	                    + "    c.[roi_text],\r\n"
	                    + "    c.[regional_director_name],\r\n"
	                    + "    CAST(c.[regional_director_date] AS DATETIME2) AS regional_director_date,\r\n"
	                    + "    c.[roi_file_name],\r\n"
	                    + "    c.[roi_file_path],\r\n"
	                    + "\r\n"
	                    + "    c.[timeline_text],\r\n"
	                    + "    c.[timeline_file_name],\r\n"
	                    + "    c.[timeline_file_path],\r\n"
	                    + "\r\n"
	                    + "    c.[reason_text],\r\n"
	                    + "    c.[reason_file_name],\r\n"
	                    + "    c.[reason_file_path],\r\n"
	                    + "\r\n"
	                    + "    c.[prepared_by_name],\r\n"
	                    + "    c.[prepared_by_designation],\r\n"
	                    + "    CAST(c.[prepared_by_date] AS DATETIME2) AS prepared_by_date,\r\n"
	                    + "    c.[prepared_by_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[project_manager_name],\r\n"
	                    + "    c.[project_manager_designation],\r\n"
	                    + "    CAST(c.[project_manager_date] AS DATETIME2) AS project_manager_date,\r\n"
	                    + "    c.[project_manager_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[requested_by_name],\r\n"
	                    + "    c.[requested_by_designation],\r\n"
	                    + "    CAST(c.[requested_by_date] AS DATETIME2) AS requested_by_date,\r\n"
	                    + "    c.[requested_by_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[head_of_plant_name],\r\n"
	                    + "    c.[head_of_plant_designation],\r\n"
	                    + "    CAST(c.[head_of_plant_date] AS DATETIME2) AS head_of_plant_date,\r\n"
	                    + "    c.[head_of_plant_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[finance_department],c.reject_remarks,c.send_back_remarks,\r\n"
	                    + "    c.[finance_category],\r\n"
	                    + "    c.[finance_status],\r\n"
	                    + "    c.[finance_name],\r\n"
	                    + "    c.[finance_designation],\r\n"
	                    + "    CAST(c.[finance_date] AS DATETIME2) AS finance_date,\r\n"
	                    + "    c.[finance_comments],\r\n"
	                    + "\r\n"
	                    + "    c.[head_projects_name],\r\n"
	                    + "    c.[head_projects_designation],\r\n"
	                    + "    CAST(c.[head_projects_date] AS DATETIME2) AS head_projects_date,\r\n"
	                    + "    c.[regional_director_comment],\r\n"
	                    + "    c.[head_projects_comment],\r\n"
	                    + "    c.[head_projects_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[business_head_name],\r\n"
	                    + "    c.[business_head_designation],\r\n"
	                    + "    CAST(c.[business_head_date] AS DATETIME2) AS business_head_date,\r\n"
	                    + "    c.[business_head_comment],\r\n"
	                    + "    c.[business_head_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[finance_controller_name],\r\n"
	                    + "    CAST(c.[finance_controller_date] AS DATETIME2) AS finance_controller_date,\r\n"
	                    + "    c.[finance_controller_comment],\r\n"
	                    + "\r\n"
	                    + "    c.[cfo_name],\r\n"
	                    + "    c.[cfo_designation],\r\n"
	                    + "    CAST(c.[cfo_date] AS DATETIME2) AS cfo_date,\r\n"
	                    + "    c.[cfo_comment],\r\n"
	                    + "    c.[cfo_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[ceo_name],\r\n"
	                    + "    c.[ceo_designation],\r\n"
	                    + "    CAST(c.[ceo_date] AS DATETIME2) AS ceo_date,\r\n"
	                    + "    c.[ceo_comment],\r\n"
	                    + "    c.[ceo_signature_path],\r\n"
	                    + "\r\n"
	                    + "    c.[status],\r\n"
	                    + "    c.[created_by], u.user_name,\r\n"
	                    + "    CAST(c.[created_at] AS DATETIME2) AS created_at,\r\n"
	                    + "    CAST(c.[updated_at] AS DATETIME2) AS updated_at,\r\n"
	                    + "\r\n"
	                    + "    c.[phase_one],\r\n"
	                    + "    c.[phase_two],\r\n"
	                    + "    c.[phase_three],\r\n"
	                    + "    c.[phase_four],\r\n"
	                    + "    c.[current_pending_at],\r\n"
	                    + "    u1.user_name AS pendingAt,\r\n"
	                    + "    u1.role_type AS role,u2.user_name as project_manager_fullname,u_req.user_name AS requested_by_fullname,\r\n"
	                    + "u_hop.user_name AS head_of_plant_fullname,\r\n"
	                    + "u_fin.user_name AS finance_fullname, \r\n"
	                    + "u_rd.user_name AS regional_director_fullname,\r\n"
	                    + "u_hp.user_name AS head_projects_fullname,\r\n"
	                    + "u_fc.user_name AS finance_controller_fullname,\r\n"
	                    + "u_bh.user_name AS business_head_fullname,\r\n"
	                    + "u_cfo.user_name AS cfo_fullname,\r\n"
	                    + "u_ceo.user_name AS ceo_fullname \r\n"
	                    + "\r\n"
	                    + "FROM [capexDB].[dbo].[capex_proposal] c\r\n"
	                    + "LEFT JOIN [dbo].[plant] p ON c.plant_code = p.plant_code\r\n"
	                    + "LEFT JOIN [dbo].[user_profile] u ON c.created_by = u.user_id\r\n"
	                    + "LEFT JOIN [dbo].[user_profile] u1 ON c.current_pending_at = u1.user_id\r\n"
	                    + "LEFT JOIN [dbo].[user_profile] u2 ON c.project_manager_name = u2.user_id\r\n"
	                    + "LEFT JOIN [dbo].[user_profile] u_req ON c.requested_by_name = u_req.user_id\r\n"
	                    + "LEFT JOIN [dbo].[user_profile] u_hop ON c.head_of_plant_name = u_hop.user_id\r\n"
	                    + "LEFT JOIN [dbo].[user_profile] u_fin ON c.finance_name = u_fin.user_id\r\n"
	                    + "LEFT JOIN [dbo].[user_profile] u_rd ON c.regional_director_name = u_rd.user_id\r\n"
	                    + "LEFT JOIN [dbo].[user_profile] u_hp ON c.head_projects_name = u_hp.user_id\r\n"
	                    + "LEFT JOIN [dbo].[user_profile] u_fc ON c.finance_controller_name = u_fc.user_id\r\n"
	                    + "LEFT JOIN [dbo].[user_profile] u_bh ON c.business_head_name = u_bh.user_id\r\n"
	                    + "LEFT JOIN [dbo].[user_profile] u_cfo ON c.cfo_name = u_cfo.user_id\r\n"
	                    + "LEFT JOIN [dbo].[user_profile] u_ceo ON c.ceo_name = u_ceo.user_id"
	                    + "\r\n"
	                    + "WHERE 1 = 1\r\n"
	                    + "    -- AND c.id = @someId\r\n"
	                    + "    -- OR c.capex_number = @someNumber\r\n");
	            
	         
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCapex_number())) {
				query.append("  and c.[id] = ? ");
				arrSize++;
			}
			   query.append(" ORDER BY created_at ASC");
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCapex_number())) {
				pValues[i++] = obj.getCapex_number();
			}
			obj = (CapexProposal)jdbcTemplate.queryForObject(query.toString(), pValues, new BeanPropertyRowMapper<CapexProposal>(CapexProposal.class));
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return obj;
	}


	@Override
	public int updateCapex(CapexProposal c) throws Exception {
		
		 
		String sql = "UPDATE capex_proposal SET " +

		"asset_description=:asset_description, " +

		"basic_cost=:basic_cost, " +
		"gst_rate=:gst_rate, " +
		"gst_amount=:gst_amount, " +
		"total_cost=:total_cost, " +

		"roi_text=:roi_text, " +
		"roi_file_name=:roi_file_name, " +
		"roi_file_path=:roi_file_path, " +

		"timeline_text=:timeline_text, " +
		"timeline_file_name=:timeline_file_name, " +
		"timeline_file_path=:timeline_file_path, " +

		"reason_text=:reason_text, " +
		"reason_file_name=:reason_file_name, " +
		"reason_file_path=:reason_file_path, " +

		"prepared_by_name=:prepared_by_name, " +
		"prepared_by_designation=:prepared_by_designation, " +
		"prepared_by_date = CASE WHEN (:prepared_by_name IS NOT NULL AND prepared_by_date IS NULL) OR (:prepared_by_name IS NULL AND prepared_by_date IS NOT NULL) THEN GETDATE() ELSE prepared_by_date END, " +
		"prepared_by_signature_path=:prepared_by_signature_path, " +

		"project_manager_name = CASE " +
		"    WHEN :project_manager_name IS NULL THEN project_manager_name " +
		"    WHEN project_manager_date IS NULL THEN :project_manager_name " +
		"    WHEN project_manager_date IS NOT NULL AND project_manager_name <> :project_manager_name THEN :project_manager_name " +
		"    ELSE project_manager_name " +
		"END, " +

		"project_manager_designation = :project_manager_designation, " +

		"project_manager_date = CASE " +
		"    WHEN :project_manager_name IS NULL THEN project_manager_date " +
		"    WHEN project_manager_name IS NULL AND :project_manager_name IS NOT NULL THEN GETDATE() " +
		"    WHEN project_manager_name IS NOT NULL AND project_manager_date IS NULL AND :project_manager_name IS NOT NULL THEN GETDATE() " +
		"    WHEN project_manager_name IS NOT NULL AND project_manager_date IS NOT NULL AND project_manager_name <> :project_manager_name THEN NULL " +
		"    ELSE project_manager_date " +
		"END, " +

		"current_pending_at = CASE " +
		"    WHEN :status = 'Approved' THEN current_pending_at " +
		"    WHEN :current_pending_at IS NULL THEN current_pending_at " +
		"    ELSE :current_pending_at " +
		"END, " +

		"project_manager_signature_path = :project_manager_signature_path, " +

		"head_of_plant_name = CASE " +
		"    WHEN :head_of_plant_name IS NULL THEN head_of_plant_name " +
		"    WHEN head_of_plant_date IS NOT NULL THEN head_of_plant_name " +
		"    ELSE :head_of_plant_name " +
		"END, " +

		"head_of_plant_designation = CASE " +
		"    WHEN :head_of_plant_name IS NULL THEN head_of_plant_designation " +
		"    ELSE :head_of_plant_designation " +
		"END, " +

"head_of_plant_date = CASE " +
"    WHEN :head_of_plant_name IS NULL THEN head_of_plant_date " +  
"    WHEN head_of_plant_date IS NULL AND :head_of_plant_name IS NOT NULL THEN GETDATE() " +
"    ELSE head_of_plant_date " +
"END, " +

		"head_of_plant_signature_path = :head_of_plant_signature_path, " +

		"requested_by_name = CASE " +
		"    WHEN :requested_by_name IS NULL THEN requested_by_name " +
		"    ELSE :requested_by_name " +
		"END, " +

		"requested_by_designation = :requested_by_designation, " +

		"requested_by_date = CASE " +
		"    WHEN :requested_by_name IS NULL THEN requested_by_date " +
		"    WHEN requested_by_date IS NULL AND :requested_by_name IS NOT NULL THEN GETDATE() " +
		"    ELSE requested_by_date " +
		"END, " +

		"requested_by_signature_path = :requested_by_signature_path, " +

		/* ✅ FINANCE RESET LOGIC WHEN REJECTED */
		"finance_department = CASE " +
		"    WHEN :finance_status = 'Rejected' THEN NULL " +
		"    WHEN :finance_department IS NULL THEN finance_department " +
		"    ELSE :finance_department " +
		"END, " +

		"finance_category = CASE " +
		"    WHEN :finance_status = 'Rejected' THEN NULL " +
		"    WHEN :finance_category IS NULL THEN finance_category " +
		"    ELSE :finance_category " +
		"END, " +

		"total_budget = CASE " +
		"    WHEN :finance_status = 'Rejected' THEN NULL " +
		"    WHEN :total_budget IS NULL THEN total_budget " +
		"    ELSE :total_budget " +
		"END, " +

		"proposed_price = CASE " +
		"    WHEN :finance_status = 'Rejected' THEN NULL " +
		"    WHEN :proposed_price IS NULL THEN proposed_price " +
		"    ELSE :proposed_price " +
		"END, " +

		"available_balance = CASE " +
		"    WHEN :finance_status = 'Rejected' THEN NULL " +
		"    WHEN :available_balance IS NULL THEN available_balance " +
		"    ELSE :available_balance " +
		"END, " +

		"finance_status = :finance_status, " +

		"finance_name = CASE " +
		"    WHEN :finance_status = 'Rejected' THEN NULL " +
		"    WHEN :finance_status = 'On Hold' THEN finance_name " +
		"    WHEN :finance_name IS NULL THEN finance_name " +
		"    ELSE :finance_name " +
		"END, " +

		"finance_designation = CASE " +
		"    WHEN :finance_status = 'Rejected' THEN NULL " +
		"    WHEN :finance_designation IS NULL THEN finance_designation " +
		"    ELSE :finance_designation " +
		"END, " +

		"finance_date = CASE " +
		"    WHEN :finance_status = 'Rejected' THEN NULL " +
		"    WHEN :finance_status = 'On Hold' THEN finance_date " +
		"    WHEN :finance_name IS NULL THEN finance_date " +
		"    WHEN finance_date IS NULL AND :finance_name IS NOT NULL THEN GETDATE() " +
		"    ELSE finance_date " +
		"END, " +

		"finance_comments = CASE " +
		"    WHEN :finance_status = 'Rejected' THEN NULL " +
		"    WHEN :finance_comments IS NULL THEN finance_comments " +
		"    ELSE :finance_comments " +
		"END, " +

		"remarks = :remarks, " +

		/* (remaining approvals unchanged) */

		"regional_director_name = CASE WHEN :regional_director_name IS NULL THEN regional_director_name WHEN regional_director_date IS NOT NULL THEN regional_director_name ELSE :regional_director_name END, " +
		"regional_director_date = CASE WHEN :regional_director_name IS NULL THEN regional_director_date WHEN regional_director_date IS NULL AND :regional_director_name IS NOT NULL THEN GETDATE() ELSE regional_director_date END, " +
		"regional_director_comment = CASE WHEN :regional_director_name IS NULL THEN regional_director_comment ELSE :regional_director_comment END, " +

		"finance_controller_name = CASE WHEN :finance_controller_name IS NULL THEN finance_controller_name WHEN finance_controller_date IS NOT NULL THEN finance_controller_name ELSE :finance_controller_name END, " +
		"finance_controller_date = CASE WHEN :finance_controller_name IS NULL THEN finance_controller_date WHEN finance_controller_date IS NULL AND :finance_controller_name IS NOT NULL THEN GETDATE() ELSE finance_controller_date END, " +
		"finance_controller_comment = CASE WHEN :finance_controller_name IS NULL THEN finance_controller_comment ELSE :finance_controller_comment END, " +

		"head_projects_name = CASE WHEN :head_projects_name IS NULL THEN head_projects_name WHEN head_projects_date IS NOT NULL THEN head_projects_name ELSE :head_projects_name END, " +
		"head_projects_date = CASE WHEN :head_projects_name IS NULL THEN head_projects_date WHEN head_projects_date IS NULL AND :head_projects_name IS NOT NULL THEN GETDATE() ELSE head_projects_date END, " +
		"head_projects_comment = CASE WHEN :head_projects_name IS NULL THEN head_projects_comment ELSE :head_projects_comment END, " +

		"business_head_name = CASE WHEN :business_head_name IS NULL THEN business_head_name WHEN business_head_date IS NOT NULL THEN business_head_name ELSE :business_head_name END, " +
		"business_head_date = CASE WHEN :business_head_name IS NULL THEN business_head_date WHEN business_head_date IS NULL AND :business_head_name IS NOT NULL THEN GETDATE() ELSE business_head_date END, " +
		"business_head_comment = CASE WHEN :business_head_name IS NULL THEN business_head_comment ELSE :business_head_comment END, " +

		"cfo_name = CASE WHEN :cfo_name IS NULL THEN cfo_name WHEN cfo_date IS NOT NULL THEN cfo_name ELSE :cfo_name END, " +
		"cfo_date = CASE WHEN :cfo_name IS NULL THEN cfo_date WHEN cfo_date IS NULL AND :cfo_name IS NOT NULL THEN GETDATE() ELSE cfo_date END, " +
		"cfo_comment = CASE WHEN :cfo_name IS NULL THEN cfo_comment ELSE :cfo_comment END, " +

		"ceo_name = CASE WHEN :ceo_name IS NULL THEN ceo_name WHEN ceo_date IS NOT NULL THEN ceo_name ELSE :ceo_name END, " +
		"ceo_date = CASE WHEN :ceo_name IS NULL THEN ceo_date WHEN ceo_date IS NULL AND :ceo_name IS NOT NULL THEN GETDATE() ELSE ceo_date END, " +
		"ceo_comment = CASE WHEN :ceo_name IS NULL THEN ceo_comment ELSE :ceo_comment END, " +

		"status = :status, " +
		"phase_one = :phase_one, " +
		"phase_two = :phase_two, " +
		"phase_three = :phase_three " +

		"WHERE id = :id";
		
		
		 if (!StringUtils.isEmpty(c.getProposed_price())) {
			 
			  String updateBudgetSql = "UPDATE plant " +
	                  "SET total_available_budget_fy = ? " +
	                  "WHERE plant_code = ?";
	
	          jdbcTemplate.update(updateBudgetSql,
	                  c.getAvailable_balance(),   // amount to deduct
	                  c.getPlant_code()   // which plant
	          );
		 }
          
		 if (!StringUtils.isEmpty(c.getProposed_price()) ||!StringUtils.isEmpty(c.getTotal_cost())  ) {
			 
			 Double price = new BigDecimal(
				        (c.getProposed_price() != null && !c.getProposed_price().trim().isEmpty()) 
				            ? c.getProposed_price().trim() 
				            : ((c.getTotal_cost() != null && !c.getTotal_cost().trim().isEmpty()) 
				                ? c.getTotal_cost().trim() 
				                : "0")
				    ).divide(BigDecimal.valueOf(100000), 4, BigDecimal.ROUND_HALF_UP)
				     .doubleValue();
			c.setLakhs(price.toString());
			String finalApprover = getFinalApprover(c);
			finalApprover = toFirstUpper(finalApprover);

			boolean isApproved = false;

			if ("finance_controller_name".equalsIgnoreCase(finalApprover)) {
			    isApproved = c.getFinance_controller_name() != null && !c.getFinance_controller_name().trim().isEmpty();

			} else if ("regional_director_name".equalsIgnoreCase(finalApprover)) {
			    isApproved = c.getRegional_director_name() != null && !c.getRegional_director_name().trim().isEmpty();

			}else if ("finance_name".equalsIgnoreCase(finalApprover)) {
			    isApproved = c.getFinance_name() != null && !c.getFinance_name().trim().isEmpty();

			} else if ("business_head_name".equalsIgnoreCase(finalApprover)) {
			    isApproved = c.getBusiness_head_name() != null && !c.getBusiness_head_name().trim().isEmpty();

			} else if ("head_projects_name".equalsIgnoreCase(finalApprover)) {
			    isApproved = c.getHead_projects_name() != null && !c.getHead_projects_name().trim().isEmpty();

			} else if ("ceo_name".equalsIgnoreCase(finalApprover)) {
			    isApproved = c.getCeo_name() != null && !c.getCeo_name().trim().isEmpty();

			} else if ("cfo_name".equalsIgnoreCase(finalApprover)) {
			    isApproved = c.getCfo_name() != null && !c.getCfo_name().trim().isEmpty();
			}
			if (isApproved) {
			    c.setStatus("Approved");
			} else {
			    c.setStatus("In Progress");
			}
		 }
	    MapSqlParameterSource params = new MapSqlParameterSource()

	            .addValue("finance_controller_name", c.getFinance_controller_name())
	            .addValue("finance_controller_date", c.getFinance_controller_date())
	            .addValue("finance_controller_comment", c.getFinance_controller_comment())
	            
	            .addValue("status", c.getStatus())
	            
	            .addValue("capex_title", c.getCapex_title())
	            .addValue("department", c.getDepartment())
	            .addValue("business_unit", c.getBusiness_unit())
	            .addValue("plant_code", c.getPlant_code())
	            .addValue("location", c.getLocation())

	            .addValue("asset_description", c.getAsset_description())
	            .addValue("basic_cost", c.getBasic_cost())
	            .addValue("gst_rate", c.getGst_rate())
	            .addValue("gst_amount", c.getGst_amount())
	            .addValue("total_cost", c.getTotal_cost())

	            .addValue("roi_text", c.getRoi_text())
	            .addValue("roi_file_name", c.getRoi_file_name())
	            .addValue("roi_file_path", c.getRoi_file_path())

	            .addValue("timeline_text", c.getTimeline_text())
	            .addValue("timeline_file_name", c.getTimeline_file_name())
	            .addValue("timeline_file_path", c.getTimeline_file_path())

	            .addValue("reason_text", c.getReason_text())
	            .addValue("reason_file_name", c.getReason_file_name())
	            .addValue("reason_file_path", c.getReason_file_path())

	            .addValue("prepared_by_name", c.getPrepared_by_name())
	            .addValue("prepared_by_designation", c.getPrepared_by_designation())
	            .addValue("prepared_by_signature_path", c.getPrepared_by_signature_path())

	            .addValue("project_manager_name", c.getProject_manager_name())
	            .addValue("project_manager_designation", c.getProject_manager_designation())
	            .addValue("project_manager_signature_path", c.getProject_manager_signature_path())

	            .addValue("requested_by_name", c.getRequested_by_name())
	            .addValue("requested_by_designation", c.getRequested_by_designation())
	            .addValue("requested_by_signature_path", c.getRequested_by_signature_path())

	            .addValue("regional_director_name", c.getRegional_director_name())
	            .addValue("regional_director_comment", c.getRegional_director_comment())

	            .addValue("head_of_plant_name", c.getHead_of_plant_name())
	            .addValue("head_of_plant_designation", c.getHead_of_plant_designation())
	            .addValue("head_of_plant_signature_path", c.getHead_of_plant_signature_path())
	            .addValue("remarks", c.getRemarks())
	          
	            .addValue("phase_one", c.getPhase_one())
	            .addValue("phase_two", c.getPhase_two())
	            .addValue("phase_three", c.getPhase_three())

	            .addValue("finance_department", c.getFinance_department())
	            .addValue("finance_category", c.getFinance_category())
	            .addValue("total_budget", c.getTotal_budget())
	            .addValue("proposed_price", c.getProposed_price())
	           
	            
	            
	            .addValue("available_balance", c.getAvailable_balance())
	            .addValue("finance_status", c.getFinance_status())

	            .addValue("finance_name", c.getFinance_name())
	            .addValue("finance_designation", c.getFinance_designation())
	            .addValue("finance_comments", c.getFinance_comments())

	            .addValue("head_projects_name", c.getHead_projects_name())
	            .addValue("head_projects_comment", c.getHead_projects_comment())

	            .addValue("business_head_name", c.getBusiness_head_name())
	            .addValue("business_head_comment", c.getBusiness_head_comment())

	            .addValue("cfo_name", c.getCfo_name())
	            .addValue("cfo_comment", c.getCfo_comment())

	            .addValue("ceo_name", c.getCeo_name())
	            .addValue("ceo_comment", c.getCeo_comment())

	            .addValue("current_pending_at", c.getCurrent_pending_at())
	            .addValue("id", c.getId());

	    NamedParameterJdbcTemplate namedParameterJdbcTemplate =
	            new NamedParameterJdbcTemplate(jdbcTemplate);

	    return namedParameterJdbcTemplate.update(sql, params);
	}
	  public static String toFirstUpper(String input) {
	        if (input == null || input.isEmpty()) {
	            return input;
	        }
	        return input.substring(0, 1).toUpperCase() + input.substring(1).toLowerCase();
	    }
	public String getFinalApprover(CapexProposal obj) throws Exception {

	    // =========================
	    // 🔹 VALIDATIONS
	    // =========================
	    if (obj.getDepartment() == null || obj.getDepartment().trim().isEmpty()) {
	        throw new IllegalArgumentException("Department is required");
	    }

	    String lakhsStr = obj.getLakhs();
	    if (lakhsStr == null || lakhsStr.trim().isEmpty()) {
	        throw new IllegalArgumentException("Amount in lakhs is required");
	    }

	    BigDecimal amount;
	    try {
	        amount = new BigDecimal(lakhsStr.trim());
	    } catch (NumberFormatException e) {
	        throw new IllegalArgumentException("Invalid amount format: " + lakhsStr);
	    }

	    if (amount.compareTo(BigDecimal.ZERO) < 0) {
	        throw new IllegalArgumentException("Amount in lakhs must be non-negative");
	    }

	    try {
	        // =========================
	        // 🔹 DEPARTMENT LOGIC
	        // =========================
	        String department = ("OPS".equalsIgnoreCase(obj.getDepartment()) ||
	                             "GN".equalsIgnoreCase(obj.getDepartment()))
	                             ? obj.getDepartment()
	                             : "DEFAULT";

	        // =========================
	        // 🔹 YOUR EXACT SQL QUERY
	        // =========================
	        String sql =
	                "SELECT final_approver " +
	                "FROM ( " +
	                "   SELECT *, ROW_NUMBER() OVER (ORDER BY min_lakhs DESC) AS rn " +
	                "   FROM [capexDB].[dbo].[capex_approval_rules] " +
	                "   WHERE department = ? " +
	                "   AND (min_lakhs <= ? OR (? > 50 AND min_lakhs = 50)) " +
	                ") t " +
	                "WHERE rn = 1";

	        // =========================
	        // 🔹 EXECUTE QUERY
	        // =========================
	        return jdbcTemplate.queryForObject(
	                sql,
	                new Object[]{department, amount, amount},
	                String.class
	        );

	    } catch (Exception ex) {
	        throw new Exception("Error fetching final approver: " + ex.getMessage(), ex);
	    }
	}

	@Override
	public List<CapexProposal> getPlantHead(String plantCode, String department) throws Exception {

	    List<CapexProposal> resultList = new ArrayList<>();

	    try {

	        StringBuilder sql = new StringBuilder();

	        sql.append("SELECT ")
	           .append("e.sbu, ")
	           .append("e.plant, ")
	           .append("e.department, ")
	           .append("e.capex_requestor_name, ")
	           .append("e.capex_project_manager_name, ")
	           .append("e.site_head_name, ")
	           .append("e.site_head_employee_id, ")
	           .append("e.site_head_email, ")
	           .append("e.site_finance_head_name, ")
	           .append("e.site_finance_head_designation, ")
	           .append("e.site_finance_head_employee_id, ")
	           .append("e.site_finance_head_email, ")
	           .append("e.finance_controller_name, ")
	           .append("e.finance_controller_employee_id, ")
	           .append("e.finance_controller_email, ")
	           .append("e.regional_director_name, ")
	           .append("e.regional_director_employee_id, ")
	           .append("e.regional_director_email, ")
	           .append("e.bu_head_name, ")
	           .append("e.bu_head_employee_id, ")
	           .append("e.bu_head_email, ")
	           .append("e.project_head_name, ")
	           .append("e.project_head_employee_id, ")
	           .append("e.project_head_email, ")
	           .append("e.cfo_name, ")
	           .append("e.cfo_employee_id, ")
	           .append("e.cfo_email, ")
	           .append("e.ceo_name, ")
	           .append("e.ceo_employee_id, ")
	           .append("e.ceo_email, ")
	           .append("e.created_at ")
	           .append("FROM capexDB.dbo.employee_master_data e ")
	           .append("LEFT JOIN department d ")
	           .append("ON e.department = d.department_name ")
	           .append("WHERE 1=1 ");

	        List<Object> paramList = new ArrayList<>();


	        // Plant filter
	        if(plantCode != null && !plantCode.trim().isEmpty())
	        {
	            sql.append(" AND e.plant = ? ");
	            paramList.add(plantCode);
	        }


	        // Department filter
	        if(department != null && !department.trim().isEmpty())
	        {
	            sql.append(" AND e.department = ? ");
	            paramList.add(department);
	        }


	        sql.append(" ORDER BY e.created_at ASC");


	        // Debug logs
	        System.out.println("SQL = "+sql);
	        System.out.println("Params = "+paramList);


	        resultList = jdbcTemplate.query(
	                sql.toString(),
	                paramList.toArray(),
	                new BeanPropertyRowMapper<>(CapexProposal.class)
	        );


	    }
	    catch(Exception ex)
	    {
	        ex.printStackTrace();
	        throw new Exception("Error fetching Plant Head Data : "+ex.getMessage());
	    }

	    return resultList;
	}

	@Override
	public List<CapexProposal> getApprovalStatus(CapexProposal obj) throws Exception {

	    if (obj.getDepartment() == null || obj.getDepartment().trim().isEmpty()) {
	        throw new IllegalArgumentException("Department is required");
	    }

	    String lakhsStr = obj.getLakhs();
	    if (lakhsStr == null || lakhsStr.trim().isEmpty()) {
	        throw new IllegalArgumentException("Amount in lakhs is required");
	    }

	    BigDecimal amount;
	    try {
	        amount = new BigDecimal(lakhsStr.trim());
	    } catch (NumberFormatException e) {
	        throw new IllegalArgumentException("Invalid amount format: " + lakhsStr);
	    }

	    if (amount.compareTo(BigDecimal.ZERO) < 0) {
	        throw new IllegalArgumentException("Amount in lakhs must be non-negative");
	    }

	    List<CapexProposal> result = new ArrayList<>();

	    try {
	        StringBuilder sql = new StringBuilder();
	        List<Object> paramList = new ArrayList<>();

	        sql.append("SELECT id, department, min_lakhs, max_lakhs, ");
	        sql.append("final_approver, previous_required_field ");
	        sql.append("FROM [capexDB].[dbo].[capex_approval_rules] ");
	        sql.append("WHERE department = ? ");

	        if ("OPS".equalsIgnoreCase(obj.getDepartment()) || "GN".equalsIgnoreCase(obj.getDepartment())) {
	            paramList.add(obj.getDepartment());
	        } else {
	            paramList.add("DEFAULT");
	        }

	        sql.append("AND (min_lakhs <= ? OR (? > 50 AND min_lakhs = 50)) ");
	        paramList.add(amount);
	        paramList.add(amount);

	        sql.append("ORDER BY min_lakhs ASC");

	        result = jdbcTemplate.query(
	                sql.toString(),
	                paramList.toArray(),
	                new BeanPropertyRowMapper<>(CapexProposal.class)
	        );

	        // =========================
	        // 🔥 ADD STATUS LOGIC
	        // =========================
	        if (result != null && !result.isEmpty()) {

	            for (CapexProposal row : result) {
	                row.setStatus_previous("In Progress");
	                row.setStatus_final("In Progress");
	            }

	            // ✅ LAST ROW → Approved
	            result.get(result.size() - 1).setStatus_final("Approved");
	        }

	    } catch (Exception ex) {
	        throw new Exception("Error fetching approval rules: " + ex.getMessage(), ex);
	    }

	    return result;
	}

	 @Override
	    public void updateStatus(String id, String status) {
	        String sql = "UPDATE capex_proposal SET status = ? , updated_at = GETDATE() WHERE id = ?";
	        jdbcTemplate.update(sql, status, id);
	    }

	    @Override
	    public void updateCurrentPending(String id, String pendingAt) {
	        String sql = "UPDATE capex_proposal SET current_pending_at = ?, updated_at = GETDATE()   WHERE id = ?";
	        jdbcTemplate.update(sql, pendingAt, id);
	    }

	    @Override
	    public void saveRejectRemarks(String id, String remarks) {
	        String sql = "UPDATE capex_proposal SET reject_remarks = ?, updated_at = GETDATE()  WHERE id = ?";
	        jdbcTemplate.update(sql, remarks, id);
	    }

	    @Override
	    public void saveSendBackRemarks(String id, String remarks) {
	        String sql = "UPDATE capex_proposal SET send_back_remarks = ?, updated_at = GETDATE()  WHERE id = ?";
	        jdbcTemplate.update(sql, remarks, id);
	    }

	    @Override
	    public void clearApproval(String field, String id) {

	        // 🔥 Convert dynamically
	        String dateColumn = field.replace("_name", "_date");
	        String commentColumn = field.replace("_name", "_comment");
	        if("finance_name".equalsIgnoreCase(field)) {
	        	commentColumn = field.replace("_name", "_comments");
	        }

	        String sql = "UPDATE capex_proposal SET " + dateColumn + " = NULL, " + field + " = NULL, updated_at = GETDATE() , " + commentColumn + " = NULL WHERE id = ?";

	        jdbcTemplate.update(sql, id);
	    }
}

