<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="SideBar.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <!-- Adjust CSS paths as needed -->
    <link rel="stylesheet" href="Heading.css">
    <link rel="stylesheet" href="Style/setting.css">
    <script>
        // Get the context path from the server (so the URL works regardless of folder location)
        var contextPath = '<%= request.getContextPath() %>';
        console.log("Context Path: " + contextPath);

        // Toggle display of the tables
        function toggleTable(tableId) {
            const allTables = ["studentsTable", "staffTable", "adminTable"];
            allTables.forEach(function(id) {
                var table = document.getElementById(id);
                if (table) {
                    table.style.display = (id === tableId) ? "block" : "none";
                }
            });
        }

        // Function to allow a user (Student or Staff) – used when the user doesn't already have a password.
        function allowUser(id, role) {
            var contactElement = document.getElementById('contact_' + role + '_' + id);
            var contact = "";
            if (contactElement.tagName.toLowerCase() === "input") {
                contact = contactElement.value;
            } else {
                contact = contactElement.textContent;
            }
            var password = document.getElementById('password_' + role + '_' + id).value;
            if (!password) {
                alert("Please enter a password.");
                return;
            }
            // Create a temporary form to POST the data to the allow servlet.
            var form = document.createElement("form");
            form.method = "POST";
            form.action = contextPath + "/UserServlet"; // URL for allowing a user
            var inputs = [
                {name: "user_id", value: id},
                {name: "contact", value: contact},
                {name: "password", value: password},
                {name: "role", value: role}
            ];
            inputs.forEach(function(inputData) {
                var input = document.createElement("input");
                input.type = "hidden";
                input.name = inputData.name;
                input.value = inputData.value;
                form.appendChild(input);
            });
            document.body.appendChild(form);
            form.submit();
        }

        // Function to update an existing user
        function updateUser(id, role) {
            var contactElement = document.getElementById('contact_' + role + '_' + id);
            var contact = "";
            if (contactElement.tagName.toLowerCase() === "input") {
                contact = contactElement.value;
            } else {
                contact = contactElement.textContent;
            }
            var password = document.getElementById('password_' + role + '_' + id).value;
            if (!password) {
                alert("Please enter a password.");
                return;
            }
            // Create a temporary form to POST the data to the update servlet.
            var form = document.createElement("form");
            form.method = "POST";
            form.action = contextPath + "/UpdateUserServlet"; // URL for updating a user
            var inputs = [
                {name: "user_id", value: id},
                {name: "contact", value: contact},
                {name: "password", value: password},
                {name: "role", value: role}
            ];
            inputs.forEach(function(inputData) {
                var input = document.createElement("input");
                input.type = "hidden";
                input.name = inputData.name;
                input.value = inputData.value;
                form.appendChild(input);
            });
            document.body.appendChild(form);
            form.submit();
        }

        // Function to allow the Admin user (special case)
        function allowAdmin() {
            var contact = document.getElementById('contact_Admin_0').value;
            var password = document.getElementById('password_Admin_0').value;
            if (!password) {
                alert("Please enter a password.");
                return;
            }
            var form = document.createElement("form");
            form.method = "POST";
            form.action = contextPath + "/UserServlet"; // Adjust if Admin uses a different servlet
            var inputs = [
                {name: "user_id", value: 0}, // Use a specific admin ID if available
                {name: "contact", value: contact},
                {name: "password", value: password},
                {name: "role", value: "Admin"}
            ];
            inputs.forEach(function(inputData) {
                var input = document.createElement("input");
                input.type = "hidden";
                input.name = inputData.name;
                input.value = inputData.value;
                form.appendChild(input);
            });
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</head>
<body>
    <div class="heading-container">
        <h3 class="heading-title">User Management</h3>
        <p class="heading-subtitle">Assign and Update Contact and Password</p>
    </div>

    <div class="container">
        <button onclick="toggleTable('studentsTable')">Show Students</button>
        <button onclick="toggleTable('staffTable')">Show Wardens</button>
        <button onclick="toggleTable('adminTable')">Show Admin</button>
        <div id="messagebox">
            <% 
                String error = request.getParameter("error");
                String success = request.getParameter("success");
                if (error != null) { 
            %>
                <div style="color: red; font-weight: bold;"><%= error %></div>
            <% } 
               if (success != null) { 
            %>
                <div style="color: green; font-weight: bold;"><%= success %></div>
            <% } %>
        </div>
    </div>

    <!-- Student Table -->
    <div id="studentsTable" class="table-container" style="display:none;">
        <h3>Students</h3>
        <table border="1" cellpadding="5">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Contact</th>
                    <th>Password</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                  try (Connection con = DatabaseConnection.getConnection();
                       Statement stmt = con.createStatement();
                       ResultSet rs = stmt.executeQuery("SELECT s.id, s.name, s.contact, u.password FROM students s LEFT JOIN user u ON s.id = u.user_id AND u.role='Student'")) {
                      while (rs.next()) {
                          int studentId = rs.getInt("id");
                          String contact = rs.getString("contact");
                          String password = rs.getString("password");
                %>
                <tr>
                    <td><%= studentId %></td>
                    <td><%= rs.getString("name") %></td>
                    <td>
                        <% if (contact == null || contact.trim().isEmpty()) { %>
                            <input type="text" id="contact_Student_<%= studentId %>" value="">
                        <% } else { %>
                            <span id="contact_Student_<%= studentId %>"><%= contact %></span>
                        <% } %>
                    </td>
                    <td>
                        <input type="text" id="password_Student_<%= studentId %>" value="<%= (password != null) ? password : "" %>">
                    </td>
                    <td>
                        <% if (password != null && !password.trim().isEmpty()) { %>
                            <button onclick="updateUser('<%= studentId %>', 'Student')">Update</button>
                        <% } else { %>
                            <button onclick="allowUser('<%= studentId %>', 'Student')">Allow</button>
                        <% } %>
                    </td>
                </tr>
                <% 
                      }
                  } catch (Exception e) { 
                      e.printStackTrace(); 
                  } 
                %>
            </tbody>
        </table>
    </div>

    <!-- Staff Table -->
    <div id="staffTable" class="table-container" style="display:none;">
        <h3>Staff Wardens</h3>
        <table border="1" cellpadding="5">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Contact</th>
                    <th>Password</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                  try (Connection con = DatabaseConnection.getConnection();
                       Statement stmt = con.createStatement();
                       ResultSet rs = stmt.executeQuery("SELECT w.id, w.name, w.phone, u.password FROM wardens w LEFT JOIN user u ON w.id = u.user_id AND u.role='Staff'")) {
                      while (rs.next()) {
                          int staffId = rs.getInt("id");
                          String contact = rs.getString("phone");
                          String password = rs.getString("password");
                %>
                <tr>
                    <td><%= staffId %></td>
                    <td><%= rs.getString("name") %></td>
                    <td>
                        <% if (contact == null || contact.trim().isEmpty()) { %>
                            <input type="text" id="contact_Staff_<%= staffId %>" value="">
                        <% } else { %>
                            <span id="contact_Staff_<%= staffId %>"><%= contact %></span>
                        <% } %>
                    </td>
                    <td>
                        <input type="text" id="password_Staff_<%= staffId %>" value="<%= (password != null) ? password : "" %>">
                    </td>
                    <td>
                        <% if (password != null && !password.trim().isEmpty()) { %>
                            <button onclick="updateUser('<%= staffId %>', 'Staff')">Update</button>
                        <% } else { %>
                            <button onclick="allowUser('<%= staffId %>', 'Staff')">Allow</button>
                        <% } %>
                    </td>
                </tr>
                <% 
                      }
                  } catch (Exception e) { 
                      e.printStackTrace(); 
                  } 
                %>
            </tbody>
        </table>
    </div>

    <!-- Admin Table -->
    <div id="adminTable" class="table-container" style="display:none;">
        <form id="adminForm" action="<%= request.getContextPath() %>/UserServlet" method="post">
            <table border="1" cellpadding="5">
                <tr>
                    <td>ID:</td>
                    <td>
                        <input type="text" name="user_id" value="" required>
                    </td>
                </tr>
                <tr>
                    <td>Name:</td>
                    <td>
                        <input type="text" name="name" value="" required>
                    </td>
                </tr>
                <tr>
                    <td>Contact:</td>
                    <td>
                        <input type="text" name="contact" value="" required>
                    </td>
                </tr>
                <tr>
                    <td>Password:</td>
                    <td>
                        <input type="password" name="password" value="" required>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="hidden" name="role" value="Admin">
                        <button type="submit" style="padding:10px;background-color:lightblue; font-weight:bold;">Register Admin</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
       
</body>
</html>
