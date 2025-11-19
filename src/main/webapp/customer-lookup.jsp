<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tra cứu & Hủy vé - TMT Group</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #ff6b35;
            --secondary-color: #ff8c42;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding-bottom: 50px;
        }
        
        .navbar {
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .navbar-brand {
            color: var(--primary-color) !important;
            font-weight: bold;
            font-size: 1.5rem;
        }
        
        .lookup-container {
            max-width: 800px;
            margin: 50px auto;
        }
        
        .search-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }
        
        .search-card h3 {
            color: var(--primary-color);
            margin-bottom: 30px;
            text-align: center;
            font-weight: bold;
        }
        
        .btn-search {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            color: white;
            padding: 12px 40px;
            border-radius: 50px;
            font-weight: bold;
        }
        
        .ticket-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-top: 30px;
        }
        
        .ticket-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 25px;
        }
        
        .ticket-code {
            font-size: 2rem;
            font-weight: bold;
            text-align: center;
            margin-bottom: 10px;
        }
        
        .route-info {
            font-size: 1.5rem;
            text-align: center;
        }
        
        .route-info .arrow {
            margin: 0 15px;
        }
        
        .info-section {
            margin-bottom: 20px;
        }
        
        .info-section h5 {
            color: var(--primary-color);
            margin-bottom: 15px;
            font-weight: bold;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            color: #666;
        }
        
        .info-value {
            font-weight: bold;
            color: #333;
        }
        
        .status-badge {
            display: inline-block;
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 1.1rem;
        }
        
        .status-daDat {
            background: #d4edda;
            color: #155724;
        }
        
        .status-daHuy {
            background: #f8d7da;
            color: #721c24;
        }
        
        .status-daSuDung {
            background: #cce5ff;
            color: #004085;
        }
        
        .btn-cancel {
            background: #dc3545;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .btn-cancel:hover {
            background: #c82333;
            transform: scale(1.05);
        }
        
        .btn-print {
            background: #28a745;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .btn-print:hover {
            background: #218838;
            transform: scale(1.05);
        }
        
        .alert-custom {
            border-radius: 15px;
            padding: 20px;
            margin-top: 30px;
        }
        
        .no-result {
            text-align: center;
            padding: 60px 20px;
        }
        
        .no-result i {
            font-size: 5rem;
            color: #ccc;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/customer-home.jsp">
                <i class="fas fa-bus"></i> TMT Group
            </a>
            <div class="ms-auto">
                <a href="${pageContext.request.contextPath}/customer-home.jsp" class="btn btn-outline-primary">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
            </div>
        </div>
    </nav>

    <div class="container lookup-container">
        <!-- Search Form -->
        <div class="search-card">
            <h3><i class="fas fa-search"></i> Tra cứu vé xe</h3>
            <form action="${pageContext.request.contextPath}/customer" method="get">
                <input type="hidden" name="action" value="lookup">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Mã vé</label>
                        <input type="text" class="form-control form-control-lg" name="maVe" 
                               placeholder="VD: 123" value="${param.maVe}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Số điện thoại</label>
                        <input type="tel" class="form-control form-control-lg" name="sdt" 
                               placeholder="VD: 0912345678" value="${param.sdt}">
                    </div>
                </div>
                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-search">
                        <i class="fas fa-search"></i> Tra cứu
                    </button>
                </div>
                <div class="text-center mt-3">
                    <small class="text-muted">
                        <i class="fas fa-info-circle"></i> 
                        Nhập mã vé hoặc số điện thoại để tra cứu
                    </small>
                </div>
            </form>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-${messageType} alert-custom">
                <i class="fas fa-${messageType == 'success' ? 'check-circle' : 'exclamation-circle'}"></i>
                ${message}
            </div>
        </c:if>

        <!-- Ticket Result -->
        <c:if test="${not empty ve}">
            <div class="ticket-card">
                <div class="ticket-header">
                    <div class="ticket-code">
                        VÉ #${ve.maVe}
                    </div>
                    <div class="route-info">
                        ${ve.chuyenXe.diemDi} 
                        <span class="arrow"><i class="fas fa-long-arrow-alt-right"></i></span> 
                        ${ve.chuyenXe.diemDen}
                    </div>
                </div>

                <!-- Trip Info -->
                <div class="info-section">
                    <h5><i class="fas fa-bus"></i> Thông tin chuyến xe</h5>
                    <div class="info-row">
                        <span class="info-label">Số xe:</span>
                        <span class="info-value">${ve.chuyenXe.soXe}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Ngày khởi hành:</span>
                        <span class="info-value">
                            <fmt:formatDate value="${ve.chuyenXe.ngayKhoiHanh}" pattern="dd/MM/yyyy"/>
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Giờ khởi hành:</span>
                        <span class="info-value">
                            <fmt:formatDate value="${ve.chuyenXe.gioKhoiHanh}" pattern="HH:mm"/>
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Số ghế:</span>
                        <span class="info-value">
                            <span class="badge bg-primary" style="font-size: 1.1rem;">Ghế ${ve.soGhe}</span>
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Giá vé:</span>
                        <span class="info-value text-success">
                            <fmt:formatNumber value="${ve.chuyenXe.giaVe}" type="number" groupingUsed="true"/> đ
                        </span>
                    </div>
                </div>

                <!-- Customer Info -->
                <div class="info-section">
                    <h5><i class="fas fa-user"></i> Thông tin khách hàng</h5>
                    <div class="info-row">
                        <span class="info-label">Họ tên:</span>
                        <span class="info-value">${ve.khachHang.hoTen}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Số điện thoại:</span>
                        <span class="info-value">${ve.khachHang.sdt}</span>
                    </div>
                    <c:if test="${not empty ve.khachHang.email}">
                        <div class="info-row">
                            <span class="info-label">Email:</span>
                            <span class="info-value">${ve.khachHang.email}</span>
                        </div>
                    </c:if>
                    <div class="info-row">
                        <span class="info-label">Ngày đặt:</span>
                        <span class="info-value">
                            <fmt:formatDate value="${ve.ngayDat}" pattern="dd/MM/yyyy HH:mm"/>
                        </span>
                    </div>
                    <c:if test="${not empty ve.phuongThucThanhToan}">
                        <div class="info-row">
                            <span class="info-label">Thanh toán:</span>
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${ve.phuongThucThanhToan == 'COD'}">
                                        <i class="fas fa-money-bill-wave text-success"></i> Thanh toán khi lên xe
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-credit-card text-primary"></i> Thanh toán online
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </c:if>
                </div>

                <!-- Status -->
                <div class="info-section">
                    <h5><i class="fas fa-info-circle"></i> Trạng thái</h5>
                    <div class="text-center">
                        <c:choose>
                            <c:when test="${ve.trangThai == 'Đã đặt'}">
                                <span class="status-badge status-daDat">
                                    <i class="fas fa-check-circle"></i> ${ve.trangThai}
                                </span>
                            </c:when>
                            <c:when test="${ve.trangThai == 'Đã hủy'}">
                                <span class="status-badge status-daHuy">
                                    <i class="fas fa-times-circle"></i> ${ve.trangThai}
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge status-daSuDung">
                                    <i class="fas fa-check-double"></i> ${ve.trangThai}
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <c:if test="${not empty ve.ghiChu}">
                        <div class="alert alert-info mt-3 mb-0">
                            <strong>Ghi chú:</strong> ${ve.ghiChu}
                        </div>
                    </c:if>
                </div>

                <!-- Actions -->
                <div class="text-center mt-4">
                    <c:if test="${ve.trangThai == 'Đã đặt'}">
                        <a href="${pageContext.request.contextPath}/export-pdf?maVe=${ve.maVe}" 
                           class="btn btn-print me-2" target="_blank">
                            <i class="fas fa-print"></i> In vé
                        </a>
                        <button type="button" class="btn btn-cancel" onclick="confirmCancel(${ve.maVe})">
                            <i class="fas fa-times-circle"></i> Hủy vé
                        </button>
                        <div class="alert alert-warning mt-3 mb-0">
                            <small>
                                <i class="fas fa-exclamation-triangle"></i> 
                                Vé chỉ có thể hủy trước giờ khởi hành <strong>2 giờ</strong>
                            </small>
                        </div>
                    </c:if>
                    <c:if test="${ve.trangThai == 'Đã hủy'}">
                        <div class="alert alert-danger mb-0">
                            <i class="fas fa-info-circle"></i> 
                            Vé này đã được hủy
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>

        <!-- No Result -->
        <c:if test="${not empty param.action && param.action == 'lookup' && empty ve && empty message}">
            <div class="ticket-card no-result">
                <i class="fas fa-ticket-alt"></i>
                <h4>Không tìm thấy vé</h4>
                <p class="text-muted">Vui lòng kiểm tra lại mã vé hoặc số điện thoại</p>
            </div>
        </c:if>
    </div>

    <!-- Cancel Confirmation Modal -->
    <div class="modal fade" id="cancelModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0">
                    <h5 class="modal-title text-danger">
                        <i class="fas fa-exclamation-triangle"></i> Xác nhận hủy vé
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn hủy vé này?</p>
                    <p class="text-muted mb-0">
                        <small><i class="fas fa-info-circle"></i> Hành động này không thể hoàn tác</small>
                    </p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i> Không
                    </button>
                    <form id="cancelForm" method="post" action="${pageContext.request.contextPath}/customer" style="display: inline;">
                        <input type="hidden" name="action" value="cancel">
                        <input type="hidden" name="maVe" id="cancelMaVe">
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-check"></i> Có, hủy vé
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        // Show message if exists
        <c:if test="${not empty message}">
            Swal.fire({
                icon: '${messageType == "success" ? "success" : (messageType == "danger" ? "error" : "warning")}',
                title: '${messageType == "success" ? "Thành công!" : (messageType == "danger" ? "Lỗi!" : "Thông báo")}',
                html: '${message}',
                confirmButtonColor: '#ff6b35'
            });
        </c:if>

        function confirmCancel(maVe) {
            Swal.fire({
                title: 'Xác nhận hủy vé?',
                html: 'Bạn có chắc chắn muốn hủy vé <strong>#' + maVe + '</strong>?<br><small class="text-muted">Hành động này không thể hoàn tác</small>',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#6c757d',
                confirmButtonText: '<i class="fas fa-check"></i> Có, hủy vé',
                cancelButtonText: '<i class="fas fa-times"></i> Không',
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    // Show loading
                    Swal.fire({
                        title: 'Đang xử lý...',
                        html: 'Vui lòng chờ trong giây lát',
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                        }
                    });
                    
                    // Submit form
                    const form = document.getElementById('cancelForm');
                    document.getElementById('cancelMaVe').value = maVe;
                    form.submit();
                }
            });
        }
    </script>
</body>
</html>


