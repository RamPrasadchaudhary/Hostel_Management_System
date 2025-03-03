<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, database.DatabaseConnection, java.io.*" %>
<%
    // Ensure the user is logged in.
    if (session.getAttribute("username") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    
    // Process the form submission.
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        Part filePart = request.getPart("profileImage");
        if (filePart != null && filePart.getSize() > 0) {
            InputStream is = filePart.getInputStream();
            try {
                Connection conn = DatabaseConnection.getConnection();
                
                // Check if an image record already exists for this user.
                String checkSql = "SELECT COUNT(*) FROM student_images WHERE contact = ?";
                PreparedStatement ps = conn.prepareStatement(checkSql);
                ps.setString(1, (String) session.getAttribute("username"));
                ResultSet rs = ps.executeQuery();
                boolean exists = false;
                if (rs.next()) {
                    exists = (rs.getInt(1) > 0);
                }
                rs.close();
                ps.close();
                
                String sql = "";
                if (exists) {
                    // Update the existing record.
                    sql = "UPDATE student_images SET profileImage = ? WHERE contact = ?";
                } else {
                    // Insert a new record.
                    sql = "INSERT INTO student_images (profileImage, contact) VALUES (?, ?)";
                }
                ps = conn.prepareStatement(sql);
                ps.setBlob(1, is);
                ps.setString(2, (String) session.getAttribute("username"));
                int row = ps.executeUpdate();
                ps.close();
                conn.close();
                if (row > 0) {
                    out.println("<p style='color:green;'>Profile image " + (exists ? "updated" : "uploaded") + " successfully!</p>");
                } else {
                    out.println("<p style='color:red;'>Error saving image.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        } else {
            out.println("<p style='color:red;'>No file selected. Please choose an image file.</p>");
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Profile Image</title>
    <!-- Link to external CSS for consistent styling -->
    <link rel="stylesheet" href="profile.css">
</head>
<body>
    <header>
        <h1>Update Profile Image</h1>
    </header>
    
    <section id="update-image">
        <div class="section">
            <h2>Upload/Update Your Profile Image</h2>
            <form action="updateImage.jsp" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <input type="file" name="profileImage" accept="image/*" required>
                </div>
                <div class="form-group">
                    <input type="submit" value="Upload Image">
                </div>
            </form>
        </div>
    </section>
    
    <a href="dashboard.jsp" class="dashboard-link">Back to Dashboard</a>
    <footer>
        <p>&copy; 2024 Hostel Management</p>
    </footer>
</body>
</html>
