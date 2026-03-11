<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IRM - Register New User</title>

    <link rel="icon" type="image/png" sizes="96x96" href="/reirm/resources/images/protect-favicon.png">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
    .select2-container--default .select2-results > .select2-results__options {
    max-height: 280px !important;   /* Adjust this value as needed (e.g. 200px–350px) */
    overflow-y: auto !important;
}
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background: linear-gradient(135deg, #e0eafc 0%, #cfdef3 100%);
            perspective: 1400px;
            font-family: system-ui, -apple-system, sans-serif;
        }

        .auth-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }

        .auth-card {
            width: 100%;
            max-width: 1100px;
            border: none;
            border-radius: 28px;
            box-shadow: 0 25px 70px rgba(0,0,0,0.18);
            overflow: hidden;
            transform-style: preserve-3d;
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            background: linear-gradient(145deg, #ffffff, #f1f5f9);
        }

        .auth-card:hover {
            transform: rotateY(3deg) rotateX(3deg) scale(1.015);
            box-shadow: 0 35px 90px rgba(0,0,0,0.22);
        }

        .card-header {
            background: linear-gradient(90deg, #4c51bf 0%, #6b46c1 100%);
            color: white;
            text-align: center;
            padding: 1.8rem 1.5rem;
            border-top-left-radius: 28px;
            border-top-right-radius: 28px;
            position: relative;
        }

        .card-header::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at 30% 20%, rgba(255,255,255,0.25) 0%, transparent 60%);
            opacity: 0.5;
        }

        .card-body {
            padding: 2rem 2.5rem;
            max-height: calc(100vh - 130px);
            overflow-y: auto;
        }

        .form-label {
            font-weight: 600;
            color: #2d3748;
        }

        .required::after {
            content: " *";
            color: #e53e3e;
        }

        .error-msg {
            color: #e53e3e;
            font-size: 0.82rem;
        }

        .form-control, .form-select {
            border-radius: 0.75rem;
            box-shadow: inset 0 3px 6px rgba(0,0,0,0.07);
            background: #f8fafc;
            border: 1px solid #cbd5e1;
            transition: all 0.25s ease;
            height: calc(2.25rem + 12px);
        }

        .form-control:focus, .form-select:focus {
            box-shadow: 0 0 0 0.25rem rgba(79,70,229,0.25);
            transform: translateY(-1px);
            border-color: #000;           /* Black border on focus too */
        }

        /* Black border for ALL select fields */
        .form-select,
        .select2-container--default .select2-selection--single {
            border: 1px solid #000 !important;   /* ← Strong black border */
            border-radius: 0.75rem;
        }

        .select2-container--default .select2-selection--single {
            height: calc(2.25rem + 12px) !important;
            box-shadow: inset 0 3px 6px rgba(0,0,0,0.07);
        }

        .select2-container--default .select2-selection--single .select2-selection__rendered {
            line-height: calc(2.25rem + 8px);
            padding-left: 0.75rem;
            color: #2d3748;
        }

        .select2-container--default .select2-selection--single:focus {
            border-color: #000 !important;
        }

        .btn-primary {
            background: linear-gradient(90deg, #4c51bf 0%, #6b46c1 100%);
            border: none;
            border-radius: 0.75rem;
            box-shadow: 0 5px 12px rgba(79,70,229,0.3);
            transition: all 0.3s ease;
            padding: 0.75rem 1.5rem;
            font-size: 1.1rem;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(79,70,229,0.4);
        }

        .password-toggle {
            cursor: pointer;
            color: #64748b;
            font-size: 1.1rem;
        }

        .password-toggle:hover {
            color: #334155;
        }

        /* 3-column layout */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.25rem 1.5rem;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .form-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 576px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            .card-body {
                padding: 1.5rem;
            }
            .auth-card {
                border-radius: 16px;
            }
            .auth-container {
                padding: 0.75rem;
            }
        }
    </style>
</head>
<body>

<div class="auth-container">
    <div class="auth-card card">
        <div class="card-header">
            <img src="<%=request.getContextPath()%>/resources/images/Ramky-Logo.png"
                 alt="IRM Logo" height="55" class="mb-2">
            <h4 class="mb-0 fw-bold">Register New User</h4>
        </div>

        <div class="card-body">
            <form id="addUserForm" action="<%=request.getContextPath()%>/add-new-user" method="post" novalidate>
                <input type="hidden" name="newUser" value="new"/>
<input type="hidden" id="usersListData"
       value='<c:out value="${usersJson}" escapeXml="false"/>' />
                <div class="form-grid">

                    <!-- Field 1 -->
                    <div class="form-floating">
                        <input type="text" class="form-control" id="user_id_add" name="user_id" placeholder="EMP123" required>
                        <label for="user_id_add">User ID / EMP ID <span class="required"></span></label>
                        <div class="invalid-feedback">Required</div>
                    </div>

                    <!-- Field 2 -->
                    <div class="form-floating">
                        <input type="text" class="form-control" id="user_name_add" name="user_name" placeholder="John Doe" required>
                        <label for="user_name_add">Full Name <span class="required"></span></label>
                        <div class="invalid-feedback">Required</div>
                    </div>

                    <!-- Field 3 -->
                    <div class="form-floating">
                        <input type="email" class="form-control" id="email_add" name="email_id" placeholder="name@example.com" required>
                        <label for="email_add">Email Address <span class="required"></span></label>
                        <div class="invalid-feedback">Valid email required</div>
                    </div>

                    <!-- Field 4 -->
                    <div class="form-floating position-relative">
                        <input type="password" class="form-control pe-5" id="password" name="password" placeholder="Password" required minlength="8">
                        <label for="password">Password <span class="required"></span></label>
                        <span class="password-toggle position-absolute top-50 end-0 translate-middle-y me-3" onclick="togglePassword('password')">
                            <i class="fas fa-eye" id="togglePasswordIcon"></i>
                        </span>
                        <div class="invalid-feedback">Min 8 chars</div>
                    </div>

                    <!-- Field 5 -->
                    <div class="form-floating position-relative">
                        <input type="password" class="form-control pe-5" id="confirm_password" name="confirm_password" placeholder="Confirm Password" required>
                        <label for="confirm_password">Confirm Password <span class="required"></span></label>
                        <span class="password-toggle position-absolute top-50 end-0 translate-middle-y me-3" onclick="togglePassword('confirm_password')">
                            <i class="fas fa-eye" id="toggleConfirmPasswordIcon"></i>
                        </span>
                        <div class="invalid-feedback">Passwords must match</div>
                    </div>

                    <!-- Field 6 - SBU (black border applied via CSS) -->
                    <div>
                        <label class="form-label required">Strategic Business Unit (SBU)</label>
                        <select class="form-select select2" id="select2-base_sbu-container" name="base_sbu" onchange="setProjectDD();" required>
                            <option value="">Select SBU</option>
                            <c:forEach var="obj" items="${sbuList}">
                                <option value="${obj.sbu}">[${obj.sbu}] - ${obj.sbu_name}</option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Required</div>
                    </div>

                    <!-- Field 7 - Project -->
                    <div>
                        <label class="form-label required">Project</label>
                        <select class="form-select select2" id="select2-base_project-container" name="base_project" required>
                            <option value="">Select Project</option>
                        </select>
                        <div class="invalid-feedback">Required</div>
                    </div>

                    <!-- Field 8 - Department -->
                    <div>
                        <label class="form-label required">Department</label>
                        <select class="form-select select2" id="select2-base_department-container" name="base_department" required>
                            <option value="">Select Department</option>
                            <c:forEach var="obj" items="${departmentList}">
                                <option value="${obj.department_code}">[${obj.department_code}] - ${obj.department_name}</option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Required</div>
                    </div>

                </div>

                <div class="d-grid mt-4">
                    <button type="button" class="btn btn-primary btn-lg" onclick="addUser()">
                        <i class="fas fa-user-plus me-2"></i> Register User
                    </button>
                </div>

                <div class="text-center mt-3">
                    <small class="text-muted">Already have an account? </small>
                    <a href="<%=request.getContextPath()%>/" class="text-primary fw-medium">Log in</a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>

<script>
var usersList = [];

$(document).ready(function () {

    // ================= LOAD JSON FROM CONTROLLER =================
    var jsonData = $('#usersListData').val();

    if (jsonData && jsonData.trim() !== "") {
        try {
            usersList = JSON.parse(jsonData);
            console.log("Users Loaded:", usersList);
        } catch (e) {
            console.error("JSON Parse Error:", e);
            usersList = [];
        }
    }

    // ================= REAL-TIME VALIDATION =================
    $('#user_id_add, #email_add').on('keyup blur', function () {
        validateField($(this));
        checkFormValidity();
    });

    checkFormValidity();
});


// ================= FIELD VALIDATION =================
function validateField(field) {

    var fieldId = field.attr("id");
    var value = field.val().trim();
    var errorMessage = "";
    var isDuplicate = false;

    // -------- USER ID VALIDATION --------
    if (fieldId === "user_id_add") {

        if (value === "") {
            errorMessage = "User ID is required.";
        } else {
            isDuplicate = usersList.some(function(user) {
                return user.user_id &&
                       user.user_id.toLowerCase() === value.toLowerCase();
            });

            if (isDuplicate) {
                errorMessage = "User ID already exists.";
            }
        }
    }

    // -------- EMAIL VALIDATION --------
    if (fieldId === "email_add") {

        if (value === "") {
            errorMessage = "Email ID is required.";
        } else {

            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!emailPattern.test(value)) {
                errorMessage = "Invalid email format.";
            } else {

                isDuplicate = usersList.some(function(user) {
                    return user.email_id &&
                           user.email_id.toLowerCase() === value.toLowerCase();
                });

                if (isDuplicate) {
                    errorMessage = "Email ID already exists.";
                }
            }
        }
    }

    showValidation(field, errorMessage);
}
function checkFormValidity() {

    var isValid = true;

    var userId = $('#user_id_add').val().trim();
    var email  = $('#email_add').val().trim();

    // If empty
    if (userId === "" || email === "") {
        isValid = false;
    }

    // If any invalid class exists
    if ($('#user_id_add').hasClass("is-invalid") ||
        $('#email_add').hasClass("is-invalid")) {
        isValid = false;
    }

    $("#submitBtn").prop("disabled", !isValid);
}

function showValidation(field, message) {

    field.next(".error-message").remove();

    if (message !== "") {
        field.addClass("is-invalid");
        field.removeClass("is-valid");
        field.after('<div class="error-message text-danger small">' + message + '</div>');
    } else {
        field.removeClass("is-invalid");
        field.addClass("is-valid");   // ADD THIS LINE
    }

    checkFormValidity();   // 🔥 ADD THIS LINE (VERY IMPORTANT)
}
// Initialize Select2
$(document).ready(function() {
    $('.select2').select2({
        theme: "bootstrap-5",
        width: '100%'
    });

    const form = document.getElementById('addUserForm');
    form.addEventListener('submit', e => {
        if (!form.checkValidity()) {
            e.preventDefault();
            e.stopPropagation();
        }
        form.classList.add('was-validated');
    }, false);
});

function addUser() {
    const form = document.getElementById('addUserForm');
    if (form.checkValidity()) {
        form.submit();
    } else {
        form.classList.add('was-validated');
    }
}

function setProjectDD() {
    var base_sbu = $("#select2-base_sbu-container").val();
    if ($.trim(base_sbu) !== "") {
        $("#select2-base_project-container option:not(:first)").remove();
        var myParams = { sbu: base_sbu };
        $.ajax({
            url: "<%=request.getContextPath()%>/ajax/getProjectListForUser",
            data: myParams,
            cache: false,
            async: true,
            success: function (data) {
                if (data.length > 0) {
                    $.each(data, function (i, val) {
                        $("#select2-base_project-container").append(
                            '<option value="' + val.plant_code + '">' + 
                            $.trim(val.plant_code) + " - " + $.trim(val.plant_name) + 
                            '</option>'
                        );
                    });
                }
            },
            error: function (jqXHR, exception) {
                console.error("Project load failed:", jqXHR, exception);
            }
        });
    }
}

$.validator.addMethod("strongPassword", function(value, element) {
    return this.optional(element) || /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/.test(value);
}, "Password must contain at least 8 characters, one uppercase, one lowercase, and one number");

$(document).ready(function() {
    $("#addUserForm").validate({
        rules: {
            user_id: { required: true, minlength: 4 },
            user_name: { required: true, minlength: 3 },
            email_id: { required: true, email: true },
            password: { required: true, minlength: 8, strongPassword: true },
            confirm_password: { required: true, equalTo: "#password" },
            base_sbu: "required",
            base_project: "required",
            base_department: "required"
        },
        messages: {
            user_id: { required: "Please enter User ID", minlength: "At least 4 characters" },
            user_name: "Please enter full name",
            email_id: { required: "Please enter email", email: "Invalid email" },
            password: { 
                required: "Please provide password",
                minlength: "At least 8 characters",
                strongPassword: "Must contain uppercase, lowercase & number"
            },
            confirm_password: { required: "Confirm password", equalTo: "Passwords do not match" }
        },
        errorElement: "span",
        errorClass: "error-msg",
        highlight: function(element) { $(element).addClass("is-invalid"); },
        unhighlight: function(element) { $(element).removeClass("is-invalid"); },
        errorPlacement: function(error, element) { error.insertAfter(element); }
    });
});

// Password visibility toggle
function togglePassword(fieldId) {
    const input = document.getElementById(fieldId);
    const icon = document.getElementById(fieldId === 'password' ? 'togglePasswordIcon' : 'toggleConfirmPasswordIcon');
    if (input.type === "password") {
        input.type = "text";
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        input.type = "password";
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
}
</script>

</body>
</html>