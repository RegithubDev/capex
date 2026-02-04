package com.resustainability.reisp.dao;

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

import com.resustainability.reisp.model.Plant;

@Repository
public class PlantDao {
    
    @Autowired
    JdbcTemplate jdbcTemplate;
    
    @Autowired
    DataSource dataSource;

    @Autowired
    DataSourceTransactionManager transactionManager;

    /**
     * Get all plants list with optional filters
     */
    public List<Plant> getPlantsList(Plant obj) throws Exception {
        List<Plant> plantList = new ArrayList<>();
        try {
            StringBuilder query = new StringBuilder();
            List<Object> params = new ArrayList<>();
            
            // Build query with optional filters
            query.append("SELECT id, location, sbu, plant_code, plant_name, status FROM plant WHERE 1=1 ");
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getLocation())) {
                query.append(" AND location LIKE ? ");
                params.add("%" + obj.getLocation() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
                query.append(" AND sbu LIKE ? ");
                params.add("%" + obj.getSbu() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getPlant_code())) {
                query.append(" AND plant_code LIKE ? ");
                params.add("%" + obj.getPlant_code() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getPlant_name())) {
                query.append(" AND plant_name LIKE ? ");
                params.add("%" + obj.getPlant_name() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
                query.append(" AND status = ? ");
                params.add(obj.getStatus());
            }
            
            query.append(" ORDER BY plant_code ASC");
            
            plantList = jdbcTemplate.query(
                query.toString(), 
                params.toArray(), 
                new BeanPropertyRowMapper<>(Plant.class)
            );
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching plant list: " + e.getMessage(), e);
        }
        return plantList;
    }

    /**
     * Get plant by ID
     */
    public Plant getPlantById(String id) throws Exception {
        Plant plant = null;
        try {
            String query = "SELECT id, location, sbu, plant_code, plant_name, status FROM plant WHERE id = ?";
            List<Plant> result = jdbcTemplate.query(
                query, 
                new Object[]{id}, 
                new BeanPropertyRowMapper<>(Plant.class)
            );
            
            if (result != null && !result.isEmpty()) {
                plant = result.get(0);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching plant by ID: " + e.getMessage(), e);
        }
        return plant;
    }

    /**
     * Add new plant
     */
    public boolean addPlant(Plant obj) throws Exception {
        int count = 0;
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        
        try {
            // First check if plant code already exists
            String checkQuery = "SELECT COUNT(*) FROM plant WHERE plant_code = ?";
            int existingCount = jdbcTemplate.queryForObject(checkQuery, Integer.class, obj.getPlant_code());
            
            if (existingCount > 0) {
                throw new Exception("Plant code already exists: " + obj.getPlant_code());
            }
            
            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            String insertQuery = "INSERT INTO plant (location, sbu, plant_code, plant_name, status) " +
                               "VALUES (:location, :sbu, :plant_code, :plant_name, :status)";
            
            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);
            count = namedParamJdbcTemplate.update(insertQuery, paramSource);
            
            if (count > 0) {
                flag = true;
            }
            
            transactionManager.commit(status);
            
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception("Error adding plant: " + e.getMessage(), e);
        }
        return flag;
    }

    /**
     * Update existing plant
     */
    public boolean updatePlant(Plant obj) throws Exception {
        int count = 0;
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        
        try {
            // Check if plant code exists for another record (excluding current one)
            String checkQuery = "SELECT COUNT(*) FROM plant WHERE plant_code = ? AND id != ?";
            int existingCount = jdbcTemplate.queryForObject(
                checkQuery, 
                Integer.class, 
                obj.getPlant_code(), 
                obj.getId()
            );
            
            if (existingCount > 0) {
                throw new Exception("Plant code already exists for another record: " + obj.getPlant_code());
            }
            
            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            String updateQuery = "UPDATE plant SET location = :location, sbu = :sbu, " +
                               "plant_code = :plant_code, plant_name = :plant_name, status = :status " +
                               "WHERE id = :id";
            
            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);
            count = namedParamJdbcTemplate.update(updateQuery, paramSource);
            
            if (count > 0) {
                flag = true;
            }
            
            transactionManager.commit(status);
            
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception("Error updating plant: " + e.getMessage(), e);
        }
        return flag;
    }

    /**
     * Delete plant
     */
    public boolean deletePlant(String id) throws Exception {
        int count = 0;
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        
        try {
            String deleteQuery = "DELETE FROM plant WHERE id = ?";
            count = jdbcTemplate.update(deleteQuery, id);
            
            if (count > 0) {
                flag = true;
            }
            
            transactionManager.commit(status);
            
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception("Error deleting plant: " + e.getMessage(), e);
        }
        return flag;
    }

    /**
     * Get active plants for dropdown
     */
    public List<Plant> getActivePlants() throws Exception {
        List<Plant> plantList = new ArrayList<>();
        try {
            String query = "SELECT id, location, sbu, plant_code, plant_name, status " +
                          "FROM plant WHERE status = 'Active' ORDER BY plant_code ASC";
            plantList = jdbcTemplate.query(query, new BeanPropertyRowMapper<>(Plant.class));
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching active plants: " + e.getMessage(), e);
        }
        return plantList;
    }

    /**
     * Get plant statistics (counts)
     */
    public Plant getPlantStatistics() throws Exception {
        Plant stats = new Plant();
        try {
            // Using count fields if they exist in Plant model, otherwise we'll add them
            String query = "SELECT " +
                          "(SELECT COUNT(*) FROM plant) AS all_plants, " +
                          "(SELECT COUNT(*) FROM plant WHERE status = 'Active') AS active_plants, " +
                          "(SELECT COUNT(*) FROM plant WHERE status != 'Active') AS inActive_plants";
            
            List<Plant> result = jdbcTemplate.query(query, new BeanPropertyRowMapper<>(Plant.class));
            
            if (result != null && !result.isEmpty()) {
                stats = result.get(0);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching plant statistics: " + e.getMessage(), e);
        }
        return stats;
    }

    /**
     * Check if plant code is unique
     */
    public boolean isPlantCodeUnique(String plantCode, String excludeId) throws Exception {
        try {
            String query;
            Object[] params;
            
            if (StringUtils.isEmpty(excludeId)) {
                query = "SELECT COUNT(*) FROM plant WHERE plant_code = ?";
                params = new Object[]{plantCode};
            } else {
                query = "SELECT COUNT(*) FROM plant WHERE plant_code = ? AND id != ?";
                params = new Object[]{plantCode, excludeId};
            }
            
            int count = jdbcTemplate.queryForObject(query, Integer.class, params);
            return count == 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error checking plant code uniqueness: " + e.getMessage(), e);
        }
    }

    /**
     * Get distinct status values for filter
     */
    public List<String> getStatusFilterList() throws Exception {
        List<String> statusList = new ArrayList<>();
        try {
            String query = "SELECT DISTINCT status FROM plant WHERE status IS NOT NULL AND status != '' ORDER BY status ASC";
            statusList = jdbcTemplate.queryForList(query, String.class);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching status filter list: " + e.getMessage(), e);
        }
        return statusList;
    }

    /**
     * Get distinct SBU values for filter
     */
    public List<String> getSBUFilterList() throws Exception {
        List<String> sbuList = new ArrayList<>();
        try {
            String query = "SELECT DISTINCT sbu FROM plant WHERE sbu IS NOT NULL AND sbu != '' ORDER BY sbu ASC";
            sbuList = jdbcTemplate.queryForList(query, String.class);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching SBU filter list: " + e.getMessage(), e);
        }
        return sbuList;
    }

    /**
     * Get distinct location values for filter
     */
    public List<String> getLocationFilterList() throws Exception {
        List<String> locationList = new ArrayList<>();
        try {
            String query = "SELECT DISTINCT location FROM plant WHERE location IS NOT NULL AND location != '' ORDER BY location ASC";
            locationList = jdbcTemplate.queryForList(query, String.class);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching location filter list: " + e.getMessage(), e);
        }
        return locationList;
    }

    /**
     * Search plants with pagination
     */
    public List<Plant> searchPlantsWithPagination(Plant obj, int page, int pageSize) throws Exception {
        List<Plant> plantList = new ArrayList<>();
        try {
            StringBuilder query = new StringBuilder();
            List<Object> params = new ArrayList<>();
            
            query.append("SELECT id, location, sbu, plant_code, plant_name, status FROM plant WHERE 1=1 ");
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getLocation())) {
                query.append(" AND location LIKE ? ");
                params.add("%" + obj.getLocation() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
                query.append(" AND sbu LIKE ? ");
                params.add("%" + obj.getSbu() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getPlant_code())) {
                query.append(" AND plant_code LIKE ? ");
                params.add("%" + obj.getPlant_code() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getPlant_name())) {
                query.append(" AND plant_name LIKE ? ");
                params.add("%" + obj.getPlant_name() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
                query.append(" AND status = ? ");
                params.add(obj.getStatus());
            }
            
            query.append(" ORDER BY plant_code ASC ");
            
            // Add pagination for SQL Server
            query.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
            params.add((page - 1) * pageSize);
            params.add(pageSize);
            
            plantList = jdbcTemplate.query(
                query.toString(), 
                params.toArray(), 
                new BeanPropertyRowMapper<>(Plant.class)
            );
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error searching plants with pagination: " + e.getMessage(), e);
        }
        return plantList;
    }

    /**
     * Count total plants for pagination
     */
    public int countPlants(Plant obj) throws Exception {
        try {
            StringBuilder query = new StringBuilder();
            List<Object> params = new ArrayList<>();
            
            query.append("SELECT COUNT(*) FROM plant WHERE 1=1 ");
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getLocation())) {
                query.append(" AND location LIKE ? ");
                params.add("%" + obj.getLocation() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
                query.append(" AND sbu LIKE ? ");
                params.add("%" + obj.getSbu() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getPlant_code())) {
                query.append(" AND plant_code LIKE ? ");
                params.add("%" + obj.getPlant_code() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getPlant_name())) {
                query.append(" AND plant_name LIKE ? ");
                params.add("%" + obj.getPlant_name() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
                query.append(" AND status = ? ");
                params.add(obj.getStatus());
            }
            
            return jdbcTemplate.queryForObject(query.toString(), Integer.class, params.toArray());
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error counting plants: " + e.getMessage(), e);
        }
    }

    /**
     * Get plants by SBU (for dropdown filtering)
     */
    public List<Plant> getPlantsBySBU(String sbu) throws Exception {
        List<Plant> plantList = new ArrayList<>();
        try {
            String query = "SELECT id, location, sbu, plant_code, plant_name, status " +
                          "FROM plant WHERE sbu = ? AND status = 'Active' ORDER BY plant_code ASC";
            plantList = jdbcTemplate.query(query, new Object[]{sbu}, new BeanPropertyRowMapper<>(Plant.class));
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching plants by SBU: " + e.getMessage(), e);
        }
        return plantList;
    }

    /**
     * Validate plant data before save
     */
    public boolean validatePlantData(Plant plant) throws Exception {
        try {
            // Check required fields
            if (StringUtils.isEmpty(plant.getLocation())) {
                throw new Exception("Location is required");
            }
            
            if (StringUtils.isEmpty(plant.getSbu())) {
                throw new Exception("SBU is required");
            }
            
            if (StringUtils.isEmpty(plant.getPlant_code())) {
                throw new Exception("Plant Code is required");
            }
            
            if (StringUtils.isEmpty(plant.getPlant_name())) {
                throw new Exception("Plant Name is required");
            }
            
            if (StringUtils.isEmpty(plant.getStatus())) {
                throw new Exception("Status is required");
            }
            
            return true;
            
        } catch (Exception e) {
            throw new Exception("Plant validation failed: " + e.getMessage(), e);
        }
    }
}