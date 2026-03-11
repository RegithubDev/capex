package com.resustainability.reisp.model;

import java.sql.Timestamp;

public class CapexProposal {

    private int id;
    private Long idVal;
    private String capex_title,department_name;
    private String capex_number,role_type;
    private String department,project_manager_fullname;
    private String business_unit,current_pending_at,total_available_budget_fy;
    private String plant_code;
    private String plant_name;
    private String location,pendingAt;
    private String asset_description;

    private String basic_cost;
    private String gst_rate;
    private String gst_amount;
    private String total_cost;

    // ROI
    private String roi_text;
    private String roi_file_name;
    private String roi_file_path;

    // Timeline
    private String timeline_text;
    private String timeline_file_name;
    private String timeline_file_path;

    // Reason
    private String reason_text;
    private String reason_file_name;
    private String reason_file_path;

    // Prepared By
    private String prepared_by_name;
    private String prepared_by_designation;
    private Timestamp   prepared_by_date;
    private String prepared_by_signature_path;

    // Project Manager
    private String project_manager_name;
    private String project_manager_designation;
    private Timestamp   project_manager_date;
    private String project_manager_signature_path;

    // Requested By
    private String requested_by_name;
    private String requested_by_designation;
    private Timestamp   requested_by_date;
    private String requested_by_signature_path;

    // Head of Plant
    private String head_of_plant_name;
    private String head_of_plant_designation;
    private Timestamp   head_of_plant_date;
    private String head_of_plant_signature_path;

    // Finance
    private String finance_department;
    private String finance_category;
    private String total_budget;
    private String proposed_price;
    private String available_balance;
    private String finance_status;
    private String finance_name;
    private String finance_designation;
    private Timestamp   finance_date;
    private String finance_comments;

    // Head Projects
    private String head_projects_name;
    private String head_projects_designation;
    private Timestamp   head_projects_date;
    private String head_projects_comment;
    private String head_projects_signature_path;

    // Business Head
    private String business_head_name;
    private String business_head_designation;
    private Timestamp   business_head_date;
    private String business_head_comment;
    private String business_head_signature_path;

    // CFO
    private String cfo_name;
    private String cfo_designation;
    private Timestamp   cfo_date;
    private String cfo_comment;
    private String cfo_signature_path;

    // CEO
    private String ceo_name,remarks;
    private String ceo_designation;
    private Timestamp   ceo_date;
    private String ceo_comment;
    private String ceo_signature_path;

    private String status,regional_director_date,role,regional_director_comment;
    private String created_by,user_name;
    private Timestamp created_at;
    private Timestamp updated_at;

    private int phase_one = 1;
    private int phase_two = 0;
    private int phase_three = 0;
    private int phase_four = 0;
    
    
    
public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
public String getProject_manager_fullname() {
		return project_manager_fullname;
	}
	public void setProject_manager_fullname(String project_manager_fullname) {
		this.project_manager_fullname = project_manager_fullname;
	}
	public String getTotal_available_budget_fy() {
		return total_available_budget_fy;
	}
	public void setTotal_available_budget_fy(String total_available_budget_fy) {
		this.total_available_budget_fy = total_available_budget_fy;
	}
public String getRole_type() {
		return role_type;
	}
	public void setRole_type(String role_type) {
		this.role_type = role_type;
	}
public String getDepartment_name() {
		return department_name;
	}
	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}
public String getRegional_director_comment() {
		return regional_director_comment;
	}
	public void setRegional_director_comment(String regional_director_comment) {
		this.regional_director_comment = regional_director_comment;
	}
public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
public String getPendingAt() {
		return pendingAt;
	}
	public void setPendingAt(String pendingAt) {
		this.pendingAt = pendingAt;
	}
public String getRegional_director_date() {
		return regional_director_date;
	}
	public void setRegional_director_date(String regional_director_date) {
		this.regional_director_date = regional_director_date;
	}
public String getBasic_cost() {
		return basic_cost;
	}
	public void setBasic_cost(String basic_cost) {
		this.basic_cost = basic_cost;
	}
	public String getGst_rate() {
		return gst_rate;
	}
	public void setGst_rate(String gst_rate) {
		this.gst_rate = gst_rate;
	}
	public String getGst_amount() {
		return gst_amount;
	}
	public void setGst_amount(String gst_amount) {
		this.gst_amount = gst_amount;
	}
	public String getTotal_cost() {
		return total_cost;
	}
	public void setTotal_cost(String total_cost) {
		this.total_cost = total_cost;
	}
private String site_head_name
,site_head_employee_id
,site_head_email
,site_finance_head_name
,site_finance_head_designation
,site_finance_head_employee_id
,site_finance_head_email,finance_controller_comment
,finance_controller_name,finance_controller_date
,finance_controller_employee_id
,finance_controller_email
,regional_director_name
,regional_director_employee_id
,regional_director_email
,bu_head_name
,bu_head_employee_id
,bu_head_email
,project_head_name
,project_head_employee_id
,project_head_email
,cfo_employee_id
,cfo_email
,ceo_employee_id
,ceo_email;
    
    public String getFinance_controller_comment() {
	return finance_controller_comment;
}
public void setFinance_controller_comment(String finance_controller_comment) {
	this.finance_controller_comment = finance_controller_comment;
}
	public String getFinance_controller_date() {
	return finance_controller_date;
}
public void setFinance_controller_date(String finance_controller_date) {
	this.finance_controller_date = finance_controller_date;
}
	public String getSite_head_name() {
	return site_head_name;
}
public void setSite_head_name(String site_head_name) {
	this.site_head_name = site_head_name;
}
public String getSite_head_employee_id() {
	return site_head_employee_id;
}
public void setSite_head_employee_id(String site_head_employee_id) {
	this.site_head_employee_id = site_head_employee_id;
}
public String getSite_head_email() {
	return site_head_email;
}
public void setSite_head_email(String site_head_email) {
	this.site_head_email = site_head_email;
}
public String getSite_finance_head_name() {
	return site_finance_head_name;
}
public void setSite_finance_head_name(String site_finance_head_name) {
	this.site_finance_head_name = site_finance_head_name;
}
public String getSite_finance_head_designation() {
	return site_finance_head_designation;
}
public void setSite_finance_head_designation(String site_finance_head_designation) {
	this.site_finance_head_designation = site_finance_head_designation;
}
public String getSite_finance_head_employee_id() {
	return site_finance_head_employee_id;
}
public void setSite_finance_head_employee_id(String site_finance_head_employee_id) {
	this.site_finance_head_employee_id = site_finance_head_employee_id;
}
public String getSite_finance_head_email() {
	return site_finance_head_email;
}
public void setSite_finance_head_email(String site_finance_head_email) {
	this.site_finance_head_email = site_finance_head_email;
}
public String getFinance_controller_name() {
	return finance_controller_name;
}
public void setFinance_controller_name(String finance_controller_name) {
	this.finance_controller_name = finance_controller_name;
}
public String getFinance_controller_employee_id() {
	return finance_controller_employee_id;
}
public void setFinance_controller_employee_id(String finance_controller_employee_id) {
	this.finance_controller_employee_id = finance_controller_employee_id;
}
public String getFinance_controller_email() {
	return finance_controller_email;
}
public void setFinance_controller_email(String finance_controller_email) {
	this.finance_controller_email = finance_controller_email;
}
public String getRegional_director_name() {
	return regional_director_name;
}
public void setRegional_director_name(String regional_director_name) {
	this.regional_director_name = regional_director_name;
}
public String getRegional_director_employee_id() {
	return regional_director_employee_id;
}
public void setRegional_director_employee_id(String regional_director_employee_id) {
	this.regional_director_employee_id = regional_director_employee_id;
}
public String getRegional_director_email() {
	return regional_director_email;
}
public void setRegional_director_email(String regional_director_email) {
	this.regional_director_email = regional_director_email;
}
public String getBu_head_name() {
	return bu_head_name;
}
public void setBu_head_name(String bu_head_name) {
	this.bu_head_name = bu_head_name;
}
public String getBu_head_employee_id() {
	return bu_head_employee_id;
}
public void setBu_head_employee_id(String bu_head_employee_id) {
	this.bu_head_employee_id = bu_head_employee_id;
}
public String getBu_head_email() {
	return bu_head_email;
}
public void setBu_head_email(String bu_head_email) {
	this.bu_head_email = bu_head_email;
}
public String getProject_head_name() {
	return project_head_name;
}
public void setProject_head_name(String project_head_name) {
	this.project_head_name = project_head_name;
}
public String getProject_head_employee_id() {
	return project_head_employee_id;
}
public void setProject_head_employee_id(String project_head_employee_id) {
	this.project_head_employee_id = project_head_employee_id;
}
public String getProject_head_email() {
	return project_head_email;
}
public void setProject_head_email(String project_head_email) {
	this.project_head_email = project_head_email;
}
public String getCfo_employee_id() {
	return cfo_employee_id;
}
public void setCfo_employee_id(String cfo_employee_id) {
	this.cfo_employee_id = cfo_employee_id;
}
public String getCfo_email() {
	return cfo_email;
}
public void setCfo_email(String cfo_email) {
	this.cfo_email = cfo_email;
}
public String getCeo_employee_id() {
	return ceo_employee_id;
}
public void setCeo_employee_id(String ceo_employee_id) {
	this.ceo_employee_id = ceo_employee_id;
}
public String getCeo_email() {
	return ceo_email;
}
public void setCeo_email(String ceo_email) {
	this.ceo_email = ceo_email;
}
	public int getPhase_four() {
		return phase_four;
	}
	public void setPhase_four(int phase_four) {
		this.phase_four = phase_four;
	}
	public String getCurrent_pending_at() {
		return current_pending_at;
	}
	public void setCurrent_pending_at(String current_pending_at) {
		this.current_pending_at = current_pending_at;
	}
	public Long getIdVal() {
		return idVal;
	}
	public void setIdVal(Long idVal) {
		this.idVal = idVal;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCapex_title() {
		return capex_title;
	}
	public void setCapex_title(String capex_title) {
		this.capex_title = capex_title;
	}
	public String getCapex_number() {
		return capex_number;
	}
	public void setCapex_number(String capex_number) {
		this.capex_number = capex_number;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getBusiness_unit() {
		return business_unit;
	}
	public void setBusiness_unit(String business_unit) {
		this.business_unit = business_unit;
	}
	public String getPlant_code() {
		return plant_code;
	}
	public void setPlant_code(String plant_code) {
		this.plant_code = plant_code;
	}
	public String getPlant_name() {
		return plant_name;
	}
	public void setPlant_name(String plant_name) {
		this.plant_name = plant_name;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getAsset_description() {
		return asset_description;
	}
	public void setAsset_description(String asset_description) {
		this.asset_description = asset_description;
	}
	
	public String getRoi_text() {
		return roi_text;
	}
	public void setRoi_text(String roi_text) {
		this.roi_text = roi_text;
	}
	public String getRoi_file_name() {
		return roi_file_name;
	}
	public void setRoi_file_name(String roi_file_name) {
		this.roi_file_name = roi_file_name;
	}
	public String getRoi_file_path() {
		return roi_file_path;
	}
	public void setRoi_file_path(String roi_file_path) {
		this.roi_file_path = roi_file_path;
	}
	public String getTimeline_text() {
		return timeline_text;
	}
	public void setTimeline_text(String timeline_text) {
		this.timeline_text = timeline_text;
	}
	public String getTimeline_file_name() {
		return timeline_file_name;
	}
	public void setTimeline_file_name(String timeline_file_name) {
		this.timeline_file_name = timeline_file_name;
	}
	public String getTimeline_file_path() {
		return timeline_file_path;
	}
	public void setTimeline_file_path(String timeline_file_path) {
		this.timeline_file_path = timeline_file_path;
	}
	public String getReason_text() {
		return reason_text;
	}
	public void setReason_text(String reason_text) {
		this.reason_text = reason_text;
	}
	public String getReason_file_name() {
		return reason_file_name;
	}
	public void setReason_file_name(String reason_file_name) {
		this.reason_file_name = reason_file_name;
	}
	public String getReason_file_path() {
		return reason_file_path;
	}
	public void setReason_file_path(String reason_file_path) {
		this.reason_file_path = reason_file_path;
	}
	public String getPrepared_by_name() {
		return prepared_by_name;
	}
	public void setPrepared_by_name(String prepared_by_name) {
		this.prepared_by_name = prepared_by_name;
	}
	public String getPrepared_by_designation() {
		return prepared_by_designation;
	}
	public void setPrepared_by_designation(String prepared_by_designation) {
		this.prepared_by_designation = prepared_by_designation;
	}
	public Timestamp   getPrepared_by_date() {
		return prepared_by_date;
	}
	public void setPrepared_by_date(Timestamp   prepared_by_date) {
		this.prepared_by_date = prepared_by_date;
	}
	public String getPrepared_by_signature_path() {
		return prepared_by_signature_path;
	}
	public void setPrepared_by_signature_path(String prepared_by_signature_path) {
		this.prepared_by_signature_path = prepared_by_signature_path;
	}
	public String getProject_manager_name() {
		return project_manager_name;
	}
	public void setProject_manager_name(String project_manager_name) {
		this.project_manager_name = project_manager_name;
	}
	public String getProject_manager_designation() {
		return project_manager_designation;
	}
	public void setProject_manager_designation(String project_manager_designation) {
		this.project_manager_designation = project_manager_designation;
	}
	public Timestamp   getProject_manager_date() {
		return project_manager_date;
	}
	public void setProject_manager_date(Timestamp   project_manager_date) {
		this.project_manager_date = project_manager_date;
	}
	public String getProject_manager_signature_path() {
		return project_manager_signature_path;
	}
	public void setProject_manager_signature_path(String project_manager_signature_path) {
		this.project_manager_signature_path = project_manager_signature_path;
	}
	public String getRequested_by_name() {
		return requested_by_name;
	}
	public void setRequested_by_name(String requested_by_name) {
		this.requested_by_name = requested_by_name;
	}
	public String getRequested_by_designation() {
		return requested_by_designation;
	}
	public void setRequested_by_designation(String requested_by_designation) {
		this.requested_by_designation = requested_by_designation;
	}
	public Timestamp   getRequested_by_date() {
		return requested_by_date;
	}
	public void setRequested_by_date(Timestamp   requested_by_date) {
		this.requested_by_date = requested_by_date;
	}
	public String getRequested_by_signature_path() {
		return requested_by_signature_path;
	}
	public void setRequested_by_signature_path(String requested_by_signature_path) {
		this.requested_by_signature_path = requested_by_signature_path;
	}
	public String getHead_of_plant_name() {
		return head_of_plant_name;
	}
	public void setHead_of_plant_name(String head_of_plant_name) {
		this.head_of_plant_name = head_of_plant_name;
	}
	public String getHead_of_plant_designation() {
		return head_of_plant_designation;
	}
	public void setHead_of_plant_designation(String head_of_plant_designation) {
		this.head_of_plant_designation = head_of_plant_designation;
	}
	public Timestamp   getHead_of_plant_date() {
		return head_of_plant_date;
	}
	public void setHead_of_plant_date(Timestamp   head_of_plant_date) {
		this.head_of_plant_date = head_of_plant_date;
	}
	public String getHead_of_plant_signature_path() {
		return head_of_plant_signature_path;
	}
	public void setHead_of_plant_signature_path(String head_of_plant_signature_path) {
		this.head_of_plant_signature_path = head_of_plant_signature_path;
	}
	public String getFinance_department() {
		return finance_department;
	}
	public void setFinance_department(String finance_department) {
		this.finance_department = finance_department;
	}
	public String getFinance_category() {
		return finance_category;
	}
	public void setFinance_category(String finance_category) {
		this.finance_category = finance_category;
	}
	public String getTotal_budget() {
		return total_budget;
	}
	public void setTotal_budget(String total_budget) {
		this.total_budget = total_budget;
	}
	public String getProposed_price() {
		return proposed_price;
	}
	public void setProposed_price(String proposed_price) {
		this.proposed_price = proposed_price;
	}
	public String getAvailable_balance() {
		return available_balance;
	}
	public void setAvailable_balance(String available_balance) {
		this.available_balance = available_balance;
	}
	public String getFinance_status() {
		return finance_status;
	}
	public void setFinance_status(String finance_status) {
		this.finance_status = finance_status;
	}
	public String getFinance_name() {
		return finance_name;
	}
	public void setFinance_name(String finance_name) {
		this.finance_name = finance_name;
	}
	public String getFinance_designation() {
		return finance_designation;
	}
	public void setFinance_designation(String finance_designation) {
		this.finance_designation = finance_designation;
	}
	public Timestamp   getFinance_date() {
		return finance_date;
	}
	public void setFinance_date(Timestamp   finance_date) {
		this.finance_date = finance_date;
	}
	public String getFinance_comments() {
		return finance_comments;
	}
	public void setFinance_comments(String finance_comments) {
		this.finance_comments = finance_comments;
	}
	public String getHead_projects_name() {
		return head_projects_name;
	}
	public void setHead_projects_name(String head_projects_name) {
		this.head_projects_name = head_projects_name;
	}
	public String getHead_projects_designation() {
		return head_projects_designation;
	}
	public void setHead_projects_designation(String head_projects_designation) {
		this.head_projects_designation = head_projects_designation;
	}
	public Timestamp   getHead_projects_date() {
		return head_projects_date;
	}
	public void setHead_projects_date(Timestamp   head_projects_date) {
		this.head_projects_date = head_projects_date;
	}
	public String getHead_projects_comment() {
		return head_projects_comment;
	}
	public void setHead_projects_comment(String head_projects_comment) {
		this.head_projects_comment = head_projects_comment;
	}
	public String getHead_projects_signature_path() {
		return head_projects_signature_path;
	}
	public void setHead_projects_signature_path(String head_projects_signature_path) {
		this.head_projects_signature_path = head_projects_signature_path;
	}
	public String getBusiness_head_name() {
		return business_head_name;
	}
	public void setBusiness_head_name(String business_head_name) {
		this.business_head_name = business_head_name;
	}
	public String getBusiness_head_designation() {
		return business_head_designation;
	}
	public void setBusiness_head_designation(String business_head_designation) {
		this.business_head_designation = business_head_designation;
	}
	public Timestamp   getBusiness_head_date() {
		return business_head_date;
	}
	public void setBusiness_head_date(Timestamp   business_head_date) {
		this.business_head_date = business_head_date;
	}
	public String getBusiness_head_comment() {
		return business_head_comment;
	}
	public void setBusiness_head_comment(String business_head_comment) {
		this.business_head_comment = business_head_comment;
	}
	public String getBusiness_head_signature_path() {
		return business_head_signature_path;
	}
	public void setBusiness_head_signature_path(String business_head_signature_path) {
		this.business_head_signature_path = business_head_signature_path;
	}
	public String getCfo_name() {
		return cfo_name;
	}
	public void setCfo_name(String cfo_name) {
		this.cfo_name = cfo_name;
	}
	public String getCfo_designation() {
		return cfo_designation;
	}
	public void setCfo_designation(String cfo_designation) {
		this.cfo_designation = cfo_designation;
	}
	public Timestamp   getCfo_date() {
		return cfo_date;
	}
	public void setCfo_date(Timestamp   cfo_date) {
		this.cfo_date = cfo_date;
	}
	public String getCfo_comment() {
		return cfo_comment;
	}
	public void setCfo_comment(String cfo_comment) {
		this.cfo_comment = cfo_comment;
	}
	public String getCfo_signature_path() {
		return cfo_signature_path;
	}
	public void setCfo_signature_path(String cfo_signature_path) {
		this.cfo_signature_path = cfo_signature_path;
	}
	public String getCeo_name() {
		return ceo_name;
	}
	public void setCeo_name(String ceo_name) {
		this.ceo_name = ceo_name;
	}
	public String getCeo_designation() {
		return ceo_designation;
	}
	public void setCeo_designation(String ceo_designation) {
		this.ceo_designation = ceo_designation;
	}
	public Timestamp   getCeo_date() {
		return ceo_date;
	}
	public void setCeo_date(Timestamp   ceo_date) {
		this.ceo_date = ceo_date;
	}
	public String getCeo_comment() {
		return ceo_comment;
	}
	public void setCeo_comment(String ceo_comment) {
		this.ceo_comment = ceo_comment;
	}
	public String getCeo_signature_path() {
		return ceo_signature_path;
	}
	public void setCeo_signature_path(String ceo_signature_path) {
		this.ceo_signature_path = ceo_signature_path;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreated_by() {
		return created_by;
	}
	public void setCreated_by(String created_by) {
		this.created_by = created_by;
	}
	public Timestamp getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
	public Timestamp getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(Timestamp updated_at) {
		this.updated_at = updated_at;
	}
	public int getPhase_one() {
		return phase_one;
	}
	public void setPhase_one(int phase_one) {
		this.phase_one = phase_one;
	}
	public int getPhase_two() {
		return phase_two;
	}
	public void setPhase_two(int phase_two) {
		this.phase_two = phase_two;
	}
	public int getPhase_three() {
		return phase_three;
	}
	public void setPhase_three(int phase_three) {
		this.phase_three = phase_three;
	}

    // ... include all getters/setters for every field
}