<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="SideBar.jsp" %> <!-- Sidebar Included -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Payments</title>
    <link rel="stylesheet" href="Style/Payment.css">
    <link rel="stylesheet" href="Heading.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<div class="heading-container">
    <h3 class="heading-title">Payment Record</h3>
    <p class="heading-subtitle">This is the Payment page</p>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="payment-table">
        <table>
            <thead>
            <tr>
                <th>Student ID</th>
                <th>Name</th>
                <th>Due Amount</th>
                <th>Paid Amount</th>
                <th>Remaining Amount</th>
                <th>Last Payment Date</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <%
                Connection conn = null;
                PreparedStatement pst = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostelproject", "root", "9821574168");

                    String sql = "SELECT sp.student_id, sp.student_name, up.due_amount, up.paid_amount, up.remaining_amount, up.last_payment_date, sp.status " +
                                 "FROM student_payments sp " +
                                 "LEFT JOIN (SELECT * FROM updated_payments up1 WHERE (student_id, last_payment_date) IN " +
                                            "(SELECT student_id, MAX(last_payment_date) FROM updated_payments GROUP BY student_id)) up " +
                                 "ON sp.student_id = up.student_id " +
                                 "ORDER BY up.last_payment_date DESC";

                    pst = conn.prepareStatement(sql);
                    rs = pst.executeQuery();

                    while (rs.next()) {
                        int studentId = rs.getInt("student_id");
                        String name = rs.getString("student_name");
                        double due = rs.getDouble("due_amount");
                        double paid = rs.getDouble("paid_amount");
                        double remaining = rs.getDouble("remaining_amount");
                        String lastDate = rs.getString("last_payment_date");
                        String verified = rs.getString("status");
            %>
            <tr>
                <td><%= studentId %></td>
                <td><%= name %></td>
                <td>₹<%= due %></td>
                <td>₹<%= paid %></td>
                <td>₹<%= remaining %></td>
                <td><%= lastDate != null ? lastDate : "N/A" %></td>
                <td><%= verified != null ? verified : "Not Verified" %></td>
                <td>
                    <a href="updatepayment.jsp?studentId=<%= studentId %>" class="update-button">Update</a>
                    <a href="acceptpayment.jsp?studentId=<%= studentId %>" class="accept-button">Accept Payment</a>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='8' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                    if (conn != null) conn.close();
                }
            %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
