<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title} - Hệ thống quản lý vé xe khách</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #ff6b35;
            --secondary-color: #f7931e;
            --sidebar-width: 250px;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .navbar {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
            color: white !important;
        }
        .user-info {
            color: white;
            margin-right: 20px;
        }
        .btn-logout {
            background: rgba(255,255,255,0.2);
            border: 1px solid rgba(255,255,255,0.3);
            color: white;
        }
        .btn-logout:hover {
            background: rgba(255,255,255,0.3);
            color: white;
        }
        .sidebar {
            position: fixed;
            top: 56px;
            left: 0;
            height: calc(100vh - 56px);
            width: var(--sidebar-width);
            background: white;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            overflow-y: auto;
            transition: all 0.3s;
        }
        .sidebar .nav-link {
            color: #333;
            padding: 15px 20px;
            border-left: 3px solid transparent;
            transition: all 0.3s;
        }
        .sidebar .nav-link:hover {
            background: #f8f9fa;
            border-left-color: var(--primary-color);
            color: var(--primary-color);
        }
        .sidebar .nav-link.active {
            background: #fff4ed;
            border-left-color: var(--primary-color);
            color: var(--primary-color);
            font-weight: bold;
        }
        .sidebar .nav-link i {
            width: 20px;
            margin-right: 10px;
        }
        .main-content {
            margin-left: var(--sidebar-width);
            margin-top: 56px;
            padding: 30px;
            min-height: calc(100vh - 56px);
        }
        
        /* Override Bootstrap primary color to orange */
        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            border: none;
            box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #ff8550 0%, #ffa940 100%);
            box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4);
        }
        .btn-primary:active, .btn-primary:focus {
            background: linear-gradient(135deg, #ff5520 0%, #f58500 100%);
            box-shadow: 0 2px 10px rgba(255, 107, 53, 0.3);
        }
        .text-primary {
            color: var(--primary-color) !important;
        }
        
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .sidebar.show {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
                margin-top: 56px;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/trang-chu">
                <i class="fas fa-bus"></i> VeXe Pro
            </a>
            
            <div class="d-flex align-items-center">
                <span class="user-info">
                    <i class="fas fa-user-circle"></i> 
                    ${sessionScope.hoTen} 
                    <span class="badge bg-light text-dark">${sessionScope.role}</span>
                </span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout btn-sm">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>



