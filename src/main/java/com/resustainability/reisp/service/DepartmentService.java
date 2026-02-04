package com.resustainability.reisp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.resustainability.reisp.dao.DepartmentDao;
import com.resustainability.reisp.model.Department;

@Service
public class DepartmentService {
    
    @Autowired
    DepartmentDao dao;

    // Get all departments with filtering
    public List<Department> getDepartmentsList(Department obj) throws Exception {
        return dao.getDepartmentsList(obj);
    }

    // Add new department
    public boolean addDepartment(Department obj) throws Exception {
        return dao.addDepartment(obj);
    }

    // Update existing department
    public boolean updateDepartment(Department obj) throws Exception {
        return dao.updateDepartment(obj);
    }

    // Delete department by ID
    public boolean deleteDepartment(String id) throws Exception {
        return dao.deleteDepartment(id);
    }

    // Get department by ID
    public Department getDepartmentById(String id) throws Exception {
        return dao.getDepartmentById(id);
    }

    // Check if department code already exists (for unique validation)
    public List<Department> checkUniqueIfForDept(Department obj) throws Exception {
        return dao.checkUniqueIfForDept(obj);
    }

    // Get distinct SBU list
    public List<Department> getSBUList() throws Exception {
        return dao.getSBUList();
    }

    // Get distinct plant codes
    public List<Department> getPlantList() throws Exception {
        return dao.getPlantList();
    }

    // Get status filter list
    public List<Department> getStatusFilterList() throws Exception {
        return dao.getStatusFilterList();
    }
}