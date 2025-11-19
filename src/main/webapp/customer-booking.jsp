<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt vé xe - TMT Group</title>
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
        
        .booking-container {
            max-width: 1200px;
            margin: 30px auto;
        }
        
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .card-header {
            border-radius: 15px 15px 0 0 !important;
            padding: 20px;
            font-weight: bold;
            font-size: 1.2rem;
        }
        
        .trip-info-card {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
        }
        
        .route-display {
            text-align: center;
            font-size: 1.8rem;
            font-weight: bold;
            margin: 20px 0;
        }
        
        .route-display .arrow {
            margin: 0 15px;
            font-size: 2rem;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 20px;
        }
        
        .info-item {
            background: rgba(255, 255, 255, 0.1);
            padding: 15px;
            border-radius: 10px;
        }
        
        .info-item label {
            font-size: 0.9rem;
            opacity: 0.9;
            margin-bottom: 5px;
        }
        
        .info-item .value {
            font-size: 1.2rem;
            font-weight: bold;
        }
        
        .seat-map {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            margin: 20px 0;
        }
        
        .seat {
            aspect-ratio: 1;
            border: 2px solid #ddd;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            background: white;
            user-select: none;
            position: relative;
            z-index: 1;
            min-height: 50px;
        }
        
        .seat:hover:not(.booked):not(.selected) {
            background: #e3f2fd;
            border-color: var(--primary-color);
            transform: scale(1.05);
        }
        
        .seat:active:not(.booked) {
            transform: scale(0.95);
        }
        
        .seat.booked {
            background: #ff5252;
            color: white;
            cursor: not-allowed;
            opacity: 0.6;
        }
        
        .seat.selected {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
            transform: scale(1.1);
        }
        
        .seat-legend {
            display: flex;
            gap: 20px;
            justify-content: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        
        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .legend-box {
            width: 30px;
            height: 30px;
            border-radius: 5px;
        }
        
        .payment-option {
            border: 2px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s;
            margin-bottom: 15px;
        }
        
        .payment-option:hover {
            border-color: var(--primary-color);
        }
        
        .payment-option.selected {
            border-color: var(--primary-color);
            background: #fff5f0;
        }
        
        .payment-option input[type="radio"] {
            width: 20px;
            height: 20px;
            accent-color: var(--primary-color);
        }
        
        .payment-icon {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            color: white;
            padding: 15px 50px;
            font-size: 1.2rem;
            border-radius: 50px;
            transition: all 0.3s;
        }
        
        .btn-submit:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 20px rgba(255, 107, 53, 0.5);
        }
        
        .price-summary {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }
        
        .total-price {
            font-size: 2rem;
            color: #28a745;
            font-weight: bold;
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
                <a href="javascript:history.back()" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left"></i> Quay lại
                </a>
            </div>
        </div>
    </nav>

    <div class="container booking-container">
        <c:if test="${not empty chuyenXe}">
            <form id="bookingForm" method="post" action="${pageContext.request.contextPath}/customer?action=book">
                <input type="hidden" name="maCX" value="${chuyenXe.maCX}">
                <input type="hidden" name="soGhe" id="selectedSeatInput">
                
                <div class="row">
                    <!-- Left Column -->
                    <div class="col-md-8">
                        <!-- Trip Info -->
                        <div class="card">
                            <div class="card-header trip-info-card">
                                <i class="fas fa-bus"></i> Thông tin chuyến xe
                            </div>
                            <div class="card-body">
                                <div class="route-display">
                                    ${chuyenXe.diemDi} 
                                    <span class="arrow"><i class="fas fa-long-arrow-alt-right"></i></span> 
                                    ${chuyenXe.diemDen}
                                </div>
                                <div class="info-grid text-white">
                                    <div class="info-item">
                                        <label><i class="fas fa-bus"></i> Số xe</label>
                                        <div class="value">${chuyenXe.soXe}</div>
                                    </div>
                                    <div class="info-item">
                                        <label><i class="fas fa-calendar"></i> Ngày khởi hành</label>
                                        <div class="value"><fmt:formatDate value="${chuyenXe.ngayKhoiHanh}" pattern="dd/MM/yyyy"/></div>
                                    </div>
                                    <div class="info-item">
                                        <label><i class="fas fa-clock"></i> Giờ khởi hành</label>
                                        <div class="value"><fmt:formatDate value="${chuyenXe.gioKhoiHanh}" pattern="HH:mm"/></div>
                                    </div>
                                    <div class="info-item">
                                        <label><i class="fas fa-money-bill"></i> Giá vé</label>
                                        <div class="value"><fmt:formatNumber value="${chuyenXe.giaVe}" type="number" groupingUsed="true"/> đ</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Seat Selection -->
                        <div class="card">
                            <div class="card-header bg-warning text-dark">
                                <i class="fas fa-chair"></i> Chọn ghế ngồi
                            </div>
                            <div class="card-body">
                                <div class="seat-legend">
                                    <div class="legend-item">
                                        <div class="legend-box" style="background: white; border: 2px solid #ddd;"></div>
                                        <span>Ghế trống</span>
                                    </div>
                                    <div class="legend-item">
                                        <div class="legend-box" style="background: var(--primary-color);"></div>
                                        <span>Ghế đang chọn</span>
                                    </div>
                                    <div class="legend-item">
                                        <div class="legend-box" style="background: #ff5252;"></div>
                                        <span>Ghế đã đặt</span>
                                    </div>
                                </div>

                                <div class="text-center mb-3">
                                    <i class="fas fa-steering-wheel fa-2x text-muted"></i>
                                    <br><small class="text-muted">Vị trí tài xế</small>
                                </div>

                                <div class="seat-map" id="seatMap">
                                    <c:forEach begin="1" end="${chuyenXe.soGhe}" var="seatNum">
                                        <c:set var="isBooked" value="false"/>
                                        <c:forEach var="bookedSeat" items="${gheDaDat}">
                                            <c:if test="${bookedSeat == seatNum}">
                                                <c:set var="isBooked" value="true"/>
                                            </c:if>
                                        </c:forEach>
                                        
                                        <div class="seat ${isBooked ? 'booked' : ''}" 
                                             data-seat="${seatNum}" 
                                             data-booked="${isBooked}"
                                             onclick="selectSeat(${seatNum}, event)">
                                            ${seatNum}
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="alert alert-info mt-3">
                                    <i class="fas fa-info-circle"></i> 
                                    Vui lòng chọn <strong>1 ghế</strong> để tiếp tục
                                </div>
                            </div>
                        </div>

                        <!-- Customer Info -->
                        <div class="card">
                            <div class="card-header bg-success text-white">
                                <i class="fas fa-user"></i> Thông tin khách hàng
                            </div>
                            <div class="card-body">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="hoTen" required 
                                               placeholder="Nguyễn Văn A">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                        <input type="tel" class="form-control" name="sdt" required 
                                               placeholder="0912345678" pattern="[0-9]{10,11}">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" name="email" 
                                               placeholder="email@example.com">
                                        <small class="text-muted">Để nhận email xác nhận</small>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Địa chỉ</label>
                                        <input type="text" class="form-control" name="diaChi" 
                                               placeholder="Địa chỉ của bạn">
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Ghi chú</label>
                                        <textarea class="form-control" name="ghiChu" rows="2" 
                                                  placeholder="Yêu cầu đặc biệt (nếu có)"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Payment Method -->
                        <div class="card">
                            <div class="card-header bg-info text-white">
                                <i class="fas fa-credit-card"></i> Phương thức thanh toán
                            </div>
                            <div class="card-body">
                                <div class="payment-option selected" onclick="selectPayment('COD', this)">
                                    <div class="d-flex align-items-center">
                                        <input type="radio" name="phuongThucThanhToan" value="COD" checked>
                                        <div class="ms-3 flex-grow-1">
                                            <div class="payment-icon text-success">
                                                <i class="fas fa-money-bill-wave"></i>
                                            </div>
                                            <h5>Thanh toán khi lên xe (COD)</h5>
                                            <p class="text-muted mb-0">Thanh toán bằng tiền mặt khi lên xe</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="payment-option" onclick="selectPayment('Online', this)">
                                    <div class="d-flex align-items-center">
                                        <input type="radio" name="phuongThucThanhToan" value="Online">
                                        <div class="ms-3 flex-grow-1">
                                            <div class="payment-icon text-primary">
                                                <i class="fas fa-credit-card"></i>
                                            </div>
                                            <h5>Thanh toán online</h5>
                                            <p class="text-muted mb-0">Chuyển khoản ngân hàng hoặc ví điện tử</p>
                                            <div class="alert alert-warning mt-2 mb-0">
                                                <small><i class="fas fa-info-circle"></i> Chức năng đang phát triển - Vui lòng chọn COD</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column - Summary -->
                    <div class="col-md-4">
                        <div class="card sticky-top" style="top: 20px;">
                            <div class="card-header bg-primary text-white">
                                <i class="fas fa-receipt"></i> Tóm tắt đặt vé
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <label class="text-muted">Tuyến đường</label>
                                    <div class="fw-bold">${chuyenXe.diemDi} → ${chuyenXe.diemDen}</div>
                                </div>
                                <div class="mb-3">
                                    <label class="text-muted">Ngày giờ khởi hành</label>
                                    <div class="fw-bold">
                                        <fmt:formatDate value="${chuyenXe.ngayKhoiHanh}" pattern="dd/MM/yyyy"/> - 
                                        <fmt:formatDate value="${chuyenXe.gioKhoiHanh}" pattern="HH:mm"/>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="text-muted">Ghế đã chọn</label>
                                    <div class="fw-bold" id="selectedSeatDisplay">
                                        <span class="text-danger">Chưa chọn ghế</span>
                                    </div>
                                </div>
                                <hr>
                                <div class="price-summary">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Giá vé:</span>
                                        <span class="fw-bold"><fmt:formatNumber value="${chuyenXe.giaVe}" type="number" groupingUsed="true"/> đ</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Số lượng:</span>
                                        <span class="fw-bold">1 vé</span>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="fw-bold">Tổng cộng:</span>
                                        <span class="total-price"><fmt:formatNumber value="${chuyenXe.giaVe}" type="number" groupingUsed="true"/> đ</span>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-submit w-100 mt-3" id="btnSubmit" disabled>
                                    <i class="fas fa-check-circle"></i> Xác nhận đặt vé
                                </button>

                                <div class="alert alert-warning mt-3 mb-0">
                                    <small>
                                        <i class="fas fa-exclamation-triangle"></i> 
                                        Vui lòng kiểm tra kỹ thông tin trước khi đặt vé
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </c:if>

        <c:if test="${empty chuyenXe}">
            <div class="card text-center">
                <div class="card-body py-5">
                    <i class="fas fa-exclamation-circle fa-4x text-warning mb-3"></i>
                    <h4>Không tìm thấy thông tin chuyến xe</h4>
                    <a href="${pageContext.request.contextPath}/customer-home.jsp" class="btn btn-primary mt-3">
                        <i class="fas fa-home"></i> Về trang chủ
                    </a>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Loading Overlay -->
    <div id="loadingOverlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.8); z-index: 9999; justify-content: center; align-items: center;">
        <div style="text-align: center; color: white;">
            <div class="spinner-border" role="status" style="width: 4rem; height: 4rem; border-width: 0.5rem;">
                <span class="visually-hidden">Loading...</span>
            </div>
            <h3 style="margin-top: 20px; font-weight: bold;">Đang đặt vé...</h3>
            <p style="margin-top: 10px; font-size: 1.2rem;">Vui lòng chờ trong giây lát</p>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        // Show message if exists
        <c:if test="${not empty sessionScope.message}">
            Swal.fire({
                icon: '${sessionScope.messageType == "success" ? "success" : (sessionScope.messageType == "danger" ? "error" : "warning")}',
                title: '${sessionScope.messageType == "success" ? "Thành công!" : (sessionScope.messageType == "danger" ? "Lỗi!" : "Thông báo")}',
                html: '${sessionScope.message}',
                confirmButtonColor: '#ff6b35'
            });
            <c:remove var="message" scope="session"/>
            <c:remove var="messageType" scope="session"/>
        </c:if>

        let selectedSeat = null;

        function selectSeat(seatNum, event) {
            console.log('=== BẮT ĐẦU selectSeat ===');
            console.log('Số ghế:', seatNum);
            
            // Get seat element from event target (most reliable)
            const seatElement = event.target.closest('.seat') || event.target;
            
            if (!seatElement || !seatElement.classList.contains('seat')) {
                console.error('❌ Không tìm thấy element ghế');
                return;
            }
            
            console.log('✅ Tìm thấy element:', seatElement);
            console.log('Classes:', seatElement.className);
            
            // Check if seat is already booked
            if (seatElement.classList.contains('booked')) {
                console.log('❌ Ghế đã được đặt');
                Swal.fire({
                    icon: 'error',
                    title: 'Ghế đã được đặt!',
                    text: 'Vui lòng chọn ghế khác',
                    confirmButtonColor: '#ff6b35'
                });
                return;
            }

            console.log('✅ Ghế trống, tiếp tục...');

            // Remove previous selection
            document.querySelectorAll('.seat.selected').forEach(seat => {
                seat.classList.remove('selected');
                console.log('Bỏ chọn ghế cũ');
            });

            // Select new seat
            seatElement.classList.add('selected');
            selectedSeat = seatNum;
            console.log('✅ Đã add class "selected"');

            // Update hidden input
            const hiddenInput = document.getElementById('selectedSeatInput');
            if (hiddenInput) {
                hiddenInput.value = seatNum;
                console.log('✅ Đã update hidden input:', hiddenInput.value);
            } else {
                console.error('❌ Không tìm thấy selectedSeatInput');
            }

            // Update display
            const displayElement = document.getElementById('selectedSeatDisplay');
            if (displayElement) {
                displayElement.innerHTML = '<span class="badge bg-primary fs-5">Ghế ' + seatNum + '</span>';
                console.log('✅ Đã update display:', displayElement.innerHTML);
            } else {
                console.error('❌ Không tìm thấy selectedSeatDisplay');
            }

            // Enable submit button
            const submitBtn = document.getElementById('btnSubmit');
            if (submitBtn) {
                submitBtn.disabled = false;
                console.log('✅ Đã enable nút submit');
            } else {
                console.error('❌ Không tìm thấy btnSubmit');
            }
            
            console.log('=== KẾT THÚC selectSeat ===');
        }
        
        // Test khi page load
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Page loaded');
            const seats = document.querySelectorAll('.seat');
            console.log('Số ghế tìm thấy:', seats.length);
            
            // Add click event listener cho mỗi ghế để test
            seats.forEach(seat => {
                const seatNum = seat.getAttribute('data-seat');
                console.log('Ghế', seatNum, 'đã sẵn sàng');
            });
        });

        function selectPayment(method, element) {
            // Remove previous selection
            document.querySelectorAll('.payment-option').forEach(opt => {
                opt.classList.remove('selected');
            });

            // Select new payment
            element.classList.add('selected');
            element.querySelector('input[type="radio"]').checked = true;

            // Disable online payment temporarily
            if (method === 'Online') {
                Swal.fire({
                    icon: 'info',
                    title: 'Tính năng đang phát triển',
                    text: 'Thanh toán online sẽ sớm được cập nhật. Vui lòng chọn thanh toán khi lên xe (COD)',
                    confirmButtonColor: '#ff6b35'
                });
                // Reselect COD
                document.querySelectorAll('.payment-option')[0].click();
            }
        }

        // Form validation & loading
        document.getElementById('bookingForm').addEventListener('submit', function(e) {
            if (!selectedSeat) {
                e.preventDefault();
                Swal.fire({
                    icon: 'warning',
                    title: 'Chưa chọn ghế!',
                    text: 'Vui lòng chọn ghế ngồi trước khi đặt vé',
                    confirmButtonColor: '#ff6b35'
                });
                return false;
            }
            
            // Show loading overlay
            document.getElementById('loadingOverlay').style.display = 'flex';
        });
    </script>
</body>
</html>


