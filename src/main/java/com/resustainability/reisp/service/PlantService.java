package com.resustainability.reisp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.resustainability.reisp.dao.PlantDao;
import com.resustainability.reisp.model.Plant;

@Service
public class PlantService {
    
    @Autowired
    PlantDao dao;

    /**
     * Get all plants with optional filters
     */
    public List<Plant> getPlantsList(Plant obj) throws Exception {
        return dao.getPlantsList(obj);
    }

    /**
     * Get plant by ID
     */
    public Plant getPlantById(String id) throws Exception {
        return dao.getPlantById(id);
    }

    /**
     * Add new plant
     */
    public boolean addPlant(Plant obj) throws Exception {
        return dao.addPlant(obj);
    }

    /**
     * Update existing plant
     */
    public boolean updatePlant(Plant obj) throws Exception {
        return dao.updatePlant(obj);
    }

    /**
     * Delete plant
     */
    public boolean deletePlant(String id) throws Exception {
        return dao.deletePlant(id);
    }

    /**
     * Get active plants for dropdown
     */
    public List<Plant> getActivePlants() throws Exception {
        return dao.getActivePlants();
    }

    /**
     * Get plant statistics
     */
    public Plant getPlantStatistics() throws Exception {
        return dao.getPlantStatistics();
    }

    /**
     * Check if plant code is unique
     */
    public boolean isPlantCodeUnique(String plantCode, String excludeId) throws Exception {
        return dao.isPlantCodeUnique(plantCode, excludeId);
    }

    /**
     * Get status filter list
     */
    public List<String> getStatusFilterList() throws Exception {
        return dao.getStatusFilterList();
    }

    /**
     * Get SBU filter list
     */
    public List<String> getSBUFilterList() throws Exception {
        return dao.getSBUFilterList();
    }

    /**
     * Get location filter list
     */
    public List<String> getLocationFilterList() throws Exception {
        return dao.getLocationFilterList();
    }

    /**
     * Search plants with pagination
     */
    public List<Plant> searchPlantsWithPagination(Plant obj, int page, int pageSize) throws Exception {
        return dao.searchPlantsWithPagination(obj, page, pageSize);
    }

    /**
     * Count total plants for pagination
     */
    public int countPlants(Plant obj) throws Exception {
        return dao.countPlants(obj);
    }

    /**
     * Get plants by SBU
     */
    public List<Plant> getPlantsBySBU(String sbu) throws Exception {
        return dao.getPlantsBySBU(sbu);
    }

    /**
     * Validate plant data
     */
    public boolean validatePlantData(Plant plant) throws Exception {
        return dao.validatePlantData(plant);
    }
}