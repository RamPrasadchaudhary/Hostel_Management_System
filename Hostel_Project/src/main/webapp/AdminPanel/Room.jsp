	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ page import="java.sql.*" %>
	<%@ include file="SideBar.jsp" %>
	<%@ page import="database.DatabaseConnection" %>
	<!DOCTYPE html>
	<html lang="en">
	<head>
	  <meta charset="UTF-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1.0">
	  <title>Room Management</title>
	<link rel="stylesheet" href="Style/room.css">

	    <link rel="stylesheet" href="Heading.css">
	  <script>
	    // Open modal in allocation (insert) mode
	    function openModal(roomNumber) {
	      document.getElementById('allocateModal').style.display = 'flex';
	      document.getElementById('roomNumberInput').value = roomNumber;
	      document.getElementById('mode').value = "allocate";
	      document.getElementById('allocationStudentDiv').style.display = 'block';
	      document.getElementById('updateStudentDiv').style.display = 'none';
	      // Clear any previous selection
	      document.getElementById('allocationDateInput').value = "";
	    }
	    // Open modal in update mode; pre-fill with existing data
	    // allocationDate must be in YYYY-MM-DD format.
	    function openUpdateModal(studentId, roomNumber, allocationDate, studentName) {
	      document.getElementById('allocateModal').style.display = 'flex';
	      document.getElementById('roomNumberInput').value = roomNumber;
	      document.getElementById('allocationDateInput').value = allocationDate;
	      document.getElementById('mode').value = "update";
	      document.getElementById('updateStudentId').value = studentId;
	      // Hide dropdown and show student name label
	      document.getElementById('allocationStudentDiv').style.display = 'none';
	      document.getElementById('updateStudentDiv').style.display = 'block';
	      document.getElementById('updateStudentLabel').innerHTML = studentName;
	    }
	    // Open the Add Room modal
	    function openAddRoomModal() {
	      document.getElementById('addRoomModal').style.display = 'flex';
	      document.getElementById('newRoomInput').value = "";
	    }
	    function closeModal() {
	      document.getElementById('allocateModal').style.display = 'none';
	      document.getElementById('addRoomModal').style.display = 'none';
	    }
	  </script>
	</head>
	<body>
	  <div class="heading-container">
	    <h3 class="heading-title">Room Management</h3>
	    <p class="heading-subtitle">Manage all rooms and students in one place</p>
	    <!-- Add Room Button -->
	   
	  </div>
	  <div class="main-content">
	   

	    <!-- Room Allocation Table -->
	    <div class="container">
	    <button onclick="openAddRoomModal()" style="display: block; margin: 0 auto;">Add Room</button>
	           <h2 style="padding:10px 10px;text-align:center; color:blue;"> Allocate the room to student</h2>
	      <div class="table-container">
	      <table border="1">
	        <thead>
	          <tr>
	            <th>Room Number</th>
	            <th>Status</th>
	            <th>Occupants</th>
	            <th>Update</th>
	            <th>Delete</th>
	            <th>Allocate</th>
	          </tr>
	        </thead>
	        <tbody>
	          <%
	            Connection con = null;
	            try {
	              con = DatabaseConnection.getConnection();
	              String roomQuery = "SELECT r.room_number, COUNT(a.student_id) AS occupants " +
	                                 "FROM rooms r LEFT JOIN allocations a ON r.room_number = a.room_number " +
	                                 "GROUP BY r.room_number";
	              PreparedStatement ps = con.prepareStatement(roomQuery);
	              ResultSet rs = ps.executeQuery();
	              boolean roomFound = false;
	              while (rs.next()) {
	                roomFound = true;
	                int roomNumber = rs.getInt("room_number");
	                int occupants = rs.getInt("occupants");
	                String status = (occupants < 3) ? "Vacant" : "Filled";
	          %>
	          <tr>
	            <td><%= roomNumber %></td>
	            <td><%= status %></td>
	            <!-- Occupants Column -->
	            <td>
	              <%
	                String occupantQuery = "SELECT s.id AS studentId, s.name, a.allocation_date " +
	                                       "FROM allocations a " +
	                                       "JOIN students s ON a.student_id = s.id " +
	                                       "WHERE a.room_number = ?";
	                PreparedStatement ps2 = con.prepareStatement(occupantQuery);
	                ps2.setInt(1, roomNumber);
	                ResultSet rs2 = ps2.executeQuery();
	                boolean occupantFound = false;
	                String occupantNames = "";
	                while (rs2.next()) {
	                  occupantFound = true;
	                  occupantNames += rs2.getString("name") + "<br>";
	                }
	                if (!occupantFound) {
	                  occupantNames = "No students allocated";
	                }
	                out.print(occupantNames);
	                rs2.close();
	                ps2.close();
	              %>
	            </td>
	            <!-- Update Column -->
	            <td>
	              <%
	                PreparedStatement ps3 = con.prepareStatement(occupantQuery);
	                ps3.setInt(1, roomNumber);
	                ResultSet rs3 = ps3.executeQuery();
	                boolean updateLinkFound = false;
	                while (rs3.next()) {
	                  updateLinkFound = true;
	                  int studentId = rs3.getInt("studentId");
	                  String studentName = rs3.getString("name");
	                  java.sql.Date allocDate = rs3.getDate("allocation_date");
	                  String dateStr = (allocDate != null) ? allocDate.toString() : "";
	                  out.print("<a href='javascript:void(0);' onclick=\"openUpdateModal('" + studentId + "', '" + roomNumber + "', '" + dateStr + "', '" + studentName + "')\">Update</a><br>");
	                }
	                if (!updateLinkFound) {
	                  out.print("N/A");
	                }
	                rs3.close();
	                ps3.close();
	              %>
	            </td>
	            <!-- Delete Column -->
	            <td>
	              <%
	                PreparedStatement ps4 = con.prepareStatement(occupantQuery);
	                ps4.setInt(1, roomNumber);
	                ResultSet rs4 = ps4.executeQuery();
	                boolean deleteLinkFound = false;
	                while (rs4.next()) {
	                  deleteLinkFound = true;
	                  int studentId = rs4.getInt("studentId");
	                  out.print("<a href='AllActionJSP/DeleteAllocation.jsp?studentId=" + studentId + "' onclick='return confirm(\"Are you sure you want to delete this allocation?\");'>Delete</a><br>");
	                }
	                if (!deleteLinkFound) {
	                  out.print("N/A");
	                }
	                rs4.close();
	                ps4.close();
	              %>
	            </td>
	            <!-- Allocate Button Column -->
	            <td>
	              <% if (occupants < 3) { %>
	                <button onclick="openModal('<%= roomNumber %>')">Allocate</button>
	              <% } %>
	            </td>
	          </tr>
	          <%
	              }
	              if (!roomFound) {
	          %>
	          <tr><td colspan="6">No rooms found.</td></tr>
	          <%
	              }
	              rs.close();
	              ps.close();
	            } catch (Exception e) {
	              out.print("Error in room query: " + e.getMessage());
	            }
	          %>
	        </tbody>
	      </table>
	      </div>
	    </div>
	    
	    <!-- Student List Table -->
	    <div class="container ">
	      <h2 style="padding-bottom:10px;text-align:center; color:blue;">Room Allocated Student List</h2>
	      <div class="table-container">
	      <table border="1">
	        <thead>
	          <tr>
	            <th>Student ID</th>
	            <th>Name</th>
	            <th>Branch</th>
	            <th>Admission Year</th>
	            <th>Allocation Status</th>
	          </tr>
	        </thead>
	        <tbody>
	          <%
	            try {
	              String studentQuery = "SELECT s.id, s.name, s.branch, s.admissiondate, " +
	                                    "(SELECT room_number FROM allocations WHERE student_id = s.id LIMIT 1) AS room_assigned " +
	                                    "FROM students s";
	              PreparedStatement ps5 = con.prepareStatement(studentQuery);
	              ResultSet rs5 = ps5.executeQuery();
	              boolean studentFound = false;
	              while (rs5.next()) {
	                studentFound = true;
	                int studentId = rs5.getInt("id");
	                String studentName = rs5.getString("name");
	                String branch = rs5.getString("branch");
	                java.sql.Date admissionDate = rs5.getDate("admissiondate");
	                int admissionYear = (admissionDate != null) ? admissionDate.toLocalDate().getYear() : 0;
	                String roomAssigned = rs5.getString("room_assigned");
	                String allocationStatus = (roomAssigned != null) ? "Allocated (Room " + roomAssigned + ")" : "Not Allocated";
	          %>
	          <tr>
	            <td><%= studentId %></td>
	            <td><%= studentName %></td>
	            <td><%= branch %></td>
	            <td><%= admissionYear %></td>
	            <td><%= allocationStatus %></td>
	          </tr>
	          <%
	              }
	              if (!studentFound) {
	          %>
	          <tr><td colspan="5">No students found.</td></tr>
	          <%
	              }
	              rs5.close();
	              ps5.close();
	            } catch (Exception e) {
	              out.print("Error in student query: " + e.getMessage());
	            }
	          %>
	        </tbody>
	      </table>
	    </div>
	  </div>
	  
	  <!-- Single Modal Form for Allocation and Update -->
	  <div id="allocateModal" class="modal" style="display:none">
	    <div class="modal-content">
	      <h3 id="modalTitle">Allocate Room</h3>
	      <form action="AllActionJSP/RoomAction.jsp" method="post">
	        <!-- Hidden inputs -->
	        <input type="hidden" id="roomNumberInput" name="roomNumber">
	        <input type="hidden" id="mode" name="mode" value="allocate">
	        <input type="hidden" id="updateStudentId" name="studentId" value="">
	        <!-- For allocation mode, show dropdown; for update mode, show student label -->
	        <div id="allocationStudentDiv">
	          <label>Student</label>
	          <select name="studentIdSelect" required>
	            <%
	              try {
	                String unallocatedStudentsQuery = "SELECT s.id, s.name FROM students s " +
	                    "LEFT JOIN allocations a ON s.id = a.student_id " +
	                    "WHERE a.student_id IS NULL";
	                PreparedStatement ps6 = con.prepareStatement(unallocatedStudentsQuery);
	                ResultSet rs6 = ps6.executeQuery();
	                if (!rs6.isBeforeFirst()) {
	            %>
	            <option disabled>No unallocated students</option>
	            <%
	                }
	                while (rs6.next()) {
	            %>
	            <option value="<%= rs6.getInt("id") %>"><%= rs6.getString("name") %></option>
	            <%
	                }
	                rs6.close();
	                ps6.close();
	              } catch (Exception e) {
	                out.print("Error in dropdown query: " + e.getMessage());
	              }
	            %>
	          </select>
	        </div>
	        <div id="updateStudentDiv" style="display:none;">
	          <label>Student</label>
	          <span id="updateStudentLabel"></span>
	        </div>
	        <label>Date</label>
	        <input type="date" id="allocationDateInput" name="allocationDate" required>
	        <button type="submit">Submit</button>
	        <button type="button" onclick="closeModal()">Cancel</button>
	      </form>
	    </div>
	  </div>
	  
	  <!-- Modal Form for Adding a New Room -->
	  <div id="addRoomModal" class="modal" style="display:none;">
	    <div class="modal-content">
	      <h3>Add Room</h3>
	      <form action="AllActionJSP/AddRoom.jsp" method="post">
	        <label>Room Number</label>
	        <input type="number" name="roomNumber" id="newRoomInput" required>
	         <label>Capacity</label>
	                <input type="number" name="capacity" id="newRoomInput" required>
	        <button type="submit">Add Room</button>
	        <button type="button" onclick="closeModal()">Cancel</button>
	      </form>
	    </div>
	  </div>
	</body>
	</html>
