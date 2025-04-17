<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="SideBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Payment</title>
    <link rel="stylesheet" href="Style/PaymentForm.css">
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
    }

    .form-container {
        max-width: 450px;
        margin: 50px auto;
        background-color: white;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #333;
    }

    label {
        display: block;
        margin-top: 15px;
        color: #444;
        font-weight: bold;
    }

    input[type="text"], input[type="number"] {
        width: 100%;
        padding: 10px;
        margin-top: 6px;
        border: 1px solid #ccc;
        border-radius: 6px;
    }

    input[type="submit"] {
        margin-top: 20px;
        width: 100%;
        background-color: #28a745;
        color: white;
        padding: 12px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 16px;
    }

    input[type="submit"]:hover {
        background-color: #218838;
    }
    </style>
</head>
<body>

<%
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        double dueAmount = Double.parseDouble(request.getParameter("dueAmount"));
        double paidAmount = Double.parseDouble(request.getParameter("paidAmount"));
        String remarks = request.getParameter("remarks");
        double remaining = dueAmount - paidAmount;

        Connection conn = null;
        PreparedStatement ps = null;
        PreparedStatement psUpdateVerified = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostelproject", "root", "9821574168");

            // Insert into updated_payments
            String sql = "INSERT INTO updated_payments (student_id, due_amount, paid_amount, remaining_amount, last_payment_date, remarks) VALUES (?, ?, ?, ?, NOW(), ?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setDouble(2, dueAmount);
            ps.setDouble(3, paidAmount);
            ps.setDouble(4, remaining);
            ps.setString(5, remarks);
            int result = ps.executeUpdate();

            // Update verified status in student_payments
            String updateStatusSql = "UPDATE student_payments SET status = 'Verified' WHERE student_id = ?";
            psUpdateVerified = conn.prepareStatement(updateStatusSql);
            psUpdateVerified.setInt(1, studentId);
            psUpdateVerified.executeUpdate();

            if (result > 0) {
                message = "Payment updated and verified successfully!";
            } else {
                message = "Payment update failed!";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            if (ps != null) ps.close();
            if (psUpdateVerified != null) psUpdateVerified.close();
            if (conn != null) conn.close();
        }
    }
%>

<div class="form-container">
    <h2>Update Payment Details</h2>
    <% if (!message.isEmpty()) { %>
        <p style="color: green;"><%= message %></p>
    <% } %>
    <form method="post" action="">
        <label>Student ID:</label>
        <input type="text" name="studentId" value="<%= request.getParameter("studentId") != null ? request.getParameter("studentId") : "" %>" readonly required>

        <label>Due Amount:</label>
        <input type="number" name="dueAmount" required>

        <label>Paid Amount:</label>
        <input type="number" name="paidAmount" required>

        <label>Remarks:</label>
        <input type="text" name="remarks">

        <input type="submit" value="Update Payment">
    </form>
</div>
</body>
</html>
