package com.resustainability.reisp.controller;

import java.io.IOException;
import java.sql.Timestamp;
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
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
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
     * Error response class for consistent error handling
     */
    public static class ErrorResponse {
        private String message;
        private int status;
        private long timestamp;
        
        public ErrorResponse(String message, int status) {
            this.message = message;
            this.status = status;
            this.timestamp = System.currentTimeMillis();
        }
        
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
        public int getStatus() { return status; }
        public void setStatus(int status) { this.status = status; }
        public long getTimestamp() { return timestamp; }
        public void setTimestamp(long timestamp) { this.timestamp = timestamp; }
    }
    
    /**
     * Global exception handler for this controller
     */
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public ResponseEntity<ErrorResponse> handleException(Exception e) {
        logger.error("Global exception handler: " + e.getMessage());
        e.printStackTrace();
        ErrorResponse error = new ErrorResponse("An error occurred: " + e.getMessage(), 500);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
    }
    
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
    public ResponseEntity<?> getSBUList(@ModelAttribute SBU obj, HttpSession session) {
        try {
            List<SBU> sbuList = service.getSBUsList(obj);
            if (sbuList != null) {
                return ResponseEntity.ok(sbuList);
            } else {
                return ResponseEntity.ok(new ArrayList<>());
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getSBUList : " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                               .body(new ErrorResponse("Error fetching SBU list: " + e.getMessage(), 500));
        }
    }
    
    /**
     * Get SBU by ID (AJAX) - FIXED VERSION
     */
    @RequestMapping(value = "/ajax/getSBUById/{id}", method = {RequestMethod.GET}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> getSBUById(@PathVariable("id") String id, HttpSession session) {
        try {
            // Validate ID
            if (id == null || id.trim().isEmpty()) {
                return ResponseEntity.badRequest()
                                   .body(new ErrorResponse("SBU ID is required", 400));
            }
            
            SBU sbu = service.getSBUById(id);
            if (sbu != null) {
                return ResponseEntity.ok(sbu);
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                                   .body(new ErrorResponse("SBU not found with ID: " + id, 404));
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getSBUById : " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                               .body(new ErrorResponse("Error fetching SBU: " + e.getMessage(), 500));
        }
    }
    
    /**
     * Get active SBUs for dropdown (AJAX)
     */
    @RequestMapping(value = "/ajax/getActiveSBUs", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> getActiveSBUs(HttpSession session) {
        try {
            List<SBU> sbuList = service.getActiveSBUs();
            return ResponseEntity.ok(sbuList != null ? sbuList : new ArrayList<>());
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getActiveSBUs : " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                               .body(new ErrorResponse("Error fetching active SBUs: " + e.getMessage(), 500));
        }
    }
    
    /**
     * Get SBU statistics (AJAX)
     */
    @RequestMapping(value = "/ajax/getSBUStatistics", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> getSBUStatistics(HttpSession session) {
        try {
            SBU stats = service.getSBUStatistics();
            return ResponseEntity.ok(stats != null ? stats : new SBU());
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getSBUStatistics : " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                               .body(new ErrorResponse("Error fetching statistics: " + e.getMessage(), 500));
        }
    }
    
    /**
     * Check if SBU code is unique (AJAX)
     */
    @RequestMapping(value = "/ajax/checkUniqueSBUCode", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> checkUniqueSBUCode(@ModelAttribute SBU obj, HttpSession session) {
        try {
            String excludeId = obj.getId();
            boolean isUnique = service.isSBUCodeUnique(obj.getSbu(), excludeId);
            return ResponseEntity.ok(isUnique);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("checkUniqueSBUCode : " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                               .body(new ErrorResponse("Error checking uniqueness: " + e.getMessage(), 500));
        }
    }
    
    /**
     * Get status filter list for SBU
     */
    @RequestMapping(value = "/ajax/getSBUStatusFilterList", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> getSBUStatusFilterList(HttpSession session) {
        try {
            List<String> statusList = service.getStatusFilterList();
            return ResponseEntity.ok(statusList != null ? statusList : new ArrayList<>());
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getSBUStatusFilterList : " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                               .body(new ErrorResponse("Error fetching status list: " + e.getMessage(), 500));
        }
    }
    
    /**
     * Add new SBU - AJAX endpoint for frontend
     */
    @RequestMapping(value = "/sbu/add/ajax", method = RequestMethod.POST, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> addSBUAjax(@ModelAttribute SBU obj, HttpSession session) {
        try {
            // Validate required fields
            if (obj.getSbu() == null || obj.getSbu().trim().isEmpty()) {
                return ResponseEntity.badRequest()
                                   .body(new ErrorResponse("SBU Code is required.", 400));
            }
            
            if (obj.getSbu_name() == null || obj.getSbu_name().trim().isEmpty()) {
                return ResponseEntity.badRequest()
                                   .body(new ErrorResponse("SBU Name is required.", 400));
            }
            
            if (obj.getStatus() == null || obj.getStatus().trim().isEmpty()) {
                obj.setStatus("Active"); // Set default status
            }
            
            // Get current user from session
            String currentUser = (String) session.getAttribute("USER_NAME");
            if (currentUser == null || currentUser.isEmpty()) {
                currentUser = (String) session.getAttribute("userName");
                if (currentUser == null || currentUser.isEmpty()) {
                    currentUser = "SYSTEM";
                }
            }
            
            // Set created by and date
            obj.setCreated_by(currentUser);
            obj.setCreated_date(new Timestamp(System.currentTimeMillis()));
            
            boolean flag = service.addSBU(obj);
            if (flag) {
                return ResponseEntity.ok(new ErrorResponse("SBU added successfully.", 200));
            } else {
                return ResponseEntity.badRequest()
                                   .body(new ErrorResponse("Failed to add SBU. Please try again.", 400));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("addSBUAjax : " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                               .body(new ErrorResponse("Error adding SBU: " + e.getMessage(), 500));
        }
    }
    
    /**
     * Update existing SBU - AJAX endpoint for frontend
     */
    @RequestMapping(value = "/sbu/update/ajax", method = RequestMethod.POST, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> updateSBUAjax(@ModelAttribute SBU obj, HttpSession session) {
        try {
            // Validate required fields
            if (obj.getId() == null || obj.getId().trim().isEmpty()) {
                return ResponseEntity.badRequest()
                                   .body(new ErrorResponse("SBU ID is required for update.", 400));
            }
            
            if (obj.getSbu() == null || obj.getSbu().trim().isEmpty()) {
                return ResponseEntity.badRequest()
                                   .body(new ErrorResponse("SBU Code is required.", 400));
            }
            
            if (obj.getSbu_name() == null || obj.getSbu_name().trim().isEmpty()) {
                return ResponseEntity.badRequest()
                                   .body(new ErrorResponse("SBU Name is required.", 400));
            }
            
            // Get current user from session
            String currentUser = (String) session.getAttribute("USER_NAME");
            if (currentUser == null || currentUser.isEmpty()) {
                currentUser = (String) session.getAttribute("userName");
                if (currentUser == null || currentUser.isEmpty()) {
                    currentUser = "SYSTEM";
                }
            }
            
            // Set updated by and date
            obj.setUpdated_by(currentUser);
            obj.setUpdated_at(new Timestamp(System.currentTimeMillis()));
            
            boolean flag = service.updateSBU(obj);
            if (flag) {
                return ResponseEntity.ok(new ErrorResponse("SBU updated successfully.", 200));
            } else {
                return ResponseEntity.badRequest()
                                   .body(new ErrorResponse("Failed to update SBU. Please try again.", 400));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("updateSBUAjax : " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                               .body(new ErrorResponse("Error updating SBU: " + e.getMessage(), 500));
        }
    }
    
    /**
     * Delete SBU - AJAX endpoint for frontend
     */
    @RequestMapping(value = "/sbu/delete/ajax/{id}", method = RequestMethod.POST, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> deleteSBUAjax(@PathVariable("id") String id, HttpSession session) {
        try {
            if (id == null || id.trim().isEmpty()) {
                return ResponseEntity.badRequest()
                                   .body(new ErrorResponse("SBU ID is required for deletion.", 400));
            }
            
            boolean flag = service.deleteSBU(id);
            if (flag) {
                return ResponseEntity.ok(new ErrorResponse("SBU deleted successfully.", 200));
            } else {
                return ResponseEntity.badRequest()
                                   .body(new ErrorResponse("Failed to delete SBU. Please try again.", 400));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("deleteSBUAjax : " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                               .body(new ErrorResponse("Error deleting SBU: " + e.getMessage(), 500));
        }
    }
    
    // Keep your existing form submission endpoints for non-AJAX requests
    @RequestMapping(value = "/sbu/add", method = RequestMethod.POST)
    public ModelAndView addSBU(@ModelAttribute SBU obj, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView("redirect:/sbu");
        try {
            // Get current user from session
            String currentUser = (String) session.getAttribute("USER_NAME");
            if (currentUser == null || currentUser.isEmpty()) {
                currentUser = (String) session.getAttribute("userName");
                if (currentUser == null || currentUser.isEmpty()) {
                    currentUser = "SYSTEM";
                }
            }
            
            // Set created by and date
            obj.setCreated_by(currentUser);
            obj.setCreated_date(new Timestamp(System.currentTimeMillis()));
            
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
    
    @RequestMapping(value = "/sbu/update", method = RequestMethod.POST)
    public ModelAndView updateSBU(@ModelAttribute SBU obj, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView("redirect:/sbu");
        try {
            // Get current user from session
            String currentUser = (String) session.getAttribute("USER_NAME");
            if (currentUser == null || currentUser.isEmpty()) {
                currentUser = (String) session.getAttribute("userName");
                if (currentUser == null || currentUser.isEmpty()) {
                    currentUser = "SYSTEM";
                }
            }
            
            // Set updated by and date
            obj.setUpdated_by(currentUser);
            obj.setUpdated_at(new Timestamp(System.currentTimeMillis()));
            
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
    
    @RequestMapping(value = "/sbu/delete/{id}", method = RequestMethod.POST)
    public ModelAndView deleteSBU(@PathVariable("id") String id, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView("redirect:/sbu");
        try {
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
                String[] headers = {"#", "SBU Code", "SBU Name", "Status", "Created By", "Created Date", "Updated By", "Updated Date"};
                
                for (int i = 0; i < headers.length; i++) {
                    Cell cell = headerRow.createCell(i);
                    cell.setCellStyle(greenStyle);
                    cell.setCellValue(headers[i]);
                }
                
                // Fill data
                int rowNum = 3;
                int serialNo = 1;
                
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
                
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
                    
                    cell = row.createCell(colNum++);
                    cell.setCellStyle(dataStyle);
                    cell.setCellValue(sbu.getCreated_by() != null ? sbu.getCreated_by() : "");
                    
                    cell = row.createCell(colNum++);
                    cell.setCellStyle(dataStyle);
                    if (sbu.getCreated_date() != null) {
                        cell.setCellValue(dateFormat.format(sbu.getCreated_date()));
                    } else {
                        cell.setCellValue("");
                    }
                    
                    cell = row.createCell(colNum++);
                    cell.setCellStyle(dataStyle);
                    cell.setCellValue(sbu.getUpdated_by() != null ? sbu.getUpdated_by() : "");
                    
                    cell = row.createCell(colNum++);
                    cell.setCellStyle(dataStyle);
                    if (sbu.getUpdated_at() != null) {
                        cell.setCellValue(dateFormat.format(sbu.getUpdated_at()));
                    } else {
                        cell.setCellValue("");
                    }
                }
                
                // Auto-size columns
                for (int i = 0; i < headers.length; i++) {
                    sheet.autoSizeColumn(i);
                }
                
                // Generate file name
                DateFormat fileNameDateFormat = new SimpleDateFormat("yyyy-MM-dd-HHmmss");
                String fileName = "SBU_Report_" + fileNameDateFormat.format(new Date());
                
                // Set response headers
                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ".xlsx");
                
                // Write to response
                workBook.write(response.getOutputStream());
                workBook.close();
                response.getOutputStream().flush();
                
            } else {
                response.sendRedirect(request.getContextPath() + "/sbu?error=" + java.net.URLEncoder.encode(dataExportNoData, "UTF-8"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("exportSBU : User Id - " + userId + " - User Name - " + userName + " - " + e.getMessage());
            try {
                response.sendRedirect(request.getContextPath() + "/sbu?error=" + java.net.URLEncoder.encode(commonError, "UTF-8"));
            } catch (IOException ex) {
                ex.printStackTrace();
            }
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