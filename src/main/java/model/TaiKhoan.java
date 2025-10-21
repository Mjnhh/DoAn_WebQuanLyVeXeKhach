package model;

import java.sql.Timestamp;

/**
 * Entity class cho bảng TaiKhoan
 */
public class TaiKhoan {
    private String username;
    private String password;
    private String role;
    private String hoTen;
    private String sdt;
    private String email;
    private String diaChi;
    private Timestamp ngayTao;

    // Constructors
    public TaiKhoan() {
    }

    public TaiKhoan(String username, String password, String role, String hoTen) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.hoTen = hoTen;
    }

    public TaiKhoan(String username, String password, String role, String hoTen, 
                    String sdt, String email, String diaChi) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.hoTen = hoTen;
        this.sdt = sdt;
        this.email = email;
        this.diaChi = diaChi;
    }

    // Getters and Setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getSdt() {
        return sdt;
    }

    public void setSdt(String sdt) {
        this.sdt = sdt;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public Timestamp getNgayTao() {
        return ngayTao;
    }

    public void setNgayTao(Timestamp ngayTao) {
        this.ngayTao = ngayTao;
    }

    @Override
    public String toString() {
        return "TaiKhoan{" +
                "username='" + username + '\'' +
                ", role='" + role + '\'' +
                ", hoTen='" + hoTen + '\'' +
                ", sdt='" + sdt + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}



