package com.resustainability.reisp.model;

import java.util.List;

public class ExcelChange {
    private Long id;
    private int rowNumber;
    private List<ChangeDetail> changes;
    private EmployeeMaster newData;
    private boolean approved;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public int getRowNumber() {
		return rowNumber;
	}
	public void setRowNumber(int rowNumber) {
		this.rowNumber = rowNumber;
	}
	public List<ChangeDetail> getChanges() {
		return changes;
	}
	public void setChanges(List<ChangeDetail> changes) {
		this.changes = changes;
	}
	public EmployeeMaster getNewData() {
		return newData;
	}
	public void setNewData(EmployeeMaster newData) {
		this.newData = newData;
	}
	public boolean isApproved() {
		return approved;
	}
	public void setApproved(boolean approved) {
		this.approved = approved;
	}
    
    // Getters and Setters
}