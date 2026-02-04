package com.resustainability.reisp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.resustainability.reisp.dao.LocationDao;
import com.resustainability.reisp.model.Location;

@Service
public class LocationService {
    
    @Autowired
    LocationDao dao;

    /**
     * Get all locations with optional filters
     */
    public List<Location> getLocationsList(Location obj) throws Exception {
        return dao.getLocationsList(obj);
    }

    /**
     * Get location by ID
     */
    public Location getLocationById(String id) throws Exception {
        return dao.getLocationById(id);
    }

    /**
     * Get active locations for dropdown
     */
    public List<Location> getActiveLocations() throws Exception {
        return dao.getActiveLocations();
    }

    /**
     * Check if location name is unique
     */
    public boolean isLocationUnique(String locationName, String excludeId) throws Exception {
        return dao.isLocationUnique(locationName, excludeId);
    }

    /**
     * Get status filter list
     */
    public List<String> getStatusFilterList() throws Exception {
        return dao.getStatusFilterList();
    }

    /**
     * Add new location
     */
    public boolean addLocation(Location obj) throws Exception {
        return dao.addLocation(obj);
    }

    /**
     * Update existing location
     */
    public boolean updateLocation(Location obj) throws Exception {
        return dao.updateLocation(obj);
    }

    /**
     * Delete location
     */
    public boolean deleteLocation(String id) throws Exception {
        return dao.deleteLocation(id);
    }
}