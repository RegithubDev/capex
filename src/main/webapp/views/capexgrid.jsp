<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CAPEX Proposals</title>
    
    <!-- Fonts and Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <style>
    .role-badge,
			.role-label {
			    font-size: 0.82em;
			    font-weight: 500;
			    vertical-align: middle;
			    border-radius: 0.375rem;     /* Bootstrap-like */
			    padding: 0.25em 0.5em;
			    background-color: #6c757d;    /* secondary gray */
			    color: white;
			    white-space: nowrap;
			}
			
			/* Optional nicer variants */
			.role-badge.finance  { background-color: #0d6efd; } /* blue */
			.role-badge.admin    { background-color: #198754; } /* green */
			.role-badge.manager  { background-color: #fd7e14; } /* orange */
			.role-badge.approver { background-color: #6610f2; } /* purple */
        /* Reset and Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
        }

        /* Header */
        .welcome-header {
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

        .welcome-header-content {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .welcome-icon img {
            height: 60px;
            width: auto;
            filter: brightness(0) invert(1);
        }

        .welcome-header h1 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 4px;
        }

        .welcome-header p {
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
        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* Page Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eaeaea;
        }

        .page-title {
            font-size: 28px;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .page-title i {
            color: #3498db;
            font-size: 32px;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 15px;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
        }

        .btn-primary {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.2);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.3);
        }

        .btn-secondary {
            background: #f8f9fa;
            color: #2c3e50;
            border: 1px solid #ddd;
        }

        .btn-secondary:hover {
            background: #e9ecef;
        }

        .btn-success {
            background: linear-gradient(135deg, #27ae60 0%, #229954 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(39, 174, 96, 0.2);
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(39, 174, 96, 0.3);
        }

        /* Department Form Modal */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 2000;
        }

        .modal-overlay.active {
            display: flex;
        }

        .modal {
            background: white;
            border-radius: 15px;
            width: 90%;
            max-width: 700px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
        }

        .modal-header {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 20px 30px;
            border-radius: 15px 15px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h3 {
            font-size: 20px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .modal-close {
            background: none;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.3s;
        }

        .modal-close:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .modal-body {
            padding: 30px;
        }

        /* Form Styles */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            color: #2c3e50;
            font-size: 14px;
        }

        .form-group label span {
            color: #e74c3c;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
            background: #f8f9fa;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #3498db;
            background: white;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        /* Table Styles */
        .table-container {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
        }

        .table-header {
            padding: 20px;
            background: #f8f9fa;
            border-bottom: 1px solid #eaeaea;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-title {
            font-size: 18px;
            font-weight: 600;
            color: #2c3e50;
        }

        .search-box {
            position: relative;
            width: 300px;
        }

        .search-box input {
            width: 100%;
            padding: 10px 15px 10px 40px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th {
            background: #2c3e50;
            color: white;
            font-weight: 600;
            text-align: left;
            padding: 15px;
            font-size: 14px;
        }

        .table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
            font-size: 14px;
        }

        .table tr:hover {
            background: #f8f9fa;
        }

        .table tr:last-child td {
            border-bottom: none;
        }

        .status-active {
            display: inline-block;
            padding: 5px 12px;
            background: #d4edda;
            color: #155724;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-inactive {
            display: inline-block;
            padding: 5px 12px;
            background: #f8d7da;
            color: #721c24;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .action-icons {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            background: none;
            border: none;
            width: 36px;
            height: 36px;
            border-radius: 6px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
        }

        .edit-btn {
            color: #3498db;
            background: #e3f2fd;
        }

        .edit-btn:hover {
            background: #bbdefb;
        }

        .delete-btn {
            color: #e74c3c;
            background: #fdedec;
        }

        .delete-btn:hover {
            background: #fadbd8;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .page-btn {
            padding: 8px 16px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 14px;
            min-width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .page-btn:hover {
            background: #f8f9fa;
        }

        .page-btn.active {
            background: #3498db;
            color: white;
            border-color: #3498db;
        }

        .page-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .page-info {
            color: #666;
            font-size: 14px;
            margin-left: 20px;
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .welcome-header {
                flex-direction: column;
                text-align: center;
                gap: 15px;
                padding: 15px;
            }

            .welcome-header-content {
                flex-direction: column;
                gap: 10px;
            }

            .page-header {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }

            .action-buttons {
                flex-wrap: wrap;
                justify-content: center;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .search-box {
                width: 100%;
            }

            .modal {
                width: 95%;
                margin: 10px;
            }
            
            .pagination {
                gap: 5px;
            }
            
            .page-btn {
                padding: 6px 12px;
                min-width: 36px;
                height: 36px;
            }
        }
        
        
        /* Add this to your existing CSS */
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: none; /* Default is none */
    justify-content: center;
    align-items: center;
    z-index: 2000;
}

.modal-overlay.active {
    display: flex !important; /* Force display when active */
}

/* Ensure modal content is scrollable on small screens */
@media (max-height: 700px) {
    .modal {
        max-height: 85vh;
        margin-top: 20px;
        margin-bottom: 20px;
    }
}
.modal-overlay {
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: rgba(0,0,0,0.6);
    display: none;
    align-items: center;
    justify-content: center;
    z-index: 2000;
}
.modal-overlay.active {
    display: flex;
}
.modal {
    background: white;
    border-radius: 12px;
    width: 90%;
    max-width: 600px;
    max-height: 90vh;
    overflow-y: auto;
    box-shadow: 0 10px 40px rgba(0,0,0,0.3);
}
.modal-header {
    background: #2c3e50;
    color: white;
    padding: 15px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.modal-close {
    background: none;
    border: none;
    color: white;
    font-size: 28px;
    cursor: pointer;
}
.phase-timeline ul {
    padding: 0;
}
.phase-timeline li {
    padding: 12px;
    border-bottom: 1px solid #eee;
    display: flex;
    justify-content: space-between;
}
.phase-timeline .completed {
    color: #27ae60;
    font-weight: bold;
}
.phase-timeline .pending {
    color: #e67e22;
}
    </style>
</head>
<body>
    <!-- Header -->
    <header class="welcome-header">
        <div class="welcome-header-content">
            <div class="welcome-icon">
                <img src="https://cdn-icons-png.flaticon.com/512/201/201623.png" alt="CAPEX Logo">
            </div>
            <div>
                <h1>CAPEX Proposals</h1>
                <p>CAPEX Proposals List</p>
            </div>
        </div>

        <div class="user-info">
            <span><i class="fas fa-user-circle"></i> <c:out value="${sessionScope.USER_NAME}" default="Admin" /></span>
        	<c:if test="${sessionScope.BASE_ROLE eq 'Admin'}">
            	   <button onclick="window.location.href='<c:url value="/home" />'">
				      <i class="fas fa-arrow-left"></i> Back to Dashboard
				   </button>
            </c:if>
          
            <button onclick="logout()"><i class="fas fa-sign-out-alt"></i> Logout</button>
        </div>
    </header>

    <!-- Main Container -->
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="page-title">
                <i class="fas fa-building"></i>
                <div>
                    <h2>CAPEX Proposals</h2>
                    <p style="font-size: 14px; color: #666; margin-top: 5px;">CAPEX Proposals Lists</p>
                </div>
            </div>
            
            <div class="action-buttons">
                <!-- <button class="btn btn-secondary" onclick="refreshData()">
                    <i class="fas fa-sync-alt"></i> Refresh
                </button> -->
            
                <a class="btn btn-primary" href = "<%=request.getContextPath() %>/form/capex-form">
                    <i class="fas fa-plus"></i> Add New Proposal
                </a>
            </div>
        </div>

        <!-- Alert Messages -->
        <div id="alertContainer">
            <!-- Display flash messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> <c:out value="${success}" />
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> <c:out value="${error}" />
                </div>
            </c:if>
        </div>

        <!-- Table Section -->
        <div class="table-container">
            <div class="table-header">
                <div class="table-title">CAPEX List</div>
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search Capex..." onkeyup="searchCapex()">
                </div>
            </div>
            
            <table class="table" id="departmentTable">
                <thead>
                    <tr>
                     <th>CAPEX Title</th>
		            <th>CAPEX Number</th>
		            <th>Department</th>
		            <th>Business Unit</th>
		            <th>Plant Code</th>
		            <th>Location</th>
		            <th>Status</th>
		            <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <!-- Data will be populated by JavaScript -->
                    <tr>
                        <td colspan="7" style="text-align: center; padding: 40px;">
                            <div style="color: #999; font-size: 16px;">
                                <i class="fas fa-spinner fa-spin" style="font-size: 48px; margin-bottom: 15px;"></i>
                                <p>Loading Capex...</p>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <div class="pagination" id="pagination">
            <!-- Pagination will be generated by JavaScript -->
        </div>
    </div>
<!-- View CAPEX Flow Modal -->
<!-- Add this modal HTML just before </body> -->
<div id="viewCapexModal" class="modal-overlay">
    <div class="modal">
        <div class="modal-header">
            <h3><i class="fas fa-eye"></i> CAPEX Approval Flow</h3>
            <button class="modal-close" onclick="closeViewModal()">×</button>
        </div>
        <div class="modal-body">
            <div id="capexDetails">
                <h4 id="modalCapexTitle">CAPEX Title</h4>
                <p id="modalCapexNumber"></p>
                <p id="modalDepartment"></p>
            </div>

            <div style="margin: 25px 0;">
                <h4>Approval Progress</h4>
                <ul id="phaseList" style="list-style:none; padding:0; margin:15px 0;">
                    <!-- Phases injected here -->
                </ul>
            </div>

            <div style="padding:15px; background:#f8f9fa; border-radius:8px; border:1px solid #ddd;">
                <strong>Current Stage:</strong><br>
                <span id="modalCurrentStatus" style="font-weight:bold; font-size:1.1em;"></span>
            </div>
        </div>
    </div>
</div>
    <!-- Add/Edit Department Modal -->
    
    <!-- JavaScript -->
<script>
    // Global variables
    let currentPage = 1;
    const itemsPerPage = 10;
    const baseUrl = '${pageContext.request.contextPath}';
    let capexData = [];

    // Page initialization
    document.addEventListener('DOMContentLoaded', function() {
        console.log('CAPEX list page initialized');
        loadCapexList();

        // Event listeners
        var searchInput = document.getElementById('searchInput');
        if (searchInput) {
            searchInput.addEventListener('input', debounce(searchAndRefresh, 350));
        }

        var refreshBtn = document.querySelector('.btn-secondary');
        if (refreshBtn) {
            refreshBtn.addEventListener('click', refreshData);
        }
    });

    // Load data from server
    function loadCapexList() {
        showLoading();

        $.ajax({
            url: baseUrl + '/form/ajax/getCapexList',
            type: 'GET',
            dataType: 'json',
            timeout: 15000,
            success: function(response) {
                console.log('CAPEX data received:', response);
                capexData = Array.isArray(response) ? response : [];
                populateTable(capexData);
            },
            error: function(xhr, status, error) {
                console.error('CAPEX load failed:', status, error, xhr.responseText);
                showAlert('Failed to load CAPEX proposals. Please try again.', 'error');
                showNoData('');
            }
        });
    }

 // ------------------------------------------------------------------
 // Status & Phase Logic (used in both table and modal)
 // ------------------------------------------------------------------
 function getCurrentStage(item) {
     // Treat missing or null phases as 0
     var p1 = Number(item.phase_one) === 1;
     var p2 = Number(item.phase_two) === 1;
     var p3 = Number(item.phase_three) === 1;

     if (p1 && p2 && p3) {
         return "Completed – Fully Approved";
     }
     if (p1 && p2) {
         return "Verified by Finance – Waiting for Business Head approval";
     }
     if (p1) {
         return "Submitted by "+item.plant_name+" – Waiting for Finance approval";
     }
     return "Submitted by Plant – Waiting for Finance verification";
 }

 function getPhaseLabel(phaseNum) {
     if (phaseNum === 1) return "Phase 1 – Plant Submission";
     if (phaseNum === 2) return "Phase 2 – Finance Verification";
     if (phaseNum === 3) return "Phase 3 – Final Approval";
     return "Unknown Phase";
 }

 function getPhaseStatusText(value) {
     return value === 1 ? "Completed" : "Pending";
 }

 function getPhaseClass(value) {
     return value === 1 ? "completed" : "pending";
 }

 // ------------------------------------------------------------------
 // Updated populateTable – status uses getCurrentStage()
 // ------------------------------------------------------------------
 function populateTable(dataArray) {
     var tbody = document.getElementById('tableBody');
     if (!tbody) return;

     var searchTerm = '';
     var searchInput = document.getElementById('searchInput');
     if (searchInput) {
         searchTerm = (searchInput.value || '').trim().toLowerCase();
     }

     var filtered = dataArray;
     if (searchTerm !== '') {
         filtered = dataArray.filter(function(item) {
             var stage = getCurrentStage(item);
             return [
                 item.capex_title,
                 item.capex_number,
                 item.department,
                 item.business_unit,
                 item.plant_code,
                 item.location,
                 item.status,
                 stage
             ].some(function(val) {
                 return val && String(val).toLowerCase().includes(searchTerm);
             });
         });
     }

     var totalItems = filtered.length;
     var totalPages = Math.ceil(totalItems / itemsPerPage);
     var start = (currentPage - 1) * itemsPerPage;
     var end = Math.min(start + itemsPerPage, totalItems);
     var pageItems = filtered.slice(start, end);

     tbody.innerHTML = '';

     if (pageItems.length === 0) {
         showNoData(searchTerm);
         updatePagination(totalItems, totalPages);
         return;
     }

     pageItems.forEach(function(item) {
         var currentStatus = getCurrentStage(item);
         var statusClass = getStatusClass(currentStatus);

         var rowHtml =
             '<tr>' +
                 '<td>' + escapeHtml(item.capex_title || '—') + '</td>' +
                 '<td>' + escapeHtml(item.capex_number || '—') + '</td>' +
                 '<td>' + escapeHtml(item.department_name || '—') + '</td>' +
                 '<td>' + escapeHtml(item.business_unit || '—') + '</td>' +
                 '<td>' + escapeHtml(item.plant_code || '—') + '</td>' +
                 '<td>' + escapeHtml(item.location || '—') + '</td>' +
                 '<td><span class="' + statusClass + '">Pending at <strong>' + (item.pendingAt ? escapeHtml(item.pendingAt) : '—') + '</strong>' + (item.pendingAt && item.role_type ? ' <span class="inline-pill px-2 py-0.5 text-muted bg-light border border-1 rounded-pill align-middle ms-1" style="font-size:0.82em; letter-spacing:0.3px;">' + escapeHtml(item.role_type) + '</span>' : '') + '</span></td>'+
                 '<td>' +
                     '<div class="action-icons">' +
                         '<button class="action-btn edit-btn" onclick="editCapex(\'' + escapeHtml(item.id || item.capex_number || '') + '\')" title="Edit"><i class="fas fa-edit"></i></button>' +
/*                          '<button class="action-btn view-btn" onclick="viewCapex(\'' + escapeHtml(item.id || item.capex_number || '') + '\')" title="View"><i class="fas fa-eye"></i></button>' +
 */                         '<button class="action-btn delete-btn" onclick="deleteCapex(\'' + escapeHtml(item.id || item.capex_number || '') + '\')" title="Delete"><i class="fas fa-trash"></i></button>' +
                     '</div>' +
                 '</td>' +
             '</tr>';

         tbody.innerHTML += rowHtml;
     });

     updatePagination(totalItems, totalPages);
 }

 // ------------------------------------------------------------------
 // View Modal – completely client-side, no API call
 // ------------------------------------------------------------------
 function viewCapex(id) {
     if (!id) {
         alert('Cannot view: missing identifier');
         return;
     }

     // Find item from already loaded data
     var item = capexData.find(function(capex) {
         return (capex.id && String(capex.id) === id) ||
                (capex.capex_number && capex.capex_number === id);
     });

     if (!item) {
         alert('CAPEX record not found in loaded data');
         return;
     }

     // Fill basic info
     document.getElementById('modalCapexTitle').textContent = item.capex_title || 'CAPEX Proposal';
     document.getElementById('modalCapexNumber').textContent = 'Number: ' + (item.capex_number || '—');
     document.getElementById('modalDepartment').textContent = 'Department: ' + (item.department || '—');

     // Current status
     var currentStatus = getCurrentStage(item);
     document.getElementById('modalCurrentStatus').textContent = currentStatus;

     // Build phase rows
     var phases = [
         { num: 1, value: Number(item.phase_one) || 0 },
         { num: 2, value: Number(item.phase_two) || 0 },
         { num: 3, value: Number(item.phase_three) || 0 }
     ];

     var phaseHtml = '';
     phases.forEach(function(p) {
         var label = getPhaseLabel(p.num);
         var text  = getPhaseStatusText(p.value);
         var cls   = getPhaseClass(p.value);
         phaseHtml += '<li class="' + cls + '">' +
                      '<strong>' + label + ':</strong> ' + text +
                      '</li>';
     });

     document.getElementById('phaseList').innerHTML = phaseHtml;

     // Show modal
     document.getElementById('viewCapexModal').classList.add('active');
 }

 function closeViewModal() {
     document.getElementById('viewCapexModal').classList.remove('active');
 }

 // Close modal when clicking outside content
 document.addEventListener('click', function(e) {
     var modal = document.getElementById('viewCapexModal');
     if (modal && modal.classList.contains('active') && e.target === modal) {
         closeViewModal();
     }
 });
    // Helpers
    function getStatusClass(status) {
        var s = (status || '').toLowerCase();
        if (s.indexOf('approved') !== -1)  return 'status-approved';
        if (s.indexOf('rejected') !== -1)  return 'status-rejected';
        if (s.indexOf('pending')  !== -1)  return 'status-pending';
        if (s.indexOf('on hold')  !== -1)  return 'status-onhold';
        return 'status-default';
    }

 // Safe escapeHtml – never fails
    function escapeHtml(unsafe) {
        // Convert anything to string safely
        var str = (unsafe == null) ? '' : String(unsafe);
        return str
            .replace(/&/g, "&amp;")
            .replace(/</g,  "&lt;")
            .replace(/>/g,  "&gt;")
            .replace(/"/g,  "&quot;")
            .replace(/'/g,  "&#039;");
    }

    // Inside populateTable → add debug before rendering
    pageItems.forEach(function(item, index) {
        console.log('Rendering item #' + index + ':', item); // ← see what the actual object looks like

        var statusClass = getStatusClass(item.status || 'Pending');

        var rowHtml =
            '<tr>' +
                '<td>' + escapeHtml(item.capex_title     || '—') + '</td>' +
                '<td>' + escapeHtml(item.capex_number    || '—') + '</td>' +
                '<td>' + escapeHtml(item.department      || '—') + '</td>' +
                '<td>' + escapeHtml(item.business_unit   || '—') + '</td>' +
                '<td>' + escapeHtml(item.plant_code      || '—') + '</td>' +
                '<td>' + escapeHtml(item.location        || '—') + '</td>' +
                '<td><span class="' + statusClass + '">' + escapeHtml(item.status || 'Pending') + '</span></td>' +
                '<td>' +
                    '<div class="action-icons">' +
                        '<button class="action-btn edit-btn" ' +
                                'onclick="editCapex(\'' + escapeHtml(item.capex_number) + '\')" ' +
                                'title="Edit">' +
                            '<i class="fas fa-edit"></i>' +
                        '</button>' +
                        '<button class="action-btn view-btn" ' +
                                'onclick="viewCapex(\'' + escapeHtml(item.id || item.capex_number || '') + '\')" ' +
                                'title="View">' +
                            '<i class="fas fa-eye"></i>' +
                        '</button>' +
                        '<button class="action-btn delete-btn" ' +
                                'onclick="deleteCapex(\'' + escapeHtml(item.id || item.capex_number || '') + '\')" ' +
                                'title="Delete">' +
                            '<i class="fas fa-trash"></i>' +
                        '</button>' +
                    '</div>' +
                '</td>' +
            '</tr>';

        tbody.innerHTML += rowHtml;
    });

    function showLoading() {
        var html = 
            '<tr>' +
                '<td colspan="8" style="text-align:center; padding:80px 20px;">' +
                    '<i class="fas fa-spinner fa-spin" style="font-size:3.5rem; color:#3498db; margin-bottom:1rem;"></i>' +
                    '<p style="color:#555; font-size:1.1rem;">Loading CAPEX proposals...</p>' +
                '</td>' +
            '</tr>';
        document.getElementById('tableBody').innerHTML = html;
    }

    function showNoData(term) {
        var msg = (term !== '')
            ? 'No matching CAPEX proposals found for your search.'
            : 'No CAPEX proposals have been created yet.';

        var html = 
            '<tr>' +
                '<td colspan="8" style="text-align:center; padding:80px 20px;">' +
                    '<i class="far fa-folder-open" style="font-size:3.5rem; color:#adb5bd; margin-bottom:1rem;"></i>' +
                    '<p style="color:#555; font-size:1.1rem;">' + msg + '</p>' +
                    '<p style="color:#6c757d; margin-top:0.75rem;">' +
                        'Click <strong>Add New Proposal</strong> to create one.' +
                    '</p>' +
                '</td>' +
            '</tr>';

        document.getElementById('tableBody').innerHTML = html;
    }

    function updatePagination(totalItems, totalPages) {
        var pag = document.getElementById('pagination');
        if (!pag) return;
        pag.innerHTML = '';

        if (totalItems === 0) return;

        // Previous button
        var prevHtml = '<button class="page-btn" ' +
                       (currentPage > 1 ? '' : 'disabled') + '>' +
                       '<i class="fas fa-chevron-left"></i></button>';
        pag.innerHTML += prevHtml;
        if (currentPage > 1) {
            pag.lastChild.onclick = function() {
                currentPage--;
                populateTable(capexData);
            };
        }

        // Page numbers
        for (var i = 1; i <= totalPages; i++) {
            var active = (i === currentPage) ? ' active' : '';
            var pageHtml = '<button class="page-btn' + active + '">' + i + '</button>';
            pag.innerHTML += pageHtml;
            pag.lastChild.onclick = (function(pageNum) {
                return function() {
                    currentPage = pageNum;
                    populateTable(capexData);
                };
            })(i);
        }

        // Next button
        var nextHtml = '<button class="page-btn" ' +
                       (currentPage < totalPages ? '' : 'disabled') + '>' +
                       '<i class="fas fa-chevron-right"></i></button>';
        pag.innerHTML += nextHtml;
        if (currentPage < totalPages) {
            pag.lastChild.onclick = function() {
                currentPage++;
                populateTable(capexData);
            };
        }

        // Info text
        if (totalItems > 0) {
            var from = (currentPage - 1) * itemsPerPage + 1;
            var to = Math.min(from + itemsPerPage - 1, totalItems);
            var infoHtml = '<span class="page-info">Showing ' + from + '–' + to + ' of ' + totalItems + '</span>';
            pag.innerHTML += infoHtml;
        }
    }

    function searchAndRefresh() {
        currentPage = 1;
        populateTable(capexData);
    }

    function debounce(fn, ms) {
        var timer;
        return function() {
            var args = arguments;
            clearTimeout(timer);
            timer = setTimeout(function() {
                fn.apply(this, args);
            }, ms);
        };
    }

    function showAlert(msg, type) {
        var container = document.getElementById('alertContainer');
        if (!container) return;

        var icon = (type === 'success') ? 'check-circle' : 'exclamation-circle';
        var html = 
            '<div class="alert alert-' + type + '">' +
                '<i class="fas fa-' + icon + '"></i>' +
                '<span>' + msg + '</span>' +
            '</div>';

        container.insertAdjacentHTML('beforeend', html);

        setTimeout(function() {
            var alerts = container.getElementsByClassName('alert');
            if (alerts.length > 0) {
                alerts[alerts.length - 1].remove();
            }
        }, 6000);
    }

    function refreshData() {
        currentPage = 1;
        var searchInput = document.getElementById('searchInput');
        if (searchInput) searchInput.value = '';
        loadCapexList();
        showAlert('Table refreshed successfully', 'success');
    }

    function logout() {
        if (confirm('Are you sure you want to log out?')) {
            window.location.href = baseUrl + '/logout';
        }
    }

    // Placeholder action handlers
    function editCapex(capex_number) {
        if (!capex_number) {
            alert('Cannot edit: missing identifier');
            return;
        }
        window.location.href = baseUrl + '/form/capex-form/' + capex_number;
    }


    function deleteCapex(id) {
        if (!id) {
            alert('Cannot delete: missing identifier');
            return;
        }
        if (!confirm('Delete CAPEX ' + id + '? This action cannot be undone.')) {
            return;
        }

        $.ajax({
            url: baseUrl + '/form/ajax/deleteCapex',
            type: 'POST',
            data: { id: id },
            success: function() {
                showAlert('CAPEX deleted successfully', 'success');
                loadCapexList();
            },
            error: function() {
                showAlert('Failed to delete CAPEX', 'error');
            }
        });
    }
    
    
</script>
</body>
</html>