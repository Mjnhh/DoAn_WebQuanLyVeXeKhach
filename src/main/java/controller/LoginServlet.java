package controller;

import model.TaiKhoan;
import model.TaiKhoanDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet xử lý đăng nhập và đăng xuất
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login", "/logout"})
public class LoginServlet extends HttpServlet {

    private TaiKhoanDAO taiKhoanDAO = new TaiKhoanDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        
        if ("/logout".equals(path)) {
            handleLogout(request, response);
        } else {
            showLoginPage(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleLogin(request, response);
    }

    /**
     * Hiển thị trang đăng nhập
     */
    private void showLoginPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    /**
     * Xử lý đăng nhập
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        TaiKhoan taiKhoan = taiKhoanDAO.authenticate(username, password);

        if (taiKhoan != null) {
            // Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("user", taiKhoan);
            session.setAttribute("username", taiKhoan.getUsername());
            session.setAttribute("hoTen", taiKhoan.getHoTen());
            session.setAttribute("role", taiKhoan.getRole());
            session.setMaxInactiveInterval(30 * 60); // 30 phút

            response.sendRedirect(request.getContextPath() + "/trang-chu");
        } else {
            // Đăng nhập thất bại
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    /**
     * Xử lý đăng xuất
     */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/login");
    }
}



