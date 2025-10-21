package model;

import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class cho bảng TaiKhoan
 */
public class TaiKhoanDAO {

    /**
     * Xác thực đăng nhập
     */
    public TaiKhoan authenticate(String username, String password) {
        String sql = "SELECT * FROM TaiKhoan WHERE username = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractTaiKhoanFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy tất cả tài khoản
     */
    public List<TaiKhoan> getAllTaiKhoan() {
        List<TaiKhoan> list = new ArrayList<>();
        String sql = "SELECT * FROM TaiKhoan ORDER BY ngayTao DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                list.add(extractTaiKhoanFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy tài khoản theo username
     */
    public TaiKhoan getById(String username) {
        String sql = "SELECT * FROM TaiKhoan WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractTaiKhoanFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Thêm tài khoản mới
     */
    public boolean insert(TaiKhoan tk) {
        String sql = "INSERT INTO TaiKhoan (username, password, role, hoTen, sdt, email, diaChi) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, tk.getUsername());
            ps.setString(2, tk.getPassword());
            ps.setString(3, tk.getRole());
            ps.setString(4, tk.getHoTen());
            ps.setString(5, tk.getSdt());
            ps.setString(6, tk.getEmail());
            ps.setString(7, tk.getDiaChi());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Cập nhật tài khoản
     */
    public boolean update(TaiKhoan tk) {
        String sql = "UPDATE TaiKhoan SET password = ?, role = ?, hoTen = ?, sdt = ?, email = ?, diaChi = ? WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, tk.getPassword());
            ps.setString(2, tk.getRole());
            ps.setString(3, tk.getHoTen());
            ps.setString(4, tk.getSdt());
            ps.setString(5, tk.getEmail());
            ps.setString(6, tk.getDiaChi());
            ps.setString(7, tk.getUsername());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa tài khoản
     */
    public boolean delete(String username) {
        String sql = "DELETE FROM TaiKhoan WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Đổi mật khẩu
     */
    public boolean changePassword(String username, String oldPassword, String newPassword) {
        // Kiểm tra mật khẩu cũ
        TaiKhoan tk = authenticate(username, oldPassword);
        if (tk == null) {
            return false;
        }
        
        String sql = "UPDATE TaiKhoan SET password = ? WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, newPassword);
            ps.setString(2, username);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Đếm số lượng tài khoản
     */
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM TaiKhoan";
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
     * Extract TaiKhoan from ResultSet
     */
    private TaiKhoan extractTaiKhoanFromResultSet(ResultSet rs) throws SQLException {
        TaiKhoan tk = new TaiKhoan();
        tk.setUsername(rs.getString("username"));
        tk.setPassword(rs.getString("password"));
        tk.setRole(rs.getString("role"));
        tk.setHoTen(rs.getString("hoTen"));
        tk.setSdt(rs.getString("sdt"));
        tk.setEmail(rs.getString("email"));
        tk.setDiaChi(rs.getString("diaChi"));
        tk.setNgayTao(rs.getTimestamp("ngayTao"));
        return tk;
    }
}



