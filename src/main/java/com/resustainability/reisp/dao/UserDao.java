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
import com.resustainability.reisp.common.Mail;
import com.resustainability.reisp.constants.CommonConstants;
import com.resustainability.reisp.common.DBConnectionHandler;
import com.resustainability.reisp.common.EMailSender;
import com.resustainability.reisp.model.IRM;
import com.resustainability.reisp.model.RoleMapping;
import com.resustainability.reisp.model.User;

@Repository
public class UserDao {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	DataSource dataSource;

	@Autowired
	DataSourceTransactionManager transactionManager;
	
	public List<User> getUsersList(User obj) throws Exception {
	    List<User> objsList = null;
	    try {
	        jdbcTemplate = new JdbcTemplate(dataSource);
	        List<Object> paramList = new ArrayList<>();

	        StringBuilder qry = new StringBuilder();
	        qry.append("SELECT DISTINCT ");
	        qry.append("up.id, ");
	        qry.append("up.user_id, ");
	        qry.append("up.user_name, ");
	        qry.append("up.email_id, ");
	        qry.append("up.contact_number, ");
	        qry.append("up.base_role AS designation, ");
	        qry.append("up.base_sbu, ");
	        qry.append("up.base_project, ");
	        qry.append("up.base_department, ");
	        qry.append("up.reporting_to, ");
	        qry.append("up.status, ");
	        qry.append("up.created_by, ");
	        qry.append("FORMAT(up.created_date, 'dd-MMM-yyyy') AS created_date, ");
	        qry.append("up.modified_by, ");
	        qry.append("FORMAT(up.modified_date, 'dd-MMM-yyyy') AS modified_date, ");
	        qry.append("up2.user_name AS reporting_to_name, ");
	        qry.append("p.project_name AS base_project_name, ");
	        qry.append("s.sbu_name AS base_sbu_name, ");
	        qry.append("d.department_name AS base_department_name ");
	        
	        qry.append("FROM user_profile up ");
	        qry.append("LEFT JOIN user_profile up2 ON up.reporting_to = up2.user_id ");
	        qry.append("LEFT JOIN project p ON up.base_project = p.project_code ");
	        qry.append("LEFT JOIN sbu s ON up.base_sbu = s.sbu_code ");
	        qry.append("LEFT JOIN department d ON up.base_department = d.department_code ");
	        qry.append("WHERE up.user_id <> '' AND up.user_id IS NOT NULL ");

	        if (obj != null) {
	            if (!StringUtils.isEmpty(obj.getUser_id())) {
	                qry.append("AND up.user_id = ? ");
	                paramList.add(obj.getUser_id());
	            }
	            if (!StringUtils.isEmpty(obj.getStatus())) {
	                qry.append("AND up.status = ? ");
	                paramList.add(obj.getStatus());
	            }
	            if (!StringUtils.isEmpty(obj.getProject())) {
	                qry.append("AND up.base_project = ? ");
	                paramList.add(obj.getProject());
	            }
	            if (!StringUtils.isEmpty(obj.getBase_role())) {
	                qry.append("AND up.base_role = ? ");
	                paramList.add(obj.getBase_role());
	            }
	            if (!StringUtils.isEmpty(obj.getSbu())) {
	                qry.append("AND up.base_sbu = ? ");
	                paramList.add(obj.getSbu());
	            }
	        }

	        qry.append("ORDER BY up.user_name ASC ");

	        System.out.println("Executing Users Query: " + qry.toString());
	        System.out.println("Parameters: " + paramList);

	        objsList = jdbcTemplate.query(qry.toString(), paramList.toArray(), new BeanPropertyRowMapper<>(User.class));
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Fallback to simple query if joins fail
	        objsList = getSimpleUsersList(obj);
	    }
	    return objsList;
	}

	// Fallback method if joins fail
	private List<User> getSimpleUsersList(User obj) throws Exception {
	    List<User> objsList = null;
	    try {
	        jdbcTemplate = new JdbcTemplate(dataSource);
	        List<Object> paramList = new ArrayList<>();

	        StringBuilder qry = new StringBuilder();
	        qry.append("SELECT DISTINCT ");
	        qry.append("id, ");
	        qry.append("user_id, ");
	        qry.append("user_name, ");
	        qry.append("email_id, ");
	        qry.append("contact_number, ");
	        qry.append("base_role AS designation, ");
	        qry.append("base_sbu, ");
	        qry.append("base_project, ");
	        qry.append("base_department, ");
	        qry.append("reporting_to, ");
	        qry.append("status, ");
	        qry.append("created_by, ");
	        qry.append("FORMAT(created_date, 'dd-MMM-yyyy') AS created_date, ");
	        qry.append("modified_by, ");
	        qry.append("FORMAT(modified_date, 'dd-MMM-yyyy') AS modified_date ");
	        
	        qry.append("FROM user_profile ");
	        qry.append("WHERE user_id <> '' AND user_id IS NOT NULL ");

	        if (obj != null) {
	            if (!StringUtils.isEmpty(obj.getUser_id())) {
	                qry.append("AND user_id = ? ");
	                paramList.add(obj.getUser_id());
	            }
	            if (!StringUtils.isEmpty(obj.getStatus())) {
	                qry.append("AND status = ? ");
	                paramList.add(obj.getStatus());
	            }
	        }

	        qry.append("ORDER BY user_name ASC ");

	        objsList = jdbcTemplate.query(qry.toString(), paramList.toArray(), new BeanPropertyRowMapper<>(User.class));
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception(e);
	    }
	    return objsList;
	}

	public boolean addUser(User obj) throws Exception {
	    int count = 0;
	    boolean flag = false;
	    TransactionDefinition def = new DefaultTransactionDefinition();
	    TransactionStatus status = transactionManager.getTransaction(def);
	    try {
	        NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
	        
	        // Encrypt password if provided
	        if(!StringUtils.isEmpty(obj.getPassword())) {
	            String encryptPwd = EncryptDecrypt.encrypt(obj.getPassword());	
	            obj.setPassword(encryptPwd);
	        } else {
	            // Default password if not provided
	            obj.setPassword(EncryptDecrypt.encrypt("Password@123"));
	        }
	        
	        obj.setReward_points("100");
	        obj.setStatus("Active"); // Set default status
	        
	        String insertQry = "INSERT INTO user_profile "
	                + "(user_id, user_name, email_id, contact_number, password, "
	                + "base_role, base_project, base_sbu, base_department, reporting_to, "
	                + "created_by, end_date, created_date, reward_points, status) "
	                + "VALUES "
	                + "(:user_id, :user_name, :email_id, :contact_number, :password, "
	                + ":base_role, :base_project, :base_sbu, :base_department, :reporting_to, "
	                + ":created_by, :end_date, GETDATE(), :reward_points, :status)";
	        
	        BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);		 
	        count = namedParamJdbcTemplate.update(insertQry, paramSource);
	        
	        if(count > 0) {
	            flag = true;
	            // Email sending logic (optional)
	            try {
	                EMailSender emailSender = new EMailSender();
	                String login_url = CommonConstants.HOME;
	                Mail mail = new Mail();
	                mail.setMailTo(obj.getEmail_id());
	                mail.setMailSubject("Welcome to CAPEX System");
	                
	                String body = "Dear " + obj.getUser_name() + "<br>"
	                        + "Your account has been created successfully in CAPEX Management System.<br>"
	                        + "User ID: " + obj.getUser_id() + "<br>"
	                        + "Password: Password@123 (Please change after first login)<br><br>"
	                        + "Please login at: <a href='" + login_url + "'>CAPEX System Login</a><br><br>"
	                        + "Best regards,<br>"
	                        + "CAPEX Management Team";
	                
	                emailSender.send(mail.getMailTo(), mail.getMailSubject(), body, obj, "Account Created Successfully");
	            } catch (Exception e) {
	                System.out.println("Email sending failed: " + e.getMessage());
	                // Don't fail the transaction if email fails
	            }
	        }
	        
	        transactionManager.commit(status);
	    } catch (Exception e) {
	        transactionManager.rollback(status);
	        e.printStackTrace();
	        throw new Exception("Error adding user: " + e.getMessage());
	    }
	    return flag;
	}

	public boolean updateUser(User obj) throws Exception {
		int count = 0;
		boolean flag = false;
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = transactionManager.getTransaction(def);
		try {
			NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
			String updateQry = "UPDATE user_profile set user_name=:user_name,email_id=:email_id,contact_number=:contact_number,"
					+ "base_sbu= :base_sbu,base_project= :base_project,base_department= :base_department,base_role= :base_role,reporting_to= :reporting_to,"
					+ "modified_by=:modified_by,modified_date= getdate()  "
					+ "where user_id = :user_id ";
			BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);		 
		    count = namedParamJdbcTemplate.update(updateQry, paramSource);
			if(count > 0) {
				updateUserAccounts(obj);
				flag = true;
				String updateAuditQry = "UPDATE user_profile set status=:status where user_id = :user_id ";
				paramSource = new BeanPropertySqlParameterSource(obj);		 
			    count = namedParamJdbcTemplate.update(updateAuditQry, paramSource);
			}
			transactionManager.commit(status);
		}catch (Exception e) {
			transactionManager.rollback(status);
			e.printStackTrace();
			throw new Exception(e);
		}
		return flag;
	}

	public List<User> getDeptList(User obj) throws Exception {
		List<User> objsList = new ArrayList<User>();
		try {
			String qry = "SELECT user_role FROM user_role "; 
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_role())) {
				qry = qry + "and user_role = ? ";
				arrSize++;
			}
			qry = qry + " order by user_role asc";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_role())) {
				pValues[i++] = obj.getUser_role();
			}	
			objsList = jdbcTemplate.query( qry, pValues, new BeanPropertyRowMapper<User>(User.class));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return objsList;
	}

	public User validateUser(User user) throws Exception {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		User userDetails = null;
		try{  
			con = dataSource.getConnection();
			String qry = "select up.id,up.user_id,up.user_name,up.base_role,up.contact_number,up.email_id,up.base_department,department_name,up.base_sbu,up.base_project,"
					+ "p.plant_name,s.sbu_name from user_profile up "
					+ "LEFT JOIN plant p on up.base_project = p.plant_code  "
					+ "LEFT JOIN sbu s on up.base_sbu = s.sbu  "
					+ "LEFT JOIN department d on up.base_department = d.department_code  "
					+ "where  up.user_name <> '' and up.status = 'Active'";
			if(!StringUtils.isEmpty(user.getUser_name()) && !StringUtils.isEmpty(user.getPassword())){
				qry = qry + "AND up.user_name = ? "; 
				qry = qry + "AND up.password = ? "; 
			}
			stmt = con.prepareStatement(qry);
			if(!StringUtils.isEmpty(user.getUser_name()) && !StringUtils.isEmpty(user.getPassword())){
				stmt.setString(1, user.getUser_name());
				stmt.setString(2, user.getPassword());
			}
			rs = stmt.executeQuery();  
			if(rs.next()) {
				userDetails = new User();
				userDetails.setId(rs.getString("id"));
				userDetails.setUser_id(rs.getString("user_id"));
				userDetails.setUser_name(rs.getString("user_name"));
				userDetails.setEmail_id(rs.getString("email_id"));
				userDetails.setContact_number(rs.getString("contact_number"));
				userDetails.setBase_role(rs.getString("base_role"));
				userDetails.setBase_sbu(rs.getString("base_sbu"));
				userDetails.setBase_project(rs.getString("base_project"));
				userDetails.setProject_name(rs.getString("plant_name"));
				userDetails.setSbu_name(rs.getString("sbu_name"));
				userDetails.setBase_department(rs.getString("base_department"));
				userDetails.setDepartment_name(rs.getString("department_name"));
			}
		}catch(Exception e){ 
			throw new SQLException(e.getMessage());
		}finally {
			DBConnectionHandler.closeJDBCResoucrs(con, stmt, rs);
		}
		return userDetails;
		
	}


	public User getAllPermissions(String base_role) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		User userPermissions = null;
		try{  
			con = dataSource.getConnection();
			String qry = "select role,p_add,p_view,p_edit,p_approvals,p_reports,p_dashboards,p_auto_email from base_role_permissions "
					+ "where  role <> '' ";
			if(!StringUtils.isEmpty(base_role)){
				qry = qry + "AND role = ? "; 
			}
			stmt = con.prepareStatement(qry);
			if(!StringUtils.isEmpty(base_role)){
				stmt.setString(1, base_role);
			}
			rs = stmt.executeQuery();  
			if(rs.next()) {
				userPermissions = new User();
				userPermissions.setRole(rs.getString("role"));
				userPermissions.setP_add(rs.getString("p_add"));
				userPermissions.setP_view(rs.getString("p_view"));
				userPermissions.setP_edit(rs.getString("p_edit"));
				userPermissions.setP_approvals(rs.getString("p_approvals"));
				userPermissions.setP_reports(rs.getString("p_reports"));
				userPermissions.setP_dashboards(rs.getString("p_dashboards"));
				userPermissions.setP_auto_email(rs.getString("p_auto_email"));
			}
		}catch(Exception e){ 
			throw new SQLException(e.getMessage());
		}finally {
			DBConnectionHandler.closeJDBCResoucrs(con, stmt, rs);
		}
		return userPermissions;
	}    
	
	public int checkUserLoginDetails(User obj) throws Exception {
		int totalRecords = 0;
		try {
			NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
			String subQry = " and device_type_no = 2";
			if(!StringUtils.isEmpty(obj.getDevice_type())  && obj.getDevice_type().equals("mobile")) {
				subQry = " and device_type_no = 1";
			}
			String qry = "select count(user_id) from user_audit_log where user_logout_time is null or  user_logout_time = '' "+ subQry;
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_session_id())) {
				qry = qry + " and user_session_id = ? ";
				arrSize++; 
			}	
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_session_id())) {
				pValues[i++] = obj.getUser_session_id();
			}
			totalRecords = jdbcTemplate.queryForObject( qry,pValues,Integer.class);
			if(totalRecords > 0) {
				//String updateQry = "update [user_audit_log] set user_logout_time=GETDATE()  where user_id= :user_id and user_logout_time is null or  user_logout_time = '' ";
				//BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);		 
			   // namedParamJdbcTemplate.update(updateQry, paramSource);
			}
		}catch(Exception e){ 
			e.printStackTrace();
			throw new Exception(e);
		}
		return totalRecords;
		
		
	}



	public int getTotalRecords(User obj, String searchParameter) throws Exception {
	    int totalRecords = 0;
	    try {
	        int arrSize = 0;
	        StringBuilder qry = new StringBuilder();
	        qry.append("SELECT COUNT(DISTINCT up.user_id) as total_records ");
	        qry.append("FROM user_profile up ");
	        qry.append("WHERE up.user_id <> '' AND up.user_id IS NOT NULL ");
	        
	        if(!StringUtils.isEmpty(obj)) {
	            if(!StringUtils.isEmpty(obj.getUser_id())) {
	                qry.append(" AND up.user_id = ? ");
	                arrSize++;
	            }   
	            if(!StringUtils.isEmpty(obj.getStatus())) {
	                qry.append(" AND up.status = ? ");
	                arrSize++;
	            }
	            if(!StringUtils.isEmpty(obj.getProject())) {
	                qry.append(" AND up.base_project = ? ");
	                arrSize++;
	            }
	            if(!StringUtils.isEmpty(obj.getBase_role())) {
	                qry.append(" AND up.base_role = ? ");
	                arrSize++;
	            }
	            if(!StringUtils.isEmpty(obj.getSbu())) {
	                qry.append(" AND up.base_sbu = ? ");
	                arrSize++;
	            }
	            if(!StringUtils.isEmpty(obj.getDesignation_new())) {
	                qry.append(" AND up.designation = ? ");
	                arrSize++;
	            }
	        }
	        
	        if(!StringUtils.isEmpty(searchParameter)) {
	            qry.append(" AND (LOWER(up.user_id) LIKE ? OR LOWER(up.user_name) LIKE ? OR LOWER(up.email_id) LIKE ? ");
	            qry.append(" OR LOWER(up.contact_number) LIKE ? OR LOWER(up.designation) LIKE ? OR LOWER(up.status) LIKE ?) ");
	            arrSize += 6;
	        }   
	        
	        Object[] pValues = new Object[arrSize];
	        int i = 0;
	        
	        if(!StringUtils.isEmpty(obj)) {
	            if(!StringUtils.isEmpty(obj.getUser_id())) {
	                pValues[i++] = obj.getUser_id();
	            }
	            if(!StringUtils.isEmpty(obj.getStatus())) {
	                pValues[i++] = obj.getStatus();
	            }
	            if(!StringUtils.isEmpty(obj.getProject())) {
	                pValues[i++] = obj.getProject();
	            }
	            if(!StringUtils.isEmpty(obj.getBase_role())) {
	                pValues[i++] = obj.getBase_role();
	            }
	            if(!StringUtils.isEmpty(obj.getSbu())) {
	                pValues[i++] = obj.getSbu();
	            }
	            if(!StringUtils.isEmpty(obj.getDesignation_new())) {
	                pValues[i++] = obj.getDesignation_new();
	            }
	        }
	        
	        if(!StringUtils.isEmpty(searchParameter)) {
	            String like = "%" + searchParameter.toLowerCase() + "%";
	            pValues[i++] = like;
	            pValues[i++] = like;
	            pValues[i++] = like;
	            pValues[i++] = like;
	            pValues[i++] = like;
	            pValues[i++] = like;
	        }
	        
	        System.out.println("Executing Count Query: " + qry.toString());
	        System.out.println("Parameters: " + Arrays.toString(pValues));
	        
	        totalRecords = jdbcTemplate.queryForObject(qry.toString(), pValues, Integer.class);
	    } catch(Exception e){ 
	        e.printStackTrace();
	        throw new Exception(e);
	    }
	    return totalRecords;
	}

	public List<User> getUserList(User obj, int startIndex, int offset, String searchParameter) throws Exception {
	    List<User> objsList = null;
	    try {
	        jdbcTemplate = new JdbcTemplate(dataSource);
	        List<Object> paramList = new ArrayList<>();

	        StringBuilder qry = new StringBuilder();
	        qry.append("SELECT DISTINCT ");
	        qry.append("up.id, ");
	        qry.append("up.user_id, ");
	        qry.append("up.user_name, ");
	        qry.append("up.email_id, ");
	        qry.append("up.contact_number, ");
	        qry.append("up.base_role AS designation, ");  // Using base_role as designation
	        qry.append("up.base_sbu, ");
	        qry.append("up.base_project, ");
	        qry.append("up.base_department, ");
	        qry.append("up.status, ");
	        qry.append("up.created_by, ");
	        qry.append("FORMAT(up.created_date, 'dd-MMM-yyyy') AS created_date, ");
	        qry.append("up.modified_by, ");
	        qry.append("FORMAT(up.modified_date, 'dd-MMM-yyyy') AS modified_date ");
	        // Removed reporting_to column
	        
	        qry.append("FROM user_profile up ");
	        qry.append("WHERE up.user_id <> '' AND up.user_id IS NOT NULL ");

	        if (obj != null) {
	            if (!StringUtils.isEmpty(obj.getUser_id())) {
	                qry.append("AND up.user_id = ? ");
	                paramList.add(obj.getUser_id());
	            }
	            if (!StringUtils.isEmpty(obj.getStatus())) {
	                qry.append("AND up.status = ? ");
	                paramList.add(obj.getStatus());
	            }
	            if (!StringUtils.isEmpty(obj.getProject())) {
	                qry.append("AND up.base_project = ? ");
	                paramList.add(obj.getProject());
	            }
	            if (!StringUtils.isEmpty(obj.getBase_role())) {
	                qry.append("AND up.base_role = ? ");
	                paramList.add(obj.getBase_role());
	            }
	            if (!StringUtils.isEmpty(obj.getSbu())) {
	                qry.append("AND up.base_sbu = ? ");
	                paramList.add(obj.getSbu());
	            }
	            if (!StringUtils.isEmpty(obj.getDesignation())) {
	                qry.append("AND up.base_role = ? ");  // Search in base_role for designation
	                paramList.add(obj.getDesignation());
	            }
	        }

	        if (!StringUtils.isEmpty(searchParameter)) {
	            qry.append("AND (LOWER(up.user_id) LIKE ? OR LOWER(up.user_name) LIKE ? OR LOWER(up.email_id) LIKE ? ");
	            qry.append("OR LOWER(up.contact_number) LIKE ? OR LOWER(up.base_role) LIKE ? OR LOWER(up.status) LIKE ?) ");
	            String like = "%" + searchParameter.toLowerCase() + "%";
	            for (int i = 0; i < 6; i++) {
	                paramList.add(like);
	            }
	        }

	        qry.append("ORDER BY up.user_name ASC ");

	        if (startIndex >= 0 && offset > 0) {
	            qry.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
	            paramList.add(startIndex);
	            paramList.add(offset);
	        }

	        System.out.println("Executing Pagination Query: " + qry.toString());
	        System.out.println("Parameters: " + paramList);

	        objsList = jdbcTemplate.query(qry.toString(), paramList.toArray(), new BeanPropertyRowMapper<>(User.class));
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception(e);
	    }
	    return objsList;
	}


	public boolean updateUser(User obj) throws Exception {
	    int count = 0;
	    boolean flag = false;
	    TransactionDefinition def = new DefaultTransactionDefinition();
	    TransactionStatus status = transactionManager.getTransaction(def);
	    try {
	        NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
	        String updateQry = "UPDATE user_profile set user_name=:user_name,email_id=:email_id,contact_number=:contact_number,"
	                + "base_sbu= :base_sbu,base_project= :base_project,base_department= :base_department,base_role= :base_role,"
	                + "modified_by=:modified_by,modified_date= getdate()  "
	                + "where user_id = :user_id ";
	        BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);		 
	        count = namedParamJdbcTemplate.update(updateQry, paramSource);
	        
	        if(count > 0) {
	            flag = true;
	        }
	        transactionManager.commit(status);
	    }catch (Exception e) {
	        transactionManager.rollback(status);
	        e.printStackTrace();
	        throw new Exception(e);
	    }
	    return flag;
	}
	
	public boolean deleteProject(User obj) throws Exception {
		boolean flag = false;
		try {
			String sql = "DELETE FROM user_profile WHERE user_id = ?";
		    Object[] args = new Object[] {obj.getUser_id()};
		    flag =  jdbcTemplate.update(sql, args) == 1;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return flag;
	}

	public List<User> getDeptFilterList(User obj) throws Exception {
		List<User> objsList = new ArrayList<User>();
		try {
			String qry = "SELECT  count(user_role) as count ,(select count(user_name) from user_profile) as totalCount, user_role FROM user_profile where user_role is not null and user_role <> '' group by user_role "; 
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_role())) {
				qry = qry + "and user_role = ? ";
				arrSize++;
			}
			qry = qry + " order by user_role asc";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_role())) {
				pValues[i++] = obj.getUser_role();
			}	
			objsList = jdbcTemplate.query( qry, pValues, new BeanPropertyRowMapper<User>(User.class));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return objsList;
	}

	public  boolean UserLoginActions(User obj) throws Exception {
		boolean flag = false;
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = transactionManager.getTransaction(def);
		try {
			obj.setModule_type("User");
			obj.setMessage("User Action");
			obj.setDevice_type_no("1");
			if(!StringUtils.isEmpty(obj.getDevice_type())  && obj.getDevice_type().equals("desktop")) {
				obj.setDevice_type_no("2");
			}
			NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
			String insertQry = "INSERT INTO user_audit_log (module_id,module_type,message,user_id,user_session_id,device_type,device_type_no,user_login_time)"
					+ " values (:id,:module_type,:message,:user_id,:user_session_id,:device_type,:device_type_no,GETDATE())";
			BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);		 
		    namedParamJdbcTemplate.update(insertQry, paramSource);
			transactionManager.commit(status);
		}catch (Exception e) {
			transactionManager.rollback(status);
			e.printStackTrace();
			throw new Exception(e);
		}
		return flag;
	}


	public  boolean UserLogOutActions(User obj) throws Exception {
		boolean flag = false;
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = transactionManager.getTransaction(def);
		try {
			NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
			String insertQry = "Update  user_audit_log set user_logout_time = GETDATE() where "
					+ " user_login_time IN (SELECT max(user_login_time) FROM user_audit_log )  and  module_id = :id";
			BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);		 
		    namedParamJdbcTemplate.update(insertQry, paramSource);
			transactionManager.commit(status);
		}catch (Exception e) {
			transactionManager.rollback(status);
			e.printStackTrace();
			throw new Exception(e);
		}
		return flag;
		
	}

	public List<User> getMenuList() throws SQLException {
		List<User> menuList = null;
		try{  
			String qry = "select id, module_name, module_url from form_menu where project is null or project = 'safety' order by priority asc ";
			menuList = jdbcTemplate.query( qry, new BeanPropertyRowMapper<User>(User.class));
			
		}catch(Exception e){ 
			e.printStackTrace();
			throw new SQLException(e.getMessage());
		}
		return menuList;
	}

	public List<User> getUserFilterList(User obj) throws Exception {
		List<User> objsList = new ArrayList<User>();
		try {
			String qry = "SELECT up.user_id,up.user_name FROM user_profile up "
					+ "left join user_profile ua on up.user_id = ua.user_id where up.user_id <> '' ";
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_id())) {
				qry = qry + " and up.user_id = ? ";
				arrSize++;
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				qry = qry + " and ua.status = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject())) {
				qry = qry + " and up.base_project = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getBase_role())) {
				qry = qry + " and up.base_role = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				qry = qry + " and up.base_sbu = ? ";
				arrSize++;
			}
			qry = qry + "group by up.user_id,up.user_name ";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_id())) {
				pValues[i++] = obj.getUser_id();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				pValues[i++] = obj.getStatus();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject())) {
				pValues[i++] = obj.getProject();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getBase_role())) {
				pValues[i++] = obj.getBase_role();
			}
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

	public List<User> getStatusFilterListFromUser(User obj) throws Exception {
		List<User> objsList = new ArrayList<User>();
		try {
			String qry = "SELECT ua.status FROM user_profile up "
					+ "left join user_profile ua on up.user_id = ua.user_id where up.user_id <> '' ";
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_id())) {
				qry = qry + " and up.user_id = ? ";
				arrSize++;
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				qry = qry + " and ua.status = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject())) {
				qry = qry + " and up.base_project = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getBase_role())) {
				qry = qry + " and up.base_role = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				qry = qry + " and up.base_sbu = ? ";
				arrSize++;
			}

			qry = qry + "group by ua.status ";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_id())) {
				pValues[i++] = obj.getUser_id();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				pValues[i++] = obj.getStatus();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject())) {
				pValues[i++] = obj.getProject();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getBase_role())) {
				pValues[i++] = obj.getBase_role();
			}
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

	public List<User> getReportingTosList(User obj) throws SQLException {
		List<User> menuList = null;
		try{  
			String qry = "select user_id,user_name from user_profile";
			menuList = jdbcTemplate.query( qry, new BeanPropertyRowMapper<User>(User.class));
			
		}catch(Exception e){ 
			e.printStackTrace();
			throw new SQLException(e.getMessage());
		}
		return menuList;
	}

	public List<RoleMapping> getDeptsList() throws SQLException {
		List<RoleMapping> menuList = null;
		try{  
			String qry = "SELECT department_code ,department_name FROM department d "
					+ " where d.department_code is not null and  d.department_code <> ''  "; 
			menuList = jdbcTemplate.query( qry, new BeanPropertyRowMapper<RoleMapping>(RoleMapping.class));
		}catch(Exception e){ 
			e.printStackTrace();
			throw new SQLException(e.getMessage());
		}
		return menuList;
	}

	public List<User> getRoleFilterListInUser(User obj) throws Exception {
		List<User> objsList = new ArrayList<User>();
		try {
			String qry = "SELECT up.base_role FROM user_profile up "
					+ "left join user_profile ua on up.user_id = ua.user_id  "
					+ " where up.base_role <> '' and up.base_role is not null  ";
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_id())) {
				qry = qry + " and up.user_id = ? ";
				arrSize++;
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				qry = qry + " and ua.status = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject())) {
				qry = qry + " and up.base_project = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getBase_role())) {
				qry = qry + " and up.base_role = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				qry = qry + " and up.base_sbu = ? ";
				arrSize++;
			}

			qry = qry + "group by up.base_role ";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_id())) {
				pValues[i++] = obj.getUser_id();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				pValues[i++] = obj.getStatus();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject())) {
				pValues[i++] = obj.getProject();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getBase_role())) {
				pValues[i++] = obj.getBase_role();
			}
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

	public List<User> getSBUFilterListInUser(User obj) throws Exception {
		List<User> objsList = new ArrayList<User>();
		try {
			String qry = "SELECT s.sbu_code,sbu_name FROM user_profile up "
					+ "left join user_profile ua on up.user_id = ua.user_id  "
					+ "left join sbu s on up.base_sbu = s.sbu_code  "
					+ " where up.base_sbu <> '' and up.base_sbu is not null ";
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_id())) {
				qry = qry + " and up.user_id = ? ";
				arrSize++;
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				qry = qry + " and ua.status = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject())) {
				qry = qry + " and up.base_project = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getBase_role())) {
				qry = qry + " and up.base_role = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				qry = qry + " and up.base_sbu = ? ";
				arrSize++;
			}

			qry = qry + "group by s.sbu_code,sbu_name ";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_id())) {
				pValues[i++] = obj.getUser_id();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				pValues[i++] = obj.getStatus();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject())) {
				pValues[i++] = obj.getProject();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getBase_role())) {
				pValues[i++] = obj.getBase_role();
			}
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

	public List<User> getProjectFilterListInUser(User obj) throws Exception {
		List<User> objsList = new ArrayList<User>();
		try {
			String qry = "SELECT p.project_code,project_name FROM user_profile up "
					+ "left join user_profile ua on up.user_id = ua.user_id  "
					+ "left join project p on p.project_code = up.base_project   "
					+ " where up.base_project <> '' and up.base_project is not null ";
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_id())) {
				qry = qry + " and up.user_id = ? ";
				arrSize++;
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				qry = qry + " and ua.status = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject())) {
				qry = qry + " and up.base_project = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getBase_role())) {
				qry = qry + " and up.base_role = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				qry = qry + " and up.base_sbu = ? ";
				arrSize++;
			}

			qry = qry + "group by p.project_code,project_name ";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_id())) {
				pValues[i++] = obj.getUser_id();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				pValues[i++] = obj.getStatus();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject())) {
				pValues[i++] = obj.getProject();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getBase_role())) {
				pValues[i++] = obj.getBase_role();
			}
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

	public List<User> getRewardsHistory(User user) throws Exception {
		List<User> objsList = new ArrayList<User>();
		try {
			String qry = "SELECT[action],sum(rh.reward_points) + 100 as reward_points,up.user_name,up.user_id FROM rewards_history rh "
					+ "left join user_profile up on rh.user_id = up.user_id where action like '%Incident%' "
					+ " and up.user_id is not null   ";
			int arrSize = 0;
			if(!StringUtils.isEmpty(user) && (!CommonConstants.ADMIN.equals(user.getRole()) && !CommonConstants.MANAGEMENT.equals(user.getRole()))
					&& !StringUtils.isEmpty(user.getUser_id())  ) {
				qry = qry + " and up.user_id = ? ";
				arrSize++;
			}
			
			qry = qry + "group by up.user_id,action,user_name order by sum(rh.reward_points) + 100 desc ";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(user) && (!CommonConstants.ADMIN.equals(user.getRole()) && !CommonConstants.MANAGEMENT.equals(user.getRole()))
					&& !StringUtils.isEmpty(user.getUser_id())  ) {
				pValues[i++] = user.getUser_id();
			}
		
			objsList = jdbcTemplate.query( qry, pValues, new BeanPropertyRowMapper<User>(User.class));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return objsList;
	}

	public boolean addUser(User obj) throws Exception {
	    int count = 0;
	    boolean flag = false;
	    TransactionDefinition def = new DefaultTransactionDefinition();
	    TransactionStatus status = transactionManager.getTransaction(def);
	    try {
	        NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
	        if(!StringUtils.isEmpty(obj.getPassword())) {
	            String encryptPwd = EncryptDecrypt.encrypt(obj.getPassword());	
	            obj.setPassword(encryptPwd);
	        }
	        obj.setReward_points("100");
	        String insertQry = "INSERT INTO user_profile "
	                + "(user_id,user_name,email_id,contact_number,base_role,base_project,base_sbu,base_department,created_by,end_date,created_date,reward_points,password,status)"
	                + " VALUES "
	                + "(:user_id,:user_name,:email_id,:contact_number,:base_role,:base_project,:base_sbu,:base_department,:created_by,:end_date,getdate(),:reward_points,:password,'Active')";
	        BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);		 
	        count = namedParamJdbcTemplate.update(insertQry, paramSource);
	        
	        if(count > 0) {
	            flag = true;
	            // Send email logic here
	        }
	        transactionManager.commit(status);
	    }catch (Exception e) {
	        transactionManager.rollback(status);
	        e.printStackTrace();
	        throw new Exception(e);
	    }
	    return flag;
	}

	public List<User> getProjectListForUser(User obj) throws Exception {
		List<User> objsList = new ArrayList<User>();
		try {
			String qry = "SELECT p.project_code,project_name FROM project p "
					+ "left join sbu s on p.sbu_code = s.sbu_code  "
					+ " where p.project_code <> '' and p.project_code is not null ";
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getBase_sbu())) {
				qry = qry + " and p.sbu_code = ? ";
				arrSize++;
			}	
			qry = qry + "group by p.project_code,project_name ";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getBase_sbu())) {
				pValues[i++] = obj.getBase_sbu();
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
			String qry = "SELECT d.department_code ,department_name,assigned_to_sbu FROM department d "
					+ " where d.department_code <> '' and d.department_code is not null ";
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getBase_sbu())) {
				qry = qry + "and  d.assigned_to_sbu like ('%"+obj.getBase_sbu()+"%') ";
			}	
			
			objsList = jdbcTemplate.query( qry, new BeanPropertyRowMapper<User>(User.class));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return objsList;
	}

	public List<User> getUserActionsForNotification(User obj) throws Exception {
		List<User> objsList = new ArrayList<User>();
		try {
			String qry = "SELECT TOP (10) module_type,message,user_id,create_date FROM user_audit_log  "
					+ " where user_id <> '' and user_id is not null ";
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_id())) {
				qry = qry + " and user_id = ? ";
				arrSize++;
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getLast_sync_time())) {
				qry = qry + " and create_date >= ? ";
				arrSize++;
			}	
			qry = qry + " and module_type <> 'User' order by create_date desc";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getUser_id())) {
				pValues[i++] = obj.getUser_id();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getLast_sync_time())) {
				pValues[i++] = obj.getLast_sync_time();
			}
			objsList = jdbcTemplate.query( qry, pValues, new BeanPropertyRowMapper<User>(User.class));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return objsList;
	}

	public boolean otpLog(IRM irm) throws Exception {
		int count = 0;
		boolean flag = false;
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = transactionManager.getTransaction(def);
		try {
			NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
			
			String insertQry = "INSERT INTO otp_log "
					+ "(email_id,otp_code,created_datetime,expired_datetime)"
					+ " VALUES "
					+ "(:email_id,:otp_code,getdate(),DATEADD(MINUTE, 15, GETDATE()))";
			BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(irm);		 
		    count = namedParamJdbcTemplate.update(insertQry, paramSource);
		   
			if(count > 0) {
				flag = true;
			}
			transactionManager.commit(status);
		}catch (Exception e) {
			transactionManager.rollback(status);
			e.printStackTrace();
			throw new Exception(e);
		}
		return flag;
	}

	public boolean verifyOtp(IRM irm) throws Exception {
		List<User> objsList = new ArrayList<User>();
		boolean flag = false ;
		try {
			String qry = "SELECT TOP (1)  * FROM otp_log "
					+ "WHERE (select max(expired_datetime) from  otp_log) > GETDATE()  and email_id ='"+irm.getEmail_id()+"' and otp_code ='"+irm.getOtp_code()+"'  order by expired_datetime desc ";
		
			objsList = jdbcTemplate.query( qry, new BeanPropertyRowMapper<User>(User.class));
			if(objsList.size() > 0) {
				flag = true ;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return flag;
	}

}
