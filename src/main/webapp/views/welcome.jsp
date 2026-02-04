<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    // Store context path in a JavaScript variable
    String contextPath = request.getContextPath();
    if (contextPath == null) {
        contextPath = "";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Capital Expenditure Management System</title>
    
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

        /* Master Button in Header - Dropdown Style */
        .master-btn-header {
            position: relative;
            margin-left: auto;
            margin-right: 20px;
        }

        .master-header-btn {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.2);
            display: inline-flex;
            align-items: center;
            gap: 10px;
            min-width: 200px;
            justify-content: center;
        }

        .master-header-btn:hover {
            background: linear-gradient(135deg, #2980b9 0%, #2573a7 100%);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.3);
        }

        .master-header-btn i {
            font-size: 18px;
        }

        .master-dropdown {
            position: absolute;
            top: 100%;
            left: 0;
            width: 300px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            margin-top: 10px;
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: all 0.3s ease;
            z-index: 1001;
            border: 1px solid #eaeaea;
            overflow: hidden;
        }

        .master-dropdown.active {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .dropdown-header {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 20px;
            text-align: center;
        }

        .dropdown-header h3 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .dropdown-header p {
            font-size: 12px;
            opacity: 0.8;
        }

        .dropdown-menu {
            max-height: 400px;
            overflow-y: auto;
            padding: 10px 0;
        }

        .dropdown-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 20px;
            text-decoration: none;
            color: #333;
            transition: all 0.2s ease;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
        }

        .dropdown-item:last-child {
            border-bottom: none;
        }

        .dropdown-item:hover {
            background: #f8f9fa;
            padding-left: 25px;
        }

        .dropdown-item i {
            width: 24px;
            text-align: center;
            color: #3498db;
            font-size: 18px;
        }

        .dropdown-item .item-content {
            flex: 1;
        }

        .dropdown-item .item-title {
            font-weight: 600;
            font-size: 15px;
            color: #2c3e50;
            margin-bottom: 3px;
        }

        .dropdown-item .item-desc {
            font-size: 12px;
            color: #666;
            line-height: 1.4;
        }

        /* Main Content */
        .main-content {
            max-width: 1200px;
            margin: 50px auto;
            padding: 0 20px;
            text-align: center;
        }

        .welcome-card {
            background: white;
            border-radius: 15px;
            padding: 50px 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
        }

        .welcome-card h2 {
            font-size: 36px;
            color: #2c3e50;
            margin-bottom: 15px;
        }

        .welcome-card p {
            font-size: 18px;
            color: #666;
            max-width: 800px;
            margin: 0 auto 30px;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-top: 40px;
        }

        .feature-card {
            background: white;
            border-radius: 12px;
            padding: 30px 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-align: center;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        .feature-icon {
            font-size: 48px;
            color: #3498db;
            margin-bottom: 20px;
        }

        .feature-card h3 {
            font-size: 20px;
            color: #2c3e50;
            margin-bottom: 10px;
        }

        .feature-card p {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
        }

        /* Debug Button (Optional - can be removed in production) */
        .debug-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #e74c3c;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 50px;
            cursor: pointer;
            font-size: 12px;
            z-index: 9999;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        .debug-btn:hover {
            background: #c0392b;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .master-btn-header {
                margin-right: 10px;
            }
            
            .master-header-btn {
                min-width: 180px;
                padding: 10px 20px;
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

            .master-btn-header {
                margin: 10px auto;
                order: 3;
                width: 100%;
            }

            .master-header-btn {
                width: 100%;
                min-width: unset;
            }

            .master-dropdown {
                left: 50%;
                transform: translateX(-50%) translateY(-10px);
                width: 90%;
                max-width: 300px;
            }

            .master-dropdown.active {
                transform: translateX(-50%) translateY(0);
            }

            .user-info {
                order: 2;
                flex-wrap: wrap;
                justify-content: center;
            }

            .main-content {
                margin: 30px auto;
                padding: 0 15px;
            }

            .welcome-card {
                padding: 30px 20px;
            }

            .welcome-card h2 {
                font-size: 28px;
            }

            .welcome-card p {
                font-size: 16px;
            }
        }

        @media (max-width: 480px) {
            .master-dropdown {
                width: 95%;
            }
            
            .features-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body data-context-path="<%= contextPath %>">
    <!-- Header -->
    <header class="welcome-header">
        <div class="welcome-header-content">
            <div class="welcome-icon">
                <img src="https://cdn-icons-png.flaticon.com/512/201/201623.png" alt="CAPEX Logo">
            </div>
            <div>
                <h1>CAPEX Management System</h1>
                <p>Welcome to Capital Expenditure Management Portal</p>
            </div>
        </div>
        
        <!-- Master Button with Dropdown in Header -->
        <div class="master-btn-header">
            <button class="master-header-btn" onclick="toggleMasterDropdown()">
                <i class="fas fa-plus-circle"></i> Master Actions
                <i class="fas fa-chevron-down" style="font-size: 14px; margin-left: auto;"></i>
            </button>
            
            <div class="master-dropdown" id="masterDropdown">
                <div class="dropdown-header">
                    <h3>Master Data Management</h3>
                    <p>Manage system configuration</p>
                </div>
                
                <div class="dropdown-menu">
                    <!-- Department -->
                    <div class="dropdown-item" data-url="/department">
                        <i class="fas fa-building"></i>
                        <div class="item-content">
                            <div class="item-title">Department Management</div>
                            <div class="item-desc">Manage organizational departments</div>
                        </div>
                    </div>
                    
                    <!-- SBU -->
                    <div class="dropdown-item" data-url="/sbu">
                        <i class="fas fa-sitemap"></i>
                        <div class="item-content">
                            <div class="item-title">SBU Management</div>
                            <div class="item-desc">Manage Strategic Business Units</div>
                        </div>
                    </div>
                    
                    <!-- Plant -->
                    <div class="dropdown-item" data-url="/plant">
                        <i class="fas fa-industry"></i>
                        <div class="item-content">
                            <div class="item-title">Plant Management</div>
                            <div class="item-desc">Manage plant/facility information</div>
                        </div>
                    </div>
                    
                    <!-- Location -->
                    <div class="dropdown-item" data-url="/location">
                        <i class="fas fa-map-marker-alt"></i>
                        <div class="item-content">
                            <div class="item-title">Location Management</div>
                            <div class="item-desc">Add, edit, or delete locations</div>
                        </div>
                    </div>
                    
                    <!-- User Profile -->
                    <div class="dropdown-item" data-url="/user-profile">
                        <i class="fas fa-user-cog"></i>
                        <div class="item-content">
                            <div class="item-title">User Profile Management</div>
                            <div class="item-desc">Manage user accounts and permissions</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="user-info">
            <span><i class="fas fa-user-circle"></i> ${sessionScope.USER_NAME}</span>
            <button onclick="logout()"><i class="fas fa-sign-out-alt"></i> Logout</button>
        </div>
    </header>

    <!-- Main Content -->
    <div class="main-content">
        <div class="welcome-card">
            <h2>Welcome to CAPEX Management System</h2>
            <p>Manage your capital expenditures efficiently with our comprehensive management system. 
               Track, approve, and monitor all capital expenditure requests in one place.</p>
        </div>
        
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h3>Budget Tracking</h3>
                <p>Monitor and track capital expenditure budgets across departments and projects.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-file-invoice-dollar"></i>
                </div>
                <h3>Expense Management</h3>
                <p>Create, submit, and approve capital expenditure requests with automated workflows.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-tasks"></i>
                </div>
                <h3>Project Management</h3>
                <p>Manage capital projects from initiation to completion with detailed tracking.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-chart-pie"></i>
                </div>
                <h3>Reporting & Analytics</h3>
                <p>Generate detailed reports and gain insights into capital expenditure patterns.</p>
            </div>
        </div>
    </div>

    <!-- Debug Button (Optional) -->
    <button class="debug-btn" onclick="debugURLs()">
        <i class="fas fa-bug"></i> Debug URLs
    </button>

    <!-- JavaScript Functions -->
    <script>
        // Global context path
        const CONTEXT_PATH = '<%= contextPath %>';
        console.log('Context Path:', CONTEXT_PATH);
        
        // Master Dropdown Functions
        function toggleMasterDropdown() {
            const dropdown = document.getElementById('masterDropdown');
            dropdown.classList.toggle('active');
        }
        
        function closeMasterDropdown() {
            const dropdown = document.getElementById('masterDropdown');
            dropdown.classList.remove('active');
        }
        
        // Enhanced Navigation Function
        function navigateTo(path) {
            try {
                // Ensure path starts with /
                const cleanPath = path.startsWith('/') ? path : '/' + path;
                
                // Build full URL with context path
                let fullUrl;
                if (CONTEXT_PATH && CONTEXT_PATH !== '') {
                    fullUrl = CONTEXT_PATH + cleanPath;
                } else {
                    fullUrl = cleanPath;
                }
                
                console.log('Navigating to full URL:', fullUrl);
                console.log('Path:', path);
                console.log('Context Path:', CONTEXT_PATH);
                
                // Close dropdown first
                closeMasterDropdown();
                
                // Small delay to ensure dropdown closes
                setTimeout(() => {
                    window.location.href = fullUrl;
                }, 100);
                
            } catch (error) {
                console.error('Navigation error:', error);
                alert('Error navigating to page: ' + error.message);
            }
        }
        
        // Direct navigation functions
        function managePlant() {
            navigateTo('/plant');
        }
        
        function manageDepartment() {
            navigateTo('/department');
        }
        
        function manageSBU() {
            navigateTo('/sbu');
        }
        
        function manageLocation() {
            navigateTo('/location');
        }
        
        function manageUserProfile() {
            navigateTo('/user-profile');
        }
        
        function logout() {
            if (confirm("Are you sure you want to logout?")) {
                navigateTo('/logout');
            }
        }
        
        // Debug function to check URLs
        function debugURLs() {
            console.log("=== URL DEBUG INFORMATION ===");
            console.log("Current URL:", window.location.href);
            console.log("Context Path:", CONTEXT_PATH);
            console.log("Session User:", '${sessionScope.USER_NAME}');
            
            // Test URLs
            const testPaths = ['/plant', '/department', '/sbu', '/location', '/user-profile', '/logout'];
            
            testPaths.forEach(path => {
                let testUrl;
                if (CONTEXT_PATH && CONTEXT_PATH !== '') {
                    testUrl = CONTEXT_PATH + path;
                } else {
                    testUrl = path;
                }
                
                console.log(`Testing URL: ${testUrl}`);
                
                // Try to fetch to see if URL exists
                fetch(testUrl, { method: 'HEAD' })
                    .then(response => {
                        console.log(`URL ${testUrl}: ${response.status} ${response.statusText}`);
                    })
                    .catch(error => {
                        console.log(`URL ${testUrl}: ERROR - ${error.message}`);
                    });
            });
            
            alert("Check browser console for URL debug information.");
        }

        // Close dropdown when clicking outside
        document.addEventListener('click', function(event) {
            const dropdown = document.getElementById('masterDropdown');
            const button = document.querySelector('.master-header-btn');
            
            if (dropdown && button && !dropdown.contains(event.target) && !button.contains(event.target)) {
                dropdown.classList.remove('active');
            }
        });

        // Set up event listeners for dropdown items
        document.addEventListener('DOMContentLoaded', function() {
            console.log("CAPEX Welcome Page Loaded");
            console.log("User:", '${sessionScope.USER_NAME}');
            
            // Add click event listeners to all dropdown items
            const dropdownItems = document.querySelectorAll('.dropdown-item[data-url]');
            dropdownItems.forEach(item => {
                item.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    
                    const url = this.getAttribute('data-url');
                    console.log('Dropdown item clicked, URL:', url);
                    navigateTo(url);
                });
            });
            
            // Test if plant navigation works immediately
            console.log('Testing plant navigation function...');
            console.log('managePlant function:', typeof managePlant);
            
            // Ensure dropdown is closed on page load
            closeMasterDropdown();
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Alt + M to open master dropdown
            if (e.altKey && e.key === 'm') {
                e.preventDefault();
                toggleMasterDropdown();
            }
            
            // Escape to close dropdown
            if (e.key === 'Escape') {
                closeMasterDropdown();
            }
            
            // Alt + S for SBU (shortcut)
            if (e.altKey && e.key === 's') {
                e.preventDefault();
                navigateTo('/sbu');
            }
            
            // Alt + D for Department (shortcut)
            if (e.altKey && e.key === 'd') {
                e.preventDefault();
                navigateTo('/department');
            }
            
            // Alt + P for Plant (shortcut)
            if (e.altKey && e.key === 'p') {
                e.preventDefault();
                navigateTo('/plant');
            }
            
            // Alt + L for Location (shortcut)
            if (e.altKey && e.key === 'l') {
                e.preventDefault();
                navigateTo('/location');
            }
            
            // Alt + U for User Profile (shortcut)
            if (e.altKey && e.key === 'u') {
                e.preventDefault();
                navigateTo('/user-profile');
            }
        });
    </script>
</body>
</html>