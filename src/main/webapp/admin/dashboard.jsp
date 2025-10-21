<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="layout/header.jsp">
    <jsp:param name="title" value="Dashboard"/>
</jsp:include>

<jsp:include page="layout/sidebar.jsp">
    <jsp:param name="active" value="dashboard"/>
</jsp:include>

<div class="main-content">
    <h2 class="mb-4"><i class="fas fa-chart-line"></i> Dashboard - Tổng quan hệ thống</h2>
    
    <!-- Statistics Cards -->
    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="card border-0 shadow-sm" style="border-left: 4px solid #ff6b35 !important;">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="text-muted mb-1">Tổng chuyến xe</p>
                            <h3 class="mb-0">${totalChuyenXe}</h3>
                            <small class="text-success">
                                <i class="fas fa-check-circle"></i> ${activeChuyenXe} hoạt động
                            </small>
                        </div>
                        <div style="font-size: 3rem; opacity: 0.3; color: #ff6b35;">
                            <i class="fas fa-bus"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card border-0 shadow-sm" style="border-left: 4px solid #ff8c42 !important;">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="text-muted mb-1">Tổng vé đã đặt</p>
                            <h3 class="mb-0">${totalVe}</h3>
                            <small class="text-info">
                                <i class="fas fa-ticket-alt"></i> ${veDaDat} đang sử dụng
                            </small>
                        </div>
                        <div style="font-size: 3rem; opacity: 0.3; color: #ff8c42;">
                            <i class="fas fa-ticket-alt"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card border-0 shadow-sm" style="border-left: 4px solid #ffa726 !important;">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="text-muted mb-1">Tổng khách hàng</p>
                            <h3 class="mb-0">${totalKhachHang}</h3>
                            <small class="text-muted">
                                <i class="fas fa-users"></i> Đã đăng ký
                            </small>
                        </div>
                        <div style="font-size: 3rem; opacity: 0.3; color: #ffa726;">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card border-0 shadow-sm" style="border-left: 4px solid #ffb74d !important;">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="text-muted mb-1">Tài khoản</p>
                            <h3 class="mb-0">${totalTaiKhoan}</h3>
                            <small class="text-muted">
                                <i class="fas fa-user-cog"></i> Người dùng
                            </small>
                        </div>
                        <div style="font-size: 3rem; opacity: 0.3; color: #ffb74d;">
                            <i class="fas fa-user-shield"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="row g-4">
        <div class="col-md-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-bottom-0">
                    <h5 class="mb-0"><i class="fas fa-bolt text-warning"></i> Thao tác nhanh</h5>
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/vexe?action=form" 
                           class="btn btn-primary btn-lg">
                            <i class="fas fa-plus-circle"></i> Đặt vé mới
                        </a>
                        <a href="${pageContext.request.contextPath}/chuyenxe" 
                           class="btn btn-outline-primary">
                            <i class="fas fa-bus"></i> Quản lý chuyến xe
                        </a>
                        <a href="${pageContext.request.contextPath}/khachhang" 
                           class="btn btn-outline-info">
                            <i class="fas fa-users"></i> Quản lý khách hàng
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-bottom-0">
                    <h5 class="mb-0"><i class="fas fa-info-circle text-info"></i> Thông tin hệ thống</h5>
                </div>
                <div class="card-body">
                    <table class="table table-borderless">
                        <tr>
                            <td><i class="fas fa-user text-primary"></i> Người dùng:</td>
                            <td class="text-end"><strong>${sessionScope.hoTen}</strong></td>
                        </tr>
                        <tr>
                            <td><i class="fas fa-shield-alt text-success"></i> Vai trò:</td>
                            <td class="text-end"><span class="badge bg-success">${sessionScope.role}</span></td>
                        </tr>
                        <tr>
                            <td><i class="fas fa-calendar text-warning"></i> Ngày hôm nay:</td>
                            <td class="text-end">
                                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy"/>
                            </td>
                        </tr>
                        <tr>
                            <td><i class="fas fa-clock text-info"></i> Giờ hiện tại:</td>
                            <td class="text-end">
                                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="HH:mm:ss"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="layout/footer.jsp"/>







