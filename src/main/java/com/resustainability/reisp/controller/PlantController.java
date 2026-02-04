package com.resustainability.reisp.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.resustainability.reisp.model.Plant;
import com.resustainability.reisp.model.User;
import com.resustainability.reisp.service.PlantService;

@Controller
public class PlantController {
    
    @InitBinder
    public void initBinder(WebDataBinder binder) { 
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }
    
    Logger logger = Logger.getLogger(PlantController.class);
    
    @Autowired
    PlantService service;
    
   
    @RequestMapping(value = "/plant", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView plant(@ModelAttribute User user, HttpSession session) {
        ModelAndView model = new ModelAndView(PageConstants.plant); // Make sure PageConstants has "plant"
        try {
           
        } catch (Exception e) { 
            logger.error("Error loading plant page: " + e.getMessage(), e);
            e.printStackTrace();
        }
        return model;
    }
    
    /**
     * Get all plants list (AJAX)
     */
    @RequestMapping(value = "/ajax/getPlantList", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<Plant> getPlantList(@ModelAttribute Plant obj, HttpSession session) {
        List<Plant> plantList = null;
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                logger.warn("Unauthorized access attempt to get plant list");
                return null;
            }
            
            plantList = service.getPlantsList(obj);
            logger.info("Plant list loaded successfully. Count: " + (plantList != null ? plantList.size() : 0));
        } catch (Exception e) {
            logger.error("getPlantList : " + e.getMessage(), e);
            e.printStackTrace();
        }
        return plantList;
    }
    
    /**
     * Get plant by ID (AJAX)
     */
    @RequestMapping(value = "/ajax/getPlantById/{id}", method = {RequestMethod.GET}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Plant getPlantById(@PathVariable("id") String id, HttpSession session) {
        Plant plant = null;
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                logger.warn("Unauthorized access attempt to get plant by ID");
                return null;
            }
            
            plant = service.getPlantById(id);
            logger.info("Plant loaded by ID: " + id);
        } catch (Exception e) {
            logger.error("getPlantById : " + e.getMessage(), e);
            e.printStackTrace();
        }
        return plant;
    }
    
    /**
     * Get active plants for dropdown (AJAX)
     */
    @RequestMapping(value = "/ajax/getActivePlants", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<Plant> getActivePlants(HttpSession session) {
        List<Plant> plantList = null;
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                logger.warn("Unauthorized access attempt to get active plants");
                return null;
            }
            
            plantList = service.getActivePlants();
            logger.info("Active plants loaded successfully");
        } catch (Exception e) {
            logger.error("getActivePlants : " + e.getMessage(), e);
            e.printStackTrace();
        }
        return plantList;
    }
    
    /**
     * Get plant statistics (AJAX)
     */
    @RequestMapping(value = "/ajax/getPlantStatistics", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Plant getPlantStatistics(HttpSession session) {
        Plant stats = new Plant();
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                logger.warn("Unauthorized access attempt to get plant statistics");
                return stats;
            }
            
            stats = service.getPlantStatistics();
            logger.info("Plant statistics loaded");
        } catch (Exception e) {
            logger.error("getPlantStatistics : " + e.getMessage(), e);
            e.printStackTrace();
        }
        return stats;
    }
    
    /**
     * Check if plant code is unique (AJAX)
     */
    @RequestMapping(value = "/ajax/checkUniquePlantCode", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public boolean checkUniquePlantCode(@ModelAttribute Plant obj, HttpSession session) {
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                logger.warn("Unauthorized access attempt to check plant code uniqueness");
                return false;
            }
            
            String excludeId = obj.getId();
            return service.isPlantCodeUnique(obj.getPlant_code(), excludeId);
        } catch (Exception e) {
            logger.error("checkUniquePlantCode : " + e.getMessage(), e);
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Get status filter list for plants (AJAX)
     */
    @RequestMapping(value = "/ajax/getPlantStatusFilterList", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<String> getPlantStatusFilterList(HttpSession session) {
        List<String> statusList = null;
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                logger.warn("Unauthorized access attempt to get status filter list");
                return null;
            }
            
            statusList = service.getStatusFilterList();
            logger.info("Status filter list loaded");
        } catch (Exception e) {
            logger.error("getPlantStatusFilterList : " + e.getMessage(), e);
            e.printStackTrace();
        }
        return statusList;
    }
    
    /**
     * Get SBU filter list for plants (AJAX)
     */
    @RequestMapping(value = "/ajax/getPlantSBUFilterList", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<String> getPlantSBUFilterList(HttpSession session) {
        List<String> sbuList = null;
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                logger.warn("Unauthorized access attempt to get SBU filter list");
                return null;
            }
            
            sbuList = service.getSBUFilterList();
            logger.info("SBU filter list loaded");
        } catch (Exception e) {
            logger.error("getPlantSBUFilterList : " + e.getMessage(), e);
            e.printStackTrace();
        }
        return sbuList;
    }
    
    /**
     * Get location filter list for plants (AJAX)
     */
    @RequestMapping(value = "/ajax/getPlantLocationFilterList", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<String> getPlantLocationFilterList(HttpSession session) {
        List<String> locationList = null;
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                logger.warn("Unauthorized access attempt to get location filter list");
                return null;
            }
            
            locationList = service.getLocationFilterList();
            logger.info("Location filter list loaded");
        } catch (Exception e) {
            logger.error("getPlantLocationFilterList : " + e.getMessage(), e);
            e.printStackTrace();
        }
        return locationList;
    }
    
    /**
     * Add new plant
     */
    @RequestMapping(value = "/plant/add", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView addPlant(@ModelAttribute Plant obj, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/plant");
            
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                attributes.addFlashAttribute("error", "Session expired. Please login again.");
                model.setViewName("redirect:/login");
                return model;
            }
            
            // Validate required fields
            if (obj.getLocation() == null || obj.getLocation().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Location is required.");
                return model;
            }
            
            if (obj.getSbu() == null || obj.getSbu().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "SBU is required.");
                return model;
            }
            
            if (obj.getPlant_code() == null || obj.getPlant_code().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Plant Code is required.");
                return model;
            }
            
            if (obj.getPlant_name() == null || obj.getPlant_name().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Plant Name is required.");
                return model;
            }
            
            if (obj.getStatus() == null || obj.getStatus().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Status is required.");
                return model;
            }
            
            // Check if plant code already exists
            boolean isUnique = service.isPlantCodeUnique(obj.getPlant_code(), null);
            if (!isUnique) {
                attributes.addFlashAttribute("error", "Plant Code already exists.");
                return model;
            }
            
            boolean flag = service.addPlant(obj);
            if (flag) {
                attributes.addFlashAttribute("success", "Plant added successfully.");
                logger.info("Plant added successfully: " + obj.getPlant_code() + " by user: " + userId);
            } else {
                attributes.addFlashAttribute("error", "Failed to add plant. Please try again.");
                logger.warn("Failed to add plant: " + obj.getPlant_code());
            }
            
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Error adding plant: " + e.getMessage());
            logger.error("addPlant : " + e.getMessage(), e);
            e.printStackTrace();
        }
        return model;
    }
    
    /**
     * Update existing plant
     */
    @RequestMapping(value = "/plant/update", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView updatePlant(@ModelAttribute Plant obj, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/plant");
            
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                attributes.addFlashAttribute("error", "Session expired. Please login again.");
                model.setViewName("redirect:/login");
                return model;
            }
            
            // Validate required fields
            if (obj.getId() == null || obj.getId().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Plant ID is required for update.");
                return model;
            }
            
            if (obj.getLocation() == null || obj.getLocation().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Location is required.");
                return model;
            }
            
            if (obj.getSbu() == null || obj.getSbu().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "SBU is required.");
                return model;
            }
            
            if (obj.getPlant_code() == null || obj.getPlant_code().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Plant Code is required.");
                return model;
            }
            
            if (obj.getPlant_name() == null || obj.getPlant_name().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Plant Name is required.");
                return model;
            }
            
            if (obj.getStatus() == null || obj.getStatus().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Status is required.");
                return model;
            }
            
            // Check if plant code already exists for another record
            boolean isUnique = service.isPlantCodeUnique(obj.getPlant_code(), obj.getId());
            if (!isUnique) {
                attributes.addFlashAttribute("error", "Plant Code already exists for another record.");
                return model;
            }
            
            boolean flag = service.updatePlant(obj);
            if (flag) {
                attributes.addFlashAttribute("success", "Plant updated successfully.");
                logger.info("Plant updated successfully. ID: " + obj.getId() + " by user: " + userId);
            } else {
                attributes.addFlashAttribute("error", "Failed to update plant. Please try again.");
                logger.warn("Failed to update plant. ID: " + obj.getId());
            }
            
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Error updating plant: " + e.getMessage());
            logger.error("updatePlant : " + e.getMessage(), e);
            e.printStackTrace();
        }
        return model;
    }
    
    /**
     * Delete plant
     */
    @RequestMapping(value = "/plant/delete/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView deletePlant(@PathVariable("id") String id, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/plant");
            
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                attributes.addFlashAttribute("error", "Session expired. Please login again.");
                model.setViewName("redirect:/login");
                return model;
            }
            
            if (id == null || id.trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Plant ID is required for deletion.");
                return model;
            }
            
            boolean flag = service.deletePlant(id);
            if (flag) {
                attributes.addFlashAttribute("success", "Plant deleted successfully.");
                logger.info("Plant deleted successfully. ID: " + id + " by user: " + userId);
            } else {
                attributes.addFlashAttribute("error", "Failed to delete plant. Please try again.");
                logger.warn("Failed to delete plant. ID: " + id);
            }
            
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Error deleting plant: " + e.getMessage());
            logger.error("deletePlant : " + e.getMessage(), e);
            e.printStackTrace();
        }
        return model;
    }
    
    /**
     * Export plants to Excel (if needed)
     */
    @RequestMapping(value = "/plant/export", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView exportPlants(@ModelAttribute Plant obj, HttpSession session, RedirectAttributes attributes) {
        ModelAndView model = new ModelAndView("redirect:/plant");
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                attributes.addFlashAttribute("error", "Session expired. Please login again.");
                model.setViewName("redirect:/login");
                return model;
            }
            
            // Export functionality can be added here
            attributes.addFlashAttribute("info", "Export feature is under development.");
            logger.info("Export plants requested by user: " + userId);
            
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Error exporting plants: " + e.getMessage());
            logger.error("exportPlants : " + e.getMessage(), e);
            e.printStackTrace();
        }
        return model;
    }
}