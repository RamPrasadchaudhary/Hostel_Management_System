<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>
<%
    // Get search parameters (if any)
    String searchQuery = request.getParameter("searchQuery");
    String selectedRole = request.getParameter("selectedRole");
    if(searchQuery == null) { searchQuery = ""; }
    if(selectedRole == null) { selectedRole = "All Roles"; }
    
    // Build the query dynamically.
    String query = "SELECT * FROM staff WHERE 1=1";
    if(!searchQuery.isEmpty()){
        query += " AND name LIKE ?";
    }
    if(!selectedRole.equals("All Roles")){
        query += " AND role = ?";
    }
    
    Connection con = DatabaseConnection.getConnection();
    PreparedStatement pst = con.prepareStatement(query);
    int paramIndex = 1;
    if(!searchQuery.isEmpty()){
        pst.setString(paramIndex++, "%" + searchQuery + "%");
    }
    if(!selectedRole.equals("All Roles")){
        pst.setString(paramIndex++, selectedRole);
    }
    ResultSet rs = pst.executeQuery();
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="SideBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Staff</title>
    <link rel="stylesheet" type="text/css" href="Style/staff.css">
    <link rel="stylesheet" type="text/css" href="Heading.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="Heading.jsp" %>

<div class="manage-staff-wrapper">
    <div class="manage-staff-container">
        <div class="staff-filters">
            <form method="post" action="Staff.jsp">
                <input type="text" name="searchQuery" placeholder="Search staff..." value="<%= searchQuery %>">
                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i> Search
                </button>
                <select name="selectedRole">
                    <option value="All Roles" <%= ("All Roles".equals(selectedRole)) ? "selected" : "" %>>All Roles</option>
                    <option value="Electrician" <%= ("Electrician".equals(selectedRole)) ? "selected" : "" %>>Electrician</option>
                    <option value="Manager" <%= ("Manager".equals(selectedRole)) ? "selected" : "" %>>Manager</option>
                    <option value="Plumber" <%= ("Plumber".equals(selectedRole)) ? "selected" : "" %>>Plumber</option>
                </select>
                <button type="submit" class="filter-button">
                    <i class="fas fa-filter"></i> Apply
                </button>
                <button type="button" class="add-staff-button" onclick="openModal('add')">
                    <i class="fas fa-plus"></i> Add New Staff
                </button>
            </form>
        </div>
        
        <%-- Display a response message (if any) --%>
        <%
            String message = "";
            if(session.getAttribute("message") != null){
                message = (String) session.getAttribute("message");
            }
            if(!message.isEmpty()){
        %>
            <div class="alert">
                <h3 style="text-align:center; color:green; background-color:lightgreen;">
                    <%= message %>
                </h3>
            </div>
        <%
                session.removeAttribute("message");
            }
        %>
        
        <div class="staff-list">
            <table class="staff-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Role</th>
                        <th>Joining Date</th>
                        <th>Contact</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while(rs.next()){
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
                            String roleVal = rs.getString("role");
                            Date joinDate = rs.getDate("join_date");
                            String contact = rs.getString("contact");
                    %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= name %></td>
                        <td><%= roleVal %></td>
                        <td><%= joinDate %></td>
                        <td><%= contact %></td>
                        <td>
                            <button class="action-button edit" onclick="openModal('edit', '<%= id %>', '<%= name %>', '<%= roleVal %>', '<%= joinDate %>', '<%= contact %>')">
                                <i class="fas fa-edit"></i> Edit
                            </button>
                            <button class="action-button delete" onclick="deleteStaff('<%= id %>')">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                        </td>
                    </tr>
                    <%
                        } // end while
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal for Adding/Editing Staff -->
<div id="staffModal" class="modal" style="display:none;">
    <div class="modal-content">
        <h3 id="modalTitle"></h3>
        <form method="post" action="AllActionJSP/StaffAction.jsp">
            <input type="hidden" name="id" id="staffId">
            <label>Name:</label>
            <input type="text" name="name" id="staffName" required>
            <label>Role:</label>
            <input type="text" name="role" id="staffRole" required>
            <label>Joining Date:</label>
            <input type="date" name="joiningDate" id="staffJoiningDate" required>
            <label>Contact:</label>
            <input type="number" name="contact" id="contact" required>
            <button type="submit" id="modalActionBtn"></button>
            <button type="button" onclick="closeModal()">Cancel</button>
        </form>
    </div>
</div>

<script>
    function openModal(type, id = "", name = "", role = "", joinDate = "", contact = "") {
        document.getElementById("staffModal").style.display = "block";
        document.getElementById("modalTitle").innerText = type === 'add' ? "Add New Staff" : "Edit Staff";
        document.getElementById("modalActionBtn").innerText = type === 'add' ? "Add" : "Save";
        document.getElementById("staffId").value = id;
        document.getElementById("staffName").value = name;
        document.getElementById("staffRole").value = role;
        document.getElementById("staffJoiningDate").value = joinDate;
        document.getElementById("contact").value = contact;
    }

    function closeModal() {
        document.getElementById("staffModal").style.display = "none";
    }

    function deleteStaff(id) {
        if(confirm("Are you sure you want to delete this staff member?")){
            window.location.href = "AllActionJSP/StaffAction.jsp?deleteId=" + id;
        }
    }

    // Remove the alert message after 3 seconds.
    setTimeout(() => {
        var alertDiv = document.querySelector('.alert');
        if(alertDiv) alertDiv.remove();
    }, 3000);
</script>
</body>
</html>
<%
    // Clean up JDBC resources
    if(rs != null) rs.close();
    if(pst != null) pst.close();
    if(con != null) con.close();
%>
