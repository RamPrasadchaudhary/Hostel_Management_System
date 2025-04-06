<%@include file="../templates/header.jsp"%>
<%@page import="database.DatabaseConnection, java.sql.*, java.util.List, java.util.ArrayList" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }

    // Profile variables
    String name = "N/A";
    String position = "Warden";
    String email = "N/A";
    String address = "N/A";
    String phone = "N/A";
    String salary = "N/A";

    // Complaint summary variables
    int resolvedCount = 0, pendingCount = 0, progressCount = 0, totalCount = 0;
    List<String[]> recentComplaints = new ArrayList<>();

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DatabaseConnection.getConnection();

        // Get Warden Profile
        String sql = "SELECT name, contact, phone, address, salary FROM wardens WHERE phone = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("contact");
            phone = rs.getString("phone");
            address = rs.getString("address");
            salary = rs.getString("salary");
        }
        rs.close();
        pstmt.close();

        // Get Complaint Summary
        String summarySql = "SELECT status, COUNT(*) as count FROM complaints GROUP BY status";
        pstmt = conn.prepareStatement(summarySql);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            String status = rs.getString("status");
            int count = rs.getInt("count");
            totalCount += count;
            if ("Resolved".equalsIgnoreCase(status)) resolvedCount = count;
            else if ("Pending".equalsIgnoreCase(status)) pendingCount = count;
            else if ("In Progress".equalsIgnoreCase(status)) progressCount = count;
        }
        rs.close();
        pstmt.close();

        // Get Recent Complaints (limit 3)
        String recentSql = "SELECT complaint_id, room, status, date, time FROM complaints ORDER BY date DESC, time DESC LIMIT 3";
        pstmt = conn.prepareStatement(recentSql);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            String[] complaint = new String[5];
            complaint[0] = rs.getString("complaint_id");
            complaint[1] = rs.getString("room");
            complaint[2] = rs.getString("status");
            complaint[3] = rs.getString("date");
            complaint[4] = rs.getString("time");
            recentComplaints.add(complaint);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>

<section id="dashboard">
    <div class="section warden-summary">
        <form action="${pageContext.request.contextPath}/LogoutServlet" method="get">
            <input type="submit" class="logout-btn" value="Logout">
        </form>

        <h2><i class="fa-solid fa-user"></i><span class="shiny-text">Warden Profile</span></h2>
        <div class="profile-pic">
            <img src="../assets/img/ux.jpg" alt="Warden Picture">
        </div>
        <div style="align-items:left">
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Position:</strong> <%= position %></p>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Phone Number:</strong> <%= phone %></p>
            <p><strong>Address:</strong> <%= address %></p>
            <p><strong>Salary:</strong> <%= salary %></p>
        </div>
    </div>

    <div class="section complaint-summary">
        <h2><i class="fa-solid fa-clipboard-list"></i><span class="shiny-text">Complaint Overview</span></h2>
        <table class="overview-table">
            <thead>
                <tr>
                    <th>Status</th>
                    <th>Count</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Resolved</td>
                    <td class="status-resolved"><%= resolvedCount %></td>
                </tr>
                <tr>
                    <td>In Progress</td>
                    <td class="status-in-progress"><%= progressCount %></td>
                </tr>
                <tr>
                    <td>Pending</td>
                    <td class="status-pending"><%= pendingCount %></td>
                </tr>
                <tr>
                    <td>Total Complaints</td>
                    <td><%= totalCount %></td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="section recent-complaints">
        <h2><i class="fa-solid fa-clock"></i><span class="shiny-text">Recent Complaints</span></h2>
        <table class="complaints-table">
            <thead>
                <tr>
                    <th>Complaint ID</th>
                    <th>Room</th>
                    <th>Status</th>
                    <th>Date</th>
                    <th>Time</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (String[] c : recentComplaints) {
                        String statusClass = "";
                        if ("Resolved".equalsIgnoreCase(c[2])) statusClass = "status-resolved";
                        else if ("Pending".equalsIgnoreCase(c[2])) statusClass = "status-pending";
                        else if ("In Progress".equalsIgnoreCase(c[2])) statusClass = "status-in-progress";
                %>
                <tr>
                    <td><%= c[0] %></td>
                    <td><%= c[1] %></td>
                    <td class="<%= statusClass %>"><%= c[2] %></td>
                    <td><%= c[3] %></td>
                    <td><%= c[4] %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</section>

<%@include file="../templates/footer.jsp"%>
