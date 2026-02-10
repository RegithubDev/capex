<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - CAPEX System</title>
    
    <!-- Fonts and Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- jQuery and Select2 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    
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

        .btn-warning {
            background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(243, 156, 18, 0.2);
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(243, 156, 18, 0.3);
        }

        /* User Form Modal */
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
            max-width: 800px;
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
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
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

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #3498db;
            background: white;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .password-container {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #666;
            cursor: pointer;
            font-size: 18px;
            padding: 0;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        /* Filter Section */
        .filter-section {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            align-items: end;
        }

        .filter-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
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
            font-size: 14px;
        }

        .table th {
            background: #2c3e50;
            color: white;
            font-weight: 600;
            text-align: left;
            padding: 15px;
            font-size: 14px;
            position: sticky;
            top: 0;
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
            gap: 8px;
            flex-wrap: wrap;
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
            font-size: 16px;
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

        .view-btn {
            color: #27ae60;
            background: #d4edda;
        }

        .view-btn:hover {
            background: #c3e6cb;
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

        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
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

        /* Statistics Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            gap: 20px;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .stat-icon.total { background: #e3f2fd; color: #3498db; }
        .stat-icon.active { background: #d4edda; color: #27ae60; }
        .stat-icon.inactive { background: #fdedec; color: #e74c3c; }
        .stat-icon.admin { background: #fff3cd; color: #f39c12; }

        .stat-content h3 {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-content p {
            color: #666;
            font-size: 14px;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .filter-grid {
                grid-template-columns: 1fr;
            }
            
            .table {
                font-size: 13px;
            }
            
            .table th,
            .table td {
                padding: 10px;
            }
        }

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
            }

            .modal {
                width: 95%;
                margin: 10px;
            }
            
            .stats-container {
                grid-template-columns: 1fr;
            }
            
            .table-header {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }
        }

        /* Select2 Custom Styling */
        .select2-container--default .select2-selection--single {
            border: 1px solid #ddd !important;
            border-radius: 8px !important;
            height: 46px !important;
            background: #f8f9fa !important;
        }

        .select2-container--default .select2-selection--single .select2-selection__rendered {
            line-height: 46px !important;
            padding-left: 15px !important;
        }

        .select2-container--default .select2-selection--single .select2-selection__arrow {
            height: 46px !important;
            right: 10px !important;
        }

        .select2-container--default .select2-results__option--highlighted[aria-selected] {
            background-color: #3498db !important;
            color: white !important;
        }

        .select2-container--default .select2-results__option[aria-selected=true] {
            background-color: #e3f2fd !important;
            color: #2c3e50 !important;
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
                <p>User Management</p>
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
                <i class="fas fa-users"></i>
                <div>
                    <h2>User Management</h2>
                    <p style="font-size: 14px; color: #666; margin-top: 5px;">Manage system users and their permissions</p>
                </div>
            </div>
            
            <div class="action-buttons">
                <button class="btn btn-secondary" onclick="refreshData()">
                    <i class="fas fa-sync-alt"></i> Refresh
                </button>
                <button class="btn btn-primary" onclick="openAddUserModal()">
                    <i class="fas fa-plus"></i> Add New User
                </button>
                <button class="btn btn-warning" onclick="exportToExcel()">
                    <i class="fas fa-file-export"></i> Export Users
                </button>
            </div>
        </div>

        <!-- Alert Messages -->
        <div id="alertContainer">
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

        <!-- Statistics Cards -->
        <div class="stats-container" id="statsContainer">
            <!-- Stats will be loaded dynamically -->
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <div class="filter-grid">
                <div class="form-group">
                    <label for="filterDesignation">Designation</label>
                    <select id="filterDesignation" class="form-select" onchange="applyFilters()">
                        <option value="">All Designations</option>
                        <c:forEach var="dept" items="${deptList}">
                            <option value="${dept.designation}">${dept.designation}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="filterProject">Base Project</label>
                    <select id="filterProject" class="form-select" onchange="applyFilters()">
                        <option value="">All Projects</option>
                        <c:forEach var="project" items="${projectsList}">
                            <option value="${project.project_code}">${project.project_name}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="filterSBU">Base SBU</label>
                    <select id="filterSBU" class="form-select" onchange="applyFilters()">
                        <option value="">All SBUs</option>
                        <c:forEach var="sbu" items="${sbuList}">
                            <option value="${sbu.sbu_code}">${sbu.sbu_name}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="filterStatus">Status</label>
                    <select id="filterStatus" class="form-select" onchange="applyFilters()">
                        <option value="">All Status</option>
                        <option value="Active">Active</option>
                        <option value="Inactive">Inactive</option>
                    </select>
                </div>
                
                <div class="filter-actions">
                    <button class="btn btn-secondary" onclick="clearFilters()">
                        <i class="fas fa-times"></i> Clear
                    </button>
                    <button class="btn btn-primary" onclick="applyFilters()">
                        <i class="fas fa-filter"></i> Apply Filters
                    </button>
                </div>
            </div>
        </div>

        <!-- Table Section -->
        <div class="table-container">
            <div class="table-header">
                <div class="table-title">User List</div>
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search users..." onkeyup="searchUsers()">
                </div>
            </div>
            
            <table class="table" id="userTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>User ID</th>
                        <th>User Name</th>
                        <th>Email</th>
                        <th>Mobile</th>
                        <th>Designation</th>
                        <th>Base Project</th>
                        <th>Base SBU</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <!-- Data will be populated by JavaScript -->
                    <tr>
                        <td colspan="10" style="text-align: center; padding: 40px;">
                            <div style="color: #999; font-size: 16px;">
                                <i class="fas fa-spinner fa-spin" style="font-size: 48px; margin-bottom: 15px;"></i>
                                <p>Loading users...</p>
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

    <!-- Add/Edit User Modal -->
    <div class="modal-overlay" id="userModal">
        <div class="modal">
            <div class="modal-header">
                <h3><i class="fas fa-user"></i> <span id="modalTitle">Add New User</span></h3>
                <button class="modal-close" onclick="closeUserModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="userForm" onsubmit="saveUser(event)">
                    <div class="form-grid">
                    
                        <!-- User ID -->
                        
                        <div class="form-group">
                            <label for="user_id">User ID <span>*</span></label>
                            <input type="text" id="user_id" name="user_id" required 
                                   placeholder="Enter user ID" maxlength="50" 
                                   pattern="[A-Za-z0-9_]+" title="Only letters, numbers and underscore allowed">
                            <small style="color: #666; font-size: 12px; margin-top: 5px; display: block;">
                                Unique identifier for the user
                            </small>
                        </div>
                        
                        <!-- User Name -->
                        <div class="form-group">
                            <label for="user_name">User Name <span>*</span></label>
                            <input type="text" id="user_name" name="user_name" required 
                                   placeholder="Enter full name" maxlength="100">
                        </div>
                        
                        <!-- Designation -->
                   <%--      <div class="form-group">
                            <label for="designation">Designation <span>*</span></label>
                            <select id="designation" name="designation" class="form-select" >
                                <option value="">Select Designation</option>
                                <c:forEach var="dept" items="${deptList}">
                                    <option value="${dept.designation}">${dept.designation}</option>
                                </c:forEach>
                            </select>
                        </div> --%>
                        
                        <!-- Password (only for add, optional for edit) -->
                        <div class="form-group" id="passwordGroup">
                            <label for="password">Password <span id="passwordRequired">*</span></label>
                            <div class="password-container">
                                <input type="password" id="password" name="password" 
                                       placeholder="Enter password" maxlength="50" required>
                                <button type="button" class="toggle-password" onclick="togglePassword('password')">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <small style="color: #666; font-size: 12px; margin-top: 5px; display: block;">
                                Minimum 6 characters
                            </small>
                        </div>
                        
                        <!-- Contact Number -->
                        <div class="form-group">
                            <label for="contact_number">Mobile Number <span>*</span></label>
                            <input type="tel" id="contact_number" name="contact_number" required 
                                   placeholder="Enter mobile number" maxlength="15"
                                   pattern="[0-9]{10,15}" title="10-15 digits only">
                        </div>
                        
                        <!-- Email -->
                        <div class="form-group">
                            <label for="email_id">Email <span>*</span></label>
                            <input type="email" id="email_id" name="email_id" required 
                                   placeholder="Enter email address" maxlength="100">
                        </div>
                        
                        <!-- Base Project -->
                        <div class="form-group">
                            <label for="base_project">Base Project</label>
                            <select id="base_project" name="base_project" class="form-select">
                                <option value="">Select Project</option>
                                <c:forEach var="project" items="${projectsList}">
                                    <option value="${project.project_code}">${project.project_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <!-- Base SBU -->
                        <div class="form-group">
                            <label for="base_sbu">Base SBU</label>
                            <select id="base_sbu" name="base_sbu" class="form-select">
                                <option value="">Select SBU</option>
                                <c:forEach var="sbu" items="${sbuList}">
                                    <option value="${sbu.sbu_code}">${sbu.sbu_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <!-- Base Department -->
                        <div class="form-group">
                            <label for="base_department">Base Department</label>
                            <select id="base_department" name="base_department" class="form-select">
                                <option value="">Select Department</option>
                                <c:forEach var="dept" items="${deptList}">
                                    <option value="${dept.department}">${dept.department}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <!-- Reporting To -->
                        <div class="form-group">
                            <label for="reporting_to">Reporting To</label>
                            <select id="reporting_to" name="reporting_to" class="form-select">
                                <option value="">Select Reporting Manager</option>
                                <c:forEach var="reportingUser" items="${objList}">
                                    <option value="${reportingUser.user_id}">${reportingUser.user_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <!-- Status -->
                        <div class="form-group">
                            <label for="status">Status <span>*</span></label>
                            <select id="status" name="status" class="form-select" required>
                                <option value="Active" selected>Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="closeUserModal()">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-success" id="submitButton">
                            <i class="fas fa-save"></i> Save User
                        </button>
                    </div>
                    
                    <input type="hidden" id="editMode" value="false">
                    <input type="hidden" id="original_user_id" name="original_user_id" value="">
                </form>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
      <script>
        // Global variables
        let currentPage = 1;
        const itemsPerPage = 10;
        const baseUrl = '<c:url value="/" />';
        let allUsers = [];
        let filteredUsers = [];
        
        // Initialize the page
        $(document).ready(function() {
            console.log('User Management Page loaded');
            initializeSelect2();
            loadUsers();
            loadStatistics();
            initEventListeners();
        });
        
        // Initialize Select2 for all select elements
        function initializeSelect2() {
            $('.form-select').select2({
                width: '100%',
                placeholder: 'Select an option',
                allowClear: true
            });
            
            // Initialize filter dropdowns
            $('#filterDesignation').select2();
            $('#filterProject').select2();
            $('#filterSBU').select2();
            $('#filterStatus').select2();
        }
        
        // Initialize event listeners
        function initEventListeners() {
            // Close modal when clicking outside
            $('#userModal').on('click', function(e) {
                if (e.target === this) {
                    closeUserModal();
                }
            });
            
            // Keyboard shortcuts
            $(document).on('keydown', function(e) {
                // Ctrl + F for search
                if (e.ctrlKey && e.key === 'f') {
                    e.preventDefault();
                    $('#searchInput').focus();
                }
                
                // Escape to close modal
                if (e.key === 'Escape') {
                    closeUserModal();
                }
                
                // Ctrl + N for new user
                if (e.ctrlKey && e.key === 'n') {
                    e.preventDefault();
                    openAddUserModal();
                }
            });
        }
        
        // Load users from server
     function loadUsers() {
    console.log('Loading users...');
    showLoading();
    
    $.ajax({
        url: baseUrl + 'ajax/getUserList1',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            console.log('Users loaded:', data);
            
            if (data && data.length > 0) {
                allUsers = data;
                filteredUsers = [...allUsers];
                
                // Sort by created_date or ID in descending order (newest first)
                filteredUsers.sort(function(a, b) {
                    if (a.created_date && b.created_date) {
                        return new Date(b.created_date) - new Date(a.created_date);
                    }
                    const idA = parseInt(a.id) || 0;
                    const idB = parseInt(b.id) || 0;
                    return idB - idA;
                });
                
                populateTable();
                loadStatistics();
                showAlert('Loaded ' + data.length + ' users successfully', 'success');
            } else {
                showAlert('No users found in database', 'warning');
                allUsers = [];
                filteredUsers = [];
                populateTable();
            }
        },
        error: function(xhr, status, error) {
            console.error('Error loading users:', error);
            
            // Check if it's a database error
            if (xhr.status === 500) {
                console.error('Database error details:', xhr.responseText);
                showAlert('Database connection issue. Please check if all required tables exist.', 'error');
            } else {
                showAlert('Error loading users: ' + error, 'error');
            }
            
            // Show no data
            showNoData();
        }
    });
}
        
        // Load statistics
        function loadStatistics() {
            if (allUsers.length === 0) return;
            
            const totalUsers = allUsers.length;
            const activeUsers = allUsers.filter(u => u.status === 'Active').length;
            const inactiveUsers = allUsers.filter(u => u.status === 'Inactive').length;
            const adminUsers = allUsers.filter(u => u.designation === 'Admin' || u.designation === 'Administrator').length;
            
            const statsContainer = $('#statsContainer');
            statsContainer.html(
                '<div class="stat-card">' +
                    '<div class="stat-icon total">' +
                        '<i class="fas fa-users"></i>' +
                    '</div>' +
                    '<div class="stat-content">' +
                        '<h3>' + totalUsers + '</h3>' +
                        '<p>Total Users</p>' +
                    '</div>' +
                '</div>' +
                '<div class="stat-card">' +
                    '<div class="stat-icon active">' +
                        '<i class="fas fa-user-check"></i>' +
                    '</div>' +
                    '<div class="stat-content">' +
                        '<h3>' + activeUsers + '</h3>' +
                        '<p>Active Users</p>' +
                    '</div>' +
                '</div>' +
                '<div class="stat-card">' +
                    '<div class="stat-icon inactive">' +
                        '<i class="fas fa-user-times"></i>' +
                    '</div>' +
                    '<div class="stat-content">' +
                        '<h3>' + inactiveUsers + '</h3>' +
                        '<p>Inactive Users</p>' +
                    '</div>' +
                '</div>' +
                '<div class="stat-card">' +
                    '<div class="stat-icon admin">' +
                        '<i class="fas fa-user-shield"></i>' +
                    '</div>' +
                    '<div class="stat-content">' +
                        '<h3>' + adminUsers + '</h3>' +
                        '<p>Admin Users</p>' +
                    '</div>' +
                '</div>'
            );
        }
        
        
        // Populate table with data
        function populateTable() {
            console.log('Populating table with', filteredUsers.length, 'users');
            const tableBody = $('#tableBody');
            const searchTerm = $('#searchInput').val().toLowerCase();
            
            // Filter users based on search
            let displayUsers = filteredUsers;
            if (searchTerm) {
                displayUsers = filteredUsers.filter(function(user) {
                    return (user.user_id && user.user_id.toLowerCase().includes(searchTerm)) ||
                           (user.user_name && user.user_name.toLowerCase().includes(searchTerm)) ||
                           (user.email_id && user.email_id.toLowerCase().includes(searchTerm)) ||
                           (user.contact_number && user.contact_number.includes(searchTerm)) ||
                           (user.designation && user.designation.toLowerCase().includes(searchTerm));
                });
            }
            
            // Calculate pagination
            const totalPages = Math.ceil(displayUsers.length / itemsPerPage);
            const startIndex = (currentPage - 1) * itemsPerPage;
            const endIndex = startIndex + itemsPerPage;
            const pageUsers = displayUsers.slice(startIndex, endIndex);
            
            // Clear table
            tableBody.empty();
            
            if (pageUsers.length === 0) {
                showNoData(searchTerm);
            } else {
                // Add rows
                pageUsers.forEach(function(user, index) {
                    const rowNumber = startIndex + index + 1;
                    const statusClass = (user.status === 'Active') ? 'status-active' : 'status-inactive';
                    const statusText = user.status || 'Inactive';
                    
                    // Get project and SBU names
                    const projectName = user.base_project_name || user.base_project || '-';
                    const sbuName = user.base_sbu_name || user.base_sbu || '-';
                    
                 // In populateTable function, update the row creation:
                // In populateTable function, update the row creation:
const row = $(
    '<tr>' +
        '<td>' + rowNumber + '</td>' +
        '<td><strong>' + (user.user_id || '-') + '</strong></td>' +
        '<td>' + (user.user_name || '-') + '</td>' +
        '<td><a href="mailto:' + (user.email_id || '') + '" style="color: #3498db;">' + (user.email_id || '-') + '</a></td>' +
        '<td>' + (user.contact_number || '-') + '</td>' +
        '<td>' + (user.designation || user.base_role || '-') + '</td>' +  // Use designation or base_role
        '<td>' + (user.base_project || '-') + '</td>' +
        '<td>' + (user.base_sbu || '-') + '</td>' +
        '<td><span class="' + statusClass + '">' + statusText + '</span></td>' +
        '<td>' +
            '<div class="action-icons">' +
                '<button class="action-btn edit-btn" onclick="editUser(\'' + user.user_id + '\')" title="Edit">' +
                    '<i class="fas fa-edit"></i>' +
                '</button>' +
                '<button class="action-btn delete-btn" onclick="deleteUser(\'' + user.user_id + '\')" title="Delete">' +
                    '<i class="fas fa-trash"></i>' +
                '</button>' +
            '</div>' +
        '</td>' +
    '</tr>'
);
                    tableBody.append(row);
                });
            }
            
            // Update pagination
            updatePagination(displayUsers.length, totalPages);
            
            // Update statistics
            loadStatistics();
        }
        
        // Show loading state
        function showLoading() {
            $('#tableBody').html(
                '<tr>' +
                    '<td colspan="10" style="text-align: center; padding: 40px;">' +
                        '<div style="color: #999; font-size: 16px;">' +
                            '<i class="fas fa-spinner fa-spin" style="font-size: 48px; margin-bottom: 15px;"></i>' +
                            '<p>Loading users...</p>' +
                        '</div>' +
                    '</td>' +
                '</tr>'
            );
        }
        
        // Show no data message
        function showNoData(searchTerm) {
            const message = searchTerm ? 
                'No users found matching your search. Try a different search or add a new user.' :
                'No user data available. Click "Add New User" to get started.';
            const icon = searchTerm ? 'search' : 'users';
            
            $('#tableBody').html(
                '<tr>' +
                    '<td colspan="10" style="text-align: center; padding: 40px;">' +
                        '<div style="color: #999; font-size: 16px;">' +
                            '<i class="fas fa-' + icon + '" style="font-size: 48px; margin-bottom: 15px;"></i>' +
                            '<p>' + message + '</p>' +
                        '</div>' +
                    '</td>' +
                '</tr>'
            );
        }
        
        // Update pagination controls
        function updatePagination(totalItems, totalPages) {
            const pagination = $('#pagination');
            pagination.empty();
            
            if (totalPages <= 1) return;
            
            // Previous button
            const prevBtn = $(
                '<button class="page-btn" ' + (currentPage === 1 ? 'disabled' : '') + '>' +
                    '<i class="fas fa-chevron-left"></i>' +
                '</button>'
            ).click(function() {
                if (currentPage > 1) {
                    currentPage--;
                    populateTable();
                }
            });
            pagination.append(prevBtn);
            
            // Page numbers
            for (let i = 1; i <= totalPages; i++) {
                let className = 'page-btn';
                if (i === currentPage) {
                    className += ' active';
                }
                
                const pageBtn = $('<button class="' + className + '">' + i + '</button>').click((function(pageNum) {
                    return function() {
                        currentPage = pageNum;
                        populateTable();
                    };
                })(i));
                pagination.append(pageBtn);
            }
            
            // Next button
            const nextBtn = $(
                '<button class="page-btn" ' + (currentPage === totalPages ? 'disabled' : '') + '>' +
                    '<i class="fas fa-chevron-right"></i>' +
                '</button>'
            ).click(function() {
                if (currentPage < totalPages) {
                    currentPage++;
                    populateTable();
                }
            });
            pagination.append(nextBtn);
            
            // Page info
            const start = ((currentPage - 1) * itemsPerPage) + 1;
            const end = Math.min(currentPage * itemsPerPage, totalItems);
            const pageInfo = $('<span class="page-info">Showing ' + start + ' to ' + end + ' of ' + totalItems + ' users</span>');
            pagination.append(pageInfo);
        }
        
        // Search users
        function searchUsers() {
            currentPage = 1;
            populateTable();
        }
        
        // Apply filters
        function applyFilters() {
            currentPage = 1;
            
            const designation = $('#filterDesignation').val();
            const project = $('#filterProject').val();
            const sbu = $('#filterSBU').val();
            const status = $('#filterStatus').val();
            
            filteredUsers = allUsers.filter(function(user) {
                let match = true;
                
                if (designation && user.designation !== designation) {
                    match = false;
                }
                
                if (project && user.base_project !== project) {
                    match = false;
                }
                
                if (sbu && user.base_sbu !== sbu) {
                    match = false;
                }
                
                if (status && user.status !== status) {
                    match = false;
                }
                
                return match;
            });
            
            // Sort by ID in descending order
            filteredUsers.sort(function(a, b) {
                const idA = parseInt(a.id) || 0;
                const idB = parseInt(b.id) || 0;
                return idB - idA;
            });
            
            populateTable();
            showAlert('Filters applied successfully!', 'info');
        }
        
        // Clear all filters
        function clearFilters() {
            $('#filterDesignation').val('').trigger('change');
            $('#filterProject').val('').trigger('change');
            $('#filterSBU').val('').trigger('change');
            $('#filterStatus').val('').trigger('change');
            $('#searchInput').val('');
            
            filteredUsers = [...allUsers];
            currentPage = 1;
            populateTable();
            showAlert('Filters cleared successfully!', 'info');
        }
        
        // Open modal for adding new user
        function openAddUserModal() {
            console.log('Opening add user modal');
            $('#modalTitle').text('Add New User');
            $('#editMode').val('false');
            
            // Reset form
            $('#userForm')[0].reset();
            $('.form-select').val('').trigger('change');
            
            // Set defaults
            $('#status').val('Active').trigger('change');
            
            // Show password field as required
            $('#passwordGroup').show();
            $('#passwordRequired').show();
            $('#password').prop('required', true);
            $('#submitButton').html('<i class="fas fa-save"></i> Save User');
            
            // Clear hidden fields
            $('#original_user_id').val('');
            
            // Show modal
            $('#userModal').addClass('active').css('display', 'flex');
            setTimeout(function() { initializeSelect2(); }, 100);
        }
        
        // Open modal for editing user
        function editUser(userId) {
            console.log('Editing user with ID:', userId);
            
            // Find user in the data
            const user = allUsers.find(function(u) { return u.user_id === userId; });
            
            if (user) {
                $('#modalTitle').text('Edit User');
                $('#editMode').val('true');
                
                // Fill form with user data
                $('#user_id').val(user.user_id).prop('readonly', true);
                $('#original_user_id').val(user.user_id);
                $('#user_name').val(user.user_name || '');
                $('#email_id').val(user.email_id || '');
                $('#contact_number').val(user.contact_number || '');
                
                // Set dropdown values
                $('#designation').val(user.designation || '').trigger('change');
                $('#base_project').val(user.base_project || '').trigger('change');
                $('#base_sbu').val(user.base_sbu || '').trigger('change');
                $('#base_department').val(user.base_department || '').trigger('change');
                $('#reporting_to').val(user.reporting_to || '').trigger('change');
                $('#status').val(user.status || 'Active').trigger('change');
                
                // Hide password field for edit (optional)
                $('#passwordGroup').show();
                $('#passwordRequired').hide();
                $('#password').prop('required', false);
                $('#password').attr('placeholder', 'Enter new password (leave blank to keep current)');
                $('#submitButton').html('<i class="fas fa-save"></i> Update User');
                
                // Show modal
                $('#userModal').addClass('active').css('display', 'flex');
                setTimeout(function() { initializeSelect2(); }, 100);
            } else {
                showAlert('User not found', 'error');
            }
        }
        
        // View user details
        function viewUser(userId) {
            const user = allUsers.find(function(u) { return u.user_id === userId; });
            if (user) {
                let details = 
                    '<strong>User ID:</strong> ' + (user.user_id || '-') + '<br>' +
                    '<strong>Name:</strong> ' + (user.user_name || '-') + '<br>' +
                    '<strong>Email:</strong> ' + (user.email_id || '-') + '<br>' +
                    '<strong>Mobile:</strong> ' + (user.contact_number || '-') + '<br>' +
                    '<strong>Designation:</strong> ' + (user.designation || '-') + '<br>' +
                    '<strong>Base Project:</strong> ' + (user.base_project || '-') + '<br>' +
                    '<strong>Base SBU:</strong> ' + (user.base_sbu || '-') + '<br>' +
                    '<strong>Base Department:</strong> ' + (user.base_department || '-') + '<br>' +
                    '<strong>Status:</strong> ' + (user.status || '-') + '<br>' +
                    '<strong>Created Date:</strong> ' + (user.created_date || '-') + '<br>' +
                    '<strong>Modified Date:</strong> ' + (user.modified_date || '-');
                
                if (typeof Swal !== 'undefined') {
                    Swal.fire({
                        title: 'User Details',
                        html: details,
                        icon: 'info',
                        confirmButtonText: 'Close',
                        width: '600px'
                    });
                } else {
                    alert('User Details:\n\n' + 
                        'User ID: ' + (user.user_id || '-') + '\n' +
                        'Name: ' + (user.user_name || '-') + '\n' +
                        'Email: ' + (user.email_id || '-') + '\n' +
                        'Mobile: ' + (user.contact_number || '-') + '\n' +
                        'Designation: ' + (user.designation || '-') + '\n' +
                        'Base Project: ' + (user.base_project || '-') + '\n' +
                        'Base SBU: ' + (user.base_sbu || '-') + '\n' +
                        'Base Department: ' + (user.base_department || '-') + '\n' +
                        'Status: ' + (user.status || '-'));
                }
            }
        }
        
        // Close modal
        function closeUserModal() {
            console.log('Closing modal');
            $('#userModal').removeClass('active').hide();
            $('#userForm')[0].reset();
            $('.form-select').val('').trigger('change');
        }
        
        // Toggle password visibility
        function togglePassword(fieldId) {
            const field = $('#' + fieldId);
            const button = field.siblings('.toggle-password');
            const icon = button.find('i');
            
            if (field.attr('type') === 'password') {
                field.attr('type', 'text');
                icon.removeClass('fa-eye').addClass('fa-eye-slash');
            } else {
                field.attr('type', 'password');
                icon.removeClass('fa-eye-slash').addClass('fa-eye');
            }
        }
        
        // Save user (Add/Edit)
        function saveUser(event) {
            event.preventDefault();
            console.log('Saving user...');
            
            // Get form data
            const formData = {
                user_id: $('#user_id').val(),
                user_name: $('#user_name').val(),
                designation: $('#designation').val(),
                password: $('#password').val(),
                contact_number: $('#contact_number').val(),
                email_id: $('#email_id').val(),
                base_project: $('#base_project').val(),
                base_sbu: $('#base_sbu').val(),
                base_department: $('#base_department').val(),
                reporting_to: $('#reporting_to').val(),
                status: $('#status').val()
            };
            
            const editMode = $('#editMode').val() === 'true';
            const originalUserId = $('#original_user_id').val();
            
            console.log('Form data to save:', formData);
            
            // Validate form data
            if (!formData.user_id || formData.user_id.trim() === '') {
                showAlert('User ID is required', 'error');
                return;
            }
            
            if (!formData.user_name || formData.user_name.trim() === '') {
                showAlert('User Name is required', 'error');
                return;
            }
            
            if (!formData.designation) {
                showAlert('Designation is required', 'error');
                return;
            }
            
            if (!editMode && (!formData.password || formData.password.trim() === '')) {
                showAlert('Password is required for new users', 'error');
                return;
            }
            
            if (!formData.contact_number || formData.contact_number.trim() === '') {
                showAlert('Mobile number is required', 'error');
                return;
            }
            
            if (!formData.email_id || formData.email_id.trim() === '') {
                showAlert('Email is required', 'error');
                return;
            }
            
            // If editing, don't require password
            if (editMode && formData.password.trim() === '') {
                delete formData.password;
            }
            
            // Set original user_id for updates
            if (editMode && originalUserId) {
                formData.original_user_id = originalUserId;
            }
            
            // Determine URL based on add/edit
            let url = editMode ? baseUrl + 'update-user' : baseUrl + 'add-user';
            
            console.log('Sending to:', url, 'Edit mode:', editMode);
            
            // Show loading
            $('#submitButton').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Saving...');
            
            // Send AJAX request
            $.ajax({
                url: url,
                type: 'POST',
                data: formData,
                success: function(response) {
                    console.log('Save successful:', response);
                    showAlert(editMode ? 'User updated successfully!' : 'User added successfully!', 'success');
                    closeUserModal();
                    
                    // Reload data after a short delay
                    setTimeout(function() {
                        loadUsers();
                    }, 500);
                },
                error: function(xhr, status, error) {
                    console.error('Error saving user:', error);
                    console.error('Response text:', xhr.responseText);
                    
                    let errorMsg = 'Error saving user. ';
                    if (xhr.responseText && xhr.responseText.includes('already exists')) {
                        errorMsg += 'User ID already exists.';
                    } else if (xhr.responseText && xhr.responseText.includes('duplicate')) {
                        errorMsg += 'Duplicate entry detected.';
                    } else {
                        errorMsg += 'Please check all fields and try again.';
                    }
                    
                    showAlert(errorMsg, 'error');
                    $('#submitButton').prop('disabled', false).html(editMode ? 
                        '<i class="fas fa-save"></i> Update User' : 
                        '<i class="fas fa-save"></i> Save User');
                },
                complete: function() {
                    // Reset button after a delay
                    setTimeout(function() {
                        $('#submitButton').prop('disabled', false);
                    }, 2000);
                }
            });
        }
        
        // Delete user
        function deleteUser(userId) {
            if (typeof Swal !== 'undefined') {
                Swal.fire({
                    title: 'Are you sure?',
                    text: 'You are about to delete user "' + userId + '". This action cannot be undone!',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Yes, delete it!',
                    cancelButtonText: 'Cancel',
                    width: '500px'
                }).then(function(result) {
                    if (result.isConfirmed) {
                        console.log('Deleting user with ID:', userId);
                        
                        // Send delete request via form submission
                        const form = $('<form>', {
                            method: 'POST',
                            action: baseUrl + 'delete-user'
                        });
                        
                        $('<input>', {
                            type: 'hidden',
                            name: 'user_id',
                            value: userId
                        }).appendTo(form);
                        
                        form.appendTo('body').submit();
                    }
                });
            } else {
                if (confirm('Are you sure you want to delete user "' + userId + '"?')) {
                    console.log('Deleting user with ID:', userId);
                    
                    // Send delete request via form submission
                    const form = $('<form>', {
                        method: 'POST',
                        action: baseUrl + 'delete-user'
                    });
                    
                    $('<input>', {
                        type: 'hidden',
                        name: 'user_id',
                        value: userId
                    }).appendTo(form);
                    
                    form.appendTo('body').submit();
                }
            }
        }
        
        // Export to Excel
        function exportToExcel() {
            console.log('Exporting users to Excel...');
            window.location.href = baseUrl + 'export-user';
        }
        
        // Show alert message
        function showAlert(message, type) {
            const alertContainer = $('#alertContainer');
            
            // Clear any existing alerts
            alertContainer.empty();
            
            let iconClass = 'info-circle';
            if (type === 'success') {
                iconClass = 'check-circle';
            } else if (type === 'error') {
                iconClass = 'exclamation-circle';
            }
            
            const alert = $(
                '<div class="alert alert-' + type + '">' +
                    '<i class="fas fa-' + iconClass + '"></i>' +
                    '<span>' + message + '</span>' +
                '</div>'
            );
            alertContainer.append(alert);
            
            // Remove alert after 5 seconds
            setTimeout(function() {
                alert.fadeOut(500, function() {
                    $(this).remove();
                });
            }, 5000);
        }
        
        // Refresh data
        function refreshData() {
            console.log('Refreshing data...');
            currentPage = 1;
            clearFilters();
            loadUsers();
            showAlert('Data refreshed successfully!', 'success');
        }
        
        // Navigation function
        function goBackToDashboard() {
            window.location.href = baseUrl + 'home';
        }
        
        function logout() {
            if (typeof Swal !== 'undefined') {
                Swal.fire({
                    title: 'Logout',
                    text: 'Are you sure you want to logout?',
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Yes, logout!',
                    cancelButtonText: 'Cancel'
                }).then(function(result) {
                    if (result.isConfirmed) {
                        window.location.href = baseUrl + 'logout';
                    }
                });
            } else {
                if (confirm('Are you sure you want to logout?')) {
                    window.location.href = baseUrl + 'logout';
                }
            }
        }
    </script>
</body>
</html>