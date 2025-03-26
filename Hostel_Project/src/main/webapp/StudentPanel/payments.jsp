<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, database.DatabaseConnection" %>
<%@ include file="Header.jsp" %>
<%
    // Retrieve student contact from session; if not found, redirect to login.
    String contact = (String) session.getAttribute("username");
    if (session.getAttribute("username") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    
    
    // Initialize database resources
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    try {
        conn = DatabaseConnection.getConnection();
        String sql = "SELECT * FROM student_payments WHERE contact = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, contact);
        rs = stmt.executeQuery();
    } catch (Exception e) {
        out.println("<p>Error retrieving payment records: " + e.getMessage() + "</p>");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Monthly Dues</title>
  <link rel="icon" href="./Components/Images/img.png" type="image/png">
  <!-- Google Fonts & Font Awesome -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700&display=swap">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
  <!-- External CSS file if any -->
<link rel="stylesheet" href="payments.css">

  
  <script>
      // Automatically hide the alert message after 5 seconds
      document.addEventListener("DOMContentLoaded", function () {
          setTimeout(function () {
              let alertBox = document.getElementById("alertMessage");
              if (alertBox) {
                  alertBox.style.display = "none";
              }
          }, 5000);
      });
  </script>
  
 
</head>
<body>
  <section id="payments">
    <h2>Monthly Dues</h2>
    
    <!-- Alert message if available -->
    <% if (request.getParameter("msg") != null) { %>
        <div id="alertMessage" class="alert"><%= request.getParameter("msg") %></div>
    <% } %>
    
    <!-- Button to open the modal payment form -->
    <button id="openModal" class="pay-btn">Pay Now</button>
    
    <!-- Payment Records Table -->
    <table>
        <thead>

            <tr>
                <th>Student Name</th>
                <th>Contact</th>
                <th>Room No</th>
                <th>Month</th>
                <th>Payment Details</th>
                <th>Status</th>
                <th>Receipt</th>
            </tr>
        </thead>
        <tbody>
            <% 
                if (rs != null) {
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("student_name") %></td>
                <td><%= rs.getString("contact") %></td>
                <td><%= rs.getString("room_number") %></td>
                <td><%= rs.getString("month") %></td>
                <td><%= rs.getString("payment_details") %></td>
                <td><%= rs.getString("status") %></td>
                <td>
                    <a href="<%= request.getContextPath() + "/" + rs.getString("receipt_file") %>" target="_blank">View</a>
                </td>
            </tr>
            <%      } // end while
                  } // end if
            %>
        </tbody>
    </table>
  </section>
  
  <!-- Modal for Payment Submission Form -->
  <div id="paymentModal" class="modal">
    <div class="modal-content">
      <span class="close" id="closeModal">&times;</span>
      <h2>Submit Payment</h2>
      <form action="${pageContext.request.contextPath}/SubmitPaymentServlet" method="post" enctype="multipart/form-data">
        <label>Contact:</label>
        <!-- Pre-fill the contact field using session value (read-only) -->
        <input type="text" name="contact" value="<%= contact %>" readonly />
        
        <label>Payment Details:</label>
        <input type="text" name="payment_details" placeholder="Enter payment info" required />
        
        <label>Month:</label>
        <select name="month" required>
          <option value="">--Select Month--</option>
          <option value="January">January</option>
          <option value="February">February</option>
          <option value="March">March</option>
          <option value="April">April</option>
          <option value="May">May</option>
          <option value="June">June</option>
          <option value="July">July</option>
          <option value="August">August</option>
          <option value="September">September</option>
          <option value="October">October</option>
          <option value="November">November</option>
          <option value="December">December</option>
        </select>
        
        <label>Payment Receipt:</label>
        <input type="file" name="payment_receipt" accept="image/*,application/pdf" required />
        
        <input type="submit" value="Submit Payment" class="submit-btn" />
      </form>
    </div>
  </div>
  
  <script>
    // Modal functionality: open and close the payment form
    var modal = document.getElementById("paymentModal");
    var openBtn = document.getElementById("openModal");
    var closeBtn = document.getElementById("closeModal");
    
    openBtn.onclick = function() {
      modal.style.display = "block";
    }
    
    closeBtn.onclick = function() {
      modal.style.display = "none";
    }
    
    window.onclick = function(event) {
      if (event.target == modal) {
        modal.style.display = "none";
      }
    }
  </script>
</body>
</html>
<%
    // Clean up database resources
    if (rs != null) rs.close();
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
%>
