<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TMT Group - Đặt Vé Xe Khách Online</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #ff6b35;
            --secondary-color: #ff8c42;
            --accent-color: #ffa726;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .hero-section {
            padding: 80px 0;
            color: white;
            text-align: center;
        }
        
        .hero-section h1 {
            font-size: 3.5rem;
            font-weight: bold;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .hero-section p {
            font-size: 1.3rem;
            margin-bottom: 40px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
        }
        
        .search-box {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            max-width: 900px;
            margin: 0 auto;
        }
        
        .search-box h3 {
            color: var(--primary-color);
            margin-bottom: 30px;
            font-weight: bold;
        }
        
        .btn-search {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            color: white;
            padding: 15px 50px;
            font-size: 1.2rem;
            border-radius: 50px;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(255, 107, 53, 0.4);
        }
        
        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 107, 53, 0.6);
            color: white;
        }
        
        .feature-section {
            padding: 60px 0;
            background: white;
        }
        
        .feature-card {
            text-align: center;
            padding: 30px;
            border-radius: 15px;
            transition: all 0.3s;
            height: 100%;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .feature-card i {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 20px;
        }
        
        .feature-card h5 {
            color: #333;
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .feature-card p {
            color: #666;
        }
        
        .quick-links {
            background: #f8f9fa;
            padding: 50px 0;
        }
        
        .quick-link-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s;
            height: 100%;
            text-decoration: none;
            color: inherit;
            display: block;
        }
        
        .quick-link-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            color: inherit;
        }
        
        .quick-link-card i {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }
        
        .footer {
            background: #2c3e50;
            color: white;
            padding: 30px 0;
            text-align: center;
        }
        
        .admin-link {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
        }
        
        .btn-admin {
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
            border: 2px solid white;
            color: white;
            padding: 10px 20px;
            border-radius: 50px;
            transition: all 0.3s;
        }
        
        .btn-admin:hover {
            background: white;
            color: #667eea;
        }
    </style>
</head>
<body>
    <!-- Admin Link -->
    <div class="admin-link">
        <a href="${pageContext.request.contextPath}/login" class="btn btn-admin">
            <i class="fas fa-user-shield"></i> Đăng nhập Admin
        </a>
    </div>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <h1><i class="fas fa-bus"></i> TMT Group</h1>
            <p style="font-size: 1.5rem; margin-bottom: 10px;">Đặt Vé Xe Khách Trực Tuyến</p>
            <p>Nhanh chóng - Tiện lợi - An toàn</p>
            
            <!-- Search Box -->
            <div class="search-box">
                <h3><i class="fas fa-search"></i> Tìm chuyến xe</h3>
                <form action="${pageContext.request.contextPath}/customer" method="get">
                    <input type="hidden" name="action" value="search">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label text-start d-block">Điểm đi</label>
                            <input type="text" class="form-control form-control-lg" name="diemDi" 
                                   placeholder="VD: Hà Nội" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label text-start d-block">Điểm đến</label>
                            <input type="text" class="form-control form-control-lg" name="diemDen" 
                                   placeholder="VD: Hải Phòng" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label text-start d-block">Ngày đi</label>
                            <input type="date" class="form-control form-control-lg" name="ngayDi" 
                                   value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" 
                                   min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" 
                                   required>
                        </div>
                    </div>
                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-search">
                            <i class="fas fa-search"></i> Tìm chuyến xe
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </section>

    <!-- Statistics Section -->
    <section style="
        background: linear-gradient(rgba(67, 97, 238, 0.75), rgba(118, 75, 162, 0.75)), 
                    url('https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=1920&h=600&fit=crop') center/cover;
        padding: 80px 0; 
        color: white;
        position: relative;
        text-shadow: 0 2px 4px rgba(0,0,0,0.3);
    ">
        <div class="container">
            <h2 class="text-center mb-5" style="font-weight: bold; font-size: 2.5rem;">
                📊 Thành Tựu TMT Group
            </h2>
            <p class="text-center mb-5" style="font-size: 1.2rem; opacity: 0.95;">
                Những con số ấn tượng khẳng định vị thế
            </p>
            <div class="row g-4 text-center">
                <div class="col-md-3 col-6">
                    <div style="transition: all 0.3s;" onmouseover="this.style.transform='translateY(-10px)'" onmouseout="this.style.transform='translateY(0)'">
                        <div style="font-size: 3.5rem; margin-bottom: 15px;">
                            <i class="fas fa-users"></i>
                        </div>
                        <h2 style="font-size: 3rem; font-weight: bold; margin-bottom: 10px;">
                            <span class="counter" data-target="1247">0</span>+
                        </h2>
                        <p style="font-size: 1.2rem; opacity: 0.9;">Khách hàng tin dùng</p>
                    </div>
                </div>
                
                <div class="col-md-3 col-6">
                    <div style="transition: all 0.3s;" onmouseover="this.style.transform='translateY(-10px)'" onmouseout="this.style.transform='translateY(0)'">
                        <div style="font-size: 3.5rem; margin-bottom: 15px;">
                            <i class="fas fa-bus"></i>
                        </div>
                        <h2 style="font-size: 3rem; font-weight: bold; margin-bottom: 10px;">
                            <span class="counter" data-target="586">0</span>+
                        </h2>
                        <p style="font-size: 1.2rem; opacity: 0.9;">Chuyến xe mỗi ngày</p>
                    </div>
                </div>
                
                <div class="col-md-3 col-6">
                    <div style="transition: all 0.3s;" onmouseover="this.style.transform='translateY(-10px)'" onmouseout="this.style.transform='translateY(0)'">
                        <div style="font-size: 3.5rem; margin-bottom: 15px;">
                            <i class="fas fa-route"></i>
                        </div>
                        <h2 style="font-size: 3rem; font-weight: bold; margin-bottom: 10px;">
                            <span class="counter" data-target="63">0</span>+
                        </h2>
                        <p style="font-size: 1.2rem; opacity: 0.9;">Tuyến đường</p>
                    </div>
                </div>
                
                <div class="col-md-3 col-6">
                    <div style="transition: all 0.3s;" onmouseover="this.style.transform='translateY(-10px)'" onmouseout="this.style.transform='translateY(0)'">
                        <div style="font-size: 3.5rem; margin-bottom: 15px;">
                            <i class="fas fa-star"></i>
                        </div>
                        <h2 style="font-size: 3rem; font-weight: bold; margin-bottom: 10px;">
                            <span class="counter" data-target="98">0</span>%
                        </h2>
                        <p style="font-size: 1.2rem; opacity: 0.9;">Khách hài lòng</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Popular Routes Section -->
    <section class="popular-routes" style="background: #f8f9fa; padding: 60px 0;">
        <div class="container">
            <h2 class="text-center mb-5" style="color: var(--primary-color); font-weight: bold;">
                <i class="fas fa-route"></i> Tuyến đường phổ biến
            </h2>
            <div class="row g-4">
                <div class="col-md-3">
                    <div class="route-card" style="background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.1); transition: all 0.3s; cursor: pointer;" 
                         onclick="searchRoute('Hà Nội', 'Hải Phòng')">
                        <div style="height: 200px; overflow: hidden;">
                            <img src="https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=400&h=200&fit=crop" 
                                 alt="Hà Nội - Hải Phòng" 
                                 style="width: 100%; height: 100%; object-fit: cover; transition: all 0.3s;"
                                 onmouseover="this.style.transform='scale(1.1)'"
                                 onmouseout="this.style.transform='scale(1)'">
                        </div>
                        <div style="padding: 20px;">
                            <h5 style="color: #333; font-weight: bold; margin-bottom: 10px;">
                                Hà Nội - Hải Phòng
                            </h5>
                            <div style="color: #666; margin-bottom: 10px;">
                                <i class="fas fa-clock"></i> 2 giờ 30 phút
                            </div>
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <div style="color: var(--primary-color); font-weight: bold; font-size: 1.2rem;">
                                    Từ 150.000đ
                                </div>
                                <div style="color: #28a745;">
                                    <i class="fas fa-bus"></i> 5+ chuyến/ngày
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="route-card" style="background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.1); transition: all 0.3s; cursor: pointer;"
                         onclick="searchRoute('Hà Nội', 'Nam Định')">
                        <div style="height: 200px; overflow: hidden;">
                            <img src="https://images.unsplash.com/photo-1570125909232-eb263c188f7e?w=400&h=200&fit=crop" 
                                 alt="Hà Nội - Nam Định"
                                 style="width: 100%; height: 100%; object-fit: cover; transition: all 0.3s;"
                                 onmouseover="this.style.transform='scale(1.1)'"
                                 onmouseout="this.style.transform='scale(1)'">
                        </div>
                        <div style="padding: 20px;">
                            <h5 style="color: #333; font-weight: bold; margin-bottom: 10px;">
                                Hà Nội - Nam Định
                            </h5>
                            <div style="color: #666; margin-bottom: 10px;">
                                <i class="fas fa-clock"></i> 2 giờ
                            </div>
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <div style="color: var(--primary-color); font-weight: bold; font-size: 1.2rem;">
                                    Từ 120.000đ
                                </div>
                                <div style="color: #28a745;">
                                    <i class="fas fa-bus"></i> 3+ chuyến/ngày
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="route-card" style="background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.1); transition: all 0.3s; cursor: pointer;"
                         onclick="searchRoute('Hà Nội', 'Đà Nẵng')">
                        <div style="height: 200px; overflow: hidden;">
                            <img src="https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=400&h=200&fit=crop" 
                                 alt="Hà Nội - Đà Nẵng"
                                 style="width: 100%; height: 100%; object-fit: cover; transition: all 0.3s;"
                                 onmouseover="this.style.transform='scale(1.1)'"
                                 onmouseout="this.style.transform='scale(1)'">
                        </div>
                        <div style="padding: 20px;">
                            <h5 style="color: #333; font-weight: bold; margin-bottom: 10px;">
                                Hà Nội - Đà Nẵng
                            </h5>
                            <div style="color: #666; margin-bottom: 10px;">
                                <i class="fas fa-clock"></i> 14 giờ
                            </div>
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <div style="color: var(--primary-color); font-weight: bold; font-size: 1.2rem;">
                                    Từ 400.000đ
                                </div>
                                <div style="color: #28a745;">
                                    <i class="fas fa-bus"></i> 4+ chuyến/ngày
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="route-card" style="background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.1); transition: all 0.3s; cursor: pointer;"
                         onclick="searchRoute('Hà Nội', 'TP.HCM')">
                        <div style="height: 200px; overflow: hidden;">
                            <img src="https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=400&h=200&fit=crop" 
                                 alt="Hà Nội - TP.HCM"
                                 style="width: 100%; height: 100%; object-fit: cover; transition: all 0.3s;"
                                 onmouseover="this.style.transform='scale(1.1)'"
                                 onmouseout="this.style.transform='scale(1)'">
                        </div>
                        <div style="padding: 20px;">
                            <h5 style="color: #333; font-weight: bold; margin-bottom: 10px;">
                                Hà Nội - TP.HCM
                            </h5>
                            <div style="color: #666; margin-bottom: 10px;">
                                <i class="fas fa-clock"></i> 30 giờ
                            </div>
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <div style="color: var(--primary-color); font-weight: bold; font-size: 1.2rem;">
                                    Từ 800.000đ
                                </div>
                                <div style="color: #28a745;">
                                    <i class="fas fa-bus"></i> 6+ chuyến/ngày
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/customer?action=search" class="btn btn-outline-primary btn-lg">
                    <i class="fas fa-list"></i> Xem tất cả tuyến đường
                </a>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section style="padding: 60px 0; background: white;">
        <div class="container">
            <h2 class="text-center mb-5" style="color: var(--primary-color); font-weight: bold;">
                <i class="fas fa-map-signs"></i> Đặt vé chỉ với 3 bước
            </h2>
            <div class="row g-4">
                <div class="col-md-4 text-center">
                    <div style="position: relative; margin-bottom: 20px;">
                        <div style="width: 100px; height: 100px; background: linear-gradient(135deg, #667eea, #764ba2); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto; box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);">
                            <i class="fas fa-search" style="font-size: 2.5rem; color: white;"></i>
                        </div>
                        <div style="position: absolute; top: -10px; right: calc(50% - 70px); background: var(--primary-color); color: white; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 1.2rem; box-shadow: 0 3px 10px rgba(255, 107, 53, 0.5);">1</div>
                    </div>
                    <h4 style="color: #333; margin-bottom: 15px;">Tìm chuyến xe</h4>
                    <p style="color: #666;">Nhập điểm đi, điểm đến và ngày khởi hành để tìm chuyến phù hợp</p>
                </div>

                <div class="col-md-4 text-center">
                    <div style="position: relative; margin-bottom: 20px;">
                        <div style="width: 100px; height: 100px; background: linear-gradient(135deg, #667eea, #764ba2); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto; box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);">
                            <i class="fas fa-chair" style="font-size: 2.5rem; color: white;"></i>
                        </div>
                        <div style="position: absolute; top: -10px; right: calc(50% - 70px); background: var(--primary-color); color: white; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 1.2rem; box-shadow: 0 3px 10px rgba(255, 107, 53, 0.5);">2</div>
                    </div>
                    <h4 style="color: #333; margin-bottom: 15px;">Chọn ghế & Điền thông tin</h4>
                    <p style="color: #666;">Chọn ghế ngồi yêu thích và nhập thông tin liên hệ của bạn</p>
                </div>

                <div class="col-md-4 text-center">
                    <div style="position: relative; margin-bottom: 20px;">
                        <div style="width: 100px; height: 100px; background: linear-gradient(135deg, #667eea, #764ba2); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto; box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);">
                            <i class="fas fa-check-circle" style="font-size: 2.5rem; color: white;"></i>
                        </div>
                        <div style="position: absolute; top: -10px; right: calc(50% - 70px); background: var(--primary-color); color: white; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 1.2rem; box-shadow: 0 3px 10px rgba(255, 107, 53, 0.5);">3</div>
                    </div>
                    <h4 style="color: #333; margin-bottom: 15px;">Xác nhận & Nhận vé</h4>
                    <p style="color: #666;">Hoàn tất đặt vé và nhận email xác nhận ngay lập tức</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="feature-section">
        <div class="container">
            <h2 class="text-center mb-5" style="color: var(--primary-color); font-weight: bold;">
                Tại sao chọn chúng tôi?
            </h2>
            <div class="row g-4">
                <div class="col-md-3">
                    <div class="feature-card">
                        <i class="fas fa-bolt"></i>
                        <h5>Đặt vé nhanh chóng</h5>
                        <p>Chỉ 3 bước đơn giản để đặt vé của bạn</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-card">
                        <i class="fas fa-shield-alt"></i>
                        <h5>An toàn & bảo mật</h5>
                        <p>Thông tin được mã hóa và bảo mật tuyệt đối</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-card">
                        <i class="fas fa-headset"></i>
                        <h5>Hỗ trợ 24/7</h5>
                        <p>Đội ngũ hỗ trợ luôn sẵn sàng giúp bạn</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="feature-card">
                        <i class="fas fa-money-bill-wave"></i>
                        <h5>Giá cả hợp lý</h5>
                        <p>Cam kết giá tốt nhất thị trường</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Links Section -->
    <section class="quick-links">
        <div class="container">
            <h2 class="text-center mb-5" style="color: #333; font-weight: bold;">
                Dịch vụ khác
            </h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <a href="${pageContext.request.contextPath}/customer?action=lookup" class="quick-link-card">
                        <i class="fas fa-search text-info"></i>
                        <h5>Tra cứu vé</h5>
                        <p>Kiểm tra thông tin vé đã đặt</p>
                    </a>
                </div>
                <div class="col-md-4">
                    <a href="${pageContext.request.contextPath}/customer?action=cancel" class="quick-link-card">
                        <i class="fas fa-times-circle text-danger"></i>
                        <h5>Hủy vé</h5>
                        <p>Hủy vé trước 2 giờ khởi hành</p>
                    </a>
                </div>
                <div class="col-md-4">
                    <a href="${pageContext.request.contextPath}/customer?action=search" class="quick-link-card">
                        <i class="fas fa-route text-success"></i>
                        <h5>Xem tuyến đường</h5>
                        <p>Khám phá các tuyến đường phổ biến</p>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p class="mb-2"><strong><i class="fas fa-bus"></i> TMT GROUP</strong></p>
            <p class="mb-3" style="font-size: 0.9rem; opacity: 0.9;">
                Hệ thống đặt vé xe khách trực tuyến hàng đầu Việt Nam
            </p>
            <p class="mb-2">
                <i class="fas fa-phone"></i> Hotline: 1900-8386 | 
                <i class="fas fa-envelope"></i> Email: contact@tmtgroup.vn
            </p>
            <p class="mb-2">
                <i class="fas fa-map-marker-alt"></i> Trụ sở: 123 Nguyễn Huệ, Quận 1, TP. Hồ Chí Minh
            </p>
            <p class="mb-0" style="opacity: 0.7;">
                © 2025 TMT Group. All rights reserved. | Made with ❤️ by Trưởng, Tài, Minh
            </p>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Animated Counter
        function animateCounter() {
            const counters = document.querySelectorAll('.counter');
            counters.forEach(counter => {
                const target = parseInt(counter.getAttribute('data-target'));
                const duration = 2000; // 2 seconds
                const increment = target / (duration / 16); // 60fps
                let current = 0;
                
                const updateCounter = () => {
                    current += increment;
                    if (current < target) {
                        counter.textContent = Math.floor(current);
                        requestAnimationFrame(updateCounter);
                    } else {
                        counter.textContent = target;
                    }
                };
                
                updateCounter();
            });
        }

        // Trigger counter animation when scrolled into view
        const observerOptions = {
            threshold: 0.5,
            rootMargin: '0px 0px -100px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    animateCounter();
                    observer.disconnect(); // Run only once
                }
            });
        }, observerOptions);

        // Observe the statistics section
        window.addEventListener('DOMContentLoaded', () => {
            const statsSection = document.querySelector('.counter');
            if (statsSection) {
                observer.observe(statsSection.closest('section'));
            }
        });

        // Function to search route when clicking on popular route card
        function searchRoute(diemDi, diemDen) {
            // Không truyền ngày để hiển thị tất cả chuyến của tuyến này
            window.location.href = '${pageContext.request.contextPath}/customer?action=search&diemDi=' + 
                                   encodeURIComponent(diemDi) + 
                                   '&diemDen=' + encodeURIComponent(diemDen);
        }

        // Hover effect for route cards
        document.addEventListener('DOMContentLoaded', function() {
            const routeCards = document.querySelectorAll('.route-card');
            routeCards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-10px)';
                    this.style.boxShadow = '0 10px 30px rgba(0,0,0,0.2)';
                });
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                    this.style.boxShadow = '0 5px 15px rgba(0,0,0,0.1)';
                });
            });
        });
    </script>
</body>
</html>


