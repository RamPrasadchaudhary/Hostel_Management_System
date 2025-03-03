<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>
<%@ include file="SideBar.jsp" %> <!-- Sidebar Included -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Wardens</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="Heading.css"> <!-- Link to CSS -->
    <link rel="stylesheet" href="Style/Warden.css">
    <style>
        .message {
            padding: 10px;
            margin: 10px 0;
            text-align: center;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
           
        }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>

<div class="heading-container">
    <h3 class="heading-title">Warden Record</h3>
    <p class="heading-subtitle">This is Warden Record</p>
</div>

<div class="manage-wardens">
 <%-- Display Messages --%>
    <% String message = (String) session.getAttribute("message");
       String messageType = (String) session.getAttribute("messageType");
       session.removeAttribute("message");
       session.removeAttribute("messageType");
    %>
    <% if (message != null) { %>
        <div id="messageBox" class="message <%= messageType.equals("success") ? "success" : "error" %>">
            <%= message %>
        </div>
    <% } %>
    <button class="add-warden-btn" onclick="openModal('add')">Add New Warden</button>
    <div class="warden-list">
        <%
            Connection conn = DatabaseConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM wardens");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
        %>
        <div class="warden-card">
            <h3>Warden <%= rs.getInt("id") %></h3>
            <p><strong>Name:</strong> <%= rs.getString("name") %></p>
            <p><strong>Email:</strong> <%= rs.getString("contact") %></p>
            <p><strong>Phone:</strong> <%= rs.getString("phone") %></p>
            <p><strong>Address:</strong> <%= rs.getString("address") %></p>
            <p><strong>Salary:</strong> <%= rs.getString("salary") %></p>
            <p><strong>Joining Date:</strong> <%= rs.getString("date") %></p>
            <div class="warden-buttons">
                <button class="edit-btn" onclick="openModal('edit', <%= rs.getInt("id") %>, '<%= rs.getString("name") %>', '<%= rs.getString("contact") %>', '<%= rs.getString("phone") %>', '<%= rs.getString("address") %>', '<%= rs.getString("salary") %>', '<%= rs.getString("date") %>')">Edit</button>
                <form action="AllActionJSP/WardenAction.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <button type="submit" class="remove-btn" onclick="return confirm('Are you sure you want to delete this warden?')">Remove</button>
                </form>
            </div>
        </div>
        <% } rs.close(); ps.close(); conn.close(); %>
    </div>
</div>

<!-- Modal -->
<div id="wardenModal" class="modal">
    <div class="modal-content">
        <h3 id="modalTitle"></h3>
        <form id="wardenForm" action="AllActionJSP/WardenAction.jsp" method="post">
            <input type="hidden" name="action" id="modalAction">
            <input type="hidden" name="id" id="wardenId">

            <div class="form-group">
                <label>Name:</label>
                <input type="text" name="name" id="wardenName" required>
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="contact" id="wardenContact" required>
            </div>
            <div class="form-group">
                <label>Phone:</label>
                <input type="text" name="phone" id="wardenPhone" required>
            </div>
            <div class="form-group">
                <label>Address:</label>
                <input type="text" name="address" id="wardenAddress" required>
            </div>
            <div class="form-group">
                <label>Salary:</label>
                <input type="number" name="salary" id="wardenSalary" required>
            </div>
            <div class="form-group">
                <label>Joining Date:</label>
                <input type="date" name="date" id="wardenDate" required>
            </div>
            <div class="modal-buttons">
                <button type="submit" class="add-btn">Save</button>
                <button type="button" class="cancel-btn" onclick="closeModal()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openModal(mode, id = '', name = '', contact = '', phone = '', address = '', salary = '', date = '') {
        document.getElementById('wardenModal').style.display = 'flex';
        document.getElementById('modalTitle').textContent = mode === 'add' ? 'Add New Warden' : 'Edit Warden';
        document.getElementById('modalAction').value = mode;
        document.getElementById('wardenId').value = id;
        document.getElementById('wardenName').value = name;
        document.getElementById('wardenContact').value = contact;
        document.getElementById('wardenPhone').value = phone;
        document.getElementById('wardenAddress').value = address;
        document.getElementById('wardenSalary').value = salary;
        document.getElementById('wardenDate').value = date;
    }

    function closeModal() {
        document.getElementById('wardenModal').style.display = 'none';
    }

    setTimeout(function() {
        let messageBox = document.getElementById('messageBox');
        if (messageBox) {
            messageBox.style.display = 'none';
        }
    }, 5000);
</script>

</body>
</html>
