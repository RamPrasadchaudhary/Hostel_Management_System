package servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hostelproject";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "9821574168";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        StringBuilder json = new StringBuilder("{");
        	
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            appendCount(json, "totalUsers", getCount(conn, "user"));
            appendCount(json, "totalStudents", getCount(conn, "students"));
            appendCount(json, "totalStaff", getCount(conn, "staff"));
            appendCount(json, "totalWardens", getCount(conn, "wardens"));
            appendCount(json, "totalMaintenanceRequests", getCount(conn, "complaints"));
            
            // Remove trailing comma
            if(json.charAt(json.length()-1) == ',') {
                json.setLength(json.length()-1);
            }
        } catch (Exception e) {
            json.append("\"error\":\"Database connection failed\"");
        }
        
        json.append("}");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json.toString());
    }

    private void appendCount(StringBuilder json, String key, int value) {
        json.append("\"")
            .append(key)
            .append("\":")
            .append(value)
            .append(",");
    }

    private int getCount(Connection conn, String table) throws SQLException {
        String sql = "SELECT COUNT(*) FROM " + table;
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
}