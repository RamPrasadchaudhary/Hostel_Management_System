import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DatabaseConnection; // Your helper class for DB connection
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SubmitComplaintServlet")
public class SubmitComplaintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Set request encoding and content type
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        // Check for valid session and logged-in user
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
            return;
        }
        
        // Retrieve complaint parameters from the form
        String complaintType = request.getParameter("complaint-type");
        String complaintDescription = request.getParameter("complaint-description");
        
        // Retrieve the logged-in user's contact (used as username)
        String userContact = (String) session.getAttribute("username");
        
        // Variables to store student details
        int studentId = 0;
        String studentName = "";
        String roomNumber = "";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            
            // 1. Retrieve student details (ID and Name) from the 'students' table using the contact
            String studentQuery = "SELECT id, name FROM students WHERE contact = ?";
            stmt = conn.prepareStatement(studentQuery);
            stmt.setString(1, userContact);
            rs = stmt.executeQuery();
            if (rs.next()) {
                studentId = rs.getInt("id");
                studentName = rs.getString("name");
            }
            rs.close();
            stmt.close();
            
            // 2. Retrieve the room number from the 'allocations' table using the student ID
            String allocationQuery = "SELECT room_number FROM allocations WHERE student_id = ?";
            stmt = conn.prepareStatement(allocationQuery);
            stmt.setInt(1, studentId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                roomNumber = rs.getString("room_number");
            }
            rs.close();
            stmt.close();
            
            // 3. Insert the complaint record into the database
            String insertQuery = "INSERT INTO complaints " +
                    "(student_id, name, contact, room_number, complaint_type, complaint_description, status ,date_submitted) " +
                    "VALUES (?, ?, ?, ?, ?, ?,?, NOW())";
            stmt = conn.prepareStatement(insertQuery);
            stmt.setInt(1, studentId);
            stmt.setString(2, studentName);
            stmt.setString(3, userContact);
            stmt.setString(4, roomNumber);
            stmt.setString(5, complaintType);
            stmt.setString(6, complaintDescription);
            stmt.setString(7, "In Process");
            
            int rowsInserted = stmt.executeUpdate();
            stmt.close();
            
            // Prepare the success or error message using URL encoding
            String msg;
            if (rowsInserted > 0) {
                msg = URLEncoder.encode("Complaint submitted successfully", "UTF-8");
            } else {
                msg = URLEncoder.encode("Failed to submit complaint. Please try again.", "UTF-8");
            }
            // Redirect to complaints.jsp with a message
            response.sendRedirect(request.getContextPath() + "/StudentPanel/complaints.jsp?msg=" + msg);
            
        } catch (SQLException e) {
            e.printStackTrace();
            String errMsg = URLEncoder.encode("Database error: " + e.getMessage(), "UTF-8");
            response.sendRedirect(request.getContextPath() + "/StudentPanel/complaints.jsp?msg=" + errMsg);
        } finally {
            // Close resources to prevent memory leaks
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
