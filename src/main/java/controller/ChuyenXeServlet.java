package controller;

import model.ChuyenXe;
import model.ChuyenXeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

/**
 * Servlet quản lý chuyến xe
 */
@WebServlet(name = "ChuyenXeServlet", urlPatterns = {"/chuyenxe"})
public class ChuyenXeServlet extends HttpServlet {

    private ChuyenXeDAO chuyenXeDAO = new ChuyenXeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listChuyenXe(request, response);
                break;
            case "add":
                addChuyenXe(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "update":
                updateChuyenXe(request, response);
                break;
            case "delete":
                deleteChuyenXe(request, response);
                break;
            case "search":
                searchChuyenXe(request, response);
                break;
            default:
                listChuyenXe(request, response);
                break;
        }
    }

    /**
     * Hiển thị danh sách chuyến xe
     */
    private void listChuyenXe(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<ChuyenXe> list = chuyenXeDAO.getAllChuyenXe();
        request.setAttribute("listChuyenXe", list);
        request.getRequestDispatcher("/admin/list-chuyenxe.jsp").forward(request, response);
    }

    /**
     * Thêm chuyến xe mới
     */
    private void addChuyenXe(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String soXe = request.getParameter("soXe");
            String diemDi = request.getParameter("diemDi");
            String diemDen = request.getParameter("diemDen");
            Date ngayKhoiHanh = Date.valueOf(request.getParameter("ngayKhoiHanh"));
            Time gioKhoiHanh = Time.valueOf(request.getParameter("gioKhoiHanh") + ":00");
            BigDecimal giaVe = new BigDecimal(request.getParameter("giaVe"));
            int soGhe = Integer.parseInt(request.getParameter("soGhe"));

            ChuyenXe cx = new ChuyenXe(soXe, diemDi, diemDen, ngayKhoiHanh, gioKhoiHanh, giaVe, soGhe);

            if (chuyenXeDAO.insert(cx)) {
                request.getSession().setAttribute("message", "Thêm chuyến xe thành công!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Thêm chuyến xe thất bại!");
                request.getSession().setAttribute("messageType", "danger");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
        }

        response.sendRedirect(request.getContextPath() + "/chuyenxe");
    }

    /**
     * Hiển thị form sửa chuyến xe
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int maCX = Integer.parseInt(request.getParameter("maCX"));
        ChuyenXe cx = chuyenXeDAO.getById(maCX);
        
        request.setAttribute("chuyenXe", cx);
        request.getRequestDispatcher("/admin/edit-chuyenxe.jsp").forward(request, response);
    }

    /**
     * Cập nhật chuyến xe
     */
    private void updateChuyenXe(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int maCX = Integer.parseInt(request.getParameter("maCX"));
            String soXe = request.getParameter("soXe");
            String diemDi = request.getParameter("diemDi");
            String diemDen = request.getParameter("diemDen");
            Date ngayKhoiHanh = Date.valueOf(request.getParameter("ngayKhoiHanh"));
            Time gioKhoiHanh = Time.valueOf(request.getParameter("gioKhoiHanh") + ":00");
            BigDecimal giaVe = new BigDecimal(request.getParameter("giaVe"));
            int soGhe = Integer.parseInt(request.getParameter("soGhe"));
            int soGheTrong = Integer.parseInt(request.getParameter("soGheTrong"));
            String trangThai = request.getParameter("trangThai");

            ChuyenXe cx = new ChuyenXe();
            cx.setMaCX(maCX);
            cx.setSoXe(soXe);
            cx.setDiemDi(diemDi);
            cx.setDiemDen(diemDen);
            cx.setNgayKhoiHanh(ngayKhoiHanh);
            cx.setGioKhoiHanh(gioKhoiHanh);
            cx.setGiaVe(giaVe);
            cx.setSoGhe(soGhe);
            cx.setSoGheTrong(soGheTrong);
            cx.setTrangThai(trangThai);

            if (chuyenXeDAO.update(cx)) {
                request.getSession().setAttribute("message", "Cập nhật chuyến xe thành công!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Cập nhật chuyến xe thất bại!");
                request.getSession().setAttribute("messageType", "danger");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
        }

        response.sendRedirect(request.getContextPath() + "/chuyenxe");
    }

    /**
     * Xóa chuyến xe
     */
    private void deleteChuyenXe(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int maCX = Integer.parseInt(request.getParameter("maCX"));

            if (chuyenXeDAO.delete(maCX)) {
                request.getSession().setAttribute("message", "Xóa chuyến xe thành công!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Xóa chuyến xe thất bại!");
                request.getSession().setAttribute("messageType", "danger");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
        }

        response.sendRedirect(request.getContextPath() + "/chuyenxe");
    }

    /**
     * Tìm kiếm chuyến xe
     */
    private void searchChuyenXe(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String diemDi = request.getParameter("diemDi");
        String diemDen = request.getParameter("diemDen");
        String ngayKhoiHanhStr = request.getParameter("ngayKhoiHanh");
        
        Date ngayKhoiHanh = null;
        if (ngayKhoiHanhStr != null && !ngayKhoiHanhStr.trim().isEmpty()) {
            ngayKhoiHanh = Date.valueOf(ngayKhoiHanhStr);
        }

        List<ChuyenXe> list = chuyenXeDAO.searchChuyenXe(diemDi, diemDen, ngayKhoiHanh);
        
        request.setAttribute("listChuyenXe", list);
        request.setAttribute("searchDiemDi", diemDi);
        request.setAttribute("searchDiemDen", diemDen);
        request.setAttribute("searchNgayKhoiHanh", ngayKhoiHanhStr);
        
        request.getRequestDispatcher("/admin/list-chuyenxe.jsp").forward(request, response);
    }
}



