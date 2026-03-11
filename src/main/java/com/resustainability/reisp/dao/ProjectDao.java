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

import com.resustainability.reisp.model.Project;
import com.resustainability.reisp.model.SBU;
import com.resustainability.reisp.model.SBU;
import com.resustainability.reisp.model.Project;
import com.resustainability.reisp.model.Project;

@Repository
public class ProjectDao {

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	DataSource dataSource;

	@Autowired
	DataSourceTransactionManager transactionManager;

	public List<Project> getProjectsList(Project obj) throws Exception {
		List<Project> objsList = null;
		try {
			int arrSize = 0;
			String qry =" select ";
					qry = qry +"(select count( plant_code) from plant where plant_code is not null  ";
					if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
						qry = qry + " and status = ? ";
						arrSize++;
					}
					if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
						qry = qry + " and company_code = ? ";
						arrSize++;
					}
					if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
						qry = qry + "and plant_code = ? ";
						arrSize++;
					}
					if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
						qry = qry + " and sbu = ? ";
						arrSize++;
					}
					qry = qry +  " ) as all_plants ,";
					qry = qry +	"(select count( plant_code) from plant where plant_code is not null and status = 'Active' ";
									if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
										qry = qry + "  and status = ? ";
										arrSize++;
									}
									if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
										qry = qry + " and company_code = ? ";
										arrSize++;
									}
									if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
										qry = qry + "and plant_code = ? ";
										arrSize++;
									}
									if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
										qry = qry + " and sbu = ? ";
										arrSize++;
									}
									qry = qry + " ) as active_plants,"
									+ "(select count( plant_code) from plant where plant_code is not null   and status <> 'Active' ";
									if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
										qry = qry + " and status = ? ";
										arrSize++;
									}
									if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
										qry = qry + " and company_code = ? ";
										arrSize++;
									}
									if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
										qry = qry + "and plant_code = ? ";
										arrSize++;
									}
									if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
										qry = qry + " and sbu = ? ";
										arrSize++;
									}
									qry = qry + " ) as inActive_plants,"
					+ "p.id	,plant_code,	plant_name,p.company_code,p.sbu,c.company_name,s.sbu_name,	p.status,	FORMAT (p.created_date, 'dd-MMM-yy') as created_date,up.user_name as 	"
					+ " created_by,FORMAT	(p.modified_date, 'dd-MMM-yy') as modified_date,up1.user_name as  modified_by from plant p "
					+ " left join user_profile up on p.created_by = up.user_id "
					+ " left join user_profile up1 on p.modified_by = up1.user_id "
					+ " left join company c on  p.company_code = c.company_code "
					+ " left join sbu s on p.sbu = s.sbu "
					+ " where p.plant_code is not null and p.plant_code <> '' ";
			
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				qry = qry + " and c.company_code = ?";
				arrSize++;
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				qry = qry + " and p.status = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				qry = qry + "and plant_code = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				qry = qry + " and p.sbu = ? ";
				arrSize++;
			}
			qry = qry + " ORDER BY p.status ASC ";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				pValues[i++] = obj.getStatus();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				pValues[i++] = obj.getCompany_code();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				pValues[i++] = obj.getProject_code();
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				pValues[i++] = obj.getSbu();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				pValues[i++] = obj.getStatus();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				pValues[i++] = obj.getCompany_code();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				pValues[i++] = obj.getProject_code();
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				pValues[i++] = obj.getSbu();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				pValues[i++] = obj.getStatus();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				pValues[i++] = obj.getCompany_code();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				pValues[i++] = obj.getProject_code();
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				pValues[i++] = obj.getSbu();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				pValues[i++] = obj.getCompany_code();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				pValues[i++] = obj.getStatus();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				pValues[i++] = obj.getProject_code();
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				pValues[i++] = obj.getSbu();
			}
			objsList = jdbcTemplate.query( qry,pValues, new BeanPropertyRowMapper<Project>(Project.class));
		
		}catch(Exception e){ 
			e.printStackTrace();
			throw new Exception(e);
		}
		return objsList;
	}

	public List<Project> getCompanyFilterList(Project obj) throws Exception {
		List<Project> objsList = new ArrayList<Project>();
		try {
			String qry = "SELECT  p.company_code,	c.company_name  "
					+ " FROM plant p  "
					+ " left join company c on  p.company_code = c.company_code "
					+ "where plant_code is not null and plant_code <> ''  "; 
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				qry = qry + "and company_code = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				qry = qry + " and p.status = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				qry = qry + "and plant_code = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				qry = qry + " and p.sbu = ? ";
				arrSize++;
			}
			qry = qry + "  group by p.company_code,c.company_name order by company_code asc";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				pValues[i++] = obj.getCompany_code();
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				pValues[i++] = obj.getStatus();
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				pValues[i++] = obj.getProject_code();
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				pValues[i++] = obj.getSbu();
			}
			objsList = jdbcTemplate.query( qry, pValues, new BeanPropertyRowMapper<Project>(Project.class));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return objsList;
	}

	public List<Project> getProjectFilterList(Project obj) throws Exception {
		List<Project> objsList = new ArrayList<Project>();
		try {
			String qry = "SELECT  id,	plant_code,	plant_name,	status "
					+ " FROM plant p  where plant_code is not null and plant_code <> ''  "; 
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				qry = qry + "and company_code = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				qry = qry + " and status = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				qry = qry + "and plant_code = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				qry = qry + " and p.sbu = ? ";
				arrSize++;
			}
			qry = qry + "  group by plant_code,id,plant_name,status order by plant_code asc";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				pValues[i++] = obj.getCompany_code();
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				pValues[i++] = obj.getStatus();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				pValues[i++] = obj.getProject_code();
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				pValues[i++] = obj.getSbu();
			}
			objsList = jdbcTemplate.query( qry, pValues, new BeanPropertyRowMapper<Project>(Project.class));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return objsList;
	}

	public List<Project> getStatusFilterList(Project obj) throws Exception {
		List<Project> objsList = new ArrayList<Project>();
		try {
			String qry = "SELECT  status "
					+ " FROM plant p  where status is not null and status <> ''  "; 
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				qry = qry + "and status = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				qry = qry + " and company_code = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				qry = qry + "and plant_code = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				qry = qry + " and p.sbu = ? ";
				arrSize++;
			}
			qry = qry + " group by  status order by status asc";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				pValues[i++] = obj.getStatus();
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				pValues[i++] = obj.getCompany_code();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				pValues[i++] = obj.getProject_code();
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				pValues[i++] = obj.getSbu();
			}
			objsList = jdbcTemplate.query( qry, pValues, new BeanPropertyRowMapper<Project>(Project.class));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return objsList;
	}

	public boolean addProject(Project obj) throws Exception {
		int count = 0;
		boolean flag = false;
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = transactionManager.getTransaction(def);
		try {
			NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
			String insertQry = "INSERT INTO plant (plant_name,plant_code,company_code,sbu,status,created_by) VALUES (:plant_name,:plant_code,:company_code,:sbu,:status,:created_by)";
			BeanPropertySqlParameterSource paramSource = new BeanPropertySqlParameterSource(obj);		 
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

	public boolean updateProject(Project obj) throws Exception {
		int count = 0;
		boolean flag = false;
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = transactionManager.getTransaction(def);
		try {
			NamedParameterJdbcTemplate namedParamJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
			String updateQry = "UPDATE plant set plant_name= :plant_name,company_code= :company_code,sbu= :sbu,plant_code= :plant_code,status=:status,modified_by= :modified_by "
					+ " where id= :id ";
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

	public List<Project> getSBUsList(Project obj) throws Exception {
		List<Project> objsList = new ArrayList<Project>();
		try {
			String qry = "SELECT  p.sbu,sbu_name "
					+ " FROM plant p  "
					+ "left join sbu s on p.sbu = s.sbu "
					+ " where p.sbu is not null and p.sbu <> ''  "; 
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				qry = qry + "and p.status = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				qry = qry + " and p.company_code = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				qry = qry + "and plant_code = ? ";
				arrSize++;
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				qry = qry + " and p.sbu = ? ";
				arrSize++;
			}
			qry = qry + " group by  p.sbu,sbu_name";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getStatus())) {
				pValues[i++] = obj.getStatus();
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				pValues[i++] = obj.getCompany_code();
			}
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				pValues[i++] = obj.getProject_code();
			}	
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getSbu())) {
				pValues[i++] = obj.getSbu();
			}
			objsList = jdbcTemplate.query( qry, pValues, new BeanPropertyRowMapper<Project>(Project.class));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return objsList;
	}

	public List<SBU> getCompaniesList(Project obj) throws SQLException {
		List<SBU> menuList = null;
		try{  
			String qry = "select  company_name, company_code from company";
			menuList = jdbcTemplate.query( qry, new BeanPropertyRowMapper<SBU>(SBU.class));
			
		}catch(Exception e){ 
			e.printStackTrace();
			throw new SQLException(e.getMessage());
		}
		return menuList;
	}

	public List<SBU> getSbuList(Project obj) throws SQLException {
		List<SBU> menuList = null;
		try{  
			String qry = "select sbu_name, sbu,company_code from sbu";
			menuList = jdbcTemplate.query( qry, new BeanPropertyRowMapper<SBU>(SBU.class));
			
		}catch(Exception e){ 
			e.printStackTrace();
			throw new SQLException(e.getMessage());
		}
		return menuList;
	}

	public List<Project> getFilteredSBUsList(Project obj) throws Exception {
		List<Project> objsList = new ArrayList<Project>();
		try {
			String qry = "SELECT  sbu,sbu_name,company_code  "
					+ " FROM sbu   "
					+ " where sbu is not null and sbu <> ''  "; 
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				qry = qry + "and company_code = ? ";
				arrSize++;
			}
			qry = qry + " group by  sbu,sbu_name,company_code ";
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getCompany_code())) {
				pValues[i++] = obj.getCompany_code();
			}	
			objsList = jdbcTemplate.query( qry, pValues, new BeanPropertyRowMapper<Project>(Project.class));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return objsList;
	}

	public List<Project> checkUniqueIfForProject(Project obj) throws Exception {
		List<Project> objsList = new ArrayList<Project>();
		try {
			String qry = "SELECT plant_code FROM plant  "
					+ " where status is not null and status <> ''  "; 
			int arrSize = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				qry = qry + " and plant_code = ?";
				arrSize++;
			}	
			Object[] pValues = new Object[arrSize];
			int i = 0;
			if(!StringUtils.isEmpty(obj) && !StringUtils.isEmpty(obj.getProject_code())) {
				pValues[i++] = obj.getProject_code();
			}
			
			objsList = jdbcTemplate.query( qry, pValues, new BeanPropertyRowMapper<Project>(Project.class));
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return objsList;
	}
}
