<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Capital Expenditure Proposal</title>
    
    <!-- Fonts and Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <style>
        /* Reset and Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', 'Segoe UI', Arial, sans-serif;
            background: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }

        /* Header */
        .capex-header {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
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
            width: auto;
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

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-info span {
            font-weight: 500;
        }

        .user-info button {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: background 0.3s;
        }

        .user-info button:hover {
            background: #c0392b;
        }

        /* Main Container */
        .capex-container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* Cards */
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

        /* Form Grids */
        .form-grid {
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

        .form-group input,
        .form-group select,
        .form-group textarea {
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: border 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .full-width {
            grid-column: 1 / -1;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        /* Cost Grid */
        .cost-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
        }

        .cost-group {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            border: 1px solid #e9ecef;
        }

        .cost-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 10px;
            color: #2c3e50;
        }

        .cost-group input,
        .cost-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 15px;
            margin-bottom: 8px;
        }

        .cost-group small {
            color: #6c757d;
            font-size: 12px;
            display: block;
            margin-top: 5px;
        }

        /* Investment Grid */
        .investment-grid {
            display: grid;
            gap: 25px;
        }

        .compact .investment-group {
            margin-bottom: 25px;
        }

        .investment-group {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 10px;
            border: 1px solid #e9ecef;
        }

        .investment-group.full-row {
            grid-column: 1 / -1;
        }

        .investment-group textarea {
            width: 100%;
            min-height: 80px;
            margin-bottom: 15px;
        }

        .upload-row {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .upload-btn {
            background: #3498db;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            transition: background 0.3s;
        }

        .upload-btn:hover {
            background: #2980b9;
        }

        .uploaded-file {
            background: white;
            padding: 8px 15px;
            border-radius: 6px;
            border: 1px solid #ddd;
            display: flex;
            align-items: center;
            gap: 10px;
            max-width: 300px;
        }

        .uploaded-file span {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            flex: 1;
        }

        .remove-file {
            background: #e74c3c;
            color: white;
            border: none;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
        }

        .file-hint {
            color: #6c757d;
            font-size: 12px;
        }

        /* Signature Grid */
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
            margin-bottom: 15px;
            overflow: hidden;
        }

        .signature-box img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }

        .signature-box span {
            color: #7f8c8d;
            font-size: 14px;
        }

        .signature-actions {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .signature-fields {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .signature-fields select,
        .signature-fields input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }

        /* Finance Section */
        .finance-section {
            background: #e8f4fc;
            border: 2px solid #3498db;
        }

        .finance-title {
            color: #2c3e50;
            text-align: center;
            font-size: 18px;
        }

        .finance-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-top: 20px;
        }

        .finance-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        .finance-card h4 {
            font-size: 16px;
            margin-bottom: 25px;
            color: #2c3e50;
            padding-bottom: 10px;
            border-bottom: 2px solid #3498db;
        }

        .finance-field {
            margin-bottom: 20px;
        }

        .finance-field label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            color: #555;
            font-size: 14px;
        }

        .finance-field input,
        .finance-field select,
        .finance-field textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }

        .finance-field small {
            color: #6c757d;
            font-size: 12px;
            display: block;
            margin-top: 5px;
        }

        /* Comment Field */
        .comment-field {
            position: relative;
        }

        .comment-field textarea {
            width: 100%;
            min-height: 60px;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            resize: vertical;
        }

        .comment-counter {
            position: absolute;
            bottom: 5px;
            right: 10px;
            font-size: 12px;
            color: #6c757d;
        }

        /* Action Bar */
        .action-bar {
            display: flex;
            justify-content: center;
            margin: 40px 0;
        }

        .submit-btn {
            background: linear-gradient(135deg, #27ae60 0%, #229954 100%);
            color: white;
            border: none;
            padding: 18px 45px;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 6px 20px rgba(39, 174, 96, 0.2);
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(39, 174, 96, 0.3);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        /* Alert Messages */
        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin: 20px 0;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideIn 0.3s ease;
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

        .alert i {
            font-size: 20px;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Loading Overlay */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            flex-direction: column;
            color: white;
        }

        .loading-spinner {
            width: 50px;
            height: 50px;
            border: 4px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: #3498db;
            animation: spin 1s ease-in-out infinite;
            margin-bottom: 20px;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .capex-header {
                flex-direction: column;
                text-align: center;
                gap: 15px;
                padding: 15px;
            }

            .capex-header-content {
                flex-direction: column;
                gap: 10px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .signature-grid {
                grid-template-columns: 1fr;
            }

            .finance-grid {
                grid-template-columns: 1fr;
            }

            .cost-grid {
                grid-template-columns: 1fr;
            }

            .capex-container {
                padding: 0 15px;
            }

            .capex-card {
                padding: 20px;
            }
        }

        /* Disabled Input */
        input:disabled {
            background: #f5f5f5;
            color: #999;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <!-- Loading Overlay -->
    <div id="loadingOverlay" class="loading-overlay">
        <div class="loading-spinner"></div>
        <p>Processing...</p>
    </div>

    <!-- Header -->
    <header class="capex-header">
        <div class="capex-header-content">
            <div class="capex-icon">
                <img src="/capex/resources/images/Ramky-Logo.png" alt="Company Logo">
            </div>
            <div>
                <h1>Capital Expenditure Proposal</h1>
                <p>Submit and track CAPEX requests for approval</p>
            </div>
        </div>
        <div class="user-info">
            <span>Welcome, <c:out value="${sessionScope.username}" default="User" /></span>
            <button onclick="logout()">Logout</button>
        </div>
    </header>

    <!-- Main Container -->
    <div class="capex-container">
        <!-- Success/Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <i class="material-icons">check_circle</i>
                <span>${successMessage}</span>
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                <i class="material-icons">error</i>
                <span>${errorMessage}</span>
            </div>
        </c:if>

        <!-- Basic Information -->
        <section class="capex-card">
            <h3><i class="material-icons">description</i> Basic Information</h3>
            <div class="form-grid">
                <div class="form-group">
                    <label>CAPEX Title <span>*</span></label>
                    <input type="text" id="capexTitle" placeholder="Enter proposal title" required>
                </div>
                <div class="form-group">
                    <label>CAPEX Number <span>*</span></label>
                    <input type="text" id="capexNumber" placeholder="e.g. CAPEX-2024-001" required>
                </div>
                <div class="form-group">
                    <label>Department / Function <span>*</span></label>
                    <select id="department" required>
                        <option value="">Select department</option>
                        <option value="IT">IT</option>
                        <option value="Finance">Finance</option>
                        <option value="Operations">Operations</option>
                        <option value="HR">HR</option>
                        <option value="Marketing">Marketing</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Business Unit <span>*</span></label>
                    <select id="businessUnit" required>
                        <option value="">Select business unit</option>
                        <option value="India">India</option>
                        <option value="Global">Global</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Plant Code <span>*</span></label>
                    <select id="plantCode" required>
                        <option value="">Select Plant Code</option>
                        <option value="P-001">P-001</option>
                        <option value="P-002">P-002</option>
                        <option value="P-003">P-003</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Location <span>*</span></label>
                    <select id="location" required>
                        <option value="">Select Location</option>
                        <option value="Hyderabad">Hyderabad</option>
                        <option value="Bengaluru">Bengaluru</option>
                        <option value="Mumbai">Mumbai</option>
                        <option value="Delhi">Delhi</option>
                    </select>
                </div>
            </div>
            <div class="form-group full-width">
                <label>Asset Description <span>*</span></label>
                <textarea id="assetDescription" placeholder="Provide detailed description of the asset..." required></textarea>
            </div>
        </section>

        <!-- Cost Estimation -->
        <section class="capex-card">
            <h3><i class="material-icons">attach_money</i> Cost Estimation</h3>
            <div class="cost-grid">
                <div class="cost-group">
                    <label>Estimate of Proposal / Basic Cost (₹) <span>*</span></label>
                    <input type="number" id="basicCost" placeholder="0.00" step="0.01" min="0">
                    <small>Numeric value in Crores</small>
                </div>
                <div class="cost-group">
                    <label>GST Rate <span>*</span></label>
                    <select id="gstRate">
                        <option value="">Select GST %</option>
                        <option value="5">5%</option>
                        <option value="12">12%</option>
                        <option value="18">18%</option>
                        <option value="28">28%</option>
                    </select>
                    <small>Select percentage</small>
                </div>
                <div class="cost-group">
                    <label>GST Amount (₹)</label>
                    <input type="text" id="gstAmount" disabled>
                    <small>Auto-calculated</small>
                </div>
                <div class="cost-group">
                    <label>Total Estimate Including GST (₹)</label>
                    <input type="text" id="totalCost" disabled>
                    <small>Auto-calculated</small>
                </div>
            </div>
        </section>

        <!-- Investment Details -->
        <section class="capex-card">
            <h3><i class="material-icons">trending_up</i> Investment Details</h3>
            <div class="investment-grid compact">
                <div class="investment-group">
                    <label>Return of Investment (ROI) & Pay Back Period <span>*</span></label>
                    <textarea id="roiText" placeholder="Manual entry..." maxlength="500"></textarea>
                    <div class="upload-row">
                        <label class="upload-btn">
                            <i class="material-icons">attach_file</i> Upload
                            <input type="file" id="roiFile" accept=".pdf,.xls,.xlsx,.jpg,.jpeg" hidden>
                        </label>
                        <span id="roiFileName" class="file-hint">No file selected</span>
                        <span class="file-hint">Excel / PDF / JPG • Max 10MB</span>
                    </div>
                </div>
                <div class="investment-group">
                    <label>Project Timeline (with Zero Date) <span>*</span></label>
                    <textarea id="timelineText" placeholder="Manual entry..." maxlength="500"></textarea>
                    <div class="upload-row">
                        <label class="upload-btn">
                            <i class="material-icons">attach_file</i> Upload
                            <input type="file" id="timelineFile" accept=".pdf,.xls,.xlsx,.jpg,.jpeg" hidden>
                        </label>
                        <span id="timelineFileName" class="file-hint">No file selected</span>
                        <span class="file-hint">Excel / PDF / JPG • Max 10MB</span>
                    </div>
                </div>
                <div class="investment-group full-row">
                    <label>Reason for Purchases / Milestones / Savings <span>*</span></label>
                    <textarea id="reasonText" placeholder="Manual entry (Max 500 characters)" maxlength="500"></textarea>
                    <div class="upload-row">
                        <label class="upload-btn">
                            <i class="material-icons">attach_file</i> Upload
                            <input type="file" id="reasonFile" accept=".pdf,.xls,.xlsx,.jpg,.jpeg" hidden>
                        </label>
                        <span id="reasonFileName" class="file-hint">No file selected</span>
                        <span class="file-hint">500 characters • Excel / PDF / JPG • Max 10MB</span>
                    </div>
                </div>
            </div>
        </section>

        <!-- Digital Signatures -->
        <section class="capex-card">
            <h3><i class="material-icons">create</i> Digital Signatures</h3>
            <div class="signature-grid">
                <!-- Prepared By -->
                <div class="signature-card">
                    <h4>Prepared By</h4>
                    <div class="signature-box" id="preparedBySignatureBox">
                        <span>Upload Signature</span>
                    </div>
                    <div class="signature-actions">
                        <label class="upload-btn">
                            <i class="material-icons">upload</i> Upload
                            <input type="file" class="signature-upload" data-role="preparedBy" accept="image/*" hidden>
                        </label>
                    </div>
                    <div class="signature-fields">
                        <select class="signature-name" data-role="preparedBy">
                            <option value="">Select Name</option>
                            <option value="Ashok Pawar">Ashok Pawar</option>
                            <option value="SS Parashar">SS Parashar</option>
                        </select>
                        <select class="signature-designation" data-role="preparedBy">
                            <option value="">Select Designation</option>
                            <option value="AGM (MECH)">AGM (MECH)</option>
                            <option value="DGM">DGM</option>
                        </select>
                        <input type="date" class="signature-date" data-role="preparedBy">
                    </div>
                </div>

                <!-- Project Manager -->
                <div class="signature-card">
                    <h4>Project Manager / Execution</h4>
                    <div class="signature-box" id="projectManagerSignatureBox">
                        <span>Upload Signature</span>
                    </div>
                    <div class="signature-actions">
                        <label class="upload-btn">
                            <i class="material-icons">upload</i> Upload
                            <input type="file" class="signature-upload" data-role="projectManager" accept="image/*" hidden>
                        </label>
                    </div>
                    <div class="signature-fields">
                        <select class="signature-name" data-role="projectManager">
                            <option value="">Select Name</option>
                            <option value="Ashok Pawar">Ashok Pawar</option>
                        </select>
                        <select class="signature-designation" data-role="projectManager">
                            <option value="">Select Designation</option>
                            <option value="AGM (MECH)">AGM (MECH)</option>
                        </select>
                        <input type="date" class="signature-date" data-role="projectManager">
                    </div>
                </div>

                <!-- Requested By -->
                <div class="signature-card">
                    <h4>Requested By</h4>
                    <div class="signature-box" id="requestedBySignatureBox">
                        <span>Upload Signature</span>
                    </div>
                    <div class="signature-actions">
                        <label class="upload-btn">
                            <i class="material-icons">upload</i> Upload
                            <input type="file" class="signature-upload" data-role="requestedBy" accept="image/*" hidden>
                        </label>
                    </div>
                    <div class="signature-fields">
                        <select class="signature-name" data-role="requestedBy">
                            <option value="">Select Name</option>
                            <option value="Ashok Pawar">Ashok Pawar</option>
                        </select>
                        <select class="signature-designation" data-role="requestedBy">
                            <option value="">Select Designation</option>
                            <option value="AGM (MECH)">AGM (MECH)</option>
                        </select>
                        <input type="date" class="signature-date" data-role="requestedBy">
                    </div>
                </div>

                <!-- Head of Plant -->
                <div class="signature-card">
                    <h4>Head of the Plant (User)</h4>
                    <div class="signature-box" id="headOfPlantSignatureBox">
                        <span>Upload Signature</span>
                    </div>
                    <div class="signature-actions">
                        <label class="upload-btn">
                            <i class="material-icons">upload</i> Upload
                            <input type="file" class="signature-upload" data-role="headOfPlant" accept="image/*" hidden>
                        </label>
                    </div>
                    <div class="signature-fields">
                        <select class="signature-name" data-role="headOfPlant">
                            <option value="">Select Name</option>
                            <option value="SS Parashar">SS Parashar</option>
                        </select>
                        <select class="signature-designation" data-role="headOfPlant">
                            <option value="">Select Designation</option>
                            <option value="DGM">DGM</option>
                        </select>
                        <input type="date" class="signature-date" data-role="headOfPlant">
                    </div>
                </div>
            </div>
        </section>

        <!-- Finance Department -->
        <section class="capex-card finance-section">
            <h3 class="finance-title">TO BE COMPLETED BY FINANCE DEPARTMENT</h3>
            <div class="finance-grid">
                <div class="finance-card">
                    <h4>CAPITAL EXPENDITURE BUDGET</h4>
                    <div class="finance-field">
                        <label>Department</label>
                        <select id="financeDept">
                            <option value="">Select department</option>
                            <option value="IT">IT</option>
                            <option value="Finance">Finance</option>
                            <option value="Operations">Operations</option>
                        </select>
                    </div>
                    <div class="finance-field">
                        <label>Capital Expenditure Category</label>
                        <select id="financeCategory">
                            <option value="Software">Software</option>
                            <option value="Hardware">Hardware</option>
                            <option value="Infrastructure">Infrastructure</option>
                        </select>
                    </div>
                    <div class="finance-field">
                        <label>Total Budget Available for the Year (₹)</label>
                        <input type="number" id="totalBudget" placeholder="0" step="0.01" min="0">
                        <small>90CR limit</small>
                    </div>
                    <div class="finance-field">
                        <label>Proposed Purchase Price (₹)</label>
                        <input type="number" id="proposedPrice" placeholder="0.00" step="0.01" min="0">
                    </div>
                    <div class="finance-field">
                        <label>Available Balance After (₹)</label>
                        <input type="text" id="availableBalance" disabled>
                        <small>Auto-calculated (A − B = C)</small>
                    </div>
                </div>
                <div class="finance-card">
                    <h4>Reviewed by Finance Department</h4>
                    <div class="finance-field">
                        <label>Signature Status</label>
                        <select id="financeStatus">
                            <option value="">Select status</option>
                            <option value="Approved">Approved</option>
                            <option value="Rejected">Rejected</option>
                            <option value="On Hold">On Hold</option>
                        </select>
                    </div>
                    <div class="finance-field">
                        <label>Name</label>
                        <input type="text" id="financeName" placeholder="Employee name">
                    </div>
                    <div class="finance-field">
                        <label>Designation</label>
                        <input type="text" id="financeDesignation" placeholder="Designation">
                    </div>
                    <div class="finance-field">
                        <label>Date</label>
                        <input type="date" id="financeDate">
                    </div>
                    <div class="finance-field">
                        <label>Comments (100 chars max)</label>
                        <textarea id="financeComments" maxlength="100" placeholder="Enter comments..."></textarea>
                    </div>
                </div>
            </div>
        </section>

        <!-- Appropriate Authority -->
        <section class="capex-card">
            <h3 class="finance-title">TO BE COMPLETED BY APPROPRIATE AUTHORITY</h3>
            <div class="signature-grid">
                <!-- Head Projects -->
                <div class="signature-card">
                    <h4>Head Projects (HO)</h4>
                    <div class="signature-box" id="headProjectsSignatureBox">
                        <span>Upload Signature</span>
                    </div>
                    <div class="signature-actions">
                        <label class="upload-btn">
                            <i class="material-icons">upload</i> Upload
                            <input type="file" class="authority-upload" data-role="headProjects" accept="image/*" hidden>
                        </label>
                    </div>
                    <div class="signature-fields">
                        <select class="authority-name" data-role="headProjects">
                            <option value="">Select Name</option>
                            <option value="Ashok Pawar">Ashok Pawar</option>
                        </select>
                        <select class="authority-designation" data-role="headProjects">
                            <option value="">Select Designation</option>
                            <option value="Head Projects (HO)">Head Projects (HO)</option>
                        </select>
                        <input type="date" class="authority-date" data-role="headProjects">
                        <div class="comment-field">
                            <textarea class="authority-comment" data-role="headProjects" maxlength="200" placeholder="Enter comments (max 200 characters)"></textarea>
                            <span class="comment-counter">0 / 200</span>
                        </div>
                    </div>
                </div>

                <!-- Business Head -->
                <div class="signature-card">
                    <h4>Business Head</h4>
                    <div class="signature-box" id="businessHeadSignatureBox">
                        <span>Upload Signature</span>
                    </div>
                    <div class="signature-actions">
                        <label class="upload-btn">
                            <i class="material-icons">upload</i> Upload
                            <input type="file" class="authority-upload" data-role="businessHead" accept="image/*" hidden>
                        </label>
                    </div>
                    <div class="signature-fields">
                        <select class="authority-name" data-role="businessHead">
                            <option value="">Select Name</option>
                            <option value="Business Head">Business Head</option>
                        </select>
                        <select class="authority-designation" data-role="businessHead">
                            <option value="">Select Designation</option>
                            <option value="Business Head">Business Head</option>
                        </select>
                        <input type="date" class="authority-date" data-role="businessHead">
                        <div class="comment-field">
                            <textarea class="authority-comment" data-role="businessHead" maxlength="200" placeholder="Enter comments (max 200 characters)"></textarea>
                            <span class="comment-counter">0 / 200</span>
                        </div>
                    </div>
                </div>

                <!-- CFO -->
                <div class="signature-card">
                    <h4>CFO</h4>
                    <div class="signature-box" id="cfoSignatureBox">
                        <span>Upload Signature</span>
                    </div>
                    <div class="signature-actions">
                        <label class="upload-btn">
                            <i class="material-icons">upload</i> Upload
                            <input type="file" class="authority-upload" data-role="cfo" accept="image/*" hidden>
                        </label>
                    </div>
                    <div class="signature-fields">
                        <select class="authority-name" data-role="cfo">
                            <option value="">Select Name</option>
                            <option value="CFO">CFO</option>
                        </select>
                        <select class="authority-designation" data-role="cfo">
                            <option value="">Select Designation</option>
                            <option value="CFO">CFO</option>
                        </select>
                        <input type="date" class="authority-date" data-role="cfo">
                        <div class="comment-field">
                            <textarea class="authority-comment" data-role="cfo" maxlength="200" placeholder="Enter comments (max 200 characters)"></textarea>
                            <span class="comment-counter">0 / 200</span>
                        </div>
                    </div>
                </div>

                <!-- CEO & MD -->
                <div class="signature-card">
                    <h4>CEO & MD</h4>
                    <div class="signature-box" id="ceoSignatureBox">
                        <span>Upload Signature</span>
                    </div>
                    <div class="signature-actions">
                        <label class="upload-btn">
                            <i class="material-icons">upload</i> Upload
                            <input type="file" class="authority-upload" data-role="ceo" accept="image/*" hidden>
                        </label>
                    </div>
                    <div class="signature-fields">
                        <select class="authority-name" data-role="ceo">
                            <option value="">Select Name</option>
                            <option value="CEO & MD">CEO & MD</option>
                        </select>
                        <select class="authority-designation" data-role="ceo">
                            <option value="">Select Designation</option>
                            <option value="CEO & MD">CEO & MD</option>
                        </select>
                        <input type="date" class="authority-date" data-role="ceo">
                        <div class="comment-field">
                            <textarea class="authority-comment" data-role="ceo" maxlength="200" placeholder="Enter comments (max 200 characters)"></textarea>
                            <span class="comment-counter">0 / 200</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Action Bar -->
        <div class="action-bar">
            <button class="submit-btn" onclick="submitForm()">
                <i class="material-icons">send</i> Submit Proposal
            </button>
        </div>
    </div>
  <form action="<%=request.getContextPath() %>/logout" name="logoutForm" id="logoutForm" method="post">
		
	</form>
    <script>
        $(document).ready(function() {
            // Set current date for date inputs
            const today = new Date().toISOString().split('T')[0];
            $('input[type="date"]').val(today);
            
            // Set current year in CAPEX number
            const currentYear = new Date().getFullYear();
            $('#capexNumber').val(`CAPEX-${currentYear}-001`);
            
            // Cost Calculation
            $('#basicCost, #gstRate').on('input', calculateCosts);
            
            // Budget Calculation
            $('#totalBudget, #proposedPrice').on('input', calculateBudget);
            
            // File Upload Handlers
            $('#roiFile').on('change', function(e) {
                handleFileUpload(e, '#roiFileName');
            });
            
            $('#timelineFile').on('change', function(e) {
                handleFileUpload(e, '#timelineFileName');
            });
            
            $('#reasonFile').on('change', function(e) {
                handleFileUpload(e, '#reasonFileName');
            });
            
            // Signature Uploads
            $('.signature-upload').on('change', handleSignatureUpload);
            $('.authority-upload').on('change', handleAuthoritySignatureUpload);
            
            // Comment Character Counters
            $('.authority-comment').on('input', updateCommentCounter);
            
            // Initialize comment counters
            $('.authority-comment').each(function() {
                updateCommentCounter.call(this);
            });
            
            // Load saved data if exists
            loadSavedData();
            
            // Auto-save on input
            setupAutoSave();
        });
        
        function calculateCosts() {
            const basicCost = parseFloat($('#basicCost').val()) || 0;
            const gstRate = parseFloat($('#gstRate').val()) || 0;
            
            const gstAmount = (basicCost * gstRate) / 100;
            const totalCost = basicCost + gstAmount;
            
            $('#gstAmount').val(gstAmount.toFixed(2));
            $('#totalCost').val(totalCost.toFixed(2));
        }
        
        function calculateBudget() {
            const totalBudget = parseFloat($('#totalBudget').val()) || 0;
            const proposedPrice = parseFloat($('#proposedPrice').val()) || 0;
            
            const availableBalance = totalBudget - proposedPrice;
            $('#availableBalance').val(availableBalance.toFixed(2));
        }
        
        function handleFileUpload(event, fileNameSelector) {
            const file = event.target.files[0];
            if (!file) return;
            
            // Validate file type
            const allowedTypes = [
                'application/pdf',
                'application/vnd.ms-excel',
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                'image/jpeg',
                'image/jpg'
            ];
            
            if (!allowedTypes.includes(file.type)) {
                alert('Only Excel, PDF, or JPG files are allowed.');
                event.target.value = '';
                $(fileNameSelector).text('No file selected');
                return;
            }
            
            // Validate file size (10MB)
            const maxSize = 10 * 1024 * 1024;
            if (file.size > maxSize) {
                alert('File size must be less than 10MB.');
                event.target.value = '';
                $(fileNameSelector).text('No file selected');
                return;
            }
            
            $(fileNameSelector).text(file.name);
        }
        
        function handleSignatureUpload(event) {
            const file = event.target.files[0];
            if (!file) return;
            
            const reader = new FileReader();
            const role = $(event.target).data('role');
            
            reader.onload = function(e) {
                $(`#${role}SignatureBox`).html(`<img src="${e.target.result}" alt="Signature">`);
                saveToLocalStorage(`signature_${role}`, e.target.result);
            };
            
            reader.readAsDataURL(file);
        }
        
        function handleAuthoritySignatureUpload(event) {
            const file = event.target.files[0];
            if (!file) return;
            
            const reader = new FileReader();
            const role = $(event.target).data('role');
            
            reader.onload = function(e) {
                $(`#${role}SignatureBox`).html(`<img src="${e.target.result}" alt="Signature">`);
                saveToLocalStorage(`authority_${role}`, e.target.result);
            };
            
            reader.readAsDataURL(file);
        }
        
        function updateCommentCounter() {
            const textarea = $(this);
            const currentLength = textarea.val().length;
            const maxLength = parseInt(textarea.attr('maxlength'));
            const counter = textarea.siblings('.comment-counter');
            
            counter.text(`${currentLength} / ${maxLength}`);
            
            if (currentLength > maxLength * 0.8) {
                counter.css('color', '#e74c3c');
            } else {
                counter.css('color', '#6c757d');
            }
        }
        
        function saveToLocalStorage(key, value) {
            try {
                localStorage.setItem(`capex_${key}`, value);
            } catch (e) {
                console.error('LocalStorage error:', e);
            }
        }
        
        function getFromLocalStorage(key) {
            try {
                return localStorage.getItem(`capex_${key}`);
            } catch (e) {
                console.error('LocalStorage error:', e);
                return null;
            }
        }
        
        function loadSavedData() {
            // Load form data
            const savedData = getFromLocalStorage('form_data');
            if (savedData) {
                const data = JSON.parse(savedData);
                Object.keys(data).forEach(key => {
                    const element = $(`#${key}`);
                    if (element.length) {
                        if (element.is('input[type="text"], input[type="number"], textarea')) {
                            element.val(data[key]);
                        } else if (element.is('select')) {
                            element.val(data[key]);
                        }
                    }
                });
                
                // Trigger calculations
                calculateCosts();
                calculateBudget();
            }
            
            // Load signatures
            ['preparedBy', 'projectManager', 'requestedBy', 'headOfPlant'].forEach(role => {
                const signature = getFromLocalStorage(`signature_${role}`);
                if (signature) {
                    $(`#${role}SignatureBox`).html(`<img src="${signature}" alt="Signature">`);
                }
            });
            
            ['headProjects', 'businessHead', 'cfo', 'ceo'].forEach(role => {
                const signature = getFromLocalStorage(`authority_${role}`);
                if (signature) {
                    $(`#${role}SignatureBox`).html(`<img src="${signature}" alt="Signature">`);
                }
            });
        }
        
        function setupAutoSave() {
            // Save form data on input
            const saveFields = [
                'capexTitle', 'capexNumber', 'department', 'businessUnit', 
                'plantCode', 'location', 'assetDescription', 'basicCost',
                'gstRate', 'roiText', 'timelineText', 'reasonText',
                'financeDept', 'financeCategory', 'totalBudget', 'proposedPrice',
                'financeStatus', 'financeName', 'financeDesignation', 'financeDate',
                'financeComments'
            ];
            
            saveFields.forEach(fieldId => {
                $(`#${fieldId}`).on('input', function() {
                    const data = {};
                    saveFields.forEach(id => {
                        const element = $(`#${id}`);
                        if (element.length) {
                            data[id] = element.val();
                        }
                    });
                    
                    // Save signature details
                    $('.signature-name, .signature-designation, .signature-date').each(function() {
                        const role = $(this).data('role');
                        const field = $(this).hasClass('signature-name') ? 'name' :
                                     $(this).hasClass('signature-designation') ? 'designation' : 'date';
                        data[`signature_${role}_${field}`] = $(this).val();
                    });
                    
                    $('.authority-name, .authority-designation, .authority-date, .authority-comment').each(function() {
                        const role = $(this).data('role');
                        const field = $(this).hasClass('authority-name') ? 'name' :
                                     $(this).hasClass('authority-designation') ? 'designation' :
                                     $(this).hasClass('authority-date') ? 'date' : 'comment';
                        data[`authority_${role}_${field}`] = $(this).val();
                    });
                    
                    saveToLocalStorage('form_data', JSON.stringify(data));
                });
            });
        }
        
        function validateForm() {
            const requiredFields = [
                { id: 'capexTitle', name: 'CAPEX Title' },
                { id: 'capexNumber', name: 'CAPEX Number' },
                { id: 'department', name: 'Department' },
                { id: 'businessUnit', name: 'Business Unit' },
                { id: 'plantCode', name: 'Plant Code' },
                { id: 'location', name: 'Location' },
                { id: 'assetDescription', name: 'Asset Description' },
                { id: 'basicCost', name: 'Basic Cost' },
                { id: 'gstRate', name: 'GST Rate' }
            ];
            
            const errors = [];
            
            requiredFields.forEach(field => {
                const value = $(`#${field.id}`).val();
                if (!value || value.trim() === '') {
                    errors.push(`${field.name} is required`);
                }
            });
            
            // Validate numeric fields
            const basicCost = $('#basicCost').val();
            if (basicCost && parseFloat(basicCost) < 0) {
                errors.push('Basic Cost must be a positive number');
            }
            
            if (errors.length > 0) {
                alert('Please fix the following errors:\n\n' + errors.join('\n'));
                return false;
            }
            
            return true;
        }
        
        function submitForm() {
            if (!validateForm()) {
                return;
            }
            
            showLoading();
            
            // Collect all form data
            const formData = new FormData();
            
            // Basic information
            formData.append('capexTitle', $('#capexTitle').val());
            formData.append('capexNumber', $('#capexNumber').val());
            formData.append('department', $('#department').val());
            formData.append('businessUnit', $('#businessUnit').val());
            formData.append('plantCode', $('#plantCode').val());
            formData.append('location', $('#location').val());
            formData.append('assetDescription', $('#assetDescription').val());
            
            // Cost estimation
            formData.append('basicCost', $('#basicCost').val());
            formData.append('gstRate', $('#gstRate').val());
            formData.append('gstAmount', $('#gstAmount').val());
            formData.append('totalCost', $('#totalCost').val());
            
            // Investment details
            formData.append('roiText', $('#roiText').val());
            formData.append('timelineText', $('#timelineText').val());
            formData.append('reasonText', $('#reasonText').val());
            
            // File uploads
            const roiFile = $('#roiFile')[0].files[0];
            const timelineFile = $('#timelineFile')[0].files[0];
            const reasonFile = $('#reasonFile')[0].files[0];
            
            if (roiFile) formData.append('roiFile', roiFile);
            if (timelineFile) formData.append('timelineFile', timelineFile);
            if (reasonFile) formData.append('reasonFile', reasonFile);
            
            // Signature details
            $('.signature-name, .signature-designation, .signature-date').each(function() {
                const role = $(this).data('role');
                const field = $(this).hasClass('signature-name') ? 'name' :
                            $(this).hasClass('signature-designation') ? 'designation' : 'date';
                formData.append(`signature_${role}_${field}`, $(this).val());
            });
            
            // Authority details
            $('.authority-name, .authority-designation, .authority-date, .authority-comment').each(function() {
                const role = $(this).data('role');
                const field = $(this).hasClass('authority-name') ? 'name' :
                            $(this).hasClass('authority-designation') ? 'designation' :
                            $(this).hasClass('authority-date') ? 'date' : 'comment';
                formData.append(`authority_${role}_${field}`, $(this).val());
            });
            
            // Finance details
            formData.append('financeDept', $('#financeDept').val());
            formData.append('financeCategory', $('#financeCategory').val());
            formData.append('totalBudget', $('#totalBudget').val());
            formData.append('proposedPrice', $('#proposedPrice').val());
            formData.append('availableBalance', $('#availableBalance').val());
            formData.append('financeStatus', $('#financeStatus').val());
            formData.append('financeName', $('#financeName').val());
            formData.append('financeDesignation', $('#financeDesignation').val());
            formData.append('financeDate', $('#financeDate').val());
            formData.append('financeComments', $('#financeComments').val());
            
            // AJAX submission
            $.ajax({
                url: 'CapexServlet',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    hideLoading();
                    
                    if (response.success) {
                        alert('Proposal submitted successfully!');
                        localStorage.removeItem('capex_form_data');
                        window.location.href = 'dashboard.jsp';
                    } else {
                        alert('Error: ' + (response.message || 'Submission failed'));
                    }
                },
                error: function(xhr, status, error) {
                    hideLoading();
                    alert('Network error: ' + error);
                }
            });
        }
        
        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                // Clear local storage
                localStorage.clear();
                console.log('User signed out.');
                // Redirect to login
                $("#logoutForm").submit();
            }
        }   
       
        
        function showLoading() {
            $('#loadingOverlay').fadeIn();
        }
        
        function hideLoading() {
            $('#loadingOverlay').fadeOut();
        }
        
        // Prevent form submission on Enter key
        $(document).on('keypress', function(e) {
            if (e.which === 13) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>