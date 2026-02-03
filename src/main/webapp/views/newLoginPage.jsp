<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Capex Management - Login</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <!-- Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!-- Font Awesome -->
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
            background: linear-gradient(135deg, #000000, #E5242C);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow-x: hidden;
        }

        .login-container {
            display: flex;
            width: 90%;
            max-width: 1200px;
            min-height: 85vh;
          
            border-radius: 24px;
           
            overflow: hidden;
            position: relative;
        }

        /* Bubbles Animation */
        .bubbles {
            position: absolute;
            width: 100%;
            height: 100%;
            z-index: 1;
            overflow: hidden;
            border-radius: 24px;
        }

        .bubbles span {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            animation: float 15s infinite linear;
        }

        .bubbles span:nth-child(1) {
            width: 80px;
            height: 80px;
            left: 10%;
            animation-duration: 20s;
        }

        .bubbles span:nth-child(2) {
            width: 100px;
            height: 100px;
            left: 20%;
            animation-duration: 15s;
            animation-delay: 2s;
        }

        .bubbles span:nth-child(3) {
            width: 60px;
            height: 60px;
            left: 30%;
            animation-duration: 18s;
            animation-delay: 4s;
        }

        .bubbles span:nth-child(4) {
            width: 90px;
            height: 90px;
            left: 40%;
            animation-duration: 22s;
            animation-delay: 1s;
        }

        .bubbles span:nth-child(5) {
            width: 70px;
            height: 70px;
            left: 50%;
            animation-duration: 17s;
            animation-delay: 3s;
        }

        .bubbles span:nth-child(6) {
            width: 85px;
            height: 85px;
            left: 60%;
            animation-duration: 19s;
            animation-delay: 5s;
        }

        .bubbles span:nth-child(7) {
            width: 95px;
            height: 95px;
            left: 70%;
            animation-duration: 21s;
            animation-delay: 2s;
        }

        .bubbles span:nth-child(8) {
            width: 65px;
            height: 65px;
            left: 80%;
            animation-duration: 16s;
            animation-delay: 6s;
        }

        .bubbles span:nth-child(9) {
            width: 75px;
            height: 75px;
            left: 90%;
            animation-duration: 20s;
            animation-delay: 3s;
        }

        @keyframes float {
            0% {
                transform: translateY(100vh) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(-100px) rotate(360deg);
                opacity: 0;
            }
        }

        /* Left Illustration */
        .login-illustration {
            flex: 1;
            padding: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            z-index: 2;
        }

        .login-illustration img {
            max-width: 119%;
            max-height: 135vh;
            object-fit: contain;
            filter: drop-shadow(0 10px 20px rgba(102, 126, 234, 0.2));
            /* animation: float-image 6s ease-in-out infinite; */
        }

        @keyframes float-image {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-20px);
            }
        }

        /* Right Login Form */
        .login-form-section {
            flex: 1;
            padding: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            z-index: 2;
        }

        .login-card {
        width: 100%;
    max-width: 425px;
    padding: 27px;
    background: white;
    /* border-radius: 20px; */
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .logo-container {
            display: flex;
            justify-content: center;
            margin-bottom: 24px;
        }

        .login-logo {
            height: 80px;
            width: auto;
            filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.1));
        }

        .title-container {
            text-align: center;
            margin-bottom: 32px;
        }

        .login-title {
            font-size: 28px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 8px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .login-subtitle {
            font-size: 14px;
            color: #718096;
            font-weight: 400;
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 24px;
        }

        .input-container {
            position: relative;
            background: #f7fafc;
            border-radius: 12px;
            padding: 16px;
            border: 2px solid #e2e8f0;
            transition: all 0.3s ease;
        }

        .input-container:focus-within {
            border-color: #667eea;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-input {
            width: 100%;
            border: none;
            background: transparent;
            font-size: 16px;
            color: #2d3748;
            outline: none;
            padding-left: 8px;
        }

        .form-input::placeholder {
            color: #a0aec0;
        }

        .input-label {
            position: absolute;
            left: 56px;
            top: 50%;
            transform: translateY(-50%);
            color: #718096;
            font-size: 16px;
            transition: all 0.3s ease;
            pointer-events: none;
            background: transparent;
            padding: 0 4px;
        }

        .form-input:focus + .input-label,
        .form-input:not(:placeholder-shown) + .input-label {
            top: 0;
            font-size: 12px;
            color: #667eea;
            background: #fff;
        }

        .input-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
            font-size: 20px;
        }

        .input-icon-right {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
            font-size: 20px;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .input-icon-right:hover {
            color: #667eea;
        }

        /* Alert Styles */
        .alert {
            padding: 16px;
            border-radius: 12px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideIn 0.3s ease;
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

        .error-alert {
            background: #fed7d7;
            color: #9b2c2c;
            border-left: 4px solid #e53e3e;
        }

        .success-alert {
            background: #c6f6d5;
            color: #22543d;
            border-left: 4px solid #38a169;
        }

        .alert i {
            font-size: 20px;
        }

        /* Login Button */
        .login-button {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 12px;
            transition: all 0.3s ease;
            margin-top: 24px;
        }

        .login-button:hover {
            transform: translateY(-2px);
            box-shadow: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .login-button:active {
            transform: translateY(0);
        }

        .login-button i {
            font-size: 20px;
        }

        /* Form Footer */
        .form-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 24px;
            padding-top: 16px;
            border-top: 1px solid #e2e8f0;
        }

        .forgot-link {
            color: #667eea;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        .forgot-link:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .help-link {
            color: #718096;
            text-decoration: none;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: color 0.3s ease;
        }

        .help-link:hover {
            color: #667eea;
        }

        /* Copyright */
        .copyright {
            text-align: center;
            margin-top: 32px;
            color: #a0aec0;
            font-size: 12px;
            padding-top: 20px;
            border-top: 1px solid #edf2f7;
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
            z-index: 1000;
            flex-direction: column;
            color: white;
        }

        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 4px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: #667eea;
            animation: spin 1s ease-in-out infinite;
            margin-bottom: 20px;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .login-container {
                flex-direction: column;
                width: 95%;
                min-height: auto;
            }
            
            .login-illustration {
                padding: 30px;
            }
            
            .login-illustration img {
                max-height: 300px;
            }
            
            .login-form-section {
                padding: 30px;
            }
            
            .login-card {
                padding: 30px;
            }
        }

        @media (max-width: 576px) {
            .login-container {
                width: 100%;
                min-height: 100vh;
                border-radius: 0;
            }
            
            .login-illustration {
                padding: 20px;
                min-height: 200px;
            }
            
            .login-illustration img {
                max-height: 200px;
            }
            
            .login-form-section {
                padding: 20px;
            }
            
            .login-card {
                padding: 24px;
                box-shadow: none;
            }
            
            .login-title {
                font-size: 24px;
            }
            
            .form-footer {
                flex-direction: column;
                gap: 12px;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <!-- Floating background bubbles -->
        <div class="bubbles">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
        </div>

        <!-- Left Illustration -->
        <div class="login-illustration">
            <img src="/capex/resources/images/sidelogo.png" alt="Capex Management">
        </div>

        <!-- Right Login Card -->
        <div class="login-form-section">
            <div class="login-card" id="loginCard">
                <!-- Logo -->
                <div class="logo-container">
                    <img src="/capex/resources/images/Ramky-Logo.png" alt="Capex Logo" class="login-logo">
                </div>

                <div class="title-container">
                    <h2 class="login-title">Capex Management</h2>
                    <p class="login-subtitle">Capital Expenditure Control Panel</p>
                </div>

                <!-- Login Form -->
                <form id="loginForm" method="POST" action="<%= request.getContextPath() %>/login">
                    <div class="form-group">
                        <div class="input-container">
                           <!--  <i class="material-icons input-icon">person</i> -->
                            <input 
                                type="text" 
                                id="username" 
                                name="username" 
                                class="form-input" 
                                placeholder=""
                                required>
                            <label for="username" class="input-label">Username</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-container">
                            <!-- <i class="material-icons input-icon">lock</i> -->
                            <input 
                                type="password" 
                                id="password" 
                                name="password" 
                                class="form-input" 
                                placeholder=""
                                required>
                            <label for="password" class="input-label">Password</label>
                            <i class="material-icons input-icon-right" id="togglePassword">visibility_off</i>
                        </div>
                    </div>

                    <!-- Error Message -->
                    <div id="errorAlert" class="alert error-alert" style="display: none;">
                        <i class="material-icons">error</i>
                        <span id="errorMessage"></span>
                    </div>

                    <!-- Success Message -->
                    <div id="successAlert" class="alert success-alert" style="display: none;">
                        <i class="material-icons">check_circle</i>
                        <span id="successMessage"></span>
                    </div>

                    <!-- Server-side error from JSP -->
                    <% 
                        String error = (String) request.getAttribute("error");
                        String success = (String) request.getAttribute("success");
                        
                        if (error != null && !error.isEmpty()) {
                    %>
                        <div class="alert error-alert">
                            <i class="material-icons">error</i>
                            <span><%= error %></span>
                        </div>
                    <% 
                        } 
                        if (success != null && !success.isEmpty()) {
                    %>
                        <div class="alert success-alert">
                            <i class="material-icons">check_circle</i>
                            <span><%= success %></span>
                        </div>
                    <% } %>

                    <button type="submit" class="login-button" id="loginButton">
                        <i class="material-icons">login</i>
                        <span>Login</span>
                    </button>

                   <!--  <div class="form-footer">
                        <a href="#" class="forgot-link">Forgot Password?</a>
                        <a href="#" class="help-link">
                            <i class="material-icons">help</i>
                            Need Help?
                        </a>
                    </div> -->
                </form>

                <p class="copyright">
                    © <span id="currentYear"></span> Capex Financial System
                </p>
            </div>
        </div>
    </div>

    <!-- Loading Overlay -->
    <div id="loadingOverlay" class="loading-overlay">
        <div class="loading-spinner"></div>
        <p>Authenticating...</p>
    </div>

    <script>
        $(document).ready(function() {
            // Initialize current year
            $('#currentYear').text(new Date().getFullYear());
            
            // Password visibility toggle
            $('#togglePassword').click(function() {
                const passwordInput = $('#password');
                const type = passwordInput.attr('type') === 'password' ? 'text' : 'password';
                passwordInput.attr('type', type);
                
                // Toggle icon
                $(this).text(type === 'password' ? 'visibility_off' : 'visibility');
            });
            
            // Form submission with AJAX
            $('#loginForm').submit(function(e) {
                e.preventDefault();
                
                const username = $('#username').val().trim();
                const password = $('#password').val().trim();
                
                // Clear previous errors
                hideAlerts();
                
                // Validation
                if (!username || !password) {
                    showError('Please fill in all fields');
                    return;
                }
                
                if (username.length < 3) {
                    showError('Username must be at least 3 characters');
                    return;
                }
                
                if (password.length < 6) {
                    showError('Password must be at least 6 characters');
                    return;
                }
                
                // Show loading
                showLoading();
                
                // AJAX login submission
                $.ajax({
                    url: $(this).attr('action'),
                    method: $(this).attr('method'),
                    data: $(this).serialize(),
                    success: function(response) {
                        hideLoading();
                        
                        // Check if response is HTML or JSON
                        if (typeof response === 'string' && response.includes('<!DOCTYPE')) {
                            // HTML response - check for success redirect
                            if (response.includes('dashboard') || response.includes('Dashboard')) {
                                showSuccess('Login successful! Redirecting...');
                                setTimeout(() => {
                                    window.location.href = '<%= request.getContextPath() %>/login';
                                }, 1500);
                            } else {
                                // Parse HTML to find error message
                                const tempDiv = $('<div>').html(response);
                                const errorMsg = tempDiv.find('.error-alert span').text() || 'Invalid credentials';
                                showError(errorMsg);
                            }
                        } else if (typeof response === 'object') {
                            // JSON response
                            if (response.success) {
                                showSuccess('Login successful! Redirecting...');
                                setTimeout(() => {
                                    window.location.href = response.redirectUrl || '<%= request.getContextPath() %>/login';
                                }, 1500);
                            } else {
                                showError(response.message || 'Login failed');
                            }
                        }
                    },
                    error: function(xhr, status, error) {
                        hideLoading();
                        
                        if (xhr.status === 401) {
                            showError('Invalid username or password');
                        } else if (xhr.status === 403) {
                            showError('Access denied. Please contact administrator.');
                        } else if (xhr.status === 500) {
                            showError('Server error. Please try again later.');
                        } else {
                            showError('Network error. Please check your connection.');
                        }
                        
                        // Log error for debugging
                        console.error('Login error:', error);
                    }
                });
            });
            
            // Input focus effects
            $('.form-input').focus(function() {
                $(this).closest('.input-container').addClass('focused');
                $(this).next('.input-label').addClass('active');
            }).blur(function() {
                $(this).closest('.input-container').removeClass('focused');
                if (!$(this).val()) {
                    $(this).next('.input-label').removeClass('active');
                }
            });
            
            // Auto-fill label adjustment
            $('.form-input').each(function() {
                if ($(this).val()) {
                    $(this).next('.input-label').addClass('active');
                }
            });
            
            // Card hover effect enhancement
            $('#loginCard').hover(
                function() {
                    $(this).css({
                        'transform': 'translateY(-5px)',
                        'box-shadow': '0 20px 40px rgba(0, 0, 0, 0.15)'
                    });
                },
                function() {
                    $(this).css({
                        'transform': 'translateY(0)',
                        'box-shadow': '0 15px 35px rgba(0, 0, 0, 0.1)'
                    });
                }
            );
            
            // Forgot password link
            $('.forgot-link').click(function(e) {
                e.preventDefault();
                showError('Password reset feature coming soon! Please contact administrator.');
            });
            
            // Help link
            $('.help-link').click(function(e) {
                e.preventDefault();
                alert('Please contact system administrator at:\n\nEmail: admin@capex.com\nPhone: +1 (555) 123-4567\nHours: Mon-Fri 9AM-5PM EST');
            });
            
            // Enter key submits form
            $(document).keypress(function(e) {
                if (e.which === 13) { // Enter key
                    if ($('#username').is(':focus') || $('#password').is(':focus')) {
                        $('#loginForm').submit();
                    }
                }
            });
            
            // Utility Functions
            function showError(message) {
                $('#errorMessage').text(message);
                $('#errorAlert').slideDown();
                
                // Add shake animation
                $('#errorAlert').css('animation', 'shake 0.5s');
                setTimeout(() => {
                    $('#errorAlert').css('animation', '');
                }, 500);
                
                // Auto-hide after 5 seconds
                setTimeout(() => {
                    $('#errorAlert').slideUp();
                }, 5000);
            }
            
            function showSuccess(message) {
                $('#successMessage').text(message);
                $('#successAlert').slideDown();
                
                // Auto-hide after 3 seconds
                setTimeout(() => {
                    $('#successAlert').slideUp();
                }, 3000);
            }
            
            function hideAlerts() {
                $('#errorAlert').slideUp();
                $('#successAlert').slideUp();
            }
            
            function showLoading() {
                $('#loadingOverlay').fadeIn();
                $('#loginButton').prop('disabled', true).css('opacity', '0.7');
                $('#loginButton span').text('Authenticating...');
            }
            
            function hideLoading() {
                $('#loadingOverlay').fadeOut();
                $('#loginButton').prop('disabled', false).css('opacity', '1');
                $('#loginButton span').text('Login as Admin');
            }
            
            // Add animation to form inputs on load
            setTimeout(() => {
                $('.form-group').each(function(index) {
                    $(this).css('opacity', '0').css('transform', 'translateY(20px)');
                    $(this).delay(index * 100).animate({
                        opacity: 1,
                        transform: 'translateY(0)'
                    }, 500);
                });
                
                // Animate login card
                $('#loginCard').css('opacity', '0').css('transform', 'scale(0.9)');
                $('#loginCard').animate({
                    opacity: 1,
                    transform: 'scale(1)'
                }, 600);
            }, 300);
            
            // Shake animation for errors
            const style = document.createElement('style');
            style.textContent = `
                @keyframes shake {
                    0%, 100% { transform: translateX(0); }
                    10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
                    20%, 40%, 60%, 80% { transform: translateX(5px); }
                }
            `;
            document.head.appendChild(style);
            
            // Auto-hide success message after redirect
            if ($('#successAlert').is(':visible')) {
                setTimeout(() => {
                    $('#successAlert').slideUp();
                }, 2000);
            }
        });
    </script>
</body>
</html>