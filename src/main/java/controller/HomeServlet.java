package controller;

import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet xử lý trang chủ và dashboard
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/trang-chu", "/dashboard"})
public class HomeServlet extends HttpServlet {

    private ChuyenXeDAO chuyenXeDAO = new ChuyenXeDAO();
    private KhachHangDAO khachHangDAO = new KhachHangDAO();
    private VeXeDAO veXeDAO = new VeXeDAO();
    private TaiKhoanDAO taiKhoanDAO = new TaiKhoanDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy thống kê
        int totalChuyenXe = chuyenXeDAO.getTotalCount();
        int activeChuyenXe = chuyenXeDAO.getActiveCount();
        int totalKhachHang = khachHangDAO.getTotalCount();
        int totalVe = veXeDAO.getTotalCount();
        int veDaDat = veXeDAO.getVeDaDatCount();
        int totalTaiKhoan = taiKhoanDAO.getTotalCount();

        // Gửi dữ liệu sang JSP
        request.setAttribute("totalChuyenXe", totalChuyenXe);
        request.setAttribute("activeChuyenXe", activeChuyenXe);
        request.setAttribute("totalKhachHang", totalKhachHang);
        request.setAttribute("totalVe", totalVe);
        request.setAttribute("veDaDat", veDaDat);
        request.setAttribute("totalTaiKhoan", totalTaiKhoan);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}



