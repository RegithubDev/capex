package com.resustainability.reisp.service;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Year;
import java.util.List;
import java.util.function.Consumer;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ConnectionCallback;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.resustainability.reisp.dao.CapexDao;
import com.resustainability.reisp.model.CapexProposal;

@Service
public class CapexServiceImpl implements CapexService {

    private static final Logger log = LoggerFactory.getLogger(CapexServiceImpl.class);

    @Autowired
    private CapexDao capexDao;

    @Autowired
    private JdbcTemplate jdbcTemplate;  // Needed for SELECT FOR UPDATE

    private static final String ATTACHMENTS_BASE_PATH = "D:/nginx-1.24.0/html/capex/resources/Attachments/";
    private static final String RELATIVE_BASE_PATH    = "/capex/resources/Attachments/";

    // Helper
    private java.sql.Date parseDate(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) return null;
        try {
            return java.sql.Date.valueOf(dateStr.trim());
        } catch (Exception e) {
            log.warn("Bad date format: {}", dateStr);
            return null;
        }
    }
    
    private Timestamp parseDateTime(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) return null;
        try {
            return Timestamp.valueOf(dateStr.trim() + " 00:00:00");
        } catch (Exception e) {
            log.warn("Bad date format: {}", dateStr);
            return null;
        }
    }
    // =====================================================================
    // HELPER METHODS
    // =====================================================================

    /**
     * Generates next capex_number safely using SELECT FOR UPDATE (prevents duplicates)
     * @param plantCode 
     */
    private String generateUniqueCapexNumber(String plantCode) {

        int year = Year.now().getValue();
        int month = LocalDate.now().getMonthValue();

        String prefix = "CAPEX-" + plantCode + "-" + year + "-" + "-";

        return jdbcTemplate.execute((ConnectionCallback<String>) conn -> {

            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT ISNULL(MAX(CAST(SUBSTRING(capex_number, LEN(?) + 1, 10) AS INT)), 0) + 1 " +
                    "FROM capex_proposal WITH (UPDLOCK, ROWLOCK) " +
                    "WHERE capex_number LIKE ? + '%'")) {

                ps.setString(1, prefix);
                ps.setString(2, prefix);

                ResultSet rs = ps.executeQuery();
                rs.next();

                int nextSeq = rs.getInt(1);

                return prefix + String.format("%03d", nextSeq);

            } finally {
                conn.commit();
            }
        });
    }
    private String saveFile(MultipartFile file,
            String folderPath,
            String baseName,
            String relativeBase) throws IOException {

        if (!isFilePresent(file))
            return null;

        String originalExt = "";
        String origName = file.getOriginalFilename();

        if (origName != null && origName.contains(".")) {
            originalExt = origName.substring(origName.lastIndexOf("."));
        }

        // Remove spaces + special characters → keep only letters and numbers
        String cleanBaseName = baseName
                .replaceAll("[^a-zA-Z0-9]", "")  // remove special characters
                .trim();

        // Final filename
        String fileName = cleanBaseName + originalExt;

        String fullPath = folderPath + fileName;

        File destFile = new File(fullPath);

        // Delete old file if exists
        if (destFile.exists()) {
            destFile.delete();
        }

        // Upload new file
        file.transferTo(destFile);

        // Return relative path
        return relativeBase + fileName;
    }

    private boolean isFilePresent(MultipartFile file) {
        return file != null && !file.isEmpty();
    }

    private void deleteFolderIfEmpty(File folder) {
        if (folder.isDirectory() && folder.list().length == 0) {
            folder.delete();
        }
    }

    private String getSafeString(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        return (value != null) ? value.trim() : null;
    }

    private boolean isNotBlank(String str) {
        return str != null && !str.trim().isEmpty();
    }

    private String getSafeString(String valueStr) {
        if (isNotBlank(valueStr)) {
            try {
                return new String(valueStr.trim());
            } catch (NumberFormatException e) {
                log.warn("Invalid String format: {}", valueStr);
            }
        }
        return null;
    }

    private String getCurrentUsername(HttpServletRequest request) {
        java.security.Principal principal = request.getUserPrincipal();
        return (principal != null) ? principal.getName() : "anonymous";
    }

    @Override
    public List<CapexProposal> getCapexList(CapexProposal obj) throws Exception {
        return capexDao.getCapexList(obj);
    }

    @Override
    @Transactional
    public CapexProposal submitCapex(
            String capexTitle, String department, String businessUnit, String plantCode, String location, String assetDescription,
            String basicCost, String gstRate, String gstAmount, String totalCost,
            String roiText, String timelineText, String reasonText,
            MultipartFile roiFile, MultipartFile timelineFile, MultipartFile reasonFile,
            MultipartFile preparedSignature, MultipartFile pmSignature, MultipartFile requestedSignature, MultipartFile headSignature,
            String preparedByName, String preparedByDesignation, String preparedByDate,
            String projectManagerName, String projectManagerDesignation, String projectManagerDate,
            String requestedByName, String requestedByDesignation, String requestedByDate,
            String headOfPlantName, String headOfPlantDesignation, String headOfPlantDate , String userId
    ) throws Exception {

        CapexProposal capex = new CapexProposal();
        String capexNumber = generateUniqueCapexNumber(plantCode);
        capex.setCapex_number(capexNumber);

        capex.setCapex_title(capexTitle);
        capex.setDepartment(department);
        capex.setBusiness_unit(businessUnit);
        capex.setPlant_code(plantCode);
        capex.setLocation(location);
        capex.setAsset_description(assetDescription);

        capex.setBasic_cost(basicCost);
        capex.setGst_rate(gstRate);
        capex.setGst_amount(gstAmount);
        capex.setTotal_cost(totalCost);

        capex.setRoi_text(roiText);
        capex.setTimeline_text(timelineText);
        capex.setReason_text(reasonText);

        capex.setPrepared_by_name(preparedByName);
        capex.setPrepared_by_designation(preparedByDesignation);
        capex.setPrepared_by_date(parseDateTime(preparedByDate));

        capex.setProject_manager_name(projectManagerName);
        capex.setProject_manager_designation(projectManagerDesignation);
        capex.setProject_manager_date(parseDateTime(projectManagerDate));

        capex.setRequested_by_name(requestedByName);
        capex.setRequested_by_designation(requestedByDesignation);
        capex.setRequested_by_date(parseDateTime(requestedByDate));

        capex.setHead_of_plant_name(headOfPlantName);
        capex.setHead_of_plant_designation(headOfPlantDesignation);
        capex.setHead_of_plant_date(parseDateTime(headOfPlantDate));

        capex.setStatus("submitted");
        capex.setCreated_by(userId);
        capex.setCreated_at(new Timestamp(System.currentTimeMillis()));

        // File saving
        String folderPath = ATTACHMENTS_BASE_PATH + capexNumber + "/";
        new File(folderPath).mkdirs();
        String relativeBase = RELATIVE_BASE_PATH + capexNumber + "/";

        capex.setRoi_file_path(saveFile(roiFile, folderPath, roiFile.getOriginalFilename(), relativeBase));
        capex.setRoi_file_name(roiFile != null && !roiFile.isEmpty() ? roiFile.getOriginalFilename() : null);

        capex.setTimeline_file_path(saveFile(timelineFile, folderPath, timelineFile.getOriginalFilename(), relativeBase));
        capex.setTimeline_file_name(timelineFile != null && !timelineFile.isEmpty() ? timelineFile.getOriginalFilename() : null);

        capex.setReason_file_path(saveFile(reasonFile, folderPath, reasonFile.getOriginalFilename(), relativeBase));
        capex.setReason_file_name(reasonFile != null && !reasonFile.isEmpty() ? reasonFile.getOriginalFilename() : null);

        capex.setPrepared_by_signature_path(saveFile(preparedSignature, folderPath, "prepared_signature", relativeBase));
        capex.setProject_manager_signature_path(saveFile(pmSignature, folderPath, "project_manager_signature", relativeBase));
        capex.setRequested_by_signature_path(saveFile(requestedSignature, folderPath, "requested_by_signature", relativeBase));
        capex.setHead_of_plant_signature_path(saveFile(headSignature, folderPath, "head_of_plant_signature", relativeBase));

        capexDao.insertCapex(capex);
        return capex;
    }

	@Override
	public CapexProposal getCapexEditFormPage(CapexProposal obj) throws Exception {
		return capexDao.getCapexEditFormPage(obj);
	}

	@Override
	@Transactional
	public CapexProposal updateCapex(String remarks ,String regional_director_comment,String finance_controller_name,String finance_controller_comment,String current_pending_at,
			String regional_director_name,String regional_director_date,
	String capexTitle,
	String capex_number,
	String id,
	String department,
	String businessUnit,
	String plantCode,
	String location,
	String assetDescription,

	String basicCost,
	String gstRate,
	String gstAmount,
	String totalCost,

	String roiText,
	String timelineText,
	String reasonText,

	MultipartFile roiFile,
	MultipartFile timelineFile,
	MultipartFile reasonFile,

	MultipartFile preparedSignature,
	MultipartFile pmSignature,
	MultipartFile requestedSignature,
	MultipartFile headSignature,

	String preparedByName,
	String preparedByDesignation,
	String preparedByDate,

	String projectManagerName,
	String projectManagerDesignation,
	String projectManagerDate,

	String requestedByName,
	String requestedByDesignation,
	String requestedByDate,

	String headOfPlantName,
	String headOfPlantDesignation,
	String headOfPlantDate,

	String userId,
	String roi_file_name,
	String timeline_file_name,
	String reason_file_name,

	/* FINANCE */
	String financeDepartment,
	String financeCategory,
	String totalBudget,
	String proposedPrice,
	String availableBalance,
	String financeStatus,
	String financeName,
	String financeDesignation,
	String financeDate,
	String financeComments,

	/* HEAD PROJECT */
	String headProjectsName,
	String headProjectsDate,
	String headProjectsComment,

	/* BUSINESS HEAD */
	String businessHeadName,
	String businessHeadDate,
	String businessHeadComment,

	/* CFO */
	String cfoName,
	String cfoDate,
	String cfoComment,

	/* CEO */
	String ceoName,
	String ceoDate,
	String ceoComment

	) throws Exception {

	CapexProposal capex = new CapexProposal();
	capex.setRegional_director_name(regional_director_name);
	capex.setRegional_director_date(regional_director_date);
	capex.setId(Integer.parseInt(id));
	capex.setCapex_number(capex_number);
	capex.setCapex_title(capexTitle);
	capex.setRegional_director_comment(regional_director_comment);
	
	capex.setDepartment(department);
	capex.setBusiness_unit(businessUnit);
	capex.setPlant_code(plantCode);
	capex.setLocation(location);
	capex.setAsset_description(assetDescription);


	/* COST */
capex.setRemarks(remarks);
	capex.setBasic_cost(basicCost);
	capex.setGst_rate(gstRate);
	capex.setGst_amount(gstAmount);
	capex.setTotal_cost(totalCost);

	capex.setFinance_controller_name(finance_controller_name);
	capex.setFinance_controller_comment(finance_controller_comment);

	/* TEXT */

	capex.setRoi_text(roiText);
	capex.setTimeline_text(timelineText);
	capex.setReason_text(reasonText);


	/* PREPARED */

	capex.setPrepared_by_name(preparedByName);
	capex.setPrepared_by_designation(preparedByDesignation);
	capex.setPrepared_by_date(parseDateTime(preparedByDate));


	/* PROJECT MANAGER */

	capex.setProject_manager_name(projectManagerName);
	capex.setProject_manager_designation(projectManagerDesignation);
	capex.setProject_manager_date(parseDateTime(projectManagerDate));


	/* REQUESTED */

	capex.setRequested_by_name(requestedByName);
	capex.setRequested_by_designation(requestedByDesignation);
	capex.setRequested_by_date(parseDateTime(requestedByDate));


	/* HEAD OF PLANT */

	capex.setHead_of_plant_name(headOfPlantName);
	capex.setHead_of_plant_designation(headOfPlantDesignation);
	capex.setHead_of_plant_date(parseDateTime(headOfPlantDate));


	/* ================= FINANCE ================= */

	capex.setFinance_department(financeDepartment);
	capex.setFinance_category(financeCategory);

	capex.setTotal_budget(totalBudget);
	capex.setProposed_price(proposedPrice);
	capex.setAvailable_balance(availableBalance);

	capex.setFinance_status(financeStatus);
	capex.setFinance_name(financeName);
	capex.setFinance_designation(financeDesignation);

	capex.setFinance_date(parseDateTime(financeDate));
	capex.setFinance_comments(financeComments);


	/* ================= HEAD PROJECT ================= */

	capex.setHead_projects_name(headProjectsName);
	capex.setHead_projects_date(parseDateTime(headProjectsDate));
	capex.setHead_projects_comment(headProjectsComment);


	/* ================= BUSINESS HEAD ================= */

	capex.setBusiness_head_name(businessHeadName);
	capex.setBusiness_head_date(parseDateTime(businessHeadDate));
	capex.setBusiness_head_comment(businessHeadComment);


	/* ================= CFO ================= */

	capex.setCfo_name(cfoName);
	capex.setCfo_date(parseDateTime(cfoDate));
	capex.setCfo_comment(cfoComment);


	/* ================= CEO ================= */

	capex.setCeo_name(ceoName);
	capex.setCeo_date(parseDateTime(ceoDate));
	capex.setCeo_comment(ceoComment);


	/* ================= SYSTEM ================= */

	capex.setStatus("submitted");
	capex.setCreated_by(userId);
	capex.setCreated_at(new Timestamp(System.currentTimeMillis()));
	capex.setCurrent_pending_at(current_pending_at);
	/* ================= FILE SAVE ================= */

	String folderPath = ATTACHMENTS_BASE_PATH + capex_number + "/";
	new File(folderPath).mkdirs();

	String relativeBase = RELATIVE_BASE_PATH + capex_number + "/";


	capex.setRoi_file_path(
	saveFile(roiFile,folderPath,
	roiFile!=null?roiFile.getOriginalFilename():roi_file_name,
	relativeBase));

	capex.setRoi_file_name(
	roiFile!=null&&!roiFile.isEmpty()
	?roiFile.getOriginalFilename()
	:roi_file_name);



	capex.setTimeline_file_path(
	saveFile(timelineFile,folderPath,
	timelineFile!=null?timelineFile.getOriginalFilename():timeline_file_name,
	relativeBase));

	capex.setTimeline_file_name(
	timelineFile!=null&&!timelineFile.isEmpty()
	?timelineFile.getOriginalFilename()
	:timeline_file_name);



	capex.setReason_file_path(
	saveFile(reasonFile,folderPath,
	reasonFile!=null?reasonFile.getOriginalFilename():reason_file_name,
	relativeBase));

	capex.setReason_file_name(
	reasonFile!=null&&!reasonFile.isEmpty()
	?reasonFile.getOriginalFilename()
	:reason_file_name);



	/* SIGNATURES */

	capex.setPrepared_by_signature_path(
	saveFile(preparedSignature,folderPath,
	"prepared_signature",relativeBase));

	capex.setProject_manager_signature_path(
	saveFile(pmSignature,folderPath,
	"project_manager_signature",relativeBase));

	capex.setRequested_by_signature_path(
	saveFile(requestedSignature,folderPath,
	"requested_signature",relativeBase));

	capex.setHead_of_plant_signature_path(
	saveFile(headSignature,folderPath,
	"head_signature",relativeBase));



	/* SAVE */

	int count = capexDao.updateCapex(capex);

	return capex;

	}

	@Override
	public List<CapexProposal> getPlantHead(String plantCode, String department) throws Exception {
		return capexDao.getPlantHead(plantCode,department);
	}

	@Override
	public CapexProposal submitCapex(HttpServletRequest request, MultipartFile roiFile, MultipartFile timelineFile,
			MultipartFile reasonFile, MultipartFile preparedBySignature, MultipartFile projectManagerSignature,
			MultipartFile requestedBySignature, MultipartFile headOfPlantSignature) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}