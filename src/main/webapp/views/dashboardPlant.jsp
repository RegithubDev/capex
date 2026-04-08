<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Capital Expenditure Proposal</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
    .ai-loader {
    position: fixed;
    inset: 0;
    background: rgba(0,0,0,0.6);
    display: none;
    justify-content: center;
    align-items: center;
    z-index: 9999;
    backdrop-filter: blur(6px);
}

.ai-box {
    text-align: center;
    color: #fff;
    animation: fadeIn 0.4s ease;
}

.ai-brain {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    border: 4px solid #6366f1;
    border-top-color: transparent;
    animation: spin 1s linear infinite;
    margin: auto;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

@keyframes fadeIn {
    from { opacity: 0; transform: scale(0.9); }
    to { opacity: 1; transform: scale(1); }
}
    .reject-btn {
    background: #ef4444;
    color: #fff;
    margin-left: 10px;
}

.sendback-btn {
    background: #f59e0b;
    color: #fff;
    margin-left: 10px;
}
    /* ✅ Premium "Already Submitted" Badge - Elegant Blue-Gray Theme */
.badge-submitted {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: linear-gradient(135deg, #334155, #1e2937);   /* Slate Dark Blue-Gray */
    color: #e2e8f0;
    font-size: 0.88rem;
    font-weight: 700;
    padding: 10px 26px;
    border-radius: 50px;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    box-shadow: 
        0 8px 25px rgba(0, 0, 0, 0.5),
        inset 0 4px 12px rgba(255, 255, 255, 0.25),
        inset 0 -4px 12px rgba(0, 0, 0, 0.7);
    border: 2px solid #94a3b8;
    position: relative;
    overflow: hidden;
    transition: all 0.4s ease;
}

.badge-submitted:hover {
    transform: translateY(-3px) scale(1.03);
    box-shadow: 
        0 12px 30px rgba(148, 163, 184, 0.35),
        inset 0 4px 15px rgba(255, 255, 255, 0.3);
}

.badge-submitted::before {
    content: '📋';
    font-size: 1.1rem;
}

.badge-submitted::after {
    content: '';
    position: absolute;
    top: -50%;
    left: -100%;
    width: 50%;
    height: 200%;
    background: linear-gradient(
        120deg,
        transparent,
        rgba(255, 255, 255, 0.4),
        transparent
    );
    transform: skewX(-25deg);
    animation: shine 6s infinite linear;
}

/* Shine Animation */
@keyframes shine {
    0%   { left: -100%; }
    25%  { left: 200%; }
    100% { left: 200%; }
}
    /* ✅ Best Approved Badge - Green BG with 3D Premium Look */
.badge-approved {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: linear-gradient(135deg, #1e7e4a, #166534);   /* Deep Green Gradient */
    color: white;
    font-size: 0.88rem;
    font-weight: 700;
    padding: 10px 26px;
    border-radius: 50px;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    box-shadow: 
        0 8px 25px rgba(0, 0, 0, 0.5),
        inset 0 4px 12px rgba(255, 255, 255, 0.35),
        inset 0 -4px 12px rgba(0, 0, 0, 0.6);
    border: 2px solid #4ade80;
    position: relative;
    overflow: hidden;
    transition: all 0.4s ease;
}

.badge-approved:hover {
    transform: translateY(-3px) scale(1.04);
    box-shadow: 
        0 12px 30px rgba(74, 222, 128, 0.4),
        inset 0 4px 15px rgba(255, 255, 255, 0.45);
}

.badge-approved::before {
    content: '✓';
    font-size: 1.15rem;
    font-weight: bold;
    animation: checkPop 0.6s ease forwards;
}

.badge-approved::after {
    content: '';
    position: absolute;
    top: -50%;
    left: -100%;
    width: 50%;
    height: 200%;
    background: linear-gradient(
        120deg,
        transparent,
        rgba(255, 255, 255, 0.5),
        transparent
    );
    transform: skewX(-25deg);
    animation: shine 5s infinite linear;
}

/* Animations */
@keyframes checkPop {
    0%   { transform: scale(0) rotate(-20deg); }
    70%  { transform: scale(1.3) rotate(10deg); }
    100% { transform: scale(1) rotate(0); }
}

@keyframes shine {
    0%   { left: -100%; }
    20%  { left: 200%; }
    100% { left: 200%; }
}
    /* 🔥 Best 3D Signature Date - Black & Yellow Theme */
.approval-signature-date {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    background: linear-gradient(145deg, #1a1a1a, #0f0f0f);
    color: #ffd700;                    /* Gold Yellow */
    font-size: 0.82rem;
    font-weight: 600;
    padding: 10px 18px;
    border-radius: 50px;
    margin-top: 12px;
    box-shadow: 
        0 4px 15px rgba(0, 0, 0, 0.6),
        inset 0 2px 6px rgba(255, 215, 0, 0.15),
        inset 0 -2px 6px rgba(0, 0, 0, 0.8);
    border: 1px solid #ffd70033;
    transition: all 0.3s ease;
    width: fit-content;
}
.submit-btn, .reject-btn, .sendback-btn {
    transition: all 0.25s ease;
}

.submit-btn:hover,
.reject-btn:hover,
.sendback-btn:hover {
    transform: translateY(-2px) scale(1.03);
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
}

.submit-btn:active,
.reject-btn:active,
.sendback-btn:active {
    transform: scale(0.96);
}
.approval-signature-date:hover {
    transform: translateY(-2px);
    box-shadow: 
        0 8px 20px rgba(255, 215, 0, 0.25),
        inset 0 2px 6px rgba(255, 215, 0, 0.25);
}

.approval-signature-date i {
    color: #ffd700;
    font-size: 1.1rem;
    filter: drop-shadow(0 0 4px #ffd700);
    animation: pulse 2s infinite;
}

.approval-signature-date span {
    font-weight: 700;
    letter-spacing: 0.5px;
}

/* Glow Animation */
@keyframes pulse {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.7; }
}
.ai-btn {
    position: relative;
    padding: 10px 22px;
    border: none;
    border-radius: 10px;
    font-weight: 600;
    cursor: pointer;
    overflow: hidden;
    transition: all 0.3s ease;
    color: #fff;
}

/* 🔴 Reject */
.reject-btn {
    background: linear-gradient(135deg, #ef4444, #dc2626);
}

/* 🟠 Send Back */
.sendback-btn {
    background: linear-gradient(135deg, #f59e0b, #d97706);
}

/* Hover Glow */
.ai-btn:hover {
    transform: translateY(-2px) scale(1.04);
    box-shadow: 0 10px 25px rgba(0,0,0,0.3);
}

/* Click effect */
.ai-btn:active {
    transform: scale(0.95);
}

/* Loader inside button */
.btn-loader {
    width: 16px;
    height: 16px;
    border: 2px solid #fff;
    border-top-color: transparent;
    border-radius: 50%;
    position: absolute;
    right: 12px;
    top: 50%;
    transform: translateY(-50%);
    display: none;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    to { transform: translateY(-50%) rotate(360deg); }
}

/* Loading state */
.ai-btn.loading .btn-loader {
    display: block;
}

.ai-btn.loading .btn-text {
    opacity: 0.7;
}
/* Extra 3D Depth */
.approval-signature-date::before {
    content: '';
    position: absolute;
    top: -2px;
    left: -2px;
    right: -2px;
    bottom: -2px;
    background: linear-gradient(145deg, #ffd700, #b8860b);
    border-radius: 50px;
    z-index: -1;
    opacity: 0.15;
    filter: blur(8px);
}
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #f3f4f6;
            color: #1f2937;
            line-height: 1.5;
        }

        /* Compact Header */
        .capex-header {
            background: linear-gradient(135deg, #1e293b, #0f172a);
            color: white;
            padding: 12px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .capex-header-content {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .capex-icon img {
            height: 45px;
            filter: brightness(0) invert(1);
        }

        .capex-header h1 {
            font-size: 1.35rem;
            font-weight: 600;
            margin-bottom: 2px;
        }

        .capex-header p {
            font-size: 0.75rem;
            opacity: 0.85;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-info span {
            font-size: 0.85rem;
            background: rgba(255,255,255,0.15);
            padding: 6px 12px;
            border-radius: 20px;
        }

        .red-3d-button {
            display: inline-block;
            padding: 8px 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-decoration: none;
            color: white;
            background: #dc2626;
            border-radius: 8px;
            transition: all 0.2s ease;
            text-align: center;
        }

        .red-3d-button:hover {
            background: #b91c1c;
            transform: translateY(-1px);
        }

        /* Main Container */
        .capex-container {
            max-width: 1600px;
            margin: 20px auto;
            padding: 0 20px;
        }

        /* Compact Cards */
        .capex-card {
            background: white;
            border-radius: 12px;
            padding: 20px 24px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            border: 1px solid #e5e7eb;
        }

        .capex-card h3 {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 16px;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 8px;
            border-left: 3px solid #3b82f6;
            padding-left: 12px;
        }

        .capex-card h3 i {
            font-size: 1.2rem;
            color: #3b82f6;
        }

        /* Compact Grid Layout */
        .form-grid, .cost-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 16px;
            margin-bottom: 16px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: 500;
            margin-bottom: 6px;
            color: #4b5563;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .form-group label span {
            color: #ef4444;
        }

        .form-group input, 
        .form-group select, 
        .form-group textarea {
            padding: 8px 12px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 0.85rem;
            transition: all 0.2s;
        }

        .form-group input:focus, 
        .form-group select:focus, 
        .form-group textarea:focus {
            border-color: #3b82f6;
            outline: none;
            box-shadow: 0 0 0 3px rgba(59,130,246,0.1);
        }

        .full-width {
            grid-column: 1/-1;
        }

        textarea {
            min-height: 70px;
            resize: vertical;
        }

        .cost-group {
            background: #f9fafb;
            padding: 12px 16px;
            border-radius: 10px;
            border: 1px solid #e5e7eb;
        }

        .cost-group input, .cost-group select {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            margin-top: 6px;
        }

        .cost-group small {
            color: #6b7280;
            font-size: 0.7rem;
            display: block;
            margin-top: 4px;
        }

        /* Investment Grid - 3 columns */
        .investment-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .investment-group {
            background: #f9fafb;
            padding: 16px;
            border-radius: 10px;
            border: 1px solid #e5e7eb;
        }

        .investment-label {
            font-weight: 600;
            margin-bottom: 10px;
            display: block;
            color: #374151;
            font-size: 0.85rem;
        }

        .upload-container {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 10px;
        }

        .upload-btn {
            background: #3b82f6;
            color: white;
            padding: 6px 14px;
            border-radius: 6px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 0.75rem;
        }

        .upload-btn:hover {
            background: #2563eb;
        }

        /* Signature Grid */
        .signature-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .signature-card {
            background: #f9fafb;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            padding: 16px;
        }

        .signature-card h4 {
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 12px;
            color: #1f2937;
        }

        .signature-fields select,
        .signature-fields textarea {
            width: 100%;
            padding: 8px 12px;
            border-radius: 6px;
            border: 1px solid #d1d5db;
            font-size: 0.85rem;
            margin-top: 8px;
        }

        .signature-fields textarea {
            min-height: 60px;
            resize: vertical;
        }

        .approval-status {
            padding: 4px 10px;
            font-size: 0.7rem;
            font-weight: 600;
            color: #155724;
            background-color: #d4edda;
            border-radius: 20px;
            display: inline-block;
        }

        /* Approval Grid - 2 columns */
        .approval-grid-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }

        .approval-card-dynamic {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 16px;
            transition: all 0.2s;
        }

        .approval-card-dynamic.approved {
            border-left: 4px solid #10b981;
            background: #f0fdf4;
        }

        .approval-card-dynamic.in-progress {
            border-left: 4px solid #f59e0b;
            background: #fffbeb;
        }

        .approval-card-dynamic.pending {
            border-left: 4px solid #6b7280;
            background: #f9fafb;
            opacity: 0.8;
        }

        .approval-header-dynamic {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            padding-bottom: 8px;
            border-bottom: 1px solid #e5e7eb;
        }

        .approval-title-dynamic {
            font-size: 0.9rem;
            font-weight: 600;
            color: #1f2937;
        }

        .status-badge-dynamic {
            padding: 3px 10px;
            font-size: 0.7rem;
            font-weight: 600;
            border-radius: 20px;
        }

        .status-badge-dynamic.approved {
            background: #d1fae5;
            color: #065f46;
        }

        .status-badge-dynamic.in-progress {
            background: #fed7aa;
            color: #92400e;
        }

        .status-badge-dynamic.pending {
            background: #e5e7eb;
            color: #374151;
        }

        .approval-fields-dynamic select,
        .approval-fields-dynamic textarea {
            width: 100%;
            padding: 8px 12px;
            border-radius: 6px;
            border: 1px solid #d1d5db;
            font-size: 0.8rem;
            margin-bottom: 8px;
        }

        /* Finance Special Card */
        .approval-card-dynamic.finance-card-special {
            grid-column: span 2;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 0;
            overflow: hidden;
        }

        .approval-card-dynamic.finance-card-special .finance-header {
            background: rgba(0,0,0,0.1);
            padding: 16px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }

        .approval-card-dynamic.finance-card-special .approval-title-dynamic {
            color: white;
        }

        .approval-card-dynamic.finance-card-special .finance-section-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0;
            padding: 20px;
            background: white;
        }

        .approval-card-dynamic.finance-card-special .finance-left-card,
        .approval-card-dynamic.finance-card-special .finance-right-card {
            padding: 0 16px;
        }

        .approval-card-dynamic.finance-card-special .finance-left-card {
            border-right: 1px solid #e5e7eb;
        }

        .approval-card-dynamic.finance-card-special .finance-left-card h5,
        .approval-card-dynamic.finance-card-special .finance-right-card h5 {
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 16px;
            padding-bottom: 8px;
            border-bottom: 2px solid #667eea;
            color: #1f2937;
        }

        .finance-field-group {
            margin-bottom: 14px;
        }

        .finance-field-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
            font-size: 0.7rem;
            text-transform: uppercase;
            color: #6b7280;
        }

        .finance-field-group select,
        .finance-field-group input,
        .finance-field-group textarea {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 0.8rem;
        }

        .rejection-remarks {
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-radius: 8px;
            padding: 10px;
            margin-top: 10px;
        }

        .action-bar {
            display: flex;
            justify-content: center;
            margin: 20px 0 30px;
        }

        .submit-btn {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
            border: none;
            padding: 12px 40px;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
        }

        .alert {
            padding: 12px 16px;
            border-radius: 8px;
            margin: 15px 0;
            font-size: 0.85rem;
        }

        .alert-success {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }

        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .loading-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.7);
            display: none;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            z-index: 9999;
            color: white;
        }

        .loading-spinner {
            width: 40px;
            height: 40px;
            border: 3px solid rgba(255,255,255,0.3);
            border-top-color: white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .budget-warning {
            display: none;
            color: #dc2626;
            font-size: 0.7rem;
            margin-top: 5px;
        }

        .remove-btn {
            background: #ef4444;
            color: white;
            border: none;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            cursor: pointer;
            font-size: 12px;
            margin-left: 6px;
        }

        .char-count {
            font-size: 0.65rem;
            color: #6b7280;
            text-align: right;
            margin-top: 3px;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .investment-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .capex-header {
                flex-direction: column;
                gap: 10px;
                padding: 12px;
            }
            
            .capex-header-content {
                width: 100%;
                justify-content: center;
            }
            
            .form-grid, .cost-grid, .signature-grid, .investment-grid {
                grid-template-columns: 1fr;
            }
            
            .approval-grid-container {
                grid-template-columns: 1fr;
            }
            
            .approval-card-dynamic.finance-card-special {
                grid-column: span 1;
            }
            
            .approval-card-dynamic.finance-card-special .finance-section-grid {
                grid-template-columns: 1fr;
            }
            
            .approval-card-dynamic.finance-card-special .finance-left-card {
                border-right: none;
                border-bottom: 1px solid #e5e7eb;
                margin-bottom: 16px;
                padding-bottom: 16px;
            }
            
            .capex-card {
                padding: 16px;
            }
        }

        @media (max-width: 480px) {
            .capex-container {
                padding: 0 12px;
            }
            
            .user-info span {
                font-size: 0.7rem;
            }
            
            .submit-btn {
                padding: 10px 30px;
                font-size: 0.9rem;
            }
        }
        /* 🔥 LEGEND */

@keyframes glowPulse {
    0% { box-shadow: 0 0 0px rgba(255,193,7,0.3); }
    50% { box-shadow: 0 0 15px rgba(255,193,7,0.6); }
    100% { box-shadow: 0 0 0px rgba(255,193,7,0.3); }
}

/* 🚫 DISABLE BASIC INFO */
.capex-card.disabled-section {
    pointer-events: none;
    opacity: 0.85;
    cursor: not-allowed;
}
.capex-card.disabled-section * {
    cursor: not-allowed !important;
}
/* Centered Approval Legend - Modern & Clean */

/* ===== LEGEND WRAPPER (CENTERED) ===== */
.legend-wrapper.compact {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;   /* 🔥 center horizontally */
    justify-content: center;
    margin-bottom: 12px;
}

/* TITLE */
.legend-title {
     font-size: 18px;
    font-weight: 600;
    margin-bottom: 15px;
    color: #333;
    text-align: center;
}

/* ===== FLOW LINE ===== */
.legend-flow {
    display: flex;
    align-items: center;
    justify-content: center;   /* 🔥 center flow */
    width: 100%;
    max-width: 100%;
    flex-wrap: wrap;   
    margin-bottom: 2rem;        /* responsive */
}

/* ===== STEP (AUTO WIDTH + FLEX) ===== */
.legend-step {
    flex: 1;                  /* 🔥 auto adjust evenly */
    min-width: 110px;
    max-width: 160px;

    display: flex;
    align-items: center;
    justify-content: center;

    gap: 6px;
    padding: 8px 12px;

    font-size: 12px;
    border-radius: 30px;

    position: relative;
    overflow: hidden;

    /* GLASS + 3D */
    background: linear-gradient(145deg, rgba(255,255,255,0.6), rgba(240,240,240,0.2));
    backdrop-filter: blur(10px);

    border: 1px solid rgba(255,255,255,0.5);

    box-shadow:
        inset 0 2px 4px rgba(255,255,255,0.6),
        inset 0 -2px 4px rgba(0,0,0,0.05),
        0 4px 8px rgba(0,0,0,0.15);

    transition: all 0.3s ease;
}

/* 🔥 SHINE EFFECT */
.legend-step::before {
    content: '';
    position: absolute;
    top: 0;
    left: -75%;
    width: 50%;
    height: 100%;
    background: linear-gradient(120deg, rgba(255,255,255,0.6), transparent);
    transform: skewX(-25deg);
}

.legend-step:hover::before {
    animation: shineMove 1s forwards;
}

@keyframes shineMove {
    100% { left: 130%; }
}

/* TEXT */
.step-title {
    font-size: 12px;
    font-weight: 500;
}

/* ICON */
.step-icon {
    font-size: 11px;
}

/* ===== STATES ===== */

/* Approved */
.legend-approved {
    background: linear-gradient(145deg, rgba(40,167,69,0.25), rgba(40,167,69,0.1));
    color: #1b8a4b;
}

/* Pending */
.legend-pending {
    background: rgba(200,200,200,0.2);
    color: #777;
}

/* ACTIVE (GLOW) */
.legend-active {
    background: linear-gradient(145deg, rgba(0,123,255,0.25), rgba(0,123,255,0.1));
    color: #007bff;
    animation: activeGlow 1.5s infinite ease-in-out;
}

/* Glow */
@keyframes activeGlow {
    0% { box-shadow: 0 0 6px rgba(0,123,255,0.3); }
    50% { box-shadow: 0 0 14px rgba(0,123,255,0.7); }
    100% { box-shadow: 0 0 6px rgba(0,123,255,0.3); }
}

/* ACTIVE DOT */
.active-dot {
    animation: blinkDot 1s infinite;
}

@keyframes blinkDot {
    0%,100% { opacity: 1; }
    50% { opacity: 0.3; }
}

/* ===== CONNECTOR (ARROW STYLE) ===== */
.step-connector {
    flex: 0 0 auto;
    margin: 0 6px;
    font-size: 16px;
    color: #bbb;
    animation: arrowMove 1.2s infinite linear;
}

.step-connector.completed {
    color: #28a745;
}

@keyframes arrowMove {
    0% { transform: translateX(0px); opacity: 0.5; }
    50% { transform: translateX(4px); opacity: 1; }
    100% { transform: translateX(0px); opacity: 0.5; }
}
    </style>
</head>
<body>

<div id="loadingOverlay" class="loading-overlay">
    <div class="loading-spinner"></div>
    <p id="loadingText" style="margin-top: 12px;">Submitting proposal...</p>
</div>

<header class="capex-header">
    <div class="capex-header-content">
        <div class="capex-icon">
            <img src="/capex/resources/images/Ramky-Logo.png" alt="Logo">
        </div>
        <div>
            <h1>Capital Expenditure Proposal</h1>
            <p>
                <c:choose>
                    <c:when test="${not empty editList}">Edit - ${editList.capex_number}</c:when>
                    <c:otherwise>New Proposal</c:otherwise>
                </c:choose>
            </p>
        </div>
    </div>
    <div class="user-info">
       <%--  <span>Pending at: ${editList.role} (${editList.pendingAt})</span> --%>
        <a href="<%=request.getContextPath()%>/form/capex" class="red-3d-button">Go Back</a>
    </div>
</header>

<div class="capex-container">
    <c:if test="${editList.finance_status eq 'Rejected' || editList.finance_status eq 'On Hold'}">
        <div class="alert alert-error">
            <strong>${editList.finance_status} by Finance Department</strong>
        </div>
    </c:if>

    <form id="capexForm" 
          action="${not empty editList ? (pageContext.request.contextPath.concat('/form/update')) : (pageContext.request.contextPath.concat('/form/submit'))}"
          method="post" enctype="multipart/form-data">

        <input type="hidden" name="id" value="${editList.id}">
        <input type="hidden" name="capex_number" id="capex_number" value="${editList.capex_number}">

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">${errorMessage}</div>
        </c:if>
<div id="approvalLegendContainer" class="approval-legend"></div>
        <!-- Basic Information - Compact -->
        <section class="capex-card">
            <h3><i class="material-icons">description</i> Basic Information</h3>
            <div class="form-grid">
                <div class="form-group">
                    <label>CAPEX Title <span>*</span></label>
                    <input type="text" name="capex_title" value="${editList.capex_title}" required>
                </div>
                <div class="form-group">
                    <label>Plant Code <span>*</span></label>
                    <select id="plantCode" name="plant_code" required onchange="updateSbuAndLocation()">
                        <option value="">Select Plant</option>
                        <c:forEach var="obj" items="${pList}">
                            <option value="${obj.plant_code}" data-sbu="${obj.sbu}" data-location="${obj.location}" data-budget="${obj.total_available_budget_fy}" ${obj.plant_code == editList.plant_code ? 'selected' : ''}>
                                [${obj.plant_code}] - ${obj.plant_name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Department <span>*</span></label>
                    <select id="department" name="department" required>
                        <option value="">Select department</option>
                        <c:forEach var="obj" items="${departmentList}">
                            <option value="${obj.department_code}" ${obj.department_code == editList.department ? 'selected' : ''}>[${obj.department_code}] - ${obj.department_name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Business Unit</label>
                    <p id="displaySbu" style="background:#f3f4f6; padding:8px 12px; border-radius:8px;">${editList.business_unit}</p>
                    <input type="hidden" name="business_unit" id="businessUnit" value="${editList.business_unit}">
                </div>
                <div class="form-group">
                    <label>Location</label>
                    <p id="displayLocation" style="background:#f3f4f6; padding:8px 12px; border-radius:8px;">${editList.location}</p>
                    <input type="hidden" name="location" id="location" value="${editList.location}">
                </div>
                <div class="form-group">
                    <label>Available Budget (₹)</label>
                    <div id="displayBudget" style="background:#f3f4f6; padding:8px 12px; border-radius:8px;">—</div>
                </div>
            </div>
            <div class="form-group full-width">
                <label>Asset Description <span>*</span></label>
                <textarea name="asset_description" required>${editList.asset_description}</textarea>
            </div>
        </section>

        <!-- Cost Estimation - Compact -->
        <section class="capex-card">
            <h3><i class="material-icons">attach_money</i> Cost Estimation</h3>
            <div class="cost-grid">
                <div class="cost-group">
                    <label>Basic Cost (₹) <span>*</span></label>
                    <input type="number" id="basicCost" name="basic_cost" oninput="updateCostCalculations();validateBudgetLimit();" value="${editList.basic_cost}" step="0.01" min="0" required>
                    <div id="budgetWarning" class="budget-warning"></div>
                </div>
                <div class="cost-group">
                    <label>GST Rate <span>*</span></label>
                    <select id="gstRate" onchange="updateCostCalculations()" name="gst_rate" required>
                        <option value="">Select GST %</option>
                        <option value="5" ${editList.gst_rate == '5.00' ? 'selected' : ''}>5%</option>
                        <option value="12" ${editList.gst_rate == '12.00' ? 'selected' : ''}>12%</option>
                        <option value="18" ${editList.gst_rate == '18.00' ? 'selected' : ''}>18%</option>
                        <option value="28" ${editList.gst_rate == '28.00' ? 'selected' : ''}>28%</option>
                    </select>
                </div>
                <div class="cost-group">
                    <label>GST Amount (₹)</label>
                    <input type="text" id="gstAmount" name="gst_amount" value="${editList.gst_amount}" readonly>
                </div>
                <div class="cost-group">
                    <label>Total Cost (₹)</label>
                    <input type="text" id="totalCost" name="total_cost" value="${editList.total_cost}" readonly>
                </div>
            </div>
        </section>

        <!-- Investment Details - 3 columns compact -->
        <section class="capex-card">
            <h3><i class="material-icons">trending_up</i> Investment Details</h3>
            <div class="investment-grid">
                <div class="investment-group">
                    <label class="investment-label">ROI & Payback Period <span class="required">*</span></label>
                    <textarea name="roi_text" rows="3" required>${editList.roi_text}</textarea>
                    <div class="upload-container">
                        <label class="upload-btn"><i class="material-icons">attach_file</i> Upload
                            <input type="file" name="roiFile" accept=".pdf,.xls,.xlsx,.jpg,.jpeg,.png" hidden>
                        </label>
                    </div>
                    <input type="hidden" name="roi_file_name" value="${editList.roi_file_name}">
                    <c:if test="${not empty editList.roi_file_name}">
                        <div class="current-file"><a href="${pageContext.request.contextPath}/resources/Attachments/${editList.capex_number}/${editList.roi_file_name}" target="_blank">View</a></div>
                    </c:if>
                    <div class="file-name-display" id="roiFileDisplay"></div>
                </div>
                <div class="investment-group">
                    <label class="investment-label">Project Timeline <span class="required">*</span></label>
                    <textarea name="timeline_text" rows="3" required>${editList.timeline_text}</textarea>
                    <div class="upload-container">
                        <label class="upload-btn"><i class="material-icons">attach_file</i> Upload
                            <input type="file" name="timelineFile" accept=".pdf,.xls,.xlsx,.jpg,.jpeg,.png" hidden>
                        </label>
                    </div>
                    <input type="hidden" name="timeline_file_name" value="${editList.timeline_file_name}">
                    <c:if test="${not empty editList.timeline_file_name}">
                        <div class="current-file"><a href="${pageContext.request.contextPath}/resources/Attachments/${editList.capex_number}/${editList.timeline_file_name}" target="_blank">View</a></div>
                    </c:if>
                    <div class="file-name-display" id="timelineFileDisplay"></div>
                </div>
                <div class="investment-group">
                    <label class="investment-label">Reason for Purchase <span class="required">*</span></label>
                    <textarea name="reason_text" rows="3" required>${editList.reason_text}</textarea>
                    <div class="upload-container">
                        <label class="upload-btn"><i class="material-icons">attach_file</i> Upload
                            <input type="file" name="reasonFile" accept=".pdf,.xls,.xlsx,.jpg,.jpeg,.png" hidden>
                        </label>
                    </div>
                    <input type="hidden" name="reason_file_name" value="${editList.reason_file_name}">
                    <c:if test="${not empty editList.reason_file_name}">
                        <div class="current-file"><a href="${pageContext.request.contextPath}/resources/Attachments/${editList.capex_number}/${editList.reason_file_name}" target="_blank">View</a></div>
                    </c:if>
                    <div class="file-name-display" id="reasonFileDisplay"></div>
                </div>
            </div>
        </section>

        <!-- Digital Signature - 2 columns -->
        <section class="capex-card">
            <h3><i class="material-icons">create</i> Digital Signature</h3>
            <div class="signature-grid">
                <div class="signature-card">
                    <h4>Requested By</h4>
                    <div class="signature-fields">
                        <select name="requested_by_name" required>
                            <option value="">Select Employee</option>
                            <c:forEach var="obj" items="${uList1}">
                                <option value="${obj.user_id}" ${obj.user_id == editList.requested_by_name ? 'selected' : ''}>[${obj.user_id}] - ${obj.user_name}</option>
                            </c:forEach>
                        </select>
                    </div>
                 <c:if test="${not empty editList.requested_by_date}">
				    <small>
				        Signed on 
				        <fmt:formatDate value="${editList.requested_by_date}" 
				                        pattern="dd MMM yyyy hh:mm a"/>
				    </small>
				</c:if>
                </div>
                <div class="signature-card">
                    <h4>Project Manager</h4>
                    <c:if test="${not empty editList.project_manager_date}">
                        <span class="approval-status">Approved</span>
                    </c:if>
                    <div class="signature-fields">
                        <c:if test="${not empty fn:trim(editList.project_manager_date)}">
                            <select name="project_manager_name" id="projectManager" data-original="${editList.project_manager_name}">
                                <option value="">Select Name</option>
                                <c:forEach var="obj" items="${uList}">
                                    <option value="${obj.user_id}" data-plant="${obj.base_project}" ${obj.user_id == editList.project_manager_name ? 'selected' : ''}>[${obj.user_id}] - ${obj.user_name}</option>
                                </c:forEach>
                            </select>
                        </c:if>
                        <c:if test="${empty fn:trim(editList.project_manager_date)}">
                        <input type="hidden" name="current_pending_at" value="${editList.project_manager_name}">
                            <input type="hidden" name="project_manager_name" value="${editList.project_manager_name}">
                            <div class="bg-light" style="padding:8px; background:#f3f4f6; border-radius:6px;">${editList.project_manager_fullname}</div>
                        </c:if>
                    </div>
                     <c:if test="${not empty editList.project_manager_date}">
				    <small>
				        Signed on 
				        <fmt:formatDate value="${editList.project_manager_date}" 
				                        pattern="dd MMM yyyy hh:mm a"/>
				    </small>
				</c:if>
                </div>
            </div>
        </section>
 <input type="hidden" name="status" value="">
        <!-- Dynamic Approval Container -->
        <div id="dynamicApprovalContainer"></div>

        <div class="action-bar">
           <c:set var="hasPendingApproval" value="false" />
<c:set var="hasApproved" value="false" />

<c:if test="${sessionScope.USER_ID eq editList.project_manager_name}">
    <c:if test="${empty editList.project_manager_date}">
        <c:set var="hasPendingApproval" value="true"/>
    </c:if>
    <c:if test="${not empty editList.project_manager_date}">
        <c:set var="hasApproved" value="true"/>
    </c:if>
</c:if>

<c:if test="${sessionScope.USER_ID eq editList.head_of_plant_name}">
    <c:if test="${empty editList.head_of_plant_date}">
        <c:set var="hasPendingApproval" value="true"/>
    </c:if>
    <c:if test="${not empty editList.head_of_plant_date}">
        <c:set var="hasApproved" value="true"/>
    </c:if>
</c:if>

<c:if test="${sessionScope.USER_ID eq editList.finance_name}">
    <c:if test="${empty editList.finance_date}">
        <c:set var="hasPendingApproval" value="true"/>
    </c:if>
    <c:if test="${not empty editList.finance_date}">
        <c:set var="hasApproved" value="true"/>
    </c:if>
</c:if>

<c:if test="${sessionScope.USER_ID eq editList.regional_director_name}">
    <c:if test="${empty editList.regional_director_date}">
        <c:set var="hasPendingApproval" value="true"/>
    </c:if>
    <c:if test="${not empty editList.regional_director_date}">
        <c:set var="hasApproved" value="true"/>
    </c:if>
</c:if>

<c:if test="${sessionScope.USER_ID eq editList.head_projects_name}">
    <c:if test="${empty editList.head_projects_date}">
        <c:set var="hasPendingApproval" value="true"/>
    </c:if>
    <c:if test="${not empty editList.head_projects_date}">
        <c:set var="hasApproved" value="true"/>
    </c:if>
</c:if>

<c:if test="${sessionScope.USER_ID eq editList.finance_controller_name}">
    <c:if test="${empty editList.finance_controller_date}">
        <c:set var="hasPendingApproval" value="true"/>
    </c:if>
    <c:if test="${not empty editList.finance_controller_date}">
        <c:set var="hasApproved" value="true"/>
    </c:if>
</c:if>

<c:if test="${sessionScope.USER_ID eq editList.business_head_name}">
    <c:if test="${empty editList.business_head_date}">
        <c:set var="hasPendingApproval" value="true"/>
    </c:if>
    <c:if test="${not empty editList.business_head_date}">
        <c:set var="hasApproved" value="true"/>
    </c:if>
</c:if>

<c:if test="${sessionScope.USER_ID eq editList.cfo_name}">
    <c:if test="${empty editList.cfo_date}">
        <c:set var="hasPendingApproval" value="true"/>
    </c:if>
    <c:if test="${not empty editList.cfo_date}">
        <c:set var="hasApproved" value="true"/>
    </c:if>
</c:if>

<c:if test="${sessionScope.USER_ID eq editList.ceo_name}">
    <c:if test="${empty editList.ceo_date}">
        <c:set var="hasPendingApproval" value="true"/>
    </c:if>
    <c:if test="${not empty editList.ceo_date}">
        <c:set var="hasApproved" value="true"/>
    </c:if>
</c:if>
<c:choose>

    <c:when test="${editList.status eq 'Rejected'}">
        <div style="display:flex; flex-direction:column; gap:6px; margin-top:10px;">
            
           <div style="
    display:flex;
    flex-direction:column;
    gap:8px;
    margin-top:12px;
    padding:14px 16px;
    border-radius:10px;
    background:linear-gradient(135deg,#fff5f5,#ffe4e6);
    border:1px solid #fecaca;
    box-shadow:0 4px 12px rgba(0,0,0,0.05);
    max-width:420px;
">

    <div style="display:flex; align-items:center; gap:8px;">
        <span style="
            background:#dc2626;
            color:#fff;
            padding:4px 10px;
            font-size:12px;
            border-radius:999px;
            font-weight:600;
            letter-spacing:0.5px;
        ">
            ● Rejected
        </span>
    </div>

    <c:if test="${not empty editList.updated_at}">
        <div style="
            font-size:13px;
            color:#6b7280;
            display:flex;
            align-items:center;
            gap:6px;
        ">
            <i class="fas fa-clock" style="font-size:12px;"></i>
            <span>
                Rejected on 
                <fmt:formatDate value="${editList.updated_at}" 
                                pattern="dd MMM yyyy hh:mm a"/>
            </span>
        </div>
    </c:if>

    <c:if test="${not empty editList.reject_remarks}">
        <div style="
            font-size:13px;
            color:#7f1d1d;
            background:#fff;
            padding:8px 10px;
            border-radius:6px;
            border-left:3px solid #dc2626;
            line-height:1.4;
        ">
            <strong style="color:#b91c1c;">Reason:</strong>
            ${editList.reject_remarks}
        </div>
    </c:if>

</div>

        </div>
    </c:when>


    <c:when test="${(sessionScope.BASE_ROLE eq 'Admin' || hasPendingApproval) && editList.status ne 'Approved'}">
      
        <div style="display:flex; gap:12px; align-items:center; margin-top:10px;">

            <button type="button" class="ai-btn reject-btn"
                onclick="rejectProposal()"
                style="height:42px; padding:0 18px; display:flex; align-items:center;">
                <span class="btn-text">Reject</span>
                <span class="btn-loader"></span>
            </button>

            <button type="submit" class="submit-btn"
                style="height:42px; padding:0 18px;">
                ${not empty editList ? 'Update Proposal' : 'Submit Proposal'}
            </button>

            <button type="button" class="ai-btn sendback-btn"
                onclick="openSendBackPopup()"
                style="height:42px; padding:0 18px; display:flex; align-items:center;">
                <span class="btn-text">Send Back</span>
                <span class="btn-loader"></span>
            </button>

        </div>
        
    </c:when>


    <c:when test="${hasApproved && editList.status ne 'Approved'}">
        <span class="badge badge-submitted" id="hideElement">Already Submitted</span>
    </c:when>


    <c:otherwise>
        <span class="badge badge-approved">Approved</span>
    </c:otherwise>

</c:choose>
  <div class="action-bar" id="hideDiv" style="display:none">
 <div style="display:flex; gap:12px; align-items:center; margin-top:10px;" >

            <button type="button" class="ai-btn reject-btn"
                onclick="rejectProposal()"
                style="height:42px; padding:0 18px; display:flex; align-items:center;">
                <span class="btn-text">Reject</span>
                <span class="btn-loader"></span>
            </button>

            <button type="submit" class="submit-btn"
                style="height:42px; padding:0 18px;">
                ${not empty editList ? 'Update Proposal' : 'Submit Proposal'}
            </button>

            <button type="button" class="ai-btn sendback-btn"
                onclick="openSendBackPopup()"
                style="height:42px; padding:0 18px; display:flex; align-items:center;">
                <span class="btn-text">Send Back</span>
                <span class="btn-loader"></span>
            </button>

        </div>
         </div>
        </div>
    </form>
</div>
<div id="aiLoader" class="ai-loader">
    <div class="ai-box">
        <div class="ai-brain"></div>
        <p id="aiText">Processing...</p>
    </div>
</div>
<script>
// [Include all your JavaScript functions here - the same as in your current code]
// Make sure to include: formatBudget, updateCostCalculations, validateBudgetLimit, 
// updateSbuAndLocation, getApproverTitle, getApproverKey, getApprovalOrderAndStatus,
// renderApprovalChain, loadAllApproverOptions, loadFinanceApproverOptions,
// getExistingApprovals, calculateBalance, setTotalBudget, clearFile, and all other functions

// Note: The full JavaScript code from your previous implementation should be placed here
// I'm showing the structure - you need to paste your existing JavaScript functions
var selectedPlantBudget = null;

function formatBudget(num) {
    if (!num && num !== 0) return '—';
    return Number(num).toLocaleString('en-IN');
}

function updateCostCalculations() {
    var basic = Number(document.getElementById('basicCost').value) || 0;
    var rate = Number(document.getElementById('gstRate').value) || 0;
    var gst = basic * (rate / 100);
    var total = basic + gst;
    document.getElementById('gstAmount').value = gst.toFixed(2);
    document.getElementById('totalCost').value = total.toFixed(2);
    
    if (document.getElementById('proposedPrice')) {
        document.getElementById('proposedPrice').value = total.toFixed(2);
        calculateBalance();
    }
    
    validateBudgetLimit();
    
    var amountLakhs = total / 100000;
    var dept = document.getElementById("department").value || "${editList.department}";
    var currentPending = "${editList.current_pending_at}";
    var existingApprovals = getExistingApprovals();
  
    if (amountLakhs > 0 && dept) {
        $.ajax({
            url: "<%=request.getContextPath()%>/form/getApprovalStatus",
            type: "GET",
            data: { lakhs: amountLakhs.toFixed(2), department: dept },
            dataType: "json",
            success: function(rules) {
                console.log("=== RULES FROM SERVER ===");
                console.log(JSON.stringify(rules, null, 2));
                renderApprovalChain(rules, existingApprovals, currentPending);
            },
            error: function(err) {
                console.log("Error loading approval rules:", err);
            }
        });
    }
}

function validateBudgetLimit() {
    if (selectedPlantBudget === null) return;
    var basicCost = Number(document.getElementById('basicCost').value) || 0;
    var warningEl = document.getElementById('budgetWarning');
    if (basicCost > selectedPlantBudget) {
        warningEl.textContent = 'Warning: Cost exceeds available budget!';
        warningEl.style.display = 'block';
    } else {
        warningEl.style.display = 'none';
    }
}

function updateSbuAndLocation() {
    var select = document.getElementById('plantCode');
    var opt = select.options[select.selectedIndex];
    if (!opt.value) return;
    document.getElementById('displaySbu').textContent = opt.dataset.sbu || '—';
    document.getElementById('displayLocation').textContent = opt.dataset.location || '—';
    document.getElementById('businessUnit').value = opt.dataset.sbu || '';
    document.getElementById('location').value = opt.dataset.location || '';
    var budgetRaw = opt.dataset.budget || '0';
    selectedPlantBudget = Number(budgetRaw);
    document.getElementById('displayBudget').textContent = selectedPlantBudget > 0 ? '₹ ' + formatBudget(selectedPlantBudget) : '—';
    
    if (document.getElementById('totalBudget')) {
        document.getElementById('totalBudget').value = selectedPlantBudget;
    }
    
    validateBudgetLimit();
}

function getApproverTitle(fieldName) {
    var map = {
        "head_of_plant_name": "Head of Plant",
        "regional_director_name": "Regional Director",
        "finance_controller_name": "Finance Controller",
        "head_projects_name": "Head Projects",
        "business_head_name": "Business Head",
        "cfo_name": "CFO",
        "ceo_name": "CEO & MD",
        "finance_name": "Finance Department"
    };
    return map[fieldName] || fieldName.replace(/_/g, ' ').replace(/\b\w/g, function(l) { return l.toUpperCase(); });
}

function getApproverKey(fieldName) {
    var map = {
        "head_of_plant_name": "head_of_plant",
        "regional_director_name": "regional_director",
        "finance_controller_name": "finance_controller",
        "head_projects_name": "head_projects",
        "business_head_name": "business_head",
        "cfo_name": "cfo",
        "ceo_name": "ceo",
        "finance_name": "finance"
    };
    return map[fieldName] || fieldName;
}

function renderApprovalChain(rules, existingApprovals, currentPendingAt) {
    var container = document.getElementById("dynamicApprovalContainer");
    if (!container) return;
    container.innerHTML = "";
    
    var projectManagerDate = "${editList.project_manager_date}";
    if (!projectManagerDate || projectManagerDate.trim() === "") {
        container.innerHTML = '<div class="alert alert-info">Approval chain will be available after Project Manager approval.</div>';
        return;
    }
    
    if (!rules || rules.length === 0) {
        container.innerHTML = '<div class="alert alert-info">No approval rules found for this proposal.</div>';
        return;
    }
    
    console.log("Rules from API:", rules);
    
    // Build approval steps based ONLY on rules from API
    var approvalSteps = [];
    var added = {};
    window.approvalSteps = approvalSteps;
    for (var i = 0; i < rules.length; i++) {
        var rule = rules[i];
        var prev = rule.previous_required_field;
        var final = rule.final_approver;
        
        if (prev && prev !== "NULL" && !added[prev]) {
            added[prev] = true;
            approvalSteps.push({
                fieldName: prev,
                title: getApproverTitle(prev),
                isFinal: false,
                stepOrder: approvalSteps.length + 1
            });
            console.log("Added step from API (prev): " + prev);
        }
        
        if (final && final !== "NULL" && !added[final]) {
            added[final] = true;
            approvalSteps.push({
                fieldName: final,
                title: getApproverTitle(final),
                isFinal: (i === rules.length - 1),
                stepOrder: approvalSteps.length + 1
            });
            console.log("Added step from API (final): " + final);
        }
    }
    
    console.log("Approval steps to display:", approvalSteps);
    
    if (approvalSteps.length === 0) {
        container.innerHTML = '<div class="alert alert-info">No approval steps required for this proposal.</div>';
        return;
    }
    
    // Get approval data from editList based on dates
    var approvedData = {};
    
    for (var i = 0; i < approvalSteps.length; i++) {
        var step = approvalSteps[i];
        var fieldName = step.fieldName;
        var dateValue = "";
        var idValue = "";
        var nameValue = "";
        
        // Get date values from JSP
        <c:if test="${not empty editList.head_of_plant_date}">
        if (fieldName === "head_of_plant_name") dateValue = "${editList.head_of_plant_date}";
        </c:if>
        <c:if test="${not empty editList.finance_date}">
        if (fieldName === "finance_name") dateValue = "${editList.finance_date}";
        </c:if>
        <c:if test="${not empty editList.regional_director_date}">
        if (fieldName === "regional_director_name") dateValue = "${editList.regional_director_date}";
        </c:if>
        <c:if test="${not empty editList.finance_controller_date}">
        if (fieldName === "finance_controller_name") dateValue = "${editList.finance_controller_date}";
        </c:if>
        <c:if test="${not empty editList.head_projects_date}">
        if (fieldName === "head_projects_name") dateValue = "${editList.head_projects_date}";
        </c:if>
        <c:if test="${not empty editList.business_head_date}">
        if (fieldName === "business_head_name") dateValue = "${editList.business_head_date}";
        </c:if>
        <c:if test="${not empty editList.cfo_date}">
        if (fieldName === "cfo_name") dateValue = "${editList.cfo_date}";
        </c:if>
        <c:if test="${not empty editList.ceo_date}">
        if (fieldName === "ceo_name") dateValue = "${editList.ceo_date}";
        </c:if>
        
        // Get ID values from JSP (employee ID)
        <c:if test="${not empty editList.head_of_plant_name}">
        if (fieldName === "head_of_plant_name") idValue = "${editList.head_of_plant_name}";
        </c:if>
        <c:if test="${not empty editList.finance_name}">
        if (fieldName === "finance_name") idValue = "${editList.finance_name}";
        </c:if>
        <c:if test="${not empty editList.regional_director_name}">
        if (fieldName === "regional_director_name") idValue = "${editList.regional_director_name}";
        </c:if>
        <c:if test="${not empty editList.finance_controller_name}">
        if (fieldName === "finance_controller_name") idValue = "${editList.finance_controller_name}";
        </c:if>
        <c:if test="${not empty editList.head_projects_name}">
        if (fieldName === "head_projects_name") idValue = "${editList.head_projects_name}";
        </c:if>
        <c:if test="${not empty editList.business_head_name}">
        if (fieldName === "business_head_name") idValue = "${editList.business_head_name}";
        </c:if>
        <c:if test="${not empty editList.cfo_name}">
        if (fieldName === "cfo_name") idValue = "${editList.cfo_name}";
        </c:if>
        <c:if test="${not empty editList.ceo_name}">
        if (fieldName === "ceo_name") idValue = "${editList.ceo_name}";
        </c:if>
        
        // Get Name values from JSP (full name)
        <c:if test="${not empty editList.head_of_plant_name}">
        if (fieldName === "head_of_plant_name") nameValue = "${editList.head_of_plant_name}";
        </c:if>
        <c:if test="${not empty editList.finance_name}">
        if (fieldName === "finance_name") nameValue = "${editList.finance_name}";
        </c:if>
        <c:if test="${not empty editList.regional_director_name}">
        if (fieldName === "regional_director_name") nameValue = "${editList.regional_director_name}";
        </c:if>
        <c:if test="${not empty editList.finance_controller_name}">
        if (fieldName === "finance_controller_name") nameValue = "${editList.finance_controller_name}";
        </c:if>
        <c:if test="${not empty editList.head_projects_name}">
        if (fieldName === "head_projects_name") nameValue = "${editList.head_projects_name}";
        </c:if>
        <c:if test="${not empty editList.business_head_name}">
        if (fieldName === "business_head_name") nameValue = "${editList.business_head_name}";
        </c:if>
        <c:if test="${not empty editList.cfo_name}">
        if (fieldName === "cfo_name") nameValue = "${editList.cfo_name}";
        </c:if>
        <c:if test="${not empty editList.ceo_name}">
        if (fieldName === "ceo_name") nameValue = "${editList.ceo_name}";
        </c:if>
        
        var isApproved = (dateValue && dateValue.trim() !== "");
        
        // Use full name if available, otherwise use ID
        var displayName = nameValue || idValue || "";
        
        approvedData[fieldName] = {
            isApproved: isApproved,
            approvalDate: dateValue,
            approverId: idValue,
            approverName: displayName
        };
        renderLegend(rules, approvedData);
        console.log("Step " + fieldName + ": isApproved=" + isApproved + ", approverId=" + idValue + ", approverName=" + displayName);
    }
    
    // Determine next approver
    var nextApprover = null;
    var lastApprovedIndex = -1;
    
    for (var i = 0; i < approvalSteps.length; i++) {
        var step = approvalSteps[i];
        if (approvedData[step.fieldName] && approvedData[step.fieldName].isApproved) {
            lastApprovedIndex = i;
        } else {
            break;
        }
    }
    
    if (lastApprovedIndex === approvalSteps.length - 1) {
        nextApprover = null;
    } else if (lastApprovedIndex >= 0) {
        nextApprover = approvalSteps[lastApprovedIndex + 1];
    } else {
        nextApprover = approvalSteps[0];
    }
    
    var isFullyApproved = (lastApprovedIndex === approvalSteps.length - 1);
    
    console.log("Next approver:", nextApprover);
    console.log("Fully approved:", isFullyApproved);
    
    // Build HTML grid
    var gridHtml = '<div class="approval-grid-container">';
    
    for (var i = 0; i < approvalSteps.length; i++) {
        var step = approvalSteps[i];
        var stepData = approvedData[step.fieldName] || { isApproved: false, approvalDate: "", approverName: "", approverId: "" };
        var isApproved = stepData.isApproved;
        var stepStatus = "";
        
        if (isApproved) {
            stepStatus = "approved";
        } else if (nextApprover && nextApprover.fieldName === step.fieldName) {
            stepStatus = "in-progress";
        } else {
            stepStatus = "pending";
        }
        
        var statusText = "";
        if (stepStatus === "approved") statusText = "Approved";
        else if (stepStatus === "in-progress") statusText = "In Progress";
        else if (stepStatus === "pending") statusText = "Pending";
        
        if (step.fieldName === "finance_name") {
            gridHtml += getFinanceSectionHTML(step, stepStatus, statusText, isApproved, stepData);
        } else {
            gridHtml += getRegularApprovalHTML(step, stepStatus, statusText, isApproved, stepData);
        }
    }
    
    gridHtml += '</div>';
    container.innerHTML = gridHtml;
    
    // Load approver options for in-progress step
    if (nextApprover && !isFullyApproved) {
        if (nextApprover.fieldName !== "finance_name") {
            var selectEl = document.getElementById(nextApprover.fieldName);
            if (selectEl) {
                loadSingleApprover(nextApprover.fieldName, selectEl, existingApprovals, function(selectedId) {
                    updateCurrentPendingHidden(selectedId);
                });
                
                selectEl.addEventListener('change', function() {
                    updateCurrentPendingHidden(this.value);
                });
            }
        } else if (nextApprover.fieldName === "finance_name") {
            var financeSelect = document.getElementById('finance_name_select');
            if (financeSelect) {
                var existingFinanceId = "${editList.finance_name}" || "";
                loadFinanceApproverOptions(financeSelect, existingFinanceId, function(selectedId) {
                    updateCurrentPendingHidden(selectedId);
                });
                
                financeSelect.addEventListener('change', function() {
                    updateCurrentPendingHidden(this.value);
                });
            }
        }
    }
    
    // Initialize finance handlers
    if (document.getElementById('proposedPrice')) {
        initializeFinanceHandlers();
    }
    
    // Handle hidden inputs
    $("input[name='current_pending_at']").remove();
    $("input[name='status']").remove();
    
    // Always add status hidden input
    var isFullyApproved = (lastApprovedIndex === approvalSteps.length - 1);

	var statusInput = document.createElement("input");
	statusInput.type = "hidden";
	statusInput.name = "status";
	
	if (isFullyApproved) {
	    statusInput.value = "Approved";
	} else {
	    statusInput.value = "In Progress";
	}

	document.getElementById("capexForm").appendChild(statusInput);
    
    // Add current_pending_at only if there's a next approver
    if (nextApprover && !isFullyApproved) {
        var hiddenInput = document.createElement("input");
        hiddenInput.type = "hidden";
        hiddenInput.name = "current_pending_at";
        hiddenInput.id = "current_pending_at_hidden";
        hiddenInput.value = "";
        document.getElementById("capexForm").appendChild(hiddenInput);
        console.log("Hidden input created for current_pending_at");
    }
}

function updateCurrentPendingHidden(approverId) {
    var hiddenInput = document.getElementById("current_pending_at_hidden");
    if (hiddenInput) {
        hiddenInput.value = approverId;
        console.log("Current pending at updated to: " + approverId);
    }
}
//=========================
//🔥 USER LIST FROM JSP
//=========================
var userList = [
<c:forEach var="obj" items="${uList}" varStatus="loop">
   {
       id: "${obj.user_id}",
       name: "${obj.user_name}"
   }<c:if test="${!loop.last}">,</c:if>
</c:forEach>
];

//=========================
//🔥 EDIT DATA FROM DB
//=========================
var editData = {
  head_of_plant_comment: "",
  finance_comment: "${editList.finance_comments}",
  regional_director_comment: "${editList.regional_director_comment}",
  head_projects_comment: "${editList.head_projects_comment}",
  finance_controller_comment: "${editList.finance_controller_comment}",
  business_head_comment: "${editList.business_head_comment}",
  cfo_comment: "${editList.cfo_comment}",
  ceo_comment: "${editList.ceo_comment}"
};

//=========================
//🔥 DEPARTMENT OPTIONS (FIXED - moved out of JS loop issue)
//=========================
var departmentOptions = `
<option value="">Select Department</option>
<c:forEach var="obj" items="${departmentList}">
  <option value="${obj.department_code}" ${obj.department_code == editList.finance_department ? 'selected' : ''}>
      [${obj.department_code}] - ${obj.department_name}
  </option>
</c:forEach>
`;

//=========================
//🔥 GET USER DISPLAY NAME
//=========================
function getUserDisplayName(userId) {
  var name = "";

  if (typeof userList !== "undefined" && userId) {
      userList.forEach(function(user) {
          if (user.id == userId) {
              name = '[' + user.id + '] - ' + user.name;
          }
      });
  }

  return name || userId || "";
}

//=========================
//🔥 APPROVAL CARD FUNCTION
//=========================
function getRegularApprovalHTML(step, stepStatus, statusText, isApproved, stepData) {

  var html = 
      '<div class="approval-card-dynamic ' + stepStatus + '" ' +
          'data-approver-field="' + step.fieldName + '" ' +
          'data-step-order="' + step.stepOrder + '" ' +
          'data-status="' + stepStatus + '">' +

          '<div class="approval-header-dynamic">' +
              '<h4 class="approval-title-dynamic">' + step.title + '</h4>' +
              '<span class="status-badge-dynamic ' + stepStatus + '">' + statusText + '</span>' +
          '</div>' +

          '<div class="approval-fields-dynamic">';

  var isHeadOfPlant = step.fieldName === "head_of_plant_name";
  var key = step.fieldName.replace(/_name$/, '') + '_comment';

  var displayName = getUserDisplayName(stepData.approverId);

  // 🔥 IN-PROGRESS
  if (!isApproved && stepStatus === "in-progress") {

      html +=
          '<select name="' + step.fieldName + '" id="' + step.fieldName + '" required>' +
              '<option value="">Select ' + step.title + '</option>' +
              (stepData.approverId ? '<option value="' + stepData.approverId + '" selected>' + displayName + '</option>' : '') +
          '</select>';

      if (!isHeadOfPlant) {
          html +=
              '<textarea name="' + key + '" placeholder="Enter comments (max 200 chars)" maxlength="200"></textarea>';
      }
  }

  // 🔥 APPROVED
  else if (isApproved) {

      html +=
          '<select name="' + step.fieldName + '" disabled>' +
              '<option value="' + (stepData.approverId || '') + '" selected>' +
                  displayName +
              '</option>' +
          '</select>';

      if (!isHeadOfPlant) {
          html +=
              '<textarea name="' + key + '" disabled>' +
              (editData[key] || '') +
              '</textarea>';
      }
  }

  // 🔥 FUTURE
  else {

      html +=
          '<select name="' + step.fieldName + '" disabled>' +
              '<option value="">Locked - Waiting for previous approval</option>' +
          '</select>';

      if (!isHeadOfPlant) {
          html +=
              '<textarea name="' + key + '" disabled></textarea>';
      }
  }
  var formattedDate = formatDateTime(stepData.approvalDate);
  if (stepData.approvalDate && stepData.approvalDate !== "") {
	  if (formattedDate) {
		    html += '<div class="approval-signature-date">' +
		            '<i class="fas fa-clock"></i> Signed on ' + formattedDate +
		            '</div>';
		}
	  
     // html += '<div class="approval-signature-date"><i class="fas fa-clock"></i> Signed on ' + stepData.approvalDate + '</div>';
  }

  html += '</div></div>';

  return html;
}
function formatDateTime(dateStr) {
    if (!dateStr) return '';

    var date = new Date(dateStr);

    if (isNaN(date)) return '';

    var day = String(date.getDate()).padStart(2, '0');

    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    var month = months[date.getMonth()];

    var year = date.getFullYear();

    var hours = date.getHours();
    var minutes = String(date.getMinutes()).padStart(2, '0');

    var ampm = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours ? hours : 12; // 0 → 12

    return day + ' ' + month + ' ' + year + ' ' + hours + ':' + minutes + ' ' + ampm;
}
//=========================
//🔥 FINANCE SECTION (FULL YOUR ORIGINAL + FIXED)
//=========================
function getFinanceSectionHTML(step, stepStatus, statusText, isApproved, stepData) {

  var displayName = getUserDisplayName(stepData.approverId);

  var html = 
      '<div class="approval-card-dynamic finance-card-special ' + stepStatus + '" ' +
          'data-approver-field="' + step.fieldName + '" ' +
          'data-step-order="' + step.stepOrder + '" ' +
          'data-status="' + stepStatus + '">' +

          '<div class="approval-header-dynamic finance-header">' +
              '<h4 class="approval-title-dynamic">🏦 ' + step.title + '</h4>' +
              '<span class="status-badge-dynamic ' + stepStatus + '">' + statusText + '</span>' +
          '</div>' +

          '<div class="finance-section-grid">' +

              '<div class="finance-left-card">' +
                  '<h5>💰 CAPITAL EXPENDITURE BUDGET</h5>' +

                  '<div class="finance-field-group">' +
                      '<label>Department <span>*</span></label>' +
                      '<select id="financeDept" name="finance_department" ' + (isApproved ? 'disabled' : (stepStatus === "in-progress" ? 'required' : 'disabled')) + '>' +
                      '<option value="">Select department</option>';

<c:forEach var="obj" items="${departmentList}">
html += '<option value="${obj.department_code}" ${obj.department_code == editList.department ? 'selected' : ''}>[${obj.department_code}] - ${obj.department_name}</option>';
</c:forEach>

html +=
                  '</select>' +
                  '</div>' +

                  '<div class="finance-field-group">' +
                      '<label>Category <span>*</span></label>' +
                      '<select id="financeCategory" name="finance_category" ' +
                          (isApproved ? 'disabled' : (stepStatus === "in-progress" ? 'required' : 'disabled')) + '>' +

                          '<option value="">Select Category</option>' +
                          '<option value="Admin" ${editList.finance_category == 'Admin' ? 'selected' : ''}>Admin</option>' +
                          '<option value="Bins" ${editList.finance_category == 'Bins' ? 'selected' : ''}>Bins</option>' +
                          '<option value="Civil" ${editList.finance_category == 'Civil' ? 'selected' : ''}>Civil</option>' +
                          '<option value="Digital" ${editList.finance_category == 'Digital' ? 'selected' : ''}>Digital</option>' +
                          '<option value="Fleet" ${editList.finance_category == 'Fleet' ? 'selected' : ''}>Fleet</option>' +
                          '<option value="Laboratory" ${editList.finance_category == 'Laboratory' ? 'selected' : ''}>Laboratory</option>' +
                          '<option value="Landfill" ${editList.finance_category == 'Landfill' ? 'selected' : ''}>Landfill</option>' +
                          '<option value="Plant & Machinery" ${editList.finance_category == 'Plant & Machinery' ? 'selected' : ''}>Plant & Machinery</option>' +
                          '<option value="Safety" ${editList.finance_category == 'Safety' ? 'selected' : ''}>Safety</option>' +
                      '</select>' +
                  '</div>' +

                  '<div class="finance-field-group">' +
                      '<label>Total Budget (₹)</label>' +
                      '<input type="number" id="totalBudget" name="total_budget" value="${editList.total_cost}" disabled>' +
                  '</div>' +

                  '<div class="finance-field-group">' +
                      '<label>Proposed Price (₹) <span>*</span></label>' +
                      '<input type="number" id="proposedPrice" name="proposed_price" value="${editList.proposed_price}" step="0.01" min="0" ' +
                          (isApproved ? 'required' : (stepStatus === "in-progress" ? 'required' : 'disabled')) + '>' +
                  '</div>' +

                  '<div class="finance-field-group">' +
                      '<label>Available Balance (₹)</label>' +
                      '<input type="text" id="availableBalance" name="available_balance" value="${editList.available_balance}" readonly ' +
                          (isApproved ? 'required' : '') + '>' +
                  '</div>' +

              '</div>' +

              '<div class="finance-right-card">' +

                  '<h5>✓ REVIEWED BY FINANCE</h5>' +

                  '<div class="finance-field-group">' +
                      '<label>Status <span>*</span></label>' +
                      '<select id="financeStatus" name="finance_status" ' +
                          (isApproved ? 'disabled' : (stepStatus === "in-progress" ? 'required' : 'disabled')) + '>' +

                          '<option value="">Select status</option>' +
                          '<option value="Approved" ${editList.finance_status == 'Approved' ? 'selected' : ''}>Approved</option>' +
                          '<option value="Rejected" ${editList.finance_status == 'Rejected' ? 'selected' : ''}>Rejected</option>' +
                          '<option value="On Hold" ${editList.finance_status == 'On Hold' ? 'selected' : ''}>On Hold</option>' +

                      '</select>' +
                  '</div>' +

                  '<div class="finance-field-group rejection-remarks" id="rejectionRemarks" style="display: ${editList.finance_status == 'Rejected' ? 'block' : 'none'};">' +
                      '<label>Rejection Reason</label>' +
                      '<textarea id="financeComments" name="remarks" maxlength="500" ' +
                          (isApproved ? 'disabled' : '') + '>${editList.remarks}</textarea>' +
                  '</div>' +

                  '<div class="finance-field-group">' +
                      '<label>Name <span>*</span></label>' +
                      '<select name="finance_name" id="finance_name_select" ' +
                          (isApproved ? 'disabled' : (stepStatus === "in-progress" ? 'required' : 'disabled')) + '>' +

                          '<option value="' + (stepData.approverId || '') + '" selected>' +
                              displayName +
                          '</option>' +

                      '</select>' +
                  '</div>' +

                  '<div class="finance-field-group">' +
                      '<label>Comments <span>*</span></label>' +
                      '<textarea name="finance_comments" maxlength="100" ' +
                          (isApproved ? 'disabled' : (stepStatus === "in-progress" ? 'required' : 'disabled')) + '>' +
                          '${editList.finance_comments}' +
                      '</textarea>' +
                  '</div>' +

              '</div>' +

          '</div>';
  var formattedDate = formatDateTime(stepData.approvalDate);
  
  if (stepData.approvalDate && stepData.approvalDate !== "") {
	  var formattedDate = formatDateTime(stepData.approvalDate);

	  if (formattedDate) {
	      html += '<div class="approval-signature-date">' +
	              '<i class="fas fa-clock"></i> Signed on ' + formattedDate +
	              '</div>';
	  }
  }

  html += '</div>';
  return html;
}

function loadSingleApprover(fieldName, selectElement, existingApprovals, callback) {
    var plantCode = document.getElementById("plantCode").value;
    var department = document.getElementById("department").value;
    
    if (!plantCode) return;
    
    $.ajax({
        url: "<%=request.getContextPath()%>/form/getPlantHead",
        type: "GET",
        data: { plant_code: plantCode, department: department },
        success: function(response) {
            if (response && response.length > 0) {
                var data = response[0];
                var approverMap = {
                    "head_of_plant_name": { name: "site_head_name", id: "site_head_employee_id", displayName: "Head of Plant" },
                    "regional_director_name": { name: "regional_director_name", id: "regional_director_employee_id", displayName: "Regional Director" },
                    "finance_controller_name": { name: "finance_controller_name", id: "finance_controller_employee_id", displayName: "Finance Controller" },
                    "head_projects_name": { name: "project_head_name", id: "project_head_employee_id", displayName: "Head Projects" },
                    "business_head_name": { name: "bu_head_name", id: "bu_head_employee_id", displayName: "Business Head" },
                    "cfo_name": { name: "cfo_name", id: "cfo_employee_id", displayName: "CFO" },
                    "ceo_name": { name: "ceo_name", id: "ceo_employee_id", displayName: "CEO & MD" }
                };
                
                var mapping = approverMap[fieldName];
                if (mapping && data[mapping.id]) {
                    var existingValue = existingApprovals[fieldName] ? existingApprovals[fieldName].approverId : "";
                    var approverName = data[mapping.name] || "";
                    var approverId = data[mapping.id] || "";
                    
                    selectElement.innerHTML = '<option value="">Select ' + mapping.displayName + '</option>' +
                        '<option value="' + approverId + '" ' + (existingValue === approverId ? 'selected' : 'selected') + '>' + approverName + '</option>';
                    
                    if (existingValue && existingValue !== "" && !selectElement.value) {
                        selectElement.value = existingValue;
                        if (callback) callback(existingValue);
                    } else if (selectElement.value) {
                        if (callback) callback(selectElement.value);
                    }
                    
                    console.log("Loaded approver for " + fieldName + ": " + approverName + " (" + approverId + ")");
                    if(approverId === '${sessionScope.USER_ID}'){
                    	 document.getElementById("hideElement").style.display = "none";
                    document.getElementById("hideDiv").style.display = "block";
                } else {
                    document.getElementById("hideElement").style.display = "block";
                    document.getElementById("hideDiv").style.display = "none";
                }
                }
            }
        },
        error: function() {
            console.log("Error loading approver for " + fieldName);
        }
    });
}

function loadFinanceApproverOptions(selectElement, existingApproverId, callback) {
    var plantCode = document.getElementById("plantCode").value;
    var department = document.getElementById("department").value;
    
    if (!plantCode) {
        selectElement.innerHTML = '';
        return;
    }
    
    $.ajax({
        url: "<%=request.getContextPath()%>/form/getPlantHead",
        type: "GET",
        data: { plant_code: plantCode, department: department },
        success: function(response) {
            if (response && response.length > 0) {
                var data = response[0];
                var financeName = data.site_finance_head_name || "";
                var financeId = data.site_finance_head_employee_id || "";
                
                selectElement.innerHTML = '';
                if (financeId) {
                    selectElement.innerHTML += '<option value="' + financeId + '" ' + (existingApproverId === financeId ? 'selected' : 'selected') + '>' + financeName + '</option>';
                    if (existingApproverId && existingApproverId !== "" && !selectElement.value) {
                        selectElement.value = existingApproverId;
                    }
                    if (callback) callback(selectElement.value);
                }
                console.log("Loaded finance approver: " + financeName + " (" + financeId + ")");
            }
        },
        error: function() {
            console.log("Error loading finance approver");
        }
    });
}

function initializeFinanceHandlers() {

    var proposedPrice = document.getElementById('proposedPrice');

    if (proposedPrice) {

        proposedPrice.addEventListener('change', function() {

            var totalBudget = parseFloat(
                document.getElementById("displayBudget").textContent.replace(/[^0-9.]/g, '')
            ) || 0;

            var totalCost = parseFloat(
                document.getElementById("totalBudget").value   // ✅ FIXED
            ) || 0;

            var price = parseFloat(this.value) || 0;

            console.log("Total Budget:", totalBudget);
            console.log("Total Cost:", totalCost);
            console.log("Entered Price:", price);

            if (price > totalBudget) {
                Swal.fire({
                    title: "Budget Exceeded!",
                    text: "Amount exceeds available budget",
                    icon: "error"
                });
                this.value = totalBudget;
            }

            if (price > totalCost) {
                Swal.fire({
                    title: "Budget Exceeded!",
                    text: "Amount exceeds Provided budget",
                    icon: "error"
                });
                this.value = totalCost;
            }

            calculateBalance();
        });

        proposedPrice.addEventListener('keyup', calculateBalance);
    }

    var financeStatus = document.getElementById('financeStatus');

    if (financeStatus) {

        financeStatus.addEventListener('change', function() {

            var remarksField = document.getElementById('rejectionRemarks');

            if (this.value === "Rejected") {
                remarksField.style.display = 'block';
            } else {
                remarksField.style.display = 'none';
            }
        });

        if (financeStatus.value === "Rejected") {
            var remarksField = document.getElementById('rejectionRemarks');
            if (remarksField) remarksField.style.display = 'block';
        }
    }
}

function getExistingApprovals() {
    var approvals = {};
    <c:if test="${not empty editList}">
        <c:if test="${not empty editList.head_of_plant_name}">
        approvals["head_of_plant_name"] = {
            approverId: "${editList.head_of_plant_name}",
            approverName: "${editList.head_of_plant_name}",
            approvalDate: "${editList.head_of_plant_date}",
            status: "Approved"
        };
        </c:if>
        <c:if test="${not empty editList.finance_name}">
        approvals["finance_name"] = {
            approverId: "${editList.finance_name}",
            approverName: "${editList.finance_name}",
            approvalDate: "${editList.finance_date}",
            status: "Approved"
        };
        </c:if>
        <c:if test="${not empty editList.regional_director_name}">
        approvals["regional_director_name"] = {
            approverId: "${editList.regional_director_name}",
            approverName: "${editList.regional_director_name}",
            approvalDate: "${editList.regional_director_date}",
            status: "Approved"
        };
        </c:if>
        <c:if test="${not empty editList.finance_controller_name}">
        approvals["finance_controller_name"] = {
            approverId: "${editList.finance_controller_name}",
            approverName: "${editList.finance_controller_name}",
            approvalDate: "${editList.finance_controller_date}",
            status: "Approved"
        };
        </c:if>
        <c:if test="${not empty editList.head_projects_name}">
        approvals["head_projects_name"] = {
            approverId: "${editList.head_projects_name}",
            approverName: "${editList.head_projects_name}",
            approvalDate: "${editList.head_projects_date}",
            status: "Approved"
        };
        </c:if>
        <c:if test="${not empty editList.business_head_name}">
        approvals["business_head_name"] = {
            approverId: "${editList.business_head_name}",
            approverName: "${editList.business_head_name}",
            approvalDate: "${editList.business_head_date}",
            status: "Approved"
        };
        </c:if>
        <c:if test="${not empty editList.cfo_name}">
        approvals["cfo_name"] = {
            approverId: "${editList.cfo_name}",
            approverName: "${editList.cfo_name}",
            approvalDate: "${editList.cfo_date}",
            status: "Approved"
        };
        </c:if>
        <c:if test="${not empty editList.ceo_name}">
        approvals["ceo_name"] = {
            approverId: "${editList.ceo_name}",
            approverName: "${editList.ceo_name}",
            approvalDate: "${editList.ceo_date}",
            status: "Approved"
        };
        </c:if>
    </c:if>
    return approvals;
}

function calculateBalance() {
    var displayBudget = document.getElementById("displayBudget");
    var proposedPrice = document.getElementById("proposedPrice");
    var availableBalance = document.getElementById("availableBalance");
    
    if (!displayBudget || !proposedPrice || !availableBalance) return;
    
    var totalBudget = parseFloat(displayBudget.textContent.replace(/[^0-9.]/g, '')) || 0;
    var price = parseFloat(proposedPrice.value) || 0;
    var balance = totalBudget - price;
    if (balance < 0) balance = 0;
    availableBalance.value = balance.toFixed(2);
}

function setTotalBudget() {
    var displayBudget = document.getElementById("displayBudget");
    var totalBudgetInput = document.getElementById("totalBudget");
    if (displayBudget && totalBudgetInput) {
        var totalBudget = parseFloat(displayBudget.textContent.replace(/[^0-9.]/g, '')) || 0;
        totalBudgetInput.value = totalBudget.toFixed(2);
    }
}

function clearFile(name, displayId) {
    document.querySelector('input[name="' + name + '"]').value = '';
    document.getElementById(displayId).innerHTML = '';
}

// Document ready
document.addEventListener('DOMContentLoaded', function() {
    updateSbuAndLocation();
    updateCostCalculations();
    document.querySelectorAll('.capex-card')[0].classList.add('disabled-section');
    document.querySelectorAll('input[type="file"]').forEach(function(inp) {
        inp.addEventListener('change', function() {
            var display = document.getElementById(inp.name + 'Display');
            if (display && inp.files[0]) {
                display.innerHTML = inp.files[0].name + ' <button type="button" class="remove-btn" onclick="clearFile(\'' + inp.name + '\', \'' + inp.name + 'Display\')">×</button>';
            }
        });
    });
    
    document.getElementById('capexForm').addEventListener('submit', function(e) {
        if (selectedPlantBudget !== null) {
            var totalEstimate = Number(document.getElementById('totalCost').value) || 0;
            if (totalEstimate > selectedPlantBudget) {
                e.preventDefault();
                Swal.fire({ icon: 'error', title: 'Budget Exceeded', text: 'Total cost exceeds available budget' });
                return;
            }
        }
        document.getElementById('loadingOverlay').style.display = 'flex';
    });
    
    var amountLakhs = (parseFloat(document.getElementById("totalCost").value) || 0) / 100000;
    var amountLakhs_proposedPrice = (parseFloat(document.getElementById("proposedPrice").value) || 0) / 100000;
    if(amountLakhs != amountLakhs_proposedPrice){
    	amountLakhs = amountLakhs_proposedPrice;
    }
    var dept = document.getElementById("department").value || "${editList.department}";
    var currentPending = "${editList.current_pending_at}";
    var existingApprovals = getExistingApprovals();
    
    if (amountLakhs > 0 && dept) {
        $.ajax({
            url: "<%=request.getContextPath()%>/form/getApprovalStatus",
            type: "GET",
            data: { lakhs: amountLakhs.toFixed(2), department: dept },
            dataType: "json",
            success: function(rules) {
                renderApprovalChain(rules, existingApprovals, currentPending);
            },
            error: function(err) { console.log(err); }
        });
    }
    
    setTotalBudget();
    calculateBalance();
});
function renderLegend(rules, approvedData) {
    var container = document.getElementById("approvalLegendContainer");
    if (!container) return;

    var steps = [];
    var added = {};

    // ✅ Add Project Manager manually as FIRST step
    steps.push("project_manager_name");
    added["project_manager_name"] = true;

    // ✅ API steps
    for (var i = 0; i < rules.length; i++) {
        var r = rules[i];

        if (r.previous_required_field && !added[r.previous_required_field]) {
            steps.push(r.previous_required_field);
            added[r.previous_required_field] = true;
        }

        if (r.final_approver && !added[r.final_approver]) {
            steps.push(r.final_approver);
            added[r.final_approver] = true;
        }
    }

    // ✅ Inject project manager approval from JSP (NOT API)
    approvedData["project_manager_name"] = {
        isApproved: ("${editList.project_manager_date}" && "${editList.project_manager_date}".trim() !== "")
    };

    // ✅ Find active step
    var lastApprovedIndex = -1;
    for (var i = 0; i < steps.length; i++) {
        if (approvedData[steps[i]] && approvedData[steps[i]].isApproved) {
            lastApprovedIndex = i;
        } else {
            break;
        }
    }

    var html = '<div class="legend-wrapper compact">';
    html += '<div class="legend-title">Current Approval Flow</div>';
    html += '<div class="legend-flow">';

    for (var i = 0; i < steps.length; i++) {
        var field = steps[i];

        // ✅ Handle Project Manager title manually
        var title = (field === "project_manager_name")
            ? "Project Manager"
            : getApproverTitle(field);

        var status = approvedData[field] || {};
        var isApproved = status.isApproved === true;
        var isActive = i === lastApprovedIndex + 1;

        var icon = '';
        var cls = 'legend-pending';

        if (isApproved) {
            cls = 'legend-approved';
            icon = '<span class="step-icon">✔</span>';
        } else if (isActive) {
            cls = 'legend-active';
            icon = '<span class="step-icon active-dot">●</span>';
        } else {
            icon = '<span class="step-icon">○</span>';
        }

        html += '<div class="legend-step ' + cls + '">';
        html += icon;
        html += '<span class="step-title">' + title + '</span>';
        html += '</div>';

        if (i < steps.length - 1) {
        	html += '<div class="step-connector ' + (isApproved ? 'completed' : '') + '">➜</div>';
        }
    }

    html += '</div></div>';

    container.innerHTML = html;
}
$(document).ready(function(){
	filterProjectManagers();
})
function filterProjectManagers() {

    var selectedPlant = "${editList.plant_code}";

    var managerSelect = document.getElementById("projectManager");
    var options = managerSelect.options;

    for (var i = 0; i < options.length; i++) {

        if (!options[i].value) continue; // ✅ skip "Select Name"

        var plant = options[i].getAttribute("data-plant");

        if (plant === selectedPlant) {
            options[i].style.display = "";
        } else {
            options[i].style.display = "none";
        }
    }

    managerSelect.value = "${editList.project_manager_name}";
}
//When any change happens on the project manager dropdown/select
$('#projectManager').on('change', function() {
    
    // Get the selected value
    let selectedValue = $(this).val();
    
    // Store it in the hidden field
    $('#current_pending_at_hidden').val(selectedValue);
    
    // Optional: console log to check
    console.log('Project Manager changed to:', selectedValue);
});
function showAILoader(type) {
    const textMap = {
        reject: [
            "Validating rejection...",
            "Updating workflow...",
            "Finalizing decision..."
        ],
        sendback: [
            "Analyzing approval chain...",
            "Reverting workflow step...",
            "Sending back for re-approval..."
        ]
    };

    let messages = textMap[type] || ["Processing..."];
    let i = 0;

    document.getElementById("aiLoader").style.display = "flex";
    document.getElementById("aiText").innerText = messages[0];

    let interval = setInterval(() => {
        i++;
        if (i < messages.length) {
            document.getElementById("aiText").innerText = messages[i];
        } else {
            clearInterval(interval);
        }
    }, 1200);
}
function openSendBackPopup() {

    let btn = document.querySelector(".sendback-btn");

    Swal.fire({
        title: "Send Back for Re-approval",
        input: "textarea",
        inputLabel: "Reason (mandatory)",
        inputPlaceholder: "Enter reason...",
        showCancelButton: true,
        confirmButtonText: "Send Back",
        preConfirm: (value) => {
            if (!value) {
                Swal.showValidationMessage("Reason is required!");
            }
            return value;
        }
    }).then((result) => {
        if (result.isConfirmed) {

            setButtonLoading(btn, true);

            processSendBack(result.value);
        }
    });
}
function processSendBack(reason) {

    if (!window.approvalSteps || window.approvalSteps.length === 0) {
        Swal.fire("Wait", "Approval chain still loading", "info");
        return;
    }

    let currentIndex = -1;

    // 🔥 STEP 1: Find CURRENT approver (in-progress)
    for (let i = 0; i < approvalSteps.length; i++) {

        let field = approvalSteps[i].fieldName;

        if (document.querySelector('[data-approver-field="' + field + '"][data-status="in-progress"]')) {
            currentIndex = i;
            break;
        }
    }

    console.log("Current Approver Index:", currentIndex);

    // 🔴 Safety check
    if (currentIndex <= 0) {
        Swal.fire("Error", "Cannot send back further", "error");
        return;
    }

    // 🔥 STEP 2: Go ONE STEP BACK
    let previousField = approvalSteps[currentIndex - 1].fieldName;

    console.log("Send back to:", previousField);

    // 🔥 ADD DATA
    addHidden("send_back_to", previousField);
    addHidden("send_back_remarks", reason);

    let form = document.getElementById("capexForm");

    form.action = "<%=request.getContextPath()%>/form/send-back";

    showAILoader("sendback");

    setTimeout(() => {
        form.submit();
    }, 1500);
}
function addHidden(name, value) {
    let input = document.createElement("input");
    input.type = "hidden";
    input.name = name;
    input.value = value;
    document.getElementById("capexForm").appendChild(input);
}
function rejectProposal() {

    let btn = document.querySelector(".reject-btn");

    Swal.fire({
        title: "Reject Proposal",
        input: "textarea",
        inputLabel: "Reason (mandatory)",
        inputPlaceholder: "Enter rejection reason...",
        inputAttributes: {
            maxlength: 300
        },
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Reject",
        preConfirm: (value) => {
            if (!value) {
                Swal.showValidationMessage("Reason is required!");
            }
            return value;
        }
    }).then((result) => {

        if (result.isConfirmed) {

            setButtonLoading(btn, true);

            let form = document.getElementById("capexForm");

            // ✅ SET CONTROLLER URL
            form.action = "<%=request.getContextPath()%>/form/reject";

            // ✅ ADD REQUIRED DATA
            addHidden("status", "Rejected");
            addHidden("reject_remarks", result.value); // 🔥 THIS WAS MISSING

            // Optional: track who rejected
            addHidden("action_type", "reject");

            showAILoader("reject");

            setTimeout(() => {
                form.submit();
            }, 1500);
        }
    });
}
function setButtonLoading(button, isLoading) {
    if (isLoading) {
        button.classList.add("loading");
        button.disabled = true;
    } else {
        button.classList.remove("loading");
        button.disabled = false;
    }
}
<c:if test="${not empty successMessage}">
<script>
Swal.fire({
    icon: "success",
    title: "Success",
    text: "${successMessage}",
    timer: 2000,
    showConfirmButton: false
});
</script>
</c:if>
</script>
</body>
</html>