package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter kiểm tra đăng nhập
 * Bảo vệ các trang yêu cầu đăng nhập
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/trang-chu", "/dashboard", "/chuyenxe", "/vexe", "/khachhang", "/taikhoan", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Kiểm tra đã đăng nhập chưa
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (isLoggedIn) {
            // Đã đăng nhập, cho phép tiếp tục
            chain.doFilter(request, response);
        } else {
            // Chưa đăng nhập, chuyển về trang login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
    }
}



