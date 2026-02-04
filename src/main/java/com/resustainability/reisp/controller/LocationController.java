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
import com.resustainability.reisp.model.Location;
import com.resustainability.reisp.model.User;
import com.resustainability.reisp.service.LocationService;

@Controller
public class LocationController {

    @InitBinder
    public void initBinder(WebDataBinder binder) { 
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }
    
    Logger logger = Logger.getLogger(LocationController.class);
    
    @Autowired
    LocationService service;
    
    /**
     * Display Location management page
     */
    @RequestMapping(value = "/location", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView location(@ModelAttribute User user, HttpSession session) {
        ModelAndView model = new ModelAndView(PageConstants.location);
        try {
            // Check session
            String userId = (String) session.getAttribute("USER_ID");
            String userName = (String) session.getAttribute("USER_NAME");
            
            if (userId == null) {
                model.setViewName("redirect:/login");
                return model;
            }
            
            // Add user info to model
            model.addObject("userName", userName);
            model.addObject("userId", userId);
            
            logger.info("Location page loaded successfully for user: " + userName);
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("Error loading Location page: " + e.getMessage());
            model.addObject("error", "Error loading page: " + e.getMessage());
        }
        return model;
    }
    
    /**
     * Get all locations list (AJAX)
     */
    @RequestMapping(value = "/ajax/getLocationList", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<Location> getLocationList(@ModelAttribute Location obj, HttpSession session) {
        List<Location> locationList = null;
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                return null;
            }
            
            locationList = service.getLocationsList(obj);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getLocationList : " + e.getMessage());
        }
        return locationList;
    }
    
    /**
     * Get location by ID (AJAX)
     */
    @RequestMapping(value = "/ajax/getLocationById/{id}", method = {RequestMethod.GET}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Location getLocationById(@PathVariable("id") String id, HttpSession session) {
        Location location = null;
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                return null;
            }
            
            location = service.getLocationById(id);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getLocationById : " + e.getMessage());
        }
        return location;
    }
    
    /**
     * Get active locations for dropdown (AJAX)
     */
    @RequestMapping(value = "/ajax/getActiveLocations", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<Location> getActiveLocations(HttpSession session) {
        List<Location> locationList = null;
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                return null;
            }
            
            locationList = service.getActiveLocations();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getActiveLocations : " + e.getMessage());
        }
        return locationList;
    }
    
    /**
     * Check if location name is unique (AJAX)
     */
    @RequestMapping(value = "/ajax/checkUniqueLocation", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public boolean checkUniqueLocation(@ModelAttribute Location obj, HttpSession session) {
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                return false;
            }
            
            String excludeId = obj.getId();
            return service.isLocationUnique(obj.getLocation(), excludeId);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("checkUniqueLocation : " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Get status filter list for location
     */
    @RequestMapping(value = "/ajax/getLocationStatusFilterList", method = {RequestMethod.GET, RequestMethod.POST}, 
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<String> getLocationStatusFilterList(HttpSession session) {
        List<String> statusList = null;
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                return null;
            }
            
            statusList = service.getStatusFilterList();
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("getLocationStatusFilterList : " + e.getMessage());
        }
        return statusList;
    }
    
    /**
     * Add new location
     */
    @RequestMapping(value = "/location/add", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView addLocation(@ModelAttribute Location obj, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/location");
            
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                attributes.addFlashAttribute("error", "Session expired. Please login again.");
                model.setViewName("redirect:/login");
                return model;
            }
            
            // Validate required fields
            if (obj.getLocation() == null || obj.getLocation().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Location name is required.");
                return model;
            }
            
            if (obj.getStatus() == null || obj.getStatus().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Status is required.");
                return model;
            }
            
            // Check if location already exists
            boolean isUnique = service.isLocationUnique(obj.getLocation(), null);
            if (!isUnique) {
                attributes.addFlashAttribute("error", "Location name already exists.");
                return model;
            }
            
            boolean flag = service.addLocation(obj);
            if (flag) {
                attributes.addFlashAttribute("success", "Location added successfully.");
                logger.info("Location added successfully: " + obj.getLocation() + " by user: " + userId);
            } else {
                attributes.addFlashAttribute("error", "Failed to add location. Please try again.");
                logger.warn("Failed to add location: " + obj.getLocation());
            }
            
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Error adding location: " + e.getMessage());
            e.printStackTrace();
            logger.error("addLocation : " + e.getMessage());
        }
        return model;
    }
    
    /**
     * Update existing location
     */
    @RequestMapping(value = "/location/update", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView updateLocation(@ModelAttribute Location obj, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/location");
            
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                attributes.addFlashAttribute("error", "Session expired. Please login again.");
                model.setViewName("redirect:/login");
                return model;
            }
            
            // Validate required fields
            if (obj.getId() == null || obj.getId().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Location ID is required for update.");
                return model;
            }
            
            if (obj.getLocation() == null || obj.getLocation().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Location name is required.");
                return model;
            }
            
            if (obj.getStatus() == null || obj.getStatus().trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Status is required.");
                return model;
            }
            
            // Check if location already exists for another record
            boolean isUnique = service.isLocationUnique(obj.getLocation(), obj.getId());
            if (!isUnique) {
                attributes.addFlashAttribute("error", "Location name already exists for another record.");
                return model;
            }
            
            boolean flag = service.updateLocation(obj);
            if (flag) {
                attributes.addFlashAttribute("success", "Location updated successfully.");
                logger.info("Location updated successfully. ID: " + obj.getId() + " by user: " + userId);
            } else {
                attributes.addFlashAttribute("error", "Failed to update location. Please try again.");
                logger.warn("Failed to update location. ID: " + obj.getId());
            }
            
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Error updating location: " + e.getMessage());
            e.printStackTrace();
            logger.error("updateLocation : " + e.getMessage());
        }
        return model;
    }
    
    /**
     * Delete location
     */
    @RequestMapping(value = "/location/delete/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView deleteLocation(@PathVariable("id") String id, RedirectAttributes attributes, HttpSession session) {
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("redirect:/location");
            
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                attributes.addFlashAttribute("error", "Session expired. Please login again.");
                model.setViewName("redirect:/login");
                return model;
            }
            
            if (id == null || id.trim().isEmpty()) {
                attributes.addFlashAttribute("error", "Location ID is required for deletion.");
                return model;
            }
            
            boolean flag = service.deleteLocation(id);
            if (flag) {
                attributes.addFlashAttribute("success", "Location deleted successfully.");
                logger.info("Location deleted successfully. ID: " + id + " by user: " + userId);
            } else {
                attributes.addFlashAttribute("error", "Failed to delete location. Please try again.");
                logger.warn("Failed to delete location. ID: " + id);
            }
            
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Error deleting location: " + e.getMessage());
            e.printStackTrace();
            logger.error("deleteLocation : " + e.getMessage());
        }
        return model;
    }
}