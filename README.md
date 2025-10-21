# 🚌 HỆ THỐNG QUẢN LY VÉ XE KHÁCH

Ứng dụng web quản lý đặt vé xe khách sử dụng Java Servlet, JSP, SQL Server

---

## 📋 TÍNH NĂNG CHÍNH

### 1. 🔐 Quản lý Tài khoản & Phân quyền
- Đăng nhập/Đăng xuất
- Phân quyền: Admin, Nhân viên
- Quản lý tài khoản người dùng (CRUD)

### 2. 🚌 Quản lý Chuyến Xe
- Thêm/Sửa/Xóa chuyến xe
- Tìm kiếm, lọc theo điểm đi, điểm đến, ngày
- Quản lý số ghế, giá vé, trạng thái

### 3. 👥 Quản lý Khách Hàng
- Tự động tạo khách hàng khi đặt vé
- Tìm kiếm theo tên, SĐT, email
- Xem lịch sử đặt vé của khách hàng

### 4. 🎫 Quản lý Đặt Vé
- Đặt vé với chọn ghế trực quan
- Kiểm tra ghế còn trống real-time
- Hủy vé
- Tìm kiếm vé

### 5. 📊 Dashboard Thống kê
- Tổng số chuyến xe, vé, khách hàng
- Số vé đã đặt, đã hủy, đang sử dụng
- Cập nhật real-time

### 6. 📄 Xuất PDF
- Xuất vé ra file PDF
- Định dạng chuyên nghiệp
- Hỗ trợ tiếng Việt

### 7. 📧 Gửi Email Tự Động (⭐ MỚI)
- Gửi email xác nhận sau khi đặt vé thành công
- Template email HTML đẹp, responsive
- Đầy đủ thông tin vé, chuyến xe, khách hàng
- Xử lý lỗi tốt, không ảnh hưởng đến đặt vé

---

## 🛠 CÔNG NGHỆ SỬ DỤNG

### Backend:
- **Java Servlet** - Xử lý logic
- **JSP + JSTL** - Giao diện động
- **JDBC** - Kết nối SQL Server
- **DAO Pattern** - Truy xuất dữ liệu
- **Filter** - Authentication, Authorization, Encoding

### Frontend:
- **Bootstrap 5** - Responsive UI
- **JavaScript/jQuery** - Tương tác động
- **Font Awesome** - Icons

### Database:
- **SQL Server** - CSDL chính
- **Views** - Tối ưu truy vấn phức tạp

### Libraries:
- **iText PDF** - Xuất PDF
- **JavaMail API** - Gửi email

### Build Tool:
- **Maven** - Quản lý dependencies

---

## 📁 CẤU TRÚC DỰ ÁN

```
WebQuanLyVeXeKhach/
├── src/main/
│   ├── java/
│   │   ├── controller/          # Servlets
│   │   │   ├── LoginServlet.java
│   │   │   ├── HomeServlet.java
│   │   │   ├── ChuyenXeServlet.java
│   │   │   ├── KhachHangServlet.java
│   │   │   ├── VeXeServlet.java
│   │   │   ├── TaiKhoanServlet.java
│   │   │   └── ExportPDFServlet.java
│   │   ├── model/               # DAO & Entity
│   │   │   ├── TaiKhoan.java
│   │   │   ├── TaiKhoanDAO.java
│   │   │   ├── ChuyenXe.java
│   │   │   ├── ChuyenXeDAO.java
│   │   │   ├── KhachHang.java
│   │   │   ├── KhachHangDAO.java
│   │   │   ├── VeXe.java
│   │   │   └── VeXeDAO.java
│   │   ├── filter/              # Filters
│   │   │   ├── AuthFilter.java
│   │   │   ├── RoleFilter.java
│   │   │   └── EncodingFilter.java
│   │   └── util/                # Utilities
│   │       ├── DBConnection.java
│   │       └── EmailService.java    ⭐ MỚI
│   └── webapp/
│       ├── login.jsp
│       ├── admin/
│       │   ├── dashboard.jsp
│       │   ├── list-chuyenxe.jsp
│       │   ├── list-khachhang.jsp
│       │   ├── list-vexe.jsp
│       │   ├── form-vexe.jsp
│       │   ├── list-taikhoan.jsp
│       │   └── layout/
│       │       ├── header.jsp
│       │       ├── sidebar.jsp
│       │       └── footer.jsp
│       └── WEB-INF/
│           └── web.xml
├── QuanLyVeXeKhach.sql          # Database script
├── EMAIL_SETUP.md               # Hướng dẫn cấu hình email ⭐ MỚI
├── email-preview.html           # Preview email template ⭐ MỚI
├── pom.xml
└── README.md
```

---

## 🗄 CƠ SỞ DỮ LIỆU

### Tables:
1. **TaiKhoan** - Tài khoản người dùng
2. **ChuyenXe** - Thông tin chuyến xe
3. **KhachHang** - Thông tin khách hàng
4. **VeXe** - Vé đã đặt

### Views:
1. **V_ThongTinVe** - Chi tiết vé (join 3 bảng)
2. **V_ThongKeChuyenXe** - Thống kê vé theo chuyến

---

## 🚀 HƯỚNG DẪN CÀI ĐẶT

### 1. Cài đặt môi trường:
- JDK 8+
- Apache Tomcat 9+
- SQL Server 2019+
- Maven 3.6+
- NetBeans/IntelliJ/Eclipse

### 2. Cấu hình Database:
```sql
-- Chạy file QuanLyVeXeKhach.sql trong SQL Server
-- Nó sẽ tự động:
--   - Tạo database QuanLyVeXeKhach
--   - Tạo các bảng
--   - Insert dữ liệu mẫu
--   - Tạo views
```

### 3. Cấu hình kết nối DB:
Mở file: `src/main/java/util/DBConnection.java`
```java
private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=QuanLyVeXeKhach;encrypt=true;trustServerCertificate=true";
private static final String USER = "qlvk";      // Đổi theo user của bạn
private static final String PASS = "123456";    // Đổi theo password của bạn
```

### 4. Cấu hình Email (Tùy chọn):
Xem hướng dẫn chi tiết trong: **[EMAIL_SETUP.md](EMAIL_SETUP.md)**

Mở file: `src/main/java/util/EmailService.java`
```java
private static final String EMAIL_USERNAME = "your-email@gmail.com";
private static final String EMAIL_PASSWORD = "your-app-password";
```

### 5. Build & Deploy:
```bash
# Clean & compile
mvn clean compile

# Package thành WAR
mvn clean package

# File WAR sẽ ở: target/WebQuanLyVeXeKhach-1.0-SNAPSHOT.war
# Copy vào Tomcat webapps/ hoặc deploy từ IDE
```

### 6. Chạy ứng dụng:
```
http://localhost:8080/WebQuanLyVeXeKhach/
```

---

## 👤 TÀI KHOẢN MẪU

### Admin:
- Username: `admin`
- Password: `admin123`

### Nhân viên:
- Username: `nhanvien1`
- Password: `nv123456`

---

## 🔗 URL MAPPINGS

| Chức năng | URL | Servlet |
|-----------|-----|---------|
| Đăng nhập | `/login` | LoginServlet |
| Đăng xuất | `/login?action=logout` | LoginServlet |
| Dashboard | `/trang-chu` | HomeServlet |
| Quản lý chuyến xe | `/chuyenxe` | ChuyenXeServlet |
| Quản lý khách hàng | `/khachhang` | KhachHangServlet |
| Quản lý vé | `/vexe` | VeXeServlet |
| Quản lý tài khoản | `/taikhoan` | TaiKhoanServlet |
| Xuất PDF | `/export-pdf` | ExportPDFServlet |

---

## 📧 TÍNH NĂNG EMAIL

### Khi nào gửi email?
- ✅ Sau khi đặt vé thành công
- ✅ Khách hàng có nhập email

### Email chứa gì?
- Mã vé
- Thông tin chuyến xe (số xe, tuyến đường, ngày giờ)
- Thông tin vé (số ghế, giá vé)
- Thông tin khách hàng
- Lưu ý và hướng dẫn

### Preview Email:
Mở file `email-preview.html` trong trình duyệt để xem giao diện email

---

## 🎨 THEME & UI

- **Màu chủ đạo:** Orange (#ff8c00)
- **Style:** Modern, Clean, Professional
- **Responsive:** Tương thích mobile, tablet, desktop
- **Icons:** Font Awesome 6.0

---

## 🔒 BẢO MẬT

- ✅ Authentication Filter - Bảo vệ trang admin
- ✅ Role-based Authorization - Phân quyền Admin/Nhân viên
- ✅ UTF-8 Encoding - Hỗ trợ tiếng Việt
- ✅ SQL Injection Prevention - Sử dụng PreparedStatement
- ✅ Session Management - Quản lý phiên đăng nhập

---

## 📊 PHẦN NÂNG CAO ĐÃ LÀM

- ✅ **Gửi email xác nhận đặt vé** (JavaMail API)
- ⏳ **Báo cáo doanh thu theo ngày/tháng** (Đang làm)

---

## 🐛 TROUBLESHOOTING

### Lỗi kết nối database:
```
Kiểm tra:
- SQL Server có đang chạy không?
- Username/password đúng chưa?
- Database đã được tạo chưa?
- Port 1433 có bị block không?
```

### Lỗi gửi email:
```
Xem hướng dẫn chi tiết trong EMAIL_SETUP.md
```

### Lỗi encoding tiếng Việt:
```
Đảm bảo:
- EncodingFilter đã được cấu hình
- Database collation: Vietnamese_CI_AS
- File .jsp có: <%@page contentType="text/html" pageEncoding="UTF-8"%>
```

---

## 📝 CHANGELOG

### Version 1.1 (21/10/2024)
- ✅ Thêm tính năng gửi email xác nhận đặt vé
- ✅ Template email HTML responsive
- ✅ Xử lý lỗi email tốt hơn

### Version 1.0 (20/10/2024)
- ✅ Hoàn thành các tính năng cơ bản
- ✅ Xuất PDF vé
- ✅ Xem lịch sử khách hàng

---

## 📞 HỖ TRỢ

Nếu gặp vấn đề, kiểm tra:
1. Console log trong Tomcat
2. File `EMAIL_SETUP.md` cho hướng dẫn cấu hình email
3. File `QuanLyVeXeKhach.sql` cho cấu trúc database

---

## 📄 LICENSE

This project is for educational purposes only.

---

**Phát triển bởi:** Nhóm LTrinh_JV_NangCao  
**Ngày:** 10/2024  
**Version:** 1.1

