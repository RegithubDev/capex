package com.resustainability.reisp.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.resustainability.reisp.model.CapexProposal;

public interface CapexService {
    CapexProposal submitCapex(HttpServletRequest request,
                     MultipartFile roiFile,
                     MultipartFile timelineFile,
                     MultipartFile reasonFile,
                     MultipartFile preparedBySignature, MultipartFile projectManagerSignature, MultipartFile requestedBySignature, MultipartFile headOfPlantSignature) throws Exception;

	List<CapexProposal> getCapexList(CapexProposal obj) throws Exception;

	
	CapexProposal getCapexEditFormPage(CapexProposal obj)throws Exception;

	CapexProposal updateCapex(String remarks ,String regional_director_comment,String finance_controller_name,String finance_controller_comment,String current_pending_at,String regional_director_name,String regional_director_date,String capexTitle,String capex_number,String id, String department, String businessUnit, String plantCode,
			String location, String assetDescription, String basicCost, String gstRate, String gstAmount,
			String totalCost, String roiText, String timelineText, String reasonText, MultipartFile roiFile,
			MultipartFile timelineFile, MultipartFile reasonFile, MultipartFile preparedSignature,
			MultipartFile pmSignature, MultipartFile requestedSignature, MultipartFile headSignature,
			String preparedByName, String preparedByDesignation, String preparedByDate, String projectManagerName,
			String projectManagerDesignation, String projectManagerDate, String requestedByName,
			String requestedByDesignation, String requestedByDate, String headOfPlantName,
			String headOfPlantDesignation, String headOfPlantDate, String userId, String roi_file_name, String timeline_file_name, String reason_file_name, String financeDepartment, String financeCategory, String totalBudget, String proposedPrice, String availableBalance, String financeStatus, String financeName, String financeDesignation, String financeDate, String financeComments, String headProjectsName, String headProjectsDate, String headProjectsComment, String businessHeadName, String businessHeadDate, String businessHeadComment, String cfoName, String cfoDate, String cfoComment, String ceoName, String ceoDate, String ceoComment) throws IOException, Exception;

	List<CapexProposal> getPlantHead(String plantCode, String department)throws Exception;

	CapexProposal submitCapex(String capexTitle, String department, String businessUnit, String plantCode,
			String location, String assetDescription, String basicCostStr, String gstRateStr, String gstAmountStr,
			String totalCostStr, String roiText, String timelineText, String reasonText, MultipartFile roiFile,
			MultipartFile timelineFile, MultipartFile reasonFile, MultipartFile preparedSignature,
			MultipartFile pmSignature, MultipartFile requestedSignature, MultipartFile headSignature,
			String preparedByName, String preparedByDesignation, String preparedByDate, String projectManagerName,
			String projectManagerDesignation, String projectManagerDate, String requestedByName,
			String requestedByDesignation, String requestedByDate, String headOfPlantName,
			String headOfPlantDesignation, String headOfPlantDate, String userId) throws Exception;
}
