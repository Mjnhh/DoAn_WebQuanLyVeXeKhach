package model;

import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class cho bảng ChuyenXe
 */
public class ChuyenXeDAO {

    /**
     * Lấy tất cả chuyến xe
     */
    public List<ChuyenXe> getAllChuyenXe() {
        List<ChuyenXe> list = new ArrayList<>();
        String sql = "SELECT * FROM ChuyenXe ORDER BY ngayKhoiHanh DESC, gioKhoiHanh DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                list.add(extractChuyenXeFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy chuyến xe theo mã
     */
    public ChuyenXe getById(int maCX) {
        String sql = "SELECT * FROM ChuyenXe WHERE maCX = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, maCX);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractChuyenXeFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Thêm chuyến xe mới
     */
    public boolean insert(ChuyenXe cx) {
        String sql = "INSERT INTO ChuyenXe (soXe, diemDi, diemDen, ngayKhoiHanh, gioKhoiHanh, giaVe, soGhe, soGheTrong, trangThai) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, cx.getSoXe());
            ps.setString(2, cx.getDiemDi());
            ps.setString(3, cx.getDiemDen());
            ps.setDate(4, cx.getNgayKhoiHanh());
            ps.setTime(5, cx.getGioKhoiHanh());
            ps.setBigDecimal(6, cx.getGiaVe());
            ps.setInt(7, cx.getSoGhe());
            ps.setInt(8, cx.getSoGheTrong());
            ps.setString(9, cx.getTrangThai() != null ? cx.getTrangThai() : "Hoạt động");
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Cập nhật chuyến xe
     */
    public boolean update(ChuyenXe cx) {
        String sql = "UPDATE ChuyenXe SET soXe = ?, diemDi = ?, diemDen = ?, ngayKhoiHanh = ?, " +
                     "gioKhoiHanh = ?, giaVe = ?, soGhe = ?, soGheTrong = ?, trangThai = ? WHERE maCX = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, cx.getSoXe());
            ps.setString(2, cx.getDiemDi());
            ps.setString(3, cx.getDiemDen());
            ps.setDate(4, cx.getNgayKhoiHanh());
            ps.setTime(5, cx.getGioKhoiHanh());
            ps.setBigDecimal(6, cx.getGiaVe());
            ps.setInt(7, cx.getSoGhe());
            ps.setInt(8, cx.getSoGheTrong());
            ps.setString(9, cx.getTrangThai());
            ps.setInt(10, cx.getMaCX());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa chuyến xe
     */
    public boolean delete(int maCX) {
        String sql = "DELETE FROM ChuyenXe WHERE maCX = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, maCX);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Tìm kiếm chuyến xe theo điểm đi, điểm đến, ngày khởi hành
     */
    public List<ChuyenXe> searchChuyenXe(String diemDi, String diemDen, Date ngayKhoiHanh) {
        List<ChuyenXe> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM ChuyenXe WHERE 1=1");
        
        if (diemDi != null && !diemDi.trim().isEmpty()) {
            sql.append(" AND diemDi LIKE N'%").append(diemDi).append("%'");
        }
        if (diemDen != null && !diemDen.trim().isEmpty()) {
            sql.append(" AND diemDen LIKE N'%").append(diemDen).append("%'");
        }
        if (ngayKhoiHanh != null) {
            sql.append(" AND ngayKhoiHanh = '").append(ngayKhoiHanh).append("'");
        }
        sql.append(" ORDER BY ngayKhoiHanh, gioKhoiHanh");
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql.toString())) {
            
            while (rs.next()) {
                list.add(extractChuyenXeFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Cập nhật số ghế trống khi đặt vé
     */
    public boolean updateSoGheTrong(int maCX, int soGheDat) {
        String sql = "UPDATE ChuyenXe SET soGheTrong = soGheTrong - ? WHERE maCX = ? AND soGheTrong >= ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, soGheDat);
            ps.setInt(2, maCX);
            ps.setInt(3, soGheDat);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Cập nhật số ghế trống khi hủy vé
     */
    public boolean updateSoGheTrongWhenCancel(int maCX, int soGheHuy) {
        String sql = "UPDATE ChuyenXe SET soGheTrong = soGheTrong + ? WHERE maCX = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, soGheHuy);
            ps.setInt(2, maCX);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Kiểm tra số ghế còn trống
     */
    public int getSoGheTrong(int maCX) {
        String sql = "SELECT soGheTrong FROM ChuyenXe WHERE maCX = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, maCX);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("soGheTrong");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Đếm tổng số chuyến xe
     */
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM ChuyenXe";
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
     * Đếm số chuyến xe hoạt động
     */
    public int getActiveCount() {
        String sql = "SELECT COUNT(*) FROM ChuyenXe WHERE trangThai = N'Hoạt động'";
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
     * Extract ChuyenXe from ResultSet
     */
    private ChuyenXe extractChuyenXeFromResultSet(ResultSet rs) throws SQLException {
        ChuyenXe cx = new ChuyenXe();
        cx.setMaCX(rs.getInt("maCX"));
        cx.setSoXe(rs.getString("soXe"));
        cx.setDiemDi(rs.getString("diemDi"));
        cx.setDiemDen(rs.getString("diemDen"));
        cx.setNgayKhoiHanh(rs.getDate("ngayKhoiHanh"));
        cx.setGioKhoiHanh(rs.getTime("gioKhoiHanh"));
        cx.setGiaVe(rs.getBigDecimal("giaVe"));
        cx.setSoGhe(rs.getInt("soGhe"));
        cx.setSoGheTrong(rs.getInt("soGheTrong"));
        cx.setTrangThai(rs.getString("trangThai"));
        return cx;
    }
}



