<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Plant Management - CAPEX System</title>

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
            --gray-600: #4b5563;
            --gray-700: #374151;
            --gray-800: #1f2937;
            --gray-900: #111827;
            --red-600: #dc2626;
            --green-600: #16a34a;
            --radius-sm: 6px;
            --radius-md: 10px;
        }

        * { margin:0; padding:0; box-sizing:border-box; }

        body {
            font-family: 'Inter', system-ui, sans-serif;
            background: var(--gray-50);
            color: var(--gray-900);
            line-height: 1.5;
            min-height: 100vh;
        }

        .header {
            background: linear-gradient(135deg, var(--gray-800) 0%, #1e293b 100%);
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .header-left { display: flex; align-items: center; gap: 1.25rem; }
        .header-left h1 { font-size: 1.375rem; font-weight: 600; }
        .header-left p  { font-size: 0.875rem; opacity: 0.85; margin-top: 0.125rem; }

        .header-right { display: flex; align-items: center; gap: 1.25rem; }
        .user-info { display: flex; align-items: center; gap: 0.75rem; font-size: 0.95rem; }

        .btn {
            padding: 0.5rem 1.125rem;
            border-radius: var(--radius-sm);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.15s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        .btn:hover { transform: translateY(-1px); }
        .btn-primary     { background: var(--primary);    color: white; }
        .btn-primary:hover { background: var(--primary-dark); }
        .btn-secondary   { background: white; border: 1px solid var(--gray-300); color: var(--gray-800); }

        .container {
            max-width: 1480px;
            margin: 1.75rem auto;
            padding: 0 1.5rem;
        }

        .page-title-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.75rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .page-title {
            font-size: 1.75rem;
            font-weight: 600;
            color: var(--gray-800);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .table-card {
            background: white;
            border-radius: var(--radius-md);
            box-shadow: 0 4px 14px rgba(0,0,0,0.06);
            overflow: hidden;
        }

        .table-header {
            padding: 1.125rem 1.5rem;
            background: var(--gray-50);
            border-bottom: 1px solid var(--gray-200);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .table-title { font-size: 1.125rem; font-weight: 600; color: var(--gray-800); }

        .search-wrapper {
            position: relative;
            width: 320px;
            min-width: 220px;
        }
        .search-wrapper input {
            width: 100%;
            padding: 0.625rem 0.875rem 0.625rem 2.5rem;
            border: 1px solid var(--gray-300);
            border-radius: var(--radius-sm);
            font-size: 0.95rem;
        }
        .search-wrapper i {
            position: absolute;
            left: 0.875rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray-500);
        }

        table { width: 100%; border-collapse: collapse; }
        th {
            background: var(--gray-800);
            color: white;
            padding: 0.875rem 1rem;
            text-align: left;
            font-weight: 600;
            font-size: 0.9rem;
            white-space: nowrap;
        }
        td {
            padding: 0.875rem 1rem;
            border-bottom: 1px solid var(--gray-200);
            font-size: 0.95rem;
            vertical-align: middle;
        }

        .budget-cell {
            text-align: right;
            font-family: 'Courier New', monospace;
            font-weight: 500;
            color: #1e40af;
        }
        .budget-zero { color: var(--red-600); font-style: italic; }

        .status-pill {
            padding: 0.35rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        .status-active  { background: #ecfdf5; color: #065f46; }
        .status-inactive { background: #fef2f2; color: #991b1b; }

        tr:hover { background: var(--gray-50); }

        .modal-backdrop {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.55);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 2000;
        }
        .modal-backdrop.active { display: flex; }

        .modal-content {
            background: white;
            border-radius: var(--radius-md);
            width: 92%;
            max-width: 760px;
            max-height: 94vh;
            overflow-y: auto;
            box-shadow: 0 20px 40px rgba(0,0,0,0.25);
        }

        .modal-header {
            background: var(--gray-800);
            color: white;
            padding: 1.125rem 1.75rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .modal-header h3 { font-size: 1.25rem; font-weight: 600; }

        .modal-body { padding: 1.75rem; }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 1.5rem 2rem;
            margin-bottom: 1.25rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.375rem;
            font-weight: 500;
            color: var(--gray-700);
            font-size: 0.925rem;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 0.625rem 0.875rem;
            border: 1px solid var(--gray-300);
            border-radius: var(--radius-sm);
            font-size: 0.95rem;
            background: white;
            transition: border-color 0.15s;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(37,99,235,0.15);
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 1.25rem;
            border-top: 1px solid var(--gray-200);
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 0.5rem;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .page-btn {
            padding: 0.5rem 1rem;
            border: 1px solid var(--gray-300);
            background: white;
            border-radius: var(--radius-sm);
            cursor: pointer;
            font-size: 0.95rem;
            min-width: 40px;
            text-align: center;
        }
        .page-btn:hover { background: var(--gray-100); }
        .page-btn.active {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        .page-btn:disabled { opacity: 0.5; cursor: not-allowed; }

        @media (max-width: 768px) {
            .page-title-bar { flex-direction: column; align-items: flex-start; }
            .search-wrapper { width: 100%; }
            .form-row { grid-template-columns: 1fr; gap: 1.25rem; }
        }
    </style>
</head>
<body>

<header class="header">
    <div class="header-left">
        <div>
            <h1>CAPEX Management System</h1>
            <p>Plant Management</p>
        </div>
    </div>
    <div class="header-right">
        <div class="user-info">
            <i class="fas fa-user-circle" style="font-size:1.4rem;"></i>
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
        <div style="display:flex; gap:0.875rem;">
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
            <div class="table-title">Plants</div>
            <div class="search-wrapper">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search plants..." onkeyup="searchPlants()">
            </div>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Location</th>
                    <th>SBU</th>
                    <th>Plant Code</th>
                    <th>Plant Name</th>
                    <th>Total Available Budget</th>
                    <th>Status</th>
                    <th style="text-align:right; width:110px;">Actions</th>
                </tr>
            </thead>
            <tbody id="tableBody"></tbody>
        </table>
    </div>

    <div class="pagination" id="pagination"></div>
</div>

<!-- Modal -->
<div class="modal-backdrop" id="plantModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 id="modalTitle">Add New Plant</h3>
            <button onclick="closePlantModal()">×</button>
        </div>
        <c:set var="seenLocations" value="" />
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
                                <option value="${sbuItem.sbu}">${sbuItem.sbu} - ${sbuItem.sbu_name}</option>
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

                <div class="form-row">
                    <div class="form-group">
                        <label for="total_available_budget_fy">Total Available Budget</label>
                        <input type="number" id="total_available_budget_fy" name="total_available_budget_fy"
                               min="0" step="1" placeholder="0">
                        <small style="color:#6b7280; display:block; margin-top:4px;">
                            Enter amount in whole numbers
                        </small>
                    </div>

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

    function formatBudget(value) {
        if (value == null || value === '') return '—';
        var num = Number(value);
        return isNaN(num) ? '—' : num.toLocaleString('en-IN');
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
            tbody.innerHTML = '<tr><td colspan="8" style="text-align:center; padding:60px 20px;">No matching plants found</td></tr>';
            document.getElementById('pagination').innerHTML = '';
            return;
        }

        for (var j = 0; j < pageItems.length; j++) {
            var p = pageItems[j];
            var budgetStr = formatBudget(p.total_available_budget_fy);
            var budgetCls = (p.total_available_budget_fy == null || p.total_available_budget_fy === 0) ? ' budget-zero' : '';

            var row = '<tr>' +
                '<td>' + (start + j + 1) + '</td>' +
                '<td>' + (p.location || '—') + '</td>' +
                '<td>' + (p.sbu || '—') + '</td>' +
                '<td>' + (p.plant_code || '—') + '</td>' +
                '<td>' + (p.plant_name || '—') + '</td>' +
                '<td class="budget-cell' + budgetCls + '">' + budgetStr + '</td>' +
                '<td><span class="' + (p.status === 'Active' ? 'status-active' : 'status-inactive') + '">' +
                    (p.status || 'Inactive') +
                '</span></td>' +
                '<td style="text-align:right;">' +
                    '<button class="btn btn-secondary" style="padding:6px 10px;" onclick="editPlant(\'' + p.id + '\')"><i class="fas fa-edit"></i></button> ' +
                    '<button class="btn btn-secondary" style="padding:6px 10px; color:#ef4444;" onclick="deletePlant(\'' + p.id + '\')"><i class="fas fa-trash"></i></button>' +
                '</td>' +
            '</tr>';

            tbody.innerHTML += row;
        }

        var pgHtml = '';
        if (totalPages > 1) {
            pgHtml += '<button class="page-btn" ' + (currentPage === 1 ? 'disabled' : '') +
                      ' onclick="if(currentPage>1){currentPage--;populateTable(plants);}"><i class="fas fa-chevron-left"></i></button>';
            for (var pg = 1; pg <= totalPages; pg++) {
                pgHtml += '<button class="page-btn' + (pg === currentPage ? ' active' : '') +
                          '" onclick="currentPage=' + pg + ';populateTable(plants);">' + pg + '</button>';
            }
            pgHtml += '<button class="page-btn" ' + (currentPage === totalPages ? 'disabled' : '') +
                      ' onclick="if(currentPage<' + totalPages + '){currentPage++;populateTable(plants);}"><i class="fas fa-chevron-right"></i></button>';
        }
        document.getElementById('pagination').innerHTML = pgHtml;
    }

    function loadPlants() {
        $.ajax({
            url: baseUrl + '/ajax/getPlantList',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                plants = data || [];
                populateTable(plants);
            },
            error: function() {
                document.getElementById('tableBody').innerHTML =
                    '<tr><td colspan="8" style="text-align:center; color:#dc2626; padding:60px;">Error loading plants</td></tr>';
            }
        });
    }

    function editPlant(id) {
        $.ajax({
            url: baseUrl + '/ajax/getPlantById/' + id,
            type: 'GET',
            dataType: 'json',
            success: function(p) {
                if (!p) return alert('Plant not found');

                document.getElementById('modalTitle').innerText = 'Edit Plant';
                document.getElementById('plant_id').value = p.id || '';
                document.getElementById('location').value = p.location || '';
                document.getElementById('sbu').value = p.sbu || '';
                document.getElementById('plant_code').value = p.plant_code || '';
                document.getElementById('plant_name').value = p.plant_name || '';
                document.getElementById('status').value = p.status || 'Active';
                document.getElementById('total_available_budget_fy').value = p.total_available_budget_fy || '';

                document.getElementById('plantModal').classList.add('active');
            }
        });
    }

    function openAddPlantModal() {
        document.getElementById('modalTitle').innerText = 'Add New Plant';
        document.getElementById('plantForm').reset();
        document.getElementById('plant_id').value = '';
        document.getElementById('status').value = 'Active';
        document.getElementById('total_available_budget_fy').value = '';
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

        var url = formData.id ? baseUrl + '/plant/update' : baseUrl + '/plant/add';

        $.post(url, formData, function() {
            alert('Saved successfully');
            closePlantModal();
            loadPlants();
        }).fail(function() {
            alert('Save failed');
        });
    }

    function deletePlant(id) {
        if (!confirm('Delete this plant?')) return;
        $.post(baseUrl + '/plant/delete/' + id, function() {
            alert('Deleted');
            loadPlants();
        }).fail(function() {
            alert('Delete failed');
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
        if (confirm('Logout?')) {
            window.location = baseUrl + '/logout';
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        loadPlants();
    });
</script>
</body>
</html>