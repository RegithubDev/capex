package com.resustainability.reisp.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.resustainability.reisp.constants.PageConstants;
import com.resustainability.reisp.model.ApprovalRequest;
import com.resustainability.reisp.model.ChangeDetail;
import com.resustainability.reisp.model.Company;
import com.resustainability.reisp.model.EmployeeMaster;
import com.resustainability.reisp.model.ExcelChange;
import com.resustainability.reisp.model.User;
import com.resustainability.reisp.service.EmployeeMasterService;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
@Controller
public class EmployeeMasterController {
    
    @Autowired
    private EmployeeMasterService employeeMasterService;
    
    @RequestMapping(value = "/employee", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView company(@ModelAttribute User user, HttpSession session) {
		ModelAndView model = new ModelAndView(PageConstants.rules);
		Company obj = null;
		try {
			 List<EmployeeMaster> employees = employeeMasterService.getAllEmployees();
		        model.addObject("employees", employees);
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
    @RequestMapping("/list")
    public String getEmployeeList(Model model) {
        List<EmployeeMaster> employees = employeeMasterService.getAllEmployees();
        model.addAttribute("employees", employees);
        return "employeeList";
    }
    
    @RequestMapping("/downloadExcel")
    public void downloadExcel(HttpServletResponse response) throws IOException {
        List<EmployeeMaster> employees = employeeMasterService.getAllEmployees();
        
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=employee_master_data.xlsx");
        
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Employee Data");
        
        // Create header row
        Row headerRow = sheet.createRow(0);
        String[] columns = {"id", "sbu", "plant", "department", "capex_requestor_name", 
                           "capex_project_manager_name", "site_head_name", "site_head_employee_id", 
                           "site_head_email", "site_finance_head_name", "site_finance_head_designation",
                           "site_finance_head_employee_id", "site_finance_head_email", 
                           "finance_controller_name", "finance_controller_employee_id", 
                           "finance_controller_email", "regional_director_name", 
                           "regional_director_employee_id", "regional_director_email", 
                           "bu_head_name", "bu_head_employee_id", "bu_head_email", 
                           "project_head_name", "project_head_employee_id", "project_head_email",
                           "cfo_name", "cfo_employee_id", "cfo_email", "ceo_name", 
                           "ceo_employee_id", "ceo_email", "created_at"};
        
        for (int i = 0; i < columns.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columns[i]);
        }
        
        // Create data rows
        int rowNum = 1;
        for (EmployeeMaster emp : employees) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(emp.getId());
            row.createCell(1).setCellValue(emp.getSbu() != null ? emp.getSbu() : "");
            row.createCell(2).setCellValue(emp.getPlant() != null ? emp.getPlant() : "");
            row.createCell(3).setCellValue(emp.getDepartment() != null ? emp.getDepartment() : "");
            row.createCell(4).setCellValue(emp.getCapexRequestorName() != null ? emp.getCapexRequestorName() : "");
            row.createCell(5).setCellValue(emp.getCapexProjectManagerName() != null ? emp.getCapexProjectManagerName() : "");
            row.createCell(6).setCellValue(emp.getSiteHeadName() != null ? emp.getSiteHeadName() : "");
            row.createCell(7).setCellValue(emp.getSiteHeadEmployeeId() != null ? emp.getSiteHeadEmployeeId() : "");
            row.createCell(8).setCellValue(emp.getSiteHeadEmail() != null ? emp.getSiteHeadEmail() : "");
            row.createCell(9).setCellValue(emp.getSiteFinanceHeadName() != null ? emp.getSiteFinanceHeadName() : "");
            row.createCell(10).setCellValue(emp.getSiteFinanceHeadDesignation() != null ? emp.getSiteFinanceHeadDesignation() : "");
            row.createCell(11).setCellValue(emp.getSiteFinanceHeadEmployeeId() != null ? emp.getSiteFinanceHeadEmployeeId() : "");
            row.createCell(12).setCellValue(emp.getSiteFinanceHeadEmail() != null ? emp.getSiteFinanceHeadEmail() : "");
            row.createCell(13).setCellValue(emp.getFinanceControllerName() != null ? emp.getFinanceControllerName() : "");
            row.createCell(14).setCellValue(emp.getFinanceControllerEmployeeId() != null ? emp.getFinanceControllerEmployeeId() : "");
            row.createCell(15).setCellValue(emp.getFinanceControllerEmail() != null ? emp.getFinanceControllerEmail() : "");
            row.createCell(16).setCellValue(emp.getRegionalDirectorName() != null ? emp.getRegionalDirectorName() : "");
            row.createCell(17).setCellValue(emp.getRegionalDirectorEmployeeId() != null ? emp.getRegionalDirectorEmployeeId() : "");
            row.createCell(18).setCellValue(emp.getRegionalDirectorEmail() != null ? emp.getRegionalDirectorEmail() : "");
            row.createCell(19).setCellValue(emp.getBuHeadName() != null ? emp.getBuHeadName() : "");
            row.createCell(20).setCellValue(emp.getBuHeadEmployeeId() != null ? emp.getBuHeadEmployeeId() : "");
            row.createCell(21).setCellValue(emp.getBuHeadEmail() != null ? emp.getBuHeadEmail() : "");
            row.createCell(22).setCellValue(emp.getProjectHeadName() != null ? emp.getProjectHeadName() : "");
            row.createCell(23).setCellValue(emp.getProjectHeadEmployeeId() != null ? emp.getProjectHeadEmployeeId() : "");
            row.createCell(24).setCellValue(emp.getProjectHeadEmail() != null ? emp.getProjectHeadEmail() : "");
            row.createCell(25).setCellValue(emp.getCfoName() != null ? emp.getCfoName() : "");
            row.createCell(26).setCellValue(emp.getCfoEmployeeId() != null ? emp.getCfoEmployeeId() : "");
            row.createCell(27).setCellValue(emp.getCfoEmail() != null ? emp.getCfoEmail() : "");
            row.createCell(28).setCellValue(emp.getCeoName() != null ? emp.getCeoName() : "");
            row.createCell(29).setCellValue(emp.getCeoEmployeeId() != null ? emp.getCeoEmployeeId() : "");
            row.createCell(30).setCellValue(emp.getCeoEmail() != null ? emp.getCeoEmail() : "");
            row.createCell(31).setCellValue(emp.getCreatedAt() != null ? emp.getCreatedAt().toString() : "");
        }
        
        workbook.write(response.getOutputStream());
        workbook.close();
    }
    
    @RequestMapping("/uploadExcel")
    @ResponseBody
    public Map<String, Object> uploadExcel(@RequestParam("file") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<ExcelChange> changes = employeeMasterService.processExcelUpload(file);
            if (!changes.isEmpty()) {
                response.put("status", "pending_approval");
                response.put("changes", changes);
                response.put("message", "Please review and approve the changes");
            } else {
                response.put("status", "success");
                response.put("message", "No changes detected");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Error processing file: " + e.getMessage());
            e.printStackTrace();
        }
        return response;
    }
    
    @RequestMapping("/approveChanges")
    @ResponseBody
    public Map<String, Object> approveChanges(@RequestBody Map<String, Object> request) {

        Map<String, Object> response = new HashMap<>();

        try {
            List<Map<String, Object>> changesList =
                    (List<Map<String, Object>>) request.get("changes");

            if (changesList == null || changesList.isEmpty()) {
                response.put("status", "error");
                response.put("message", "No changes provided");
                return response;
            }

            int successCount = 0;

            for (Map<String, Object> changeMap : changesList) {
                try {

                    EmployeeMaster employee = new EmployeeMaster();

                    // 🔥 OPTIONAL ID (can be null for new records)
                    if (changeMap.get("id") != null && !changeMap.get("id").toString().isEmpty()) {
                        employee.setId(Long.valueOf(changeMap.get("id").toString()));
                    }

                    List<Map<String, Object>> detailsList =
                            (List<Map<String, Object>>) changeMap.get("changes");

                    // 🔥 APPLY ALL FIELDS
                    for (Map<String, Object> detail : detailsList) {

                        String field = detail.get("field").toString();
                        String newValue = detail.get("newValue") != null
                                ? detail.get("newValue").toString()
                                : null;

                        updateField(employee, field, newValue);
                    }

                    // 🔥 SINGLE METHOD CALL (UPSERT)
                    employeeMasterService.updateEmployee(employee);

                    successCount++;

                } catch (Exception e) {
                    System.err.println("Error processing record: " + e.getMessage());
                    e.printStackTrace();
                }
            }

            response.put("status", "success");
            response.put("message", "Successfully processed " + successCount + " records");

        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Error: " + e.getMessage());
            e.printStackTrace();
        }

        return response;
    }

    private void updateField(EmployeeMaster employee, String field, String value) {
        switch(field) {
            case "SBU":
                employee.setSbu(value);
                break;
            case "Plant":
                employee.setPlant(value);
                break;
            case "Department":
                employee.setDepartment(value);
                break;
            case "CAPEX Requestor Name":
                employee.setCapexRequestorName(value);
                break;
            case "CAPEX Project Manager":
                employee.setCapexProjectManagerName(value);
                break;
            case "Site Head":
                employee.setSiteHeadName(value);
                break;
            case "Site Head Employee ID":
                employee.setSiteHeadEmployeeId(value);
                break;
            case "Site Head Email":
                employee.setSiteHeadEmail(value);
                break;
            case "Site Finance Head":
                employee.setSiteFinanceHeadName(value);
                break;
            case "Site Finance Head Designation":
                employee.setSiteFinanceHeadDesignation(value);
                break;
            case "Site Finance Head Employee ID":
                employee.setSiteFinanceHeadEmployeeId(value);
                break;
            case "Site Finance Head Email":
                employee.setSiteFinanceHeadEmail(value);
                break;
            case "Finance Controller":
                employee.setFinanceControllerName(value);
                break;
            case "Finance Controller Employee ID":
                employee.setFinanceControllerEmployeeId(value);
                break;
            case "Finance Controller Email":
                employee.setFinanceControllerEmail(value);
                break;
            case "Regional Director":
                employee.setRegionalDirectorName(value);
                break;
            case "Regional Director Employee ID":
                employee.setRegionalDirectorEmployeeId(value);
                break;
            case "Regional Director Email":
                employee.setRegionalDirectorEmail(value);
                break;
            case "BU Head":
                employee.setBuHeadName(value);
                break;
            case "BU Head Employee ID":
                employee.setBuHeadEmployeeId(value);
                break;
            case "BU Head Email":
                employee.setBuHeadEmail(value);
                break;
            case "Project Head":
                employee.setProjectHeadName(value);
                break;
            case "Project Head Employee ID":
                employee.setProjectHeadEmployeeId(value);
                break;
            case "Project Head Email":
                employee.setProjectHeadEmail(value);
                break;
            case "CFO":
                employee.setCfoName(value);
                break;
            case "CFO Employee ID":
                employee.setCfoEmployeeId(value);
                break;
            case "CFO Email":
                employee.setCfoEmail(value);
                break;
            case "CEO":
                employee.setCeoName(value);
                break;
            case "CEO Employee ID":
                employee.setCeoEmployeeId(value);
                break;
            case "CEO Email":
                employee.setCeoEmail(value);
                break;
        }
    }

}