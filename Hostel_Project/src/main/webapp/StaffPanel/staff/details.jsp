<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>
<%@ include file="../templates/header.jsp" %>
<head>
    <link rel="stylesheet" type="text/css" href="../assets/css/complaint-details.css">
</head>

<%
    request.setAttribute("title", "Complaint Details");
    String message = request.getParameter("msg");
    String complaintId = request.getParameter("complaintId");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String studentId = "";
    String name = "";
    String contact = "";
    String roomNumber = "";
    String complaintType = "";
    String complaintDescription = "";
    String status = "";
    Date dateSubmitted = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DatabaseConnection.getConnection();
        String sql = "SELECT student_id, name, contact, room_number, complaint_type, complaint_description, status, date_submitted FROM complaints WHERE student_id = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, complaintId);
        rs = ps.executeQuery();

        if(rs.next()){
            studentId = rs.getString("student_id");
            name = rs.getString("name");
            contact = rs.getString("contact");
            roomNumber = rs.getString("room_number");
            complaintType = rs.getString("complaint_type");
            complaintDescription = rs.getString("complaint_description");
            status = rs.getString("status");
            dateSubmitted = rs.getDate("date_submitted");
        } else {
            out.println("No complaint found with the provided ID.");
        }
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if(rs != null) try { rs.close(); } catch(Exception e){}
        if(ps != null) try { ps.close(); } catch(Exception e){}
        if(conn != null) try { conn.close(); } catch(Exception e){}
    }
%>

<section id="complaint-details">
    <div class="back-to-list">
        <a href="complaints.jsp" class="btn">Back to Complaints List</a>
    </div>
    
    <!-- Display update message if present -->
    <% if(message != null && !message.trim().isEmpty()){ %>
    <div id="updateMessage" class="update-message">
        <p><%= message %></p>
    </div>
    <% } %>

    <div class="complaint-info">
        <h2><i class="fa-solid fa-clipboard-list"></i> Complaint Information</h2>
        <p><strong>Complaint ID:</strong> <%= studentId %></p>
        <p><strong>Complaint Type:</strong> <%= complaintType %></p>
        <p><strong>Date Filed:</strong> <%= dateSubmitted %></p>
        <p>
            <strong>Status:</strong>
            <span id="complaint-status" class="status-In-Progress"><%= status %></span>
        </p>
    </div>

    <div class="student-info">
        <h2><i class="fa-solid fa-user"></i> Student Information</h2>
        <p><strong>Name:</strong> <%= name %></p>
        <p><strong>Room Number:</strong> <%= roomNumber %></p>
        <p><strong>Contact:</strong> <%= contact %></p>
    </div>

    <div class="complaint-description">
        <h2><i class="fa-solid fa-file-alt"></i> Complaint Description</h2>
        <p><%= complaintDescription %></p>
    </div>

    <div class="actions">
        <!-- Mark as Resolved -->
        <form action="updateComplaint.jsp" method="post" style="display:inline;">
            <input type="hidden" name="complaintId" value="<%= studentId %>">
            <input type="hidden" name="status" value="Resolved">
            <button type="submit" class="btn resolve-btn">
                <i class="fa-solid fa-check-circle"></i> Mark as Resolved
            </button>
        </form>

        <!-- Mark as Pending -->
        <form action="updateComplaint.jsp" method="post" style="display:inline;">
            <input type="hidden" name="complaintId" value="<%= studentId %>">
            <input type="hidden" name="status" value="Pending">
            <button type="submit" class="btn pending-btn">
                <i class="fa-solid fa-hourglass-half"></i> Mark as Pending
            </button>
        </form>

        <!-- Mark as In Progress -->
        <form action="updateComplaint.jsp" method="post" style="display:inline;">
            <input type="hidden" name="complaintId" value="<%= studentId %>">
            <input type="hidden" name="status" value="In Progress">
            <button type="submit" class="btn progress-btn">
                <i class="fa-solid fa-spinner"></i> Mark as In Progress
            </button>
        </form>
    </div>
</section>

<!-- Message fade out script -->
<script>
    setTimeout(function() {
        var messageDiv = document.getElementById("updateMessage");
        if (messageDiv) {
            messageDiv.style.opacity = "0";
            setTimeout(function() {
                messageDiv.style.display = "none";
            }, 1000);
        }
    }, 10000);
</script>

<%@ include file="../templates/footer.jsp" %>
