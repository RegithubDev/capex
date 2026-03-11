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

    <!-- jQuery + Select2 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color:#333;
            line-height:1.6;
            min-height:100vh;
        }
        header.welcome-header {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
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
        .container { max-width:1400px; margin:30px auto; padding:0 20px; }
        .page-header {
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:30px;
            padding-bottom:15px;
            border-bottom:2px solid #eaeaea;
        }
        .btn {
            padding:10px 20px;
            border:none;
            border-radius:6px;
            cursor:pointer;
            font-weight:500;
            display:inline-flex;
            align-items:center;
            gap:8px;
        }
        .btn-primary  { background:#3498db; color:white; }
        .btn-secondary { background:#f8f9fa; color:#333; border:1px solid #ccc; }
        .btn-success  { background:#27ae60; color:white; }
        .modal-overlay {
            position:fixed; inset:0;
            background:rgba(0,0,0,0.5);
            display:none;
            align-items:center;
            justify-content:center;
            z-index:2000;
        }
        .modal-overlay.active { display:flex; }
        .modal {
            background:white;
            border-radius:12px;
            width:90%;
            max-width:800px;
            max-height:90vh;
            overflow-y:auto;
            box-shadow:0 10px 30px rgba(0,0,0,0.25);
        }
        .modal-header {
            background:#2c3e50;
            color:white;
            padding:15px 25px;
            display:flex;
            justify-content:space-between;
            align-items:center;
        }
        .modal-close {
            background:none;
            border:none;
            color:white;
            font-size:28px;
            cursor:pointer;
        }
        .form-grid {
            display:grid;
            grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
            gap:20px;
            padding:20px;
        }
        .form-group label { font-weight:500; margin-bottom:6px; display:block; }
        .form-group input,
        .form-group select {
            width:100%;
            padding:10px;
            border:1px solid #ccc;
            border-radius:6px;
            font-size:14px;
        }
        .table { width:100%; border-collapse:collapse; margin-top:15px; }
        .table th {
            background:#2c3e50;
            color:white;
            padding:12px;
            text-align:left;
        }
        .table td { padding:12px; border-bottom:1px solid #eee; }
        .status-active  { background:#d4edda; color:#155724; padding:4px 10px; border-radius:12px; }
        .status-inactive { background:#f8d7da; color:#721c24; padding:4px 10px; border-radius:12px; }
        .action-btn {
            background:none;
            border:none;
            font-size:18px;
            cursor:pointer;
            padding:6px;
            margin:0 4px;
        }
        .pagination {
            display:flex;
            justify-content:center;
            gap:8px;
            margin:30px 0;
        }
        .page-btn {
            padding:8px 14px;
            border:1px solid #ccc;
            border-radius:6px;
            background:white;
            cursor:pointer;
        }
        .page-btn.active { background:#3498db; color:white; border-color:#3498db; }
    </style>
</head>
<body>

<header class="welcome-header">
    <div>
        <h1>CAPEX Management System</h1>
        <small>User Management</small>
    </div>
    <div>
        <span><i class="fas fa-user"></i> <c:out value="${sessionScope.USER_NAME}" default="Admin"/></span>
        &nbsp;&nbsp;
        <button class="btn btn-secondary" onclick="location.href='<c:url value="/home"/>'">Dashboard</button>
        <button class="btn btn-secondary" onclick="logout()">Logout</button>
    </div>
</header>

<div class="container">

    <div class="page-header">
        <h2><i class="fas fa-users"></i> Users</h2>
        <div>
            <button class="btn btn-primary" onclick="openAddUserModal()">
                <i class="fas fa-plus"></i> Add User
            </button>
        </div>
    </div>

    <div id="alertContainer"></div>

    <table class="table" id="userTable">
        <thead>
            <tr>
                <th>#</th>
                <th>User ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Project</th>
                <th>Role</th>
                <th>Designation</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody id="tableBody">
            <tr><td colspan="9" style="text-align:center;padding:60px;">Loading users...</td></tr>
        </tbody>
    </table>

</div>

<!-- Modal -->
<div class="modal-overlay" id="userModal">
    <div class="modal">
        <div class="modal-header">
            <h3 id="modalTitle">Add New User</h3>
            <button class="modal-close" onclick="closeUserModal()">×</button>
        </div>
        <div class="modal-body">
            <form id="userForm" onsubmit="saveUser(event)">
                <div class="form-grid">

                    <div class="form-group">
                        <label>User ID <span style="color:red">*</span></label>
                        <input type="text" id="user_id" name="user_id" required maxlength="50">
                    </div>

                    <div class="form-group">
                        <label>Full Name <span style="color:red">*</span></label>
                        <input type="text" id="user_name" name="user_name" required maxlength="100">
                    </div>

                    <div class="form-group">
                        <label>Password <span id="passwordRequired" style="color:red">*</span></label>
                        <input type="password" id="password" name="password" required>
                    </div>

                    <div class="form-group">
                        <label>Mobile <span style="color:red"></span></label>
                        <input type="tel" id="contact_number" name="contact_number" pattern="[0-9]{10,15}">
                    </div>

                    <div class="form-group">
                        <label>Email <span style="color:red">*</span></label>
                        <input type="email" id="email_id" name="email_id" required>
                    </div>

                    <div class="form-group">
                        <label>Base Project</label>
                        <select id="base_plant" name="base_project" class="form-select">
                            <option value="">— Select —</option>
                            <c:forEach var="plant" items="${projectsList}">
                                <option value="${plant.plant_code}">${plant.plant_name}</option>
                            </c:forEach>
                        </select>
                    </div>
 
                    <div class="form-group">
                        <label>Role</label>
                        <select id="base_role" name="base_role" class="form-select">
                            <option value="">— Select —</option>
                                <option value="Admin">Admin</option>
                                 <option value="User">User</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Designation</label>
                        <select id="role_type" name="role_type" class="form-select">
                           <option value="">-- Select Role --</option>
						    <option value="CEO">CEO</option>
						    <option value="CFO">CFO</option>
						    <option value="ERM Head">ERM Head</option>
						    <option value="Finance Controller">Finance Controller</option>
						    <option value="Project Head">Project Head</option>
						    <option value="Regional Director">Regional Director</option>
						    <option value="Site Finance Head">Site Finance Head</option>
						    <option value="Site Head">Site Head</option>
                        </select>
                    </div>
 
                    <div class="form-group">
                        <label>Department</label>
                        <select id="base_department" name="base_department" class="form-select">
                            <option value="">— Select —</option>
                            
                            
                            <c:forEach var="dept" items="${departmentList}">
                                <option value="${dept.department_code}">${dept.department_name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Status <span style="color:red">*</span></label>
                        <select id="status" name="status" required>
                            <option value="Active" selected>Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>

                </div>

                <div style="text-align:right; margin-top:25px;">
                    <button type="button" class="btn btn-secondary" onclick="closeUserModal()">Cancel</button>
                    <button type="submit" class="btn btn-success" id="submitButton">Save</button>
                </div>

                <input type="hidden" id="editMode" value="false">
                <input type="hidden" id="original_user_id" name="original_user_id">
            </form>
        </div>
    </div>
</div>

<script>
const baseUrl = '<c:url value="/"/>';
let users = [];

$(document).ready(function(){
    loadUsers();
});

function loadUsers(){
    $.get(baseUrl + 'ajax/getUserList1', function(data){
        users = data || [];
        renderTable();
    }).fail(function(){
        $('#tableBody').html('<tr><td colspan="9" style="color:red;text-align:center">Failed to load users</td></tr>');
    });
}

function renderTable(){
    const tbody = $('#tableBody').empty();
    if (!users.length) {
        tbody.html('<tr><td colspan="9" style="text-align:center;padding:60px;">No users found</td></tr>');
        return;
    }

    users.forEach((u, i) => {
        const statusClass = (u.status == 'Active') ? 'status-active' : 'status-inactive';
        const row = 
            '<tr>' +
                '<td>' + (i+1) + '</td>' +
                '<td>' + (u.user_id || '-') + '</td>' +
                '<td>' + (u.user_name || '-') + '</td>' +
                '<td>' + (u.email_id || '-') + '</td>' +
                '<td>' + (u.base_project || '-') + '</td>' +
                '<td>' + (u.base_role || '-') + '</td>' +
                '<td>' + (u.role_type || '-') + '</td>' +
                '<td><span class="' + statusClass + '">' + (u.status || 'Inactive') + '</span></td>' +
                '<td>' +
                    '<button class="action-btn" style="color:#3498db" onclick="editUser(\'' + u.user_id + '\')"><i class="fas fa-edit"></i></button>' +
                    '<button class="action-btn" style="color:#e74c3c" onclick="deleteUser(\'' + u.user_id + '\')"><i class="fas fa-trash"></i></button>' +
                '</td>' +
            '</tr>';
        tbody.append(row);
    });
}

function openAddUserModal(){
    $('#modalTitle').text('Add New User');
    $('#editMode').val('false');
    $('#userForm')[0].reset();
    $('#password').prop('required',true);
    $('#passwordRequired').show();
    $('#submitButton').text('Save');
    $('#userModal').addClass('active');

    setTimeout(initSelect2, 100);
}

function editUser(id){
    const user = users.find(u => u.user_id === id);
    if (!user) return alert('User not found');

    $('#modalTitle').text('Edit User');
    $('#editMode').val('true');
    $('#user_id').val(user.user_id).prop('readonly',false);
    $('#original_user_id').val(user.user_id);
    $('#user_name').val(user.user_name||'');
    $('#email_id').val(user.email_id||'');
    $('#contact_number').val(user.contact_number||'');
    $('#base_plant').val(user.base_project||'');
    $('#base_role').val(user.base_role||'');
    $('#role_type').val(user.role_type||'');
    $('#base_department').val(user.base_department||'');
    $('#status').val(user.status||'Active');
    $('#password').val(user.password).prop('required',true);
    $('#passwordRequired').hide();
    $('#submitButton').text('Update');

    $('#userModal').addClass('active');

    setTimeout(initSelect2, 100);
}

function closeUserModal(){
    $('#userModal').removeClass('active');
    $('#userForm')[0].reset();
}

function initSelect2(){
    $('.form-select').select2({
        width: '100%',
        placeholder: "— Select —",
        allowClear: true,
        dropdownParent: $('#userModal')
    });
}

function saveUser(e){
    e.preventDefault();
    const fd = new FormData($('#userForm')[0]);
    const isEdit = $('#editMode').val() === 'true';
    const url = isEdit ? baseUrl+'update-user' : baseUrl+'add-user';

    $.ajax({
        url: url,
        type: 'POST',
        data: fd,
        processData: false,
        contentType: false,
        success: function(){
            alert(isEdit ? 'User updated' : 'User created');
            closeUserModal();
            loadUsers();
        },
        error: function(xhr){
            alert('Error: ' + (xhr.responseText || 'Save failed'));
        }
    });
}

function deleteUser(id){
    if (!confirm('Delete user '+id+' ?')) return;
    location.href = baseUrl + 'delete-user?user_id=' + id;
}

function logout(){
    if (confirm('Logout?')) location.href = baseUrl + 'logout';
}
</script>
</body>
</html>