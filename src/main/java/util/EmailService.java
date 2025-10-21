package util;

import model.VeXe;

import javax.mail.*;
import javax.mail.internet.*;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Properties;

/**
 * Service gửi email thông báo đặt vé thành công
 */
public class EmailService {
    
    // ============ CẤU HÌNH EMAIL ============
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587"; // TLS port
    private static final String EMAIL_USERNAME = "gialaibeo69@gmail.com";
    private static final String EMAIL_PASSWORD = "gnig ftai qfvd xvhy";
    private static final String FROM_EMAIL = "gialaibeo69@gmail.com";
    private static final String FROM_NAME = "Hệ Thống Đặt Vé Xe Khách";
    
    /**
     * Gửi email xác nhận đặt vé thành công
     * @param ve Thông tin vé vừa đặt
     * @return true nếu gửi thành công, false nếu thất bại
     */
    public static boolean sendTicketConfirmation(VeXe ve) {
        try {
            // Kiểm tra email khách hàng
            String toEmail = ve.getKhachHang().getEmail();
            if (toEmail == null || toEmail.trim().isEmpty()) {
                System.out.println("Khách hàng không có email, bỏ qua gửi mail");
                return false;
            }
            
            // Cấu hình SMTP
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            
            // Tạo session với authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });
            
            // Tạo email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Xác nhận đặt vé thành công - Mã vé #" + ve.getMaVe());
            
            // Tạo nội dung HTML
            String htmlContent = createEmailTemplate(ve);
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            
            // Gửi email
            Transport.send(message);
            
            System.out.println("✅ Đã gửi email xác nhận đến: " + toEmail);
            return true;
            
        } catch (Exception e) {
            System.err.println("❌ Lỗi khi gửi email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Tạo template HTML cho email xác nhận đặt vé
     */
    private static String createEmailTemplate(VeXe ve) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
        NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
        
        String maVe = String.valueOf(ve.getMaVe());
        String hoTen = ve.getKhachHang().getHoTen();
        String sdt = ve.getKhachHang().getSdt();
        String email = ve.getKhachHang().getEmail();
        
        String soXe = ve.getChuyenXe().getSoXe();
        String diemDi = ve.getChuyenXe().getDiemDi();
        String diemDen = ve.getChuyenXe().getDiemDen();
        String ngayKhoiHanh = sdf.format(ve.getChuyenXe().getNgayKhoiHanh());
        String gioKhoiHanh = timeFormat.format(ve.getChuyenXe().getGioKhoiHanh());
        String giaVe = currencyFormat.format(ve.getChuyenXe().getGiaVe()) + " VND";
        
        String soGhe = String.valueOf(ve.getSoGhe());
        String ngayDat = sdf.format(ve.getNgayDat());
        
        return "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "    <meta charset='UTF-8'>" +
            "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
            "    <style>" +
            "        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 20px; }" +
            "        .container { max-width: 600px; margin: 0 auto; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }" +
            "        .header { background: linear-gradient(135deg, #ff8c00 0%, #ff6600 100%); color: white; padding: 30px; text-align: center; }" +
            "        .header h1 { margin: 0; font-size: 24px; }" +
            "        .header p { margin: 5px 0 0 0; opacity: 0.9; }" +
            "        .content { padding: 30px; }" +
            "        .ticket-info { background: #fff5e6; border-left: 4px solid #ff8c00; padding: 20px; margin: 20px 0; border-radius: 5px; }" +
            "        .info-row { display: flex; justify-content: space-between; align-items: center; margin: 10px 0; padding: 10px 0; border-bottom: 1px dashed #ddd; }" +
            "        .info-row:last-child { border-bottom: none; }" +
            "        .label { font-weight: bold; color: #333; flex-shrink: 0; }" +
            "        .value { color: #666; text-align: right; flex-shrink: 0; }" +
            "        .highlight { background: #ff8c00; color: white; padding: 15px; text-align: center; border-radius: 5px; font-size: 18px; font-weight: bold; margin: 20px 0; }" +
            "        .route { font-size: 20px; font-weight: bold; color: #ff8c00; text-align: center; margin: 20px 0; }" +
            "        .arrow { color: #999; margin: 0 10px; }" +
            "        .footer { background: #f8f8f8; padding: 20px; text-align: center; color: #666; font-size: 12px; }" +
            "        .note { background: #fff3cd; border: 1px solid #ffc107; padding: 15px; border-radius: 5px; margin: 20px 0; color: #856404; }" +
            "    </style>" +
            "</head>" +
            "<body>" +
            "    <div class='container'>" +
            "        <div class='header'>" +
            "            <h1>🎫 XÁC NHẬN ĐẶT VÉ THÀNH CÔNG</h1>" +
            "            <p>Cảm ơn quý khách đã sử dụng dịch vụ của chúng tôi!</p>" +
            "        </div>" +
            "        <div class='content'>" +
            "            <p>Kính chào <strong>" + hoTen + "</strong>,</p>" +
            "            <p>Chúng tôi xác nhận đã nhận được đặt vé của quý khách. Dưới đây là thông tin chi tiết:</p>" +
            "            " +
            "            <div class='highlight'>" +
            "                MÃ VÉ: #" + maVe +
            "            </div>" +
            "            " +
            "            <div class='route'>" +
            "                " + diemDi + " <span class='arrow'>→</span> " + diemDen +
            "            </div>" +
            "            " +
            "            <div class='ticket-info'>" +
            "                <h3 style='margin-top: 0; color: #ff8c00;'>📋 THÔNG TIN CHUYẾN XE</h3>" +
            "                <div class='info-row'>" +
            "                    <span class='label'>Số xe:</span>" +
            "                    <span class='value'>" + soXe + "</span>" +
            "                </div>" +
            "                <div class='info-row'>" +
            "                    <span class='label'>Ngày khởi hành:</span>" +
            "                    <span class='value'>" + ngayKhoiHanh + "</span>" +
            "                </div>" +
            "                <div class='info-row'>" +
            "                    <span class='label'>Giờ khởi hành:</span>" +
            "                    <span class='value'>" + gioKhoiHanh + "</span>" +
            "                </div>" +
            "                <div class='info-row'>" +
            "                    <span class='label'>Số ghế:</span>" +
            "                    <span class='value'><strong style='color: #ff8c00; font-size: 18px;'>" + soGhe + "</strong></span>" +
            "                </div>" +
            "                <div class='info-row'>" +
            "                    <span class='label'>Giá vé:</span>" +
            "                    <span class='value'><strong style='color: #28a745; font-size: 16px;'>" + giaVe + "</strong></span>" +
            "                </div>" +
            "            </div>" +
            "            " +
            "            <div class='ticket-info'>" +
            "                <h3 style='margin-top: 0; color: #ff8c00;'>👤 THÔNG TIN KHÁCH HÀNG</h3>" +
            "                <div class='info-row'>" +
            "                    <span class='label'>Họ tên:</span>" +
            "                    <span class='value'>" + hoTen + "</span>" +
            "                </div>" +
            "                <div class='info-row'>" +
            "                    <span class='label'>Số điện thoại:</span>" +
            "                    <span class='value'>" + sdt + "</span>" +
            "                </div>" +
            "                <div class='info-row'>" +
            "                    <span class='label'>Email:</span>" +
            "                    <span class='value'>" + email + "</span>" +
            "                </div>" +
            "                <div class='info-row'>" +
            "                    <span class='label'>Ngày đặt:</span>" +
            "                    <span class='value'>" + ngayDat + "</span>" +
            "                </div>" +
            "            </div>" +
            "            " +
            "            <div class='note'>" +
            "                <strong>⚠️ LƯU Ý:</strong><br>" +
            "                • Vui lòng có mặt tại bến xe trước giờ khởi hành <strong>15 phút</strong><br>" +
            "                • Xuất trình mã vé hoặc số điện thoại để nhận vé<br>" +
            "                • Liên hệ hotline để hỗ trợ hoặc thay đổi thông tin<br>" +
            "                • Vé có thể được hủy trước giờ khởi hành 2 giờ" +
            "            </div>" +
            "            " +
            "            <p style='text-align: center; margin-top: 30px;'>" +
            "                <strong>Chúc quý khách có một chuyến đi an toàn và vui vẻ!</strong>" +
            "            </p>" +
            "        </div>" +
            "        <div class='footer'>" +
            "            <p><strong>HỆ THỐNG ĐẶT VÉ XE KHÁCH</strong></p>" +
            "            <p>📞 Hotline: 1900-xxxx | 📧 Email: support@vexekhach.com</p>" +
            "            <p>📍 Địa chỉ: 123 Đường ABC, Quận XYZ, TP.HCM</p>" +
            "            <p style='margin-top: 15px; color: #999;'>" +
            "                Email này được gửi tự động, vui lòng không trả lời.<br>" +
            "                © 2025 Hệ Thống Đặt Vé Xe Khách. All rights reserved." +
            "            </p>" +
            "        </div>" +
            "    </div>" +
            "</body>" +
            "</html>";
    }
}

