package controller;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import model.VeXe;
import model.VeXeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;

@WebServlet("/export-pdf")
public class ExportPDFServlet extends HttpServlet {
    
    private VeXeDAO veXeDAO = new VeXeDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String maVe = request.getParameter("maVe");
        
        if (maVe == null || maVe.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Mã vé không hợp lệ");
            return;
        }
        
        try {
            // Lấy thông tin vé
            VeXe ve = veXeDAO.getById(Integer.parseInt(maVe));
            
            if (ve == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy vé");
                return;
            }
            
            // Kiểm tra null cho ChuyenXe và KhachHang
            if (ve.getChuyenXe() == null) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Thông tin chuyến xe không tồn tại");
                return;
            }
            
            if (ve.getKhachHang() == null) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Thông tin khách hàng không tồn tại");
                return;
            }
            
            // Set response headers
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", 
                "attachment; filename=\"Ve_" + ve.getMaVe() + ".pdf\"");
            
            // Tạo document PDF
            Document document = new Document(PageSize.A5);
            PdfWriter.getInstance(document, response.getOutputStream());
            
            document.open();
            
            // Tạo PDF content
            generatePDFContent(document, ve);
            
            document.close();
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Mã vé không hợp lệ: " + maVe);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Chi tiet loi: " + e.getClass().getName() + " - " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Lỗi khi tạo PDF: " + e.getMessage());
        }
    }
    
    private void generatePDFContent(Document document, VeXe ve) throws DocumentException {
        try {
            // Sử dụng font cơ bản với CP1252 encoding (hỗ trợ Latin Extended)
            BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            
            Font titleFont = new Font(bf, 24, Font.BOLD, BaseColor.ORANGE);
            Font headerFont = new Font(bf, 16, Font.BOLD, BaseColor.BLACK);
            Font normalFont = new Font(bf, 12, Font.NORMAL, BaseColor.BLACK);
            Font boldFont = new Font(bf, 12, Font.BOLD, BaseColor.BLACK);
            Font smallFont = new Font(bf, 10, Font.ITALIC, BaseColor.GRAY);
            
            // Header - Logo và tên công ty
            Paragraph header = new Paragraph("VeXe Pro", titleFont);
            header.setAlignment(Element.ALIGN_CENTER);
            header.setSpacingAfter(10);
            document.add(header);
            
            Paragraph subHeader = new Paragraph("HE THONG QUAN LY VE XE KHACH", headerFont);
            subHeader.setAlignment(Element.ALIGN_CENTER);
            subHeader.setSpacingAfter(20);
            document.add(subHeader);
            
            // Đường kẻ
            PdfPTable lineTable = new PdfPTable(1);
            lineTable.setWidthPercentage(100);
            PdfPCell lineCell = new PdfPCell();
            lineCell.setBorder(Rectangle.BOTTOM);
            lineCell.setBorderWidthBottom(2);
            lineCell.setBorderColor(BaseColor.ORANGE);
            lineCell.setFixedHeight(5);
            lineTable.addCell(lineCell);
            document.add(lineTable);
            document.add(Chunk.NEWLINE);
            
            // Tiêu đề vé
            Paragraph ticketTitle = new Paragraph("VE XE KHACH", headerFont);
            ticketTitle.setAlignment(Element.ALIGN_CENTER);
            ticketTitle.setSpacingAfter(20);
            document.add(ticketTitle);
            
            // Thông tin vé trong table
            PdfPTable table = new PdfPTable(2);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10);
            table.setSpacingAfter(10);
            
            // Style cho cells
            PdfPCell labelCell, valueCell;
            
            // Mã vé
            labelCell = createLabelCell("Ma ve:", boldFont);
            valueCell = createValueCell(String.valueOf(ve.getMaVe()), normalFont);
            table.addCell(labelCell);
            table.addCell(valueCell);
            
            // Tuyến đường
            labelCell = createLabelCell("Tuyen duong:", boldFont);
            String tuyenDuong = removeVietnameseAccents(ve.getChuyenXe().getDiemDi()) + " - " + removeVietnameseAccents(ve.getChuyenXe().getDiemDen());
            valueCell = createValueCell(tuyenDuong, normalFont);
            table.addCell(labelCell);
            table.addCell(valueCell);
            
            // Ngày đi
            labelCell = createLabelCell("Ngay di:", boldFont);
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            valueCell = createValueCell(sdf.format(ve.getChuyenXe().getNgayKhoiHanh()), normalFont);
            table.addCell(labelCell);
            table.addCell(valueCell);
            
            // Giờ khởi hành
            labelCell = createLabelCell("Gio khoi hanh:", boldFont);
            SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
            valueCell = createValueCell(sdfTime.format(ve.getChuyenXe().getGioKhoiHanh()), normalFont);
            table.addCell(labelCell);
            table.addCell(valueCell);
            
            // Số ghế
            labelCell = createLabelCell("So ghe:", boldFont);
            valueCell = createValueCell(String.valueOf(ve.getSoGhe()), normalFont);
            valueCell.setBackgroundColor(BaseColor.YELLOW);
            table.addCell(labelCell);
            table.addCell(valueCell);
            
            // Giá vé
            labelCell = createLabelCell("Gia ve:", boldFont);
            NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
            valueCell = createValueCell(currencyFormat.format(ve.getChuyenXe().getGiaVe()) + " VND", normalFont);
            valueCell.setBackgroundColor(new BaseColor(255, 240, 220));
            table.addCell(labelCell);
            table.addCell(valueCell);
            
            // Đường kẻ
            PdfPCell separatorCell = new PdfPCell();
            separatorCell.setColspan(2);
            separatorCell.setBorder(Rectangle.BOTTOM);
            separatorCell.setBorderWidthBottom(1);
            separatorCell.setBorderColor(BaseColor.LIGHT_GRAY);
            separatorCell.setFixedHeight(10);
            table.addCell(separatorCell);
            
            // Thông tin khách hàng
            labelCell = createLabelCell("Khach hang:", boldFont);
            valueCell = createValueCell(removeVietnameseAccents(ve.getKhachHang().getHoTen()), normalFont);
            table.addCell(labelCell);
            table.addCell(valueCell);
            
            // Số điện thoại
            labelCell = createLabelCell("Dien thoai:", boldFont);
            valueCell = createValueCell(ve.getKhachHang().getSdt(), normalFont);
            table.addCell(labelCell);
            table.addCell(valueCell);
            
            // Email
            labelCell = createLabelCell("Email:", boldFont);
            String email = ve.getKhachHang().getEmail();
            valueCell = createValueCell(email != null && !email.isEmpty() ? email : "N/A", normalFont);
            table.addCell(labelCell);
            table.addCell(valueCell);
            
            // Địa chỉ
            labelCell = createLabelCell("Dia chi:", boldFont);
            String diaChi = ve.getKhachHang().getDiaChi();
            String diaChiDisplay = (diaChi != null && !diaChi.isEmpty()) ? removeVietnameseAccents(diaChi) : "N/A";
            valueCell = createValueCell(diaChiDisplay, normalFont);
            table.addCell(labelCell);
            table.addCell(valueCell);
            
            document.add(table);
            
            // QR Code placeholder (box)
            document.add(Chunk.NEWLINE);
            Paragraph qrLabel = new Paragraph("Ma QR:", boldFont);
            qrLabel.setAlignment(Element.ALIGN_CENTER);
            document.add(qrLabel);
            
            PdfPTable qrTable = new PdfPTable(1);
            qrTable.setWidthPercentage(30);
            qrTable.setHorizontalAlignment(Element.ALIGN_CENTER);
            PdfPCell qrCell = new PdfPCell();
            qrCell.setFixedHeight(80);
            qrCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            qrCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            Paragraph qrText = new Paragraph("[QR: " + ve.getMaVe() + "]", smallFont);
            qrText.setAlignment(Element.ALIGN_CENTER);
            qrCell.addElement(qrText);
            qrTable.addCell(qrCell);
            document.add(qrTable);
            
            // Lưu ý
            document.add(Chunk.NEWLINE);
            Paragraph notes = new Paragraph(
                "Luu y: Vui long mang theo ve khi len xe.\n" +
                "Co mat truoc gio khoi hanh 15 phut.\n" +
                "Cam on quy khach da su dung dich vu!", 
                smallFont
            );
            notes.setAlignment(Element.ALIGN_CENTER);
            document.add(notes);
            
            // Footer
            document.add(Chunk.NEWLINE);
            SimpleDateFormat sdfFull = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            Paragraph footer = new Paragraph(
                "In ngay: " + sdfFull.format(new java.util.Date()), 
                smallFont
            );
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new DocumentException("Loi tao PDF: " + e.getMessage());
        }
    }
    
    private PdfPCell createLabelCell(String text, Font font) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setPadding(8);
        cell.setBackgroundColor(new BaseColor(245, 245, 245));
        return cell;
    }
    
    private PdfPCell createValueCell(String text, Font font) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setPadding(8);
        return cell;
    }
    
    /**
     * Chuyển tiếng Việt có dấu sang không dấu
     */
    private String removeVietnameseAccents(String str) {
        if (str == null) return "";
        str = str.replaceAll("[àáạảãâầấậẩẫăằắặẳẵ]", "a");
        str = str.replaceAll("[ÀÁẠẢÃĂẰẮẶẲẴÂẦẤẬẨẪ]", "A");
        str = str.replaceAll("[èéẹẻẽêềếệểễ]", "e");
        str = str.replaceAll("[ÈÉẸẺẼÊỀẾỆỂỄ]", "E");
        str = str.replaceAll("[đ]", "d");
        str = str.replaceAll("[Đ]", "D");
        str = str.replaceAll("[ìíịỉĩ]", "i");
        str = str.replaceAll("[ÌÍỊỈĨ]", "I");
        str = str.replaceAll("[òóọỏõôồốộổỗơờớợởỡ]", "o");
        str = str.replaceAll("[ÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ]", "O");
        str = str.replaceAll("[ùúụủũưừứựửữ]", "u");
        str = str.replaceAll("[ÙÚỤỦŨƯỪỨỰỬỮ]", "U");
        str = str.replaceAll("[ỳýỵỷỹ]", "y");
        str = str.replaceAll("[ỲÝỴỶỸ]", "Y");
        return str;
    }
}





