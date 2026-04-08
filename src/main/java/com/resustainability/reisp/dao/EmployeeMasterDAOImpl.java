package com.resustainability.reisp.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.resustainability.reisp.model.EmployeeMaster;
import com.resustainability.reisp.model.ExcelChange;
import com.resustainability.reisp.dao.EmployeeMasterDAO;
import com.resustainability.reisp.model.ApprovalRequest;
import com.resustainability.reisp.model.ChangeDetail;

@Repository
public class EmployeeMasterDAOImpl implements EmployeeMasterDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @Override
    public List<EmployeeMaster> getAllEmployees() {
        String query = "SELECT [id], [sbu], [plant], [department], [capex_requestor_name], " +
                       "[capex_project_manager_name], [site_head_name], [site_head_employee_id], " +
                       "[site_head_email], [site_finance_head_name], [site_finance_head_designation], " +
                       "[site_finance_head_employee_id], [site_finance_head_email], " +
                       "[finance_controller_name], [finance_controller_employee_id], " +
                       "[finance_controller_email], [regional_director_name], " +
                       "[regional_director_employee_id], [regional_director_email], " +
                       "[bu_head_name], [bu_head_employee_id], [bu_head_email], " +
                       "[project_head_name], [project_head_employee_id], [project_head_email], " +
                       "[cfo_name], [cfo_employee_id], [cfo_email], [ceo_name], " +
                       "[ceo_employee_id], [ceo_email], [created_at] " +
                       "FROM [capexDB].[dbo].[employee_master_data] ORDER BY [id]";
        
        return jdbcTemplate.query(query, new EmployeeMasterRowMapper());
    }
    
    @Override
    public EmployeeMaster getEmployeeById(Long id) {

        String query = "SELECT [id], [sbu], [plant], [department], [capex_requestor_name], " +
                "[capex_project_manager_name], [site_head_name], [site_head_employee_id], " +
                "[site_head_email], [site_finance_head_name], [site_finance_head_designation], " +
                "[site_finance_head_employee_id], [site_finance_head_email], " +
                "[finance_controller_name], [finance_controller_employee_id], " +
                "[finance_controller_email], [regional_director_name], " +
                "[regional_director_employee_id], [regional_director_email], " +
                "[bu_head_name], [bu_head_employee_id], [bu_head_email], " +
                "[project_head_name], [project_head_employee_id], [project_head_email], " +
                "[cfo_name], [cfo_employee_id], [cfo_email], [ceo_name], " +
                "[ceo_employee_id], [ceo_email], [created_at] " +
                "FROM [capexDB].[dbo].[employee_master_data] WHERE [id] = ?";

        List<EmployeeMaster> list = jdbcTemplate.query(
                query,
                new Object[]{id},
                new EmployeeMasterRowMapper()
        );

        return list.isEmpty() ? null : list.get(0);
    }
    
    @Override
    public int updateEmployee(EmployeeMaster employee) {

        String query =
            "MERGE [capexDB].[dbo].[employee_master_data] AS target " +
            "USING (SELECT ? AS id) AS source " +
            "ON target.id = source.id " +

            "WHEN MATCHED THEN UPDATE SET " +
            "[sbu] = ?, [plant] = ?, [department] = ?, " +
            "[capex_requestor_name] = ?, [capex_project_manager_name] = ?, " +
            "[site_head_name] = ?, [site_head_employee_id] = ?, [site_head_email] = ?, " +
            "[site_finance_head_name] = ?, [site_finance_head_designation] = ?, " +
            "[site_finance_head_employee_id] = ?, [site_finance_head_email] = ?, " +
            "[finance_controller_name] = ?, [finance_controller_employee_id] = ?, " +
            "[finance_controller_email] = ?, [regional_director_name] = ?, " +
            "[regional_director_employee_id] = ?, [regional_director_email] = ?, " +
            "[bu_head_name] = ?, [bu_head_employee_id] = ?, [bu_head_email] = ?, " +
            "[project_head_name] = ?, [project_head_employee_id] = ?, [project_head_email] = ?, " +
            "[cfo_name] = ?, [cfo_employee_id] = ?, [cfo_email] = ?, " +
            "[ceo_name] = ?, [ceo_employee_id] = ?, [ceo_email] = ? " +

            "WHEN NOT MATCHED THEN INSERT (" +
            "[sbu], [plant], [department], " +
            "[capex_requestor_name], [capex_project_manager_name], " +
            "[site_head_name], [site_head_employee_id], [site_head_email], " +
            "[site_finance_head_name], [site_finance_head_designation], " +
            "[site_finance_head_employee_id], [site_finance_head_email], " +
            "[finance_controller_name], [finance_controller_employee_id], " +
            "[finance_controller_email], [regional_director_name], " +
            "[regional_director_employee_id], [regional_director_email], " +
            "[bu_head_name], [bu_head_employee_id], [bu_head_email], " +
            "[project_head_name], [project_head_employee_id], [project_head_email], " +
            "[cfo_name], [cfo_employee_id], [cfo_email], " +
            "[ceo_name], [ceo_employee_id], [ceo_email]) " +

            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

        return jdbcTemplate.update(query,
                // 🔥 SOURCE (id)
                employee.getId(),

                // 🔥 UPDATE VALUES
                employee.getSbu(),
                employee.getPlant(),
                employee.getDepartment(),
                employee.getCapexRequestorName(),
                employee.getCapexProjectManagerName(),
                employee.getSiteHeadName(),
                employee.getSiteHeadEmployeeId(),
                employee.getSiteHeadEmail(),
                employee.getSiteFinanceHeadName(),
                employee.getSiteFinanceHeadDesignation(),
                employee.getSiteFinanceHeadEmployeeId(),
                employee.getSiteFinanceHeadEmail(),
                employee.getFinanceControllerName(),
                employee.getFinanceControllerEmployeeId(),
                employee.getFinanceControllerEmail(),
                employee.getRegionalDirectorName(),
                employee.getRegionalDirectorEmployeeId(),
                employee.getRegionalDirectorEmail(),
                employee.getBuHeadName(),
                employee.getBuHeadEmployeeId(),
                employee.getBuHeadEmail(),
                employee.getProjectHeadName(),
                employee.getProjectHeadEmployeeId(),
                employee.getProjectHeadEmail(),
                employee.getCfoName(),
                employee.getCfoEmployeeId(),
                employee.getCfoEmail(),
                employee.getCeoName(),
                employee.getCeoEmployeeId(),
                employee.getCeoEmail(),

                // 🔥 INSERT VALUES (same order)
                employee.getSbu(),
                employee.getPlant(),
                employee.getDepartment(),
                employee.getCapexRequestorName(),
                employee.getCapexProjectManagerName(),
                employee.getSiteHeadName(),
                employee.getSiteHeadEmployeeId(),
                employee.getSiteHeadEmail(),
                employee.getSiteFinanceHeadName(),
                employee.getSiteFinanceHeadDesignation(),
                employee.getSiteFinanceHeadEmployeeId(),
                employee.getSiteFinanceHeadEmail(),
                employee.getFinanceControllerName(),
                employee.getFinanceControllerEmployeeId(),
                employee.getFinanceControllerEmail(),
                employee.getRegionalDirectorName(),
                employee.getRegionalDirectorEmployeeId(),
                employee.getRegionalDirectorEmail(),
                employee.getBuHeadName(),
                employee.getBuHeadEmployeeId(),
                employee.getBuHeadEmail(),
                employee.getProjectHeadName(),
                employee.getProjectHeadEmployeeId(),
                employee.getProjectHeadEmail(),
                employee.getCfoName(),
                employee.getCfoEmployeeId(),
                employee.getCfoEmail(),
                employee.getCeoName(),
                employee.getCeoEmployeeId(),
                employee.getCeoEmail()
        );
    }
    
    @Override
    public int updateEmployeeWithQuery(EmployeeMaster employee) {
        StringBuilder query = new StringBuilder("UPDATE [capexDB].[dbo].[employee_master_data] SET ");
        List<Object> params = new ArrayList<>();
        
        if (employee.getSbu() != null) {
            query.append("[sbu] = ?, ");
            params.add(employee.getSbu());
        }
        if (employee.getPlant() != null) {
            query.append("[plant] = ?, ");
            params.add(employee.getPlant());
        }
        if (employee.getDepartment() != null) {
            query.append("[department] = ?, ");
            params.add(employee.getDepartment());
        }
        if (employee.getCapexRequestorName() != null) {
            query.append("[capex_requestor_name] = ?, ");
            params.add(employee.getCapexRequestorName());
        }
        if (employee.getCapexProjectManagerName() != null) {
            query.append("[capex_project_manager_name] = ?, ");
            params.add(employee.getCapexProjectManagerName());
        }
        if (employee.getSiteHeadName() != null) {
            query.append("[site_head_name] = ?, ");
            params.add(employee.getSiteHeadName());
        }
        if (employee.getSiteHeadEmployeeId() != null) {
            query.append("[site_head_employee_id] = ?, ");
            params.add(employee.getSiteHeadEmployeeId());
        }
        if (employee.getSiteHeadEmail() != null) {
            query.append("[site_head_email] = ?, ");
            params.add(employee.getSiteHeadEmail());
        }
        if (employee.getSiteFinanceHeadName() != null) {
            query.append("[site_finance_head_name] = ?, ");
            params.add(employee.getSiteFinanceHeadName());
        }
        if (employee.getSiteFinanceHeadDesignation() != null) {
            query.append("[site_finance_head_designation] = ?, ");
            params.add(employee.getSiteFinanceHeadDesignation());
        }
        if (employee.getSiteFinanceHeadEmployeeId() != null) {
            query.append("[site_finance_head_employee_id] = ?, ");
            params.add(employee.getSiteFinanceHeadEmployeeId());
        }
        if (employee.getSiteFinanceHeadEmail() != null) {
            query.append("[site_finance_head_email] = ?, ");
            params.add(employee.getSiteFinanceHeadEmail());
        }
        if (employee.getFinanceControllerName() != null) {
            query.append("[finance_controller_name] = ?, ");
            params.add(employee.getFinanceControllerName());
        }
        if (employee.getFinanceControllerEmployeeId() != null) {
            query.append("[finance_controller_employee_id] = ?, ");
            params.add(employee.getFinanceControllerEmployeeId());
        }
        if (employee.getFinanceControllerEmail() != null) {
            query.append("[finance_controller_email] = ?, ");
            params.add(employee.getFinanceControllerEmail());
        }
        if (employee.getRegionalDirectorName() != null) {
            query.append("[regional_director_name] = ?, ");
            params.add(employee.getRegionalDirectorName());
        }
        if (employee.getRegionalDirectorEmployeeId() != null) {
            query.append("[regional_director_employee_id] = ?, ");
            params.add(employee.getRegionalDirectorEmployeeId());
        }
        if (employee.getRegionalDirectorEmail() != null) {
            query.append("[regional_director_email] = ?, ");
            params.add(employee.getRegionalDirectorEmail());
        }
        if (employee.getBuHeadName() != null) {
            query.append("[bu_head_name] = ?, ");
            params.add(employee.getBuHeadName());
        }
        if (employee.getBuHeadEmployeeId() != null) {
            query.append("[bu_head_employee_id] = ?, ");
            params.add(employee.getBuHeadEmployeeId());
        }
        if (employee.getBuHeadEmail() != null) {
            query.append("[bu_head_email] = ?, ");
            params.add(employee.getBuHeadEmail());
        }
        if (employee.getProjectHeadName() != null) {
            query.append("[project_head_name] = ?, ");
            params.add(employee.getProjectHeadName());
        }
        if (employee.getProjectHeadEmployeeId() != null) {
            query.append("[project_head_employee_id] = ?, ");
            params.add(employee.getProjectHeadEmployeeId());
        }
        if (employee.getProjectHeadEmail() != null) {
            query.append("[project_head_email] = ?, ");
            params.add(employee.getProjectHeadEmail());
        }
        if (employee.getCfoName() != null) {
            query.append("[cfo_name] = ?, ");
            params.add(employee.getCfoName());
        }
        if (employee.getCfoEmployeeId() != null) {
            query.append("[cfo_employee_id] = ?, ");
            params.add(employee.getCfoEmployeeId());
        }
        if (employee.getCfoEmail() != null) {
            query.append("[cfo_email] = ?, ");
            params.add(employee.getCfoEmail());
        }
        if (employee.getCeoName() != null) {
            query.append("[ceo_name] = ?, ");
            params.add(employee.getCeoName());
        }
        if (employee.getCeoEmployeeId() != null) {
            query.append("[ceo_employee_id] = ?, ");
            params.add(employee.getCeoEmployeeId());
        }
        if (employee.getCeoEmail() != null) {
            query.append("[ceo_email] = ?, ");
            params.add(employee.getCeoEmail());
        }
        
        // Remove trailing comma and space
        String queryStr = query.toString();
        queryStr = queryStr.substring(0, queryStr.length() - 2);
        queryStr = queryStr + " WHERE [id] = ?";
        params.add(employee.getId());
        
        return jdbcTemplate.update(queryStr, params.toArray());
    }
    
    @Override
    public List<EmployeeMaster> getEmployeesForExcel() {
        String query = "SELECT [id], [sbu], [plant], [department], [capex_requestor_name], " +
                       "[capex_project_manager_name], [site_head_name], [site_head_employee_id], " +
                       "[site_head_email], [site_finance_head_name], [site_finance_head_designation], " +
                       "[site_finance_head_employee_id], [site_finance_head_email], " +
                       "[finance_controller_name], [finance_controller_employee_id], " +
                       "[finance_controller_email], [regional_director_name], " +
                       "[regional_director_employee_id], [regional_director_email], " +
                       "[bu_head_name], [bu_head_employee_id], [bu_head_email], " +
                       "[project_head_name], [project_head_employee_id], [project_head_email], " +
                       "[cfo_name], [cfo_employee_id], [cfo_email], [ceo_name], " +
                       "[ceo_employee_id], [ceo_email], [created_at] " +
                       "FROM [capexDB].[dbo].[employee_master_data] ORDER BY [id]";
        
        return jdbcTemplate.query(query, new EmployeeMasterRowMapper());
    }

}