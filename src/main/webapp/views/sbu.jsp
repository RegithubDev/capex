<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SBU Management - CAPEX System</title>
    
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

        /* SBU Form Modal */
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
            display: flex !important;
        }

        .modal {
            background: white;
            border-radius: 15px;
            width: 90%;
            max-width: 600px;
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
        .form-group {
            margin-bottom: 25px;
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
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
            background: #f8f9fa;
        }

        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
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

            .search-box {
                width: 100%;
                margin-top: 15px;
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
            
            .table-header {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
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
                <p>SBU Management</p>
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
                <i class="fas fa-sitemap"></i>
                <div>
                    <h2>SBU Management</h2>
                    <p style="font-size: 14px; color: #666; margin-top: 5px;">Manage Strategic Business Units</p>
                </div>
            </div>
            
            <div class="action-buttons">
                <button class="btn btn-secondary" onclick="refreshData()">
                    <i class="fas fa-sync-alt"></i> Refresh
                </button>
                <button class="btn btn-primary" onclick="openAddSBUModal()">
                    <i class="fas fa-plus"></i> Add New SBU
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
                <div class="table-title">SBU List</div>
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search SBUs..." onkeyup="searchSBUs()">
                </div>
            </div>
            
            <table class="table" id="sbuTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>SBU Code</th>
                        <th>SBU Name</th>
                        <th>Created By</th>
                        <th>Created Date</th>
                        <th>Updated By</th>
                        <th>Updated Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <!-- Data will be populated by JavaScript -->
                    <tr>
                        <td colspan="9" style="text-align: center; padding: 40px;">
                            <div style="color: #999; font-size: 16px;">
                                <i class="fas fa-spinner fa-spin" style="font-size: 48px; margin-bottom: 15px;"></i>
                                <p>Loading SBUs...</p>
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

    <!-- Add/Edit SBU Modal -->
    <div class="modal-overlay" id="sbuModal">
        <div class="modal">
            <div class="modal-header">
                <h3><i class="fas fa-sitemap"></i> <span id="modalTitle">Add New SBU</span></h3>
                <button class="modal-close" onclick="closeSBUModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="sbuForm" onsubmit="saveSBU(event)">
                    <div class="form-group">
                        <label for="sbu_code">SBU Code <span>*</span></label>
                        <input type="text" id="sbu_code" name="sbu_code" required 
                               placeholder="Enter SBU code (e.g., SBU-001)" maxlength="50">
                        <small style="color: #666; font-size: 12px; margin-top: 5px; display: block;">
                            Unique identifier for the SBU
                        </small>
                    </div>
                    
                    <div class="form-group">
                        <label for="sbu_name">SBU Name <span>*</span></label>
                        <input type="text" id="sbu_name" name="sbu_name" required 
                               placeholder="Enter SBU name" maxlength="100">
                        <small style="color: #666; font-size: 12px; margin-top: 5px; display: block;">
                            Full name of the Strategic Business Unit
                        </small>
                    </div>
                    
                    <div class="form-group">
                        <label for="status">Status <span>*</span></label>
                        <select id="status" name="status" required>
                            <option value="">Select Status</option>
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                        <small style="color: #666; font-size: 12px; margin-top: 5px; display: block;">
                            Active SBUs will be available for selection in other modules
                        </small>
                    </div>
                    
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="closeSBUModal()">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save"></i> Save SBU
                        </button>
                    </div>
                    
                    <input type="hidden" id="sbu_id" name="id" value="">
                </form>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
<script>
    // Global variables
    let currentPage = 1;
    const itemsPerPage = 10;
    const baseUrl = '${pageContext.request.contextPath}';
    let sbus = [];

    // Initialize the page
    document.addEventListener('DOMContentLoaded', function() {
        console.log('SBU Management Page loaded');
        loadSBUs();
        initEventListeners();
    });

    // Initialize event listeners
    function initEventListeners() {
        // Close modal when clicking outside
        document.getElementById('sbuModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeSBUModal();
            }
        });
    }

    // Load SBUs from server
    function loadSBUs() {
        console.log('Loading SBUs...');
        showLoading();
        
        $.ajax({
            url: baseUrl + '/ajax/getSBUList',
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log('SBUs loaded:', response);
                // Check if response is an error object
                if (response && response.message && response.status) {
                    showAlert(response.message, 'error');
                    sbus = [];
                } else {
                    sbus = response || [];
                }
                populateTable(sbus);
            },
            error: function(xhr, status, error) {
                console.error('Error loading SBUs:', error);
                console.error('Response:', xhr.responseText);
                
                let errorMsg = 'Error loading SBUs. ';
                if (xhr.responseText) {
                    try {
                        const response = JSON.parse(xhr.responseText);
                        if (response.message) {
                            errorMsg = response.message;
                        } else {
                            errorMsg += 'Please try again.';
                        }
                    } catch (e) {
                        errorMsg += xhr.responseText;
                    }
                } else {
                    errorMsg += 'Please try again.';
                }
                
                showAlert(errorMsg, 'error');
                showNoData();
            }
        });
    }

    // Format date function
    function formatDate(dateString) {
        if (!dateString) return 'N/A';
        
        try {
            const date = new Date(dateString);
            if (isNaN(date.getTime())) return dateString;
            
            // Format: DD-MMM-YYYY HH:MM
            const day = date.getDate().toString().padStart(2, '0');
            const month = date.toLocaleString('default', { month: 'short' });
            const year = date.getFullYear();
            const hours = date.getHours().toString().padStart(2, '0');
            const minutes = date.getMinutes().toString().padStart(2, '0');
            
            return day + '-' + month + '-' + year + ' ' + hours + ':' + minutes;
        } catch (e) {
            console.error('Error formatting date:', e);
            return dateString;
        }
    }

    // Escape HTML to prevent XSS
    function escapeHtml(unsafe) {
        if (!unsafe) return unsafe;
        return unsafe
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

    // Populate table with data
    function populateTable(sbus) {
        console.log('Populating table with', sbus.length, 'SBUs');
        const tableBody = document.getElementById('tableBody');
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        
        // Filter SBUs based on search
        let filteredSBUs = sbus || [];
        if (searchTerm) {
            filteredSBUs = sbus.filter(function(sbu) {
                return (sbu.sbu && sbu.sbu.toLowerCase().includes(searchTerm)) ||
                       (sbu.sbu_name && sbu.sbu_name.toLowerCase().includes(searchTerm)) ||
                       (sbu.status && sbu.status.toLowerCase().includes(searchTerm)) ||
                       (sbu.created_by && sbu.created_by.toLowerCase().includes(searchTerm)) ||
                       (sbu.updated_by && sbu.updated_by.toLowerCase().includes(searchTerm));
            });
        }
        
        // Calculate pagination
        const totalPages = Math.ceil(filteredSBUs.length / itemsPerPage);
        const startIndex = (currentPage - 1) * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;
        const pageSBUs = filteredSBUs.slice(startIndex, endIndex);
        
        // Clear table
        tableBody.innerHTML = '';
        
        if (pageSBUs.length === 0) {
            showNoData(searchTerm);
        } else {
            // Add rows with formatted dates
            pageSBUs.forEach(function(sbu) {
                const row = document.createElement('tr');
                
                // Determine status class
                const statusClass = (sbu.status === 'Active') ? 'status-active' : 'status-inactive';
                const statusText = sbu.status || 'Inactive';
                
                // Format dates
                const createdDate = formatDate(sbu.created_date);
                const updatedDate = formatDate(sbu.updated_at);
                
                row.innerHTML = 
                    '<td>' + escapeHtml(sbu.id || 'N/A') + '</td>' +
                    '<td>' + escapeHtml(sbu.sbu || 'N/A') + '</td>' +
                    '<td>' + escapeHtml(sbu.sbu_name || 'N/A') + '</td>' +
                    '<td>' + escapeHtml(sbu.created_by || 'N/A') + '</td>' +
                    '<td>' + createdDate + '</td>' +
                    '<td>' + escapeHtml(sbu.updated_by || 'N/A') + '</td>' +
                    '<td>' + updatedDate + '</td>' +
                    '<td>' +
                        '<span class="' + statusClass + '">' + escapeHtml(statusText) + '</span>' +
                    '</td>' +
                    '<td>' +
                        '<div class="action-icons">' +
                            '<button class="action-btn edit-btn" onclick="editSBU(\'' + sbu.id + '\')" title="Edit">' +
                                '<i class="fas fa-edit"></i>' +
                            '</button>' +
                            '<button class="action-btn delete-btn" onclick="deleteSBU(\'' + sbu.id + '\')" title="Delete">' +
                                '<i class="fas fa-trash"></i>' +
                            '</button>' +
                        '</div>' +
                    '</td>';
                tableBody.appendChild(row);
            });
        }
        
        // Update pagination
        updatePagination(filteredSBUs.length, totalPages);
    }

    // Show loading state
    function showLoading() {
        const tableBody = document.getElementById('tableBody');
        tableBody.innerHTML = 
            '<tr>' +
                '<td colspan="9" style="text-align: center; padding: 40px;">' +
                    '<div style="color: #999; font-size: 16px;">' +
                        '<i class="fas fa-spinner fa-spin" style="font-size: 48px; margin-bottom: 15px;"></i>' +
                        '<p>Loading SBUs...</p>' +
                    '</div>' +
                '</td>' +
            '</tr>';
    }

    // Show no data message
    function showNoData(searchTerm) {
        const tableBody = document.getElementById('tableBody');
        const message = searchTerm ? 
            'No SBUs found matching your search. Try a different search or add a new SBU.' :
            'No SBU data available. Click "Add New SBU" to get started.';
        const icon = searchTerm ? 'search' : 'database';
        
        tableBody.innerHTML = 
            '<tr>' +
                '<td colspan="9" style="text-align: center; padding: 40px;">' +
                    '<div style="color: #999; font-size: 16px;">' +
                        '<i class="fas fa-' + icon + '" style="font-size: 48px; margin-bottom: 15px;"></i>' +
                        '<p>' + escapeHtml(message) + '</p>' +
                    '</div>' +
                '</td>' +
            '</tr>';
    }

    // Update pagination controls
    function updatePagination(totalItems, totalPages) {
        const pagination = document.getElementById('pagination');
        pagination.innerHTML = '';
        
        if (totalPages <= 1 && totalItems <= itemsPerPage) return;
        
        // Previous button
        const prevBtn = document.createElement('button');
        prevBtn.className = 'page-btn';
        prevBtn.innerHTML = '<i class="fas fa-chevron-left"></i>';
        prevBtn.disabled = currentPage === 1;
        prevBtn.onclick = function() {
            if (currentPage > 1) {
                currentPage--;
                populateTable(sbus);
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
                    populateTable(sbus);
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
                populateTable(sbus);
            }
        };
        pagination.appendChild(nextBtn);
        
        // Page info
        if (totalItems > 0) {
            const pageInfo = document.createElement('span');
            pageInfo.className = 'page-info';
            const start = ((currentPage - 1) * itemsPerPage) + 1;
            const end = Math.min(currentPage * itemsPerPage, totalItems);
            pageInfo.textContent = 'Showing ' + start + ' to ' + end + ' of ' + totalItems + ' SBUs';
            pagination.appendChild(pageInfo);
        }
    }

    // Search SBUs
    function searchSBUs() {
        currentPage = 1;
        populateTable(sbus);
    }

    // Open modal for adding new SBU
    function openAddSBUModal() {
        console.log('Opening add SBU modal');
        document.getElementById('modalTitle').textContent = 'Add New SBU';
        
        // Reset form
        document.getElementById('sbuForm').reset();
        document.getElementById('sbu_id').value = '';
        
        // Set default status
        document.getElementById('status').value = 'Active';
        
        // Show modal
        const modal = document.getElementById('sbuModal');
        modal.classList.add('active');
        modal.style.display = 'flex';
        
        // Focus on first input
        setTimeout(function() {
            document.getElementById('sbu_code').focus();
        }, 100);
        
        console.log('Modal should be visible now');
    }

    // Open modal for editing SBU - UPDATED
    function editSBU(id) {
        console.log('Editing SBU with ID:', id);
        
        // Show loading indicator
        showAlert('Loading SBU details...', 'info');
        
        $.ajax({
            url: baseUrl + '/ajax/getSBUById/' + id,
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log('SBU data received:', response);
                
                // Check if response is an error object
                if (response && response.message && response.status) {
                    showAlert(response.message, 'error');
                    return;
                }
                
                if (response) {
                    document.getElementById('modalTitle').textContent = 'Edit SBU';
                    document.getElementById('sbu_id').value = response.id || '';
                    document.getElementById('sbu_code').value = response.sbu || '';
                    document.getElementById('sbu_name').value = response.sbu_name || '';
                    document.getElementById('status').value = response.status || 'Active';
                    
                    // Show modal
                    const modal = document.getElementById('sbuModal');
                    modal.classList.add('active');
                    modal.style.display = 'flex';
                    
                    // Focus on first input
                    setTimeout(function() {
                        document.getElementById('sbu_code').focus();
                    }, 100);
                } else {
                    showAlert('SBU not found', 'error');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error loading SBU details:', error);
                console.error('Response:', xhr.responseText);
                
                let errorMsg = 'Error loading SBU details. ';
                if (xhr.responseText) {
                    try {
                        const response = JSON.parse(xhr.responseText);
                        if (response.message) {
                            errorMsg = response.message;
                        } else {
                            errorMsg += 'Please try again.';
                        }
                    } catch (e) {
                        errorMsg += xhr.responseText;
                    }
                } else {
                    errorMsg += 'Please try again.';
                }
                
                showAlert(errorMsg, 'error');
            }
        });
    }

    // Close modal
    function closeSBUModal() {
        console.log('Closing modal');
        const modal = document.getElementById('sbuModal');
        modal.classList.remove('active');
        modal.style.display = 'none';
        document.getElementById('sbuForm').reset();
    }

    // Save SBU (Add/Edit) - UPDATED
    function saveSBU(event) {
        event.preventDefault();
        console.log('Saving SBU...');
        
        // Get form data
        const formData = {
            id: document.getElementById('sbu_id').value,
            sbu: document.getElementById('sbu_code').value,
            sbu_name: document.getElementById('sbu_name').value,
            status: document.getElementById('status').value
        };
        
        console.log('Form data to save:', formData);
        
        // Validate form data
        if (!formData.sbu || !formData.sbu.trim()) {
            showAlert('SBU Code is required', 'error');
            document.getElementById('sbu_code').focus();
            return;
        }
        
        if (!formData.sbu_name || !formData.sbu_name.trim()) {
            showAlert('SBU Name is required', 'error');
            document.getElementById('sbu_name').focus();
            return;
        }
        
        if (!formData.status || !formData.status.trim()) {
            showAlert('Status is required', 'error');
            document.getElementById('status').focus();
            return;
        }
        
        // Determine URL based on add/edit
        let url;
        if (formData.id) {
            url = baseUrl + '/sbu/update/ajax';
        } else {
            url = baseUrl + '/sbu/add/ajax';
        }
        
        console.log('Sending to:', url);
        
        // Show loading state on button
        const submitBtn = event.target.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
        submitBtn.disabled = true;
        
        // Send AJAX request
        $.ajax({
            url: url,
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                console.log('Save successful:', response);
                
                let message = '';
                if (response && response.message) {
                    message = response.message;
                } else if (typeof response === 'string') {
                    message = response;
                } else {
                    message = formData.id ? 'SBU updated successfully!' : 'SBU added successfully!';
                }
                
                showAlert(message, 'success');
                closeSBUModal();
                
                // Reload data after a short delay
                setTimeout(function() {
                    loadSBUs();
                }, 500);
            },
            error: function(xhr, status, error) {
                console.error('Error saving SBU:', error);
                console.error('Response text:', xhr.responseText);
                
                let errorMsg = 'Error saving SBU. ';
                
                // Try to parse error response
                if (xhr.responseText) {
                    try {
                        const response = JSON.parse(xhr.responseText);
                        if (response && response.message) {
                            errorMsg = response.message;
                        } else if (typeof response === 'string') {
                            errorMsg += response;
                        } else {
                            errorMsg += 'Please try again.';
                        }
                    } catch (e) {
                        errorMsg += xhr.responseText;
                    }
                } else {
                    errorMsg += 'Please check all fields and try again.';
                }
                
                showAlert(errorMsg, 'error');
            },
            complete: function() {
                // Restore button state
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
            }
        });
    }

    // Delete SBU - UPDATED
    function deleteSBU(id) {
        if (confirm('Are you sure you want to delete this SBU?')) {
            console.log('Deleting SBU with ID:', id);
            
            // Get the delete button that was clicked
            const deleteBtn = event.currentTarget;
            const originalHtml = deleteBtn.innerHTML;
            deleteBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
            deleteBtn.disabled = true;
            
            $.ajax({
                url: baseUrl + '/sbu/delete/ajax/' + id,
                type: 'POST',
                dataType: 'json',
                success: function(response) {
                    console.log('Delete successful:', response);
                    
                    let message = '';
                    if (response && response.message) {
                        message = response.message;
                    } else if (typeof response === 'string') {
                        message = response;
                    } else {
                        message = 'SBU deleted successfully!';
                    }
                    
                    showAlert(message, 'success');
                    
                    // Reload data
                    setTimeout(function() {
                        loadSBUs();
                    }, 300);
                },
                error: function(xhr, status, error) {
                    console.error('Error deleting SBU:', error);
                    
                    let errorMsg = 'Error deleting SBU. ';
                    if (xhr.responseText) {
                        try {
                            const response = JSON.parse(xhr.responseText);
                            if (response && response.message) {
                                errorMsg = response.message;
                            } else if (typeof response === 'string') {
                                errorMsg += response;
                            }
                        } catch (e) {
                            errorMsg += xhr.responseText;
                        }
                    } else {
                        errorMsg += 'Please try again.';
                    }
                    
                    showAlert(errorMsg, 'error');
                },
                complete: function() {
                    deleteBtn.innerHTML = originalHtml;
                    deleteBtn.disabled = false;
                }
            });
        }
    }

    // Show alert message - UPDATED with more types
    function showAlert(message, type) {
        const alertContainer = document.getElementById('alertContainer');
        
        // Clear any existing alerts
        alertContainer.innerHTML = '';
        
        const alert = document.createElement('div');
        alert.className = 'alert alert-' + type;
        
        let icon = 'info-circle';
        if (type === 'success') icon = 'check-circle';
        if (type === 'error') icon = 'exclamation-circle';
        if (type === 'warning') icon = 'exclamation-triangle';
        if (type === 'info') icon = 'info-circle';
        
        alert.innerHTML = 
            '<i class="fas fa-' + icon + '"></i>' +
            '<span>' + escapeHtml(message) + '</span>';
        alertContainer.appendChild(alert);
        
        // Remove alert after 5 seconds (except for errors which stay longer)
        const timeout = type === 'error' ? 8000 : 5000;
        setTimeout(function() {
            if (alert.parentNode === alertContainer) {
                alert.remove();
            }
        }, timeout);
    }

    // Refresh data
    function refreshData() {
        console.log('Refreshing data...');
        currentPage = 1;
        document.getElementById('searchInput').value = '';
        loadSBUs();
        showAlert('Data refreshed successfully!', 'success');
    }

    // Debug function to check current state
    function debugState() {
        console.log('=== DEBUG INFO ===');
        console.log('Current SBUs:', sbus);
        console.log('Current page:', currentPage);
        console.log('Base URL:', baseUrl);
        console.log('==================');
    }

    // Add debug button temporarily (remove in production)
    document.addEventListener('DOMContentLoaded', function() {
        // Add debug button temporarily
        const debugBtn = document.createElement('button');
        debugBtn.innerHTML = '<i class="fas fa-bug"></i> Debug';
        debugBtn.style.position = 'fixed';
        debugBtn.style.bottom = '20px';
        debugBtn.style.right = '20px';
        debugBtn.style.zIndex = '9999';
        debugBtn.style.padding = '10px';
        debugBtn.style.background = '#3498db';
        debugBtn.style.color = 'white';
        debugBtn.style.border = 'none';
        debugBtn.style.borderRadius = '5px';
        debugBtn.style.cursor = 'pointer';
        debugBtn.onclick = debugState;
        document.body.appendChild(debugBtn);
        
        // Remove debug button after 5 minutes (optional)
        setTimeout(function() {
            if (debugBtn.parentNode) {
                debugBtn.remove();
            }
        }, 300000);
    });

    // Navigation functions
    function goBackToDashboard() {
        window.location.href = baseUrl + '/home';
    }

    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            window.location.href = baseUrl + '/logout';
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
            const modal = document.getElementById('sbuModal');
            if (modal.classList.contains('active')) {
                closeSBUModal();
            }
        }
        
        // Ctrl + N for new SBU
        if (e.ctrlKey && e.key === 'n') {
            e.preventDefault();
            openAddSBUModal();
        }
        
        // Ctrl + R for refresh
        if (e.ctrlKey && e.key === 'r') {
            e.preventDefault();
            refreshData();
        }
    });
</script>
</body>
</html>