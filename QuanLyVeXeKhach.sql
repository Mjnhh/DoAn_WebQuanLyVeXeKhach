-- =============================================
-- Database: QuanLyVeXeKhach
-- Hệ thống quản lý vé xe khách
-- =============================================

-- Drop database nếu đã tồn tại (để tạo lại từ đầu)
USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'QuanLyVeXeKhach')
BEGIN
    ALTER DATABASE QuanLyVeXeKhach SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE QuanLyVeXeKhach;
END
GO

-- Tạo database mới
CREATE DATABASE QuanLyVeXeKhach;
GO

USE QuanLyVeXeKhach;
GO

-- =============================================
-- Bảng 1: TaiKhoan (Quản lý đăng nhập)
-- =============================================
CREATE TABLE TaiKhoan (
    username NVARCHAR(50) PRIMARY KEY,
    password NVARCHAR(100) NOT NULL,
    role NVARCHAR(20) NOT NULL CHECK (role IN ('Admin', N'Nhân viên')),
    hoTen NVARCHAR(100) NOT NULL,
    sdt NVARCHAR(15),
    email NVARCHAR(100),
    diaChi NVARCHAR(200),
    ngayTao DATETIME DEFAULT GETDATE()
);
GO

-- =============================================
-- Bảng 2: ChuyenXe (Thông tin chuyến xe)
-- =============================================
CREATE TABLE ChuyenXe (
    maCX INT PRIMARY KEY IDENTITY(1,1),
    soXe NVARCHAR(20) NOT NULL,
    diemDi NVARCHAR(100) NOT NULL,
    diemDen NVARCHAR(100) NOT NULL,
    ngayKhoiHanh DATE NOT NULL,
    gioKhoiHanh TIME NOT NULL,
    giaVe DECIMAL(10,2) NOT NULL,
    soGhe INT NOT NULL,
    soGheTrong INT NOT NULL,
    trangThai NVARCHAR(20) DEFAULT N'Hoạt động' CHECK (trangThai IN (N'Hoạt động', N'Đã hủy', N'Hoàn thành'))
);
GO

-- =============================================
-- Bảng 3: KhachHang (Thông tin khách hàng)
-- =============================================
CREATE TABLE KhachHang (
    maKH INT PRIMARY KEY IDENTITY(1,1),
    hoTen NVARCHAR(100) NOT NULL,
    sdt NVARCHAR(15) NOT NULL UNIQUE,
    email NVARCHAR(100),
    diaChi NVARCHAR(200),
    ngayDangKy DATETIME DEFAULT GETDATE()
);
GO

-- =============================================
-- Bảng 4: VeXe (Thông tin vé xe đã đặt)
-- =============================================
CREATE TABLE VeXe (
    maVe INT PRIMARY KEY IDENTITY(1,1),
    maCX INT NOT NULL,
    maKH INT NOT NULL,
    soGhe INT NOT NULL,
    ngayDat DATETIME DEFAULT GETDATE(),
    trangThai NVARCHAR(20) DEFAULT N'Đã đặt' CHECK (trangThai IN (N'Đã đặt', N'Đã hủy', N'Đã sử dụng')),
    ghiChu NVARCHAR(200),
    FOREIGN KEY (maCX) REFERENCES ChuyenXe(maCX) ON DELETE CASCADE,
    FOREIGN KEY (maKH) REFERENCES KhachHang(maKH) ON DELETE CASCADE
);
GO

-- =============================================
-- Thêm dữ liệu mẫu
-- =============================================

-- Tài khoản
INSERT INTO TaiKhoan (username, password, role, hoTen, sdt, email) VALUES
('admin', '123', 'Admin', N'Quản trị viên', '0901234567', 'admin@vexe.com'),
('nhanvien1', '123', N'Nhân viên', N'Nguyễn Văn A', '0912345678', 'nva@vexe.com'),
('nhanvien2', '123', N'Nhân viên', N'Trần Thị B', '0923456789', 'ttb@vexe.com');
GO

-- Chuyến xe
INSERT INTO ChuyenXe (soXe, diemDi, diemDen, ngayKhoiHanh, gioKhoiHanh, giaVe, soGhe, soGheTrong) VALUES
('51B-12345', N'Hà Nội', N'Hải Phòng', '2025-10-25', '06:00:00', 150000, 40, 40),
('51B-12346', N'Hà Nội', N'Hải Phòng', '2025-10-25', '08:00:00', 150000, 40, 38),
('51B-12347', N'Hà Nội', N'Hải Phòng', '2025-10-25', '10:00:00', 150000, 40, 35),
('51B-22345', N'Hà Nội', N'Nam Định', '2025-10-25', '07:00:00', 120000, 40, 40),
('51B-22346', N'Hà Nội', N'Nam Định', '2025-10-25', '14:00:00', 120000, 40, 40),
('29B-33345', N'Hà Nội', N'Huế', '2025-10-26', '20:00:00', 350000, 45, 45),
('29B-33346', N'Hà Nội', N'Huế', '2025-10-26', '21:00:00', 350000, 45, 43),
('43B-44345', N'Hà Nội', N'Đà Nẵng', '2025-10-27', '19:00:00', 400000, 45, 45),
('43B-44346', N'Hà Nội', N'Đà Nẵng', '2025-10-27', '20:00:00', 400000, 45, 40),
('50B-55345', N'Hà Nội', N'TP.HCM', '2025-10-28', '06:00:00', 800000, 50, 50),
('50B-55346', N'Hà Nội', N'TP.HCM', '2025-10-28', '18:00:00', 800000, 50, 48),
('51B-66345', N'Hải Phòng', N'Hà Nội', '2025-10-25', '14:00:00', 150000, 40, 40),
('51B-66346', N'Hải Phòng', N'Hà Nội', '2025-10-25', '16:00:00', 150000, 40, 39);
GO

-- Khách hàng
INSERT INTO KhachHang (hoTen, sdt, email, diaChi) VALUES
(N'Lê Văn C', '0934567890', 'lvc@gmail.com', N'123 Đường ABC, Hà Nội'),
(N'Phạm Thị D', '0945678901', 'ptd@gmail.com', N'456 Đường DEF, Hải Phòng'),
(N'Hoàng Văn E', '0956789012', 'hve@gmail.com', N'789 Đường GHI, Nam Định'),
(N'Nguyễn Thị F', '0967890123', 'ntf@gmail.com', N'321 Đường JKL, Hà Nội'),
(N'Trần Văn G', '0978901234', 'tvg@gmail.com', N'654 Đường MNO, Hải Phòng');
GO

-- Vé xe (một số vé đã đặt)
INSERT INTO VeXe (maCX, maKH, soGhe, trangThai, ghiChu) VALUES
(2, 1, 1, N'Đã đặt', N'Ghế cạnh cửa sổ'),
(2, 1, 2, N'Đã đặt', N'Ghế cạnh cửa sổ'),
(3, 2, 1, N'Đã đặt', NULL),
(3, 2, 2, N'Đã đặt', NULL),
(3, 3, 5, N'Đã đặt', NULL),
(3, 4, 10, N'Đã đặt', N'Hàng ghế đầu'),
(3, 5, 11, N'Đã đặt', NULL),
(7, 1, 3, N'Đã đặt', NULL),
(7, 3, 4, N'Đã đặt', NULL),
(9, 2, 1, N'Đã đặt', NULL),
(9, 2, 2, N'Đã đặt', NULL),
(9, 4, 5, N'Đã đặt', NULL),
(9, 5, 6, N'Đã đặt', NULL),
(9, 1, 10, N'Đã đặt', NULL),
(11, 3, 1, N'Đã đặt', NULL),
(11, 4, 2, N'Đã đặt', NULL),
(13, 5, 1, N'Đã đặt', NULL);
GO

-- =============================================
-- Views và Stored Procedures hữu ích
-- =============================================

-- View: Xem thông tin vé chi tiết
CREATE VIEW V_ThongTinVe AS
SELECT 
    v.maVe,
    v.soGhe,
    v.ngayDat,
    v.trangThai AS trangThaiVe,
    v.ghiChu,
    cx.maCX,
    cx.soXe,
    cx.diemDi,
    cx.diemDen,
    cx.ngayKhoiHanh,
    cx.gioKhoiHanh,
    cx.giaVe,
    kh.maKH,
    kh.hoTen AS tenKhachHang,
    kh.sdt AS sdtKhachHang,
    kh.email AS emailKhachHang,
    kh.diaChi AS diaChiKhachHang
FROM VeXe v
INNER JOIN ChuyenXe cx ON v.maCX = cx.maCX
INNER JOIN KhachHang kh ON v.maKH = kh.maKH;
GO

-- View: Thống kê chuyến xe
CREATE VIEW V_ThongKeChuyenXe AS
SELECT 
    cx.maCX,
    cx.soXe,
    cx.diemDi,
    cx.diemDen,
    cx.ngayKhoiHanh,
    cx.gioKhoiHanh,
    cx.giaVe,
    cx.soGhe,
    cx.soGheTrong,
    (cx.soGhe - cx.soGheTrong) AS soGheDaDat,
    CAST((cx.soGhe - cx.soGheTrong) * 100.0 / cx.soGhe AS DECIMAL(5,2)) AS tyLeLapDay,
    cx.trangThai
FROM ChuyenXe cx;
GO





