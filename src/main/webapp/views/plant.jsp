<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Plant Management - CAPEX System</title>
    
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

        /* Plant Form Modal */
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
                <p>Plant Management</p>
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
                <i class="fas fa-industry"></i>
                <div>
                    <h2>Plant Management</h2>
                    <p style="font-size: 14px; color: #666; margin-top: 5px;">Manage plant/facility information</p>
                </div>
            </div>
            
            <div class="action-buttons">
                <button class="btn btn-secondary" onclick="refreshData()">
                    <i class="fas fa-sync-alt"></i> Refresh
                </button>
                <button class="btn btn-primary" onclick="openAddPlantModal()">
                    <i class="fas fa-plus"></i> Add New Plant
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
                <div class="table-title">Plant List</div>
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search plants..." onkeyup="searchPlants()">
                </div>
            </div>
            
            <table class="table" id="plantTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Location</th>
                        <th>SBU</th>
                        <th>Plant Code</th>
                        <th>Plant Name</th>
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
                                <p>Loading plants...</p>
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

    <!-- Add/Edit Plant Modal -->
    <div class="modal-overlay" id="plantModal">
        <div class="modal">
            <div class="modal-header">
                <h3><i class="fas fa-industry"></i> <span id="modalTitle">Add New Plant</span></h3>
                <button class="modal-close" onclick="closePlantModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="plantForm" onsubmit="savePlant(event)">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="location">Location <span>*</span></label>
                            <input type="text" id="location" name="location" required 
                                   placeholder="Enter location (e.g., City, State)" maxlength="100">
                            <small style="color: #666; font-size: 12px; margin-top: 5px; display: block;">
                                Physical location of the plant
                            </small>
                        </div>
                        
                        <div class="form-group">
                            <label for="sbu">SBU <span>*</span></label>
                            <select id="sbu" name="sbu" required>
                                <option value="">Select SBU</option>
                                <!-- SBU options will be populated dynamically -->
                            </select>
                            <small style="color: #666; font-size: 12px; margin-top: 5px; display: block;">
                                Strategic Business Unit this plant belongs to
                            </small>
                        </div>
                    </div>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="plant_code">Plant Code <span>*</span></label>
                            <input type="text" id="plant_code" name="plant_code" required 
                                   placeholder="Enter plant code (e.g., PLANT-001)" maxlength="50">
                            <small style="color: #666; font-size: 12px; margin-top: 5px; display: block;">
                                Unique identifier for the plant
                            </small>
                        </div>
                        
                        <div class="form-group">
                            <label for="plant_name">Plant Name <span>*</span></label>
                            <input type="text" id="plant_name" name="plant_name" required 
                                   placeholder="Enter plant name" maxlength="100">
                            <small style="color: #666; font-size: 12px; margin-top: 5px; display: block;">
                                Full name of the plant/facility
                            </small>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="status">Status <span>*</span></label>
                        <select id="status" name="status" required>
                            <option value="">Select Status</option>
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                        <small style="color: #666; font-size: 12px; margin-top: 5px; display: block;">
                            Active plants will be available for selection in other modules
                        </small>
                    </div>
                    
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="closePlantModal()">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save"></i> Save Plant
                        </button>
                    </div>
                    
                    <input type="hidden" id="plant_id" name="id" value="">
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
        let plants = [];

        // Initialize the page
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Plant Management Page loaded');
            loadPlants();
            loadSBUOptions();
            initEventListeners();
        });

        // Initialize event listeners
        function initEventListeners() {
            // Close modal when clicking outside
            document.getElementById('plantModal').addEventListener('click', function(e) {
                if (e.target === this) {
                    closePlantModal();
                }
            });
        }

        // Load plants from server
        function loadPlants() {
            console.log('Loading plants...');
            showLoading();
            
            $.ajax({
                url: baseUrl + '/ajax/getPlantList',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    console.log('Plants loaded:', data);
                    plants = data || [];
                    populateTable(plants);
                },
                error: function(xhr, status, error) {
                    console.error('Error loading plants:', error);
                    showAlert('Error loading plants. Please try again.', 'error');
                    showNoData();
                }
            });
        }

        // Load SBU options for dropdown
        function loadSBUOptions() {
            console.log('Loading SBU options...');
            
            $.ajax({
                url: baseUrl + '/ajax/getActiveSBUs',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    const sbuSelect = document.getElementById('sbu');
                    sbuSelect.innerHTML = '<option value="">Select SBU</option>';
                    
                    data.forEach(function(sbu) {
                        if (sbu.sbu) {
                            const option = document.createElement('option');
                            option.value = sbu.sbu;
                            option.textContent = sbu.sbu + ' - ' + (sbu.sbu_name || '');
                            sbuSelect.appendChild(option);
                        }
                    });
                },
                error: function(xhr, status, error) {
                    console.error('Error loading SBU options:', error);
                    showAlert('Error loading SBU options', 'error');
                }
            });
        }

        // Populate table with data
   // Populate table with data
function populateTable(plants) {
    console.log('Populating table with', plants.length, 'plants');
    const tableBody = document.getElementById('tableBody');
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    
    // Filter plants based on search
    let filteredPlants = plants || [];
    if (searchTerm) {
        filteredPlants = plants.filter(function(plant) {
            return (plant.location && plant.location.toLowerCase().includes(searchTerm)) ||
                   (plant.sbu && plant.sbu.toLowerCase().includes(searchTerm)) ||
                   (plant.plant_code && plant.plant_code.toLowerCase().includes(searchTerm)) ||
                   (plant.plant_name && plant.plant_name.toLowerCase().includes(searchTerm)) ||
                   (plant.status && plant.status.toLowerCase().includes(searchTerm));
        });
    }
    
    // ADD THIS: Sort by ID in ascending order (newest at bottom)
    filteredPlants.sort(function(a, b) {
        // Convert IDs to numbers if they are numeric
        const idA = parseInt(a.id) || 0;
        const idB = parseInt(b.id) || 0;
        return idA - idB; // Ascending order (oldest first, newest last)
    });
    
    // Calculate pagination
    const totalPages = Math.ceil(filteredPlants.length / itemsPerPage);
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const pagePlants = filteredPlants.slice(startIndex, endIndex);
    
    // Clear table
    tableBody.innerHTML = '';
    
    if (pagePlants.length === 0) {
        showNoData(searchTerm);
    } else {
        // Add rows
        pagePlants.forEach(function(plant, index) {
            const row = document.createElement('tr');
            
            // Determine status class
            const statusClass = (plant.status === 'Active') ? 'status-active' : 'status-inactive';
            const statusText = plant.status || 'Inactive';
            
            // Calculate row number based on all filtered plants
            const rowNumber = startIndex + index + 1;
            
            row.innerHTML = 
                '<td>' + rowNumber + '</td>' + // Changed from plant.id to row number
                '<td>' + (plant.location || 'N/A') + '</td>' +
                '<td>' + (plant.sbu || 'N/A') + '</td>' +
                '<td>' + (plant.plant_code || 'N/A') + '</td>' +
                '<td>' + (plant.plant_name || 'N/A') + '</td>' +
                '<td>' +
                    '<span class="' + statusClass + '">' + statusText + '</span>' +
                '</td>' +
                '<td>' +
                    '<div class="action-icons">' +
                        '<button class="action-btn edit-btn" onclick="editPlant(\'' + plant.id + '\')" title="Edit">' +
                            '<i class="fas fa-edit"></i>' +
                        '</button>' +
                        '<button class="action-btn delete-btn" onclick="deletePlant(\'' + plant.id + '\')" title="Delete">' +
                            '<i class="fas fa-trash"></i>' +
                        '</button>' +
                    '</div>' +
                '</td>';
            tableBody.appendChild(row);
        });
    }
    
    // Update pagination
    updatePagination(filteredPlants.length, totalPages);
}

        // Show loading state
        function showLoading() {
            const tableBody = document.getElementById('tableBody');
            tableBody.innerHTML = 
                '<tr>' +
                    '<td colspan="7" style="text-align: center; padding: 40px;">' +
                        '<div style="color: #999; font-size: 16px;">' +
                            '<i class="fas fa-spinner fa-spin" style="font-size: 48px; margin-bottom: 15px;"></i>' +
                            '<p>Loading plants...</p>' +
                        '</div>' +
                    '</td>' +
                '</tr>';
        }

        // Show no data message
        function showNoData(searchTerm) {
            const tableBody = document.getElementById('tableBody');
            const message = searchTerm ? 
                'No plants found matching your search. Try a different search or add a new plant.' :
                'No plant data available. Click "Add New Plant" to get started.';
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
                    populateTable(plants);
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
                        populateTable(plants);
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
                    populateTable(plants);
                }
            };
            pagination.appendChild(nextBtn);
            
            // Page info
            const pageInfo = document.createElement('span');
            pageInfo.className = 'page-info';
            const start = ((currentPage - 1) * itemsPerPage) + 1;
            const end = Math.min(currentPage * itemsPerPage, totalItems);
            pageInfo.textContent = 'Showing ' + start + ' to ' + end + ' of ' + totalItems + ' plants';
            pagination.appendChild(pageInfo);
        }

        // Search plants
        function searchPlants() {
            currentPage = 1;
            populateTable(plants);
        }

        // Open modal for adding new plant
        function openAddPlantModal() {
            console.log('Opening add plant modal');
            document.getElementById('modalTitle').textContent = 'Add New Plant';
            
            // Reset form
            document.getElementById('plantForm').reset();
            document.getElementById('plant_id').value = '';
            
            // Set default status
            document.getElementById('status').value = 'Active';
            
            // Show modal
            const modal = document.getElementById('plantModal');
            modal.classList.add('active');
            modal.style.display = 'flex';
            
            console.log('Modal should be visible now');
        }

        // Open modal for editing plant
        function editPlant(id) {
            console.log('Editing plant with ID:', id);
            
            $.ajax({
                url: baseUrl + '/ajax/getPlantById/' + id,
                type: 'GET',
                dataType: 'json',
                success: function(plant) {
                    if (plant) {
                        console.log('Plant data received:', plant);
                        document.getElementById('modalTitle').textContent = 'Edit Plant';
                        document.getElementById('plant_id').value = plant.id || '';
                        document.getElementById('location').value = plant.location || '';
                        document.getElementById('sbu').value = plant.sbu || '';
                        document.getElementById('plant_code').value = plant.plant_code || '';
                        document.getElementById('plant_name').value = plant.plant_name || '';
                        document.getElementById('status').value = plant.status || 'Active';
                        
                        // Show modal
                        const modal = document.getElementById('plantModal');
                        modal.classList.add('active');
                        modal.style.display = 'flex';
                    } else {
                        showAlert('Plant not found', 'error');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error loading plant details:', error);
                    showAlert('Error loading plant details', 'error');
                }
            });
        }

        // Close modal
        function closePlantModal() {
            console.log('Closing modal');
            const modal = document.getElementById('plantModal');
            modal.classList.remove('active');
            modal.style.display = 'none';
            document.getElementById('plantForm').reset();
        }

        // Save plant (Add/Edit)
        function savePlant(event) {
            event.preventDefault();
            console.log('Saving plant...');
            
            // Get form data
            const formData = {
                id: document.getElementById('plant_id').value,
                location: document.getElementById('location').value,
                sbu: document.getElementById('sbu').value,
                plant_code: document.getElementById('plant_code').value,
                plant_name: document.getElementById('plant_name').value,
                status: document.getElementById('status').value
            };
            
            console.log('Form data to save:', formData);
            
            // Determine URL based on add/edit
            let url, method;
            if (formData.id) {
                url = baseUrl + '/plant/update';
                method = 'POST';
            } else {
                url = baseUrl + '/plant/add';
                method = 'POST';
            }
            
            console.log('Sending to:', url, 'with method:', method);
            
            // Send AJAX request
            $.ajax({
                url: url,
                type: method,
                data: formData,
                success: function(response) {
                    console.log('Save successful:', response);
                    showAlert(formData.id ? 'Plant updated successfully!' : 'Plant added successfully!', 'success');
                    closePlantModal();
                    
                    // Reload data after a short delay to ensure server processed
                    setTimeout(function() {
                        loadPlants();
                    }, 500);
                },
                error: function(xhr, status, error) {
                    console.error('Error saving plant:', error);
                    console.error('Response text:', xhr.responseText);
                    showAlert('Error saving plant. Please check all fields and try again.', 'error');
                }
            });
        }

        // Delete plant
        function deletePlant(id) {
            if (confirm('Are you sure you want to delete this plant?')) {
                console.log('Deleting plant with ID:', id);
                
                $.ajax({
                    url: baseUrl + '/plant/delete/' + id,
                    type: 'POST',
                    success: function(response) {
                        console.log('Delete successful:', response);
                        showAlert('Plant deleted successfully!', 'success');
                        
                        // Reload data
                        setTimeout(function() {
                            loadPlants();
                        }, 300);
                    },
                    error: function(xhr, status, error) {
                        console.error('Error deleting plant:', error);
                        showAlert('Error deleting plant', 'error');
                    }
                });
            }
        }

        // Show alert message
        function showAlert(message, type) {
            const alertContainer = document.getElementById('alertContainer');
            
            // Clear any existing alerts
            alertContainer.innerHTML = '';
            
            const alert = document.createElement('div');
            alert.className = 'alert alert-' + type;
            alert.innerHTML = 
                '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i>' +
                '<span>' + message + '</span>';
            alertContainer.appendChild(alert);
            
            // Remove alert after 5 seconds
            setTimeout(function() {
                if (alert.parentNode === alertContainer) {
                    alert.remove();
                }
            }, 5000);
        }

        // Refresh data
        function refreshData() {
            console.log('Refreshing data...');
            currentPage = 1;
            document.getElementById('searchInput').value = '';
            loadPlants();
            showAlert('Data refreshed successfully!', 'success');
        }

        // Navigation function
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
                closePlantModal();
            }
            
            // Ctrl + N for new plant
            if (e.ctrlKey && e.key === 'n') {
                e.preventDefault();
                openAddPlantModal();
            }
        });
    </script>
</body>
</html>
