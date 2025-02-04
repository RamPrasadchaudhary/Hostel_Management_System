<%@include file="../templates/header.jsp"%>
<%
    request.setAttribute("title", "Staff Dashboard");
    request.setAttribute("active", "dashboard");
%>

<section id="dashboard">
    <div class="section staff-summary">
        <a href="../login.jsp" class="logout-btn">Logout</a>
        <h2><i class="fa-solid fa-user"></i><span class="shiny-text">Staff Profile</span></h2>
        <div class="profile-pic">
            <img src="${pageContext.request.contextPath}/assets/img/ux.jpeg" alt="Electrician Picture">
        </div>
        <p><strong>Name:</strong> Rahul Bhurtel</p>
        <p><strong>Position:</strong> Student</p>
        <p><strong>Email:</strong> bhurtel@hostel.com</p>
        <p><strong>Phone Number:</strong> 9876543210</p>
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
                    <td class="status-resolved">30</td>
                </tr>
                <tr>
                    <td>In Progress</td>
                    <td class="status-in-progress">10</td>
                </tr>
                <tr>
                    <td>Pending</td>
                    <td class="status-pending">10</td>
                </tr>
                <tr>
                    <td>Total Complaints</td>
                    <td>50</td>
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
                <tr>
                    <td>101</td>
                    <td>Room 304</td>
                    <td class="status-in-progress">In Progress</td>
                    <td>2024-08-25</td>
                    <td>10:30 AM</td>
                </tr>
                <tr>
                    <td>102</td>
                    <td>Room 516</td>
                    <td class="status-pending">Pending</td>
                    <td>2024-08-24</td>
                    <td>12:45 PM</td>
                </tr>
                <tr>
                    <td>103</td>
                    <td>Room 210</td>
                    <td class="status-resolved">Resolved</td>
                    <td>2024-08-23</td>
                    <td>02:00 PM</td>
                </tr>
            </tbody>
        </table>
    </div>
</section>

<%@include file="../templates/footer.jsp"%>