<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="Header.jsp" %>
<%@ page import="java.sql.*, database.DatabaseConnection" %>

<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    // Check that the user is logged in.
    if (session.getAttribute("username") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    
    // Initialize variables with default values.
    String name = "N/A";
    String address = "N/A";
    String email = "N/A";
    String admissionDate = "N/A";
    String parentName = "N/A";
    String branch = "N/A";
    String contact = "N/A";
    
    // Fetch student data from the database using the session username (assumed to be the contact).
    try {
        Connection conn = DatabaseConnection.getConnection();
        String sql = "SELECT * FROM students WHERE contact = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, (String)session.getAttribute("username"));
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            address = rs.getString("address");
            email = rs.getString("email");
            admissionDate = rs.getString("admissionDate");
            parentName = rs.getString("parentName");
            branch = rs.getString("branch");
            contact = rs.getString("contact");
        }
        rs.close();
        stmt.close();
        conn.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <!-- Link to external CSS for styling the profile edit page -->
    <link rel="stylesheet" href="profile.css">
</head>
<body>

    
    <a href="dashboard.jsp" class="dashboard-link">Back to Dashboard</a>
    
    <section id="edit-profile">
        <div class="section">
            <h2>Edit Profile</h2>
 <!-- Updated form action with context path -->
        <form id="profile-form" action="" method="POST">
                
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" value="<%= name %>" required>
                </div>
                
                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" value="<%= address %>" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <!-- Set as readonly by default. Click the pencil icon to edit -->
                    <input type="email" id="email" name="email" value="<%= email %>" required readonly>
                    <span class="edit-icon" onclick="toggleEdit('email')">&#9998;</span>
                </div>
                
                <div class="form-group">
                    <label for="admissionDate">Admission Date</label>
                    <input type="date" id="admissionDate" name="admissionDate" value="<%= admissionDate %>" required>
                </div>
                
                <div class="form-group">
                    <label for="parentName">Parent Name</label>
                    <input type="text" id="parentName" name="parentName" value="<%= parentName %>" required>
                </div>
                
                <div class="form-group">
                    <label for="branch">Branch</label>
                    <input type="text" id="branch" name="branch" value="<%= branch %>" required>
                </div>
                
                <div class="form-group">
                    <label for="contact">Phone Number</label>
                    <!-- Set as readonly by default. Click the pencil icon to edit -->
                    <input type="tel" id="contact" name="contact" value="<%= contact %>" required readonly>
                    <span class="edit-icon" onclick="toggleEdit('contact')">&#9998;</span>
                </div>
                
                <div class="form-group">
                    <button type="button" onclick="showPopup()">Save Changes</button>
                </div>
            </form>
        </div>
    </section>
    
    <!-- Popup Confirmation -->
    <div id="popup" class="popup">
        <p>Are you sure you want to save the changes?</p>
        <button id="confirm-btn" onclick="submitForm()">Yes</button>
        <button class="cancel" id="cancel-btn" onclick="closePopup()">No</button>
    </div>
    
    <!-- Success Message -->
    <div id="success-message" class="success-message">
        <p>Changes saved successfully!</p>
        <button onclick="closeSuccessMessage()">OK</button>
    </div>
    
    <footer>
        <p>&copy; 2024 Hostel Management</p>
    </footer>
    
    <script>
        // Allow the user to edit a readonly field by clicking the edit icon.
        function toggleEdit(fieldId) {
            var field = document.getElementById(fieldId);
            field.removeAttribute('readonly');
            field.focus();
        }
        
        // Display the confirmation popup before saving changes.
        function showPopup() {
            document.getElementById("popup").style.display = "block";
        }
        
        // Close the popup without saving.
        function closePopup() {
            document.getElementById("popup").style.display = "none";
        }
        
        // Submit the form after confirming changes.
        function submitForm() {
            document.getElementById("profile-form").submit();
        }
        
        // Close the success message popup.
        function closeSuccessMessage() {
            document.getElementById("success-message").style.display = "none";
        }
    </script>
    
</body>
</html>
