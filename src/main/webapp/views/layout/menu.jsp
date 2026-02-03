<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu</title>

    <!-- Feather Icons CDN -->
    <link rel="stylesheet" href="https://unpkg.com/feather-icons/dist/feather.css">

    <style>
        :root {
            --primary: #10b981;        /* emerald-500 */
            --primary-dark: #059669;    /* emerald-700 */
            --primary-glow: rgba(16, 185, 129, 0.35);
            --hover-bg: #f1f5f9;
            --active-gradient: linear-gradient(110deg, #10b981 0%, #059669 100%);
            --text: #1f2937;
            --text-light: #4b5563;
        }

        .main-menu-content {
            position: sticky;
            top: 0;
            background: white;
            border-bottom: 1px solid #e5e7eb;
            z-index: 1000;
            box-shadow: 0 4px 14px rgba(0,0,0,0.06);
        }

        #main-menu-navigation {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            margin: 0;
            list-style: none;
            overflow-x: auto;
            scrollbar-width: thin;
            -webkit-overflow-scrolling: touch;
        }

        #main-menu-navigation::-webkit-scrollbar {
            height: 6px;
        }

        #main-menu-navigation::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 3px;
        }

        .nav-item > a.nav-link {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 16px;
            border-radius: 10px;
            font-weight: 500;
            color: var(--text-light);
            transition: all 0.28s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            white-space: nowrap;
        }

        .nav-item > a.nav-link:hover {
            background: var(--hover-bg);
            color: var(--primary-dark);
            transform: translateY(-1px);
        }

        /* Active parent item */
        .nav-item.active > a.nav-link,
        .nav-item.active > a.dropdown-toggle {
            background: var(--active-gradient);
            color: white !important;
            box-shadow: 0 6px 16px var(--primary-glow);
            transform: translateY(-1px);
        }

        /* Active child item (dropdown) */
        .dropdown-menu .dropdown-item.active,
        .dropdown-menu .dropdown-item:active {
            background: var(--primary);
            color: white;
            font-weight: 600;
        }

        .dropdown-menu {
            border: none;
            border-radius: 12px;
            box-shadow: 0 12px 32px rgba(0,0,0,0.14);
            padding: 8px 0;
            margin-top: 8px;
            min-width: 220px;
            background: white;
            overflow: hidden;
        }

        .dropdown-item {
            padding: 10px 20px;
            font-size: 0.95rem;
            color: var(--text);
            transition: all 0.2s ease;
        }

        .dropdown-item:hover {
            background: #f0fdf4;
            color: var(--primary-dark);
            padding-left: 24px;
        }

        .dropdown-item.active {
            background: var(--primary) !important;
            color: white !important;
        }

        /* Icons */
        i[data-feather] {
            width: 20px;
            height: 20px;
            stroke-width: 2.2;
        }

        /* Floating CTA */
        .floating-cta {
            position: fixed;
            bottom: 28px;
            right: 28px;
            z-index: 1050;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .floating-cta .btn-raise {
            background: #ef4444;
            color: white;
            font-weight: 600;
            padding: 14px 24px;
            border-radius: 50px;
            box-shadow: 0 10px 25px rgba(239, 68, 68, 0.4);
            transition: all 0.3s ease;
            border: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .floating-cta .btn-raise:hover {
            transform: translateY(-3px);
            box-shadow: 0 16px 35px rgba(239, 68, 68, 0.5);
            background: #dc2626;
        }

        .badge-new {
            background: #3b82f6;
            color: white;
            font-size: 0.68rem;
            padding: 4px 10px;
            border-radius: 20px;
            font-weight: 600;
        }

        @media (max-width: 992px) {
            #main-menu-navigation {
                padding: 8px 12px;
                gap: 6px;
            }

            .nav-item > a.nav-link {
                padding: 9px 14px;
                font-size: 0.94rem;
            }
        }

        @media (max-width: 768px) {
            .floating-cta {
                bottom: 16px;
                right: 16px;
            }
        }
    </style>
</head>
<body>

<div class="navbar-container main-menu-content" data-menu="menu-container" id="menu">
    <ul class="nav navbar-nav" id="main-menu-navigation" data-menu="menu-navigation">

        <!-- USER DASHBOARD -->
        <c:if test="${sessionScope.BASE_ROLE ne 'Admin' && sessionScope.BASE_ROLE ne 'Management'}">
        <li class="nav-item" id="home" data-url="/home">
            <a class="nav-link d-flex align-items-center" href="<%=request.getContextPath()%>/home">
                <i data-feather="home"></i>
                <span>Dashboard</span>
            </a>
        </li>
        </c:if>

        <!-- ADMIN / MANAGEMENT DASHBOARD -->
        <c:if test="${sessionScope.BASE_ROLE eq 'Admin' || sessionScope.BASE_ROLE eq 'Management'}">
        <li class="dropdown nav-item" id="home">
            <a class="dropdown-toggle nav-link d-flex align-items-center" href="#" data-bs-toggle="dropdown">
                <i data-feather="layout"></i>
                <span>Dashboard</span>
            </a>
            <ul class="dropdown-menu">
                <li id="homeChild0" data-url="/home" onclick="exFunction('homeChild0')">
                    <a class="dropdown-item" href="<%=request.getContextPath()%>/home">Power BI Dashboard</a>
                </li>
                <li id="homeChild1" data-url="/dash-sd" onclick="exFunction('homeChild1')">
                    <a class="dropdown-item" href="<%=request.getContextPath()%>/dash-sd">Secondary Dashboard</a>
                </li>
            </ul>
        </li>
        </c:if>

        <!-- MASTERS (Admin only) -->
        <c:if test="${sessionScope.BASE_ROLE eq 'Admin'}">
        <li class="dropdown nav-item" id="masters">
            <a class="dropdown-toggle nav-link d-flex align-items-center" href="#" data-bs-toggle="dropdown">
                <i data-feather="database"></i>
                <span>Masters</span>
            </a>
            <ul class="dropdown-menu">
                <c:forEach var="obj" items="${menuList}" varStatus="index">
                <li id="mastersChild${index.count}" data-url="${obj.module_url}"
                    onclick="exFunction('mastersChild${index.count}')">
                    <a class="dropdown-item" href="<%=request.getContextPath()%>${obj.module_url}">
                        ${obj.module_name}
                    </a>
                </li>
                </c:forEach>
            </ul>
        </li>
        </c:if>

        <!-- INCIDENT -->
        <li class="nav-item" id="irm" data-url="irm">
            <a class="nav-link d-flex align-items-center" href="<%=request.getContextPath()%>/irm">
                <i data-feather="alert-triangle"></i>
                <span>Incident Details</span>
            </a>
        </li>

        <!-- REPORTS -->
        <li class="nav-item" id="reports" data-url="irm-report">
            <a class="nav-link d-flex align-items-center" href="<%=request.getContextPath()%>/irm-report">
                <i data-feather="file-bar-chart"></i>
                <span>Incident Reports</span>
            </a>
        </li>

        <!-- HELP -->
        <li class="nav-item" id="help" data-url="help">
            <a class="nav-link d-flex align-items-center" href="<%=request.getContextPath()%>/help-center">
                <i data-feather="life-buoy"></i>
                <span>Help Center</span>
            </a>
        </li>

    </ul>
</div>

<!-- Floating CTA – modern style -->
<div class="floating-cta">
    <a href="/aayushh/irm-add-incident" class="btn btn-raise">
        <i data-feather="plus" style="width:18px;height:18px;"></i>
        Raise New Incident
    </a>
    <span class="badge-new">New</span>
</div>

<!-- Feather Icons initialization -->
<script src="https://unpkg.com/feather-icons"></script>
<script>
    feather.replace();

    // Optional: highlight active menu based on current URL
    document.addEventListener('DOMContentLoaded', () => {
        const currentPath = window.location.pathname;
        const menuItems = document.querySelectorAll('#main-menu-navigation .nav-item');

        menuItems.forEach(item => {
            const link = item.querySelector('a[href]');
            const dataUrl = item.dataset.url;

            if (link && link.getAttribute('href').includes(currentPath)) {
                item.classList.add('active');
            }
            // Also check child items
            else if (dataUrl && currentPath.includes(dataUrl)) {
                item.classList.add('active');
                // Optional: open parent dropdown if child is active
                const parentDropdown = item.closest('.dropdown');
                if (parentDropdown) {
                    parentDropdown.classList.add('active');
                }
            }
        });
    });
</script>

</body>
</html>