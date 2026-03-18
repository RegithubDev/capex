package com.resustainability.reisp.model;

import java.sql.Timestamp;

public class SBU {
    private String id;
    private String sbu;
    private String sbu_name;
    private String created_by;
    private Timestamp created_date;
    private String updated_by;
    private Timestamp updated_at;
    private String status;
    
    // For statistics
    private int all_sbu;
    private int active_sbu;
    private int inActive_sbu;
    
    // Getters and Setters
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getSbu() {
        return sbu;
    }
    
    public void setSbu(String sbu) {
        this.sbu = sbu;
    }
    
    public String getSbu_name() {
        return sbu_name;
    }
    
    public void setSbu_name(String sbu_name) {
        this.sbu_name = sbu_name;
    }
    
    public String getCreated_by() {
        return created_by;
    }
    
    public void setCreated_by(String created_by) {
        this.created_by = created_by;
    }
    
    public Timestamp getCreated_date() {
        return created_date;
    }
    
    public void setCreated_date(Timestamp created_date) {
        this.created_date = created_date;
    }
    
    public String getUpdated_by() {
        return updated_by;
    }
    
    public void setUpdated_by(String updated_by) {
        this.updated_by = updated_by;
    }
    
    public Timestamp getUpdated_at() {
        return updated_at;
    }
    
    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public int getAll_sbu() {
        return all_sbu;
    }
    
    public void setAll_sbu(int all_sbu) {
        this.all_sbu = all_sbu;
    }
    
    public int getActive_sbu() {
        return active_sbu;
    }
    
    public void setActive_sbu(int active_sbu) {
        this.active_sbu = active_sbu;
    }
    
    public int getInActive_sbu() {
        return inActive_sbu;
    }
    
    public void setInActive_sbu(int inActive_sbu) {
        this.inActive_sbu = inActive_sbu;
    }
}