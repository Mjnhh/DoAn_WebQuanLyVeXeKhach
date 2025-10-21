<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="layout/header.jsp">
    <jsp:param name="title" value="Quản lý vé xe"/>
</jsp:include>

<jsp:include page="layout/sidebar.jsp">
    <jsp:param name="active" value="vexe"/>
</jsp:include>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-ticket-alt"></i> Quản lý vé xe</h2>
        <a href="${pageContext.request.contextPath}/vexe?action=form" class="btn btn-primary">
            <i class="fas fa-plus-circle"></i> Đặt vé mới
        </a>
    </div>

    <!-- Search Form -->
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-body">
            <form method="post" action="${pageContext.request.contextPath}/vexe?action=search" class="row g-3">
                <div class="col-md-10">
                    <label class="form-label">Tìm kiếm theo số điện thoại hoặc mã vé</label>
                    <input type="text" class="form-control" name="keyword" 
                           value="${searchKeyword}" placeholder="Nhập SĐT hoặc mã vé">
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-search"></i> Tìm
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Data Table -->
    <div class="card border-0 shadow-sm">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Mã vé</th>
                            <th>Khách hàng</th>
                            <th>Chuyến xe</th>
                            <th>Số ghế</th>
                            <th>Ngày đặt</th>
                            <th>Giá vé</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ve" items="${listVeXe}">
                            <tr>
                                <td><strong>#${ve.maVe}</strong></td>
                                <td>
                                    ${ve.khachHang.hoTen}<br>
                                    <small class="text-muted">
                                        <i class="fas fa-phone"></i> ${ve.khachHang.sdt}
                                    </small>
                                </td>
                                <td>
                                    <strong>${ve.chuyenXe.soXe}</strong><br>
                                    <small>${ve.chuyenXe.diemDi} → ${ve.chuyenXe.diemDen}</small><br>
                                    <small class="text-muted">
                                        <fmt:formatDate value="${ve.chuyenXe.ngayKhoiHanh}" pattern="dd/MM/yyyy"/> -
                                        <fmt:formatDate value="${ve.chuyenXe.gioKhoiHanh}" pattern="HH:mm"/>
                                    </small>
                                </td>
                                <td>
                                    <span class="badge bg-info">Ghế ${ve.soGhe}</span>
                                </td>
                                <td>
                                    <fmt:formatDate value="${ve.ngayDat}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td>
                                    <strong><fmt:formatNumber value="${ve.chuyenXe.giaVe}" type="number" groupingUsed="true"/> đ</strong>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${ve.trangThai == 'Đã đặt'}">
                                            <span class="badge bg-success">Đã đặt</span>
                                        </c:when>
                                        <c:when test="${ve.trangThai == 'Đã hủy'}">
                                            <span class="badge bg-danger">Đã hủy</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${ve.trangThai}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <a href="${pageContext.request.contextPath}/export-pdf?maVe=${ve.maVe}" 
                                           class="btn btn-sm btn-warning"
                                           target="_blank"
                                           title="Xuất vé ra PDF">
                                            <i class="fas fa-file-pdf"></i>
                                        </a>
                                        <c:if test="${ve.trangThai == 'Đã đặt'}">
                                            <a href="${pageContext.request.contextPath}/vexe?action=cancel&maVe=${ve.maVe}" 
                                               class="btn btn-sm btn-danger"
                                               onclick="return confirm('Bạn có chắc muốn hủy vé này?')"
                                               title="Hủy vé">
                                                <i class="fas fa-times-circle"></i>
                                            </a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listVeXe}">
                            <tr>
                                <td colspan="8" class="text-center text-muted py-4">
                                    <i class="fas fa-inbox fa-3x mb-3"></i><br>
                                    Không có dữ liệu
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="layout/footer.jsp"/>







