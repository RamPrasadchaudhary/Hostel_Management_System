<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="SideBar.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <link rel="stylesheet" href="Heading.css">
    <link rel="stylesheet" href="setting.css">
    <script src="setting.js"></script>
</head>
<body>
    <div class="heading-container">
        <h3 class="heading-title">User Management</h3>
        <p class="heading-subtitle">Assign and Update Usernames and Passwords</p>
    </div>

    <div class="container">
        <button onclick="toggleTable('studentsTable')">Show Students</button>
        <button onclick="toggleTable('staffTable')">Show Staff</button>
        <button onclick="toggleTable('adminTable')">Show Admin</button>
        
       <div id="messagebox">
        <% String error = request.getParameter("error");
           String success = request.getParameter("success"); %>

        <% if (error != null) { %>
            <div style="color: red; font-weight: bold;"><%= error %></div>
        <% } %>

        <% if (success != null) { %>
            <div style="color: green; font-weight: bold;"><%= success %></div>
        <% } %>
       </div>
    </div>

    <!-- Student Table -->
    <div id="studentsTable" class="table-container" style="display:none;">
        <h3>Students</h3>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% try (Connection con = DatabaseConnection.getConnection();
                         Statement stmt = con.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT s.id, s.name, u.username, u.password FROM students s LEFT JOIN user u ON s.id = u.user_id AND u.role='Student'") ) {
                    while (rs.next()) {
                        int studentId = rs.getInt("id");
                        String username = rs.getString("username");
                        String password = rs.getString("password"); %>
                <tr>
                    <td><%= studentId %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><input type="text" id="username_Student_<%= studentId %>" value="<%= (username != null) ? username : "" %>"></td>
                    <td><input type="password" id="password_Student_<%= studentId %>" value="<%= (password != null) ? password : "" %>"></td>
                    <td>
                        <% if (username != null) { %>
                            <button onclick="updateUser('<%= studentId %>', 'Student')">Update</button>
                        <% } else { %>
                            <button onclick="allowUser('<%= studentId %>', 'Student')">Allow</button>
                        <% } %>
                    </td>
                </tr>
                <% } } catch (Exception e) { e.printStackTrace(); } %>
            </tbody>
        </table>
    </div>

    <!-- Staff Table -->
    <div id="staffTable" class="table-container" style="display:none;">
        <h3>Staff Wardens</h3>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% try (Connection con = DatabaseConnection.getConnection();
                         Statement stmt = con.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT s.id, s.name, u.username, u.password FROM staff s LEFT JOIN user u ON s.id = u.user_id AND u.role='Staff'") ) {
                    while (rs.next()) {
                        int staffId = rs.getInt("id");
                        String username = rs.getString("username");
                        String password = rs.getString("password"); %>
                <tr>
                    <td><%= staffId %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><input type="text" id="username_Staff_<%= staffId %>" value="<%= (username != null) ? username : "" %>"></td>
                    <td><input type="password" id="password_Staff_<%= staffId %>" value="<%= (password != null) ? password : "" %>"></td>
                    <td>
                        <% if (username != null) { %>
                            <button onclick="updateUser('<%= staffId %>', 'Staff')">Update</button>
                        <% } else { %>
                            <button onclick="allowUser('<%= staffId %>', 'Staff')">Allow</button>
                        <% } %>
                    </td>
                </tr>
                <% } } catch (Exception e) { e.printStackTrace(); } %>
            </tbody>
        </table>
    </div>

    <!-- Admin Table -->
    <div id="adminTable" class="table-container" style="display:none;">
        <h3>Admin</h3>
        <table>
            <tr>
                <td>Username:</td>
                <td><input type="text" id="admin_username"></td>
                <td>Password:</td>
                <td><input type="password" id="admin_password"></td>
                <td>
                    <button onclick="allowAdmin()">Allow</button>
                </td>
            </tr>
        </table>
    </div>

    <script>
    setTimeout(function() {
        var messageBox = document.getElementById('messagebox');
        if (messageBox) {
            messageBox.style.display = 'none';
        }
    }, 5000); // 5000 milliseconds = 5 seconds
    
    function closeMessage() {
        var messageBox = document.getElementById('messagebox');
        if (messageBox) {
            messageBox.style.display = 'none';
        }
    }
</script>
</body>
</html>
