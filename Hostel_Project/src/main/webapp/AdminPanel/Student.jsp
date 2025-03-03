<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="SideBar.jsp" %> <!-- Sidebar Included -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Management System</title>  
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="Style/Student.css">
    <link rel="stylesheet" href="Heading.css">
</head>
<body>

<div class="heading-container">
    <h3 class="heading-title">Student Record</h3>
    <p class="heading-subtitle">This is Student Record</p>
</div>

<div class="student-container">
    <div class="student-header">
        <h1>Manage Students</h1>
    </div>

    <% if (session.getAttribute("message") != null) { %>
        <div class="alert">
            <h3 style="text-align:center; color:green; background-color:lightgreen;"> 
                <%= session.getAttribute("message") %>
            </h3>  
        </div>
        <% session.removeAttribute("message"); %>  
    <% } %>

    <!-- Search and Filter Form -->
    <form method="GET">
        <div class="student-search-section">
            <input type="text" class="student-search-box" name="searchQuery" placeholder="Search by name or ID" value="<%= request.getParameter("searchQuery") != null ? request.getParameter("searchQuery") : "" %>">
            <button type="submit" class="student-search-btn">Search</button>
            <button type="button" class="student-reset-btn" onclick="window.location='Student.jsp'">Reset</button>
        </div>

        <div class="student-filter-section">
            <label>Filter by Branch:</label>
            <select name="branchFilter" class="student-filter-dropdown" onchange="this.form.submit()">
               <option value="all" <%= "all".equals(request.getParameter("branchFilter")) ? "selected" : "" %>>All Branches</option>
                <option value="Computer Science " <%= "Computer Science ".equals(request.getParameter("branchFilter")) ? "selected" : "" %>>Computer Science </option>

                <option value="Electrical" <%= "Electrical".equals(request.getParameter("branchFilter")) ? "selected" : "" %>>Electrical</option>
                 <option value="Medical" <%= "Medical".equals(request.getParameter("branchFilter")) ? "selected" : "" %>>Medical</option>
                  <option value="Management" <%= "Management".equals(request.getParameter("branchFilter")) ? "selected" : "" %>>Management</option>
            </select>
        </div>
    </form>

    <button class="student-add-btn" onclick="toggleForm('add')">Add New Student</button>

    <!-- Student Form Popup -->
    <div id="studentForm" class="student-form-popup">
        <div class="student-form-container">
            <h2><%= request.getParameter("id") != null ? "Update Student" : "Add Student" %></h2>
            <form method="POST" action="AllActionJSP/StudentAction.jsp">
                <input type="hidden" name="id" value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>">

                <div class="student-form-group">
                    <label>Name:</label>
                    <input type="text" name="name" required value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">
                </div>
                <div class="student-form-group">
                    <label>Branch:</label>
                    <select name="branch">
                        <option value="Computer Science (Data Science)" <%= "Computer Science (Data Science)".equals(request.getParameter("branch")) ? "selected" : "" %>>Computer Science (Data Science)</option>
                        <option value="Electrical" <%= "Electrical".equals(request.getParameter("branch")) ? "selected" : "" %>>Electrical</option>
                         <option value="Management" <%= "Management".equals(request.getParameter("branch")) ? "selected" : "" %>>Management</option>
                          <option value="Medical" <%= "Medical".equals(request.getParameter("branch")) ? "selected" : "" %>>Medical</option>
                    </select>
                </div>

                <div class="student-form-group">
                    <label>Contact:</label>
                    <input type="tel" name="contact" required value="<%= request.getParameter("contact") != null ? request.getParameter("contact") : "" %>">
                </div>

                <div class="student-form-group">
                    <label>Admission Date:</label>
                    <input type="date" name="admissionDate" required value="<%= request.getParameter("admissionDate") != null ? request.getParameter("admissionDate") : "" %>">
                </div>

                <div class="student-form-group">
                    <label>Address:</label>
                    <input type="text" name="address" required value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>">
                </div>
				    <div class="student-form-group">
                    <label>Parent Name:</label>
                    <input type="text" name="parentName" required value="<%= request.getParameter("parentName") != null ? request.getParameter("parentName") : "" %>">
                </div>
                    <div class="student-form-group">
                    <label>email:</label>
                    <input type="email" name="email" required value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                </div>
                <div class="student-form-actions">
                    <button type="submit" class="student-submit-btn">
                        <%= request.getParameter("id") != null ? "Update Student" : "Add Student" %>
                    </button>
                    <button type="button" class="student-cancel-btn" onclick="cancelForm()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Fetch Student Data -->
    <table class="student-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Branch</th>
                <th>Contact</th>
                <th>Admission Date</th>
                <th>Address</th>
                <th>Parent Name:</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
            Connection con = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostelproject", "root", "9821574168");

                // Dynamic Query for Search and Filter
                String query = "SELECT * FROM students WHERE 1=1";
                String searchQuery = request.getParameter("searchQuery");
                String branchFilter = request.getParameter("branchFilter");

                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    query += " AND (id LIKE ? OR name LIKE ?)";
                }
                if (branchFilter != null && !branchFilter.equals("all")) {
                    query += " AND branch = ?";
                }

                stmt = con.prepareStatement(query);

                int paramIndex = 1;
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    stmt.setString(paramIndex++, "%" + searchQuery + "%");
                    stmt.setString(paramIndex++, "%" + searchQuery + "%");
                }
                if (branchFilter != null && !branchFilter.equals("all")) {
                    stmt.setString(paramIndex++, branchFilter);
                }

                rs = stmt.executeQuery();

                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                
                <td><%= rs.getString("branch") %></td>
                  
                <td><%= rs.getString("contact") %></td>
                <td><%= rs.getString("admissionDate") %></td>
                <td><%= rs.getString("address") %></td>
                 <td><%= rs.getString("parentName") %></td>
                <td><%= rs.getString("email") %></td>
                <td class="student-action-buttons">
                    <a href="?id=<%= rs.getInt("id") %>&name=<%= rs.getString("name") %>&branch=<%= rs.getString("branch") %>&contact=<%= rs.getString("contact") %>&admissionDate=<%= rs.getString("admissionDate") %>&address=<%= rs.getString("address") %>&parentName=<%= rs.getString("parentName") %>&email=<%= rs.getString("email") %>" class="student-edit-link">Edit</a>
                    <a href="AllActionJSP/StudentAction.jsp?action=delete&id=<%= rs.getInt("id") %>" class="student-delete-link" onclick="return confirm('Are you sure you want to delete this student?')">Delete</a>
                </td>
            </tr>
            <% 
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='8' style='color:red;'>Error fetching data!</td></tr>");
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            }
            %>
        </tbody>
    </table>
</div>

<script>
    function toggleForm(action) {
        document.getElementById('studentForm').style.display = "block";
    }

    function cancelForm() {
        document.getElementById("studentForm").style.display = "none";
        window.history.replaceState({}, document.title, window.location.pathname);
    }

    function resetForm() {
        window.location = window.location.pathname;
    }

    window.onload = function () {
        const urlParams = new URLSearchParams(window.location.search);
        
        // Check if there's an 'id' parameter in the URL (indicating Edit operation)
        if (urlParams.has('id')) {
            toggleForm('edit');  // Show the form in edit mode
        }
    };

    function toggleForm(action) {
        const form = document.getElementById('studentForm');
        if (action === 'add' || action === 'edit') {
            form.style.display = "block";  // Show the form
        } else {
            form.style.display = "none";  // Hide the form
            window.history.replaceState({}, document.title, window.location.pathname);  // Clean up URL
        }
    }
    
    function openModal(type, id) {
        const modal = document.getElementById("staffModal");
        modal.style.display = "flex"; // Changed to flex
        // ... rest of your code ...
    }

    function closeModal() {
        document.getElementById("staffModal").style.display = "none";
    }
</script>

</body>
</html>
                
                
