package com.resustainability.reisp.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.resustainability.reisp.model.EmployeeMaster;
import com.resustainability.reisp.model.ExcelChange;
import com.resustainability.reisp.dao.EmployeeMasterDAO;
import com.resustainability.reisp.model.ApprovalRequest;
import com.resustainability.reisp.model.ChangeDetail;
@Service
public class EmployeeMasterService {
    
    @Autowired
    private EmployeeMasterDAO employeeMasterDAO;
    
    public List<EmployeeMaster> getAllEmployees() {
        return employeeMasterDAO.getAllEmployees();
    }
    
    public List<ExcelChange> processExcelUpload(MultipartFile file) throws IOException {
        List<ExcelChange> changes = new ArrayList<>();
        Workbook workbook = new XSSFWorkbook(file.getInputStream());
        Sheet sheet = workbook.getSheetAt(0);
        
        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
            Row row = sheet.getRow(i);
            if (row == null) continue;
            
            Long id = (long) row.getCell(0).getNumericCellValue();
            EmployeeMaster existingEmployee = employeeMasterDAO.getEmployeeById(id);
            
            if (existingEmployee != null) {
                EmployeeMaster newEmployee = mapRowToEmployee(row);
                List<ChangeDetail> changeDetails = compareEmployees(existingEmployee, newEmployee);
                
                if (!changeDetails.isEmpty()) {
                    ExcelChange change = new ExcelChange();
                    change.setId(id);
                    change.setRowNumber(i + 1);
                    change.setChanges(changeDetails);
                    change.setNewData(newEmployee);
                    changes.add(change);
                }
            }
        }
        
        workbook.close();
        return changes;
    }
    
    private List<ChangeDetail> compareEmployees(EmployeeMaster existing, EmployeeMaster newEmp) {
        List<ChangeDetail> changes = new ArrayList<>();
        
        if (!isEqual(existing.getSbu(), newEmp.getSbu())) {
            changes.add(new ChangeDetail("SBU", existing.getSbu(), newEmp.getSbu()));
        }
        if (!isEqual(existing.getPlant(), newEmp.getPlant())) {
            changes.add(new ChangeDetail("Plant", existing.getPlant(), newEmp.getPlant()));
        }
        if (!isEqual(existing.getDepartment(), newEmp.getDepartment())) {
            changes.add(new ChangeDetail("Department", existing.getDepartment(), newEmp.getDepartment()));
        }
        if (!isEqual(existing.getCapexRequestorName(), newEmp.getCapexRequestorName())) {
            changes.add(new ChangeDetail("CAPEX Requestor Name", existing.getCapexRequestorName(), newEmp.getCapexRequestorName()));
        }
        if (!isEqual(existing.getCapexProjectManagerName(), newEmp.getCapexProjectManagerName())) {
            changes.add(new ChangeDetail("CAPEX Project Manager", existing.getCapexProjectManagerName(), newEmp.getCapexProjectManagerName()));
        }
        if (!isEqual(existing.getSiteHeadName(), newEmp.getSiteHeadName())) {
            changes.add(new ChangeDetail("Site Head", existing.getSiteHeadName(), newEmp.getSiteHeadName()));
        }
        if (!isEqual(existing.getSiteHeadEmployeeId(), newEmp.getSiteHeadEmployeeId())) {
            changes.add(new ChangeDetail("Site Head Employee ID", existing.getSiteHeadEmployeeId(), newEmp.getSiteHeadEmployeeId()));
        }
        if (!isEqual(existing.getSiteHeadEmail(), newEmp.getSiteHeadEmail())) {
            changes.add(new ChangeDetail("Site Head Email", existing.getSiteHeadEmail(), newEmp.getSiteHeadEmail()));
        }
        if (!isEqual(existing.getSiteFinanceHeadName(), newEmp.getSiteFinanceHeadName())) {
            changes.add(new ChangeDetail("Site Finance Head", existing.getSiteFinanceHeadName(), newEmp.getSiteFinanceHeadName()));
        }
        if (!isEqual(existing.getSiteFinanceHeadDesignation(), newEmp.getSiteFinanceHeadDesignation())) {
            changes.add(new ChangeDetail("Site Finance Head Designation", existing.getSiteFinanceHeadDesignation(), newEmp.getSiteFinanceHeadDesignation()));
        }
        if (!isEqual(existing.getSiteFinanceHeadEmployeeId(), newEmp.getSiteFinanceHeadEmployeeId())) {
            changes.add(new ChangeDetail("Site Finance Head Employee ID", existing.getSiteFinanceHeadEmployeeId(), newEmp.getSiteFinanceHeadEmployeeId()));
        }
        if (!isEqual(existing.getSiteFinanceHeadEmail(), newEmp.getSiteFinanceHeadEmail())) {
            changes.add(new ChangeDetail("Site Finance Head Email", existing.getSiteFinanceHeadEmail(), newEmp.getSiteFinanceHeadEmail()));
        }
        if (!isEqual(existing.getFinanceControllerName(), newEmp.getFinanceControllerName())) {
            changes.add(new ChangeDetail("Finance Controller", existing.getFinanceControllerName(), newEmp.getFinanceControllerName()));
        }
        if (!isEqual(existing.getFinanceControllerEmployeeId(), newEmp.getFinanceControllerEmployeeId())) {
            changes.add(new ChangeDetail("Finance Controller Employee ID", existing.getFinanceControllerEmployeeId(), newEmp.getFinanceControllerEmployeeId()));
        }
        if (!isEqual(existing.getFinanceControllerEmail(), newEmp.getFinanceControllerEmail())) {
            changes.add(new ChangeDetail("Finance Controller Email", existing.getFinanceControllerEmail(), newEmp.getFinanceControllerEmail()));
        }
        if (!isEqual(existing.getRegionalDirectorName(), newEmp.getRegionalDirectorName())) {
            changes.add(new ChangeDetail("Regional Director", existing.getRegionalDirectorName(), newEmp.getRegionalDirectorName()));
        }
        if (!isEqual(existing.getRegionalDirectorEmployeeId(), newEmp.getRegionalDirectorEmployeeId())) {
            changes.add(new ChangeDetail("Regional Director Employee ID", existing.getRegionalDirectorEmployeeId(), newEmp.getRegionalDirectorEmployeeId()));
        }
        if (!isEqual(existing.getRegionalDirectorEmail(), newEmp.getRegionalDirectorEmail())) {
            changes.add(new ChangeDetail("Regional Director Email", existing.getRegionalDirectorEmail(), newEmp.getRegionalDirectorEmail()));
        }
        if (!isEqual(existing.getBuHeadName(), newEmp.getBuHeadName())) {
            changes.add(new ChangeDetail("BU Head", existing.getBuHeadName(), newEmp.getBuHeadName()));
        }
        if (!isEqual(existing.getBuHeadEmployeeId(), newEmp.getBuHeadEmployeeId())) {
            changes.add(new ChangeDetail("BU Head Employee ID", existing.getBuHeadEmployeeId(), newEmp.getBuHeadEmployeeId()));
        }
        if (!isEqual(existing.getBuHeadEmail(), newEmp.getBuHeadEmail())) {
            changes.add(new ChangeDetail("BU Head Email", existing.getBuHeadEmail(), newEmp.getBuHeadEmail()));
        }
        if (!isEqual(existing.getProjectHeadName(), newEmp.getProjectHeadName())) {
            changes.add(new ChangeDetail("Project Head", existing.getProjectHeadName(), newEmp.getProjectHeadName()));
        }
        if (!isEqual(existing.getProjectHeadEmployeeId(), newEmp.getProjectHeadEmployeeId())) {
            changes.add(new ChangeDetail("Project Head Employee ID", existing.getProjectHeadEmployeeId(), newEmp.getProjectHeadEmployeeId()));
        }
        if (!isEqual(existing.getProjectHeadEmail(), newEmp.getProjectHeadEmail())) {
            changes.add(new ChangeDetail("Project Head Email", existing.getProjectHeadEmail(), newEmp.getProjectHeadEmail()));
        }
        if (!isEqual(existing.getCfoName(), newEmp.getCfoName())) {
            changes.add(new ChangeDetail("CFO", existing.getCfoName(), newEmp.getCfoName()));
        }
        if (!isEqual(existing.getCfoEmployeeId(), newEmp.getCfoEmployeeId())) {
            changes.add(new ChangeDetail("CFO Employee ID", existing.getCfoEmployeeId(), newEmp.getCfoEmployeeId()));
        }
        if (!isEqual(existing.getCfoEmail(), newEmp.getCfoEmail())) {
            changes.add(new ChangeDetail("CFO Email", existing.getCfoEmail(), newEmp.getCfoEmail()));
        }
        if (!isEqual(existing.getCeoName(), newEmp.getCeoName())) {
            changes.add(new ChangeDetail("CEO", existing.getCeoName(), newEmp.getCeoName()));
        }
        if (!isEqual(existing.getCeoEmployeeId(), newEmp.getCeoEmployeeId())) {
            changes.add(new ChangeDetail("CEO Employee ID", existing.getCeoEmployeeId(), newEmp.getCeoEmployeeId()));
        }
        if (!isEqual(existing.getCeoEmail(), newEmp.getCeoEmail())) {
            changes.add(new ChangeDetail("CEO Email", existing.getCeoEmail(), newEmp.getCeoEmail()));
        }
        
        return changes;
    }
    
    private boolean isEqual(String str1, String str2) {
        if (str1 == null && str2 == null) return true;
        if (str1 == null || str2 == null) return false;
        return str1.equals(str2);
    }
    
    public void approveChanges(ApprovalRequest approvalRequest) {
        for (ExcelChange change : approvalRequest.getChanges()) {
            if (change.isApproved()) {
                EmployeeMaster employee = change.getNewData();
                employee.setId(change.getId());
                employeeMasterDAO.updateEmployee(employee);
            }
        }
    }
    
    private EmployeeMaster mapRowToEmployee(Row row) {
        EmployeeMaster emp = new EmployeeMaster();
        emp.setId((long) row.getCell(0).getNumericCellValue());
        emp.setSbu(getStringCellValue(row.getCell(1)));
        emp.setPlant(getStringCellValue(row.getCell(2)));
        emp.setDepartment(getStringCellValue(row.getCell(3)));
        emp.setCapexRequestorName(getStringCellValue(row.getCell(4)));
        emp.setCapexProjectManagerName(getStringCellValue(row.getCell(5)));
        emp.setSiteHeadName(getStringCellValue(row.getCell(6)));
        emp.setSiteHeadEmployeeId(getStringCellValue(row.getCell(7)));
        emp.setSiteHeadEmail(getStringCellValue(row.getCell(8)));
        emp.setSiteFinanceHeadName(getStringCellValue(row.getCell(9)));
        emp.setSiteFinanceHeadDesignation(getStringCellValue(row.getCell(10)));
        emp.setSiteFinanceHeadEmployeeId(getStringCellValue(row.getCell(11)));
        emp.setSiteFinanceHeadEmail(getStringCellValue(row.getCell(12)));
        emp.setFinanceControllerName(getStringCellValue(row.getCell(13)));
        emp.setFinanceControllerEmployeeId(getStringCellValue(row.getCell(14)));
        emp.setFinanceControllerEmail(getStringCellValue(row.getCell(15)));
        emp.setRegionalDirectorName(getStringCellValue(row.getCell(16)));
        emp.setRegionalDirectorEmployeeId(getStringCellValue(row.getCell(17)));
        emp.setRegionalDirectorEmail(getStringCellValue(row.getCell(18)));
        emp.setBuHeadName(getStringCellValue(row.getCell(19)));
        emp.setBuHeadEmployeeId(getStringCellValue(row.getCell(20)));
        emp.setBuHeadEmail(getStringCellValue(row.getCell(21)));
        emp.setProjectHeadName(getStringCellValue(row.getCell(22)));
        emp.setProjectHeadEmployeeId(getStringCellValue(row.getCell(23)));
        emp.setProjectHeadEmail(getStringCellValue(row.getCell(24)));
        emp.setCfoName(getStringCellValue(row.getCell(25)));
        emp.setCfoEmployeeId(getStringCellValue(row.getCell(26)));
        emp.setCfoEmail(getStringCellValue(row.getCell(27)));
        emp.setCeoName(getStringCellValue(row.getCell(28)));
        emp.setCeoEmployeeId(getStringCellValue(row.getCell(29)));
        emp.setCeoEmail(getStringCellValue(row.getCell(30)));
        return emp;
    }
    
    private String getStringCellValue(Cell cell) {
        if (cell == null) return "";
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                return String.valueOf((long) cell.getNumericCellValue());
            default:
                return "";
        }
    }

	public EmployeeMaster getEmployeeById(Long id) {
		  return employeeMasterDAO.getEmployeeById(id);
	}

	public int updateEmployee(EmployeeMaster existing) {
		  return employeeMasterDAO.updateEmployee(existing);
		
	}
}