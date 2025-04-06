<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>
<%
response.setIntHeader("Refresh", 5);
  String roomNumberParam = request.getParameter("roomNumber");
  try {
      Connection con = DatabaseConnection.getConnection();
      
      // Check if the room already exists
      String selectSQL = "SELECT room_number FROM rooms WHERE room_number = ?";
      PreparedStatement psCheck = con.prepareStatement(selectSQL);
      psCheck.setInt(1, Integer.parseInt(roomNumberParam));
      ResultSet rs = psCheck.executeQuery();
      
      if(rs.next()){
          // Room already exists, show an error message
%>
          <h3>Room Already Exists</h3>
          <p>The room number <%= roomNumberParam %> already exists. Please try again with a different room number.</p>
          <a href="../Room.jsp">Go Back</a>
<%
      } else {
          // Room does not exist, insert the new room
          String insertSQL = "INSERT INTO rooms (room_number) VALUES (?)";
          PreparedStatement psInsert = con.prepareStatement(insertSQL);
          psInsert.setInt(1, Integer.parseInt(roomNumberParam));
          psInsert.executeUpdate();
          psInsert.close();
          response.sendRedirect("../Room.jsp");
      }
      rs.close();
      psCheck.close();
  } catch(Exception e) {
      out.println("Error adding room: " + e.getMessage());
  }
%>
