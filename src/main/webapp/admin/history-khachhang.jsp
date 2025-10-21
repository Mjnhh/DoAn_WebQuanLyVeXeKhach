<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="layout/header.jsp">
    <jsp:param name="title" value="Lịch sử đặt vé"/>
</jsp:include>

<jsp:include page="layout/sidebar.jsp">
    <jsp:param name="active" value="khachhang"/>
</jsp:include>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-history"></i> Lịch sử đặt vé</h2>
        <a href="${pageContext.request.contextPath}/khachhang" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Quay lại
        </a>
    </div>

    <!-- Thông tin khách hàng -->
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-body">
            <h5 class="card-title mb-3">
                <i class="fas fa-user"></i> Thông tin khách hàng
            </h5>
            <div class="row">
                <div class="col-md-3">
                    <strong>Mã KH:</strong> ${khachHang.maKH}
                </div>
                <div class="col-md-3">
                    <strong>Họ tên:</strong> ${khachHang.hoTen}
                </div>
                <div class="col-md-3">
                    <strong>SĐT:</strong> ${khachHang.sdt}
                </div>
                <div class="col-md-3">
                    <strong>Email:</strong> ${khachHang.email}
                </div>
            </div>
        </div>
    </div>

    <!-- Danh sách vé đã đặt -->
    <div class="card border-0 shadow-sm">
        <div class="card-body">
            <h5 class="card-title mb-3">
                <i class="fas fa-ticket-alt"></i> Danh sách vé đã đặt 
                <span class="badge bg-primary">${listVe.size()} vé</span>
            </h5>
            
            <c:if test="${empty listVe}">
                <div class="alert alert-info text-center">
                    <i class="fas fa-info-circle"></i> Khách hàng chưa đặt vé nào!
                </div>
            </c:if>
            
            <c:if test="${not empty listVe}">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Mã vé</th>
                                <th>Chuyến xe</th>
                                <th>Tuyến đường</th>
                                <th>Ngày đi</th>
                                <th>Giờ KH</th>
                                <th>Số ghế</th>
                                <th>Giá vé</th>
                                <th>Ngày đặt</th>
                                <th>Trạng thái</th>
                                <th>Ghi chú</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="ve" items="${listVe}">
                                <tr>
                                    <td><strong>#${ve.maVe}</strong></td>
                                    <td>${ve.chuyenXe.soXe}</td>
                                    <td>
                                        <i class="fas fa-map-marker-alt text-success"></i> ${ve.chuyenXe.diemDi}
                                        <br>
                                        <i class="fas fa-map-marker-alt text-danger"></i> ${ve.chuyenXe.diemDen}
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${ve.chuyenXe.ngayKhoiHanh}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${ve.chuyenXe.gioKhoiHanh}" pattern="HH:mm"/>
                                    </td>
                                    <td>
                                        <span class="badge bg-info">Ghế ${ve.soGhe}</span>
                                    </td>
                                    <td>
                                        <strong class="text-primary">
                                            <fmt:formatNumber value="${ve.chuyenXe.giaVe}" type="number" groupingUsed="true"/> đ
                                        </strong>
                                    </td>
                                    <td>
                                        <small class="text-muted">
                                            <fmt:formatDate value="${ve.ngayDat}" pattern="dd/MM/yyyy HH:mm"/>
                                        </small>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ve.trangThai == 'Đã đặt'}">
                                                <span class="badge bg-success">Đã đặt</span>
                                            </c:when>
                                            <c:when test="${ve.trangThai == 'Đã hủy'}">
                                                <span class="badge bg-danger">Đã hủy</span>
                                            </c:when>
                                            <c:when test="${ve.trangThai == 'Đã sử dụng'}">
                                                <span class="badge bg-secondary">Đã sử dụng</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${ve.trangThai}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${not empty ve.ghiChu}">
                                            <small class="text-muted">${ve.ghiChu}</small>
                                        </c:if>
                                        <c:if test="${empty ve.ghiChu}">
                                            <small class="text-muted">-</small>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Thống kê nhanh -->
                <div class="row mt-4">
                    <div class="col-md-4">
                        <div class="card border-0 bg-light">
                            <div class="card-body text-center">
                                <h6 class="text-muted">Tổng số vé</h6>
                                <h3 class="text-primary">${listVe.size()}</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card border-0 bg-light">
                            <div class="card-body text-center">
                                <h6 class="text-muted">Vé đang hoạt động</h6>
                                <h3 class="text-success">
                                    <c:set var="countActive" value="0"/>
                                    <c:forEach var="ve" items="${listVe}">
                                        <c:if test="${ve.trangThai == 'Đã đặt'}">
                                            <c:set var="countActive" value="${countActive + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    ${countActive}
                                </h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card border-0 bg-light">
                            <div class="card-body text-center">
                                <h6 class="text-muted">Tổng chi tiêu</h6>
                                <h3 class="text-warning">
                                    <c:set var="totalAmount" value="0"/>
                                    <c:forEach var="ve" items="${listVe}">
                                        <c:set var="totalAmount" value="${totalAmount + ve.chuyenXe.giaVe}"/>
                                    </c:forEach>
                                    <fmt:formatNumber value="${totalAmount}" type="number" groupingUsed="true"/> đ
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="layout/footer.jsp"/>

