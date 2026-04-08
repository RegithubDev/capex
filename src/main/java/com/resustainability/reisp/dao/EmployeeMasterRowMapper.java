package com.resustainability.reisp.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import com.resustainability.reisp.model.EmployeeMaster;

public class EmployeeMasterRowMapper implements RowMapper<EmployeeMaster> {
    
    @Override
    public EmployeeMaster mapRow(ResultSet rs, int rowNum) throws SQLException {
        EmployeeMaster emp = new EmployeeMaster();
        emp.setId(rs.getLong("id"));
        emp.setSbu(rs.getString("sbu"));
        emp.setPlant(rs.getString("plant"));
        emp.setDepartment(rs.getString("department"));
        emp.setCapexRequestorName(rs.getString("capex_requestor_name"));
        emp.setCapexProjectManagerName(rs.getString("capex_project_manager_name"));
        emp.setSiteHeadName(rs.getString("site_head_name"));
        emp.setSiteHeadEmployeeId(rs.getString("site_head_employee_id"));
        emp.setSiteHeadEmail(rs.getString("site_head_email"));
        emp.setSiteFinanceHeadName(rs.getString("site_finance_head_name"));
        emp.setSiteFinanceHeadDesignation(rs.getString("site_finance_head_designation"));
        emp.setSiteFinanceHeadEmployeeId(rs.getString("site_finance_head_employee_id"));
        emp.setSiteFinanceHeadEmail(rs.getString("site_finance_head_email"));
        emp.setFinanceControllerName(rs.getString("finance_controller_name"));
        emp.setFinanceControllerEmployeeId(rs.getString("finance_controller_employee_id"));
        emp.setFinanceControllerEmail(rs.getString("finance_controller_email"));
        emp.setRegionalDirectorName(rs.getString("regional_director_name"));
        emp.setRegionalDirectorEmployeeId(rs.getString("regional_director_employee_id"));
        emp.setRegionalDirectorEmail(rs.getString("regional_director_email"));
        emp.setBuHeadName(rs.getString("bu_head_name"));
        emp.setBuHeadEmployeeId(rs.getString("bu_head_employee_id"));
        emp.setBuHeadEmail(rs.getString("bu_head_email"));
        emp.setProjectHeadName(rs.getString("project_head_name"));
        emp.setProjectHeadEmployeeId(rs.getString("project_head_employee_id"));
        emp.setProjectHeadEmail(rs.getString("project_head_email"));
        emp.setCfoName(rs.getString("cfo_name"));
        emp.setCfoEmployeeId(rs.getString("cfo_employee_id"));
        emp.setCfoEmail(rs.getString("cfo_email"));
        emp.setCeoName(rs.getString("ceo_name"));
        emp.setCeoEmployeeId(rs.getString("ceo_employee_id"));
        emp.setCeoEmail(rs.getString("ceo_email"));
        
        Timestamp timestamp = rs.getTimestamp("created_at");
    
        return emp;
    }
}