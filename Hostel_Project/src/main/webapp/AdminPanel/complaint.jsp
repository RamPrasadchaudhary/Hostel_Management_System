<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="SideBar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Complaint Records</title>
    <link rel="stylesheet" href="Style/complaints.css">
    <link rel="stylesheet" href="Heading.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        .complaint-details { display: none; }
        .arrow-icon.rotate { transform: rotate(180deg); }
    </style>
</head>
<body>
<div class="heading-container">
    <h3 class="heading-title">Complaints Record</h3>
    <p class="heading-subtitle">This is the complaints page</p>
</div>

<div class="main-content">
    <div class="complaints-dashboard">
        <%
            String[] complaintTypes = {"Electrician", "Mess", "WiFi", "Water", "Sanitary", "Plumber"};

            // Map to hold categorized complaints
            Map<String, List<Map<String, String>>> categorizedComplaints = new HashMap<>();

            for (String type : complaintTypes) {
                categorizedComplaints.put(type.toLowerCase(), new ArrayList<>());
            }

            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostelproject", "root", "9821574168");

                String sql = "SELECT * FROM complaints ORDER BY date_submitted DESC";
                pst = conn.prepareStatement(sql);
                rs = pst.executeQuery();

                while (rs.next()) {
                    String type = rs.getString("complaint_type").toLowerCase();
                    if (categorizedComplaints.containsKey(type)) {
                        Map<String, String> complaint = new HashMap<>();
                        complaint.put("name", rs.getString("name"));
                        complaint.put("date", rs.getTimestamp("date_submitted").toString());
                        complaint.put("student_id", rs.getString("student_id"));
                        complaint.put("room_number", rs.getString("room_number"));
                        complaint.put("description", rs.getString("complaint_description"));
                        complaint.put("status", rs.getString("status"));
                        categorizedComplaints.get(type).add(complaint);
                    }
                }

            } catch (Exception e) {
                out.println("<p style='color:red;'>Error fetching complaints: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            }

            for (String type : complaintTypes) {
                String id = type.toLowerCase() + "-box";
        %>
        <div class="complaint-box" id="<%=id%>">
            <div class="complaint-heading" onclick="toggleComplaints('<%=id%>')">
                <h2><%=type%> Complaints</h2>
                <i class="fas fa-chevron-down arrow-icon"></i>
            </div>
            <div class="complaint-details">
                <%
                    List<Map<String, String>> complaints = categorizedComplaints.get(type.toLowerCase());
                    if (complaints.isEmpty()) {
                %>
                <p>No complaints found.</p>
                <% } else {
                    for (Map<String, String> complaint : complaints) {
                %>
                <div class="complaint">
                    <p><strong>Complaint by:</strong> <span><%=complaint.get("name")%></span></p>
                    <p><strong>Date:</strong> <span><%=complaint.get("date")%></span></p>
                    <p><strong>Student ID:</strong> <span><%=complaint.get("student_id")%></span></p>
                    <p><strong>Room Number:</strong> <span><%=complaint.get("room_number")%></span></p>
                    <p><strong>Description:</strong> <span><%=complaint.get("description")%></span></p>
                    <p><strong>Status:</strong> <span class="status <%=complaint.get("status").toLowerCase()%>"><%=complaint.get("status")%></span></p>
                    <button class="view-details-btn">View Details</button>
                </div>
                <% } } %>
            </div>
        </div>
        <% } %>
    </div>
</div>

<script>
    function toggleComplaints(boxId) {
        const box = document.getElementById(boxId);
        const details = box.querySelector('.complaint-details');
        const arrowIcon = box.querySelector('.arrow-icon');
        if (details.style.display === 'block') {
            details.style.display = 'none';
            arrowIcon.classList.remove('rotate');
        } else {
            details.style.display = 'block';
            arrowIcon.classList.add('rotate');
        }
    }
</script>
</body>
</html>
