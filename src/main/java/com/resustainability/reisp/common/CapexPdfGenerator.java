package com.resustainability.reisp.common;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.resustainability.reisp.model.CapexProposal;

import java.io.OutputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import org.springframework.util.StringUtils;

public class CapexPdfGenerator {

    private static final Font TITLE = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD);
    private static final Font HEADER = new Font(Font.FontFamily.HELVETICA, 11, Font.BOLD);
    private static final Font NORMAL = new Font(Font.FontFamily.HELVETICA, 9);
    private static final Font LABEL = new Font(Font.FontFamily.HELVETICA, 9, Font.BOLD);

    private static final SimpleDateFormat DF = new SimpleDateFormat("dd MMM yyyy hh:mm a");

    public static void generatePdf(CapexProposal c, OutputStream out) throws Exception {

        Document doc = new Document(PageSize.A4, 20, 20, 20, 20);
        PdfWriter.getInstance(doc, out);
        doc.open();

        // ================= HEADER =================
        Paragraph company = new Paragraph("RESUSTAINABILITY LIMITED", TITLE);
        company.setAlignment(Element.ALIGN_CENTER);
        doc.add(company);

        Paragraph title = new Paragraph("CAPITAL EXPENDITURE PROPOSAL / APPROVAL", HEADER);
        title.setAlignment(Element.ALIGN_CENTER);
        doc.add(title);

        doc.add(new Paragraph("\n"));

        // ================= MAIN TABLE =================
        PdfPTable main = new PdfPTable(4);
        main.setWidthPercentage(100);

        addRow(main, "CAPEX Title", c.getCapex_title(), "", "");
        addRow(main, "CAPEX Number", c.getCapex_number(), "", "");
        addRow(main, "Department", c.getDepartment(), "", "");

        addRow(main, "Business Unit", c.getBusiness_unit(),
                "Plant Code", c.getPlant_code());

        addRow(main, "Location", c.getLocation(), "", "");
        addRow(main, "Asset Description", c.getAsset_description(), "", "");

        addRow(main, "Estimate (₹)", c.getBasic_cost(), "", "");
        addRow(main, "GST (%)", c.getGst_rate(), "GST Amount", c.getGst_amount());
        addRow(main, "Total Cost (₹)", c.getTotal_cost(), "", "");

        addRow(main, "ROI & Payback", c.getRoi_text(), "", "");
        addRow(main, "Timeline", c.getTimeline_text(), "", "");
        addRow(main, "Reason", c.getReason_text(), "", "");

        doc.add(main);

        doc.add(new Paragraph("\n"));

        // ================= SIGNATURES =================
        PdfPTable signTable = new PdfPTable(3); // FIXED
        signTable.setWidthPercentage(100);

        addSignature(signTable, "Project Manager",
                c.getProject_manager_fullname(),
                c.getProject_manager_date());

        addSignature(signTable, "Requested By",
                c.getRequested_by_fullname(),
                c.getRequested_by_date());

        addSignature(signTable, "Head of Plant",
                c.getHead_of_plant_fullname(),
                c.getHead_of_plant_date());

        doc.add(signTable);

        doc.add(new Paragraph("\n"));

        // ================= FINANCE =================
        PdfPTable finance = new PdfPTable(2);
        finance.setWidthPercentage(100);

        PdfPCell left = new PdfPCell();
        left.addElement(new Paragraph("Capital Expenditure Budget", HEADER));

        PdfPTable budget = new PdfPTable(2);
        addBudget(budget, "Department", c.getFinance_department());
        addBudget(budget, "Category", c.getFinance_category());
        addBudget(budget, "Total Budget", c.getTotal_budget());
        addBudget(budget, "Available Balance", c.getAvailable_balance());
        addBudget(budget, "Proposed Price", c.getProposed_price());

        left.addElement(budget);
        finance.addCell(left);

        PdfPCell right = new PdfPCell();
        right.addElement(new Paragraph("Finance Review", HEADER));

        PdfPTable review = new PdfPTable(2);
        addBudget(review, "Name", c.getFinance_fullname());
       // addBudget(review, "Designation", c.getFinance_designation());
        addBudget(review, "Date", format(c.getFinance_date()));
        addBudget(review, "Remarks", c.getFinance_comments());

        right.addElement(review);
        finance.addCell(right);

        doc.add(finance);

        doc.add(new Paragraph("\n"));

        // ================= FINAL APPROVER LOGIC =================
        String finalApprover = "";
       
        finalApprover = getLast(finalApprover, c.getProject_manager_fullname());
        finalApprover = getLast(finalApprover, c.getRequested_by_fullname());
        finalApprover = getLast(finalApprover, c.getHead_of_plant_fullname());
        finalApprover = getLast(finalApprover, c.getFinance_fullname());
        finalApprover = getLast(finalApprover, c.getRegional_director_fullname());
        finalApprover = getLast(finalApprover, c.getFinance_controller_fullname());
        finalApprover = getLast(finalApprover, c.getHead_projects_fullname());
        finalApprover = getLast(finalApprover, c.getBusiness_head_fullname());
        finalApprover = getLast(finalApprover, c.getCfo_fullname());
        finalApprover = getLast(finalApprover, c.getCeo_fullname());
        if (!StringUtils.isEmpty(c.getFinance_controller_fullname())) {
        // ================= AUTHORITY =================
        doc.add(new Paragraph("Approvals", HEADER));
    }
        PdfPTable auth = new PdfPTable(2);
        auth.setWidthPercentage(100);

        addAuthority(auth, "Regional Director",
                c.getRegional_director_fullname(),
                c.getRegional_director_date(),
                c.getRegional_director_comment());

        addAuthority(auth, "Finance Controller",
                c.getFinance_controller_fullname(),
                c.getFinance_controller_date(),
                c.getFinance_controller_comment());

        addAuthority(auth, "Head Projects (HO)",
                c.getHead_projects_fullname(),
                c.getHead_projects_date(),
                c.getHead_projects_comment());

        addAuthority(auth, "Business Head",
                c.getBusiness_head_fullname(),
                c.getBusiness_head_date(),
                c.getBusiness_head_comment());

        addAuthority(auth, "CFO",
                c.getCfo_fullname(),
                c.getCfo_date(),
                c.getCfo_comment());

        addAuthority(auth, "CEO & MD",
                c.getCeo_fullname(),
                c.getCeo_date(),
                c.getCeo_comment());

        doc.add(auth);
   
        // ================= FINAL APPROVER DISPLAY =================
        doc.add(new Paragraph("\n"));
        doc.add(new Paragraph("Final Approver: " + finalApprover, HEADER));

        doc.close();
    }

    // ================= HELPERS =================

    private static void addRow(PdfPTable table, String l1, String v1, String l2, String v2) {
        table.addCell(new PdfPCell(new Phrase(l1, LABEL)));
        table.addCell(new PdfPCell(new Phrase(val(v1), NORMAL)));
        table.addCell(new PdfPCell(new Phrase(l2, LABEL)));
        table.addCell(new PdfPCell(new Phrase(val(v2), NORMAL)));
    }

    private static void addSignature(PdfPTable table, String title, String name, Timestamp date) {

        PdfPCell cell = new PdfPCell();

        if (name == null || name.trim().isEmpty()) {
            cell.addElement(new Paragraph(title, HEADER));
          //  cell.addElement(new Paragraph("Signature :", NORMAL));
            cell.addElement(new Paragraph("Name : ", NORMAL));
            cell.addElement(new Paragraph("Date : ", NORMAL));
        } else {
            cell.addElement(new Paragraph(title, HEADER));
           // cell.addElement(new Paragraph("Signature :", NORMAL));
            cell.addElement(new Paragraph("Name : " + name, NORMAL));
            cell.addElement(new Paragraph("Date : " + format(date), NORMAL));
        }

        table.addCell(cell);
    }

    private static void addBudget(PdfPTable table, String label, String value) {
        table.addCell(new PdfPCell(new Phrase(label, LABEL)));
        table.addCell(new PdfPCell(new Phrase(val(value), NORMAL)));
    }

    private static void addAuthority(PdfPTable table, String role, String name, Object date, String comment) {

        if (name == null || name.trim().isEmpty()) return;

        PdfPCell cell = new PdfPCell();
        cell.addElement(new Paragraph(role, HEADER));
        cell.addElement(new Paragraph("Signature :", NORMAL));
        cell.addElement(new Paragraph("Name : " + name, NORMAL));
        cell.addElement(new Paragraph("Date : " + format(date), NORMAL));
        cell.addElement(new Paragraph("Comments : " + val(comment), NORMAL));

        table.addCell(cell);
    }

    private static String getLast(String current, String next) {
        if (next != null && !next.trim().isEmpty()) {
            return next;
        }
        return current;
    }

    private static String format(Object d) {
        if (d == null) return "";
        if (d instanceof Timestamp) return DF.format((Timestamp) d);
        return d.toString();
    }

    private static String val(String v) {
        return v == null ? "" : v;
    }
}