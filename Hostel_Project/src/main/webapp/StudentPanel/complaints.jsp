<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, database.DatabaseConnection" %>
<%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaints</title>
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700&display=swap">
    <link rel="stylesheet" href="complaints.css">
    <style>
        .alert {
            padding: 2px;
            width: 100%;
            background-color: #e7f3fe;
            color: #31708f;
            border: 1px solid #bce8f1;
            border-radius: 4px;
            text-align: center;
        }
        /* Style for each complaint item */
        .complaint-item {
            border: 1px solid #ccc;
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 4px;
        }
    </style>
    <script>
        // Hide the alert message after 5 seconds (5000 milliseconds)
        document.addEventListener("DOMContentLoaded", function () {
            setTimeout(function () {
                var alertBox = document.getElementById("msgAlert");
                if (alertBox) {
                    alertBox.style.display = "none";
                }
            }, 5000);
        });
    </script>
</head>
<body>
   <section id="complaints">
       <h2>Create a Complaint</h2>
       
       <%-- Display success/error message if available --%>
       <%
           String msg = request.getParameter("msg");
           if (msg != null && !msg.isEmpty()) {
       %>
       <div class="alert" id="msgAlert">
           <p><%= msg %></p>
       </div>
       <%
           }
       %>
       
       <!-- Complaint Submission Form -->
       <form id="complaint-form" method="POST" action="${pageContext.request.contextPath}/SubmitComplaintServlet">
            <label for="complaint-type">Type of Complaint:</label>
            <select id="complaint-type" name="complaint-type" required>
                <option value="plumber">Plumber Complaints</option>
                <option value="electrical">Electrician Complaints</option>
                <option value="mess">Mess Complaints</option>
                <option value="water">Water Complaints</option>
                <option value="sanitary">Sanitary Complaints</option>
                <option value="wifi">WiFi Complaints</option>
            </select>
            <label for="complaint-description">Description:</label>
            <textarea id="complaint-description" name="complaint-description" rows="5" required></textarea>
            <button type="submit">Submit</button>
            <button type="button" id="trackerButton">Track Your Complaints</button>
       </form>
       
       <%-- Dynamic Complaint Tracker Section --%>
       <%
           Connection conn = null;
           PreparedStatement stmt = null;
           ResultSet rs = null;
           String userContact = (String) session.getAttribute("username");
           try {
               conn = DatabaseConnection.getConnection();
               String query = "SELECT * FROM complaints WHERE contact = ? ORDER BY date_submitted DESC";
               stmt = conn.prepareStatement(query);
               stmt.setString(1, userContact);
               rs = stmt.executeQuery();
       %>
       <div id="trackerSection">
           <h2>Complaint Tracker</h2>
           <%
               while (rs.next()) {
                   String compType = rs.getString("complaint_type");
                   String compDesc = rs.getString("complaint_description");
                   String compStatus = rs.getString("status");
                   if (compStatus == null || compStatus.trim().isEmpty()) {
                       compStatus = "Pending";
                   }
           %>
           <div class="complaint-item">
               <h3><%= compType %></h3>
                 <p><strong>Complaint Type  :</strong> <%=compType  %></p>
               <p><strong>Description:</strong> <%= compDesc %></p>
               <p><strong>Status:</strong> <span class="status"><%= compStatus %></span></p>
           </div>
           <%
               }
           %>
       </div>
       <%
           } catch (SQLException e) {
               out.println("<p>Error fetching complaints: " + e.getMessage() + "</p>");
           } finally {
               if (rs != null) try { rs.close(); } catch (SQLException e) {}
               if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
               if (conn != null) try { conn.close(); } catch (SQLException e) {}
           }
       %>
   </section>
   
   <footer>
       <p>&copy; 2024 Hostel Management</p>
   </footer>
   
   <!-- The Modal (if needed for further features) -->
   <div id="successModal" class="modal">
       <div class="modal-content">
           <span class="close" aria-label="Close">&times;</span>
           <h2>Success!</h2>
           <p>Your complaint has been submitted successfully.</p>
       </div>
   </div>
   
   <!-- JavaScript to Toggle Tracker Section Visibility -->
   <script>
       document.addEventListener("DOMContentLoaded", function() {
           var trackerButton = document.getElementById("trackerButton");
           var trackerSection = document.getElementById("trackerSection");
           
           // Optionally, you can hide the tracker section by default:
           // trackerSection.style.display = "none";
           
           trackerButton.addEventListener("click", function() {
               if (trackerSection.style.display === "none" || trackerSection.style.display === "") {
                   trackerSection.style.display = "block";
               } else {
                   trackerSection.style.display = "none";
               }
           });
       });
   </script>
   
</body>
</html>
