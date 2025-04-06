<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>
<%
response.setIntHeader("Refresh", 5);
  String mode = request.getParameter("mode");
  String roomNumber = request.getParameter("roomNumber");
  String allocationDate = request.getParameter("allocationDate");
  Connection con = DatabaseConnection.getConnection();
  try {
      if("update".equals(mode)) {
          // In update mode, the studentId is provided in the updateStudentId hidden field
          String studentId = request.getParameter("studentId");
          String updateSQL = "UPDATE allocations SET room_number = ?, allocation_date = ? WHERE student_id = ?";
          PreparedStatement ps = con.prepareStatement(updateSQL);
          ps.setInt(1, Integer.parseInt(roomNumber));
          ps.setString(2, allocationDate);
          ps.setInt(3, Integer.parseInt(studentId));
          ps.executeUpdate();
          ps.close();
      } else {
          // In allocate mode, studentId is chosen from dropdown (named studentIdSelect)
          String studentId = request.getParameter("studentIdSelect");
          String insertSQL = "INSERT INTO allocations (room_number, student_id, allocation_date) VALUES (?, ?, ?)";
          PreparedStatement ps = con.prepareStatement(insertSQL);
          ps.setInt(1, Integer.parseInt(roomNumber));
          ps.setInt(2, Integer.parseInt(studentId));
          ps.setString(3, allocationDate);
          ps.executeUpdate();
          ps.close();
      }
      response.sendRedirect("../Room.jsp");
  } catch(Exception e) {
      out.println("Error during " + mode + ": " + e.getMessage());
  }
%>
