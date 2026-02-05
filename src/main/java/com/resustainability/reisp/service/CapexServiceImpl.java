package com.resustainability.reisp.service;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.function.Consumer;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.resustainability.reisp.dao.CapexDao;
import com.resustainability.reisp.model.CapexProposal;

@Service
public class CapexServiceImpl implements CapexService {

    @Autowired
    private CapexDao capexDao;

    @Override
    public void submitCapex(HttpServletRequest request,
                            MultipartFile roiFile,
                            MultipartFile timelineFile,
                            MultipartFile reasonFile,
                            MultipartFile preparedBySignature) throws Exception {

        CapexProposal capex = new CapexProposal();

        // ────────────────────────────────────────────────
        // BASIC INFORMATION
        // ────────────────────────────────────────────────
        capex.setCapex_title(getSafeString(request, "capex_title"));
        capex.setCapex_number(getSafeString(request, "capex_number"));
        capex.setDepartment(getSafeString(request, "department"));
        capex.setBusiness_unit(getSafeString(request, "business_unit"));
        capex.setPlant_code(getSafeString(request, "plant_code"));
        capex.setLocation(getSafeString(request, "location"));
        capex.setAsset_description(getSafeString(request, "asset_description"));


        // ────────────────────────────────────────────────
        // COST FIELDS (BigDecimal) – safe parsing
        // ────────────────────────────────────────────────
        setSafeBigDecimal(request.getParameter("basic_cost"),   capex::setBasic_cost);
        setSafeBigDecimal(request.getParameter("gst_rate"),     capex::setGst_rate);
        setSafeBigDecimal(request.getParameter("gst_amount"),   capex::setGst_amount);
        setSafeBigDecimal(request.getParameter("total_cost"),   capex::setTotal_cost);


        // ────────────────────────────────────────────────
        // FILE UPLOADS – only save if present
        // ────────────────────────────────────────────────
        String capex_number = capex.getCapex_number();
        if (capex_number == null || capex_number.trim().isEmpty()) {
            capex_number = "DRAFT-" + System.currentTimeMillis();
            capex.setCapex_number(capex_number);
        }

        String basePath = "D:/uploads/capex/" + capex_number + "/";

        capex.setRoi_file_path(saveFileIfPresent(roiFile, basePath));
        capex.setTimeline_file_path(saveFileIfPresent(timelineFile, basePath));
        capex.setReason_file_path(saveFileIfPresent(reasonFile, basePath));
        capex.setPrepared_by_signature_path(
                saveFileIfPresent(preparedBySignature, basePath)
        );

        // Set original filenames only when file was actually saved
        if (isFilePresent(roiFile)) {
            capex.setRoi_file_name(roiFile.getOriginalFilename());
        }
        if (isFilePresent(timelineFile)) {
            capex.setTimeline_file_name(timelineFile.getOriginalFilename());
        }
        if (isFilePresent(reasonFile)) {
            capex.setReason_file_name(reasonFile.getOriginalFilename());
        }


        // ────────────────────────────────────────────────
        // ROI / TIMELINE / REASON TEXT
        // ────────────────────────────────────────────────
        capex.setRoi_text(getSafeString(request, "roi_text"));
        capex.setTimeline_text(getSafeString(request, "timeline_text"));
        capex.setReason_text(getSafeString(request, "reason_text"));


        // ────────────────────────────────────────────────
        // PREPARED BY SIGNATURE FIELDS
        // ────────────────────────────────────────────────
        capex.setPrepared_by_name(getSafeString(request, "prepared_by_name"));
        capex.setPrepared_by_designation(getSafeString(request, "prepared_by_designation"));

        String prepared_by_date_str = getSafeString(request, "prepared_by_date");
        if (isNotBlank(prepared_by_date_str)) {
            try {
                capex.setPrepared_by_date(Date.valueOf(prepared_by_date_str.trim()));
            } catch (IllegalArgumentException e) {
                System.err.println("Invalid prepared_by_date: " + prepared_by_date_str);
            }
        }


        // ────────────────────────────────────────────────
        // META / AUDIT FIELDS
        // ────────────────────────────────────────────────
        capex.setStatus("SUBMITTED");

        String createdBy = "anonymous";
        if (request.getUserPrincipal() != null) {
            createdBy = request.getUserPrincipal().getName();
        }
        capex.setCreated_by(createdBy);

        // ────────────────────────────────────────────────
        // PERSIST
        // ────────────────────────────────────────────────
        capexDao.insertCapex(capex);
    }

    // ──────────────────────────────────────────────────────────────
    //                HELPER METHODS
    // ──────────────────────────────────────────────────────────────

    private String getSafeString(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        return (value != null) ? value.trim() : null;
    }

    private boolean isNotBlank(String str) {
        return str != null && !str.trim().isEmpty();
    }

    private void setSafeBigDecimal(String valueStr, Consumer<BigDecimal> setter) {
        if (isNotBlank(valueStr)) {
            try {
                setter.accept(new BigDecimal(valueStr.trim()));
            } catch (NumberFormatException e) {
                System.err.println("Invalid number format: " + valueStr);
                // You may choose to set null explicitly:
                // setter.accept(null);
            }
        }
    }

    private boolean isFilePresent(MultipartFile file) {
        return file != null && !file.isEmpty();
    }

    private String saveFileIfPresent(MultipartFile file, String basePath) {
        if (!isFilePresent(file)) {
            return null;
        }

        try {
            File dir = new File(basePath);
            if (!dir.exists()) {
                if (!dir.mkdirs()) {
                    System.err.println("Failed to create directory: " + basePath);
                    return null;
                }
            }

            String filePath = basePath + file.getOriginalFilename();
            file.transferTo(new File(filePath));
            return filePath;
        } catch (IOException e) {
            System.err.println("Failed to save file: " + file.getOriginalFilename());
            e.printStackTrace();
            return null;
        }
    }
}