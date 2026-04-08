<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Plant Management – CAPEX System</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-300: #d1d5db;
            --gray-500: #6b7280;
            --gray-700: #374151;
            --gray-800: #1f2937;
            --gray-900: #111827;
            --red-500: #ef4444;
            --green-600: #16a34a;
            --radius-sm: 8px;
            --radius-md: 12px;
            --shadow-sm: 0 2px 8px rgba(0,0,0,0.08);
            --shadow-md: 0 10px 25px rgba(0,0,0,0.12);
            --shadow-card: 0 12px 32px rgba(0,0,0,0.14);
        }

        * { margin:0; padding:0; box-sizing:border-box; }

        body {
            font-family: 'Inter', system-ui, sans-serif;
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
            color: var(--gray-900);
            line-height: 1.6;
            min-height: 100vh;
        }

        .header {
            background: linear-gradient(135deg, var(--gray-900) 0%, #0f172a 100%);
            color: white;
            padding: 1.25rem 2.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 6px 20px rgba(0,0,0,0.3);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .header-left h1 { font-size: 1.5rem; font-weight: 700; letter-spacing: -0.025em; }
        .header-left p  { font-size: 0.9rem; opacity: 0.8; margin-top: 0.2rem; }

        .btn {
            padding: 0.6rem 1.3rem;
            border-radius: var(--radius-sm);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: var(--shadow-sm);
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        .btn-primary { background: var(--primary); color: white; }
        .btn-primary:hover { background: var(--primary-dark); }
        .btn-secondary { background: white; border: 1px solid var(--gray-300); color: var(--gray-800); }

        .container { max-width: 1520px; margin: 2.5rem auto; padding: 0 2rem; }

        .page-title-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1.25rem;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--gray-900);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .table-card {
            background: white;
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-card);
            overflow: hidden;
            transition: all 0.3s ease;
        }
        .table-card:hover { box-shadow: 0 20px 50px rgba(0,0,0,0.18); }

        .table-header {
            padding: 1.4rem 2rem;
            background: linear-gradient(to right, #f8fafc, #f1f5f9);
            border-bottom: 1px solid var(--gray-200);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1.25rem;
        }

        .table-title { font-size: 1.3rem; font-weight: 700; }

        .search-wrapper {
            position: relative;
            width: 360px;
            min-width: 260px;
        }
        .search-wrapper input {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 3rem;
            border: 1px solid var(--gray-300);
            border-radius: var(--radius-sm);
            font-size: 0.98rem;
        }
        .search-wrapper input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(37,99,235,0.12);
            outline: none;
        }
        .search-wrapper i {
            position: absolute;
            left: 1.1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray-500);
        }

        .table-responsive { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 1300px; }
        th {
            background: var(--gray-900);
            color: white;
            padding: 1rem 1.25rem;
            text-align: left;
            font-weight: 600;
            font-size: 0.92rem;
            white-space: nowrap;
        }
        td {
            padding: 1rem 1.25rem;
            border-bottom: 1px solid var(--gray-200);
            font-size: 0.97rem;
            vertical-align: middle;
            white-space: nowrap;
        }

        .budget-cell {
            text-align: right;
            font-family: 'Courier New', 'Consolas', monospace;
            font-weight: 600;
            color: #1e40af;
            letter-spacing: 0.4px;
            font-size: 1.02rem;
        }
        .budget-zero { color: var(--red-500); font-style: italic; }

        .status-pill {
            padding: 0.4rem 0.9rem;
            border-radius: 9999px;
            font-size: 0.82rem;
            font-weight: 600;
        }
        .status-active { background: #ecfdf5; color: #065f46; }
        .status-inactive { background: #fef2f2; color: #991b1b; }

        tr:hover { background: #f8fafc; }

        .modal-backdrop {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.6);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 2000;
            backdrop-filter: blur(4px);
        }
        .modal-backdrop.active { display: flex; }

        .modal-content {
            background: white;
            border-radius: var(--radius-md);
            width: 94%;
            max-width: 820px;
            max-height: 95vh;
            overflow-y: auto;
            box-shadow: 0 25px 60px rgba(0,0,0,0.3);
            transform: scale(0.95);
            transition: transform 0.25s ease;
        }
        .modal-backdrop.active .modal-content { transform: scale(1); }

        .modal-header {
            background: var(--gray-900);
            color: white;
            padding: 1.4rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-body {
            padding: 2.2rem 2.5rem !important;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
            gap: 1.75rem 2.25rem;
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--gray-700);
            font-size: 0.95rem;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid var(--gray-300);
            border-radius: var(--radius-sm);
            font-size: 0.98rem;
            transition: all 0.2s;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(37,99,235,0.12);
            outline: none;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1.25rem;
            margin-top: 2.25rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--gray-200);
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.6rem;
            margin-top: 2.5rem;
            flex-wrap: wrap;
        }

        .page-btn {
            padding: 0.6rem 1.1rem;
            border: 1px solid var(--gray-300);
            background: white;
            border-radius: var(--radius-sm);
            cursor: pointer;
            font-weight: 600;
            min-width: 44px;
            transition: all 0.2s;
        }
        .page-btn:hover { background: var(--gray-100); transform: translateY(-1px); }
        .page-btn.active {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        #toast {
            position: fixed;
            bottom: 32px;
            left: 50%;
            transform: translateX(-50%);
            background: #111827;
            color: white;
            padding: 1rem 2rem;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.4);
            opacity: 0;
            transition: opacity 0.4s, transform 0.4s;
            z-index: 3000;
            font-weight: 500;
        }
        #toast.show {
            opacity: 1;
            transform: translateX(-50%) translateY(-8px);
        }

        .loader-overlay {
            position: fixed;
            inset: 0;
            background: rgba(255,255,255,0.7);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 5000;
        }
        .loader {
            width: 60px;
            height: 60px;
            border: 6px solid #e5e7eb;
            border-top: 6px solid var(--primary);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        @keyframes spin { to { transform: rotate(360deg); } }

        @media (max-width: 768px) {
            .page-title-bar { flex-direction: column; align-items: flex-start; }
            .search-wrapper { width: 100%; }
            .form-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<div class="loader-overlay" id="loader"><div class="loader"></div></div>
<div id="toast"></div>

<header class="header">
    <div class="header-left">
        <div>
            <h1>CAPEX Management System</h1>
            <p>Plant Management</p>
        </div>
    </div>
    <div class="header-right">
        <div class="user-info" style="display:flex; align-items:center; gap:0.9rem; font-size:0.98rem;">
            <i class="fas fa-user-circle" style="font-size:1.6rem;"></i>
            <span><c:out value="${sessionScope.USER_NAME}" default="User"/></span>
        </div>
        <button class="btn btn-secondary" onclick="window.location='<c:url value='/home'/>'">Dashboard</button>
        <button class="btn btn-secondary" onclick="logout()">Logout</button>
    </div>
</header>

<div class="container">

    <div class="page-title-bar">
        <div class="page-title">
            <i class="fas fa-industry"></i>
            <span>Plant Management</span>
        </div>
        <div style="display:flex; gap:1rem;">
            <button class="btn btn-secondary" onclick="refreshData()">
                <i class="fas fa-rotate"></i> Refresh
            </button>
            <button class="btn btn-primary" onclick="openAddPlantModal()">
                <i class="fas fa-plus"></i> Add Plant
            </button>
        </div>
    </div>

    <div class="table-card">
        <div class="table-header">
            <div class="table-title">Plants List</div>
            <div class="search-wrapper">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search plants..." onkeyup="searchPlants()">
            </div>
        </div>

        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>Plant Code</th>
                        <th>Created Date</th>
                        <th>Created By</th>
                        <th>Modified Date</th>
                        <th>Modified By</th>
                        <th>Status</th>
                        <th style="text-align:right; width:120px;">Actions</th>
                    </tr>
                </thead>
                <tbody id="tableBody"></tbody>
            </table>
        </div>
    </div>

    <div class="pagination" id="pagination"></div>
</div>

<!-- Modal -->
<div class="modal-backdrop" id="plantModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 id="modalTitle">Add New Plant</h3>
            <button onclick="closePlantModal()" style="background:none;border:none;color:white;font-size:1.8rem;cursor:pointer;">×</button>
        </div>
        <div class="modal-body">
            <form id="plantForm" onsubmit="savePlant(event)">
                <div class="form-row">
                    <div class="form-group">
                        <label for="location">Location *</label>
                        <select id="location" name="location" required>
                            <option value="">— Select Location —</option>
                            <c:forEach var="loc" items="${locationList}">
                                <c:if test="${not fn:contains(seenLocations, loc.location)}">
                                    <option value="${loc.id}">${loc.location}</option>
                                    <c:set var="seenLocations" value="${seenLocations},${loc.location}" />
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="sbu">SBU *</label>
                        <select id="sbu" name="sbu" required>
                            <option value="">— Select SBU —</option>
                            <c:forEach var="sbuItem" items="${sbuList}">
                                <option value="${sbuItem.sbu}">${sbuItem.sbu} – ${sbuItem.sbu_name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="plant_code">Plant Code *</label>
                        <input type="text" id="plant_code" name="plant_code" required>
                    </div>

                    <div class="form-group">
                        <label for="plant_name">Plant Name *</label>
                        <input type="text" id="plant_name" name="plant_name" required>
                    </div>
                </div>

                <div class="form-row" id="turnoverRow">
                    <div class="form-group">
                        <label for="turn_over">Turnover (Cr) <small>(Add mode only)</small></label>
                        <input type="number" id="turn_over" name="turn_over" step="0.01" min="0" placeholder="e.g. 42.5">
                        <small style="color:var(--gray-500); display:block; margin-top:6px;">
                            Used to auto-calculate budget
                        </small>
                    </div>

                    <div class="form-group">
                        <label for="total_available_budget_fy">Total Available Budget (₹)</label>
                        <input type="number" id="total_available_budget_fy" name="total_available_budget_fy"
                               min="0" step="1" readonly placeholder="Will be auto-calculated">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="status">Status *</label>
                        <select id="status" name="status" required>
                            <option value="">— Select —</option>
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="closePlantModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save Plant</button>
                </div>

                <input type="hidden" id="plant_id" name="id">
            </form>
        </div>
    </div>
</div>

<script>
    var currentPage = 1;
    var itemsPerPage = 12;
    var baseUrl = '${pageContext.request.contextPath}';
    var plants = [];
    var isEditMode = false;

    function showToast(message, duration = 2800) {
        var toast = document.getElementById('toast');
        toast.textContent = message;
        toast.classList.add('show');
        setTimeout(function() { toast.classList.remove('show'); }, duration);
    }

    function showLoader() { 
        document.getElementById('loader').style.display = 'flex'; 
    }
    function hideLoader() { 
        document.getElementById('loader').style.display = 'none'; 
    }

    function formatBudget(value) {
        if (value == null || value === '' || value == 0) return '—';
        var num = Number(value);
        if (isNaN(num)) return '—';
        return '₹ ' + num.toLocaleString('en-IN');
    }

    function calculateBudgetFromTurnover(turn_over) {
        if (!turn_over || isNaN(turn_over) || turn_over <= 0) return 0;
        var budgetCr = 0;
        if (turn_over <= 10)  budgetCr = 1;
        else if (turn_over <= 25) budgetCr = 3;
        else if (turn_over <= 50) budgetCr = 7.5;
        else budgetCr = 15;
        return Math.round(budgetCr * 10000000);
    }

    function updateBudgetField() {
        if (isEditMode) return;

        var turnoverInput = document.getElementById('turn_over');
        var budgetInput = document.getElementById('total_available_budget_fy');

        var turnover = parseFloat(turnoverInput.value) || 0;
        var budgetInRupees = calculateBudgetFromTurnover(turnover);

        budgetInput.value = budgetInRupees;
    }

    function populateTable(data) {
        var tbody = document.getElementById('tableBody');
        var term = document.getElementById('searchInput').value.toLowerCase().trim();

        var filtered = [];
        for (var i = 0; i < data.length; i++) {
            var p = data[i];
            if ((p.location || '').toLowerCase().indexOf(term) >= 0 ||
                (p.sbu || '').toLowerCase().indexOf(term) >= 0 ||
                (p.plant_code || '').toLowerCase().indexOf(term) >= 0 ||
                (p.plant_name || '').toLowerCase().indexOf(term) >= 0 ||
                formatBudget(p.total_available_budget_fy).indexOf(term) >= 0) {
                filtered.push(p);
            }
        }

        filtered.sort(function(a, b) {
            return (parseInt(a.id) || 0) - (parseInt(b.id) || 0);
        });

        var totalPages = Math.ceil(filtered.length / itemsPerPage);
        var start = (currentPage - 1) * itemsPerPage;
        var pageItems = filtered.slice(start, start + itemsPerPage);

        tbody.innerHTML = '';

        if (pageItems.length === 0) {
            tbody.innerHTML = '<tr><td colspan="12" style="text-align:center;padding:80px 30px;font-size:1.1rem;color:#6b7280;">No matching plants found</td></tr>';
            document.getElementById('pagination').innerHTML = '';
            return;
        }

        for (var j = 0; j < pageItems.length; j++) {
            var p = pageItems[j];
            var budgetStr = formatBudget(p.total_available_budget_fy);
            var budgetCls = (p.total_available_budget_fy == null || p.total_available_budget_fy == 0) ? ' budget-zero' : '';

            var row = '<tr>' +
                '<td>' + (p.plant_code || 'N/A') + '</td>' +
              //  '<td class="budget-cell' + budgetCls + '">' + budgetStr + '</td>' +
                '<td>' + (p.created_date || 'N/A') + '</td>' +
                '<td>' + (p.created_by || 'N/A') + '</td>' +
                '<td>' + (p.modified_date || 'N/A') + '</td>' +
                '<td>' + (p.modified_by || 'N/A') + '</td>' +
                '<td><span class="' + (p.status === 'Active' ? 'status-active' : 'status-inactive') + ' status-pill">' +
                    (p.status || 'Inactive') +
                '</span></td>' +
                '<td style="text-align:right;">' +
                    '<button class="btn btn-secondary" style="padding:7px 11px;" ' +
                        'onclick="editPlant(' + p.id + ')"><i class="fas fa-edit"></i></button> ' +
                    '<button class="btn btn-secondary" style="padding:7px 11px;color:var(--red-500);" ' +
                        'onclick="deletePlant(' + p.id + ')"><i class="fas fa-trash"></i></button>' +
                '</td>' +
            '</tr>';

            tbody.innerHTML += row;
        }

        var pgHtml = '';
        if (totalPages > 1) {
            pgHtml += '<button class="page-btn" ' + (currentPage===1 ? 'disabled' : '') +
                      ' onclick="if(currentPage>1){currentPage--;populateTable(plants);}"><i class="fas fa-chevron-left"></i></button>';

            for (var pg = 1; pg <= totalPages; pg++) {
                pgHtml += '<button class="page-btn' + (pg === currentPage ? ' active' : '') +
                          '" onclick="currentPage=' + pg + ';populateTable(plants);">' + pg + '</button>';
            }

            pgHtml += '<button class="page-btn" ' + (currentPage===totalPages ? 'disabled' : '') +
                      ' onclick="if(currentPage<' + totalPages + '){currentPage++;populateTable(plants);}"><i class="fas fa-chevron-right"></i></button>';
        }
        document.getElementById('pagination').innerHTML = pgHtml;
    }

    function loadPlants() {
        showLoader();
        $.ajax({
            url: baseUrl + '/ajax/getPlantList',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                plants = data || [];
                populateTable(plants);
                hideLoader();
            },
            error: function() {
                document.getElementById('tableBody').innerHTML =
                    '<tr><td colspan="12" style="text-align:center;color:var(--red-500);padding:80px;font-size:1.1rem;">Error loading plants</td></tr>';
                hideLoader();
            }
        });
    }

    function editPlant(id) {
        showLoader();
        $.ajax({
            url: baseUrl + '/ajax/getPlantById/' + id,
            type: 'GET',
            dataType: 'json',
            success: function(p) {
                hideLoader();
                if (!p) {
                    showToast('Plant record not found');
                    return;
                }

                isEditMode = true;

                document.getElementById('modalTitle').textContent = 'Edit Plant';
                document.getElementById('plant_id').value = p.id || '';
                document.getElementById('location').value = p.location || '';
                document.getElementById('sbu').value = p.sbu || '';
                document.getElementById('plant_code').value = p.plant_code || '';
                document.getElementById('plant_name').value = p.plant_name || '';
                document.getElementById('status').value = p.status || 'Active';
                document.getElementById('turn_over').value = p.turn_over || 0;
                document.getElementById('total_available_budget_fy').value = p.total_available_budget_fy || 0;
                document.getElementById('plant_code').readOnly = true;
                document.getElementById('turnoverRow').style.display = 'grid';

                document.getElementById('plantModal').classList.add('active');
            },
            error: function() {
                hideLoader();
                showToast('Failed to load plant details');
            }
        });
    }

    function openAddPlantModal() {
        isEditMode = false;

        document.getElementById('modalTitle').textContent = 'Add New Plant';
        document.getElementById('plantForm').reset();
        document.getElementById('plant_id').value = '';
        document.getElementById('status').value = 'Active';
        document.getElementById('total_available_budget_fy').value = '';
        document.getElementById('turn_over').value = '';

        document.getElementById('turnoverRow').style.display = 'grid';

        document.getElementById('plantModal').classList.add('active');
    }

    function closePlantModal() {
        document.getElementById('plantModal').classList.remove('active');
    }

    function savePlant(e) {
        e.preventDefault();

        var formData = {
            id: document.getElementById('plant_id').value,
            location: document.getElementById('location').value,
            sbu: document.getElementById('sbu').value,
            plant_code: document.getElementById('plant_code').value,
            plant_name: document.getElementById('plant_name').value,
            status: document.getElementById('status').value,
            total_available_budget_fy: document.getElementById('total_available_budget_fy').value || null
        };

        var url = formData.id ? (baseUrl + '/plant/update') : (baseUrl + '/plant/add');

        showLoader();
        $.post(url, formData, function() {
            hideLoader();
            showToast('Plant saved successfully');
            closePlantModal();
            loadPlants();
        }).fail(function() {
            hideLoader();
            showToast('Failed to save plant');
        });
    }

    function deletePlant(id) {
        if (!confirm('Delete this plant?')) return;

        showLoader();
        $.post(baseUrl + '/plant/delete/' + id, function() {
            hideLoader();
            showToast('Plant deleted successfully');
            loadPlants();
        }).fail(function() {
            hideLoader();
            showToast('Failed to delete plant');
        });
    }

    function searchPlants() {
        currentPage = 1;
        populateTable(plants);
    }

    function refreshData() {
        loadPlants();
    }

    function logout() {
        if (confirm('Logout now?')) {
            window.location = baseUrl + '/logout';
        }
    }

    document.getElementById('turn_over').addEventListener('input', updateBudgetField);

    document.addEventListener('DOMContentLoaded', function() {
        loadPlants();
    });
</script>
</body>
</html>