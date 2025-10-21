package model;

import java.sql.Timestamp;

/**
 * Entity class cho bảng KhachHang
 */
public class KhachHang {
    private int maKH;
    private String hoTen;
    private String sdt;
    private String email;
    private String diaChi;
    private Timestamp ngayDangKy;

    // Constructors
    public KhachHang() {
    }

    public KhachHang(String hoTen, String sdt) {
        this.hoTen = hoTen;
        this.sdt = sdt;
    }

    public KhachHang(String hoTen, String sdt, String email, String diaChi) {
        this.hoTen = hoTen;
        this.sdt = sdt;
        this.email = email;
        this.diaChi = diaChi;
    }

    // Getters and Setters
    public int getMaKH() {
        return maKH;
    }

    public void setMaKH(int maKH) {
        this.maKH = maKH;
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

    public Timestamp getNgayDangKy() {
        return ngayDangKy;
    }

    public void setNgayDangKy(Timestamp ngayDangKy) {
        this.ngayDangKy = ngayDangKy;
    }

    @Override
    public String toString() {
        return "KhachHang{" +
                "maKH=" + maKH +
                ", hoTen='" + hoTen + '\'' +
                ", sdt='" + sdt + '\'' +
                ", email='" + email + '\'' +
                ", diaChi='" + diaChi + '\'' +
                '}';
    }
}



