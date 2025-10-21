package controller;

import model.TaiKhoan;
import model.TaiKhoanDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet quản lý tài khoản (chỉ Admin mới được truy cập)
 */
@WebServlet(name = "TaiKhoanServlet", urlPatterns = {"/taikhoan"})
public class TaiKhoanServlet extends HttpServlet {

    private TaiKhoanDAO taiKhoanDAO = new TaiKhoanDAO();

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
                listTaiKhoan(request, response);
                break;
            case "add":
                addTaiKhoan(request, response);
                break;
            case "update":
                updateTaiKhoan(request, response);
                break;
            case "delete":
                deleteTaiKhoan(request, response);
                break;
            default:
                listTaiKhoan(request, response);
                break;
        }
    }

    /**
     * Hiển thị danh sách tài khoản
     */
    private void listTaiKhoan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<TaiKhoan> list = taiKhoanDAO.getAllTaiKhoan();
        request.setAttribute("listTaiKhoan", list);
        request.getRequestDispatcher("/admin/list-taikhoan.jsp").forward(request, response);
    }

    /**
     * Thêm tài khoản mới
     */
    private void addTaiKhoan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");
            String hoTen = request.getParameter("hoTen");
            String sdt = request.getParameter("sdt");
            String email = request.getParameter("email");
            String diaChi = request.getParameter("diaChi");

            TaiKhoan tk = new TaiKhoan(username, password, role, hoTen, sdt, email, diaChi);

            if (taiKhoanDAO.insert(tk)) {
                request.getSession().setAttribute("message", "Thêm tài khoản thành công!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Thêm tài khoản thất bại!");
                request.getSession().setAttribute("messageType", "danger");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
        }

        response.sendRedirect(request.getContextPath() + "/taikhoan");
    }

    /**
     * Cập nhật tài khoản
     */
    private void updateTaiKhoan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");
            String hoTen = request.getParameter("hoTen");
            String sdt = request.getParameter("sdt");
            String email = request.getParameter("email");
            String diaChi = request.getParameter("diaChi");

            TaiKhoan tk = new TaiKhoan(username, password, role, hoTen, sdt, email, diaChi);

            if (taiKhoanDAO.update(tk)) {
                request.getSession().setAttribute("message", "Cập nhật tài khoản thành công!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Cập nhật tài khoản thất bại!");
                request.getSession().setAttribute("messageType", "danger");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
        }

        response.sendRedirect(request.getContextPath() + "/taikhoan");
    }

    /**
     * Xóa tài khoản
     */
    private void deleteTaiKhoan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");

            if (taiKhoanDAO.delete(username)) {
                request.getSession().setAttribute("message", "Xóa tài khoản thành công!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Xóa tài khoản thất bại!");
                request.getSession().setAttribute("messageType", "danger");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
        }

        response.sendRedirect(request.getContextPath() + "/taikhoan");
    }
}



