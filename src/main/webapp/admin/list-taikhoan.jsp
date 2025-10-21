<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="layout/header.jsp">
    <jsp:param name="title" value="Quản lý tài khoản
               "/>
</jsp:include>

<jsp:include page="layout/sidebar.jsp">
    <jsp:param name="active" value="taikhoan"/>
</jsp:include>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-user-cog"></i> Quản lý tài khoản</h2>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">
            <i class="fas fa-plus-circle"></i> Thêm tài khoản
        </button>
    </div>

    <!-- Data Table -->
    <div class="card border-0 shadow-sm">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Username</th>
                            <th>Họ và tên</th>
                            <th>Vai trò</th>
                            <th>Số điện thoại</th>
                            <th>Email</th>
                            <th>Ngày tạo</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="tk" items="${listTaiKhoan}">
                            <tr>
                                <td><strong>${tk.username}</strong></td>
                                <td>${tk.hoTen}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${tk.role == 'Admin'}">
                                            <span class="badge bg-danger">Admin</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-info">Nhân viên</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${tk.sdt}</td>
                                <td>${tk.email}</td>
                                <td><fmt:formatDate value="${tk.ngayTao}" pattern="dd/MM/yyyy"/></td>
                                <td>
                                    <button class="btn btn-sm btn-warning" 
                                            onclick="editTaiKhoan('${tk.username}', '${tk.password}', '${tk.role}', '${tk.hoTen}', '${tk.sdt}', '${tk.email}', '${tk.diaChi}')"
                                            data-bs-toggle="modal" data-bs-target="#editModal">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <c:if test="${tk.username != sessionScope.username}">
                                        <a href="${pageContext.request.contextPath}/taikhoan?action=delete&username=${tk.username}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listTaiKhoan}">
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
                <h5 class="modal-title">Thêm tài khoản mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/taikhoan?action=add">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Username <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password <span class="text-danger">*</span></label>
                        <input type="password" class="form-control" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Vai trò <span class="text-danger">*</span></label>
                        <select class="form-select" name="role" required>
                            <option value="Admin">Admin</option>
                            <option value="Nhân viên">Nhân viên</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="hoTen" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" name="sdt">
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
                <h5 class="modal-title">Sửa thông tin tài khoản</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/taikhoan?action=update">
                <div class="modal-body">
                    <input type="hidden" name="username" id="edit_username">
                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input type="text" class="form-control" id="edit_username_display" disabled>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password <span class="text-danger">*</span></label>
                        <input type="password" class="form-control" name="password" id="edit_password" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Vai trò <span class="text-danger">*</span></label>
                        <select class="form-select" name="role" id="edit_role" required>
                            <option value="Admin">Admin</option>
                            <option value="Nhân viên">Nhân viên</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="hoTen" id="edit_hoTen" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" name="sdt" id="edit_sdt">
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
function editTaiKhoan(username, password, role, hoTen, sdt, email, diaChi) {
    document.getElementById('edit_username').value = username;
    document.getElementById('edit_username_display').value = username;
    document.getElementById('edit_password').value = password;
    document.getElementById('edit_role').value = role;
    document.getElementById('edit_hoTen').value = hoTen;
    document.getElementById('edit_sdt').value = sdt || '';
    document.getElementById('edit_email').value = email || '';
    document.getElementById('edit_diaChi').value = diaChi || '';
}
</script>

<jsp:include page="layout/footer.jsp"/>



