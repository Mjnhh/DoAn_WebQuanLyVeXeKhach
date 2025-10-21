<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="layout/header.jsp">
    <jsp:param name="title" value="Quản lý chuyến xe"/>
</jsp:include>

<jsp:include page="layout/sidebar.jsp">
    <jsp:param name="active" value="chuyenxe"/>
</jsp:include>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-bus"></i> Quản lý chuyến xe</h2>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">
            <i class="fas fa-plus-circle"></i> Thêm chuyến xe
        </button>
    </div>

    <!-- Search Form -->
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-body">
            <form method="post" action="${pageContext.request.contextPath}/chuyenxe?action=search" class="row g-3">
                <div class="col-md-3">
                    <label class="form-label">Điểm đi</label>
                    <input type="text" class="form-control" name="diemDi" 
                           value="${searchDiemDi}" placeholder="Nhập điểm đi">
                </div>
                <div class="col-md-3">
                    <label class="form-label">Điểm đến</label>
                    <input type="text" class="form-control" name="diemDen" 
                           value="${searchDiemDen}" placeholder="Nhập điểm đến">
                </div>
                <div class="col-md-3">
                    <label class="form-label">Ngày khởi hành</label>
                    <input type="date" class="form-control" name="ngayKhoiHanh" 
                           value="${searchNgayKhoiHanh}">
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-search"></i> Tìm kiếm
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
                            <th>Mã CX</th>
                            <th>Số xe</th>
                            <th>Tuyến đường</th>
                            <th>Ngày/Giờ KH</th>
                            <th>Giá vé</th>
                            <th>Ghế</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cx" items="${listChuyenXe}">
                            <tr>
                                <td><strong>${cx.maCX}</strong></td>
                                <td><span class="badge bg-info">${cx.soXe}</span></td>
                                <td>
                                    <i class="fas fa-map-marker-alt text-success"></i> ${cx.diemDi}
                                    <i class="fas fa-arrow-right text-muted mx-1"></i>
                                    <i class="fas fa-map-marker-alt text-danger"></i> ${cx.diemDen}
                                </td>
                                <td>
                                    <fmt:formatDate value="${cx.ngayKhoiHanh}" pattern="dd/MM/yyyy"/><br>
                                    <small class="text-muted">
                                        <fmt:formatDate value="${cx.gioKhoiHanh}" pattern="HH:mm"/>
                                    </small>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${cx.giaVe}" type="number" groupingUsed="true"/> đ
                                </td>
                                <td>
                                    <span class="badge bg-success">${cx.soGheTrong} trống</span> /
                                    <span class="badge bg-secondary">${cx.soGhe} tổng</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${cx.trangThai == 'Hoạt động'}">
                                            <span class="badge bg-success">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${cx.trangThai}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/chuyenxe?action=edit&maCX=${cx.maCX}" 
                                       class="btn btn-sm btn-warning">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/chuyenxe?action=delete&maCX=${cx.maCX}" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Bạn có chắc muốn xóa chuyến xe này?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listChuyenXe}">
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

<!-- Add Modal -->
<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Thêm chuyến xe mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/chuyenxe?action=add">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Số xe <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="soXe" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Điểm đi <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="diemDi" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Điểm đến <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="diemDen" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Ngày khởi hành <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" name="ngayKhoiHanh" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Giờ khởi hành <span class="text-danger">*</span></label>
                            <input type="time" class="form-control" name="gioKhoiHanh" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Giá vé <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" name="giaVe" required min="0">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Số ghế <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" name="soGhe" required min="1">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Thêm mới</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="layout/footer.jsp"/>




