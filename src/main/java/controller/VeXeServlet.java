package controller;

import model.*;
import util.EmailService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet quản lý đặt vé và tra cứu vé
 */
@WebServlet(name = "VeXeServlet", urlPatterns = {"/vexe"})
public class VeXeServlet extends HttpServlet {

    private VeXeDAO veXeDAO = new VeXeDAO();
    private ChuyenXeDAO chuyenXeDAO = new ChuyenXeDAO();
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
            action = "list";
        }

        switch (action) {
            case "list":
                listVeXe(request, response);
                break;
            case "form":
                showBookingForm(request, response);
                break;
            case "book":
                bookTicket(request, response);
                break;
            case "cancel":
                cancelTicket(request, response);
                break;
            case "search":
                searchTicket(request, response);
                break;
            case "check-seat":
                checkSeat(request, response);
                break;
            default:
                listVeXe(request, response);
                break;
        }
    }

    /**
     * Hiển thị danh sách vé đã đặt
     */
    private void listVeXe(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<VeXe> list = veXeDAO.getAllVeXe();
        request.setAttribute("listVeXe", list);
        request.getRequestDispatcher("/admin/list-vexe.jsp").forward(request, response);
    }

    /**
     * Hiển thị form đặt vé
     */
    private void showBookingForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String maCXParam = request.getParameter("maCX");
        
        // Lấy danh sách chuyến xe
        List<ChuyenXe> listChuyenXe = chuyenXeDAO.getAllChuyenXe();
        request.setAttribute("listChuyenXe", listChuyenXe);
        
        // Lấy danh sách khách hàng
        List<KhachHang> listKhachHang = khachHangDAO.getAllKhachHang();
        request.setAttribute("listKhachHang", listKhachHang);
        
        // Nếu có mã chuyến xe được chọn
        if (maCXParam != null && !maCXParam.trim().isEmpty()) {
            int maCX = Integer.parseInt(maCXParam);
            ChuyenXe chuyenXe = chuyenXeDAO.getById(maCX);
            List<Integer> gheDaDat = veXeDAO.getDanhSachGheDaDat(maCX);
            
            request.setAttribute("selectedChuyenXe", chuyenXe);
            request.setAttribute("gheDaDat", gheDaDat);
        }
        
        request.getRequestDispatcher("/admin/form-vexe.jsp").forward(request, response);
    }

    /**
     * Đặt vé
     */
    private void bookTicket(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int maCX = Integer.parseInt(request.getParameter("maCX"));
            String sdtKH = request.getParameter("sdt");
            int soGhe = Integer.parseInt(request.getParameter("soGhe"));
            String ghiChu = request.getParameter("ghiChu");

            // Tìm hoặc tạo khách hàng
            KhachHang kh = khachHangDAO.getBySdt(sdtKH);
            int maKH;
            
            if (kh == null) {
                // Tạo khách hàng mới
                String hoTen = request.getParameter("hoTen");
                String email = request.getParameter("email");
                String diaChi = request.getParameter("diaChi");
                
                kh = new KhachHang(hoTen, sdtKH, email, diaChi);
                maKH = khachHangDAO.insert(kh);
                
                if (maKH <= 0) {
                    request.getSession().setAttribute("message", "Không thể tạo thông tin khách hàng!");
                    request.getSession().setAttribute("messageType", "danger");
                    response.sendRedirect(request.getContextPath() + "/vexe?action=form&maCX=" + maCX);
                    return;
                }
            } else {
                maKH = kh.getMaKH();
            }

            // Kiểm tra ghế đã được đặt chưa
            if (veXeDAO.isGheDaDat(maCX, soGhe)) {
                request.getSession().setAttribute("message", "Ghế số " + soGhe + " đã được đặt!");
                request.getSession().setAttribute("messageType", "warning");
                response.sendRedirect(request.getContextPath() + "/vexe?action=form&maCX=" + maCX);
                return;
            }

            // Đặt vé
            VeXe ve = new VeXe(maCX, maKH, soGhe, ghiChu);
            
            if (veXeDAO.insert(ve)) {
                // Lấy thông tin vé vừa đặt để gửi email
                System.out.println(">>> Đã đặt vé thành công, đang lấy thông tin để gửi email...");
                VeXe veDetail = veXeDAO.getById(ve.getMaVe());
                
                System.out.println(">>> veDetail: " + (veDetail != null ? "OK" : "NULL"));
                if (veDetail != null) {
                    System.out.println(">>> KhachHang: " + (veDetail.getKhachHang() != null ? "OK" : "NULL"));
                    if (veDetail.getKhachHang() != null) {
                        System.out.println(">>> Email khách hàng: " + veDetail.getKhachHang().getEmail());
                    }
                }
                
                // Gửi email xác nhận (chạy bất đồng bộ, không ảnh hưởng đến đặt vé)
                if (veDetail != null && veDetail.getKhachHang() != null) {
                    try {
                        System.out.println(">>> Bắt đầu gửi email...");
                        boolean emailSent = EmailService.sendTicketConfirmation(veDetail);
                        if (emailSent) {
                            request.getSession().setAttribute("message", "Đặt vé thành công! Ghế số " + soGhe + ". Email xác nhận đã được gửi đến " + veDetail.getKhachHang().getEmail());
                        } else {
                            request.getSession().setAttribute("message", "Đặt vé thành công! Ghế số " + soGhe + ". (Không gửi được email xác nhận)");
                        }
                    } catch (Exception emailEx) {
                        // Lỗi gửi email không làm ảnh hưởng đến đặt vé
                        System.err.println("Lỗi gửi email: " + emailEx.getMessage());
                        emailEx.printStackTrace();
                        request.getSession().setAttribute("message", "Đặt vé thành công! Ghế số " + soGhe + ". (Không gửi được email xác nhận)");
                    }
                } else {
                    System.out.println(">>> Không gửi email vì veDetail hoặc KhachHang là null");
                    request.getSession().setAttribute("message", "Đặt vé thành công! Ghế số " + soGhe);
                }
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Đặt vé thất bại! Vui lòng thử lại.");
                request.getSession().setAttribute("messageType", "danger");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
        }

        response.sendRedirect(request.getContextPath() + "/vexe");
    }

    /**
     * Hủy vé
     */
    private void cancelTicket(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int maVe = Integer.parseInt(request.getParameter("maVe"));

            if (veXeDAO.cancelVe(maVe)) {
                request.getSession().setAttribute("message", "Hủy vé thành công!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Hủy vé thất bại!");
                request.getSession().setAttribute("messageType", "danger");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi: " + e.getMessage());
            request.getSession().setAttribute("messageType", "danger");
        }

        response.sendRedirect(request.getContextPath() + "/vexe");
    }

    /**
     * Tìm kiếm vé
     */
    private void searchTicket(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        
        List<VeXe> list = veXeDAO.searchVe(keyword);
        
        request.setAttribute("listVeXe", list);
        request.setAttribute("searchKeyword", keyword);
        
        request.getRequestDispatcher("/admin/list-vexe.jsp").forward(request, response);
    }

    /**
     * Kiểm tra tình trạng ghế (Ajax)
     */
    private void checkSeat(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int maCX = Integer.parseInt(request.getParameter("maCX"));
            int soGhe = Integer.parseInt(request.getParameter("soGhe"));
            
            boolean isDaDat = veXeDAO.isGheDaDat(maCX, soGhe);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"available\": " + !isDaDat + "}");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
}




