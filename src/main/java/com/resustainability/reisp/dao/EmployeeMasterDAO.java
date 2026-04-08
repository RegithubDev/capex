package com.resustainability.reisp.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import com.resustainability.reisp.model.EmployeeMaster;
import com.resustainability.reisp.model.ExcelChange;
public interface EmployeeMasterDAO {
    
    List<EmployeeMaster> getAllEmployees();
    
    EmployeeMaster getEmployeeById(Long id);
    
    int updateEmployee(EmployeeMaster employee);
    
    int updateEmployeeWithQuery(EmployeeMaster employee);
    
    List<EmployeeMaster> getEmployeesForExcel();

}