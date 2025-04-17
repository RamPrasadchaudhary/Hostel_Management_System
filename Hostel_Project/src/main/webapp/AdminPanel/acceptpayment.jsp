<%@ page import="java.sql.*" %>

<%@ include file="SideBar.jsp" %>
<%
    String studentId = request.getParameter("studentId");
    String message = "";
    String dueAmount = "", paidAmount = "", paymentDate = "";

    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostelproject", "root", "9821574168");

        // Fetch current payment info
        String fetchSql = "SELECT payment_details, payment_date FROM student_payments WHERE student_id = ?";
        pst = conn.prepareStatement(fetchSql);
        pst.setString(1, studentId);
        rs = pst.executeQuery();

        if (rs.next()) {
            String paymentDetails = rs.getString("payment_details");
            paymentDate = rs.getString("payment_date");

            if (paymentDetails != null && paymentDetails.contains("/")) {
                String[] parts = paymentDetails.split("/");
                dueAmount = parts[0];
                paidAmount = parts[1];
            }
        }

        rs.close();
        pst.close();

        // On form submit
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String newDue = request.getParameter("due");
            String newPaid = request.getParameter("paid");

            String updatedDetails = newDue + "/" + newPaid;

            String updateSql = "UPDATE student_payments SET payment_details = ?, payment_date = NOW() WHERE student_id = ?";
            pst = conn.prepareStatement(updateSql);
            pst.setString(1, updatedDetails);
            pst.setString(2, studentId);
            int updated = pst.executeUpdate();

            if (updated > 0) {
                message = "Payment updated successfully!";
                dueAmount = newDue;
                paidAmount = newPaid;
                paymentDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
            } else {
                message = "Payment update failed!";
            }
        }

    } catch (Exception e) {
        message = "Error: " + e.getMessage();
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (conn != null) conn.close();
    }

    int remaining = 0;
    try {
        if (dueAmount != null && !dueAmount.isEmpty() && paidAmount != null && !paidAmount.isEmpty()) {
            remaining = Integer.parseInt(dueAmount) - Integer.parseInt(paidAmount);
        }
    } catch (NumberFormatException e) {
        remaining = 0;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Accept Payment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 30px;
        }
        .container {
            width: 600px;
            margin: auto;
            background: #fff;
            padding: 30px;
            box-shadow: 0 0 12px rgba(0,0,0,0.2);
            border-radius: 12px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .message {
            text-align: center;
            font-weight: bold;
            color: green;
        }
        .receipt, form {
            margin-top: 20px;
        }
        .receipt p, label {
            margin: 10px 0;
            font-size: 16px;
        }
        input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background: #007bff;
            color: white;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Accept Payment for Student ID: <%= studentId %></h2>

<% if (message != null && !message.trim().isEmpty()) { %>
    <div class="message"><%= message %></div>
<% } %>

    <div class="receipt">
        <h3>Payment Receipt</h3>
        <p><strong>Due Amount:</strong> <%= dueAmount %></p>
        <p><strong>Paid Amount:</strong> <%= paidAmount %></p>
        <p><strong>Remaining:</strong> <%= remaining %></p>
        <p><strong>Last Payment Date:</strong> <%= paymentDate %></p>
    </div>

    <form method="post">
        <h3>Update Payment</h3>
        <label>New Due Amount:</label>
        <input type="text" name="due" value="<%= dueAmount %>" required>

        <label>New Paid Amount:</label>
        <input type="text" name="paid" value="<%= paidAmount %>" required>

        <input type="submit" value="Update Payment">
    </form>
</div>
</body>
</html>
