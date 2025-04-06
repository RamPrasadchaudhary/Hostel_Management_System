<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>
<%@ include file="../templates/header.jsp" %>

<%
    request.setAttribute("title", "Complaints List");
    request.setAttribute("active", "complaints");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String searchId = request.getParameter("search-id");
    String searchDate = request.getParameter("date");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DatabaseConnection.getConnection();

        String sql = "SELECT id, student_id, name, contact, room_number, complaint_type, complaint_description, status, date_submitted FROM complaints";
        boolean hasCondition = false;

        if ((searchId != null && !searchId.trim().isEmpty()) || (searchDate != null && !searchDate.trim().isEmpty())) {
            sql += " WHERE ";
            if (searchId != null && !searchId.trim().isEmpty()) {
                sql += "id = ?";
                hasCondition = true;
            }
            if (searchDate != null && !searchDate.trim().isEmpty()) {
                if (hasCondition) sql += " AND ";
                sql += "DATE(date_submitted) = ?";
            }
        }

        ps = conn.prepareStatement(sql);

        int index = 1;
        if (searchId != null && !searchId.trim().isEmpty()) {
            ps.setInt(index++, Integer.parseInt(searchId));
        }
        if (searchDate != null && !searchDate.trim().isEmpty()) {
            ps.setDate(index++, java.sql.Date.valueOf(searchDate));
        }

        rs = ps.executeQuery();
%>

<style>
    .search-section {
        display: flex;
        gap: 40px;
        flex-wrap: wrap;
        justify-content: center;
        margin: 20px auto;
        padding: 20px;
        background-color: #f9f9f9;
        border-radius: 10px;
    }

    .search-box {
        flex: 1 1 300px;
        padding: 15px;
        border: 1px solid #ccc;
        border-radius: 8px;
        background: white;
    }

    .search-box label {
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
    }

    .search-box input {
        width: 100%;
        padding: 5px;
        border-radius: 5px;
        border: 1px solid #aaa;
        margin-bottom: 10px;
    }

    .search-box button {
        padding: 8px 16px;
        border: none;
        border-radius: 5px;
        background-color: #337ab7;
        color: white;
        cursor: pointer;
        margin-right: 10px;
    }

    .search-box button:hover {
        background-color: #23527c;
    }

    .complaints-table th, .complaints-table td {
        text-align: center;
    }

    .details-btn {
        background: #5cb85c;
        color: white;
        padding: 5px 10px;
        border-radius: 5px;
        text-decoration: none;
    }

    .details-btn:hover {
        background-color: #449d44;
    }
</style>

<section id="complaints-by-date">
    <div class="section search-bar">
        <h2><i class="fa-solid fa-filter"></i> <span class="shiny-text">Search Complaints</span></h2>
        <div class="search-section">

            <!-- Complaint ID Search -->
            <form class="search-box" method="get" action="complaints.jsp">
                <label for="search-id">Search by Complaint ID:</label>
                <input type="number" id="search-id" name="search-id" placeholder="Enter Complaint ID" value="<%= searchId != null ? searchId : "" %>">
                <button type="submit">Search</button>
                <a href="complaints.jsp"><button type="button">Reset</button></a>
            </form>
            <h3>OR</h3>

            <!-- Date Search -->
            <form class="search-box" method="get" action="complaints.jsp">
                <label for="date">Search by Date:</label>
                <input type="date" id="date" name="date" value="<%= searchDate != null ? searchDate : "" %>">
                <button type="submit">Search</button>
                <a href="complaints.jsp"><button type="button">Reset</button></a>
            </form>

        </div>
    </div>

    <div class="section complaints-list">
        <h2><i class="fa-solid fa-list"></i><span class="shiny-text">Complaints List</span></h2>
        <table class="complaints-table">
            <thead>
                <tr>
                    <th>Complaint Id</th>
                    <th>Student ID</th>
                    <th>Name</th>
                    <th>Contact</th>
                    <th>Room Number</th>
                    <th>Complaint Type</th>
                    <th>Complaint Description</th>
                    <th>Status</th>
                    <th>Date Submitted</th>
                    <th>Details</th>
                </tr>
            </thead>
            <tbody>
                <%
                    boolean found = false;
                    while(rs.next()) {
                        found = true;
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("student_id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("contact") %></td>
                    <td><%= rs.getString("room_number") %></td>
                    <td><%= rs.getString("complaint_type") %></td>
                    <td><%= rs.getString("complaint_description") %></td>
                    <td><%= rs.getString("status") %></td>
                    <td><%= rs.getDate("date_submitted") %></td>
                    <td><a href="details.jsp?complaintId=<%= rs.getString("student_id") %>" class="details-btn">View Details</a></td>
                </tr>
                <%
                    }
                    if (!found) {
                %>
                <tr>
                    <td colspan="10" style="text-align:center;">No complaints found for the given criteria.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</section>

<%
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if(rs != null) try { rs.close(); } catch(Exception e){}
        if(ps != null) try { ps.close(); } catch(Exception e){}
        if(conn != null) try { conn.close(); } catch(Exception e){}
    }
%>

<%@ include file="../templates/footer.jsp" %>
