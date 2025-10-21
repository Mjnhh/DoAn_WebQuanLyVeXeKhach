<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="sidebar">
    <nav class="nav flex-column">
        <a class="nav-link ${param.active == 'dashboard' ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/trang-chu">
            <i class="fas fa-home"></i> Dashboard
        </a>
        <a class="nav-link ${param.active == 'chuyenxe' ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/chuyenxe">
            <i class="fas fa-bus"></i> Quản lý chuyến xe
        </a>
        <a class="nav-link ${param.active == 'vexe' ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/vexe">
            <i class="fas fa-ticket-alt"></i> Quản lý vé xe
        </a>
        <a class="nav-link ${param.active == 'khachhang' ? 'active' : ''}" 
           href="${pageContext.request.contextPath}/khachhang">
            <i class="fas fa-users"></i> Quản lý khách hàng
        </a>
        
        <c:if test="${sessionScope.role == 'Admin'}">
            <hr class="my-2">
            <a class="nav-link ${param.active == 'taikhoan' ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/taikhoan">
                <i class="fas fa-user-cog"></i> Quản lý tài khoản
            </a>
        </c:if>
    </nav>
</div>



