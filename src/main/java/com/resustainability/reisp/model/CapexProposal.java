package com.resustainability.reisp.model;

import java.math.BigDecimal;
import java.util.Date;

public class CapexProposal {

    private Long id;

    private String capex_title;
    private String capex_number;
    private String department;
    private String business_unit;
    private String plant_code;
    private String location;
    private String asset_description;

    private BigDecimal basic_cost;
    private BigDecimal gst_rate;
    private BigDecimal gst_amount;
    private BigDecimal total_cost;

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
    private Date prepared_by_date;
    private String prepared_by_signature_path;

    // Project Manager
    private String project_manager_name;
    private String project_manager_designation;
    private Date project_manager_date;
    private String project_manager_signature_path;

    // Requested By
    private String requested_by_name;
    private String requested_by_designation;
    private Date requested_by_date;
    private String requested_by_signature_path;

    // Head of Plant
    private String head_of_plant_name;
    private String head_of_plant_designation;
    private Date head_of_plant_date;
    private String head_of_plant_signature_path;

    // Finance
    private String finance_department;
    private String finance_category;
    private BigDecimal total_budget;
    private BigDecimal proposed_price;
    private BigDecimal available_balance;
    private String finance_status;
    private String finance_name;
    private String finance_designation;
    private Date finance_date;
    private String finance_comments;

    // Head Projects
    private String head_projects_name;
    private String head_projects_designation;
    private Date head_projects_date;
    private String head_projects_comment;
    private String head_projects_signature_path;

    // Business Head
    private String business_head_name;
    private String business_head_designation;
    private Date business_head_date;
    private String business_head_comment;
    private String business_head_signature_path;

    // CFO
    private String cfo_name;
    private String cfo_designation;
    private Date cfo_date;
    private String cfo_comment;
    private String cfo_signature_path;

    // CEO
    private String ceo_name;
    private String ceo_designation;
    private Date ceo_date;
    private String ceo_comment;
    private String ceo_signature_path;

    private String status;
    private String created_by;
    private Date created_at;
    private Date updated_at;
    
    private int phase_one;
    private int phase_two;
    private int phase_three;
    
    

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
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
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
	public BigDecimal getBasic_cost() {
		return basic_cost;
	}
	public void setBasic_cost(BigDecimal basic_cost) {
		this.basic_cost = basic_cost;
	}
	public BigDecimal getGst_rate() {
		return gst_rate;
	}
	public void setGst_rate(BigDecimal gst_rate) {
		this.gst_rate = gst_rate;
	}
	public BigDecimal getGst_amount() {
		return gst_amount;
	}
	public void setGst_amount(BigDecimal gst_amount) {
		this.gst_amount = gst_amount;
	}
	public BigDecimal getTotal_cost() {
		return total_cost;
	}
	public void setTotal_cost(BigDecimal total_cost) {
		this.total_cost = total_cost;
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
	public Date getPrepared_by_date() {
		return prepared_by_date;
	}
	public void setPrepared_by_date(Date prepared_by_date) {
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
	public Date getProject_manager_date() {
		return project_manager_date;
	}
	public void setProject_manager_date(Date project_manager_date) {
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
	public Date getRequested_by_date() {
		return requested_by_date;
	}
	public void setRequested_by_date(Date requested_by_date) {
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
	public Date getHead_of_plant_date() {
		return head_of_plant_date;
	}
	public void setHead_of_plant_date(Date head_of_plant_date) {
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
	public BigDecimal getTotal_budget() {
		return total_budget;
	}
	public void setTotal_budget(BigDecimal total_budget) {
		this.total_budget = total_budget;
	}
	public BigDecimal getProposed_price() {
		return proposed_price;
	}
	public void setProposed_price(BigDecimal proposed_price) {
		this.proposed_price = proposed_price;
	}
	public BigDecimal getAvailable_balance() {
		return available_balance;
	}
	public void setAvailable_balance(BigDecimal available_balance) {
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
	public Date getFinance_date() {
		return finance_date;
	}
	public void setFinance_date(Date finance_date) {
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
	public Date getHead_projects_date() {
		return head_projects_date;
	}
	public void setHead_projects_date(Date head_projects_date) {
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
	public Date getBusiness_head_date() {
		return business_head_date;
	}
	public void setBusiness_head_date(Date business_head_date) {
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
	public Date getCfo_date() {
		return cfo_date;
	}
	public void setCfo_date(Date cfo_date) {
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
	public Date getCeo_date() {
		return ceo_date;
	}
	public void setCeo_date(Date ceo_date) {
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
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	public Date getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(Date updated_at) {
		this.updated_at = updated_at;
	}


}

