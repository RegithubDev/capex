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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.resustainability.reisp.constants.PageConstants;
import com.resustainability.reisp.model.SBU;
import com.resustainability.reisp.model.User;
import com.resustainability.reisp.service.SBUService;

@Controller
public class SBUController {

    @InitBinder
    public void initBinder(WebDataBinder binder) { 
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }
    
    Logger logger = Logger.getLogger(SBUController.class);
    
    @Autowired
    SBUService service;
    
    @Value("${common.error.message}")
    public String commonError;
    
    @Value("${record.dataexport.success}")
    public String dataExportSuccess;
    
    @Value("${record.dataexport.invalid.directory}")
    public String dataExportInvalid;
    
    @Value("${record.dataexport.error}")
    public String dataExportError;
    
    @Value("${record.dataexport.nodata}")
    public String dataExportNoData;
    
    /**
     * Display SBU management page
     */
    @RequestMapping(value = "/sbu", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView sbu(@ModelAttribute User user, HttpSession session) {
        ModelAndView model = new ModelAndView(PageConstants.sbu);
        try {
            // Load SBU statistics for dashboard
            SBU stats = service.getSBUStatistics();
            if (stats != null) {
                model.addObject("stats", stats);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("Error loading SBU page: " + e.getMessage());
        }
        return model;
    }
    
    /**
     * Get all SBUs list (AJAX)
     */
    @RequestMapping(value = "/ajax/getSBUList", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<SBU> getSBUList(@ModelAttribute SBU obj, HttpSession session) {
        List<SBU> sbuList = null;
        try {
            sbuList = service.getSBUsList(obj);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getSBUList : " + e.getMessage());
        }
        return sbuList;
    }
    
    /**
     * Get SBU by ID (AJAX)
     */
    @RequestMapping(value = "/ajax/getSBUById/{id}", method = {RequestMethod.GET}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public SBU getSBUById(@PathVariable("id") String id, HttpSession session) {
        SBU sbu = null;
        try {
            sbu = service.getSBUById(id);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getSBUById : " + e.getMessage());
        }
        return sbu;
    }
    
    /**
     * Get active SBUs for dropdown (AJAX)
     */
    @RequestMapping(value = "/ajax/getActiveSBUs", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<SBU> getActiveSBUs(HttpSession session) {
        List<SBU> sbuList = null;
        try {
            sbuList = service.getActiveSBUs();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getActiveSBUs : " + e.getMessage());
        }
        return sbuList;
    }
    
    /**
     * Get SBU statistics (AJAX)
     */
    @RequestMapping(value = "/ajax/getSBUStatistics", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public SBU getSBUStatistics(HttpSession session) {
        SBU stats = new SBU();
        try {
            stats = service.getSBUStatistics();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getSBUStatistics : " + e.getMessage());
        }
        return stats;
    }
    
    /**
     * Check if SBU code is unique (AJAX)
     */
    @RequestMapping(value = "/ajax/checkUniqueSBUCode", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public boolean checkUniqueSBUCode(@ModelAttribute SBU obj, HttpSession session) {
        try {
            String excludeId = obj.getId();
            return service.isSBUCodeUnique(obj.getSbu(), excludeId);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("checkUniqueSBUCode : " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Get status filter list for SBU (UNIQUE ENDPOINT)
     */
    @RequestMapping(value = "/ajax/getSBUStatusFilterList", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<String> getSBUStatusFilterList(HttpSession session) {
        List<String> statusList = new ArrayList<>();
        try {
            statusList = service.getStatusFilterList();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getSBUStatusFilterList : " + e.getMessage());
        }
        return statusList;
    }
    
    /**
     * Add new SBU
     */
    @RequestMapping(value = "/sbu/add", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView addSBU(@ModelAttribute SBU obj, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/sbu");
            
            // Validate required fields
            if (obj.getSbu() == null || obj.getSbu().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "SBU Code is required.");
                return model;
            }
            
            if (obj.getSbu_name() == null || obj.getSbu_name().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "SBU Name is required.");
                return model;
            }
            
            if (obj.getStatus() == null || obj.getStatus().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Status is required.");
                return model;
            }
            
            boolean flag = service.addSBU(obj);
            if (flag) {
                attributes.addFlashAttribute("success", "SBU added successfully.");
            } else {
                attributes.addFlashAttribute("error", "Failed to add SBU. Please try again.");
            }
            
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Error adding SBU: " + e.getMessage());
            e.printStackTrace();
            logger.error("addSBU : " + e.getMessage());
        }
        return model;
    }
    
    /**
     * Update existing SBU
     */
    @RequestMapping(value = "/sbu/update", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView updateSBU(@ModelAttribute SBU obj, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/sbu");
            
            // Validate required fields
            if (obj.getId() == null || obj.getId().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "SBU ID is required for update.");
                return model;
            }
            
            if (obj.getSbu() == null || obj.getSbu().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "SBU Code is required.");
                return model;
            }
            
            if (obj.getSbu_name() == null || obj.getSbu_name().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "SBU Name is required.");
                return model;
            }
            
            if (obj.getStatus() == null || obj.getStatus().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Status is required.");
                return model;
            }
            
            boolean flag = service.updateSBU(obj);
            if (flag) {
                attributes.addFlashAttribute("success", "SBU updated successfully.");
            } else {
                attributes.addFlashAttribute("error", "Failed to update SBU. Please try again.");
            }
            
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Error updating SBU: " + e.getMessage());
            e.printStackTrace();
            logger.error("updateSBU : " + e.getMessage());
        }
        return model;
    }
    
    /**
     * Delete SBU
     */
    @RequestMapping(value = "/sbu/delete/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView deleteSBU(@PathVariable("id") String id, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/sbu");
            
            if (id == null || id.trim().isEmpty()) {
                attributes.addFlashAttribute("error", "SBU ID is required for deletion.");
                return model;
            }
            
            boolean flag = service.deleteSBU(id);
            if (flag) {
                attributes.addFlashAttribute("success", "SBU deleted successfully.");
            } else {
                attributes.addFlashAttribute("error", "Failed to delete SBU. Please try again.");
            }
            
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Error deleting SBU: " + e.getMessage());
            e.printStackTrace();
            logger.error("deleteSBU : " + e.getMessage());
        }
        return model;
    }
    
    /**
     * Export SBUs to Excel
     */
    @RequestMapping(value = "/sbu/export", method = {RequestMethod.GET, RequestMethod.POST})
    public void exportSBU(HttpServletRequest request, HttpServletResponse response, 
                         HttpSession session, @ModelAttribute SBU obj, RedirectAttributes attributes) {
        String userId = null;
        String userName = null;
        
        try {
            userId = (String) session.getAttribute("USER_ID");
            userName = (String) session.getAttribute("USER_NAME");
            
            List<SBU> dataList = service.getSBUsList(obj); 
            
            if (dataList != null && !dataList.isEmpty()) {
                XSSFWorkbook workBook = new XSSFWorkbook();
                XSSFSheet sheet = workBook.createSheet(WorkbookUtil.createSafeSheetName("SBU"));
                workBook.setSheetOrder(sheet.getSheetName(), 0);
                
                // Define colors
                byte[] blueRGB = new byte[]{(byte)0, (byte)176, (byte)240};
                byte[] greenRGB = new byte[]{(byte)146, (byte)208, (byte)80};
                byte[] whiteRGB = new byte[]{(byte)255, (byte)255, (byte)255};
                
                // Create styles
                CellStyle greenStyle = cellFormating(workBook, greenRGB, HorizontalAlignment.CENTER, 
                                                     VerticalAlignment.CENTER, true, true, false, 11, "Times New Roman");
                
                CellStyle dataStyle = cellFormating(workBook, whiteRGB, HorizontalAlignment.LEFT, 
                                                    VerticalAlignment.CENTER, true, false, false, 10, "Times New Roman");
                
                // Create header
                XSSFRow heading = sheet.createRow(0);
                Cell headerCell = heading.createCell(0);
                headerCell.setCellStyle(greenStyle);
                headerCell.setCellValue("SBU Report");
                
                // Create column headers
                XSSFRow headerRow = sheet.createRow(2);
                String[] headers = {"#", "SBU Code", "SBU Name", "Status"};
                
                for (int i = 0; i < headers.length; i++) {
                    Cell cell = headerRow.createCell(i);
                    cell.setCellStyle(greenStyle);
                    cell.setCellValue(headers[i]);
                }
                
                // Fill data
                int rowNum = 3;
                int serialNo = 1;
                
                for (SBU sbu : dataList) {
                    XSSFRow row = sheet.createRow(rowNum++);
                    int colNum = 0;
                    
                    Cell cell = row.createCell(colNum++);
                    cell.setCellStyle(dataStyle);
                    cell.setCellValue(serialNo++);
                    
                    cell = row.createCell(colNum++);
                    cell.setCellStyle(dataStyle);
                    cell.setCellValue(sbu.getSbu() != null ? sbu.getSbu() : "");
                    
                    cell = row.createCell(colNum++);
                    cell.setCellStyle(dataStyle);
                    cell.setCellValue(sbu.getSbu_name() != null ? sbu.getSbu_name() : "");
                    
                    cell = row.createCell(colNum++);
                    cell.setCellStyle(dataStyle);
                    cell.setCellValue(sbu.getStatus() != null ? sbu.getStatus() : "");
                }
                
                // Auto-size columns
                for (int i = 0; i < headers.length; i++) {
                    sheet.autoSizeColumn(i);
                }
                
                // Generate file name
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-HHmmss");
                String fileName = "SBU_Report_" + dateFormat.format(new Date());
                
                // Set response headers
                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ".xlsx");
                
                // Write to response
                workBook.write(response.getOutputStream());
                workBook.close();
                response.getOutputStream().flush();
                
                attributes.addFlashAttribute("success", dataExportSuccess);
                
            } else {
                attributes.addFlashAttribute("error", dataExportNoData);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("exportSBU : User Id - " + userId + " - User Name - " + userName + " - " + e.getMessage());
            attributes.addFlashAttribute("error", commonError);
        }
    }
    
    /**
     * Helper method for Excel cell formatting
     */
    private CellStyle cellFormating(XSSFWorkbook workBook, byte[] rgb, HorizontalAlignment hAllign, 
                                    VerticalAlignment vAllign, boolean isWrapText, boolean isBoldText, 
                                    boolean isItalicText, int fontSize, String fontName) {
        CellStyle style = workBook.createCellStyle();
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        
        if (style instanceof XSSFCellStyle) {
            XSSFCellStyle xssfcellcolorstyle = (XSSFCellStyle) style;
            xssfcellcolorstyle.setFillForegroundColor(new XSSFColor(rgb, null));
        }
        
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