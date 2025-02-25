<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>

<%
Connection con = DatabaseConnection.getConnection();
PreparedStatement pst = null;
ResultSet rs = null;
String message = "";

// Corrected search and filter functionality
String query = "SELECT * FROM staff WHERE 1=1"; 
String searchQuery = request.getParameter("searchQuery");
String selectedRole = request.getParameter("selectedRole");

if (searchQuery != null && !searchQuery.isEmpty()) {
    query += " AND name LIKE ?";
}
if (selectedRole != null && !selectedRole.equals("All Roles")) {
    query += " AND role = ?";
}

try {
    pst = con.prepareStatement(query);
    int paramIndex = 1;

    if (searchQuery != null && !searchQuery.isEmpty()) {
        pst.setString(paramIndex++, "%" + searchQuery + "%");
    }
    if (selectedRole != null && !selectedRole.equals("All Roles")) {
        pst.setString(paramIndex++, selectedRole);
    }
    rs = pst.executeQuery();
} catch (SQLException e) {
    e.printStackTrace();
}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="SideBar.jsp" %> <!-- Sidebar Included -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Staff</title>
    <link rel="stylesheet" type="text/css" href="staff.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="Heading.css">
</head>
<body>
<%@ include file="Heading.jsp" %>

    <div class="manage-staff-wrapper">
        <div class="manage-staff-container">
            <div class="staff-filters">
                <form method="post" action="AllActionJSP/StaffAction.jsp">
                    <input type="text" name="searchQuery" placeholder="Search staff..." value="<%= (searchQuery != null) ? searchQuery : "" %>">
                    <button type="submit" class="search-button"><i class="fas fa-search"></i> Search</button>
                    <select name="selectedRole">
                        <option value="All Roles" <%= (selectedRole == null || selectedRole.equals("All Roles")) ? "selected" : "" %>>All Roles</option>
                        <option value="Electrician" <%= "Electrician".equals(selectedRole) ? "selected" : "" %>>Electrician</option>
                        <option value="Manager" <%= "Manager".equals(selectedRole) ? "selected" : "" %>>Manager</option>
                        <option value="Plumber" <%= "Plumber".equals(selectedRole) ? "selected" : "" %>>Plumber</option>
                    </select>
                    <button type="submit" class="filter-button"><i class="fas fa-filter"></i> Apply</button>
                    <button type="button" class="add-staff-button" onclick="openModal('add')">
                        <i class="fas fa-plus"></i> Add New Staff
                    </button>
                </form>
            </div>
            
            <% if (session.getAttribute("message") != null) { %>
                <div class="alert">
                    <h3 style="text-align:center; color:green; background-color:lightgreen;"> 
                        <%= session.getAttribute("message") %>
                    </h3>  
                </div>
                <% session.removeAttribute("message"); %>  
            <% } %>

            <div class="staff-list">
                <table class="staff-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Role</th>
                            <th>Joining Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% while (rs.next()) { %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("role") %></td>
                            <td><%= rs.getDate("join_date") %></td>
                            <td>
                                <button class="action-button edit" onclick="openModal('edit', '<%= rs.getInt("id") %>', '<%= rs.getString("name") %>', '<%= rs.getString("role") %>', '<%= rs.getDate("join_date") %>')">
                                    <i class="fas fa-edit"></i> Edit
                                </button>
                                <button class="action-button delete" onclick="deleteStaff('<%= rs.getInt("id") %>')">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

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
                <button type="submit" id="modalActionBtn"></button>
                <button type="button" onclick="closeModal()">Cancel</button>
            </form>
        </div>
    </div>

    <script>
        function openModal(type, id = "", name = "", role = "", joinDate = "") {
            document.getElementById("staffModal").style.display = "inline";
            document.getElementById("modalTitle").innerText = type === 'add' ? "Add New Staff" : "Edit Staff";
            document.getElementById("modalActionBtn").innerText = type === 'add' ? "Add" : "Save";
            document.getElementById("staffId").value = id;
            document.getElementById("staffName").value = name;
            document.getElementById("staffRole").value = role;
            document.getElementById("staffJoiningDate").value = joinDate;
        }

        function closeModal() {
            document.getElementById("staffModal").style.display = "none";
        }

        function deleteStaff(id) {
            if (confirm("Are you sure you want to delete this staff member?")) {
                window.location.href = "AllActionJSP/StaffAction.jsp?deleteId=" + id;
            }
        }
    </script>

    <script>
        setTimeout(() => {
            document.querySelector('.alert')?.remove();
        }, 3000);
    </script>

</body>
</html>
