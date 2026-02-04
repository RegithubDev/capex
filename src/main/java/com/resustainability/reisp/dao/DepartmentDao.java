package com.resustainability.reisp.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.util.StringUtils;

import com.resustainability.reisp.model.Department;

@Repository
public class DepartmentDao {
    
    @Autowired
    JdbcTemplate jdbcTemplate;
    
    @Autowired
    DataSource dataSource;

    @Autowired
    DataSourceTransactionManager transactionManager;

    // Get all departments with filtering
    public List<Department> getDepartmentsList(Department obj) throws Exception {
        List<Department> departmentsList = null;
        try {
            StringBuilder qry = new StringBuilder();
            List<Object> params = new ArrayList<>();
            
            qry.append("SELECT TOP (1000) [id], [sbu], [plant_code], ");
            qry.append("[department_code], [department_name], [status] ");
            qry.append("FROM [capexDB].[dbo].[department] ");
            qry.append("WHERE 1=1 ");
            
            if (obj != null) {
                if (!StringUtils.isEmpty(obj.getId())) {
                    qry.append("AND id = ? ");
                    params.add(obj.getId());
                }
                if (!StringUtils.isEmpty(obj.getSbu())) {
                    qry.append("AND sbu = ? ");
                    params.add(obj.getSbu());
                }
                if (!StringUtils.isEmpty(obj.getPlant_code())) {
                    qry.append("AND plant_code = ? ");
                    params.add(obj.getPlant_code());
                }
                if (!StringUtils.isEmpty(obj.getDepartment_code())) {
                    qry.append("AND department_code = ? ");
                    params.add(obj.getDepartment_code());
                }
                if (!StringUtils.isEmpty(obj.getDepartment_name())) {
                    qry.append("AND department_name LIKE ? ");
                    params.add("%" + obj.getDepartment_name() + "%");
                }
                if (!StringUtils.isEmpty(obj.getStatus())) {
                    qry.append("AND status = ? ");
                    params.add(obj.getStatus());
                }
            }
            
            qry.append("ORDER BY department_code ASC");
            
            departmentsList = jdbcTemplate.query(
                qry.toString(), 
                params.toArray(), 
                new BeanPropertyRowMapper<Department>(Department.class)
            );
            
        } catch(Exception e) { 
            e.printStackTrace();
            throw new Exception(e);
        }
        return departmentsList;
    }

    // Add new department
    public boolean addDepartment(Department obj) throws Exception {
        int count = 0;
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        
        try {
            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            String insertQry = "INSERT INTO [capexDB].[dbo].[department] " +
                               "([sbu], [plant_code], [department_code], [department_name], [status]) " +
                               "VALUES (:sbu, :plant_code, :department_code, :department_name, :status)";
            
            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);         
            count = namedParamJdbcTemplate.update(insertQry, paramSource);
            
            if(count > 0) {
                flag = true;
            }
            transactionManager.commit(status);
            
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception(e);
        }
        return flag;
    }

    // Update existing department
    public boolean updateDepartment(Department obj) throws Exception {
        int count = 0;
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        
        try {
            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            String updateQry = "UPDATE [capexDB].[dbo].[department] " +
                               "SET [sbu] = :sbu, " +
                               "[plant_code] = :plant_code, " +
                               "[department_code] = :department_code, " +
                               "[department_name] = :department_name, " +
                               "[status] = :status " +
                               "WHERE [id] = :id";
            
            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);         
            count = namedParamJdbcTemplate.update(updateQry, paramSource);
            
            if(count > 0) {
                flag = true;
            }
            transactionManager.commit(status);
            
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception(e);
        }
        return flag;
    }

    // Check if department code already exists (for unique validation)
    public List<Department> checkUniqueIfForDept(Department obj) throws Exception {
        List<Department> departmentsList = new ArrayList<Department>();
        try {
            String qry = "SELECT [department_code] FROM [capexDB].[dbo].[department] " +
                         "WHERE [department_code] = ? ";
            
            List<Object> params = new ArrayList<>();
            params.add(obj.getDepartment_code());
            
            departmentsList = jdbcTemplate.query(qry, params.toArray(), 
                new BeanPropertyRowMapper<Department>(Department.class));
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e);
        }
        return departmentsList;
    }

    // Delete department by ID
    public boolean deleteDepartment(String id) throws Exception {
        int count = 0;
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        
        try {
            String deleteQry = "DELETE FROM [capexDB].[dbo].[department] WHERE [id] = ?";
            count = jdbcTemplate.update(deleteQry, id);
            
            if(count > 0) {
                flag = true;
            }
            transactionManager.commit(status);
            
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception(e);
        }
        return flag;
    }

    // Get department by ID
    public Department getDepartmentById(String id) throws Exception {
        Department department = null;
        try {
            String qry = "SELECT TOP (1) [id], [sbu], [plant_code], " +
                         "[department_code], [department_name], [status] " +
                         "FROM [capexDB].[dbo].[department] " +
                         "WHERE [id] = ?";
            
            List<Department> result = jdbcTemplate.query(
                qry, 
                new Object[]{id}, 
                new BeanPropertyRowMapper<Department>(Department.class)
            );
            
            if (result != null && !result.isEmpty()) {
                department = result.get(0);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e);
        }
        return department;
    }

    // Get distinct SBU list
    public List<Department> getSBUList() throws SQLException {
        List<Department> sbuList = null;
        try {  
            String qry = "SELECT DISTINCT [sbu] FROM [capexDB].[dbo].[department] " +
                         "WHERE [sbu] IS NOT NULL AND [sbu] <> '' " +
                         "ORDER BY [sbu] ASC";
            
            sbuList = jdbcTemplate.query(qry, new BeanPropertyRowMapper<Department>(Department.class));
            
        } catch(Exception e) { 
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
        return sbuList;
    }

    // Get distinct plant codes
    public List<Department> getPlantList() throws SQLException {
        List<Department> plantList = null;
        try {  
            String qry = "SELECT DISTINCT [plant_code] FROM [capexDB].[dbo].[department] " +
                         "WHERE [plant_code] IS NOT NULL AND [plant_code] <> '' " +
                         "ORDER BY [plant_code] ASC";
            
            plantList = jdbcTemplate.query(qry, new BeanPropertyRowMapper<Department>(Department.class));
            
        } catch(Exception e) { 
            e.printStackTrace();
            throw new SQLException(e.getMessage());
        }
        return plantList;
    }

    // Get status filter list
    public List<Department> getStatusFilterList() throws Exception {
        List<Department> statusList = new ArrayList<Department>();
        try {
            String qry = "SELECT DISTINCT [status] FROM [capexDB].[dbo].[department] " +
                         "WHERE [status] IS NOT NULL AND [status] <> '' " +
                         "ORDER BY [status] ASC";
            
            statusList = jdbcTemplate.query(qry, new BeanPropertyRowMapper<Department>(Department.class));
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e);
        }
        return statusList;
    }
}