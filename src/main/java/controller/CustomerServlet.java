package controller;

import model.*;
import util.EmailService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

/**
 * Servlet xử lý các chức năng dành cho khách hàng
 * - Tìm kiếm chuyến xe
 * - Đặt vé online
 * - Tra cứu vé
 * - Hủy vé
 */
@WebServlet(name = "CustomerServlet", urlPatterns = {"/customer"})
public class CustomerServlet extends HttpServlet {

    private ChuyenXeDAO chuyenXeDAO = new ChuyenXeDAO();
    private VeXeDAO veXeDAO = new VeXeDAO();
    private KhachHangDAO khachHangDAO = new KhachHangDAO();

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
            action = "home";
        }

        switch (action) {
            case "home":
                showHome(request, response);
                break;
            case "search":
                searchChuyenXe(request, response);
                break;
            case "booking":
                showBookingForm(request, response);
                break;
            case "book":
                bookTicket(request, response);
                break;
            case "lookup":
                lookupTicket(request, response);
                break;
            case "cancel":
                cancelTicket(request, response);
                break;
            default:
                showHome(request, response);
                break;
        }
    }

    /**
     * Hiển thị trang chủ khách hàng
     */
    private void showHome(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/customer-home.jsp");
    }

    /**
     * Tìm kiếm chuyến xe theo điểm đi, điểm đến, ngày
     */
    private void searchChuyenXe(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String diemDi = request.getParameter("diemDi");
            String diemDen = request.getParameter("diemDen");
            String ngayDiStr = request.getParameter("ngayDi");

            List<ChuyenXe> listChuyenXe;
            
            // Nếu không có tham số hoặc tham số rỗng, hiển thị tất cả chuyến
            if ((diemDi == null || diemDi.trim().isEmpty()) && 
                (diemDen == null || diemDen.trim().isEmpty()) && 
                (ngayDiStr == null || ngayDiStr.trim().isEmpty())) {
                // Hiển thị tất cả chuyến xe còn ghế trống
                listChuyenXe = chuyenXeDAO.searchChuyenXe("", "", null);
            } else {
                // Tìm kiếm theo điều kiện
                Date ngayDi = (ngayDiStr != null && !ngayDiStr.trim().isEmpty()) ? Date.valueOf(ngayDiStr) : null;
                listChuyenXe = chuyenXeDAO.searchChuyenXe(
                    diemDi != null ? diemDi : "", 
                    diemDen != null ? diemDen : "", 
                    ngayDi
                );
            }
            
            request.setAttribute("listChuyenXe", listChuyenXe);
            request.getRequestDispatcher("/customer-search.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi: " + e.getMessage());
            request.setAttribute("messageType", "danger");
            request.getRequestDispatcher("/customer-search.jsp").forward(request, response);
        }
    }

    /**
     * Hiển thị form đặt vé cho chuyến xe đã chọn
     */
    private void showBookingForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String maCXParam = request.getParameter("maCX");
            
            if (maCXParam == null || maCXParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/customer-home.jsp");
                return;
            }

            int maCX = Integer.parseInt(maCXParam);
            ChuyenXe chuyenXe = chuyenXeDAO.getById(maCX);
            
            if (chuyenXe == null) {
                request.setAttribute("message", "Không tìm thấy chuyến xe!");
                request.setAttribute("messageType", "danger");
                request.getRequestDispatcher("/customer-booking.jsp").forward(request, response);
                return;
            }

            // Lấy danh sách ghế đã đặt
            List<Integer> gheDaDat = veXeDAO.getDanhSachGheDaDat(maCX);
            
            request.setAttribute("chuyenXe", chuyenXe);
            request.setAttribute("gheDaDat", gheDaDat);
            request.getRequestDispatcher("/customer-booking.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/customer-home.jsp");
        }
    }

    /**
     * Đặt vé (xử lý submit form)
     */
    private void bookTicket(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thông tin từ form
            int maCX = Integer.parseInt(request.getParameter("maCX"));
            int soGhe = Integer.parseInt(request.getParameter("soGhe"));
            String hoTen = request.getParameter("hoTen");
            String sdt = request.getParameter("sdt");
            String email = request.getParameter("email");
            String diaChi = request.getParameter("diaChi");
            String ghiChu = request.getParameter("ghiChu");
            String phuongThucThanhToan = request.getParameter("phuongThucThanhToan");

            // Kiểm tra ghế đã được đặt chưa
            if (veXeDAO.isGheDaDat(maCX, soGhe)) {
                request.getSession().setAttribute("message", "Ghế số " + soGhe + " đã được đặt! Vui lòng chọn ghế khác.");
                request.getSession().setAttribute("messageType", "warning");
                response.sendRedirect(request.getContextPath() + "/customer?action=booking&maCX=" + maCX);
                return;
            }

            // Tìm hoặc tạo khách hàng
            KhachHang kh = khachHangDAO.getBySdt(sdt);
            int maKH;
            
            if (kh == null) {
                // Tạo khách hàng mới
                kh = new KhachHang(hoTen, sdt, email, diaChi);
                maKH = khachHangDAO.insert(kh);
                
                if (maKH <= 0) {
                    request.getSession().setAttribute("message", "Không thể tạo thông tin khách hàng!");
                    request.getSession().setAttribute("messageType", "danger");
                    response.sendRedirect(request.getContextPath() + "/customer?action=booking&maCX=" + maCX);
                    return;
                }
            } else {
                maKH = kh.getMaKH();
                // Cập nhật thông tin khách hàng nếu có thay đổi
                if (email != null && !email.trim().isEmpty()) {
                    kh.setEmail(email);
                }
                if (hoTen != null && !hoTen.trim().isEmpty()) {
                    kh.setHoTen(hoTen);
                }
                if (diaChi != null && !diaChi.trim().isEmpty()) {
                    kh.setDiaChi(diaChi);
                }
                khachHangDAO.update(kh);
            }

            // Tạo vé mới
            VeXe ve = new VeXe(maCX, maKH, soGhe, ghiChu);
            ve.setPhuongThucThanhToan(phuongThucThanhToan);
            
            if (veXeDAO.insert(ve)) {
                // Lấy thông tin vé chi tiết để gửi email
                VeXe veDetail = veXeDAO.getById(ve.getMaVe());
                
                // Gửi email xác nhận
                if (veDetail != null && veDetail.getKhachHang() != null 
                    && veDetail.getKhachHang().getEmail() != null 
                    && !veDetail.getKhachHang().getEmail().trim().isEmpty()) {
                    try {
                        boolean emailSent = EmailService.sendTicketConfirmation(veDetail);
                        if (emailSent) {
                            System.out.println("✅ Email xác nhận đã được gửi đến: " + veDetail.getKhachHang().getEmail());
                        }
                    } catch (Exception emailEx) {
                        System.err.println("⚠️ Không gửi được email: " + emailEx.getMessage());
                    }
                }
                
                // Chuyển đến trang tra cứu vé với thông báo thành công
                response.sendRedirect(request.getContextPath() + 
                    "/customer?action=lookup&maVe=" + ve.getMaVe() + 
                    "&success=true");
            } else {
                request.getSession().setAttribute("message", "Đặt vé thất bại! Vui lòng thử lại.");
                request.getSession().setAttribute("messageType", "danger");
                response.sendRedirect(request.getContextPath() + "/customer?action=booking&maCX=" + maCX);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
            response.sendRedirect(request.getContextPath() + "/customer-home.jsp");
        }
    }

    /**
     * Tra cứu vé theo mã vé hoặc số điện thoại
     */
    private void lookupTicket(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String maVeStr = request.getParameter("maVe");
            String sdt = request.getParameter("sdt");
            boolean success = "true".equals(request.getParameter("success"));
            
            // Lấy message từ session (nếu có)
            String message = (String) request.getSession().getAttribute("message");
            String messageType = (String) request.getSession().getAttribute("messageType");
            if (message != null) {
                request.setAttribute("message", message);
                request.setAttribute("messageType", messageType);
                request.getSession().removeAttribute("message");
                request.getSession().removeAttribute("messageType");
            }

            VeXe ve = null;

            // Tìm theo mã vé
            if (maVeStr != null && !maVeStr.trim().isEmpty()) {
                int maVe = Integer.parseInt(maVeStr);
                ve = veXeDAO.getById(maVe);
            }
            // Tìm theo số điện thoại (lấy vé gần nhất)
            else if (sdt != null && !sdt.trim().isEmpty()) {
                List<VeXe> listVe = veXeDAO.getVeBySdt(sdt);
                if (listVe != null && !listVe.isEmpty()) {
                    ve = listVe.get(0); // Lấy vé gần nhất
                }
            }

            if (ve != null) {
                request.setAttribute("ve", ve);
                if (success && message == null) {
                    String successMsg = "🎉 Đặt vé thành công!";
                    if (ve.getKhachHang() != null && ve.getKhachHang().getEmail() != null && !ve.getKhachHang().getEmail().trim().isEmpty()) {
                        successMsg += "<br><small>📧 Email xác nhận đã được gửi đến <strong>" + ve.getKhachHang().getEmail() + "</strong></small>";
                    }
                    request.setAttribute("message", successMsg);
                    request.setAttribute("messageType", "success");
                }
            } else if (maVeStr != null || sdt != null) {
                if (message == null) {
                    request.setAttribute("message", "Không tìm thấy vé với thông tin đã nhập!");
                    request.setAttribute("messageType", "warning");
                }
            }

            request.getRequestDispatcher("/customer-lookup.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi: " + e.getMessage());
            request.setAttribute("messageType", "danger");
            request.getRequestDispatcher("/customer-lookup.jsp").forward(request, response);
        }
    }

    /**
     * Hủy vé
     */
    private void cancelTicket(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int maVe = Integer.parseInt(request.getParameter("maVe"));
            
            // Lấy thông tin vé trước khi hủy
            VeXe ve = veXeDAO.getById(maVe);
            
            if (ve == null) {
                request.setAttribute("message", "Không tìm thấy vé!");
                request.setAttribute("messageType", "danger");
                request.getRequestDispatcher("/customer-lookup.jsp").forward(request, response);
                return;
            }

            // Kiểm tra trạng thái vé
            if (!"Đã đặt".equals(ve.getTrangThai())) {
                request.setAttribute("message", "Vé này không thể hủy! Trạng thái: " + ve.getTrangThai());
                request.setAttribute("messageType", "warning");
                request.setAttribute("ve", ve);
                request.getRequestDispatcher("/customer-lookup.jsp").forward(request, response);
                return;
            }

            // Kiểm tra thời gian hủy (trước 2 giờ khởi hành)
            long currentTime = System.currentTimeMillis();
            long departureTime = ve.getChuyenXe().getNgayKhoiHanh().getTime() + 
                                ve.getChuyenXe().getGioKhoiHanh().getTime();
            long timeDiff = departureTime - currentTime;
            long hoursDiff = timeDiff / (1000 * 60 * 60);

            if (hoursDiff < 2) {
                request.setAttribute("message", "Không thể hủy vé! Vé chỉ có thể hủy trước giờ khởi hành 2 giờ.");
                request.setAttribute("messageType", "warning");
                request.setAttribute("ve", ve);
                request.getRequestDispatcher("/customer-lookup.jsp").forward(request, response);
                return;
            }

            // Hủy vé
            if (veXeDAO.cancelVe(maVe)) {
                request.setAttribute("message", "Hủy vé thành công! Vui lòng liên hệ để được hoàn tiền.");
                request.setAttribute("messageType", "success");
                
                // Lấy lại thông tin vé sau khi hủy
                ve = veXeDAO.getById(maVe);
                request.setAttribute("ve", ve);
            } else {
                request.setAttribute("message", "Hủy vé thất bại! Vui lòng thử lại.");
                request.setAttribute("messageType", "danger");
                request.setAttribute("ve", ve);
            }

            request.getRequestDispatcher("/customer-lookup.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi: " + e.getMessage());
            request.setAttribute("messageType", "danger");
            request.getRequestDispatcher("/customer-lookup.jsp").forward(request, response);
        }
    }
}


