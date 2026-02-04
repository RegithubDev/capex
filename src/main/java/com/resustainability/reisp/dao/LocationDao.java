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

import com.resustainability.reisp.model.Location;

@Repository
public class LocationDao {
    
    @Autowired
    JdbcTemplate jdbcTemplate;
    
    @Autowired
    DataSource dataSource;

    @Autowired
    DataSourceTransactionManager transactionManager;

    /**
     * Get all locations list with optional filters
     */
    public List<Location> getLocationsList(Location obj) throws Exception {
        List<Location> locationList = new ArrayList<>();
        try {
            StringBuilder query = new StringBuilder();
            List<Object> params = new ArrayList<>();
            
            // Build query with optional filters
            query.append("SELECT id, location, status FROM location WHERE 1=1 ");
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getLocation())) {
                query.append(" AND location LIKE ? ");
                params.add("%" + obj.getLocation() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
                query.append(" AND status = ? ");
                params.add(obj.getStatus());
            }
            
            query.append(" ORDER BY location ASC"); // Changed to order by location name
            
            locationList = jdbcTemplate.query(
                query.toString(), 
                params.toArray(), 
                new BeanPropertyRowMapper<>(Location.class)
            );
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching location list: " + e.getMessage(), e);
        }
        return locationList;
    }

    /**
     * Get location by ID
     */
    public Location getLocationById(String id) throws Exception {
        Location location = null;
        try {
            String query = "SELECT id, location, status FROM location WHERE id = ?";
            List<Location> result = jdbcTemplate.query(
                query, 
                new Object[]{id}, 
                new BeanPropertyRowMapper<>(Location.class)
            );
            
            if (result != null && !result.isEmpty()) {
                location = result.get(0);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching location by ID: " + e.getMessage(), e);
        }
        return location;
    }

    /**
     * Add new location
     */
    public boolean addLocation(Location obj) throws Exception {
        int count = 0;
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        
        try {
            // First check if location name already exists
            String checkQuery = "SELECT COUNT(*) FROM location WHERE location = ?";
            int existingCount = jdbcTemplate.queryForObject(checkQuery, Integer.class, obj.getLocation());
            
            if (existingCount > 0) {
                throw new Exception("Location name already exists: " + obj.getLocation());
            }
            
            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            String insertQuery = "INSERT INTO location (location, status) " +
                               "VALUES (:location, :status)";
            
            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);
            count = namedParamJdbcTemplate.update(insertQuery, paramSource);
            
            if (count > 0) {
                flag = true;
            }
            
            transactionManager.commit(status);
            
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception("Error adding location: " + e.getMessage(), e);
        }
        return flag;
    }

    /**
     * Update existing location
     */
    public boolean updateLocation(Location obj) throws Exception {
        int count = 0;
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        
        try {
            // Check if location name exists for another record (excluding current one)
            String checkQuery = "SELECT COUNT(*) FROM location WHERE location = ? AND id != ?";
            int existingCount = jdbcTemplate.queryForObject(
                checkQuery, 
                Integer.class, 
                obj.getLocation(), 
                obj.getId()
            );
            
            if (existingCount > 0) {
                throw new Exception("Location name already exists for another record: " + obj.getLocation());
            }
            
            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            String updateQuery = "UPDATE location SET location = :location, status = :status " +
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
            throw new Exception("Error updating location: " + e.getMessage(), e);
        }
        return flag;
    }

    /**
     * Delete location
     */
    public boolean deleteLocation(String id) throws Exception {
        int count = 0;
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        
        try {
            // First check if location is being used in plant table
            String checkQuery = "SELECT COUNT(*) FROM plant WHERE location = (SELECT location FROM location WHERE id = ?)";
            int usageCount = jdbcTemplate.queryForObject(checkQuery, Integer.class, id);
            
            if (usageCount > 0) {
                throw new Exception("Cannot delete location. It is being used in " + usageCount + " plant(s).");
            }
            
            String deleteQuery = "DELETE FROM location WHERE id = ?";
            count = jdbcTemplate.update(deleteQuery, id);
            
            if (count > 0) {
                flag = true;
            }
            
            transactionManager.commit(status);
            
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception("Error deleting location: " + e.getMessage(), e);
        }
        return flag;
    }

    /**
     * Get active locations for dropdown
     */
    public List<Location> getActiveLocations() throws Exception {
        List<Location> locationList = new ArrayList<>();
        try {
            String query = "SELECT id, location, status " +
                          "FROM location WHERE status = 'Active' ORDER BY location ASC";
            locationList = jdbcTemplate.query(query, new BeanPropertyRowMapper<>(Location.class));
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching active locations: " + e.getMessage(), e);
        }
        return locationList;
    }

    /**
     * Check if location name is unique
     */
    public boolean isLocationUnique(String locationName, String excludeId) throws Exception {
        try {
            String query;
            Object[] params;
            
            if (StringUtils.isEmpty(excludeId)) {
                query = "SELECT COUNT(*) FROM location WHERE location = ?";
                params = new Object[]{locationName};
            } else {
                query = "SELECT COUNT(*) FROM location WHERE location = ? AND id != ?";
                params = new Object[]{locationName, excludeId};
            }
            
            int count = jdbcTemplate.queryForObject(query, Integer.class, params);
            return count == 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error checking location uniqueness: " + e.getMessage(), e);
        }
    }

    /**
     * Get distinct status values for filter
     */
    public List<String> getStatusFilterList() throws Exception {
        List<String> statusList = new ArrayList<>();
        try {
            String query = "SELECT DISTINCT status FROM location WHERE status IS NOT NULL AND status != '' ORDER BY status ASC";
            statusList = jdbcTemplate.queryForList(query, String.class);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching status filter list: " + e.getMessage(), e);
        }
        return statusList;
    }

    /**
     * Search locations with pagination
     */
    public List<Location> searchLocationsWithPagination(Location obj, int page, int pageSize) throws Exception {
        List<Location> locationList = new ArrayList<>();
        try {
            StringBuilder query = new StringBuilder();
            List<Object> params = new ArrayList<>();
            
            query.append("SELECT id, location, status FROM location WHERE 1=1 ");
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getLocation())) {
                query.append(" AND location LIKE ? ");
                params.add("%" + obj.getLocation() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
                query.append(" AND status = ? ");
                params.add(obj.getStatus());
            }
            
            query.append(" ORDER BY location ASC ");
            
            // Add pagination for SQL Server
            query.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
            params.add((page - 1) * pageSize);
            params.add(pageSize);
            
            locationList = jdbcTemplate.query(
                query.toString(), 
                params.toArray(), 
                new BeanPropertyRowMapper<>(Location.class)
            );
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error searching locations with pagination: " + e.getMessage(), e);
        }
        return locationList;
    }

    /**
     * Count total locations for pagination
     */
    public int countLocations(Location obj) throws Exception {
        try {
            StringBuilder query = new StringBuilder();
            List<Object> params = new ArrayList<>();
            
            query.append("SELECT COUNT(*) FROM location WHERE 1=1 ");
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getLocation())) {
                query.append(" AND location LIKE ? ");
                params.add("%" + obj.getLocation() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
                query.append(" AND status = ? ");
                params.add(obj.getStatus());
            }
            
            return jdbcTemplate.queryForObject(query.toString(), Integer.class, params.toArray());
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error counting locations: " + e.getMessage(), e);
        }
    }

    /**
     * Get location statistics (counts)
     */
    public Location getLocationStatistics() throws Exception {
        Location stats = new Location();
        try {
            String query = "SELECT " +
                          "(SELECT COUNT(*) FROM location) AS total_locations, " +
                          "(SELECT COUNT(*) FROM location WHERE status = 'Active') AS active_locations, " +
                          "(SELECT COUNT(*) FROM location WHERE status != 'Active') AS inactive_locations";
            
            List<Location> result = jdbcTemplate.query(query, new BeanPropertyRowMapper<>(Location.class));
            
            if (result != null && !result.isEmpty()) {
                stats = result.get(0);
                // Map the result to the location object
                // Note: You need to add these fields to your Location model if not present
                // stats.setTotalLocations(String.valueOf(total));
                // stats.setActiveLocations(String.valueOf(active));
                // stats.setInactiveLocations(String.valueOf(inactive));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching location statistics: " + e.getMessage(), e);
        }
        return stats;
    }

    /**
     * Validate location data before save
     */
    public boolean validateLocationData(Location location) throws Exception {
        try {
            // Check required fields
            if (StringUtils.isEmpty(location.getLocation())) {
                throw new Exception("Location name is required");
            }
            
            if (StringUtils.isEmpty(location.getStatus())) {
                throw new Exception("Status is required");
            }
            
            // Check length constraints
            if (location.getLocation().length() > 100) {
                throw new Exception("Location name must be less than 100 characters");
            }
            
            return true;
            
        } catch (Exception e) {
            throw new Exception("Location validation failed: " + e.getMessage(), e);
        }
    }

    /**
     * Get locations by status
     */
    public List<Location> getLocationsByStatus(String status) throws Exception {
        List<Location> locationList = new ArrayList<>();
        try {
            String query = "SELECT id, location, status " +
                          "FROM location WHERE status = ? ORDER BY location ASC";
            locationList = jdbcTemplate.query(query, new Object[]{status}, new BeanPropertyRowMapper<>(Location.class));
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching locations by status: " + e.getMessage(), e);
        }
        return locationList;
    }

    /**
     * Check if location is being used in other tables
     */
    public boolean isLocationInUse(String locationName) throws Exception {
        try {
            // Check plant table
            String query = "SELECT COUNT(*) FROM plant WHERE location = ?";
            int count = jdbcTemplate.queryForObject(query, Integer.class, locationName);
            
            return count > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error checking location usage: " + e.getMessage(), e);
        }
    }

    /**
     * Get all distinct locations for dropdown (active and inactive)
     */
    public List<String> getAllLocationNames() throws Exception {
        List<String> locationList = new ArrayList<>();
        try {
            String query = "SELECT DISTINCT location FROM location WHERE location IS NOT NULL AND location != '' ORDER BY location ASC";
            locationList = jdbcTemplate.queryForList(query, String.class);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching all location names: " + e.getMessage(), e);
        }
        return locationList;
    }

    /**
     * Bulk update location status
     */
    public boolean bulkUpdateStatus(List<String> ids, String status) throws Exception {
        int count = 0;
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus transactionStatus = transactionManager.getTransaction(def);
        
        try {
            if (ids == null || ids.isEmpty()) {
                throw new Exception("No location IDs provided for bulk update");
            }
            
            // Create parameter placeholders for IN clause
            StringBuilder placeholders = new StringBuilder();
            for (int i = 0; i < ids.size(); i++) {
                placeholders.append("?");
                if (i < ids.size() - 1) {
                    placeholders.append(",");
                }
            }
            
            String updateQuery = "UPDATE location SET status = ? WHERE id IN (" + placeholders.toString() + ")";
            
            // Build parameters array
            Object[] params = new Object[ids.size() + 1];
            params[0] = status;
            for (int i = 0; i < ids.size(); i++) {
                params[i + 1] = ids.get(i);
            }
            
            count = jdbcTemplate.update(updateQuery, params);
            
            if (count > 0) {
                flag = true;
            }
            
            transactionManager.commit(transactionStatus);
            
        } catch (Exception e) {
            transactionManager.rollback(transactionStatus);
            e.printStackTrace();
            throw new Exception("Error in bulk update status: " + e.getMessage(), e);
        }
        return flag;
    }
}