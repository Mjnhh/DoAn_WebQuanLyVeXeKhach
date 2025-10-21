<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="layout/header.jsp">
    <jsp:param name="title" value="Đặt vé"/>
</jsp:include>

<jsp:include page="layout/sidebar.jsp">
    <jsp:param name="active" value="vexe"/>
</jsp:include>

<style>
    #notificationModal .modal-content {
        border-radius: 20px;
        animation: slideDown 0.3s ease-out;
    }
    
    @keyframes slideDown {
        from {
            transform: translateY(-50px);
            opacity: 0;
        }
        to {
            transform: translateY(0);
            opacity: 1;
        }
    }
    
    #notificationModal .modal-body {
        padding: 2rem 2rem 1.5rem 2rem;
    }
    
    #notificationModal #modalIcon i {
        animation: iconPop 0.5s ease-out 0.2s both;
    }
    
    @keyframes iconPop {
        0% {
            transform: scale(0);
        }
        50% {
            transform: scale(1.2);
        }
        100% {
            transform: scale(1);
        }
    }
</style>

<div class="main-content">
    <h2 class="mb-4"><i class="fas fa-ticket-alt"></i> Đặt vé xe</h2>

    <!-- Alert Messages as Modal -->
    <c:if test="${not empty sessionScope.message}">
        <c:set var="alertMessage" value="${sessionScope.message}"/>
        <c:set var="alertType" value="${sessionScope.messageType}"/>
        <c:remove var="message" scope="session"/>
        <c:remove var="messageType" scope="session"/>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/vexe?action=book">
        <div class="row g-4">
            <!-- Chọn chuyến xe -->
            <div class="col-md-6">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="fas fa-bus"></i> Chọn chuyến xe</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label">Chuyến xe <span class="text-danger">*</span></label>
                            <select class="form-select" name="maCX" id="chuyenXeSelect" required onchange="loadChuyenXeInfo()">
                                <option value="">-- Chọn chuyến xe --</option>
                                <c:forEach var="cx" items="${listChuyenXe}">
                                    <option value="${cx.maCX}" ${selectedChuyenXe != null && selectedChuyenXe.maCX == cx.maCX ? 'selected' : ''}>
                                        ${cx.soXe} - ${cx.diemDi} → ${cx.diemDen} 
                                        (<fmt:formatDate value="${cx.ngayKhoiHanh}" pattern="dd/MM"/> - 
                                        <fmt:formatDate value="${cx.gioKhoiHanh}" pattern="HH:mm"/>)
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <c:if test="${selectedChuyenXe != null}">
                            <div class="alert alert-info">
                                <strong>Thông tin chuyến xe:</strong><br>
                                <i class="fas fa-bus"></i> ${selectedChuyenXe.soXe}<br>
                                <i class="fas fa-route"></i> ${selectedChuyenXe.diemDi} → ${selectedChuyenXe.diemDen}<br>
                                <i class="fas fa-clock"></i> 
                                <fmt:formatDate value="${selectedChuyenXe.ngayKhoiHanh}" pattern="dd/MM/yyyy"/> - 
                                <fmt:formatDate value="${selectedChuyenXe.gioKhoiHanh}" pattern="HH:mm"/><br>
                                <i class="fas fa-money-bill"></i> 
                                <fmt:formatNumber value="${selectedChuyenXe.giaVe}" type="number" groupingUsed="true"/> đ<br>
                                <i class="fas fa-chair"></i> 
                                <span class="badge bg-success">${selectedChuyenXe.soGheTrong} ghế trống</span>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Thông tin khách hàng -->
            <div class="col-md-6">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0"><i class="fas fa-user"></i> Thông tin khách hàng</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="sdt" id="sdt" required 
                                   onblur="checkKhachHang()" placeholder="Nhập số điện thoại">
                            <small class="text-muted">Nhập SĐT để kiểm tra khách hàng cũ</small>
                        </div>

                        <div id="khachHangInfo">
                            <div class="mb-3">
                                <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="hoTen" required>
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
                    </div>
                </div>
            </div>

            <!-- Chọn ghế -->
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-warning text-dark">
                        <h5 class="mb-0"><i class="fas fa-chair"></i> Chọn ghế ngồi</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Số ghế <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" name="soGhe" 
                                           required min="1" id="soGheInput">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Ghi chú</label>
                                    <textarea class="form-control" name="ghiChu" rows="3"></textarea>
                                </div>
                            </div>

                            <c:if test="${not empty gheDaDat}">
                                <div class="col-md-6">
                                    <label class="form-label">Ghế đã đặt:</label>
                                    <div class="border rounded p-3" style="max-height: 200px; overflow-y: auto;">
                                        <c:forEach var="ghe" items="${gheDaDat}">
                                            <span class="badge bg-danger m-1">Ghế ${ghe}</span>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/vexe" class="btn btn-secondary btn-lg">
                <i class="fas fa-arrow-left"></i> Quay lại
            </a>
            <button type="submit" class="btn btn-primary btn-lg">
                <i class="fas fa-check-circle"></i> Đặt vé
            </button>
        </div>
    </form>
</div>

<!-- Notification Modal -->
<div class="modal fade" id="notificationModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header border-0 pb-0">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center py-4">
                <div id="modalIcon" class="mb-3"></div>
                <h4 id="modalTitle" class="mb-3"></h4>
                <p id="modalMessage" class="text-muted mb-4"></p>
                <button type="button" class="btn btn-primary px-4" data-bs-dismiss="modal">
                    <i class="fas fa-check"></i> Đã hiểu
                </button>
            </div>
        </div>
    </div>
</div>

<script>
function loadChuyenXeInfo() {
    var select = document.getElementById('chuyenXeSelect');
    if (select.value) {
        window.location.href = '${pageContext.request.contextPath}/vexe?action=form&maCX=' + select.value;
    }
}

function checkKhachHang() {
    var sdt = document.getElementById('sdt').value;
    if (sdt) {
        // AJAX call to check existing customer
        // For now, just a placeholder
        console.log('Checking customer with SDT:', sdt);
    }
}

// Show notification modal if there's a message
<c:if test="${not empty alertMessage}">
document.addEventListener('DOMContentLoaded', function() {
    var messageType = '${alertType}';
    var message = '${alertMessage}';
    
    var iconHtml = '';
    var title = '';
    var iconClass = '';
    
    if (messageType === 'success') {
        iconHtml = '<i class="fas fa-check-circle fa-4x text-success"></i>';
        title = 'Thành công!';
        iconClass = 'text-success';
    } else if (messageType === 'danger') {
        iconHtml = '<i class="fas fa-times-circle fa-4x text-danger"></i>';
        title = 'Lỗi!';
        iconClass = 'text-danger';
    } else if (messageType === 'warning') {
        iconHtml = '<i class="fas fa-exclamation-triangle fa-4x text-warning"></i>';
        title = 'Cảnh báo!';
        iconClass = 'text-warning';
    } else {
        iconHtml = '<i class="fas fa-info-circle fa-4x text-info"></i>';
        title = 'Thông báo';
        iconClass = 'text-info';
    }
    
    document.getElementById('modalIcon').innerHTML = iconHtml;
    document.getElementById('modalTitle').textContent = title;
    document.getElementById('modalTitle').className = 'mb-3 ' + iconClass;
    document.getElementById('modalMessage').textContent = message;
    
    var modal = new bootstrap.Modal(document.getElementById('notificationModal'));
    modal.show();
});
</c:if>
</script>

<jsp:include page="layout/footer.jsp"/>












