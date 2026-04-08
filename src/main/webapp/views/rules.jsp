<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Master Data Management | CAPEX System</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 30px 40px;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: pulse 8s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 0.5; }
            50% { transform: scale(1.1); opacity: 0.8; }
        }

        .header h2 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 10px;
            position: relative;
            z-index: 1;
        }

        .header p {
            font-size: 14px;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .btn-group {
            position: relative;
            z-index: 1;
            margin-top: 20px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 28px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: inline-flex;
            align-items: center;
            gap: 10px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255,255,255,0.3);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .btn:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(238, 90, 36, 0.4);
        }

        .btn-success {
            background: linear-gradient(135deg, #00b894, #00a884);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 184, 148, 0.4);
        }

        .btn-warning {
            background: linear-gradient(135deg, #fdcb6e, #f9a825);
            color: #333;
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(253, 203, 110, 0.4);
        }

        .table-container {
            padding: 30px;
            background: white;
        }

        #employeeTable {
            font-size: 13px;
            border-radius: 12px;
            overflow: hidden;
        }

        #employeeTable thead th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: 600;
            padding: 15px;
            border: none;
        }

        #employeeTable tbody tr {
            transition: all 0.3s ease;
        }

        #employeeTable tbody tr:hover {
            background: linear-gradient(90deg, #f3e5f5 0%, #e1f5fe 100%);
            transform: scale(1.01);
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.7);
            backdrop-filter: blur(8px);
        }

        .modal-content {
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            margin: 3% auto;
            padding: 0;
            border-radius: 20px;
            width: 85%;
            max-width: 1200px;
            max-height: 85vh;
            display: flex;
            flex-direction: column;
            box-shadow: 0 30px 60px rgba(0,0,0,0.5);
            animation: modalSlideIn 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: scale(0.8) translateY(-50px);
            }
            to {
                opacity: 1;
                transform: scale(1) translateY(0);
            }
        }

        .modal-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px 30px;
            border-radius: 20px 20px 0 0;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h3 {
            font-size: 24px;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .close {
            font-size: 32px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: rgba(255,255,255,0.2);
        }

        .close:hover {
            background: rgba(255,255,255,0.3);
            transform: rotate(90deg);
        }

        .changes-scroll-container {
            flex: 1;
            overflow-y: auto;
            padding: 20px 30px;
            max-height: calc(85vh - 140px);
        }

        .changes-scroll-container::-webkit-scrollbar {
            width: 10px;
        }

        .changes-scroll-container::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        .changes-scroll-container::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
        }

        .change-card {
            background: white;
            border-radius: 16px;
            margin-bottom: 20px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: all 0.3s;
        }

        .change-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }

        .card-header {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 15px 20px;
            border-bottom: 2px solid #667eea;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header h4 {
            font-size: 18px;
            font-weight: 700;
            color: #667eea;
            margin: 0;
        }

        .card-header .badge {
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .change-table-wrapper {
            overflow-x: auto;
            padding: 20px;
        }

        .change-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 12px;
            overflow: hidden;
        }

        .change-table th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px;
            font-weight: 600;
            font-size: 13px;
            text-align: left;
        }

        .change-table td {
            padding: 12px;
            border-bottom: 1px solid #e0e0e0;
            background: white;
        }

        .change-table tr:hover td {
            background: #f8f9fa;
        }

        .old-value {
            color: #dc3545;
            text-decoration: line-through;
            font-weight: 500;
            background: #ffe6e6;
            padding: 4px 8px;
            border-radius: 6px;
            display: inline-block;
        }

        .new-value {
            color: #28a745;
            font-weight: 700;
            background: #e6ffe6;
            padding: 4px 8px;
            border-radius: 6px;
            display: inline-block;
        }

        .approve-checkbox {
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: #28a745;
        }

        .modal-footer {
            padding: 20px 30px;
            background: #f8f9fa;
            border-radius: 0 0 20px 20px;
            text-align: center;
            display: flex;
            gap: 15px;
            justify-content: center;
            border-top: 1px solid #e0e0e0;
        }

        .toast {
            visibility: hidden;
            min-width: 350px;
            color: #fff;
            text-align: center;
            border-radius: 50px;
            padding: 16px 24px;
            position: fixed;
            z-index: 3000;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            font-weight: 600;
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
        }

        .toast.show {
            visibility: visible;
            animation: toastFadeIn 0.5s, toastFadeOut 0.5s 2.5s;
        }

        @keyframes toastFadeIn {
            from { bottom: 0; opacity: 0; }
            to { bottom: 30px; opacity: 1; }
        }

        @keyframes toastFadeOut {
            from { bottom: 30px; opacity: 1; }
            to { bottom: 0; opacity: 0; }
        }

        @media (max-width: 768px) {
            .modal-content { width: 95%; margin: 10% auto; }
            .btn-group { flex-direction: column; }
            .btn { width: 100%; justify-content: center; }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h2><i class="fas fa-users"></i> Employee Master Data Management</h2>
        <p>Manage and maintain employee master data with ease | CAPEX Management System</p>
        <div class="btn-group">
            <button class="btn btn-primary" onclick="downloadExcel()">
                <i class="fas fa-download"></i> Download Excel Template
            </button>
            <input type="file" id="excelFile" accept=".xlsx,.xls" style="display:none" onchange="uploadExcel(this)">
            <button class="btn btn-success" onclick="document.getElementById('excelFile').click()">
                <i class="fas fa-upload"></i> Upload Excel File
            </button>
        </div>
    </div>
    
    <div class="table-container">
        <table id="employeeTable" class="display" style="width:100%">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>SBU</th>
                    <th>Plant</th>
                    <th>Department</th>
                    <th>Site Head</th>
                    <th>Site Head ID</th>
                    <th>Site Head Email</th>
                    <th>Site Finance Head</th>
                    <th>Site Finance Head Desig</th>
                    <th>Site Finance Head ID</th>
                    <th>Site Finance Head Email</th>
                    <th>Finance Controller</th>
                    <th>Finance Controller ID</th>
                    <th>Finance Controller Email</th>
                    <th>Regional Director</th>
                    <th>Regional Director ID</th>
                    <th>Regional Director Email</th>
                    <th>BU Head</th>
                    <th>BU Head ID</th>
                    <th>BU Head Email</th>
                    <th>Project Head</th>
                    <th>Project Head ID</th>
                    <th>Project Head Email</th>
                    <th>CFO</th>
                    <th>CFO ID</th>
                    <th>CFO Email</th>
                    <th>CEO</th>
                    <th>CEO ID</th>
                    <th>CEO Email</th>
                    <th>Created At</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${employees}" var="emp">
                    <tr>
                        <td>${emp.id}</td>
                        <td>${empty emp.sbu ? '-' : emp.sbu}</td>
                        <td>${empty emp.plant ? '-' : emp.plant}</td>
                        <td>${empty emp.department ? '-' : emp.department}</td>
                        <td>${empty emp.siteHeadName ? '-' : emp.siteHeadName}</td>
                        <td>${empty emp.siteHeadEmployeeId ? '-' : emp.siteHeadEmployeeId}</td>
                        <td>${empty emp.siteHeadEmail ? '-' : emp.siteHeadEmail}</td>
                        <td>${empty emp.siteFinanceHeadName ? '-' : emp.siteFinanceHeadName}</td>
                        <td>${empty emp.siteFinanceHeadDesignation ? '-' : emp.siteFinanceHeadDesignation}</td>
                        <td>${empty emp.siteFinanceHeadEmployeeId ? '-' : emp.siteFinanceHeadEmployeeId}</td>
                        <td>${empty emp.siteFinanceHeadEmail ? '-' : emp.siteFinanceHeadEmail}</td>
                        <td>${empty emp.financeControllerName ? '-' : emp.financeControllerName}</td>
                        <td>${empty emp.financeControllerEmployeeId ? '-' : emp.financeControllerEmployeeId}</td>
                        <td>${empty emp.financeControllerEmail ? '-' : emp.financeControllerEmail}</td>
                        <td>${empty emp.regionalDirectorName ? '-' : emp.regionalDirectorName}</td>
                        <td>${empty emp.regionalDirectorEmployeeId ? '-' : emp.regionalDirectorEmployeeId}</td>
                        <td>${empty emp.regionalDirectorEmail ? '-' : emp.regionalDirectorEmail}</td>
                        <td>${empty emp.buHeadName ? '-' : emp.buHeadName}</td>
                        <td>${empty emp.buHeadEmployeeId ? '-' : emp.buHeadEmployeeId}</td>
                        <td>${empty emp.buHeadEmail ? '-' : emp.buHeadEmail}</td>
                        <td>${empty emp.projectHeadName ? '-' : emp.projectHeadName}</td>
                        <td>${empty emp.projectHeadEmployeeId ? '-' : emp.projectHeadEmployeeId}</td>
                        <td>${empty emp.projectHeadEmail ? '-' : emp.projectHeadEmail}</td>
                        <td>${empty emp.cfoName ? '-' : emp.cfoName}</td>
                        <td>${empty emp.cfoEmployeeId ? '-' : emp.cfoEmployeeId}</td>
                        <td>${empty emp.cfoEmail ? '-' : emp.cfoEmail}</td>
                        <td>${empty emp.ceoName ? '-' : emp.ceoName}</td>
                        <td>${empty emp.ceoEmployeeId ? '-' : emp.ceoEmployeeId}</td>
                        <td>${empty emp.ceoEmail ? '-' : emp.ceoEmail}</td>
                        <td>${empty emp.createdAt ? '-' : emp.createdAt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div id="approvalModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-check-circle"></i> Review & Approve Changes</h3>
            <span class="close" onclick="closeModal()">&times;</span>
        </div>
        <div class="changes-scroll-container" id="changesContainer">
            <div style="text-align: center; padding: 40px; color: #999;">
                <i class="fas fa-spinner fa-spin" style="font-size: 40px;"></i>
                <p>Loading changes...</p>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-success" onclick="approveAllChanges()">
                <i class="fas fa-check-double"></i> Approve All
            </button>
            <button class="btn btn-primary" onclick="approveSelectedChanges()">
                <i class="fas fa-check"></i> Approve Selected
            </button>
            <button class="btn btn-warning" onclick="closeModal()">
                <i class="fas fa-times"></i> Cancel
            </button>
        </div>
    </div>
</div>

<div id="toast" class="toast"></div>

<script>
    var employeeTable;
    var pendingChanges = [];
    var isProcessing = false;
    
    $(document).ready(function() {
        employeeTable = $('#employeeTable').DataTable({
            pageLength: 25,
            scrollX: true,
            scrollY: '60vh',
            scrollCollapse: true,
            autoWidth: false,
            language: {
                search: "<i class='fas fa-search'></i> Search:",
                lengthMenu: "Show _MENU_ entries",
                info: "Showing _START_ to _END_ of _TOTAL_ entries",
                paginate: {
                    first: "First",
                    last: "Last",
                    next: "Next",
                    previous: "Prev"
                }
            }
        });
        
        $('.dataTables_filter input').addClass('form-control').css({
            'padding': '8px 12px',
            'border-radius': '20px',
            'border': '1px solid #ddd',
            'margin-left': '10px'
        });
    });
    
    function downloadExcel() {
        showToast('Downloading Excel file...', 'info');
        window.location.href = '${pageContext.request.contextPath}/downloadExcel';
    }
    
    function uploadExcel(input) {
        if (isProcessing) {
            showToast('Please wait, previous operation is still processing...', 'warning');
            return;
        }
        
        var file = input.files[0];
        if (!file) return;
        
        showToast('Uploading file...', 'info');
        isProcessing = true;
        
        var formData = new FormData();
        formData.append('file', file);
        
        $.ajax({
            url: '${pageContext.request.contextPath}/uploadExcel',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                if (response.status === 'pending_approval') {
                    pendingChanges = response.changes;
                    showApprovalModal(response.changes);
                    showToast('Please review and approve the changes', 'info');
                } else if (response.status === 'success') {
                    showToast('No changes detected in the uploaded file', 'success');
                } else {
                    showToast('Error: ' + response.message, 'error');
                }
                document.getElementById('excelFile').value = '';
                isProcessing = false;
            },
            error: function(xhr, status, error) {
                showToast('Error uploading file: ' + error, 'error');
                document.getElementById('excelFile').value = '';
                isProcessing = false;
            }
        });
    }
    
    function showApprovalModal(changes) {
        var container = document.getElementById('changesContainer');
        container.innerHTML = '';
        
        if (!changes || changes.length === 0) {
            container.innerHTML = '<div style="text-align: center; padding: 40px;"><i class="fas fa-check-circle" style="font-size: 48px; color: #28a745;"></i><p>No changes to review</p></div>';
            document.getElementById('approvalModal').style.display = 'block';
            return;
        }
        
        var displayChanges = 0;
        
        changes.forEach(function(change, index) {
            var validChanges = [];
            
            if (change.changes && change.changes.length > 0) {
                validChanges = change.changes.filter(function(detail) {
                    var newVal = detail.newValue ? detail.newValue.toString().trim() : '';
                    var oldVal = detail.oldValue ? detail.oldValue.toString().trim() : '';
                    
                    return newVal !== '' && 
                           newVal !== 'null' && 
                           newVal !== 'undefined' &&
                           oldVal !== newVal;
                });
            }
            
            if (validChanges.length === 0) return;
            
            displayChanges++;
            
            var changeCard = document.createElement('div');
            changeCard.className = 'change-card';
            changeCard.style.marginBottom = '20px';
            changeCard.style.border = '1px solid #e0e0e0';
            changeCard.style.borderRadius = '8px';
            changeCard.style.overflow = 'hidden';
            
            var cardHeader = document.createElement('div');
            cardHeader.className = 'card-header';
            cardHeader.style.background = '#f8f9fa';
            cardHeader.style.padding = '15px 20px';
            cardHeader.style.borderBottom = '2px solid #667eea';
            cardHeader.innerHTML = '<h4 style="margin: 0; color: #667eea;"><i class="fas fa-edit"></i> Row ' + change.rowNumber + ' - ID: ' + change.id + '</h4>' +
                                   '<span style="background: #ff6b6b; color: white; padding: 5px 12px; border-radius: 20px; font-size: 12px;"><i class="fas fa-clock"></i> ' + validChanges.length + ' change(s)</span>';
            changeCard.appendChild(cardHeader);
            
            var tableWrapper = document.createElement('div');
            tableWrapper.style.overflowX = 'auto';
            tableWrapper.style.padding = '20px';
            
            var table = document.createElement('table');
            table.style.width = '100%';
            table.style.borderCollapse = 'collapse';
            table.innerHTML = '<thead>' +
                             '<tr>' +
                             '<th style="padding: 12px; text-align: left; background: #667eea; color: white;">Field</th>' +
                             '<th style="padding: 12px; text-align: left; background: #667eea; color: white;">Old Value</th>' +
                             '<th style="padding: 12px; text-align: left; background: #667eea; color: white;">New Value</th>' +
                             '<th style="padding: 12px; text-align: center; background: #667eea; color: white; width: 80px;">Approve</th>' +
                             '</tr>' +
                             '</thead>';
            var tbody = document.createElement('tbody');
            
            validChanges.forEach(function(detail, detailIndex) {
                var row = tbody.insertRow();
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                
                cell1.style.padding = '12px';
                cell1.style.borderBottom = '1px solid #e0e0e0';
                cell1.innerHTML = '<strong>' + escapeHtml(detail.field) + '</strong>';
                
                var oldVal = detail.oldValue ? detail.oldValue.toString().trim() : '';
                var oldValueHtml = (oldVal !== '' && oldVal !== 'null') ? 
                                   '<span style="color: #dc3545; text-decoration: line-through; background: #ffe6e6; padding: 4px 8px; border-radius: 6px; display: inline-block;"><i class="fas fa-history"></i> ' + escapeHtml(oldVal) + '</span>' : 
                                   '<span style="color: #dc3545; background: #ffe6e6; padding: 4px 8px; border-radius: 6px; display: inline-block;"><i class="fas fa-minus-circle"></i> Empty</span>';
                cell2.style.padding = '12px';
                cell2.style.borderBottom = '1px solid #e0e0e0';
                cell2.innerHTML = oldValueHtml;
                
                var newVal = detail.newValue ? detail.newValue.toString().trim() : '';
                var newValueHtml = (newVal !== '' && newVal !== 'null') ? 
                                   '<span style="color: #28a745; font-weight: bold; background: #e6ffe6; padding: 4px 8px; border-radius: 6px; display: inline-block;"><i class="fas fa-arrow-right"></i> ' + escapeHtml(newVal) + '</span>' : 
                                   '<span style="color: #28a745; font-weight: bold; background: #e6ffe6; padding: 4px 8px; border-radius: 6px; display: inline-block;"><i class="fas fa-plus-circle"></i> New Value</span>';
                cell3.style.padding = '12px';
                cell3.style.borderBottom = '1px solid #e0e0e0';
                cell3.innerHTML = newValueHtml;
                
                var checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                checkbox.style.width = '20px';
                checkbox.style.height = '20px';
                checkbox.style.cursor = 'pointer';
                checkbox.setAttribute('data-change-index', index);
                checkbox.setAttribute('data-detail-index', detailIndex);
                checkbox.onchange = function() {
                    var changeIdx = parseInt(this.getAttribute('data-change-index'));
                    var detailIdx = parseInt(this.getAttribute('data-detail-index'));
                    if (pendingChanges[changeIdx] && pendingChanges[changeIdx].changes && pendingChanges[changeIdx].changes[detailIdx]) {
                        pendingChanges[changeIdx].changes[detailIdx].approved = this.checked;
                    }
                };
                cell4.appendChild(checkbox);
                cell4.style.padding = '12px';
                cell4.style.borderBottom = '1px solid #e0e0e0';
                cell4.style.textAlign = 'center';
            });
            
            table.appendChild(tbody);
            tableWrapper.appendChild(table);
            changeCard.appendChild(tableWrapper);
            container.appendChild(changeCard);
        });
        
        if (displayChanges === 0) {
            container.innerHTML = '<div style="text-align: center; padding: 40px;"><i class="fas fa-check-circle" style="font-size: 48px; color: #28a745;"></i><p>No valid changes to review</p></div>';
        }
        
        document.getElementById('approvalModal').style.display = 'block';
    }
    
    function escapeHtml(text) {
        if (!text) return '';
        var map = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        };
        return text.toString().replace(/[&<>"']/g, function(m) { return map[m]; });
    }
    
    function approveAllChanges() {
        if (isProcessing) {
            showToast('Please wait, previous operation is still processing...', 'warning');
            return;
        }
        
        if (!pendingChanges || pendingChanges.length === 0) {
            showToast('No changes to approve', 'warning');
            return;
        }
        
        var approvalData = [];
        
        pendingChanges.forEach(function(change) {
            var approvedDetails = [];
            if (change.changes && change.changes.length > 0) {
                change.changes.forEach(function(detail) {
                    var newVal = detail.newValue ? detail.newValue.toString().trim() : '';
                    var oldVal = detail.oldValue ? detail.oldValue.toString().trim() : '';
                    
                    if (newVal !== '' && newVal !== 'null' && newVal !== 'undefined' && oldVal !== newVal) {
                        detail.approved = true;
                        approvedDetails.push({
                            field: detail.field,
                            oldValue: detail.oldValue || '',
                            newValue: detail.newValue || '',
                            approved: true
                        });
                    }
                });
            }
            
            if (approvedDetails.length > 0) {
                approvalData.push({
                    id: change.id,
                    changes: approvedDetails
                });
            }
        });
        
        if (approvalData.length > 0) {
            console.log('Sending approval data:', approvalData);
            submitApproval(approvalData);
        } else {
            showToast('No valid changes to approve', 'warning');
        }
    }
    
    function approveSelectedChanges() {
        if (isProcessing) {
            showToast('Please wait, previous operation is still processing...', 'warning');
            return;
        }
        
        if (!pendingChanges || pendingChanges.length === 0) {
            showToast('No changes to approve', 'warning');
            return;
        }
        
        var approvalData = [];
        
        pendingChanges.forEach(function(change) {
            var approvedDetails = [];
            if (change.changes && change.changes.length > 0) {
                change.changes.forEach(function(detail) {
                    if (detail.approved === true) {
                        var newVal = detail.newValue ? detail.newValue.toString().trim() : '';
                        var oldVal = detail.oldValue ? detail.oldValue.toString().trim() : '';
                        
                        if (newVal !== '' && newVal !== 'null' && newVal !== 'undefined' && oldVal !== newVal) {
                            approvedDetails.push({
                                field: detail.field,
                                oldValue: detail.oldValue || '',
                                newValue: detail.newValue || '',
                                approved: true
                            });
                        }
                    }
                });
            }
            
            if (approvedDetails.length > 0) {
                approvalData.push({
                    id: change.id,
                    changes: approvedDetails
                });
            }
        });
        
        if (approvalData.length > 0) {
            console.log('Sending approval data:', approvalData);
            submitApproval(approvalData);
        } else {
            showToast('No changes selected for approval', 'warning');
        }
    }
    
    function submitApproval(approvalData) {
        if (!approvalData || approvalData.length === 0) {
            showToast('No changes selected for approval', 'warning');
            return;
        }
        
        isProcessing = true;
        
        var requestPayload = {
            changes: approvalData
        };
        
        showToast('Processing ' + approvalData.length + ' records...', 'info');
        
        $.ajax({
            url: '${pageContext.request.contextPath}/approveChanges',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(requestPayload),
            dataType: 'json',
            timeout: 60000,
            success: function(response) {
                isProcessing = false;
                console.log('Response:', response);
                
                if (response.status === 'success') {
                    showToast('Successfully updated ' + approvalData.length + ' records!', 'success');
                    closeModal();
                    setTimeout(function() {
                        location.reload();
                    }, 2000);
                } else {
                    showToast('Error: ' + (response.message || 'Unknown error'), 'error');
                }
            },
            error: function(xhr, status, error) {
                isProcessing = false;
                console.error('Error details:', xhr, status, error);
                console.error('Request payload:', requestPayload);
                
                var errorMsg = 'Error: ';
                if (xhr.status === 400) {
                    errorMsg += 'Invalid request format. ';
                    if (xhr.responseText) {
                        errorMsg += 'Server response: ' + xhr.responseText.substring(0, 200);
                    }
                } else if (xhr.status === 413) {
                    errorMsg += 'Request too large. Try with fewer changes.';
                } else if (xhr.status === 500) {
                    errorMsg += 'Server error. Please check server logs.';
                } else {
                    errorMsg += error;
                }
                showToast(errorMsg, 'error');
            }
        });
    }
    
    function closeModal() {
        if (!isProcessing) {
            document.getElementById('approvalModal').style.display = 'none';
            pendingChanges = [];
        } else {
            showToast('Please wait, processing in progress...', 'warning');
        }
    }
    
    function showToast(message, type) {
        var toast = document.getElementById('toast');
        var icon = '';
        
        switch(type) {
            case 'success':
                icon = '<i class="fas fa-check-circle"></i> ';
                toast.style.background = 'linear-gradient(135deg, #00b894, #00a884)';
                break;
            case 'error':
                icon = '<i class="fas fa-exclamation-circle"></i> ';
                toast.style.background = 'linear-gradient(135deg, #ff6b6b, #ee5a24)';
                break;
            case 'warning':
                icon = '<i class="fas fa-exclamation-triangle"></i> ';
                toast.style.background = 'linear-gradient(135deg, #fdcb6e, #f9a825)';
                break;
            default:
                icon = '<i class="fas fa-info-circle"></i> ';
                toast.style.background = 'linear-gradient(135deg, #667eea, #764ba2)';
        }
        
        toast.innerHTML = icon + message;
        toast.className = 'toast show';
        
        setTimeout(function() {
            toast.className = toast.className.replace('show', '');
        }, 3000);
    }
    
    window.onclick = function(event) {
        var modal = document.getElementById('approvalModal');
        if (event.target == modal && !isProcessing) {
            closeModal();
        }
    }
</script>
</body>
</html>