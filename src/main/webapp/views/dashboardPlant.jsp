<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Capital Expenditure Proposal</title>

<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
.modern-reject-card {
  background: linear-gradient(145deg, #fff5f5, #ffebeb);
  border: 1px solid #fecaca;
  border-left: 5px solid #ef4444;
  border-radius: 0.75rem;
  padding: 1.25rem 1.5rem;
  margin: 1.25rem 0;
  box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
}

.reject-header {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 1rem;
}

.status-badge.rejected {
  background-color: #ef4444;
  color: white;
  font-weight: 600;
  padding: 0.35rem 0.85rem;
  border-radius: 9999px;
  font-size: 0.875rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.reject-title {
  margin: 0;
  color: #991b1b;
  font-size: 1.125rem;
  font-weight: 600;
}

.reject-message {
  color: #444;
  margin-bottom: 1rem;
}

.comment-section {
  background: rgba(248, 113, 113, 0.08);
  border: 1px dashed #fca5a5;
  border-radius: 0.5rem;
  padding: 1rem;
}

.comment-label {
  font-weight: 600;
  color: #b91c1c;
  margin-bottom: 0.5rem;
  font-size: 0.95rem;
}

.comment-content {
  color: #374151;
  white-space: pre-wrap;
  line-height: 1.5;
}

.reject-footer {
  margin-top: 1rem;
  color: #6b7280;
  font-size: 0.875rem;
  font-style: italic;
}
.signature-card {
    background: #ffffff;
    border: 1px solid #e3e6ea;
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 20px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.04);
}

.signature-card .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
}

.signature-card h4 {
    font-size: 16px;
    font-weight: 600;
    margin: 0;
    color: #2c3e50;
}

.signature-fields select {
    width: 100%;
    padding: 8px 12px;
    border-radius: 6px;
    border: 1px solid #ced4da;
    font-size: 14px;
}

.approval-status {
    padding: 5px 12px;
    font-size: 12px;
    font-weight: 600;
    color: #155724;
    background-color: #d4edda;
    border: 1px solid #c3e6cb;
    border-radius: 20px;
    letter-spacing: 0.4px;
}
.red-3d-button {
    display: inline-block;
    padding: 12px 24px;
    font-family: Arial, sans-serif;
    font-size: 16px;
    font-weight: bold;
    text-decoration: none;
    color: white;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
    
    /* Red base color with gradient */
    background: #e33d3d;
    background: -webkit-linear-gradient(top, #ff6a6a 0%, #d32f2f 100%);
    background: linear-gradient(to bottom, #ff6a6a 0%, #d32f2f 100%);
    
    /* 3D effect */
    border-radius: 6px;
    box-shadow: 
        0 5px 0 #8b1a1a,
        0 8px 8px rgba(0, 0, 0, 0.3);
    
    /* Shine effect */
    position: relative;
    overflow: hidden;
    transition: all 0.1s ease;
    
    /* Border */
    border: 1px solid #b71c1c;
    
    /* Text alignment */
    text-align: center;
    line-height: 1;
}

/* Shine overlay */
.red-3d-button::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(
        90deg,
        transparent,
        rgba(255, 255, 255, 0.4),
        transparent
    );
    transition: left 0.7s ease;
}

/* Shine animation on hover */
.red-3d-button:hover::before {
    left: 100%;
}

/* Pressed effect */
.red-3d-button:active {
    transform: translateY(5px);
    box-shadow: 
        0 2px 0 #8b1a1a,
        0 5px 8px rgba(0, 0, 0, 0.3);
}

/* Hover effect */
.red-3d-button:hover {
    background: -webkit-linear-gradient(top, #ff7a7a 0%, #e33d3d 100%);
    background: linear-gradient(to bottom, #ff7a7a 0%, #e33d3d 100%);
    cursor: pointer;
}

/* Focus effect */
.red-3d-button:focus {
    outline: none;
    box-shadow: 
        0 5px 0 #8b1a1a,
        0 0 0 3px rgba(255, 106, 106, 0.5);
}

/* Optional: Add a subtle pattern for more shine */
.red-3d-button::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(
        135deg,
        rgba(255, 255, 255, 0.2) 0%,
        rgba(255, 255, 255, 0) 50%,
        rgba(255, 255, 255, 0.1) 100%
    );
    border-radius: 6px;
    pointer-events: none;
}
/* Finance Section Container */
span {
	color: red !important;
}

.finance-section {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	padding: 30px;
	border-radius: 20px;
	box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
	margin: 30px 0;
	color: white;
}

.finance-title {
	color: white;
	font-size: 24px;
	font-weight: 600;
	margin-bottom: 25px;
	text-transform: uppercase;
	letter-spacing: 1px;
	text-align: center;
	text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
}

/* Finance Grid Layout */
.finance-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
	gap: 25px;
}

/* Finance Cards */
.finance-card {
	background: white;
	border-radius: 20px;
	padding: 25px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	border: 1px solid rgba(255, 255, 255, 0.1);
	backdrop-filter: blur(10px);
}

.finance-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 30px 50px rgba(0, 0, 0, 0.2);
}

.finance-card h4 {
	color: #333;
	font-size: 20px;
	font-weight: 600;
	margin-bottom: 25px;
	padding-bottom: 15px;
	border-bottom: 2px solid #667eea;
	position: relative;
}

.finance-card h4:after {
	content: '';
	position: absolute;
	bottom: -2px;
	left: 0;
	width: 50px;
	height: 2px;
	background: #764ba2;
}

/* Finance Fields */
.finance-field {
	margin-bottom: 20px;
	position: relative;
}

.finance-field label {
	display: block;
	color: #555;
	font-size: 14px;
	font-weight: 500;
	margin-bottom: 8px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.finance-field input, .finance-field select, .finance-field textarea {
	width: 100%;
	padding: 12px 15px;
	border: 2px solid #e0e0e0;
	border-radius: 12px;
	font-size: 14px;
	transition: all 0.3s ease;
	background: #f8f9fa;
	box-sizing: border-box;
}

.finance-field input:focus, .finance-field select:focus, .finance-field textarea:focus
	{
	border-color: #667eea;
	outline: none;
	box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
	background: white;
}

.finance-field input[type="number"] {
	-moz-appearance: textfield;
}

.finance-field input[type="number"]::-webkit-outer-spin-button,
	.finance-field input[type="number"]::-webkit-inner-spin-button {
	-webkit-appearance: none;
	margin: 0;
}

.finance-field input:disabled {
	background: #e9ecef;
	cursor: not-allowed;
	border-color: #ced4da;
}

.finance-field small {
	display: block;
	color: #6c757d;
	font-size: 11px;
	margin-top: 5px;
	font-style: italic;
}

.finance-field textarea {
	resize: vertical;
	min-height: 80px;
}

/* Status Styling */
.finance-field select#financeStatus {
	font-weight: 600;
}

.finance-field select#financeStatus option[value="Approved"] {
	background-color: #d4edda;
	color: #155724;
}

.finance-field select#financeStatus option[value="Rejected"] {
	background-color: #f8d7da;
	color: #721c24;
}

.finance-field select#financeStatus option[value="On Hold"] {
	background-color: #fff3cd;
	color: #856404;
}

/* Responsive Design */
@media ( max-width : 768px) {
	.finance-section {
		padding: 20px;
	}
	.finance-grid {
		grid-template-columns: 1fr;
	}
	.finance-card {
		padding: 20px;
	}
	.finance-title {
		font-size: 20px;
	}
}

/* Custom styles for finance cards based on status */
.finance-card.status-approved {
	border-left: 4px solid #28a745;
}

.finance-card.status-rejected {
	border-left: 4px solid #dc3545;
}

.finance-card.status-onhold {
	border-left: 4px solid #ffc107;
}

/* Budget warnings */
.finance-field.budget-warning input {
	border-color: #ffc107;
	background-color: #fff3cd;
}

.finance-field.budget-danger input {
	border-color: #dc3545;
	background-color: #f8d7da;
}

.finance-field.budget-success input {
	border-color: #28a745;
	background-color: #d4edda;
}

/* Animation for balance update */
@
keyframes highlight { 0% {
	background-color: #fff3cd;
}

100


%
{
background-color


:


#f8f9fa
;


}
}
.balance-updated {
	animation: highlight 1s ease;
}

/* Tooltip styles */
.finance-field .tooltip {
	position: relative;
	display: inline-block;
}

.finance-field .tooltip .tooltiptext {
	visibility: hidden;
	width: 200px;
	background-color: #333;
	color: #fff;
	text-align: center;
	border-radius: 6px;
	padding: 5px;
	position: absolute;
	z-index: 1;
	bottom: 125%;
	left: 50%;
	margin-left: -100px;
	opacity: 0;
	transition: opacity 0.3s;
}

.finance-field .tooltip:hover .tooltiptext {
	visibility: visible;
	opacity: 1;
}
</style>
<style>
/* Rejection Remarks - smooth toggle + styling */
.rejection-remarks {
    margin-top: 1rem;
    padding: 1rem;
    background: #fef2f2;
    border: 1px dashed #fca5a5;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.rejection-remarks label {
    color: #991b1b;
    font-weight: 600;
}

.rejection-remarks textarea {
    width: 100%;
    min-height: 100px;
    padding: 10px;
    border: 1px solid #fca5a5;
    border-radius: 6px;
    resize: vertical;
}

.rejection-remarks textarea:required {
    border-color: #ef4444;
}

.char-count {
    display: block;
    text-align: right;
    font-size: 0.85rem;
    color: #6b7280;
    margin-top: 4px;
}
.budget-warning {
            display:none;
            color:#dc2626;
            font-weight:500;
            margin:10px 0;
            padding:10px 14px;
            background:#fef2f2;
            border:1px solid #fecaca;
            border-radius:6px;
        }
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Roboto', sans-serif;
	background: #f5f7fa;
	color: #333;
	line-height: 1.6;
}

.capex-header {
	background: linear-gradient(135deg, #2c3e50, #34495e);
	color: white;
	padding: 15px 30px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	position: sticky;
	top: 0;
	z-index: 1000;
}

.capex-header-content {
	display: flex;
	align-items: center;
	gap: 20px;
}

.capex-icon img {
	height: 60px;
	filter: brightness(0) invert(1);
}

.capex-header h1 {
	font-size: 24px;
	font-weight: 700;
	margin-bottom: 4px;
}

.capex-header p {
	font-size: 14px;
	opacity: 0.9;
}

.page-title-small {
	font-size: 1.1rem;
	margin-top: 4px;
	opacity: 0.9;
}

.user-info {
	display: flex;
	align-items: center;
	gap: 15px;
}

.user-info button {
	background: #e74c3c;
	color: white;
	border: none;
	padding: 8px 20px;
	border-radius: 6px;
	cursor: pointer;
}

.capex-container {
	max-width: 1400px;
	margin: 30px auto;
	padding: 0 20px;
}

.capex-card {
	background: white;
	border-radius: 12px;
	padding: 30px;
	margin-bottom: 25px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
	border: 1px solid #eaeaea;
}

.capex-card h3 {
	font-size: 20px;
	margin-bottom: 25px;
	color: #2c3e50;
	display: flex;
	align-items: center;
	gap: 10px;
}

.form-grid, .cost-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 20px;
	margin-bottom: 25px;
}

.form-group {
	display: flex;
	flex-direction: column;
}

.form-group label {
	font-weight: 500;
	margin-bottom: 8px;
	color: #555;
	font-size: 14px;
}

.form-group label span {
	color: #e74c3c;
}

.form-group input, .form-group select, .form-group textarea {
	padding: 12px 15px;
	border: 1px solid #ddd;
	border-radius: 8px;
	font-size: 14px;
}

.form-group input:focus, .form-group select:focus, .form-group textarea:focus
	{
	border-color: #3498db;
	box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
	outline: none;
}

.full-width {
	grid-column: 1/-1;
}

textarea {
	min-height: 100px;
	resize: vertical;
}

.cost-group {
	background: #f8f9fa;
	padding: 20px;
	border-radius: 10px;
	border: 1px solid #e9ecef;
}

.cost-group input, .cost-group select {
	width: 100%;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 6px;
	margin-bottom: 8px;
}

.cost-group small {
	color: #6c757d;
	font-size: 12px;
	display: block;
	margin-top: 5px;
}

.investment-grid {
	display: flex;
	gap: 25px;
}

.investment-group {
	background: #f8f9fa;
	padding: 25px;
	border-radius: 10px;
	border: 1px solid #e9ecef;
}

.investment-label {
	font-weight: 500;
	margin-bottom: 12px;
	display: block;
	color: #444;
}

.required {
	color: #e74c3c;
}

.upload-container {
	display: flex;
	align-items: center;
	gap: 15px;
	flex-wrap: wrap;
	margin-top: 12px;
}

.upload-btn {
	background: #3498db;
	color: white;
	padding: 10px 16px;
	border-radius: 6px;
	cursor: pointer;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	font-size: 14px;
}

.upload-btn:hover {
	background: #2980b9;
}

.file-name {
	color: #555;
	font-size: 14px;
}

.file-name-display {
	font-size: 13px;
	color: #2c3e50;
	margin-top: 6px;
	word-break: break-all;
}

.current-file {
	margin-top: 8px;
	font-size: 13px;
	color: #555;
}

.current-file a {
	color: #3498db;
	text-decoration: underline;
}

.current-file a:hover {
	color: #2980b9;
}

.signature-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
	gap: 25px;
}

.signature-card {
	background: #f8f9fa;
	padding: 25px;
	border-radius: 10px;
	border: 1px solid #e9ecef;
}

.signature-card h4 {
	font-size: 16px;
	margin-bottom: 20px;
	color: #2c3e50;
	text-align: center;
}

.signature-box {
	width: 100%;
	height: 120px;
	border: 2px dashed #bdc3c7;
	border-radius: 8px;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 12px;
	overflow: hidden;
}

.signature-box.uploaded {
	border: 2px solid #27ae60;
	background: #f0fff4;
}

.signature-box img {
	max-width: 90%;
	max-height: 90%;
	object-fit: contain;
}

.signature-box span {
	color: #7f8c8d;
	font-size: 14px;
}

.signature-actions {
	display: flex;
	justify-content: center;
	margin-bottom: 12px;
}

.signature-fields {
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.signature-fields select, .signature-fields input {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 6px;
}

.remove-btn {
	background: #e74c3c;
	color: white;
	border: none;
	border-radius: 50%;
	width: 22px;
	height: 22px;
	cursor: pointer;
	font-size: 14px;
	margin-left: 6px;
}

.action-bar {
	display: flex;
	justify-content: center;
	margin: 40px 0;
}

.submit-btn {
	background: linear-gradient(135deg, #27ae60, #229954);
	color: white;
	border: none;
	padding: 18px 45px;
	border-radius: 10px;
	font-size: 18px;
	font-weight: 600;
	cursor: pointer;
}

.submit-btn:hover {
	transform: translateY(-2px);
}

.alert {
	padding: 15px 20px;
	border-radius: 8px;
	margin: 20px 0;
	display: flex;
	align-items: center;
	gap: 12px;
}

.alert-success {
	background: #d4edda;
	color: #155724;
	border: 1px solid #c3e6cb;
}

.alert-error {
	background: #f8d7da;
	color: #721c24;
	border: 1px solid #f5c6cb;
}

.loading-overlay {
	position: fixed;
	inset: 0;
	background: rgba(0, 0, 0, 0.7);
	display: none;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	z-index: 9999;
	color: white;
}

.loading-spinner {
	width: 50px;
	height: 50px;
	border: 4px solid rgba(255, 255, 255, 0.3);
	border-top-color: #3498db;
	border-radius: 50%;
	animation: spin 1s linear infinite;
	margin-bottom: 20px;
}

@
keyframes spin {to { transform:rotate(360deg);
	
}

}
@media ( max-width :768px) {
	.capex-header {
		flex-direction: column;
		text-align: center;
		gap: 15px;
		padding: 15px;
	}
	.form-grid, .cost-grid, .signature-grid, .investment-grid {
		grid-template-columns: 1fr;
	}
}
</style>
</head>
<body>

	<div id="loadingOverlay" class="loading-overlay">
		<div class="loading-spinner"></div>
		<p id="loadingText">Submitting your proposal...</p>
	</div>

	<header class="capex-header">
		<div class="capex-header-content">
			<div class="capex-icon">
				<img src="/capex/resources/images/Ramky-Logo.png" alt="Company Logo">
			</div>
			<div>
				<h1>Capital Expenditure Proposal</h1>
				<p class="page-title-small">
					<c:choose>
						<c:when test="${not empty editList}">Edit Proposal - ${editList.capex_number}</c:when>
						<c:otherwise>Submit New Proposal</c:otherwise>
					</c:choose>
				</p>
			</div>
		</div>
		<div class="user-info"> 
			<span style="color: white !important">Pending at ${editList.role} (${editList.pendingAt}) <c:out
					value="" default="User" /></span>
			<a href="<%=request.getContextPath()%>/form/capex" class="red-3d-button">Go
				Back</a>
		</div>
	</header>

	<div class="capex-container">
				<c:if test="${editList.finance_status eq 'Rejected'}">
  <div class="alert alert-danger border-danger border-3 border-start border-0 shadow-sm mb-4" role="alert">
    <div class="d-flex align-items-center gap-3">
      <i class="bi bi-x-circle-fill fs-4"></i>
      <div>
        <strong>Rejected by Finance Department</strong>
        <c:if test="${not empty editList.finance_comments}">
          <div class="mt-1">
            Reason: <span class="fw-medium">${fn:escapeXml(editList.finance_comments)}</span>
          </div>
        </c:if>
      </div>
    </div>
  </div>
</c:if>
		<form id="capexForm"
			action="${not empty editList ? (pageContext.request.contextPath.concat('/form/update')) : (pageContext.request.contextPath.concat('/form/submit'))}"
			method="post" enctype="multipart/form-data">

			<!-- Hidden fields -->
			<input type="hidden" name="id" value="${editList.id}"> <input
				type="hidden" name="capex_number" id="capex_number"
				value="${editList.capex_number}">

			<c:if test="${not empty successMessage}">
				<div class="alert alert-success">
					<i class="material-icons">check_circle</i> ${successMessage}
				</div>
			</c:if>
			<c:if test="${not empty errorMessage}">
				<div class="alert alert-error">
					<i class="material-icons">error</i> ${errorMessage}
				</div>
			</c:if>

			<!-- Basic Information -->
			<section class="capex-card">
				<h3>
					<i class="material-icons">description</i> Basic Information
				</h3>
				<div class="form-grid">
					<div class="form-group">
						<label>CAPEX Title <span>*</span></label> <input type="text"
							name="capex_title" value="${editList.capex_title}" required>
					</div>
					<div class="form-group">
						<label>Plant Code <span>*</span></label> 
				<select id="plantCode" name="plant_code" required onchange="updateSbuAndLocation()">
					    <option value="">Select Plant</option>
					    <c:forEach var="obj" items="${pList}">
					        <option value="${obj.plant_code}"
					            data-sbu="${obj.sbu}"
					            data-location="${obj.location}"
					            data-budget="${obj.total_available_budget_fy}"
					            ${obj.plant_code == editList.plant_code ? 'selected' : ''}>
					
					            [${obj.plant_code}] - ${obj.plant_name}
					        </option>
					    </c:forEach>
					</select>
					</div>
					<div class="form-group">
						<label>Department / Function <span>*</span></label> <select
							name="department" required>
							<option value="">Select department</option>
							<c:forEach var="obj" items="${departmentList}">
								<option value="${obj.department_code}"
									${obj.department_code == editList.department ? 'selected' : ''}>
									[${obj.department_code}] - ${obj.department_name}</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label>Business Unit <span>*</span></label>
						<p id="displaySbu"
							style="padding: 12px 15px; background: #f8f9fa; border: 1px solid #ddd; border-radius: 8px; min-height: 42px; margin: 0;">
							${editList.business_unit}</p>
						<input type="hidden" name="business_unit" id="businessUnit"
							value="${editList.business_unit}" required>
					</div>
					<div class="form-group">
						<label>Location <span>*</span></label>
						<p id="displayLocation"
							style="padding: 12px 15px; background: #f8f9fa; border: 1px solid #ddd; border-radius: 8px; min-height: 42px; margin: 0;">
							${editList.location}</p>
						<input type="hidden" name="location" id="location"
							value="${editList.location}" required>
					</div>
					 <div class="form-group">
                    	<label>Available Budget (₹)</label>
                    <div id="displayBudget" class="budget-info">—</div>
                </div>
				</div>
				
				<div class="form-group full-width">
					<label>Asset Description <span>*</span></label>
					<textarea name="asset_description" required>${editList.asset_description}</textarea>
				</div>
			</section>

			<!-- Cost Estimation -->
			<section class="capex-card">
				<h3>
					<i class="material-icons">attach_money</i> Cost Estimation
				</h3>
				<div class="cost-grid">
				
					<div class="cost-group">
						<label>Estimate of Proposal / Basic Cost (₹) <span>*</span></label>
						<input type="number" id="basicCost" name="basic_cost" oninput="validateBudgetLimit();updateCostCalculations();"
							value="${editList.basic_cost}" step="0.01" min="0" required>
						<small>Numeric value in Crores</small>
						<div id="budgetWarning" class="budget-warning" style="display:none;"></div>
					</div>
					<div class="cost-group">
						<label>GST Rate <span>*</span></label> <select id="gstRate" onchange="updateCostCalculations()"
							name="gst_rate" required>
							<option value="">Select GST %</option>
							<option value="5"
								${editList.gst_rate == '5.00'  ? 'selected' : ''}>5%</option>
							<option value="12"
								${editList.gst_rate == '12.00' ? 'selected' : ''}>12%</option>
							<option value="18"
								${editList.gst_rate == '18.00' ? 'selected' : ''}>18%</option>
							<option value="28"
								${editList.gst_rate == '28.00' ? 'selected' : ''}>28%</option>
						</select>
					</div>
					<div class="cost-group">
						<label>GST Amount (₹) <span>*</span></label> <input type="text"
							id="gstAmount" name="gst_amount" value="${editList.gst_amount}"
							readonly required> <small>Auto-calculated</small>
					</div>
					<div class="cost-group">
						<label>Total Estimate Including GST (₹) <span>*</span></label> <input
							type="text" id="totalCost" name="total_cost"
							value="${editList.total_cost}" readonly required> <small>Auto-calculated</small>
					</div>
				</div>
			</section>

			<!-- Investment Details -->
			<section class="capex-card">
				<h3>
					<i class="material-icons">trending_up</i> Investment Details
				</h3>
				<div class="investment-grid">
					<div class="investment-group">
						<label class="investment-label">Return on Investment (ROI)
							& Payback Period <span class="required">*</span>
						</label>
						<textarea name="roi_text" maxlength="500" rows="4" required>${editList.roi_text}</textarea>
						<div class="upload-container">
							<label class="upload-btn"> <i class="material-icons">attach_file</i>
								Upload Supporting Document <input type="file" name="roiFile"
								accept=".pdf,.xls,.xlsx,.jpg,.jpeg,.png" hidden>
							</label><c:if test="${empty editList.roi_file_name}"><span class="file-name" id="roiFileName">No file selected</span></c:if>
						</div>
						<input type="hidden" name="roi_file_name"
							value="${editList.roi_file_name}">
						<c:if test="${not empty editList.roi_file_name}">
							<div class="current-file">
								Current file: <a
									href="${pageContext.request.contextPath}/resources/Attachments/${editList.capex_number}/${editList.roi_file_name}"
									target="_blank">roi_document</a>
							</div>
						</c:if>
						<div class="file-name-display" id="roiFileDisplay"></div>
					</div>

					<div class="investment-group">
						<label class="investment-label">Project Timeline (with
							Zero Date) <span class="required">*</span>
						</label>
						<textarea name="timeline_text" maxlength="500" rows="4" required>${editList.timeline_text}</textarea>
						<div class="upload-container">
							<label class="upload-btn"> <i class="material-icons">attach_file</i>
								Upload Supporting Document <input type="file"
								name="timelineFile" accept=".pdf,.xls,.xlsx,.jpg,.jpeg,.png"
								hidden>
							</label> <c:if test="${empty editList.timeline_file_name}"><span class="file-name" id="timelineFileName">No file
								selected</span></c:if>
						</div>
						<input type="hidden" name="timeline_file_name"
							value="${editList.timeline_file_name}">
						<c:if test="${not empty editList.timeline_file_name}">
							<div class="current-file">
								Current file: <a
									href="${pageContext.request.contextPath}/resources/Attachments/${editList.capex_number}/${editList.timeline_file_name}"
									target="_blank">timeline_plan</a>
							</div>
						</c:if>
						<div class="file-name-display" id="timelineFileDisplay"></div>
					</div>

					<div class="investment-group">
						<label class="investment-label">Reason for Purchase / Key
							Milestones / Expected Savings <span class="required">*</span>
						</label>
						<textarea name="reason_text" maxlength="500" rows="5" required>${editList.reason_text}</textarea>
						<div class="upload-container">
							<label class="upload-btn"> <i class="material-icons">attach_file</i>
								Upload Supporting Document <input type="file" name="reasonFile"
								accept=".pdf,.xls,.xlsx,.jpg,.jpeg,.png" hidden>
							</label> <c:if test="${empty editList.reason_file_name}"><span class="file-name" id="reasonFileName">No file
								selected</span></c:if>
						</div>
						<input type="hidden" name="reason_file_name"
							value="${editList.reason_file_name}">
						<c:if test="${not empty editList.reason_file_name}">
							<div class="current-file">
								Current file: <a
									href="${pageContext.request.contextPath}/resources/Attachments/${editList.capex_number}/${editList.reason_file_name}"
									target="_blank">reason_justification</a>
							</div>
						</c:if>
						<div class="file-name-display" id="reasonFileDisplay"></div>
					</div>
				</div>
			</section>

			<!-- Digital Signatures / Approval chain -->
			
				<section class="capex-card">
					<h3
						style="display: flex; align-items: center; gap: 8px; color: #1976d2; margin-bottom: 5px; font-weight: 600;">
						<i class="material-icons" style="font-size: 22px;">create</i>
						Digital Signature
					</h3>
					<h4 style="margin-top: 5px; color: #333; font-weight: 500;">
						Prepared By : <span
							style="color: #4e28a5 !important; font-weight: 600;">${editList.user_name}</span>
						<span
							style="color: #4e28a5 !important; font-size: 14px; margin-left: 10px;">|
							Signed on ${editList.updated_at}</span>
					</h4>

					<div class="signature-grid">
						<div class="signature-card">
							<h4>Requested By</h4>
							<div class="signature-fields">
								<select name="requested_by_name" required>
									<option value="">-- Select Employee --</option>
									<c:forEach var="obj" items="${uList}">
										<option value="${obj.user_id}"
											${obj.user_id == editList.requested_by_name ? 'selected' : ''}>
											[${obj.user_id}] - ${obj.user_name}</option>
									</c:forEach>
								</select>
							</div>
							<span
							style="color: #4e28a5 !important; font-size: 14px; margin-left: 10px;">
							Signed on ${editList.requested_by_date}</span>
						</div>

						<div class="signature-card">
							<h4>Project Manager / Execution</h4>
							 <div class="card-header">
							
							        <c:if test="${not empty editList.project_manager_date}">
							            <span class="approval-status">
							                ✓ Approved
							            </span>
							        </c:if>
							    </div>
							<div class="signature-fields">
							<c:if test="${not empty fn:trim(editList.project_manager_date)}">
							<select name="project_manager_name" id="projectManager" required>
									<option value="">Select Name</option>
									<c:forEach var="obj" items="${uList}">
										<option value="${obj.user_id}"  data-plant="${obj.base_project}"
											${obj.user_id == editList.project_manager_name ? 'selected' : ''}>
											[${obj.user_id}] - ${obj.user_name}</option>
									</c:forEach>
								</select>
							</c:if>
							<c:if test="${empty fn:trim(editList.project_manager_date)}">
							    <div class="form-group row">
							        <label class="col-md-4 col-form-label font-weight-bold">
							            Project Manager
							        </label>
							        <div class="col-md-8">
							            <input type="hidden" name="project_manager_name" 
							                   value="${editList.project_manager_name}" />
							
							            <div class="form-control bg-light border-0">
							                <i class="fa fa-user text-primary"></i>
							                ${editList.project_manager_fullname}
							            </div>
							        </div>
							    </div>
							</c:if>
							</div>
							<span style="color: #4e28a5 !important; font-size: 14px; margin-left: 10px;">
							Signed on ${editList.project_manager_date}</span>
						</div>
						</div>
					</section>


						
						<c:if test="${not empty fn:trim(editList.project_manager_date) and editList.department ne 'GN'}">
						<input type="hidden" 
name="current_pending_at" 
id="head_of_plant_name" />
							<div class="signature-card">
							    <div class="card-header">
							        <h4>Head of the Plant (User)</h4>
							
							        <c:if test="${not empty editList.head_of_plant_name}">
							            <span class="approval-status">
							                ✓ Approved
							            </span>
							        </c:if>
							    </div>
							
							    <div class="signature-fields">
							        <select name="head_of_plant_name" required>
							            <option value="">Select Name</option>
							            <!-- AJAX will populate -->
							        </select>
							    </div>
							    <span style="color: #4e28a5 !important; font-size: 14px; margin-left: 10px;">
							Signed on ${editList.head_of_plant_date}</span>
							</div>
								<input type="hidden" 
<c:if test="${ not  empty fn:trim(editList.project_manager_name) and empty editList.head_of_plant_name
and editList.department ne 'GN'}"> 
name="current_pending_at" 
</c:if>id="finance_name" />
						</c:if>
					</div>
				</section>
				
<input type="hidden" 
					 
					name="current_pending_at" 
					id="regional_director_name" />

	<c:if test="${not empty fn:trim(editList.head_of_plant_name) and editList.department ne 'GN'}">
	
					
					
					<section class="capex-card finance-section">
    <h3 class="finance-title">TO BE COMPLETED BY FINANCE DEPARTMENT</h3>
     <span style="color: #4e28a5 !important; font-size: 14px; margin-left: 10px;">
							Signed on ${editList.finance_date}</span>
    <div class="finance-grid">
        <div class="finance-card">
            <h4>CAPITAL EXPENDITURE BUDGET</h4>
            <div class="finance-field">
                <label>Department <span>*</span></label>
                <select id="financeDept" name="finance_department" required>
                    <option value="">Select department</option>
                    <c:forEach var="obj" items="${departmentList}">
                        <option value="${obj.department_code}"
                                ${obj.department_code == editList.department ? 'selected' : ''}>
                            [${obj.department_code}] - ${obj.department_name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="finance-field">
                <label>Capital Expenditure Category <span>*</span></label>
                <select id="financeCategory" name="finance_category" required>
                    <option value="">Select Category</option>
                    <option value="Admin" ${editList.finance_category == 'Admin' ? 'selected' : ''}>Admin</option>
                    <option value="Bins" ${editList.finance_category == 'Bins' ? 'selected' : ''}>Bins</option>
                    <option value="Civil" ${editList.finance_category == 'Civil' ? 'selected' : ''}>Civil</option>
                    <option value="Digital" ${editList.finance_category == 'Digital' ? 'selected' : ''}>Digital</option>
                    <option value="Fleet" ${editList.finance_category == 'Fleet' ? 'selected' : ''}>Fleet</option>
                    <option value="Laboratory" ${editList.finance_category == 'Laboratory' ? 'selected' : ''}>Laboratory</option>
                    <option value="Landfill" ${editList.finance_category == 'Landfill' ? 'selected' : ''}>Landfill</option>
                    <option value="Plant & Machinery" ${editList.finance_category == 'Plant & Machinery' ? 'selected' : ''}>Plant & Machinery</option>
                    <option value="Safety" ${editList.finance_category == 'Safety' ? 'selected' : ''}>Safety</option>
                </select>
            </div>
            <div class="finance-field">
                <label>Total Budget Available (₹) <span>*</span></label>
                <input type="number" id="totalBudget" name="total_budget"
                       value="${editList.total_budget}" step="0.01" min="0" disabled>
                <small>90CR limit</small>
            </div>
            <div class="finance-field">
                <label>Proposed Purchase Price (₹) <span>*</span></label>
                <input type="number" id="proposedPrice" name="proposed_price"
                       value="${editList.total_cost}" step="0.01" min="0" required>
            </div>
            <div class="finance-field">
                <label>Available Balance After (₹) <span>*</span></label>
                <input type="text" id="availableBalance" name="available_balance"
                       value="${editList.available_balance}" readonly required>
                <small>Auto-calculated</small>
            </div>
        </div>
<input type="hidden" name="remarks" value="Reason : " />
        <div class="finance-card">
            <h4>Reviewed by Finance Department</h4>
            <div class="finance-field">
                <label>Signature Status <span>*</span></label>
                <select id="financeStatus" name="finance_status" required>
                    <option value="">Select status</option>
                    <option value="Approved" ${editList.finance_status == 'Approved' ? 'selected' : ''}>Approved</option>
                    <option value="Rejected" ${editList.finance_status == 'Rejected' ? 'selected' : ''}>Rejected</option>
                    <option value="On Hold" ${editList.finance_status == 'On Hold' ? 'selected' : ''}>On Hold</option>
                </select>
            </div>

            <!-- Remarks / Rejection Reason - toggles on Rejected -->
            <div class="finance-field rejection-remarks" id="rejectionRemarks" style="display: ${editList.finance_status == 'Rejected' ? 'block' : 'none'};">
                <label>Remarks / Reason for Rejection <span class="required">*</span></label>
                <textarea id="financeComments" name="remarks" maxlength="500" 
                          ${editList.finance_status == 'Rejected' ? 'required' : ''}>
                    ${editList.remarks}
                </textarea>
                <small class="char-count">0 / 500 characters</small>
            </div>
						
            <div class="finance-field">
                <label>Name <span>*</span></label>
                <select name="finance_name" required>
                    <option value="">Select Name</option>
                    <option value="${editList.finance_name}" selected>${editList.finance_name}</option>
                </select>
            </div>
            <div class="finance-field">
									<label>Comments <span>*</span></label>
									<textarea id="financeComments" name="finance_comments"
										maxlength="100" required>${editList.finance_comments}</textarea>
								</div>
        </div>
    </div>
</section>
				
				</c:if>



				<c:if
					test="${((editList.finance_status eq 'Approved') or (editList.department eq 'GN' ))}">
					<section class="capex-card">
    <h3 class="finance-title">TO BE COMPLETED BY APPROPRIATE AUTHORITY</h3>
    <div class="signature-grid">

        <!-- Regional Director -->
        <div class="signature-card">
            <div class="card-header">
                <h4>Regional Director</h4>
                <c:if test="${not empty editList.regional_director_name}">
                    <span class="approval-status">✓ Approved</span>
                </c:if>
            </div>
            <div class="signature-fields">
                <select class="authority-name" name="regional_director_name"
                    data-role="regionalDirector" required>
                    <option value="">Select Name</option>
                    <option value="Ashok Pawar" ${editList.regional_director_name == 'Ashok Pawar' ? 'selected' : ''}>Ashok Pawar</option>
                </select>
                <div class="comment-field">
                    <textarea class="authority-comment"
                        name="regional_director_comment" data-role="regionalDirector"
                        maxlength="200"
                        placeholder="Enter comments (max 200 characters)" required>${editList.regional_director_comment}</textarea>
                    <span class="comment-counter">0 / 200</span>
                </div>
            </div>
        </div>

        <input type="hidden" 
                name="current_pending_at" 
            id="finance_controller_name" />

        <!-- Finance Controller -->
        <c:if test="${not empty fn:trim(editList.regional_director_name)}">
            <div class="signature-card finance-controller-section">
                <div class="card-header">
                    <h4>Finance Controller</h4>
                    <c:if test="${not empty editList.finance_controller_name}">
                        <span class="approval-status">✓ Approved</span>
                    </c:if>
                </div>
                <div class="signature-fields">
                    <select class="authority-name" name="finance_controller_name"
                        data-role="headProjects" required>
                        <option value="">Select Name</option>
                        <option value="Ashok Pawar" ${editList.finance_controller_name == 'Ashok Pawar' ? 'selected' : ''}>Ashok Pawar</option>
                    </select>
                    <div class="comment-field">
                        <textarea class="authority-comment"
                            name="finance_controller_comment" data-role="headProjects"
                            maxlength="200"
                            placeholder="Enter comments (max 200 characters)" required>${editList.finance_controller_comment}</textarea>
                        <span class="comment-counter">0 / 200</span>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Department-based routing -->
        <c:choose>
            <c:when test="${editList.department ne 'OPS'}">
                <!-- Non-OPS Department: Include Head Projects -->
                <input type="hidden" 
                        name="current_pending_at" 
                    id="head_projects_name" />

                <!-- Head Projects (HO) -->
                <c:if test="${not empty fn:trim(editList.finance_controller_name)}">
                    <div class="signature-card">
                        <div class="card-header">
                            <h4>
                             <c:if test="${ editList.department eq 'ERM'}">
		                        ERM Head 
		                    </c:if> 
                    		<c:if test="${ editList.department ne 'ERM'}">
		                       Head Projects (HO)
		                    </c:if> 
                           </h4>
                            <c:if test="${not empty editList.head_projects_name}">
                                <span class="approval-status">✓ Approved</span>
                            </c:if>
                        </div>
                        <div class="signature-fields">
                            <select class="authority-name" name="head_projects_name"
                                data-role="headProjects" required>
                                <option value="">Select Name</option>
                                <option value="Ashok Pawar" ${editList.head_projects_name == 'Ashok Pawar' ? 'selected' : ''}>Ashok Pawar</option>
                            </select>
                            <div class="comment-field">
                                <textarea class="authority-comment"
                                    name="head_projects_comment" data-role="headProjects"
                                    maxlength="200"
                                    placeholder="Enter comments (max 200 characters)" required>${editList.head_projects_comment}</textarea>
                                <span class="comment-counter">0 / 200</span>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Business Head (after Head Projects) -->
                <c:if test="${not empty fn:trim(editList.head_projects_name)}">
                    <div class="signature-card">
                        <div class="card-header">
                            <h4>Business Head</h4>
                            <c:if test="${not empty editList.business_head_name}">
                                <span class="approval-status">✓ Approved</span>
                            </c:if>
                        </div>
                        <div class="signature-fields business-head-section">
                            <select class="authority-name" name="business_head_name"
                                data-role="businessHead" required>
                                <option value="">Select Name</option>
                                <option value="Business Head" ${editList.business_head_name == 'Business Head' ? 'selected' : ''}>Business Head</option>
                            </select>
                            <div class="comment-field">
                                <textarea class="authority-comment"
                                    name="business_head_comment" data-role="businessHead"
                                    maxlength="200"
                                    placeholder="Enter comments (max 200 characters)" required>${editList.business_head_comment}</textarea>
                                <span class="comment-counter">0 / 200</span>
                            </div>
                        </div>
                    </div>
                </c:if>

                <input type="hidden" 
                        name="current_pending_at" 
                    id="business_head_name" />
            </c:when>

            <c:otherwise>
                <!-- OPS Department: Business Head directly after Finance Controller -->
                <c:if test="${not empty fn:trim(editList.finance_controller_name)}">
                    <div class="signature-card">
                        <div class="card-header">
                            <h4>Business Head</h4>
                            <c:if test="${not empty editList.business_head_name}">
                                <span class="approval-status">✓ Approved</span>
                            </c:if>
                        </div>
                        <div class="signature-fields business-head-section">
                            <select class="authority-name" name="business_head_name"
                                data-role="businessHead" required>
                                <option value="">Select Name</option>
                                <option value="Business Head" ${editList.business_head_name == 'Business Head' ? 'selected' : ''}>Business Head</option>
                            </select>
                            <div class="comment-field">
                                <textarea class="authority-comment"
                                    name="business_head_comment" data-role="businessHead"
                                    maxlength="200"
                                    placeholder="Enter comments (max 200 characters)" required>${editList.business_head_comment}</textarea>
                                <span class="comment-counter">0 / 200</span>
                            </div>
                        </div>
                    </div>
                </c:if>

                <input type="hidden" 
                        name="current_pending_at" 
                    id="business_head_name" />
            </c:otherwise>
        </c:choose>

        <!-- CFO -->
        <input type="hidden" 
                name="current_pending_at" 
            id="cfo_name" />

        <c:if test="${not empty fn:trim(editList.business_head_name)}">
            <div class="signature-card">
                <div class="card-header">
                    <h4>CFO</h4>
                    <c:if test="${not empty editList.cfo_name}">
                        <span class="approval-status">✓ Approved</span>
                    </c:if>
                </div>
                <div class="signature-fields">
                    <select class="authority-name" name="cfo_name" data-role="cfo" required>
                        <option value="">Select Name</option>
                        <option value="CFO" ${editList.cfo_name == 'CFO' ? 'selected' : ''}>CFO</option>
                    </select>
                    <div class="comment-field">
                        <textarea class="authority-comment" name="cfo_comment"
                            data-role="cfo" maxlength="200"
                            placeholder="Enter comments (max 200 characters)" required>${editList.cfo_comment}</textarea>
                        <span class="comment-counter">0 / 200</span>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- CEO & MD -->
        <input type="hidden" 
            
                name="current_pending_at" 
           
            id="ceo_name" />

        <c:if test="${not empty fn:trim(editList.cfo_name)}">
            <div class="signature-card ceo-section">
                <div class="card-header">
                    <h4>CEO & MD</h4>
                    <c:if test="${not empty editList.ceo_name}">
                        <span class="approval-status">✓ Approved</span>
                    </c:if>
                </div>
                <div class="signature-fields">
                    <select class="authority-name" name="ceo_name" data-role="ceo" required>
                        <option value="">Select Name</option>
                        <option value="CEO & MD" ${editList.ceo_name == 'CEO & MD' ? 'selected' : ''}>CEO & MD</option>
                    </select>
                    <div class="comment-field">
                        <textarea class="authority-comment" name="ceo_comment"
                            data-role="ceo" maxlength="200"
                            placeholder="Enter comments (max 200 characters)" required>${editList.ceo_comment}</textarea>
                        <span class="comment-counter">0 / 200</span>
                    </div>
                </div>
            </div>
        </c:if>

    </div>
</section>
				</c:if>
 
		<div class="action-bar">
		    <c:if test="${editList.finance_status ne 'Rejected' && (sessionScope.BASE_ROLE eq 'Admin' || sessionScope.USER_ID eq editList.current_pending_at)}">
		        <button type="submit" class="submit-btn">
		            <i class="material-icons">${not empty editList ? 'save' : 'send'}</i>
		            ${not empty editList ? 'Approved' : 'Submit Proposal'}
		        </button>
		    </c:if>
		    
		    <c:if test="${!(editList.finance_status ne 'Rejected' && (sessionScope.BASE_ROLE eq 'Admin' || sessionScope.USER_ID eq editList.current_pending_at))}">
		        <div class="not-authorized" style="color: #d32f2f; padding: 12px; font-weight: 500;">
		            Not Authorized
		        </div>
		    </c:if>
		</div>
		</form>
	</div>

	<form action="<%=request.getContextPath()%>/form/capex" id="logoutForm"
		method="post"></form>

	<script>
	// Format number with Indian comma style
	function formatBudget(num) {
	    if (!num && num !== 0) return '—';
	    return Number(num).toLocaleString('en-IN');
	}
// File name display + remove
function showFileName(input, displayId) {
    var file = input.files[0];
    var el = document.getElementById(displayId);
    if (file) {
        el.innerHTML = file.name + ' <button type="button" class="remove-btn" onclick="clearFile(\'' + input.name + '\', \'' + displayId + '\')">×</button>';
    } else {
        el.innerHTML = '';
    }
}

function clearFile(name, displayId) {
    document.querySelector('input[name="' + name + '"]').value = '';
    document.getElementById(displayId).innerHTML = '';
}

// Signature preview
function handleSignatureUpload(e) {
    var input = e.target;
    var file = input.files[0];
    if (!file) return;

    var role = input.dataset.role;
    var box = document.getElementById(role + 'Box');
    var nameEl = document.getElementById(role + 'NameDisplay');

    var reader = new FileReader();
    reader.onload = function(ev) {
        box.innerHTML = '<img src="' + ev.target.result + '" alt="Signature">';
        box.classList.add('uploaded');
        nameEl.innerHTML = file.name + ' <button type="button" class="remove-btn" onclick="clearSignature(\'' + role + '\')">×</button>';
    };
    reader.readAsDataURL(file);
}

function clearSignature(role) {
    var box = document.getElementById(role + 'Box');
    var input = document.querySelector('input[data-role="' + role + '"]');
    var nameEl = document.getElementById(role + 'NameDisplay');

    box.classList.remove('uploaded');
    box.innerHTML = '<span>Upload Signature</span>';
    input.value = '';
    nameEl.innerHTML = '';
}

// Plant → Business Unit & Location
function validateBudgetLimit() {
    if (selectedPlantBudget === null) return;

    var basicCostEl = document.getElementById('basicCost');
    var basicCost = Number(basicCostEl.value) || 0;
    var warningEl = document.getElementById('budgetWarning');

    if (basicCost > selectedPlantBudget) {
        var msg = 'Warning: Proposed cost (₹ ' + formatBudget(basicCost) + 
                  ') exceeds available plant budget (₹ ' + formatBudget(selectedPlantBudget) + ')!';
        
        warningEl.textContent = msg;
        warningEl.style.display = 'block';
        basicCostEl.style.borderColor = '#dc2626';
        basicCostEl.style.backgroundColor = '#fef2f2';
    } else {
        warningEl.style.display = 'none';
        basicCostEl.style.borderColor = '';
        basicCostEl.style.backgroundColor = '';
    }
}
//Global variable for selected plant budget
var selectedPlantBudget = null;

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('basicCost').addEventListener('input', function() {
        validateBudgetLimit();
        updateCostCalculations();
    });

    document.getElementById('gstRate').addEventListener('change', function() {
        updateCostCalculations();
        validateBudgetLimit();
    });

    // File name display
    document.querySelectorAll('input[type="file"]').forEach(function(inp) {
        inp.addEventListener('change', function() {
            var display = document.getElementById(inp.name + 'Display');
            if (display && inp.files[0]) {
                display.innerHTML = inp.files[0].name + 
                    ' <button type="button" class="remove-btn" onclick="clearFile(\'' + inp.name + '\', \'' + inp.name + 'Display\')">×</button>';
            }
        });
    });

    // Final submit validation: check TOTAL ESTIMATE vs budget
    document.getElementById('capexForm').addEventListener('submit', function(e) {
        if (selectedPlantBudget !== null) {
            var totalEstimate = Number(document.getElementById('totalCost').value) || 0;
            
            if (totalEstimate > selectedPlantBudget) {
                e.preventDefault();
                Swal.fire({
                    icon: 'error',
                    title: 'Budget Limit Exceeded',
                    html: 'Total Estimate Including GST (₹ ' + formatBudget(totalEstimate) + 
                          ')<br>exceeds available plant budget (₹ ' + formatBudget(selectedPlantBudget) + ')',
                    confirmButtonColor: '#dc2626'
                });
                return;
            }
        }
        document.getElementById('loadingOverlay').style.display = 'flex';
    });
});
function updateCostCalculations() {
    var basic = Number(document.getElementById('basicCost').value) || 0;
    var rate = Number(document.getElementById('gstRate').value) || 0;

    var gst = basic * (rate / 100);
    var total = basic + gst;

    document.getElementById('gstAmount').value = gst.toFixed(2);
    document.getElementById('totalCost').value = total.toFixed(2);

    // Re-validate after total is updated
    validateBudgetLimit();
}

function updateSbuAndLocation() {

    var select = document.getElementById('plantCode');
    var opt = select.options[select.selectedIndex]; // correct way

    if (!opt.value) {
        document.getElementById('displaySbu').textContent = 'Select Plant first';
        document.getElementById('displayLocation').textContent = 'Select Plant first';
        document.getElementById('businessUnit').value = '';
        document.getElementById('location').value = '';

        selectedPlantBudget = null;
        document.getElementById('displayBudget').textContent = '—';
        document.getElementById('budgetWarning').style.display = 'none';

        document.getElementById('basicCost').value = '';
        document.getElementById('basicCost').style.borderColor = '';
        document.getElementById('basicCost').style.backgroundColor = '';

        updateCostCalculations();
        return;
    }

    document.getElementById('displaySbu').textContent = opt.dataset.sbu || '—';
    document.getElementById('displayLocation').textContent = opt.dataset.location || '—';

    document.getElementById('businessUnit').value = opt.dataset.sbu || '';
    document.getElementById('location').value = opt.dataset.location || '';

    var budgetRaw = opt.dataset.budget || '0';
    selectedPlantBudget = Number(budgetRaw);

    document.getElementById('displayBudget').textContent =
        selectedPlantBudget > 0 ? '₹ ' + formatBudget(selectedPlantBudget) : '—';

    validateBudgetLimit();
    updateCostCalculations();
}
document.addEventListener("DOMContentLoaded", function () {
	
    updateSbuAndLocation();
});
// Cost auto-calculation
document.addEventListener('DOMContentLoaded', () => {
    const basic = document.getElementById('basicCost');
    const rate = document.getElementById('gstRate');
    const gstEl = document.getElementById('gstAmount');
    const totalEl = document.getElementById('totalCost');

    function calc() {
        const b = parseFloat(basic.value) || 0;
        const r = parseFloat(rate.value) || 0;
        const g = b * (r / 100);
        const t = b + g;
        gstEl.value = g.toFixed(2);
        totalEl.value = t.toFixed(2);
    }

    basic.addEventListener('input', calc);
    rate.addEventListener('input', calc);

    // Run once on load (important for edit)
    calc();

    // File listeners
    document.querySelector('input[name="roiFile"]')?.addEventListener('change', e => showFileName(e.target, 'roiFileDisplay'));
    document.querySelector('input[name="timelineFile"]')?.addEventListener('change', e => showFileName(e.target, 'timelineFileDisplay'));
    document.querySelector('input[name="reasonFile"]')?.addEventListener('change', e => showFileName(e.target, 'reasonFileDisplay'));

    // Signature listeners
    document.querySelectorAll('.signature-upload').forEach(inp => {
        inp.addEventListener('change', handleSignatureUpload);
    });

    // Update plant info on load
    updateSbuAndLocation();
    
    // Loading overlay text
    document.getElementById('capexForm')?.addEventListener('submit', function() {
        document.getElementById('loadingText').textContent = 
            document.querySelector('.submit-btn').textContent.includes('Update') ? 'Updating...' : 'Submitting...';
        document.getElementById('loadingOverlay').style.display = 'flex';
    });
});
function filterProjectManagers() {

    var selectedPlant = "${editList.plant_code}";

    var managerSelect = document.getElementById("projectManager");
    var options = managerSelect.options;

    for (var i = 0; i < options.length; i++) {

        var plant = options[i].dataset.plant;

        if (!plant || plant === selectedPlant) {
            options[i].style.display = "";
        } else {
            options[i].style.display = "none";
        }
    }

    managerSelect.value = "${editList.project_manager_name}";
}
$(document).ready(function(){
	
	var plantCode="${editList.plant_code}";
	var department="${editList.department}";

	$.ajax({

	url:"<%=request.getContextPath()%>/form/getPlantHead",

	type:"GET",

	data:{
	plant_code:plantCode,
	department:department
	},

	success:function(response){

	console.log("Response:",response);

	if(response.length > 0){

	    var data = response[0];

	    /* ======================
	       Extract Values
	    ====================== */

	    var siteHead = $.trim(data.site_head_name || "");
	    var siteHeadID = $.trim(data.site_head_employee_id || "");
		$("#head_of_plant_name").val(siteHeadID);
	
		
	    var financeHead = $.trim(data.site_finance_head_name || "");
	    var financeHeadID = $.trim(data.site_finance_head_employee_id || "");
		$("#finance_name").val(financeHeadID);
	    var projectHead = $.trim(data.project_head_name || "");
	    var projectHeadID = $.trim(data.project_head_employee_id || "");
	    $("#head_projects_name").val(projectHeadID);
	    var buHead = $.trim(data.bu_head_name || "");
	    var buHeadID = $.trim(data.bu_head_employee_id || "");
	    $("#business_head_name").val(buHeadID);
	    
	    var cfoName = $.trim(data.cfo_name || "");
	    var cfoID = $.trim(data.cfo_employee_id || "");
	    $("#cfo_name").val(cfoID);
	    var ceoName = $.trim(data.ceo_name || "");
	    var ceoID = $.trim(data.ceo_employee_id || "");
	    $("#ceo_name").val(ceoID);
	    var financeName = $.trim(data.finance_controller_name || "");
	    var financeID = $.trim(data.finance_controller_employee_id || "");
	    
	    $("#finance_controller_name").val(financeID);
	    /* NEW FIELD */
	    var regionalDirectorName = $.trim(data.regional_director_name || "");
	    var regionalDirectorID = $.trim(data.regional_director_employee_id || "");
	    
	    $("#regional_director_name").val(regionalDirectorID);
	    /* ======================
	       Dropdown References
	    ====================== */
	    var finance_controller_nameSelect = $("select[name='finance_controller_name']");
	    var plantHeadSelect = $("select[name='head_of_plant_name']");

	    var financeSelect = $("select[name='finance_name']");

	    var projectHeadSelect = $("select[name='head_projects_name']");

	    var buHeadSelect = $("select[name='business_head_name']");

	    var cfoSelect = $("select[name='cfo_name']");

	    var ceoSelect = $("select[name='ceo_name']");

	    /* NEW DROPDOWN */
	    var regionalDirectorSelect =
	        $("select[name='regional_director_name']");


	    /* ======================
	       Remove Old Options
	    ====================== */
	    finance_controller_nameSelect.find("option:not(:first)").remove();
	    plantHeadSelect.find("option:not(:first)").remove();

	    financeSelect.find("option:not(:first)").remove();

	    projectHeadSelect.find("option:not(:first)").remove();

	    buHeadSelect.find("option:not(:first)").remove();

	    cfoSelect.find("option:not(:first)").remove();

	    ceoSelect.find("option:not(:first)").remove();

	    regionalDirectorSelect.find("option:not(:first)").remove();


	    /* ======================
	       Add Options
	    ====================== */
	    if(financeID !== "")
	    	finance_controller_nameSelect.append(
		        "<option value='"+financeID+"'>"+financeName+"</option>"
		    );
	    if(siteHeadID !== "")
	    plantHeadSelect.append(
	        "<option value='"+siteHeadID+"'>"+siteHead+"</option>"
	    );


	    if(financeHeadID !== "")
	    financeSelect.append(
	        "<option value='"+financeHeadID+"'>"+financeHead+"</option>"
	    );


	    if(projectHeadID !== "")
	    projectHeadSelect.append(
	        "<option value='"+projectHeadID+"'>"+projectHead+"</option>"
	    );


	    if(buHeadID !== "")
	    buHeadSelect.append(
	        "<option value='"+buHeadID+"'>"+buHead+"</option>"
	    );


	    if(cfoID !== "")
	    cfoSelect.append(
	        "<option value='"+cfoID+"'>"+cfoName+"</option>"
	    );


	    if(ceoID !== "")
	    ceoSelect.append(
	        "<option value='"+ceoID+"'>"+ceoName+"</option>"
	    );


	    /* NEW OPTION */

	    if(regionalDirectorID !== "")
	    regionalDirectorSelect.append(
	        "<option value='"+regionalDirectorID+"'>"
	        + regionalDirectorName +
	        "</option>"
	    );


	    /* ======================
	       Auto Select
	    ====================== */
	    finance_controller_nameSelect.val(financeID).trigger("change");
	    plantHeadSelect.val(siteHeadID).trigger("change");

	    financeSelect.val(financeHeadID).trigger("change");

	    projectHeadSelect.val(projectHeadID).trigger("change");

	    buHeadSelect.val(buHeadID).trigger("change");

	    cfoSelect.val(cfoID).trigger("change");

	    ceoSelect.val(ceoID).trigger("change");

	    regionalDirectorSelect.val(regionalDirectorID)
	    .trigger("change");

	}
	 $('input[name="current_pending_at"]:not(:first)')
     .removeAttr('name');
	},

	error:function(){

	alert("Error loading Head Of Plant");

	}

	});

	});

$(document).ready(function(){
	filterProjectManagers();
})

function setTotalBudget(){

    var totalBudget = parseFloat($("#displayBudget").text().replace(/[^0-9.]/g, '')) || 0;

    $("#totalBudget").val(totalBudget.toFixed(2));

}
$("#proposedPrice").on("change", function () {

    var totalBudget = parseFloat($("#displayBudget").text().replace(/[^0-9.]/g, '')) || 0;
    var proposedPrice = parseFloat($(this).val()) || 0;

    if (proposedPrice > totalBudget) {

        Swal.fire({
            title: "Budget Exceeded!",
            html: `
                <p>Proposed price cannot exceed available budget.</p>
                <input type="number" id="popupPrice" class="swal2-input" value="${proposedPrice}" min="0" step="0.01">
                <small>Enter value less than ₹ ${totalBudget}</small>
            `,
            allowOutsideClick: false,
            allowEscapeKey: false,
            confirmButtonText: "Update",
            preConfirm: () => {

                let newPrice = parseFloat(document.getElementById("popupPrice").value) || 0;

                if (newPrice > totalBudget) {
                    Swal.showValidationMessage("Amount must be less than available budget");
                    return false;
                }

                return newPrice;
            }
        }).then((result) => {

            if (result.isConfirmed) {

                // update main field
                $("#proposedPrice").val(result.value);

                // recalculate balance
                calculateBalance();
            }
        });

    } else {
        calculateBalance();
    }
});
function calculateBalance() {

    var totalBudget = parseFloat($("#displayBudget").text().replace(/[^0-9.]/g, '')) || 0;
    var proposedPrice = parseFloat($("#proposedPrice").val()) || 0;

    var balance = totalBudget - proposedPrice;

    if (balance < 0) {
        balance = 0;
    }

    $("#availableBalance").val(balance.toFixed(2));
}
$(document).ready(function(){
	calculateBalance();
	setTotalBudget();
	/* ==========================
	AUTO CALCULATE BALANCE
	========================== */

	
	//$("#totalBudget").keyup(calculateBalance);
	$("#proposedPrice").keyup(calculateBalance);


	/* ==========================
	LIMIT 90 CR VALIDATION
	========================== */

	$("#totalBudget").blur(function(){

	var val = parseFloat($(this).val());

	if(val > 900000000){

	alert("Budget exceeds 90 CR");

	$(this).val("");

	}

	});


	/* ==========================
	STATUS COLOR CHANGE
	========================== */

	$("#financeStatus").change(function(){

	var status=$(this).val();

	$("#financeStatus").removeClass("approved rejected hold");

	if(status=="Approved"){
	$(this).addClass("approved");
	}

	if(status=="Rejected"){
	$(this).addClass("rejected");
	}

	if(status=="On Hold"){
	$(this).addClass("hold");
	}

	});


	/* ==========================
	COMMENTS LIMIT DISPLAY
	========================== */

	$("#financeComments").keyup(function(){

	var len=$(this).val().length;

	if(len>100){
	$(this).val($(this).val().substring(0,100));
	}

	});



	});
	
$(document).ready(function() {
    // Toggle rejection remarks field when status changes
    $("#financeStatus").on("change", function() {
        var status = $(this).val();
        var remarksField = $("#rejectionRemarks");
        var textarea = $("#financeComments");
		if("${editList.finance_name}" === ''){
			   if (status === "Rejected") {
		        	$("[name='current_pending_at']").removeAttr("name");
		        	var val = $("select[name='finance_name'] option:eq(1)").val();
		        	$("#finance_name").attr("name", "current_pending_at");
		        	$("#finance_name").val(val);
		            remarksField.slideDown(300);        // smooth show
		            textarea.prop("required", true);    // make required
		        }else if(status === "On Hold"){
		        	$("[name='current_pending_at']").removeAttr("name");
		        	var val = $("select[name='finance_name'] option:eq(1)").val();
		        	$("#finance_name").attr("name", "current_pending_at");
		        	$("#finance_name").val(val);
		        }else {
		            remarksField.slideUp(200);    
		            $("[name='current_pending_at']").removeAttr("name");
		            $("#regional_director_name").attr("name", "current_pending_at");// smooth hide
		            textarea.prop("required", false);   // remove required
		            // Optional: clear value when hidden  
		            // textarea.val("");
		        }
		}
     
    });

    // Character counter for remarks
    $("#financeComments").on("input", function() {
        var len = $(this).val().length;
        $(".char-count").text(len + " / 500 characters");
        if (len > 500) {
            $(this).val($(this).val().substring(0, 500));
        }
    });

    // Trigger once on load (for edit case)
    $("#financeStatus").trigger("change");
    
 // Get the form element
    const form = document.getElementById('capexForm');

    // Collect all inputs/selects/textareas with name="current_pending_at" inside the form
    const pendingElements = form.querySelectorAll('[name="current_pending_at"]');

    // Iterate over the elements
    pendingElements.forEach((el, index) => {
        // Find the last field in the form (last input/select/textarea)
        const allFields = form.querySelectorAll('input, select, textarea');
        const lastField = allFields[allFields.length - 1];

        // Print the index, element value, and last field value
        console.log(`Index ${index}: current_pending_at = ${el.value}, lastField (${lastField.name}) = ${lastField.value}`);
    });
});
document.addEventListener('DOMContentLoaded', () => {

    // All current_pending_at elements
    const pendingElements = Array.from(document.querySelectorAll('[name="current_pending_at"]'));

    // Last select on the page
    const allSelects = document.querySelectorAll('select');
    const lastSelect = allSelects[allSelects.length - 1];

    console.log('Last select: name = '+(lastSelect?.name||'N/A')+', value = '+(lastSelect?.value||'N/A'));

    // Get department
    const department = $("#department").val() || "";

    // Get proposed budget from input or fallback div
    let proposedBudgetRaw = "0";
    if($("#proposedPrice").length){ 
        proposedBudgetRaw = $("#proposedPrice").val() || "0";
    } else if($("#displayBudget").length){
        proposedBudgetRaw = $("#displayBudget").text() || "0";
    }
    proposedBudgetRaw = proposedBudgetRaw.toString().replace(/,/g,'');
    const proposedPrice = parseFloat(proposedBudgetRaw) || 0;

    console.log('Proposed Price:', proposedPrice);

    // Determine final approval based on proposed budget
    let finalApproverClass = '';
    if(proposedPrice <= 1500000){ // <=15L
        finalApproverClass = 'finance-section';
    } else if(proposedPrice <= 2000000){ // >15L && <=20L
        finalApproverClass = 'finance-controller-section';
    } else if(proposedPrice <= 5000000){ // >20L && <=50L
        finalApproverClass = 'business-head-section';
    } else { // >50L
        finalApproverClass = 'ceo-section';
    }

    // === Remove specific fields for GN department ===
    if(department === 'GN'){
        const gnRemoveIds = ['head_of_plant_name', 'finance_name'];
        gnRemoveIds.forEach(id => {
            const el = document.getElementById(id);
            if(el){
                console.log('Removing element for GN department: '+id);
                el.remove(); // completely remove from DOM
            }
        });
    }

    // Assign current_pending_at dynamically
    let matched = false;
    const updatedPendingElements = Array.from(document.querySelectorAll('[name="current_pending_at"]')); // refresh after removal
    updatedPendingElements.forEach((el, index) => {
        if(!matched){
            if(el.id === lastSelect.id || el.id === lastSelect.name){
                matched = true;
                console.log('Matched current_pending_at ID: '+el.id);

                // Find the next eligible current_pending_at
                for(let i = index + 1; i < updatedPendingElements.length; i++){
                    const nextEl = updatedPendingElements[i];

                    // Skip based on department
                    if(department === 'GN' && (nextEl.id === 'head_of_plant_name' || nextEl.id === 'finance_name')){
                        console.log('Skipping '+nextEl.id+' for GN department');
                        continue;
                    }
                    if(department === 'OPS' && nextEl.id === 'head_projects_name'){
                        console.log('Skipping '+nextEl.id+' for OPS department');
                        continue;
                    }

                    // Clear all current_pending_at first
                    $("[name='current_pending_at']").removeAttr("name");

                    // Assign current_pending_at to this next eligible element
                    $("#"+nextEl.id).attr("name", "current_pending_at");
                    console.log('Next current_pending_at after matched ID: name = '+nextEl.id+', value = '+nextEl.value);

                    break; // only assign the first eligible one
                }
            }
        }
    });

    // Set final approval button
    const submitBtn = $(".submit-btn");
    submitBtn.removeClass('final-approval finance-section finance-controller-section business-head-section ceo-section');

    if(finalApproverClass){
        submitBtn.addClass('final-approval '+finalApproverClass);
        console.log('Final approver section set to: '+finalApproverClass);
    }

    // Set status Approved on click
    submitBtn.off('click').on('click', function(e){
        e.preventDefault();
        $("#status").val("Approved");
        console.log('Form submitted with status: Approved');
        $("#capexForm").submit();
    });

});

</script>
</body>
</html>