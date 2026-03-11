<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Capital Expenditure Proposal</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
    /* ────────────────────────────────────────────────
   Digital Signature Section - Modern & Clean UI
───────────────────────────────────────────────── */
.signature-section {
    background: linear-gradient(145deg, #f8f9ff, #f0f4ff);
    border-left: 5px solid #4f46e5;
}

.signature-title {
    font-size: 1.5rem;
    font-weight: 700;
    color: #1e40af;
    margin-bottom: 1.75rem;
    display: flex;
    align-items: center;
    gap: 12px;
}

.signature-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
    gap: 1.5rem;
}

.signature-card {
    background: white;
    border-radius: 12px;
    padding: 1.5rem;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
    border: 1px solid #e0e7ff;
    transition: all 0.25s ease;
}

.signature-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 30px rgba(79, 70, 229, 0.15);
    border-color: #c7d2fe;
}

.card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.25rem;
    padding-bottom: 0.75rem;
    border-bottom: 2px solid #e0e7ff;
}

.card-header h4 {
    margin: 0;
    font-size: 1.15rem;
    font-weight: 600;
    color: #1e40af;
}

.status-badge {
    padding: 0.35rem 0.9rem;
    border-radius: 9999px;
    font-size: 0.8rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.4px;
}

.status-badge.pending {
    background: #fef3c7;
    color: #92400e;
}

.field-label {
    display: block;
    font-weight: 500;
    color: #374151;
    margin-bottom: 0.5rem;
    font-size: 0.95rem;
}

.custom-select {
    width: 100%;
    padding: 0.75rem 1rem;
    border: 1px solid #d1d5db;
    border-radius: 8px;
    font-size: 0.95rem;
    background: white;
    transition: all 0.2s;
}

.custom-select:focus {
    border-color: #6366f1;
    box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15);
    outline: none;
}

.required {
    color: #ef4444;
    margin-left: 4px;
}

/* Responsive */
@media (max-width: 768px) {
    .signature-grid {
        grid-template-columns: 1fr;
    }
    .signature-title {
        font-size: 1.35rem;
    }
}
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Roboto',sans-serif; background:#f5f7fa; color:#333; line-height:1.6; }
        
        .capex-header {
            background:linear-gradient(135deg,#2c3e50,#34495e);
            color:white;
            padding:15px 30px;
            display:flex;
            justify-content:space-between;
            align-items:center;
            box-shadow:0 4px 12px rgba(0,0,0,0.1);
            position:sticky;
            top:0;
            z-index:1000;
        }
        .capex-header-content { display:flex; align-items:center; gap:20px; }
        .capex-icon img { height:60px; filter:brightness(0) invert(1); }
        .capex-header h1 { font-size:24px; font-weight:700; margin-bottom:4px; }
        .capex-header p { font-size:14px; opacity:0.9; }
        .user-info { display:flex; align-items:center; gap:15px; }
        .user-info button {
            background:#e74c3c;
            color:white;
            border:none;
            padding:8px 20px;
            border-radius:6px;
            cursor:pointer;
        }

        .capex-container { max-width:1400px; margin:30px auto; padding:0 20px; }
        .capex-card { 
            background:white; 
            border-radius:12px; 
            padding:30px; 
            margin-bottom:25px; 
            box-shadow:0 6px 15px rgba(0,0,0,0.08); 
            border:1px solid #eaeaea; 
        }
        .capex-card h3 { 
            font-size:20px; 
            margin-bottom:25px; 
            color:#2c3e50; 
            display:flex; 
            align-items:center; 
            gap:10px; 
        }

        .form-grid, .cost-grid, .investment-grid { 
            display:grid; 
            grid-template-columns:repeat(auto-fit,minmax(340px,1fr)); 
            gap:28px; 
            margin-bottom:25px; 
        }

        .form-group, .cost-group, .investment-group { 
            display:flex; 
            flex-direction:column; 
            gap:8px; 
        }

        .form-group label, .cost-group label, .investment-label {
            font-weight:500;
            color:#374151;
            font-size:15px;
        }
        .required { color:#ef4444; margin-left:4px; }

        input, select, textarea {
            padding:12px 15px;
            border:1px solid #d1d5db;
            border-radius:8px;
            font-size:14px;
        }
        input:focus, select:focus, textarea:focus {
            border-color:#3b82f6;
            box-shadow:0 0 0 3px rgba(59,130,246,0.15);
            outline:none;
        }

        textarea { min-height:110px; resize:vertical; }

        .upload-container {
            display:flex;
            align-items:center;
            gap:16px;
            flex-wrap:wrap;
            margin-top:8px;
        }
        .upload-btn {
            background:#3498db;
            color:white;
            padding:10px 18px;
            border-radius:6px;
            cursor:pointer;
            display:inline-flex;
            align-items:center;
            gap:8px;
            font-size:14px;
        }
        .upload-btn:hover { background:#2980b9; }

        .file-name-display {
            font-size:13px;
            color:#374151;
            margin-top:4px;
            word-break:break-all;
        }

        .budget-info {
            font-weight:600;
            font-size:1.05rem;
            color:#1e40af;
            padding:10px 14px;
            background:#eff6ff;
            border-radius:6px;
            border:1px solid #bfdbfe;
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

        .action-bar { 
            display:flex; 
            justify-content:center; 
            margin:40px 0; 
        }
        .submit-btn {
            background:linear-gradient(135deg,#27ae60,#229954);
            color:white;
            border:none;
            padding:18px 45px;
            border-radius:10px;
            font-size:18px;
            font-weight:600;
            cursor:pointer;
            transition:all 0.3s;
        }
        .submit-btn:hover { transform:translateY(-2px); }
        .submit-btn:disabled { opacity:0.6; cursor:not-allowed; }

        .loading-overlay {
            position:fixed;
            inset:0;
            background:rgba(0,0,0,0.7);
            display:none;
            justify-content:center;
            align-items:center;
            flex-direction:column;
            z-index:9999;
            color:white;
        }
        .loading-spinner {
            width:50px; height:50px;
            border:4px solid rgba(255,255,255,0.3);
            border-top-color:#3498db;
            border-radius:50%;
            animation:spin 1s linear infinite;
            margin-bottom:20px;
        }
        @keyframes spin { to { transform:rotate(360deg); } }

        @media (max-width:768px) {
            .capex-header { flex-direction:column; text-align:center; gap:15px; padding:15px; }
            .form-grid, .cost-grid, .investment-grid { grid-template-columns:1fr; }
        }
    </style>
</head>
<body>

<div id="loadingOverlay" class="loading-overlay">
    <div class="loading-spinner"></div>
    <p>Submitting your proposal...</p>
</div>

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
        <span>Welcome, <c:out value="${sessionScope.BASE_ROLE}" default="User" /></span>
        <button onclick="document.getElementById('logoutForm').submit()">Logout</button>
    </div>
</header>

<div class="capex-container">
    <form id="capexForm" action="<%=request.getContextPath()%>/form/submit" method="post" enctype="multipart/form-data">
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
            <h3><i class="material-icons">description</i> Basic Information</h3>
            <div class="form-grid">
                <div class="form-group">
                    <label>CAPEX Title <span class="required">*</span></label>
                    <input type="text" name="capex_title" placeholder="Enter proposal title" required>
                </div>

                <div class="form-group">
                    <label>Plant Code <span class="required">*</span></label>
                    <select id="plantCode" name="plant_code" required onchange="updateSbuAndLocation(); filterProjectManagers();">
                        <option value="">Select Plant</option>
                        
                        <c:if test="${sessionScope.BASE_ROLE eq 'Admin'}">
                            <c:forEach var="obj" items="${pList}">
                                <option value="${obj.plant_code}"
                                        data-sbu="${obj.sbu}"
                                        data-location="${obj.location}"
                                        data-budget="${obj.total_available_budget_fy}">
                                    [${obj.plant_code}] - ${obj.plant_name}
                                </option>
                            </c:forEach>
                        </c:if>

                        <c:if test="${sessionScope.BASE_ROLE ne 'Admin'}">
                            <c:forEach var="obj" items="${pList}">
                                <c:if test="${obj.plant_code == sessionScope.BASE_PROJECT_CODE}">
                                    <option value="${obj.plant_code}"
                                            data-sbu="${obj.sbu}"
                                            data-location="${obj.location}"
                                            data-budget="${obj.total_available_budget_fy}">
                                        [${obj.plant_code}] - ${obj.plant_name}
                                    </option>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </select>
                </div>

                <div class="form-group">
                    <label>Department / Function <span class="required">*</span></label>
                    <select name="department" required>
                        <option value="">Select department</option>
                        <c:forEach var="obj" items="${departmentList}">
                            <option value="${obj.department_code}"
                                    ${obj.department_code == editList.department ? 'selected' : ''}>
                                [${obj.department_code}] - ${obj.department_name}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Business Unit <span class="required">*</span></label>
                    <p id="displaySbu" style="padding:12px 15px; background:#f8f9fa; border:1px solid #ddd; border-radius:8px; min-height:42px; margin:0;">
                        Select Plant first
                    </p>
                    <input type="hidden" name="business_unit" id="businessUnit">
                </div>

                <div class="form-group">
                    <label>Location <span class="required">*</span></label>
                    <p id="displayLocation" style="padding:12px 15px; background:#f8f9fa; border:1px solid #ddd; border-radius:8px; min-height:42px; margin:0;">
                        Select Plant first
                    </p>
                    <input type="hidden" name="location" id="location">
                </div>

                <div class="form-group">
                    <label>Available Budget (₹)</label>
                    <div id="displayBudget" class="budget-info">—</div>
                </div>
            </div>

            <div id="budgetWarning" class="budget-warning"></div>

            <div class="form-group full-width">
                <label>Asset Description <span class="required">*</span></label>
                <textarea name="asset_description" placeholder="Provide detailed description..." required></textarea>
            </div>
        </section>

        <!-- Cost Estimation -->
        <section class="capex-card">
            <h3><i class="material-icons">attach_money</i> Cost Estimation</h3>
            <div class="cost-grid">
                <div class="cost-group">
                    <label>Estimate of Proposal / Basic Cost (₹) <span class="required">*</span></label>
                    <input type="number" id="basicCost" name="basic_cost" placeholder="0.00" 
                           step="0.01" min="0" required oninput="validateBudgetLimit();updateCostCalculations();">
                    <small>Numeric value in Crores</small>
                </div>

                <div class="cost-group">
                    <label>GST Rate <span class="required">*</span></label>
                    <select id="gstRate" name="gst_rate" required onchange="updateCostCalculations()">
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
                    <input type="text" id="gstAmount" name="gst_amount" readonly>
                    <small>Auto-calculated</small>
                </div>

                <div class="cost-group">
                    <label>Total Estimate Including GST (₹)</label>
                    <input type="text" id="totalCost" name="total_cost" readonly>
                    <small>Auto-calculated</small>
                </div>
            </div>
        </section>

        <!-- Investment Details -->
        <section class="capex-card">
            <h3><i class="material-icons">trending_up</i> Investment Details</h3>
            <div class="investment-grid">
                <div class="investment-group">
                    <label class="investment-label">Return on Investment (ROI) & Payback Period <span class="required">*</span></label>
                    <textarea name="roi_text" maxlength="500" rows="4" required placeholder=""></textarea>
                    <div class="upload-container">
                        <label class="upload-btn">
                            <i class="material-icons">attach_file</i> Upload Supporting Document
                            <input type="file" name="roiFile" accept=".pdf,.xls,.xlsx,.jpg,.jpeg,.png" hidden>
                        </label>
                        <span class="file-name" id="roiFileName">No file selected</span>
                    </div>
                    <div class="file-name-display" id="roiFileDisplay"></div>
                </div>

                <div class="investment-group">
                    <label class="investment-label">Project Timeline (with Zero Date) <span class="required">*</span></label>
                    <textarea name="timeline_text" maxlength="500" rows="4" required placeholder=""></textarea>
                    <div class="upload-container">
                        <label class="upload-btn">
                            <i class="material-icons">attach_file</i> Upload Supporting Document
                            <input type="file" name="timelineFile" accept=".pdf,.xls,.xlsx,.jpg,.jpeg,.png" hidden>
                        </label>
                        <span class="file-name" id="timelineFileName">No file selected</span>
                    </div>
                    <div class="file-name-display" id="timelineFileDisplay"></div>
                </div>

                <div class="investment-group full-width">
                    <label class="investment-label">Reason for Purchase / Key Milestones / Expected Savings <span class="required">*</span></label>
                    <textarea name="reason_text" maxlength="500" rows="5" required placeholder=""></textarea>
                    <div class="upload-container">
                        <label class="upload-btn">
                            <i class="material-icons">attach_file</i> Upload Supporting Document
                            <input type="file" name="reasonFile" accept=".pdf,.xls,.xlsx,.jpg,.jpeg,.png" hidden>
                        </label>
                        <span class="file-name" id="reasonFileName">No file selected</span>
                    </div>
                    <div class="file-name-display" id="reasonFileDisplay"></div>
                </div>
            </div>
        </section>
        <!-- Digital Signature Section -->
<section class="capex-card signature-section">
    <h3 class="signature-title">
        <i class="material-icons" style="font-size: 28px; vertical-align: middle;">edit_note</i>
        Digital Signature & Approval
    </h3>

    <div class="signature-grid">
        <!-- Requested By Card -->
        <div class="signature-card">
            <div class="card-header">
                <h4>Requested By</h4>
                <span class="status-badge pending">Pending</span>
            </div>
            <div class="signature-fields">
                <label class="field-label">Employee Name <span class="required">*</span></label>
                <select name="requested_by_name" class="custom-select" required>
                    <option value="">-- Select Employee --</option>
                    <c:forEach var="obj" items="${uList}">
                        <option value="${obj.user_id}"
                                ${obj.user_id == editList.requested_by_name ? 'selected' : ''}>
                            [${obj.user_id}] - ${obj.user_name}
                        </option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <!-- Project Manager / Execution Card -->
        <div class="signature-card">
            <div class="card-header">
                <h4>Project Manager / Execution</h4>
                <span class="status-badge pending">Pending</span>
            </div>
            <div class="signature-fields">
                <label class="field-label">Employee Name <span class="required">*</span></label>
               <select name="project_manager_name" id="projectManager" class="custom-select" required>
				    <option value="">-- Select Name --</option>
				    <c:forEach var="obj" items="${uList}">
				        <option value="${obj.user_id}"
				                data-plant="${obj.base_project}"
				                >
				            [${obj.user_id}] - ${obj.user_name}
				        </option>
				    </c:forEach>
				</select>
            </div>
        </div>
    </div>
</section>
        <div class="action-bar">
            <button type="submit" class="submit-btn">
                <i class="material-icons">send</i> Submit Proposal
            </button>
        </div>
    </form>
</div>

<form action="<%=request.getContextPath()%>/logout" id="logoutForm" method="post"></form>

<script>
// Format number with Indian comma style
function formatBudget(num) {
    if (!num && num !== 0) return '—';
    return Number(num).toLocaleString('en-IN');
}

// Global variable for selected plant budget
var selectedPlantBudget = null;

function filterProjectManagers() {

    var plantSelect = document.getElementById("plantCode");
    var selectedPlant = plantSelect.value;

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

    managerSelect.value = "";
}

function updateSbuAndLocation() {
    var select = document.getElementById('plantCode');
    var opt = select.options[select.selectedIndex];

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

function clearFile(name, displayId) {
    document.querySelector('input[name="' + name + '"]').value = '';
    document.getElementById(displayId).innerHTML = '';
}
</script>
</body>
</html>