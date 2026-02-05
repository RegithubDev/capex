package com.resustainability.reisp.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.resustainability.reisp.model.CapexProposal;

@Repository
public class CapexDaoImpl implements CapexDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void insertCapex(CapexProposal c) {

        String sql = "INSERT INTO capex_proposal ("
                + "capex_title, capex_number, department, business_unit, plant_code, location, asset_description, "
                + "basic_cost, gst_rate, gst_amount, total_cost, "
                + "roi_text, roi_file_name, roi_file_path, "
                + "timeline_text, timeline_file_name, timeline_file_path, "
                + "reason_text, reason_file_name, reason_file_path, "
                + "prepared_by_name, prepared_by_designation, prepared_by_date, prepared_by_signature_path, "
                + "project_manager_name, project_manager_designation, project_manager_date, project_manager_signature_path, "
                + "requested_by_name, requested_by_designation, requested_by_date, requested_by_signature_path, "
                + "head_of_plant_name, head_of_plant_designation, head_of_plant_date, head_of_plant_signature_path, "
                + "status, created_by,phase_one, created_at"
                + ") VALUES ("
                + "?, ?, ?, ?, ?, ?, ?, "
                + "?, ?, ?, ?, "
                + "?, ?, ?, "
                + "?, ?, ?, "
                + "?, ?, ?, "
                + "?, ?, ?, ?, "
                + "?, ?, ?, ?, "
                + "?, ?, ?, ?, "
                + "?, ?, ?, ?, "
                + "?, ?, ?, ?"
                + ")";
        c.setPhase_one(1);
        jdbcTemplate.update(sql,
                // Basic details
        	     // Basic
                c.getCapex_title(),
                c.getCapex_number(),
                c.getDepartment(),
                c.getBusiness_unit(),
                c.getPlant_code(),
                c.getLocation(),
                c.getAsset_description(),

                // Cost
                c.getBasic_cost(),
                c.getGst_rate(),
                c.getGst_amount(),
                c.getTotal_cost(),

                // ROI
                c.getRoi_text(),
                c.getRoi_file_name(),
                c.getRoi_file_path(),

                // Timeline
                c.getTimeline_text(),
                c.getTimeline_file_name(),
                c.getTimeline_file_path(),

                // Reason
                c.getReason_text(),
                c.getReason_file_name(),
                c.getReason_file_path(),

                // Prepared By
                c.getPrepared_by_name(),
                c.getPrepared_by_designation(),
                c.getPrepared_by_date(),
                c.getPrepared_by_signature_path(),

                // Project Manager
                c.getProject_manager_name(),
                c.getProject_manager_designation(),
                c.getProject_manager_date(),
                c.getProject_manager_signature_path(),

                // Requested By
                c.getRequested_by_name(),
                c.getRequested_by_designation(),
                c.getRequested_by_date(),
                c.getRequested_by_signature_path(),

                // Head of Plant
                c.getHead_of_plant_name(),
                c.getHead_of_plant_designation(),
                c.getHead_of_plant_date(),
                c.getHead_of_plant_signature_path(),

                // Meta
                c.getStatus(),
                c.getCreated_by(),
                c.getPhase_one(),
                new java.sql.Timestamp(System.currentTimeMillis())
        );
    }

}

