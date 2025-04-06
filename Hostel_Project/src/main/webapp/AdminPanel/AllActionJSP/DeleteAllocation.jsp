<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>
<%
response.setIntHeader("Refresh", 5);
    String studentId = request.getParameter("studentId");
    try {
        Connection con = DatabaseConnection.getConnection();
        String deleteSQL = "DELETE FROM allocations WHERE student_id = ?";
        PreparedStatement ps = con.prepareStatement(deleteSQL);
        ps.setInt(1, Integer.parseInt(studentId));
        ps.executeUpdate();
        response.sendRedirect("../Room.jsp");
    } catch(Exception e) {
        out.println("Error during deletion: " + e.getMessage());
    }
%>
