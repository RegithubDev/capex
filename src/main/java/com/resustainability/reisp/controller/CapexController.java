package com.resustainability.reisp.controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.Year;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.resustainability.reisp.model.CapexProposal;
import com.resustainability.reisp.model.Department;
import com.resustainability.reisp.model.Plant;
import com.resustainability.reisp.model.SBU;
import com.resustainability.reisp.model.User;
import com.resustainability.reisp.service.CapexService;
import com.resustainability.reisp.service.DepartmentService;
import com.resustainability.reisp.service.PlantService;
import com.resustainability.reisp.service.UserService;

@Controller
@RequestMapping("/form")
public class CapexController {
    @InitBinder
    public void initBinder(WebDataBinder binder) { 
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }
    
    Logger logger = Logger.getLogger(CapexController.class);
    
    @Autowired
    private CapexService capexService;

	@Autowired
	UserService service_user;
	
    @Autowired
    PlantService service_plant;
    
    @Autowired
    DepartmentService service_dept;
    
    @RequestMapping(value = "/capex", method = {RequestMethod.GET})
    public ModelAndView capexPage(HttpSession session) {
        ModelAndView model = new ModelAndView("capexgrid"); // Your JSP file name
        try {
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("Error in departmentPage method: " + e.getMessage());
        }
        return model;
    }
    @RequestMapping(value = "/capex-form", method = {RequestMethod.GET})
    public ModelAndView capexFormPage(HttpSession session) {
        ModelAndView model = new ModelAndView("dashboardAdmin"); // Your JSP file name
        	String userId = null;
      		String userName = null;
      		String plant = null;
      		String role = null;
        try {
        	Plant obj = new Plant();
        	obj.setStatus("Active");
        	User u = new User();
        	Department objd = new Department();
        	objd.setStatus("Active");
        	if(role != "Admin") {
        		obj.setPlant_code(plant);
        	}
        	List<User> uList = service_user.getUsersList(u);
			model.addObject("uList", uList);
        	obj.setTotal_available_budget_fy(role);
            List<Department> departmentList= service_dept.getDepartmentsList(objd);
            model.addObject("departmentList", departmentList);
        	List<Plant> pList = service_plant.getPlantsList(obj);
			model.addObject("pList", pList);
			
			
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("Error in departmentPage method: " + e.getMessage());
        }
        return model;
    }
    
    @RequestMapping(value = "/capex-form/{capex_number}", method = {RequestMethod.GET})
    public ModelAndView capexEditFormPage(HttpSession session,@PathVariable("capex_number") String capex_number) {
        ModelAndView model = new ModelAndView("dashboardPlant"); // Your JSP file name
        	String userId = null;
      		String userName = null;
      		String plant = null;
      		String role = null;
        try {
        	User u = new User();
        	CapexProposal obj = new CapexProposal();
        	obj.setCapex_number(capex_number);
        	Plant objp = new Plant();
        	obj.setStatus("Active");
        	if(role != "Admin") {
        		objp.setPlant_code(plant);
        		u.setBase_project(plant);
        	}
        	Department objd = new Department();
        	objd.setStatus("Active");
        	
            List<Department> departmentList= service_dept.getDepartmentsList(objd);
            model.addObject("departmentList", departmentList);
            List<Plant> pList = service_plant.getPlantsList(objp);
			model.addObject("pList", pList);
		
			List<User> uList = service_user.getUsersList(u);
			model.addObject("uList", uList);
        	CapexProposal editList = capexService.getCapexEditFormPage(obj);
			model.addObject("editList", editList);
			
			
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("Error in departmentPage method: " + e.getMessage());
        }
        return model;
    }
    
    // Get department list (AJAX)
    @RequestMapping(value = "/ajax/getCapexList", method = {RequestMethod.GET, RequestMethod.POST}, 
                    produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<CapexProposal> getCapexList(@ModelAttribute CapexProposal obj, HttpSession session) {
        List<CapexProposal> capexList = null;
        String userId = null;
		String userName = null;
		String plant = null;
		String role = null;
        try {
        	userId = (String) session.getAttribute("USER_ID");
			userName = (String) session.getAttribute("USER_NAME");
			role = (String) session.getAttribute("BASE_ROLE");
			plant = (String) session.getAttribute("BASE_PROJECT_CODE");
			String email = (String) session.getAttribute("USER_EMAIL");
			obj.setRole(role);
			obj.setPlant_code(plant);
        	capexList = capexService.getCapexList(obj);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getCapexList : " + e.getMessage());
        }
        return capexList;
    }
    
    @RequestMapping(value="/getPlantHead", method=RequestMethod.GET)
    @ResponseBody
    public List<CapexProposal> getPlantHead(
            @RequestParam("plant_code") String plantCode,
            @RequestParam("department") String department)
    {

    	 List<CapexProposal> capexList = null;
         try {
         	capexList = capexService.getPlantHead(plantCode,department);
         } catch (Exception e) {
             e.printStackTrace();
             logger.error("getCapexList : " + e.getMessage());
         }
         return capexList;

    }
    
    @RequestMapping(value = "/submit", method = {RequestMethod.POST, RequestMethod.GET})
    public String submitCapex(
            @RequestParam("capex_title") String capexTitle,
            @RequestParam("department") String department,
            @RequestParam("business_unit") String businessUnit,
            @RequestParam("plant_code") String plantCode,
            @RequestParam("location") String location,
            @RequestParam("asset_description") String assetDescription,

            @RequestParam("basic_cost") String basicCostStr,
            @RequestParam("gst_rate") String gstRateStr,
            @RequestParam("gst_amount") String gstAmountStr,
            @RequestParam("total_cost") String totalCostStr,

            @RequestParam("roi_text") String roiText,
            @RequestParam("timeline_text") String timelineText,
            @RequestParam("reason_text") String reasonText,

            @RequestParam(value = "roiFile", required = false) MultipartFile roiFile,
            @RequestParam(value = "timelineFile", required = false) MultipartFile timelineFile,
            @RequestParam(value = "reasonFile", required = false) MultipartFile reasonFile,

            @RequestParam(value = "prepared_by_signature_path", required = false) MultipartFile preparedSignature,
            @RequestParam(value = "project_manager_signature_path", required = false) MultipartFile pmSignature,
            @RequestParam(value = "requested_by_signature_path", required = false) MultipartFile requestedSignature,
            @RequestParam(value = "head_of_plant_signature_path", required = false) MultipartFile headSignature,

            @RequestParam(value = "prepared_by_name", required = false) String preparedByName,
            @RequestParam(value = "prepared_by_designation", required = false) String preparedByDesignation,
            @RequestParam(value = "prepared_by_date", required = false) String preparedByDate,

            @RequestParam(value = "project_manager_name", required = false) String projectManagerName,
            @RequestParam(value = "project_manager_designation", required = false) String projectManagerDesignation,
            @RequestParam(value = "project_manager_date", required = false) String projectManagerDate,

            @RequestParam(value = "requested_by_name", required = false) String requestedByName,
            @RequestParam(value = "requested_by_designation", required = false) String requestedByDesignation,
            @RequestParam(value = "requested_by_date", required = false) String requestedByDate,

            @RequestParam(value = "head_of_plant_name", required = false) String headOfPlantName,
            @RequestParam(value = "head_of_plant_designation", required = false) String headOfPlantDesignation,
            @RequestParam(value = "head_of_plant_date", required = false) String headOfPlantDate,
            // Add finance, head_projects, business_head, cfo, ceo fields here if needed

            RedirectAttributes redirectAttributes,HttpSession session
    ) {
    	String userId = null;
        try {
        	userId = (String) session.getAttribute("USER_ID");
     

            CapexProposal saved = capexService.submitCapex(
                    capexTitle, department, businessUnit, plantCode, location, assetDescription,
                    basicCostStr, gstRateStr, gstAmountStr, totalCostStr,
                    roiText, timelineText, reasonText,
                    roiFile, timelineFile, reasonFile,
                    preparedSignature, pmSignature, requestedSignature, headSignature,
                    preparedByName, preparedByDesignation, preparedByDate,
                    projectManagerName, projectManagerDesignation, projectManagerDate,
                    requestedByName, requestedByDesignation, requestedByDate,
                    headOfPlantName, headOfPlantDesignation, headOfPlantDate,userId
            );

            redirectAttributes.addFlashAttribute("successMessage", 
                "CAPEX submitted successfully with number: " + saved.getCapex_number());

            return "redirect:/form/capex";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Submission failed: " + e.getMessage());
            return "redirect:/capex/new";
        }
    }
    
    @RequestMapping(value = "/update", method = {RequestMethod.POST, RequestMethod.GET})
    public String updateCapex(
            @RequestParam("capex_title") String capexTitle,
            @RequestParam("capex_number") String capex_number,
            @RequestParam("id") String id,
            @RequestParam("department") String department,
            @RequestParam("business_unit") String businessUnit,
            @RequestParam("plant_code") String plantCode,
            @RequestParam("location") String location,
            @RequestParam("asset_description") String assetDescription,

            @RequestParam("basic_cost") String basicCostStr,
            @RequestParam("gst_rate") String gstRateStr,
            @RequestParam("gst_amount") String gstAmountStr,
            @RequestParam("total_cost") String totalCostStr,

            @RequestParam("roi_text") String roiText,
            @RequestParam("timeline_text") String timelineText,
            @RequestParam("reason_text") String reasonText,

            @RequestParam(value = "roiFile", required = false) MultipartFile roiFile,
            @RequestParam(value = "timelineFile", required = false) MultipartFile timelineFile,
            @RequestParam(value = "reasonFile", required = false) MultipartFile reasonFile,
            
            @RequestParam(value = "roi_file_name", required = false) String roi_file_name,
            @RequestParam(value = "timeline_file_name", required = false) String timeline_file_name,
            @RequestParam(value = "reason_file_name", required = false) String reason_file_name,

            @RequestParam(value = "prepared_by_signature_path", required = false) MultipartFile preparedSignature,
            @RequestParam(value = "project_manager_signature_path", required = false) MultipartFile pmSignature,
            @RequestParam(value = "requested_by_signature_path", required = false) MultipartFile requestedSignature,
            @RequestParam(value = "head_of_plant_signature_path", required = false) MultipartFile headSignature,

            @RequestParam(value = "prepared_by_name", required = false) String preparedByName,
            @RequestParam(value = "prepared_by_designation", required = false) String preparedByDesignation,
            @RequestParam(value = "prepared_by_date", required = false) String preparedByDate,

            @RequestParam(value = "project_manager_name", required = false) String projectManagerName,
            @RequestParam(value = "project_manager_designation", required = false) String projectManagerDesignation,
            @RequestParam(value = "project_manager_date", required = false) String projectManagerDate,

            @RequestParam(value = "requested_by_name", required = false) String requestedByName,
            @RequestParam(value = "requested_by_designation", required = false) String requestedByDesignation,
            @RequestParam(value = "requested_by_date", required = false) String requestedByDate,

            @RequestParam(value = "head_of_plant_name", required = false) String headOfPlantName,
            @RequestParam(value = "head_of_plant_designation", required = false) String headOfPlantDesignation,
            @RequestParam(value = "head_of_plant_date", required = false) String headOfPlantDate,
            
            @RequestParam(value = "finance_department", required = false) String financeDepartment,
            @RequestParam(value = "finance_category", required = false) String financeCategory,
            @RequestParam(value = "total_budget", required = false) String totalBudget,
            @RequestParam(value = "proposed_price", required = false) String proposedPrice,
            @RequestParam(value = "available_balance", required = false) String availableBalance,
            @RequestParam(value = "finance_status", required = false) String financeStatus,
            @RequestParam(value = "finance_name", required = false) String financeName,
            @RequestParam(value = "finance_designation", required = false) String financeDesignation,
            @RequestParam(value = "finance_date", required = false) String financeDate,
            @RequestParam(value = "finance_comments", required = false) String financeComments,
            // Add finance, head_projects, business_head, cfo, ceo fields here if needed
            @RequestParam(value = "head_projects_name", required = false) String headProjectsName,
            @RequestParam(value = "head_projects_date", required = false) String headProjectsDate,
            @RequestParam(value = "head_projects_comment", required = false) String headProjectsComment,
            @RequestParam(value = "business_head_name", required = false) String businessHeadName,
            @RequestParam(value = "business_head_date", required = false) String businessHeadDate,
            @RequestParam(value = "business_head_comment", required = false) String businessHeadComment,
         // CFO
            @RequestParam(value = "cfo_name", required = false) String cfoName,
            @RequestParam(value = "cfo_date", required = false) String cfoDate,
            @RequestParam(value = "cfo_comment", required = false) String cfoComment,
            @RequestParam(value = "ceo_name", required = false) String ceoName,
            @RequestParam(value = "ceo_date", required = false) String ceoDate,
            @RequestParam(value = "ceo_comment", required = false) String ceoComment,
            @RequestParam(value = "regional_director_name", required = false) String regional_director_name,
            @RequestParam(value = "regional_director_date", required = false) String regional_director_date,
            @RequestParam(value = "current_pending_at", required = false) String current_pending_at,
            @RequestParam(value = "finance_controller_name", required = false) String finance_controller_name,
            
            @RequestParam(value = "finance_controller_date", required = false) String finance_controller_date,
            @RequestParam(value = "finance_controller_comment", required = false) String finance_controller_comment,
            @RequestParam(value = "regional_director_comment", required = false) String regional_director_comment,
            @RequestParam(value = "remarks", required = false) String remarks,

            RedirectAttributes redirectAttributes,HttpSession session
    ) {
    	String userId = null;
        try {
        	userId = (String) session.getAttribute("USER_ID");
   

            CapexProposal saved = capexService.updateCapex(remarks,regional_director_comment,finance_controller_name,finance_controller_comment,current_pending_at,
            		regional_director_name,regional_director_date,
            		capexTitle,
            		capex_number,
            		id,
            		department,
            		businessUnit,
            		plantCode,
            		location,
            		assetDescription,

            		basicCostStr,
            		gstRateStr,
            		gstAmountStr,
            		totalCostStr,

            		roiText,
            		timelineText,
            		reasonText,

            		roiFile,
            		timelineFile,
            		reasonFile,

            		preparedSignature,
            		pmSignature,
            		requestedSignature,
            		headSignature,

            		preparedByName,
            		preparedByDesignation,
            		preparedByDate,

            		projectManagerName,
            		projectManagerDesignation,
            		projectManagerDate,

            		requestedByName,
            		requestedByDesignation,
            		requestedByDate,

            		headOfPlantName,
            		headOfPlantDesignation,
            		headOfPlantDate,

            		userId,
            		roi_file_name,
            		timeline_file_name,
            		reason_file_name,


            		/* ================= FINANCE ================= */

            		financeDepartment,
            		financeCategory,
            		totalBudget,
            		proposedPrice,
            		availableBalance,
            		financeStatus,
            		financeName,
            		financeDesignation,
            		financeDate,
            		financeComments,


            		/* ================= HEAD PROJECT ================= */

            		headProjectsName,
            		headProjectsDate,
            		headProjectsComment,


            		/* ================= BUSINESS HEAD ================= */

            		businessHeadName,
            		businessHeadDate,
            		businessHeadComment,


            		/* ================= CFO ================= */

            		cfoName,
            		cfoDate,
            		cfoComment,


            		/* ================= CEO ================= */

            		ceoName,
            		ceoDate,
            		ceoComment



            );

            redirectAttributes.addFlashAttribute("successMessage", 
                "CAPEX Updated successfully with number: " + saved.getCapex_number());

            return "redirect:/form/capex";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Submission failed: " + e.getMessage());
            return "redirect:/capex/new";
        }
    }

    private BigDecimal safeBigDecimal(String val) {
        if (val == null || val.trim().isEmpty()) return BigDecimal.ZERO;
        try {
            return new BigDecimal(val.trim());
        } catch (Exception e) {
            return BigDecimal.ZERO;
        }
    }
    /**
     * Helper: Save MultipartFile with automatic extension
     */
    private void saveMultipartFile(MultipartFile file, String basePathWithoutExt) throws IOException {
        if (file == null || file.isEmpty()) {
            return;
        }

        String originalFilename = file.getOriginalFilename();
        String extension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }

        String finalPath = basePathWithoutExt + extension;
        File dest = new File(finalPath);

        // Optional: overwrite or add timestamp if file already exists
        if (dest.exists()) {
            String timestamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
            finalPath = basePathWithoutExt + "_" + timestamp + extension;
            dest = new File(finalPath);
        }

        file.transferTo(dest);

        // Optional: update entity with file path (e.g. relative path for DB)
        // Example: c.setRoi_file_path("/capex/resources/Attachments/" + capexNumber + "/roi_document" + extension);
    }
}
