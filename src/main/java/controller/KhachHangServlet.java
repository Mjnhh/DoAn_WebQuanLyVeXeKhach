package controller;

import model.KhachHang;
import model.KhachHangDAO;
import model.VeXe;
import model.VeXeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet quản lý khách hàng
 */
@WebServlet(name = "KhachHangServlet", urlPatterns = {"/khachhang"})
public class KhachHangServlet extends HttpServlet {

    private KhachHangDAO khachHangDAO = new KhachHangDAO();
    private VeXeDAO veXeDAO = new VeXeDAO();

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
                listKhachHang(request, response);
                break;
            case "add":
                addKhachHang(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "update":
                updateKhachHang(request, response);
                break;
            case "delete":
                deleteKhachHang(request, response);
                break;
            case "search":
                searchKhachHang(request, response);
                break;
            case "history":
                viewHistory(request, response);
                break;
            default:
                listKhachHang(request, response);
                break;
        }
    }

    /**
     * Hiển thị danh sách khách hàng
     */
    private void listKhachHang(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<KhachHang> list = khachHangDAO.getAllKhachHang();
        request.setAttribute("listKhachHang", list);
        request.getRequestDispatcher("/admin/list-khachhang.jsp").forward(request, response);
    }

    /**
     * Thêm khách hàng mới
     */
    private void addKhachHang(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String hoTen = request.getParameter("hoTen");
            String sdt = request.getParameter("sdt");
            String email = request.getParameter("email");
            String diaChi = request.getParameter("diaChi");

            KhachHang kh = new KhachHang(hoTen, sdt, email, diaChi);

            int result = khachHangDAO.insert(kh);
            if (result > 0) {
                request.getSession().setAttribute("message", "Thêm khách hàng thành công!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Thêm khách hàng thất bại!");
                request.getSession().setAttribute("messageType", "danger");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
        }

        response.sendRedirect(request.getContextPath() + "/khachhang");
    }

    /**
     * Hiển thị form sửa khách hàng
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int maKH = Integer.parseInt(request.getParameter("maKH"));
        KhachHang kh = khachHangDAO.getById(maKH);
        
        request.setAttribute("khachHang", kh);
        request.getRequestDispatcher("/admin/edit-khachhang.jsp").forward(request, response);
    }

    /**
     * Cập nhật khách hàng
     */
    private void updateKhachHang(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int maKH = Integer.parseInt(request.getParameter("maKH"));
            String hoTen = request.getParameter("hoTen");
            String sdt = request.getParameter("sdt");
            String email = request.getParameter("email");
            String diaChi = request.getParameter("diaChi");

            KhachHang kh = new KhachHang(hoTen, sdt, email, diaChi);
            kh.setMaKH(maKH);

            if (khachHangDAO.update(kh)) {
                request.getSession().setAttribute("message", "Cập nhật khách hàng thành công!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Cập nhật khách hàng thất bại!");
                request.getSession().setAttribute("messageType", "danger");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
        }

        response.sendRedirect(request.getContextPath() + "/khachhang");
    }

    /**
     * Xóa khách hàng
     */
    private void deleteKhachHang(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int maKH = Integer.parseInt(request.getParameter("maKH"));

            if (khachHangDAO.delete(maKH)) {
                request.getSession().setAttribute("message", "Xóa khách hàng thành công!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Xóa khách hàng thất bại!");
                request.getSession().setAttribute("messageType", "danger");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
        }

        response.sendRedirect(request.getContextPath() + "/khachhang");
    }

    /**
     * Tìm kiếm khách hàng
     */
    private void searchKhachHang(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        
        List<KhachHang> list = khachHangDAO.searchKhachHang(keyword);
        
        request.setAttribute("listKhachHang", list);
        request.setAttribute("searchKeyword", keyword);
        
        request.getRequestDispatcher("/admin/list-khachhang.jsp").forward(request, response);
    }

    /**
     * Xem lịch sử đặt vé của khách hàng
     */
    private void viewHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int maKH = Integer.parseInt(request.getParameter("maKH"));
        
        KhachHang kh = khachHangDAO.getById(maKH);
        List<VeXe> listVe = veXeDAO.getByKhachHang(maKH);
        
        request.setAttribute("khachHang", kh);
        request.setAttribute("listVe", listVe);
        
        request.getRequestDispatcher("/admin/history-khachhang.jsp").forward(request, response);
    }
}



