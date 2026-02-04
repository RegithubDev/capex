package com.resustainability.reisp.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.WorkbookUtil;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.resustainability.reisp.constants.PageConstants;
import com.resustainability.reisp.model.Department;
import com.resustainability.reisp.model.User;
import com.resustainability.reisp.service.DepartmentService;

@Controller
@RequestMapping("/department") // Add class-level mapping
public class DepartmentController {

    @InitBinder
    public void initBinder(WebDataBinder binder) { 
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }
    
    Logger logger = Logger.getLogger(DepartmentController.class);
    
    @Autowired
    DepartmentService service;
    
    @Value("${common.error.message}")
    public String commonError;
    
    @Value("${record.dataexport.success}")
    public String dataExportSucess;
    
    @Value("${record.dataexport.error}")
    public String dataExportError;
    
    @Value("${record.dataexport.nodata}")
    public String dataExportNoData;
    
    // Main department page
    @RequestMapping(value = "", method = {RequestMethod.GET})
    public ModelAndView departmentPage(HttpSession session) {
        ModelAndView model = new ModelAndView("department"); // Your JSP file name
        try {
            List<Department> sbuList = service.getSBUList();
            model.addObject("sbuList", sbuList);
            
            List<Department> plantList = service.getPlantList();
            model.addObject("plantList", plantList);
            
            List<Department> statusList = service.getStatusFilterList();
            model.addObject("statusList", statusList);
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("Error in departmentPage method: " + e.getMessage());
        }
        return model;
    }
    
    // Get department list (AJAX)
    @RequestMapping(value = "/ajax/getList", method = {RequestMethod.GET, RequestMethod.POST}, 
                    produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<Department> getDepartmentList(@ModelAttribute Department obj, HttpSession session) {
        List<Department> departmentList = null;
        try {
            departmentList = service.getDepartmentsList(obj);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getDepartmentList : " + e.getMessage());
        }
        return departmentList;
    }
    
    // Get single department by ID (AJAX)
    @RequestMapping(value = "/ajax/getById", method = {RequestMethod.GET, RequestMethod.POST}, 
                    produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Department getDepartmentById(@ModelAttribute Department obj, HttpSession session) {
        Department department = null;
        try {
            department = service.getDepartmentById(obj.getId());
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getDepartmentById : " + e.getMessage());
        }
        return department;
    }
    
    // Check unique department code (AJAX)
    @RequestMapping(value = "/ajax/checkUnique", method = {RequestMethod.GET, RequestMethod.POST}, 
                    produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<Department> checkUniqueIfForDept(@ModelAttribute Department obj, HttpSession session) {
        List<Department> departmentList = null;
        try {
            departmentList = service.checkUniqueIfForDept(obj);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("checkUniqueIfForDept : " + e.getMessage());
        }
        return departmentList;
    }
    
    // Get SBU filter options (AJAX)
    @RequestMapping(value = "/ajax/getSBUs", method = {RequestMethod.GET, RequestMethod.POST}, 
                    produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<Department> getSBUFilterList(HttpSession session) {
        List<Department> sbuList = null;
        try {
            sbuList = service.getSBUList();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getSBUFilterList : " + e.getMessage());
        }
        return sbuList;
    }
    
    // Get status filter options (AJAX)
    @RequestMapping(value = "/ajax/getStatuses", method = {RequestMethod.GET, RequestMethod.POST}, 
                    produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<Department> getDepartmentStatusFilterList(HttpSession session) {
        List<Department> statusList = null;
        try {
            statusList = service.getStatusFilterList();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getDepartmentStatusFilterList : " + e.getMessage());
        }
        return statusList;
    }
    
    // Get plant filter options (AJAX)
    @RequestMapping(value = "/ajax/getPlants", method = {RequestMethod.GET, RequestMethod.POST}, 
                    produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<Department> getPlantFilterList(HttpSession session) {
        List<Department> plantList = null;
        try {
            plantList = service.getPlantList();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getPlantFilterList : " + e.getMessage());
        }
        return plantList;
    }
    
    // Add new department
    @RequestMapping(value = "/add", method = {RequestMethod.POST})
    public ModelAndView addDepartment(@ModelAttribute Department obj, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/department");
            boolean flag = service.addDepartment(obj);
            
            if (flag) {
                attributes.addFlashAttribute("success", "Department added successfully.");
            } else {
                attributes.addFlashAttribute("error", "Failed to add department. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            attributes.addFlashAttribute("error", "An error occurred while adding department.");
            logger.error("addDepartment : " + e.getMessage());
        }
        return model;
    }
    
    // Update existing department
    @RequestMapping(value = "/update", method = {RequestMethod.POST})
    public ModelAndView updateDepartment(@ModelAttribute Department obj, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/department");
            boolean flag = service.updateDepartment(obj);
            
            if (flag) {
                attributes.addFlashAttribute("success", "Department updated successfully.");
            } else {
                attributes.addFlashAttribute("error", "Failed to update department. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            attributes.addFlashAttribute("error", "An error occurred while updating department.");
            logger.error("updateDepartment : " + e.getMessage());
        }
        return model;
    }
    
    // Delete department
    @RequestMapping(value = "/delete", method = {RequestMethod.POST})
    public ModelAndView deleteDepartment(@ModelAttribute Department obj, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/department");
            boolean flag = service.deleteDepartment(obj.getId());
            
            if (flag) {
                attributes.addFlashAttribute("success", "Department deleted successfully.");
            } else {
                attributes.addFlashAttribute("error", "Failed to delete department. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            attributes.addFlashAttribute("error", "An error occurred while deleting department.");
            logger.error("deleteDepartment : " + e.getMessage());
        }
        return model;
    }
    
    // Export departments to Excel
    @RequestMapping(value = "/export", method = {RequestMethod.GET})
    public void exportDepartment(HttpServletRequest request, HttpServletResponse response, 
                                 HttpSession session, @ModelAttribute Department obj, 
                                 RedirectAttributes attributes) {
        List<Department> dataList = new ArrayList<Department>();
        String userId = null;
        String userName = null;
        
        try {
            userId = (String) session.getAttribute("USER_ID");
            userName = (String) session.getAttribute("USER_NAME");
            dataList = service.getDepartmentsList(obj);
            
            if (dataList != null && !dataList.isEmpty()) {
                XSSFWorkbook workBook = new XSSFWorkbook();
                XSSFSheet sheet = workBook.createSheet(WorkbookUtil.createSafeSheetName("Department"));
                workBook.setSheetOrder(sheet.getSheetName(), 0);
                
                byte[] blueRGB = new byte[]{(byte)0, (byte)176, (byte)240};
                byte[] greenRGB = new byte[]{(byte)146, (byte)208, (byte)80};
                byte[] whiteRGB = new byte[]{(byte)255, (byte)255, (byte)255};
                
                boolean isWrapText = true;
                boolean isBoldText = true;
                boolean isItalicText = false;
                int fontSize = 11;
                String fontName = "Times New Roman";
                
                CellStyle headerStyle = cellFormating(workBook, greenRGB, HorizontalAlignment.CENTER, 
                                                     VerticalAlignment.CENTER, isWrapText, isBoldText, 
                                                     isItalicText, fontSize, fontName);
                
                isWrapText = true;
                isBoldText = false;
                fontSize = 10;
                CellStyle dataStyle = cellFormating(workBook, whiteRGB, HorizontalAlignment.LEFT, 
                                                   VerticalAlignment.CENTER, isWrapText, isBoldText, 
                                                   isItalicText, fontSize, fontName);
                
                XSSFRow titleRow = sheet.createRow(0);
                Cell titleCell = titleRow.createCell(0);
                titleCell.setCellStyle(headerStyle);
                titleCell.setCellValue("Department Report");
                
                XSSFRow headerRow = sheet.createRow(1);
                String[] headers = {"ID", "SBU", "Plant Code", "Department Code", "Department Name", "Status"};
                
                for (int i = 0; i < headers.length; i++) {
                    Cell cell = headerRow.createCell(i);
                    cell.setCellStyle(headerStyle);
                    cell.setCellValue(headers[i]);
                }
                
                int rowNum = 2;
                for (Department dept : dataList) {
                    XSSFRow row = sheet.createRow(rowNum++);
                    
                    Cell cell = row.createCell(0);
                    cell.setCellStyle(dataStyle);
                    cell.setCellValue(dept.getId() != null ? dept.getId() : "");
                    
                    cell = row.createCell(1);
                    cell.setCellStyle(dataStyle);
                    cell.setCellValue(dept.getSbu() != null ? dept.getSbu() : "");
                    
                    cell = row.createCell(2);
                    cell.setCellStyle(dataStyle);
                    cell.setCellValue(dept.getPlant_code() != null ? dept.getPlant_code() : "");
                    
                    cell = row.createCell(3);
                    cell.setCellStyle(dataStyle);
                    cell.setCellValue(dept.getDepartment_code() != null ? dept.getDepartment_code() : "");
                    
                    cell = row.createCell(4);
                    cell.setCellStyle(dataStyle);
                    cell.setCellValue(dept.getDepartment_name() != null ? dept.getDepartment_name() : "");
                    
                    cell = row.createCell(5);
                    cell.setCellStyle(dataStyle);
                    cell.setCellValue(dept.getStatus() != null ? dept.getStatus() : "");
                }
                
                for (int i = 0; i < headers.length; i++) {
                    sheet.autoSizeColumn(i);
                }
                
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-HHmmss");
                String fileName = "Department_Report_" + dateFormat.format(new Date()) + ".xlsx";
                
                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
                
                workBook.write(response.getOutputStream());
                workBook.close();
                
                attributes.addFlashAttribute("success", dataExportSucess);
                
            } else {
                attributes.addFlashAttribute("error", dataExportNoData);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("exportDepartment : User Id - " + userId + " - User Name - " + userName + " - " + e.getMessage());
            attributes.addFlashAttribute("error", commonError);
        }
    }
    
    private CellStyle cellFormating(XSSFWorkbook workBook, byte[] rgb, HorizontalAlignment hAllign, 
                                   VerticalAlignment vAllign, boolean isWrapText, boolean isBoldText, 
                                   boolean isItalicText, int fontSize, String fontName) {
        CellStyle style = workBook.createCellStyle();
        
        if (style instanceof XSSFCellStyle) {
            XSSFCellStyle xssfCellStyle = (XSSFCellStyle) style;
            xssfCellStyle.setFillForegroundColor(new XSSFColor(rgb, null));
        }
        
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        style.setBorderBottom(BorderStyle.THIN);
        style.setBorderTop(BorderStyle.THIN);
        style.setBorderLeft(BorderStyle.THIN);
        style.setBorderRight(BorderStyle.THIN);
        style.setAlignment(hAllign);
        style.setVerticalAlignment(vAllign);
        style.setWrapText(isWrapText);
        
        Font font = workBook.createFont();
        font.setFontHeightInPoints((short) fontSize);
        font.setFontName(fontName);
        font.setItalic(isItalicText);
        font.setBold(isBoldText);
        
        style.setFont(font);
        return style;
    }
}