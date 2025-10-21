package model;

import java.sql.Date;
import java.sql.Time;
import java.math.BigDecimal;

/**
 * Entity class cho bảng ChuyenXe
 */
public class ChuyenXe {
    private int maCX;
    private String soXe;
    private String diemDi;
    private String diemDen;
    private Date ngayKhoiHanh;
    private Time gioKhoiHanh;
    private BigDecimal giaVe;
    private int soGhe;
    private int soGheTrong;
    private String trangThai;

    // Constructors
    public ChuyenXe() {
    }

    public ChuyenXe(String soXe, String diemDi, String diemDen, Date ngayKhoiHanh, 
                    Time gioKhoiHanh, BigDecimal giaVe, int soGhe) {
        this.soXe = soXe;
        this.diemDi = diemDi;
        this.diemDen = diemDen;
        this.ngayKhoiHanh = ngayKhoiHanh;
        this.gioKhoiHanh = gioKhoiHanh;
        this.giaVe = giaVe;
        this.soGhe = soGhe;
        this.soGheTrong = soGhe; // Ban đầu tất cả ghế đều trống
        this.trangThai = "Hoạt động";
    }

    // Getters and Setters
    public int getMaCX() {
        return maCX;
    }

    public void setMaCX(int maCX) {
        this.maCX = maCX;
    }

    public String getSoXe() {
        return soXe;
    }

    public void setSoXe(String soXe) {
        this.soXe = soXe;
    }

    public String getDiemDi() {
        return diemDi;
    }

    public void setDiemDi(String diemDi) {
        this.diemDi = diemDi;
    }

    public String getDiemDen() {
        return diemDen;
    }

    public void setDiemDen(String diemDen) {
        this.diemDen = diemDen;
    }

    public Date getNgayKhoiHanh() {
        return ngayKhoiHanh;
    }

    public void setNgayKhoiHanh(Date ngayKhoiHanh) {
        this.ngayKhoiHanh = ngayKhoiHanh;
    }

    public Time getGioKhoiHanh() {
        return gioKhoiHanh;
    }

    public void setGioKhoiHanh(Time gioKhoiHanh) {
        this.gioKhoiHanh = gioKhoiHanh;
    }

    public BigDecimal getGiaVe() {
        return giaVe;
    }

    public void setGiaVe(BigDecimal giaVe) {
        this.giaVe = giaVe;
    }

    public int getSoGhe() {
        return soGhe;
    }

    public void setSoGhe(int soGhe) {
        this.soGhe = soGhe;
    }

    public int getSoGheTrong() {
        return soGheTrong;
    }

    public void setSoGheTrong(int soGheTrong) {
        this.soGheTrong = soGheTrong;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    // Computed properties
    public int getSoGheDaDat() {
        return soGhe - soGheTrong;
    }

    public double getTyLeLapDay() {
        if (soGhe == 0) return 0;
        return (soGhe - soGheTrong) * 100.0 / soGhe;
    }

    @Override
    public String toString() {
        return "ChuyenXe{" +
                "maCX=" + maCX +
                ", soXe='" + soXe + '\'' +
                ", diemDi='" + diemDi + '\'' +
                ", diemDen='" + diemDen + '\'' +
                ", ngayKhoiHanh=" + ngayKhoiHanh +
                ", gioKhoiHanh=" + gioKhoiHanh +
                ", giaVe=" + giaVe +
                ", soGhe=" + soGhe +
                ", soGheTrong=" + soGheTrong +
                ", trangThai='" + trangThai + '\'' +
                '}';
    }
}



