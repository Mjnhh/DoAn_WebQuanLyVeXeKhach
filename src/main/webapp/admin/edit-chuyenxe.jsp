<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="layout/header.jsp">
    <jsp:param name="title" value="Sửa chuyến xe"/>
</jsp:include>

<jsp:include page="layout/sidebar.jsp">
    <jsp:param name="active" value="chuyenxe"/>
</jsp:include>

<div class="main-content">
    <h2 class="mb-4"><i class="fas fa-edit"></i> Sửa thông tin chuyến xe</h2>

    <div class="card border-0 shadow-sm">
        <div class="card-body">
            <form method="post" action="${pageContext.request.contextPath}/chuyenxe?action=update">
                <input type="hidden" name="maCX" value="${chuyenXe.maCX}">
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Mã chuyến xe</label>
                        <input type="text" class="form-control" value="${chuyenXe.maCX}" disabled>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Số xe <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="soXe" 
                               value="${chuyenXe.soXe}" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Điểm đi <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="diemDi" 
                               value="${chuyenXe.diemDi}" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Điểm đến <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="diemDen" 
                               value="${chuyenXe.diemDen}" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Ngày khởi hành <span class="text-danger">*</span></label>
                        <input type="date" class="form-control" name="ngayKhoiHanh" 
                               value="<fmt:formatDate value='${chuyenXe.ngayKhoiHanh}' pattern='yyyy-MM-dd'/>" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Giờ khởi hành <span class="text-danger">*</span></label>
                        <input type="time" class="form-control" name="gioKhoiHanh" 
                               value="<fmt:formatDate value='${chuyenXe.gioKhoiHanh}' pattern='HH:mm'/>" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Giá vé <span class="text-danger">*</span></label>
                        <input type="number" class="form-control" name="giaVe" 
                               value="${chuyenXe.giaVe}" required min="0">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Số ghế <span class="text-danger">*</span></label>
                        <input type="number" class="form-control" name="soGhe" 
                               value="${chuyenXe.soGhe}" required min="1">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Số ghế trống <span class="text-danger">*</span></label>
                        <input type="number" class="form-control" name="soGheTrong" 
                               value="${chuyenXe.soGheTrong}" required min="0">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Trạng thái <span class="text-danger">*</span></label>
                    <select class="form-select" name="trangThai" required>
                        <option value="Hoạt động" ${chuyenXe.trangThai == 'Hoạt động' ? 'selected' : ''}>Hoạt động</option>
                        <option value="Đã hủy" ${chuyenXe.trangThai == 'Đã hủy' ? 'selected' : ''}>Đã hủy</option>
                        <option value="Hoàn thành" ${chuyenXe.trangThai == 'Hoàn thành' ? 'selected' : ''}>Hoàn thành</option>
                    </select>
                </div>

                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/chuyenxe" class="btn btn-secondary btn-lg">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                    <button type="submit" class="btn btn-primary btn-lg">
                        <i class="fas fa-save"></i> Cập nhật
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="layout/footer.jsp"/>



