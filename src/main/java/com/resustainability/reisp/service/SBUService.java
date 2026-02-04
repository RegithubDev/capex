package com.resustainability.reisp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.resustainability.reisp.dao.SBUDao;
import com.resustainability.reisp.model.SBU;

@Service
public class SBUService {
    
    @Autowired
    SBUDao dao;

    /**
     * Get all SBUs with optional filters
     */
    public List<SBU> getSBUsList(SBU obj) throws Exception {
        return dao.getSBUsList(obj);
    }

    /**
     * Get SBU by ID
     */
    public SBU getSBUById(String id) throws Exception {
        return dao.getSBUById(id);
    }

    /**
     * Add new SBU
     */
    public boolean addSBU(SBU obj) throws Exception {
        return dao.addSBU(obj);
    }

    /**
     * Update existing SBU
     */
    public boolean updateSBU(SBU obj) throws Exception {
        return dao.updateSBU(obj);
    }

    /**
     * Delete SBU
     */
    public boolean deleteSBU(String id) throws Exception {
        return dao.deleteSBU(id);
    }

    /**
     * Get active SBUs for dropdown
     */
    public List<SBU> getActiveSBUs() throws Exception {
        return dao.getActiveSBUs();
    }

    /**
     * Get SBU statistics
     */
    public SBU getSBUStatistics() throws Exception {
        return dao.getSBUStatistics();
    }

    /**
     * Check if SBU code is unique
     */
    public boolean isSBUCodeUnique(String sbuCode, String excludeId) throws Exception {
        return dao.isSBUCodeUnique(sbuCode, excludeId);
    }

    /**
     * Get status filter list
     */
    public List<String> getStatusFilterList() throws Exception {
        return dao.getStatusFilterList();
    }

    /**
     * Search SBUs with pagination
     */
    public List<SBU> searchSBUsWithPagination(SBU obj, int page, int pageSize) throws Exception {
        return dao.searchSBUsWithPagination(obj, page, pageSize);
    }

    /**
     * Count total SBUs for pagination
     */
    public int countSBUs(SBU obj) throws Exception {
        return dao.countSBUs(obj);
    }
  
}