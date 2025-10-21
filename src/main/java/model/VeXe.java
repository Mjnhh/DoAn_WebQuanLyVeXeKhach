package model;

import java.sql.Timestamp;

/**
 * Entity class cho bảng VeXe
 */
public class VeXe {
    private int maVe;
    private int maCX;
    private int maKH;
    private int soGhe;
    private Timestamp ngayDat;
    private String trangThai;
    private String ghiChu;

    // Thông tin chi tiết từ JOIN
    private ChuyenXe chuyenXe;
    private KhachHang khachHang;

    // Constructors
    public VeXe() {
    }

    public VeXe(int maCX, int maKH, int soGhe) {
        this.maCX = maCX;
        this.maKH = maKH;
        this.soGhe = soGhe;
        this.trangThai = "Đã đặt";
    }

    public VeXe(int maCX, int maKH, int soGhe, String ghiChu) {
        this.maCX = maCX;
        this.maKH = maKH;
        this.soGhe = soGhe;
        this.ghiChu = ghiChu;
        this.trangThai = "Đã đặt";
    }

    // Getters and Setters
    public int getMaVe() {
        return maVe;
    }

    public void setMaVe(int maVe) {
        this.maVe = maVe;
    }

    public int getMaCX() {
        return maCX;
    }

    public void setMaCX(int maCX) {
        this.maCX = maCX;
    }

    public int getMaKH() {
        return maKH;
    }

    public void setMaKH(int maKH) {
        this.maKH = maKH;
    }

    public int getSoGhe() {
        return soGhe;
    }

    public void setSoGhe(int soGhe) {
        this.soGhe = soGhe;
    }

    public Timestamp getNgayDat() {
        return ngayDat;
    }

    public void setNgayDat(Timestamp ngayDat) {
        this.ngayDat = ngayDat;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    public ChuyenXe getChuyenXe() {
        return chuyenXe;
    }

    public void setChuyenXe(ChuyenXe chuyenXe) {
        this.chuyenXe = chuyenXe;
    }

    public KhachHang getKhachHang() {
        return khachHang;
    }

    public void setKhachHang(KhachHang khachHang) {
        this.khachHang = khachHang;
    }

    @Override
    public String toString() {
        return "VeXe{" +
                "maVe=" + maVe +
                ", maCX=" + maCX +
                ", maKH=" + maKH +
                ", soGhe=" + soGhe +
                ", ngayDat=" + ngayDat +
                ", trangThai='" + trangThai + '\'' +
                ", ghiChu='" + ghiChu + '\'' +
                '}';
    }
}



