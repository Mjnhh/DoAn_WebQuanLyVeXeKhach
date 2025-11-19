<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm kiếm chuyến xe - TMT Group</title>
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
        
        .search-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-top: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .search-result {
            margin-top: 30px;
        }
        
        .trip-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.1);
            transition: all 0.3s;
        }
        
        .trip-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 25px rgba(0,0,0,0.15);
        }
        
        .trip-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px dashed #eee;
        }
        
        .route {
            font-size: 1.5rem;
            font-weight: bold;
            color: #333;
        }
        
        .route .arrow {
            color: var(--primary-color);
            margin: 0 10px;
        }
        
        .price {
            font-size: 1.8rem;
            font-weight: bold;
            color: #28a745;
        }
        
        .trip-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .info-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .info-item i {
            color: var(--primary-color);
            font-size: 1.2rem;
        }
        
        .seats-available {
            display: inline-block;
            padding: 5px 15px;
            background: #d4edda;
            color: #155724;
            border-radius: 20px;
            font-weight: bold;
        }
        
        .seats-low {
            background: #fff3cd;
            color: #856404;
        }
        
        .btn-book {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .btn-book:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(255, 107, 53, 0.4);
            color: white;
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
        
        .btn-back {
            background: rgba(255, 255, 255, 0.9);
            color: #667eea;
            border: 2px solid #667eea;
        }
        
        .btn-back:hover {
            background: #667eea;
            color: white;
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
                <a href="${pageContext.request.contextPath}/customer?action=lookup" class="btn btn-outline-primary me-2">
                    <i class="fas fa-search"></i> Tra cứu vé
                </a>
                <a href="${pageContext.request.contextPath}/customer-home.jsp" class="btn btn-back">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
            </div>
        </div>
    </nav>

    <div class="container">
        <!-- Search Box -->
        <div class="search-section">
            <h4 class="mb-4" style="color: var(--primary-color);">
                <i class="fas fa-search"></i> Tìm kiếm chuyến xe
            </h4>
            <form action="${pageContext.request.contextPath}/customer" method="get">
                <input type="hidden" name="action" value="search">
                <div class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label">Điểm đi</label>
                        <input type="text" class="form-control" name="diemDi" 
                               value="${param.diemDi}" placeholder="VD: Hà Nội" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Điểm đến</label>
                        <input type="text" class="form-control" name="diemDen" 
                               value="${param.diemDen}" placeholder="VD: Hải Phòng" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Ngày đi</label>
                        <input type="date" class="form-control" name="ngayDi" 
                               value="${param.ngayDi}" 
                               min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" 
                               required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">&nbsp;</label>
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-search"></i> Tìm kiếm
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Search Results -->
        <c:if test="${not empty listChuyenXe}">
            <div class="search-result">
                <h5 class="mb-3 text-white">
                    <i class="fas fa-list"></i> Tìm thấy <strong>${listChuyenXe.size()}</strong> chuyến xe
                </h5>
                
                <c:forEach var="cx" items="${listChuyenXe}">
                    <div class="trip-card">
                        <div class="trip-header">
                            <div class="route">
                                ${cx.diemDi} <span class="arrow"><i class="fas fa-long-arrow-alt-right"></i></span> ${cx.diemDen}
                            </div>
                            <div class="price">
                                <fmt:formatNumber value="${cx.giaVe}" type="number" groupingUsed="true"/> đ
                            </div>
                        </div>
                        
                        <div class="trip-info">
                            <div class="info-item">
                                <i class="fas fa-bus"></i>
                                <div>
                                    <small class="text-muted">Số xe</small><br>
                                    <strong>${cx.soXe}</strong>
                                </div>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-calendar"></i>
                                <div>
                                    <small class="text-muted">Ngày khởi hành</small><br>
                                    <strong><fmt:formatDate value="${cx.ngayKhoiHanh}" pattern="dd/MM/yyyy"/></strong>
                                </div>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-clock"></i>
                                <div>
                                    <small class="text-muted">Giờ khởi hành</small><br>
                                    <strong><fmt:formatDate value="${cx.gioKhoiHanh}" pattern="HH:mm"/></strong>
                                </div>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-chair"></i>
                                <div>
                                    <small class="text-muted">Ghế trống</small><br>
                                    <span class="${cx.soGheTrong < 10 ? 'seats-low' : 'seats-available'}">
                                        ${cx.soGheTrong}/${cx.soGhe} ghế
                                    </span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="text-end">
                            <c:choose>
                                <c:when test="${cx.soGheTrong > 0}">
                                    <a href="${pageContext.request.contextPath}/customer?action=booking&maCX=${cx.maCX}" 
                                       class="btn btn-book">
                                        <i class="fas fa-ticket-alt"></i> Đặt vé ngay
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-secondary" disabled>
                                        <i class="fas fa-times"></i> Hết chỗ
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        
        <!-- No Results -->
        <c:if test="${empty listChuyenXe && not empty param.action}">
            <div class="search-result">
                <div class="trip-card no-result">
                    <i class="fas fa-bus-alt"></i>
                    <h4>Không tìm thấy chuyến xe phù hợp</h4>
                    <p class="text-muted">Vui lòng thử lại với điểm đi/đến hoặc ngày khác</p>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>



