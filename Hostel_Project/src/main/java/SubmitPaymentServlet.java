import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DatabaseConnection; // Ensure this class has a getConnection() method
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/SubmitPaymentServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class SubmitPaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String contactInput = request.getParameter("contact");
        String paymentDetails = request.getParameter("payment_details");
        String month = request.getParameter("month");

        int studentId = 0;
        String studentName = "";
        String emailFromDB = "";
        String roomNumber = "";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();

            // Get student details
            String studentQuery = "SELECT id, name, email FROM students WHERE contact = ?";
            stmt = conn.prepareStatement(studentQuery);
            stmt.setString(1, contactInput);
            rs = stmt.executeQuery();
            if (rs.next()) {
                studentId = rs.getInt("id");
                studentName = rs.getString("name");
                emailFromDB = rs.getString("email");
            }
            rs.close();
            stmt.close();

            // Get room number
            String allocationQuery = "SELECT room_number FROM allocations WHERE student_id = ?";
            stmt = conn.prepareStatement(allocationQuery);
            stmt.setInt(1, studentId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                roomNumber = rs.getString("room_number");
            }
            rs.close();
            stmt.close();

            // Handle file upload
            Part filePart = request.getPart("payment_receipt");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String applicationPath = request.getServletContext().getRealPath(""); 
            String uploadDir = applicationPath + File.separator + "uploads";

            File fileUploadDir = new File(uploadDir);
            if (!fileUploadDir.exists()) {
                fileUploadDir.mkdirs();
            }

            String filePath = uploadDir + File.separator + fileName;
            filePart.write(filePath);
            String dbFilePath = "uploads/" + fileName;

            // Insert into database
            String insertQuery = "INSERT INTO student_payments (student_id, student_name, contact, payment_details, month, email, room_number, status, receipt_file, payment_date) " +
                                 "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
            stmt = conn.prepareStatement(insertQuery);
            stmt.setInt(1, studentId);
            stmt.setString(2, studentName);
            stmt.setString(3, contactInput);
            stmt.setString(4, paymentDetails);
            stmt.setString(5, month);
            stmt.setString(6, emailFromDB);
            stmt.setString(7, roomNumber);
            stmt.setString(8, "Pending");
            stmt.setString(9, dbFilePath);
            int rowsInserted = stmt.executeUpdate();
            stmt.close();

            // Set session contact
            HttpSession session = request.getSession();
            session.setAttribute("contact", contactInput);

            String msg = (rowsInserted > 0) ? "Payment submitted successfully" : "Failed to submit payment.";
            response.sendRedirect(request.getContextPath() + "/StudentPanel/payments.jsp?msg=" + URLEncoder.encode(msg, "UTF-8"));

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/StudentPanel/payments.jsp?msg=" + URLEncoder.encode("Database error: " + e.getMessage(), "UTF-8"));
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
