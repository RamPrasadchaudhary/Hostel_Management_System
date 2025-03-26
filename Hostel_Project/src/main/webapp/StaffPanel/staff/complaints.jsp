<%@include file="../templates/header.jsp"%>
<%
    request.setAttribute("title", "Complaints List");
    request.setAttribute("active", "complaints");
%>

<section id="complaints-by-date">
    <div class="section date-selector search-bar">
        <h2><i class="fa-solid fa-calendar-day"></i><span class="shiny-text">Select Date</span></h2>
        <form id="date-form" style="display:inline;gap:10%;justfy-content:center;">
            <label for="date">Choose a date:</label><br>
            <input type="date" id="date" style="width:70%;" name="date">
            <button type="button" id="search-date-btn">View Complaints</button>
            <button type="button" id="reset-date-btn">Reset</button>
        </form>
    </div>

    <div class="section search-bar ">
        <h2><i class="fa-solid fa-search"></i><span class="shiny-text">Search by ID</span></h2>
        <div id="search-area">
            <label for="search-id">Complaint ID:</label>
            <input type="number" id="search-id" name="search-id" placeholder="Enter Complaint ID" min="0">
            <button id="search-btn">Search</button>
            <button id="reset-btn">Reset</button>
        </div>
    </div>

    <div class="section complaints-list">
        <h2><i class="fa-solid fa-list"></i><span class="shiny-text">Complaints List</span></h2>
        <table class="complaints-table">
            <thead>
                <tr>
                    <th>Complaint ID</th>
                    <th>Room</th>
                    <th>Status</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Details</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>201</td>
                    <td>Room 101</td>
                    <td class="status-pending">Pending</td>
                    <td>2024-08-26</td>
                    <td>09:30 AM</td>
                    <td><a href="details.jsp?complaintId=201" class="details-btn">View Details</a></td>
                </tr>
                <tr>
                    <td>202</td>
                    <td>Room 102</td>
                    <td class="status-resolved">Resolved</td>
                    <td>2024-08-25</td>
                    <td>11:00 AM</td>
                    <td><a href="details.jsp?complaintId=202" class="details-btn">View Details</a></td>
                </tr>
                <tr>
                    <td>203</td>
                    <td>Room 103</td>
                    <td class="status-in-progress">In Progress</td>
                    <td>2024-08-24</td>
                    <td>02:15 PM</td>
                    <td><a href="details.jsp?complaintId=203" class="details-btn">View Details</a></td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="pagination">
        <button id="prev-page">Previous</button>
        <span>Page <input type="number" id="page-number" value="1" min="1" max="10"> of 10</span>
        <button id="next-page">Next</button>
    </div>
</section>

<%@include file="../templates/footer.jsp"%>