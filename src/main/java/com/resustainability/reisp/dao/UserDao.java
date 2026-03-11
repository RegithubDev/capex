package com.resustainability.reisp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

import com.resustainability.reisp.common.EncryptDecrypt;
import com.resustainability.reisp.common.EMailSender;
import com.resustainability.reisp.common.Mail;
import com.resustainability.reisp.constants.CommonConstants;
import com.resustainability.reisp.common.DBConnectionHandler;
import com.resustainability.reisp.model.IRM;
import com.resustainability.reisp.model.User;

@Repository
public class UserDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private DataSource dataSource;

    @Autowired
    private DataSourceTransactionManager transactionManager;

    /**
     * Get list of users with optional filtering
     */
    public List<User> getUsersList(User obj) throws Exception {
        List<User> users = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder();
            List<Object> params = new ArrayList<>();

            sql.append("SELECT ");
            sql.append("u.id, u.user_id, u.user_name, u.email_id, u.contact_number,u.password,u.role_type, ");
            sql.append("u.base_role, u.base_sbu,s.sbu_name, u.base_project, u.base_department, ");
            sql.append("u.role_type, u.status, u.created_by, ");
            sql.append("FORMAT(u.created_date, 'dd-MMM-yyyy') AS created_date, ");
            sql.append("u.modified_by, FORMAT(u.modified_date, 'dd-MMM-yyyy') AS modified_date ");
            sql.append("FROM user_profile u left join sbu s on u.base_sbu = s.sbu  ");
            sql.append("WHERE u.user_id IS NOT NULL AND u.user_id <> '' ");

            if (obj != null) {
                if (StringUtils.hasText(obj.getUser_id())) {
                    sql.append("AND u.user_id = ? ");
                    params.add(obj.getUser_id());
                }
                if (StringUtils.hasText(obj.getStatus())) {
                    sql.append("AND u.status = ? ");
                    params.add(obj.getStatus());
                }
                if (StringUtils.hasText(obj.getBase_project())) {
                    sql.append("AND u.base_project = ? ");
                    params.add(obj.getBase_project());
                }
                if (StringUtils.hasText(obj.getBase_role())) {
                    sql.append("AND u.base_role = ? ");
                    params.add(obj.getBase_role());
                }
                if (StringUtils.hasText(obj.getSbu())) {
                    sql.append("AND u.base_sbu = ? ");
                    params.add(obj.getSbu());
                }
            }

            sql.append("ORDER BY u.user_name ASC");

            users = jdbcTemplate.query(
                sql.toString(),
                params.toArray(),
                new BeanPropertyRowMapper<>(User.class)
            );
        } catch (Exception e) {
            throw new Exception("Error fetching user list: " + e.getMessage(), e);
        }
        return users;
    }

    /**
     * Add new user
     */
    public boolean addUser(User obj) throws Exception {
        boolean success = false;

        try {
            NamedParameterJdbcTemplate namedJdbc = new NamedParameterJdbcTemplate(dataSource);

            // Encrypt password
            if (StringUtils.hasText(obj.getPassword())) {
                obj.setPassword((obj.getPassword()));
            } else {
                obj.setPassword(EncryptDecrypt.encrypt("Password@123"));
            }

            obj.setStatus("Active");

            String insertSql = """
                INSERT INTO user_profile 
                (user_id, user_name, password, email_id, contact_number, 
                 base_role,role_type, base_sbu, base_project, base_department, 
                 created_by, created_date, status)
                VALUES 
                (:user_id, :user_name, :password, :email_id, :contact_number,
                 :base_role,:role_type, :base_sbu, :base_project, :base_department,
                 :created_by, GETDATE(), :status)
                """;

            BeanPropertySqlParameterSource params = new BeanPropertySqlParameterSource(obj);
            int rows = namedJdbc.update(insertSql, params);

            if (rows > 0) {
                success = true;

            }

        } catch (Exception e) {
            throw new Exception("Failed to add user: " + e.getMessage(), e);
        }
        return success;
    }

    /**
     * Update existing user
     */
    public boolean updateUser(User obj) throws Exception {
        boolean success = false;
        TransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        try {
            NamedParameterJdbcTemplate namedJdbc = new NamedParameterJdbcTemplate(dataSource);

            String updateSql = """
                UPDATE user_profile 
                SET user_name = :user_name,
                    email_id = :email_id,
                    contact_number = :contact_number,
                    base_sbu = :base_sbu,
                    base_project = :base_project,
                    base_department = :base_department,
                    base_role = :base_role,
                    role_type = :role_type,
                    modified_by = :modified_by,
                    modified_date = GETDATE()
                WHERE user_id = :user_id
                """;

            BeanPropertySqlParameterSource params = new BeanPropertySqlParameterSource(obj);
            int rows = namedJdbc.update(updateSql, params);

            success = (rows > 0);
            transactionManager.commit(status);
        } catch (Exception e) {
            transactionManager.rollback(status);
            throw new Exception("Failed to update user: " + e.getMessage(), e);
        }
        return success;
    }

    /**
     * Validate user login credentials
     */
    public User validateUser(User user) throws Exception {
        User details = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = dataSource.getConnection();
            String sql = """
                SELECT id, user_id, user_name, base_role,password, contact_number, 
                       email_id, base_department, base_sbu, base_project, status
                FROM user_profile
                WHERE status = 'Active'
                  AND user_id = ?
                  AND password = ?
                """;

            ps = con.prepareStatement(sql);
            ps.setString(1, user.getUser_id());
            String p = user.getPassword();
            ps.setString(2, p); 

            rs = ps.executeQuery();
            if (rs.next()) {
                details = new User();
                details.setId(rs.getString("id"));
                details.setUser_id(rs.getString("user_id"));
                details.setUser_name(rs.getString("user_name"));
                details.setPassword(rs.getString("password"));
                details.setEmail_id(rs.getString("email_id"));
                details.setContact_number(rs.getString("contact_number"));
                details.setBase_role(rs.getString("base_role"));
                details.setBase_sbu(rs.getString("base_sbu"));
                details.setBase_project(rs.getString("base_project"));
                details.setBase_department(rs.getString("base_department"));
                details.setStatus(rs.getString("status"));
            }
        } finally {
            DBConnectionHandler.closeJDBCResoucrs(con, ps, rs);
        }
        return details;
    }

    /**
     * Get total record count for pagination
     */
    public int getTotalRecords(User obj, String search) throws Exception {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM user_profile WHERE user_id IS NOT NULL ");
        List<Object> params = new ArrayList<>();

        if (obj != null) {
            if (StringUtils.hasText(obj.getUser_id())) {
                sql.append("AND user_id = ? ");
                params.add(obj.getUser_id());
            }
            if (StringUtils.hasText(obj.getStatus())) {
                sql.append("AND status = ? ");
                params.add(obj.getStatus());
            }
            if (StringUtils.hasText(obj.getBase_project())) {
                sql.append("AND base_project = ? ");
                params.add(obj.getBase_project());
            }
            if (StringUtils.hasText(obj.getBase_role())) {
                sql.append("AND base_role = ? ");
                params.add(obj.getBase_role());
            }
            if (StringUtils.hasText(obj.getSbu())) {
                sql.append("AND base_sbu = ? ");
                params.add(obj.getSbu());
            }
        }

        if (StringUtils.hasText(search)) {
            String like = "%" + search.toLowerCase() + "%";
            sql.append("AND (LOWER(user_id) LIKE ? OR LOWER(user_name) LIKE ? " +
                       "OR LOWER(email_id) LIKE ? OR LOWER(contact_number) LIKE ?) ");
            params.add(like);
            params.add(like);
            params.add(like);
            params.add(like);
        }

        return jdbcTemplate.queryForObject(sql.toString(), params.toArray(), Integer.class);
    }

    /**
     * Get paginated list of users
     */
    public List<User> getUserList(User obj, int start, int length, String search) throws Exception {
        StringBuilder sql = new StringBuilder();
        List<Object> params = new ArrayList<>();

        sql.append("SELECT id, user_id, user_name, email_id, contact_number, ");
        sql.append("base_role, base_sbu, base_project, base_department, ");
        sql.append("role_type, status, created_by, ");
        sql.append("FORMAT(created_date, 'dd-MMM-yyyy') AS created_date, ");
        sql.append("modified_by, FORMAT(modified_date, 'dd-MMM-yyyy') AS modified_date ");
        sql.append("FROM user_profile WHERE user_id IS NOT NULL ");

        if (obj != null) {
            if (StringUtils.hasText(obj.getUser_id())) {
                sql.append("AND user_id = ? ");
                params.add(obj.getUser_id());
            }
            if (StringUtils.hasText(obj.getStatus())) {
                sql.append("AND status = ? ");
                params.add(obj.getStatus());
            }
            if (StringUtils.hasText(obj.getBase_project())) {
                sql.append("AND base_project = ? ");
                params.add(obj.getBase_project());
            }
            if (StringUtils.hasText(obj.getBase_role())) {
                sql.append("AND base_role = ? ");
                params.add(obj.getBase_role());
            }
            if (StringUtils.hasText(obj.getSbu())) {
                sql.append("AND base_sbu = ? ");
                params.add(obj.getSbu());
            }
        }

        if (StringUtils.hasText(search)) {
            String like = "%" + search.toLowerCase() + "%";
            sql.append("AND (LOWER(user_id) LIKE ? OR LOWER(user_name) LIKE ? " +
                       "OR LOWER(email_id) LIKE ? OR LOWER(contact_number) LIKE ?) ");
            for (int i = 0; i < 4; i++) params.add(like);
        }

        sql.append("ORDER BY user_name ASC ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(start);
        params.add(length);

        return jdbcTemplate.query(sql.toString(), params.toArray(), new BeanPropertyRowMapper<>(User.class));
    }

    /**
     * Delete user
     */
    public boolean deleteUser(User obj) throws Exception {
        String sql = "DELETE FROM user_profile WHERE user_id = ?";
        return jdbcTemplate.update(sql, obj.getUser_id()) > 0;
    }

    // -------------------------------------------------------------------------
    // OTP methods (kept as-is, assuming otp_log table exists)
    // -------------------------------------------------------------------------
    public boolean otpLog(IRM irm) throws Exception {
        String sql = "INSERT INTO otp_log (email_id, otp_code, created_datetime, expired_datetime) " +
                     "VALUES (?, ?, GETDATE(), DATEADD(MINUTE, 15, GETDATE()))";
        return jdbcTemplate.update(sql, irm.getEmail_id(), irm.getOtp_code()) > 0;
    }

    public boolean verifyOtp(IRM irm) throws Exception {
        String sql = """
            SELECT TOP 1 1 FROM otp_log 
            WHERE email_id = ? AND otp_code = ? 
              AND expired_datetime > GETDATE()
            ORDER BY expired_datetime DESC
            """;
        try {
            Integer result = jdbcTemplate.queryForObject(sql, Integer.class, irm.getEmail_id(), irm.getOtp_code());
            return result != null && result > 0;
        } catch (Exception e) {
            return false;
        }
    }
    public List<User> getProjectListForUser(User obj) throws Exception {
		List<User> objsList = new ArrayList<User>();
		try {
			String qry = "SELECT p.plant_code,plant_name FROM plant p "
					+ "left join sbu s on p.sbu = s.sbu  "
					+ " where p.plant_code <> '' and p.plant_code is not null ";
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				qry = qry + " and p.sbu = ? ";
				arrSize++;
			}	
			qry = qry + "group by p.plant_code,plant_name ";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				pValues[i++] = obj.getSbu();
			}
			objsList = jdbcTemplate.query( qry, pValues, new BeanPropertyRowMapper<User>(User.class));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return objsList;
	}

	public List<User> getDeptListForUser(User obj) throws Exception {
		List<User> objsList = new ArrayList<User>();
		try {
			String qry = "SELECT d.department_code ,department_name,sbu FROM department d "
					+ " where d.department_code <> '' and d.department_code is not null ";
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				qry = qry + "and  d.sbu like ('%"+obj.getSbu()+"%') ";
			}	
			
			objsList = jdbcTemplate.query( qry, new BeanPropertyRowMapper<User>(User.class));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return objsList;
	}
	
	public boolean addUserSelf(User obj) throws Exception {
		int count = 0;
		boolean flag = false;
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = transactionManager.getTransaction(def);
		try {
			NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
			String updateQry = "UPDATE user_profile set contact_number=:contact_number,"
					+ "base_sbu= :base_sbu,base_project= :base_project,base_department= :base_department,reporting_to= :reporting_to,"
					+ "modified_by=:modified_by,modified_date= getdate()  "
					+ "where user_id = :user_id ";
			BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);		 
		    count = namedParamJdbcTemplate.update(updateQry, paramSource);
			if(count > 0) {
				flag = true;
				obj.setModule_type("Profile");
				obj.setMessage("Profile Updated Successfully");
				String logQry = "INSERT INTO user_audit_log "
						+ "(module_type,message,user_id,create_date)"
						+ " VALUES "
						+ "(:module_type,:message,:modified_by,getdate())";
				 paramSource = new BeanPropertySqlParameterSource(obj);		 
			     count = namedParamJdbcTemplate.update(logQry, paramSource);
			}
			transactionManager.commit(status);
		}catch (Exception e) {
			transactionManager.rollback(status);
			e.printStackTrace();
			throw new Exception(e);
		}
		return flag;
	}

}