package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Lớp kết nối database SQL Server
 */
public class DBConnection {
    
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=QuanLyVeXeKhach;encrypt=false";
    private static final String USER = "qlvk";
    private static final String PASS = "c24";
    
    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            System.err.println("Không tìm thấy SQL Server JDBC Driver!");
            e.printStackTrace();
        }
    }
    
    /**
     * Lấy kết nối đến database
     */
    public static Connection getConnection() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(URL, USER, PASS);
        } catch (SQLException e) {
            System.err.println("Lỗi kết nối database!");
            System.err.println("URL: " + URL);
            System.err.println("User: " + USER);
            e.printStackTrace();
        }
        return conn;
    }
    
    /**
     * Đóng kết nối
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Test kết nối
     */
    public static void main(String[] args) {
        Connection conn = getConnection();
        if (conn != null) {
            System.out.println("Kết nối database thành công!");
            closeConnection(conn);
        } else {
            System.out.println("Kết nối database thất bại!");
        }
    }
}



