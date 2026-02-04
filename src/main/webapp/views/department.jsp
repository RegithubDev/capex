<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Department Management - CAPEX System</title>
    
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
                <h1>CAPEX Management System</h1>
                <p>Department Management</p>
            </div>
        </div>

        <div class="user-info">
            <span><i class="fas fa-user-circle"></i> <c:out value="${sessionScope.USER_NAME}" default="Admin" /></span>
           <button onclick="window.location.href='<c:url value="/home" />'">
    <i class="fas fa-arrow-left"></i> Back to Dashboard
</button>
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
                    <h2>Department Management</h2>
                    <p style="font-size: 14px; color: #666; margin-top: 5px;">Manage organizational departments</p>
                </div>
            </div>
            
            <div class="action-buttons">
                <button class="btn btn-secondary" onclick="refreshData()">
                    <i class="fas fa-sync-alt"></i> Refresh
                </button>
                <button class="btn btn-primary" onclick="openAddDepartmentModal()">
                    <i class="fas fa-plus"></i> Add New Department
                </button>
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
                <div class="table-title">Department List</div>
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search departments..." onkeyup="searchDepartments()">
                </div>
            </div>
            
            <table class="table" id="departmentTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>SBU</th>
                        <th>Plant Code</th>
                        <th>Department Code</th>
                        <th>Department Name</th>
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
                                <p>Loading departments...</p>
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

    <!-- Add/Edit Department Modal -->
    <div class="modal-overlay" id="departmentModal">
        <div class="modal">
            <div class="modal-header">
                <h3><i class="fas fa-building"></i> <span id="modalTitle">Add New Department</span></h3>
                <button class="modal-close" onclick="closeDepartmentModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="departmentForm" onsubmit="saveDepartment(event)">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="sbu">SBU <span>*</span></label>
                            <select id="sbu" name="sbu" required>
                                <option value="">Select SBU</option>
                                <!-- SBU options will be populated dynamically -->
                            </select>
                        </div>
                        
                        
                         <div class="form-group">
                            <label for="plant_code">Plant Code <span>*</span></label>
                            <select id="plant_code" name="plant_code" required>
                                <option value="">Select plant code</option>
                                <!-- plant code options will be populated dynamically -->
                            </select>
                        </div>
                       <!--  <div class="form-group">
                            <label for="plant_code">Plant Code <span>*</span></label>
                            <input type="text" id="plant_code" name="plant_code" required 
                                   placeholder="Enter plant code (e.g., PLANT-001)">
                        </div> -->
                    </div>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="department_code">Department Code <span>*</span></label>
                            <input type="text" id="department_code" name="department_code" required 
                                   placeholder="Enter department code (e.g., DEPT-001)">
                        </div>
                        
                        <div class="form-group">
                            <label for="department_name">Department Name <span>*</span></label>
                            <input type="text" id="department_name" name="department_name" required 
                                   placeholder="Enter department name">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="status">Status <span>*</span></label>
                        <select id="status" name="status" required>
                            <option value="">Select Status</option>
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>
                    
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="closeDepartmentModal()">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save"></i> Save Department
                        </button>
                    </div>
                    
                    <input type="hidden" id="department_id" name="id" value="">
                </form>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
<script>
    // Global variables
    let currentPage = 1;
    const itemsPerPage = 10;
    const baseUrl = '${pageContext.request.contextPath}'; // Fixed base URL
    let departments = [];

    // Initialize the page
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Page loaded, loading departments...');
        loadDepartments();
        loadSBUOptions();
        
        // Initialize event listeners
        initEventListeners();
    });

    // Initialize event listeners
    function initEventListeners() {
        // Close modal when clicking outside
        document.getElementById('departmentModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeDepartmentModal();
            }
        });
        
        // Add Department button
        document.querySelector('.btn-primary').addEventListener('click', openAddDepartmentModal);
        
        // Refresh button
        document.querySelector('.btn-secondary').addEventListener('click', refreshData);
    }

    // Load departments from server
    function loadDepartments() {
        console.log('Loading departments...');
        showLoading();
        
        $.ajax({
            url: baseUrl + '/department/ajax/getList',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                console.log('Departments loaded:', data);
                departments = data;
                populateTable(data);
            },
            error: function(xhr, status, error) {
                console.error('Error loading departments:', error);
                showAlert('Error loading departments. Please try again.', 'error');
                showNoData();
            }
        });
    }

    // Load SBU options for dropdown
    function loadSBUOptions() {
        console.log('Loading SBU options...');
        $.ajax({
            url: baseUrl + '/department/ajax/getSBUs',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                const sbuSelect = document.getElementById('sbu');
                sbuSelect.innerHTML = '<option value="">Select SBU</option>';
                
                data.forEach(function(sbu) {
                    if (sbu.sbu) {
                        const option = document.createElement('option');
                        option.value = sbu.sbu;
                        option.textContent = sbu.sbu;
                        sbuSelect.appendChild(option);
                    }
                });
            },
            error: function() {
                console.error('Error loading SBU options');
                showAlert('Error loading SBU options', 'error');
            }
        });
    }

    // Populate table with data
    function populateTable(departments) {
        console.log('Populating table...');
        const tableBody = document.getElementById('tableBody');
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        
        // Filter departments based on search
        let filteredDepartments = departments;
        if (searchTerm) {
            filteredDepartments = departments.filter(function(dept) {
                return (dept.department_code && dept.department_code.toLowerCase().includes(searchTerm)) ||
                       (dept.department_name && dept.department_name.toLowerCase().includes(searchTerm)) ||
                       (dept.sbu && dept.sbu.toLowerCase().includes(searchTerm)) ||
                       (dept.plant_code && dept.plant_code.toLowerCase().includes(searchTerm));
            });
        }
        
        // Calculate pagination
        const totalPages = Math.ceil(filteredDepartments.length / itemsPerPage);
        const startIndex = (currentPage - 1) * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;
        const pageDepartments = filteredDepartments.slice(startIndex, endIndex);
        
        // Clear table
        tableBody.innerHTML = '';
        
        if (pageDepartments.length === 0) {
            showNoData(searchTerm);
        } else {
            // Add rows
            pageDepartments.forEach(function(dept) {
                const row = document.createElement('tr');
                
                // Determine status class
                const statusClass = dept.status === 'Active' ? 'status-active' : 'status-inactive';
                
                row.innerHTML = 
                    '<td>' + (dept.id || 'N/A') + '</td>' +
                    '<td>' + (dept.sbu || 'N/A') + '</td>' +
                    '<td>' + (dept.plant_code || 'N/A') + '</td>' +
                    '<td>' + (dept.department_code || 'N/A') + '</td>' +
                    '<td>' + (dept.department_name || 'N/A') + '</td>' +
                    '<td>' +
                        '<span class="' + statusClass + '">' +
                            (dept.status || 'Inactive') +
                        '</span>' +
                    '</td>' +
                    '<td>' +
                        '<div class="action-icons">' +
                            '<button class="action-btn edit-btn" onclick="editDepartment(' + dept.id + ')" title="Edit">' +
                                '<i class="fas fa-edit"></i>' +
                            '</button>' +
                            '<button class="action-btn delete-btn" onclick="deleteDepartment(' + dept.id + ')" title="Delete">' +
                                '<i class="fas fa-trash"></i>' +
                            '</button>' +
                        '</div>' +
                    '</td>';
                tableBody.appendChild(row);
            });
        }
        
        // Update pagination
        updatePagination(filteredDepartments.length, totalPages);
    }

    // Show loading state
    function showLoading() {
        const tableBody = document.getElementById('tableBody');
        tableBody.innerHTML = 
            '<tr>' +
                '<td colspan="7" style="text-align: center; padding: 40px;">' +
                    '<div style="color: #999; font-size: 16px;">' +
                        '<i class="fas fa-spinner fa-spin" style="font-size: 48px; margin-bottom: 15px;"></i>' +
                        '<p>Loading departments...</p>' +
                    '</div>' +
                '</td>' +
            '</tr>';
    }

    // Show no data message - FIXED: removed duplicate parameter declaration
    function showNoData(searchTerm) {
        const tableBody = document.getElementById('tableBody');
        const message = searchTerm ? 
            'No departments found matching your search. Try a different search or add a new department.' :
            'No department data available. Click "Add New Department" to get started.';
        const icon = searchTerm ? 'search' : 'database';
        
        tableBody.innerHTML = 
            '<tr>' +
                '<td colspan="7" style="text-align: center; padding: 40px;">' +
                    '<div style="color: #999; font-size: 16px;">' +
                        '<i class="fas fa-' + icon + '" style="font-size: 48px; margin-bottom: 15px;"></i>' +
                        '<p>' + message + '</p>' +
                    '</div>' +
                '</td>' +
            '</tr>';
    }

    // Update pagination controls
    function updatePagination(totalItems, totalPages) {
        const pagination = document.getElementById('pagination');
        pagination.innerHTML = '';
        
        if (totalPages <= 1) return;
        
        // Previous button
        const prevBtn = document.createElement('button');
        prevBtn.className = 'page-btn';
        prevBtn.innerHTML = '<i class="fas fa-chevron-left"></i>';
        prevBtn.disabled = currentPage === 1;
        prevBtn.onclick = function() {
            if (currentPage > 1) {
                currentPage--;
                populateTable(departments);
            }
        };
        pagination.appendChild(prevBtn);
        
        // Page numbers
        for (let i = 1; i <= totalPages; i++) {
            const pageBtn = document.createElement('button');
            
            let className = 'page-btn';
            if (i === currentPage) {
                className += ' active';
            }
            
            pageBtn.className = className;
            pageBtn.textContent = i;
            pageBtn.onclick = (function(pageNum) {
                return function() {
                    currentPage = pageNum;
                    populateTable(departments);
                };
            })(i);
            pagination.appendChild(pageBtn);
        }
        
        // Next button
        const nextBtn = document.createElement('button');
        nextBtn.className = 'page-btn';
        nextBtn.innerHTML = '<i class="fas fa-chevron-right"></i>';
        nextBtn.disabled = currentPage === totalPages;
        nextBtn.onclick = function() {
            if (currentPage < totalPages) {
                currentPage++;
                populateTable(departments);
            }
        };
        pagination.appendChild(nextBtn);
        
        // Page info
        const pageInfo = document.createElement('span');
        pageInfo.className = 'page-info';
        const start = ((currentPage - 1) * itemsPerPage) + 1;
        const end = Math.min(currentPage * itemsPerPage, totalItems);
        pageInfo.textContent = 'Showing ' + start + ' to ' + end + ' of ' + totalItems + ' departments';
        pagination.appendChild(pageInfo);
    }

    // Search departments
    function searchDepartments() {
        currentPage = 1;
        populateTable(departments);
    }

    // Open modal for adding new department - FIXED THIS FUNCTION
    function openAddDepartmentModal() {
        console.log('Opening add department modal');
        document.getElementById('modalTitle').textContent = 'Add New Department';
        
        // Reset form
        document.getElementById('departmentForm').reset();
        document.getElementById('department_id').value = '';
        
        // Show modal
        const modal = document.getElementById('departmentModal');
        modal.classList.add('active');
        modal.style.display = 'flex'; // Force display flex
        
        console.log('Modal should be visible now');
    }

    // Open modal for editing department
    function editDepartment(id) {
        console.log('Editing department with ID:', id);
        
        $.ajax({
            url: baseUrl + '/department/ajax/getById',
            type: 'GET',
            data: { id: id },
            dataType: 'json',
            success: function(dept) {
                if (dept) {
                    document.getElementById('modalTitle').textContent = 'Edit Department';
                    document.getElementById('department_id').value = dept.id || '';
                    document.getElementById('sbu').value = dept.sbu || '';
                    document.getElementById('plant_code').value = dept.plant_code || '';
                    document.getElementById('department_code').value = dept.department_code || '';
                    document.getElementById('department_name').value = dept.department_name || '';
                    document.getElementById('status').value = dept.status || 'Active';
                    
                    // Show modal
                    const modal = document.getElementById('departmentModal');
                    modal.classList.add('active');
                    modal.style.display = 'flex'; // Force display flex
                }
            },
            error: function() {
                showAlert('Error loading department details', 'error');
            }
        });
    }

    // Close modal
    function closeDepartmentModal() {
        console.log('Closing modal');
        const modal = document.getElementById('departmentModal');
        modal.classList.remove('active');
        modal.style.display = 'none'; // Hide modal
        document.getElementById('departmentForm').reset();
    }

    // Save department (Add/Edit)
    function saveDepartment(event) {
        event.preventDefault();
        console.log('Saving department...');
        
        const formData = {
            id: document.getElementById('department_id').value,
            sbu: document.getElementById('sbu').value,
            plant_code: document.getElementById('plant_code').value,
            department_code: document.getElementById('department_code').value,
            department_name: document.getElementById('department_name').value,
            status: document.getElementById('status').value
        };
        
        console.log('Form data:', formData);
        
        const url = formData.id ? baseUrl + '/department/update' : baseUrl + '/department/add';
        const method = 'POST';
        
        $.ajax({
            url: url,
            type: method,
            data: formData,
            success: function(response) {
                showAlert(formData.id ? 'Department updated successfully!' : 'Department added successfully!', 'success');
                closeDepartmentModal();
                loadDepartments();
            },
            error: function(xhr, status, error) {
                console.error('Error saving department:', error);
                showAlert('Error saving department. Please check all fields and try again.', 'error');
            }
        });
    }

    // Delete department
    function deleteDepartment(id) {
        if (confirm('Are you sure you want to delete this department?')) {
            $.ajax({
                url: baseUrl + '/department/delete',
                type: 'POST',
                data: { id: id },
                success: function(response) {
                    showAlert('Department deleted successfully!', 'success');
                    loadDepartments();
                },
                error: function() {
                    showAlert('Error deleting department', 'error');
                }
            });
        }
    }

    // Show alert message
    function showAlert(message, type) {
        const alertContainer = document.getElementById('alertContainer');
        const alert = document.createElement('div');
        alert.className = 'alert alert-' + type;
        alert.innerHTML = 
            '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i>' +
            '<span>' + message + '</span>';
        alertContainer.appendChild(alert);
        
        // Remove alert after 5 seconds
        setTimeout(function() {
            alert.remove();
        }, 5000);
    }

    // Refresh data - FIXED THIS FUNCTION
    function refreshData() {
        console.log('Refreshing data...');
        currentPage = 1;
        document.getElementById('searchInput').value = '';
        loadDepartments();
        showAlert('Data refreshed successfully!', 'success');
    }

    // Navigation functions - FIXED THESE FUNCTIONS
    function goBackToDashboard() {
        console.log('Going back to dashboard...');
        // Try different possible paths
        const paths = [
            '${pageContext.request.contextPath}/welcome',
            '${pageContext.request.contextPath}/dashboard',
            '${pageContext.request.contextPath}/',
            '/welcome',
            '/dashboard',
            '/'
        ];
        
        // Try to redirect
        window.location.href = paths[0];
    }

    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            window.location.href = '${pageContext.request.contextPath}/logout';
        }
    }

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl + F for search
        if (e.ctrlKey && e.key === 'f') {
            e.preventDefault();
            document.getElementById('searchInput').focus();
        }
        
        // Escape to close modal
        if (e.key === 'Escape') {
            closeDepartmentModal();
        }
        
        // Ctrl + N for new department
        if (e.ctrlKey && e.key === 'n') {
            e.preventDefault();
            openAddDepartmentModal();
        }
    });
</script>
</body>
</html>