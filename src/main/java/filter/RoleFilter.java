package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter kiểm tra phân quyền
 * Chỉ Admin mới được truy cập quản lý tài khoản
 */
@WebFilter(filterName = "RoleFilter", urlPatterns = {"/taikhoan"})
public class RoleFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        if (session != null) {
            String role = (String) session.getAttribute("role");
            
            if ("Admin".equals(role)) {
                // Admin được phép truy cập
                chain.doFilter(request, response);
            } else {
                // Không có quyền, chuyển về dashboard với thông báo
                session.setAttribute("message", "Bạn không có quyền truy cập chức năng này!");
                session.setAttribute("messageType", "warning");
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/trang-chu");
            }
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
    }
}



