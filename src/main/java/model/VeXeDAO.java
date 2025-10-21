package model;

import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class cho bảng VeXe
 */
public class VeXeDAO {

    /**
     * Lấy tất cả vé xe
     */
    public List<VeXe> getAllVeXe() {
        List<VeXe> list = new ArrayList<>();
        String sql = "SELECT * FROM V_ThongTinVe ORDER BY ngayDat DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                list.add(extractVeXeDetailFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy vé xe theo mã
     */
    public VeXe getById(int maVe) {
        String sql = "SELECT * FROM V_ThongTinVe WHERE maVe = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, maVe);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractVeXeDetailFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy vé theo chuyến xe
     */
    public List<VeXe> getByChuyenXe(int maCX) {
        List<VeXe> list = new ArrayList<>();
        String sql = "SELECT * FROM V_ThongTinVe WHERE maCX = ? ORDER BY soGhe";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, maCX);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractVeXeDetailFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy vé theo khách hàng
     */
    public List<VeXe> getByKhachHang(int maKH) {
        List<VeXe> list = new ArrayList<>();
        String sql = "SELECT * FROM V_ThongTinVe WHERE maKH = ? ORDER BY ngayDat DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, maKH);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractVeXeDetailFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Đặt vé mới
     */
    public boolean insert(VeXe ve) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            // 1. Kiểm tra số ghế còn trống
            ChuyenXeDAO cxDao = new ChuyenXeDAO();
            int soGheTrong = cxDao.getSoGheTrong(ve.getMaCX());
            if (soGheTrong < 1) {
                conn.rollback();
                return false;
            }
            
            // 2. Kiểm tra ghế đã được đặt chưa
            if (isGheDaDat(ve.getMaCX(), ve.getSoGhe())) {
                conn.rollback();
                return false;
            }
            
            // 3. Thêm vé mới
            String sql = "INSERT INTO VeXe (maCX, maKH, soGhe, trangThai, ghiChu) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, ve.getMaCX());
                ps.setInt(2, ve.getMaKH());
                ps.setInt(3, ve.getSoGhe());
                ps.setString(4, ve.getTrangThai() != null ? ve.getTrangThai() : "Đã đặt");
                ps.setString(5, ve.getGhiChu());
                
                if (ps.executeUpdate() > 0) {
                    // Lấy ID vừa tạo và set vào object
                    try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            ve.setMaVe(generatedKeys.getInt(1));
                            System.out.println(">>> Vé mới được tạo với ID: " + ve.getMaVe());
                        }
                    }
                    
                    // 4. Cập nhật số ghế trống
                    if (cxDao.updateSoGheTrong(ve.getMaCX(), 1)) {
                        conn.commit();
                        return true;
                    }
                }
            }
            
            conn.rollback();
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return false;
    }

    /**
     * Hủy vé
     */
    public boolean cancelVe(int maVe) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            // 1. Lấy thông tin vé
            VeXe ve = getById(maVe);
            if (ve == null || "Đã hủy".equals(ve.getTrangThai())) {
                conn.rollback();
                return false;
            }
            
            // 2. Cập nhật trạng thái vé
            String sql = "UPDATE VeXe SET trangThai = N'Đã hủy' WHERE maVe = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, maVe);
                
                if (ps.executeUpdate() > 0) {
                    // 3. Cập nhật lại số ghế trống
                    ChuyenXeDAO cxDao = new ChuyenXeDAO();
                    if (cxDao.updateSoGheTrongWhenCancel(ve.getMaCX(), 1)) {
                        conn.commit();
                        return true;
                    }
                }
            }
            
            conn.rollback();
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return false;
    }

    /**
     * Cập nhật trạng thái vé
     */
    public boolean updateTrangThai(int maVe, String trangThai) {
        String sql = "UPDATE VeXe SET trangThai = ? WHERE maVe = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, trangThai);
            ps.setInt(2, maVe);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Tìm vé theo số điện thoại hoặc mã vé
     */
    public List<VeXe> searchVe(String keyword) {
        List<VeXe> list = new ArrayList<>();
        String sql = "SELECT * FROM V_ThongTinVe WHERE sdtKhachHang LIKE '%' + ? + '%' OR CAST(maVe AS VARCHAR) LIKE '%' + ? + '%' ORDER BY ngayDat DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, keyword);
            ps.setString(2, keyword);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractVeXeDetailFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Kiểm tra ghế đã được đặt chưa
     */
    public boolean isGheDaDat(int maCX, int soGhe) {
        String sql = "SELECT COUNT(*) FROM VeXe WHERE maCX = ? AND soGhe = ? AND trangThai = N'Đã đặt'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, maCX);
            ps.setInt(2, soGhe);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Lấy danh sách số ghế đã đặt của chuyến xe
     */
    public List<Integer> getDanhSachGheDaDat(int maCX) {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT soGhe FROM VeXe WHERE maCX = ? AND trangThai = N'Đã đặt' ORDER BY soGhe";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, maCX);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getInt("soGhe"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Đếm tổng số vé
     */
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM VeXe";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Đếm số vé đã đặt
     */
    public int getVeDaDatCount() {
        String sql = "SELECT COUNT(*) FROM VeXe WHERE trangThai = N'Đã đặt'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Extract VeXe with details from View ResultSet
     */
    private VeXe extractVeXeDetailFromResultSet(ResultSet rs) throws SQLException {
        VeXe ve = new VeXe();
        ve.setMaVe(rs.getInt("maVe"));
        ve.setMaCX(rs.getInt("maCX"));
        ve.setMaKH(rs.getInt("maKH"));
        ve.setSoGhe(rs.getInt("soGhe"));
        ve.setNgayDat(rs.getTimestamp("ngayDat"));
        ve.setTrangThai(rs.getString("trangThaiVe"));
        ve.setGhiChu(rs.getString("ghiChu"));
        
        // Thông tin chuyến xe
        ChuyenXe cx = new ChuyenXe();
        cx.setMaCX(rs.getInt("maCX"));
        cx.setSoXe(rs.getString("soXe"));
        cx.setDiemDi(rs.getString("diemDi"));
        cx.setDiemDen(rs.getString("diemDen"));
        cx.setNgayKhoiHanh(rs.getDate("ngayKhoiHanh"));
        cx.setGioKhoiHanh(rs.getTime("gioKhoiHanh"));
        cx.setGiaVe(rs.getBigDecimal("giaVe"));
        ve.setChuyenXe(cx);
        
        // Thông tin khách hàng
        KhachHang kh = new KhachHang();
        kh.setMaKH(rs.getInt("maKH"));
        kh.setHoTen(rs.getString("tenKhachHang"));
        kh.setSdt(rs.getString("sdtKhachHang"));
        kh.setEmail(rs.getString("emailKhachHang"));
        kh.setDiaChi(rs.getString("diaChiKhachHang"));
        ve.setKhachHang(kh);
        
        return ve;
    }
}







