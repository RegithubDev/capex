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

import com.resustainability.reisp.model.SBU;

@Repository
public class SBUDao {
    
    @Autowired
    JdbcTemplate jdbcTemplate;
    
    @Autowired
    DataSource dataSource;

    @Autowired
    DataSourceTransactionManager transactionManager;

    /**
     * Get all SBUs list with optional filters
     */
    public List<SBU> getSBUsList(SBU obj) throws Exception {
        List<SBU> sbuList = new ArrayList<>();
        try {
            StringBuilder query = new StringBuilder();
            List<Object> params = new ArrayList<>();
            
            // Build query with optional filters
            query.append("SELECT id, sbu, sbu_name, created_date, created_by, updated_at, updated_by, status FROM sbu WHERE 1=1 ");
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
                query.append(" AND sbu LIKE ? ");
                params.add("%" + obj.getSbu() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu_name())) {
                query.append(" AND sbu_name LIKE ? ");
                params.add("%" + obj.getSbu_name() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
                query.append(" AND status = ? ");
                params.add(obj.getStatus());
            }
            
            query.append(" ORDER BY sbu ASC");
            
            sbuList = jdbcTemplate.query(
                query.toString(), 
                params.toArray(), 
                new BeanPropertyRowMapper<>(SBU.class)
            );
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching SBU list: " + e.getMessage(), e);
        }
        return sbuList;
    }

    /**
     * Get SBU by ID
     */
    public SBU getSBUById(String id) throws Exception {
        SBU sbu = null;
        try {
            String query = "SELECT id, sbu, sbu_name, created_date, created_by, updated_by, updated_at, status FROM sbu WHERE id = ?";
            List<SBU> result = jdbcTemplate.query(
                query, 
                new Object[]{id}, 
                new BeanPropertyRowMapper<>(SBU.class)
            );
            
            if (result != null && !result.isEmpty()) {
                sbu = result.get(0);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching SBU by ID: " + e.getMessage(), e);
        }
        return sbu;
    }

    /**
     * Add new SBU - FIXED: Explicitly inserts NULL for updated_by and updated_at
     * to override any SQL Server default constraints.
     */
    public boolean addSBU(SBU obj) throws Exception {
        int count = 0;
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        
        try {
            // First check if SBU code already exists
            String checkQuery = "SELECT COUNT(*) FROM sbu WHERE sbu = ?";
            int existingCount = jdbcTemplate.queryForObject(checkQuery, Integer.class, obj.getSbu());
            
            if (existingCount > 0) {
                throw new Exception("SBU code already exists: " + obj.getSbu());
            }
            
            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            
            obj.setUpdated_by(null);
            obj.setUpdated_at(null);
            
            // Explicitly insert NULL for updated_by and updated_at to prevent DB defaults from firing
            String insertQuery = "INSERT INTO sbu (sbu, sbu_name, created_by, created_date, updated_by, updated_at, status) " +
                                "VALUES (:sbu, :sbu_name, :created_by, :created_date, NULL, NULL, :status)";
            
            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);
            count = namedParamJdbcTemplate.update(insertQuery, paramSource);
            
            if (count > 0) {
                flag = true;
            }
            
            transactionManager.commit(status);
            
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception("Error adding SBU: " + e.getMessage(), e);
        }
        return flag;
    }

    /**
     * Update existing SBU
     */
    public boolean updateSBU(SBU obj) throws Exception {
        int count = 0;
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        
        try {
            // Check if SBU code exists for another record (excluding current one)
            String checkQuery = "SELECT COUNT(*) FROM sbu WHERE sbu = ? AND id != ?";
            int existingCount = jdbcTemplate.queryForObject(
                checkQuery, 
                Integer.class, 
                obj.getSbu(), 
                obj.getId()
            );
            
            if (existingCount > 0) {
                throw new Exception("SBU code already exists for another record: " + obj.getSbu());
            }
            
            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            
            // Only update sbu, sbu_name, updated_by, updated_at, status
            String updateQuery = "UPDATE sbu SET sbu = :sbu, sbu_name = :sbu_name, " +
                                "updated_by = :updated_by, updated_at = GETDATE(), " +
                                "status = :status WHERE id = :id";
            
            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);
            count = namedParamJdbcTemplate.update(updateQuery, paramSource);
            
            if (count > 0) {
                flag = true;
            }
            
            transactionManager.commit(status);
            
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception("Error updating SBU: " + e.getMessage(), e);
        }
        return flag;
    }

    /**
     * Alternative update method that first fetches the existing record
     * to ensure created fields are preserved
     */
    public boolean updateSBUSafe(SBU obj) throws Exception {
        int count = 0;
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        
        try {
            // First get the existing record
            SBU existingSBU = getSBUById(obj.getId());
            if (existingSBU == null) {
                throw new Exception("SBU not found with ID: " + obj.getId());
            }
            
            // Check if SBU code exists for another record (excluding current one)
            String checkQuery = "SELECT COUNT(*) FROM sbu WHERE sbu = ? AND id != ?";
            int existingCount = jdbcTemplate.queryForObject(
                checkQuery, 
                Integer.class, 
                obj.getSbu(), 
                obj.getId()
            );
            
            if (existingCount > 0) {
                throw new Exception("SBU code already exists for another record: " + obj.getSbu());
            }
            
            NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
            
            // Preserve created fields from existing record
            obj.setCreated_by(existingSBU.getCreated_by());
            obj.setCreated_date(existingSBU.getCreated_date());
            
            // Update only the allowed fields
            String updateQuery = "UPDATE sbu SET sbu = :sbu, sbu_name = :sbu_name, " +
                                "updated_by = :updated_by, updated_at = GETDATE(), " +
                                "status = :status WHERE id = :id";
            
            BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);
            count = namedParamJdbcTemplate.update(updateQuery, paramSource);
            
            if (count > 0) {
                flag = true;
            }
            
            transactionManager.commit(status);
            
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception("Error updating SBU: " + e.getMessage(), e);
        }
        return flag;
    }

    /**
     * Delete SBU
     */
    public boolean deleteSBU(String id) throws Exception {
        int count = 0;
        boolean flag = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        
        try {
            String deleteQuery = "DELETE FROM sbu WHERE id = ?";
            count = jdbcTemplate.update(deleteQuery, id);
            
            if (count > 0) {
                flag = true;
            }
            
            transactionManager.commit(status);
            
        } catch (Exception e) {
            transactionManager.rollback(status);
            e.printStackTrace();
            throw new Exception("Error deleting SBU: " + e.getMessage(), e);
        }
        return flag;
    }

    /**
     * Get all active SBUs for dropdown
     */
    public List<SBU> getActiveSBUs() throws Exception {
        List<SBU> sbuList = new ArrayList<>();
        try {
            String query = "SELECT id, sbu, sbu_name, status FROM sbu WHERE status = 'Active' ORDER BY sbu ASC";
            sbuList = jdbcTemplate.query(query, new BeanPropertyRowMapper<>(SBU.class));
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching active SBUs: " + e.getMessage(), e);
        }
        return sbuList;
    }

    /**
     * Get SBU statistics (counts)
     */
    public SBU getSBUStatistics() throws Exception {
        SBU stats = new SBU();
        try {
            String query = "SELECT " +
                          "(SELECT COUNT(*) FROM sbu) AS all_sbu, " +
                          "(SELECT COUNT(*) FROM sbu WHERE status = 'Active') AS active_sbu, " +
                          "(SELECT COUNT(*) FROM sbu WHERE status != 'Active') AS inActive_sbu";
            
            List<SBU> result = jdbcTemplate.query(query, new BeanPropertyRowMapper<>(SBU.class));
            
            if (result != null && !result.isEmpty()) {
                stats = result.get(0);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching SBU statistics: " + e.getMessage(), e);
        }
        return stats;
    }

    /**
     * Check if SBU code is unique
     */
    public boolean isSBUCodeUnique(String sbuCode, String excludeId) throws Exception {
        try {
            String query;
            Object[] params;
            
            if (StringUtils.isEmpty(excludeId)) {
                query = "SELECT COUNT(*) FROM sbu WHERE sbu = ?";
                params = new Object[]{sbuCode};
            } else {
                query = "SELECT COUNT(*) FROM sbu WHERE sbu = ? AND id != ?";
                params = new Object[]{sbuCode, excludeId};
            }
            
            int count = jdbcTemplate.queryForObject(query, Integer.class, params);
            return count == 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error checking SBU code uniqueness: " + e.getMessage(), e);
        }
    }

    /**
     * Get distinct status values for filter
     */
    public List<String> getStatusFilterList() throws Exception {
        List<String> statusList = new ArrayList<>();
        try {
            String query = "SELECT DISTINCT status FROM sbu WHERE status IS NOT NULL AND status != '' ORDER BY status ASC";
            statusList = jdbcTemplate.queryForList(query, String.class);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching status filter list: " + e.getMessage(), e);
        }
        return statusList;
    }

    /**
     * Search SBUs with pagination
     */
    public List<SBU> searchSBUsWithPagination(SBU obj, int page, int pageSize) throws Exception {
        List<SBU> sbuList = new ArrayList<>();
        try {
            StringBuilder query = new StringBuilder();
            List<Object> params = new ArrayList<>();
            
            query.append("SELECT id, sbu, sbu_name, created_by, created_date, updated_by, updated_at, status FROM sbu WHERE 1=1 ");
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
                query.append(" AND sbu LIKE ? ");
                params.add("%" + obj.getSbu() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu_name())) {
                query.append(" AND sbu_name LIKE ? ");
                params.add("%" + obj.getSbu_name() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
                query.append(" AND status = ? ");
                params.add(obj.getStatus());
            }
            
            query.append(" ORDER BY sbu ASC ");
            
            // Add pagination - SQL Server syntax
            query.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
            params.add((page - 1) * pageSize);
            params.add(pageSize);
            
            sbuList = jdbcTemplate.query(
                query.toString(), 
                params.toArray(), 
                new BeanPropertyRowMapper<>(SBU.class)
            );
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error searching SBUs with pagination: " + e.getMessage(), e);
        }
        return sbuList;
    }

    /**
     * Count total SBUs for pagination
     */
    public int countSBUs(SBU obj) throws Exception {
        try {
            StringBuilder query = new StringBuilder();
            List<Object> params = new ArrayList<>();
            
            query.append("SELECT COUNT(*) FROM sbu WHERE 1=1 ");
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
                query.append(" AND sbu LIKE ? ");
                params.add("%" + obj.getSbu() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu_name())) {
                query.append(" AND sbu_name LIKE ? ");
                params.add("%" + obj.getSbu_name() + "%");
            }
            
            if (!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
                query.append(" AND status = ? ");
                params.add(obj.getStatus());
            }
            
            return jdbcTemplate.queryForObject(query.toString(), Integer.class, params.toArray());
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error counting SBUs: " + e.getMessage(), e);
        }
    }

    /**
     * Get recently added/modified SBUs
     */
    public List<SBU> getRecentSBUs(int limit) throws Exception {
        List<SBU> sbuList = new ArrayList<>();
        try {
            String query = "SELECT TOP (?) id, sbu, sbu_name, created_by, created_date, updated_by, updated_at, status " +
                          "FROM sbu ORDER BY created_date DESC, updated_at DESC";
            sbuList = jdbcTemplate.query(query, new Object[]{limit}, new BeanPropertyRowMapper<>(SBU.class));
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching recent SBUs: " + e.getMessage(), e);
        }
        return sbuList;
    }

    /**
     * Reset updated fields to NULL for testing (use only if needed)
     */
    public int resetUpdatedFieldsForNewRecords() throws Exception {
        String updateQuery = "UPDATE sbu SET updated_by = NULL, updated_at = NULL WHERE updated_at = created_date";
        return jdbcTemplate.update(updateQuery);
    }
}