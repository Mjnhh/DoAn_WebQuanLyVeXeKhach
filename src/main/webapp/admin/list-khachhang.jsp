<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="layout/header.jsp">
    <jsp:param name="title" value="Quản lý khách hàng"/>
</jsp:include>

<jsp:include page="layout/sidebar.jsp">
    <jsp:param name="active" value="khachhang"/>
</jsp:include>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-users"></i> Quản lý khách hàng</h2>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">
            <i class="fas fa-plus-circle"></i> Thêm khách hàng
        </button>
    </div>

    <!-- Search Form -->
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-body">
            <form method="post" action="${pageContext.request.contextPath}/khachhang?action=search" class="row g-3">
                <div class="col-md-10">
                    <input type="text" class="form-control" name="keyword" 
                           value="${searchKeyword}" placeholder="Tìm kiếm theo tên hoặc SĐT">
                </div>
                <div class="col-md-2">
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
                            <th>Mã KH</th>
                            <th>Họ và tên</th>
                            <th>Số điện thoại</th>
                            <th>Email</th>
                            <th>Địa chỉ</th>
                            <th>Ngày đăng ký</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="kh" items="${listKhachHang}">
                            <tr>
                                <td><strong>${kh.maKH}</strong></td>
                                <td>${kh.hoTen}</td>
                                <td><i class="fas fa-phone text-primary"></i> ${kh.sdt}</td>
                                <td>${kh.email}</td>
                                <td>${kh.diaChi}</td>
                                <td><fmt:formatDate value="${kh.ngayDangKy}" pattern="dd/MM/yyyy"/></td>
                                <td>
                                    <button class="btn btn-sm btn-info" 
                                            onclick="editKhachHang(${kh.maKH}, '${kh.hoTen}', '${kh.sdt}', '${kh.email}', '${kh.diaChi}')"
                                            data-bs-toggle="modal" data-bs-target="#editModal">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <a href="${pageContext.request.contextPath}/khachhang?action=history&maKH=${kh.maKH}" 
                                       class="btn btn-sm btn-success">
                                        <i class="fas fa-history"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/khachhang?action=delete&maKH=${kh.maKH}" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Bạn có chắc muốn xóa khách hàng này?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listKhachHang}">
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">
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
                <h5 class="modal-title">Thêm khách hàng mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/khachhang?action=add">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="hoTen" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="sdt" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" name="diaChi">
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

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Sửa thông tin khách hàng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/khachhang?action=update">
                <div class="modal-body">
                    <input type="hidden" name="maKH" id="edit_maKH">
                    <div class="mb-3">
                        <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="hoTen" id="edit_hoTen" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="sdt" id="edit_sdt" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" id="edit_email">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" name="diaChi" id="edit_diaChi">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function editKhachHang(maKH, hoTen, sdt, email, diaChi) {
    document.getElementById('edit_maKH').value = maKH;
    document.getElementById('edit_hoTen').value = hoTen;
    document.getElementById('edit_sdt').value = sdt;
    document.getElementById('edit_email').value = email || '';
    document.getElementById('edit_diaChi').value = diaChi || '';
}
</script>

<jsp:include page="layout/footer.jsp"/>



