package model;

import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class cho bảng KhachHang
 */
public class KhachHangDAO {

    /**
     * Lấy tất cả khách hàng
     */
    public List<KhachHang> getAllKhachHang() {
        List<KhachHang> list = new ArrayList<>();
        String sql = "SELECT * FROM KhachHang ORDER BY ngayDangKy DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                list.add(extractKhachHangFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy khách hàng theo mã
     */
    public KhachHang getById(int maKH) {
        String sql = "SELECT * FROM KhachHang WHERE maKH = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, maKH);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractKhachHangFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy khách hàng theo số điện thoại
     */
    public KhachHang getBySdt(String sdt) {
        String sql = "SELECT * FROM KhachHang WHERE sdt = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, sdt);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractKhachHangFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Thêm khách hàng mới
     */
    public int insert(KhachHang kh) {
        String sql = "INSERT INTO KhachHang (hoTen, sdt, email, diaChi) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, kh.getHoTen());
            ps.setString(2, kh.getSdt());
            ps.setString(3, kh.getEmail());
            ps.setString(4, kh.getDiaChi());
            
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // Trả về maKH vừa tạo
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * Cập nhật khách hàng
     */
    public boolean update(KhachHang kh) {
        String sql = "UPDATE KhachHang SET hoTen = ?, sdt = ?, email = ?, diaChi = ? WHERE maKH = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, kh.getHoTen());
            ps.setString(2, kh.getSdt());
            ps.setString(3, kh.getEmail());
            ps.setString(4, kh.getDiaChi());
            ps.setInt(5, kh.getMaKH());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa khách hàng
     */
    public boolean delete(int maKH) {
        String sql = "DELETE FROM KhachHang WHERE maKH = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, maKH);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Tìm kiếm khách hàng theo tên hoặc số điện thoại
     */
    public List<KhachHang> searchKhachHang(String keyword) {
        List<KhachHang> list = new ArrayList<>();
        String sql = "SELECT * FROM KhachHang WHERE hoTen LIKE N'%' + ? + '%' OR sdt LIKE '%' + ? + '%' ORDER BY ngayDangKy DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, keyword);
            ps.setString(2, keyword);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractKhachHangFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Đếm tổng số khách hàng
     */
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM KhachHang";
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
     * Extract KhachHang from ResultSet
     */
    private KhachHang extractKhachHangFromResultSet(ResultSet rs) throws SQLException {
        KhachHang kh = new KhachHang();
        kh.setMaKH(rs.getInt("maKH"));
        kh.setHoTen(rs.getString("hoTen"));
        kh.setSdt(rs.getString("sdt"));
        kh.setEmail(rs.getString("email"));
        kh.setDiaChi(rs.getString("diaChi"));
        kh.setNgayDangKy(rs.getTimestamp("ngayDangKy"));
        return kh;
    }
}



