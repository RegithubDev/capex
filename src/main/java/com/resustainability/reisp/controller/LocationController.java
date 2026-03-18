package com.resustainability.reisp.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
            String userId = (String) session.getAttribute("USER_ID");
            String userName = (String) session.getAttribute("USER_NAME");
            
            if (userId == null) {
                model.setViewName("redirect:/login");
                return model;
            }
            
            model.addObject("userName", userName);
            model.addObject("userId", userId);
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("Error loading Location page: " + e.getMessage());
        }
        return model;
    }
    
    @RequestMapping(value = "/ajax/getLocationList", method = {RequestMethod.GET, RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<Location> getLocationList(@ModelAttribute Location obj, HttpSession session) {
        try {
            if (session.getAttribute("USER_ID") == null) return null;
            return service.getLocationsList(obj);
        } catch (Exception e) {
            logger.error("getLocationList : " + e.getMessage());
            return null;
        }
    }
    
    @RequestMapping(value = "/ajax/getLocationById/{id}", method = {RequestMethod.GET}, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Location getLocationById(@PathVariable("id") String id, HttpSession session) {
        try {
            if (session.getAttribute("USER_ID") == null) return null;
            return service.getLocationById(id);
        } catch (Exception e) {
            logger.error("getLocationById : " + e.getMessage());
            return null;
        }
    }
    
    @RequestMapping(value = "/ajax/getActiveLocations", method = {RequestMethod.GET, RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<Location> getActiveLocations(HttpSession session) {
        try {
            if (session.getAttribute("USER_ID") == null) return null;
            return service.getActiveLocations();
        } catch (Exception e) {
            logger.error("getActiveLocations : " + e.getMessage());
            return null;
        }
    }
    
    @RequestMapping(value = "/ajax/checkUniqueLocation", method = {RequestMethod.GET, RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public boolean checkUniqueLocation(@ModelAttribute Location obj, HttpSession session) {
        try {
            if (session.getAttribute("USER_ID") == null) return false;
            return service.isLocationUnique(obj.getLocation(), obj.getId());
        } catch (Exception e) {
            logger.error("checkUniqueLocation : " + e.getMessage());
            return false;
        }
    }
    
    @RequestMapping(value = "/ajax/getLocationStatusFilterList", method = {RequestMethod.GET, RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<String> getLocationStatusFilterList(HttpSession session) {
        try {
            if (session.getAttribute("USER_ID") == null) return null;
            return service.getStatusFilterList();
        } catch (Exception e) {
            logger.error("getLocationStatusFilterList : " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Add new location (Returns JSON)
     */
    @RequestMapping(value = "/location/add", method = {RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, String> addLocation(@ModelAttribute Location obj, HttpSession session) {
        Map<String, String> response = new HashMap<>();
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                response.put("status", "error");
                response.put("message", "Session expired. Please login again.");
                return response;
            }
            
            if (obj.getLocation() == null || obj.getLocation().trim().isEmpty()) {
                response.put("status", "error");
                response.put("message", "Location name is required.");
                return response;
            }
            
            boolean isUnique = service.isLocationUnique(obj.getLocation(), null);
            if (!isUnique) {
                response.put("status", "error");
                response.put("message", "Location name already exists.");
                return response;
            }
            
            // Set Created By and Date
            obj.setCreated_by(userId);
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            obj.setCreated_date(formatter.format(new Date()));
            
            boolean flag = service.addLocation(obj);
            if (flag) {
                response.put("status", "success");
                response.put("message", "Location added successfully.");
            } else {
                response.put("status", "error");
                response.put("message", "Failed to add location.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Database Error: " + e.getMessage());
            logger.error("addLocation : " + e.getMessage(), e);
        }
        return response;
    }
    
    /**
     * Update existing location (Returns JSON)
     */
    @RequestMapping(value = "/location/update", method = {RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, String> updateLocation(@ModelAttribute Location obj, HttpSession session) {
        Map<String, String> response = new HashMap<>();
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                response.put("status", "error");
                response.put("message", "Session expired. Please login again.");
                return response;
            }
            
            if (obj.getId() == null || obj.getId().trim().isEmpty()) {
                response.put("status", "error");
                response.put("message", "Location ID is required for update.");
                return response;
            }
            
            boolean isUnique = service.isLocationUnique(obj.getLocation(), obj.getId());
            if (!isUnique) {
                response.put("status", "error");
                response.put("message", "Location name already exists for another record.");
                return response;
            }
            
            // Set Modified By and Date
            obj.setModified_by(userId);
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            obj.setModified_date(formatter.format(new Date()));
            
            boolean flag = service.updateLocation(obj);
            if (flag) {
                response.put("status", "success");
                response.put("message", "Location updated successfully.");
            } else {
                response.put("status", "error");
                response.put("message", "Failed to update location.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Database Error: " + e.getMessage());
            logger.error("updateLocation : " + e.getMessage(), e);
        }
        return response;
    }
    
    /**
     * Delete location (Returns JSON)
     */
    @RequestMapping(value = "/location/delete/{id}", method = {RequestMethod.POST}, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, String> deleteLocation(@PathVariable("id") String id, HttpSession session) {
        Map<String, String> response = new HashMap<>();
        try {
            String userId = (String) session.getAttribute("USER_ID");
            if (userId == null) {
                response.put("status", "error");
                response.put("message", "Session expired.");
                return response;
            }
            
            boolean flag = service.deleteLocation(id);
            if (flag) {
                response.put("status", "success");
                response.put("message", "Location deleted successfully.");
            } else {
                response.put("status", "error");
                response.put("message", "Failed to delete location.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Database Error: " + e.getMessage());
            logger.error("deleteLocation : " + e.getMessage(), e);
        }
        return response;
    }
}