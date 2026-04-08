package com.resustainability.reisp.dao;

import java.util.List;

import com.resustainability.reisp.model.CapexProposal;

public interface CapexDao {
    void insertCapex(CapexProposal capex);

	List<CapexProposal> getCapexList(CapexProposal obj) throws Exception;

	CapexProposal getCapexEditFormPage(CapexProposal obj) throws Exception;

	int updateCapex(CapexProposal capex) throws Exception;

	List<CapexProposal> getPlantHead(String plantCode, String department)throws Exception;

	List<CapexProposal> getApprovalStatus(CapexProposal obj) throws Exception;

	   void updateStatus(String id, String status);

	    void updateCurrentPending(String id, String pendingAt);

	    void saveRejectRemarks(String id, String remarks);

	    void saveSendBackRemarks(String id, String remarks);

	    void clearApproval(String field, String id);
}

