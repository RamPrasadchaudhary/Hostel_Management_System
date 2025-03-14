<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, database.DatabaseConnection" %>
<%@ include file="Header.jsp" %>

<%
    Connection conn = DatabaseConnection.getConnection();
    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM student_payments WHERE contact = ?");
    stmt.setString(1, (String) session.getAttribute("contact"));
    ResultSet rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Monthly Dues</title>
  <link rel="icon" href="./Components/Images/img.png" type="image/png">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700&display=swap">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
  <link rel="stylesheet" href="payments.css">
   <script>
        // JavaScript to remove the message after 5 seconds
        document.addEventListener("DOMContentLoaded", function () {
            setTimeout(function () {
                let alertBox = document.getElementById("alertMessage");
                if (alertBox) {
                    alertBox.style.display = "none";
                }
            }, 5000);
        });
    </script>
  <style>
    /* Modal container styling */
    .modal {
      display: none; /* Hidden by default */
      position: fixed;
      z-index: 1000;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0, 0, 0, 0.5); /* Black background with opacity */
    }
    /* Modal content box styling */
    .modal-content {
      background-color: #fefefe;
      margin: 10% auto; /* Centered vertically with some margin from top */
      padding: 20px;
      border: 1px solid #888;
      width: 50%;
      position: relative;
    }
    /* Close button styling */
    .close {
      position: absolute;
      right: 10px;
      top: 10px;
      font-size: 28px;
      font-weight: bold;
      cursor: pointer;
    }
    /* Message alert styling */
    .alert {
      padding: 10px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      background-color: #f8f8f8;
      text-align: center;
      font-size: 16px;
    }
  </style>
</head>
<body>
  <section id="payments">
    <h2>Monthly Dues</h2>
    
    <c:if test="${not empty param.msg}">
        <div id="alertMessage" class="alert">${param.msg}</div>
    </c:if>
    
    <!-- Existing dues table -->
     <div class="total-balance">
      <!-- Clicking this button opens the modal payment form -->
      <button id="openModal" class="button">Pay Now</button>
    </div>
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
            <% while (rs.next()) { %>
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
            <% } %>
        </tbody>
    </table>
 
  </section>
  
  <!-- Modal for Payment Form -->
  <div id="paymentModal" class="modal">
    <div class="modal-content">
      <span class="close" id="closeModal">&times;</span>
      <h2>Submit Payment</h2>
      <form action="${pageContext.request.contextPath}/SubmitPaymentServlet" method="post" enctype="multipart/form-data">
        <table>
          <tr>
            <td>Contact:</td>
            <td><input type="text" name="contact" required /></td>
          </tr>
          <tr>
            <td>Payment Details:</td>
            <td><input type="text" name="payment_details" placeholder="Enter payment info" required /></td>
          </tr>
           <tr>
            <td>Month:</td>
            <td><input type="text" name="month" placeholder="Monthly Fee" required /></td>
          </tr>
          <tr>
            <td>Payment Receipt:</td>
            <td>
              <input type="file" name="payment_receipt" accept="image/*,application/pdf" required />
            </td>
          </tr>
          <tr>
            <td colspan="2">
              <input type="submit" value="Submit Payment" />
            </td>
          </tr>
        </table>
      </form>
    </div>
  </div>
  

  <script>
    // Modal functionality
    var modal = document.getElementById("paymentModal");
    var btn = document.getElementById("openModal");
    var closeBtn = document.getElementById("closeModal");

    btn.onclick = function() {
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
