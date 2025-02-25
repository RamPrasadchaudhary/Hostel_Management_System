<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>

<%
    String action = request.getParameter("action");
    Connection con = null;
    PreparedStatement ps = null;

    try {
        con = DatabaseConnection.getConnection();

        if ("add".equals(action)) {
            int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));

            // Check if the room already exists
            ps = con.prepareStatement("SELECT COUNT(*) FROM rooms WHERE room_number = ?");
            ps.setInt(1, roomNumber);
            ResultSet rs = ps.executeQuery();
            rs.next();

            if (rs.getInt(1) == 0) {
                ps = con.prepareStatement("INSERT INTO rooms (room_number, occupied) VALUES (?, 0)");
                ps.setInt(1, roomNumber);
                ps.executeUpdate();
            }
        } 
        else if ("allocate".equals(action)) {
            int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
            int studentId = Integer.parseInt(request.getParameter("studentId"));

            // Check if the student is already allocated
            ps = con.prepareStatement("SELECT COUNT(*) FROM room_allocation WHERE student_id = ?");
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            rs.next();

            if (rs.getInt(1) == 0) { // Student not allocated yet
                // Check room capacity
                ps = con.prepareStatement("SELECT occupied FROM rooms WHERE room_number = ?");
                ps.setInt(1, roomNumber);
                rs = ps.executeQuery();
                rs.next();
                int occupied = rs.getInt("occupied");

                if (occupied < 3) {
                    ps = con.prepareStatement("INSERT INTO room_allocation (student_id, room_number) VALUES (?, ?)");
                    ps.setInt(1, studentId);
                    ps.setInt(2, roomNumber);
                    ps.executeUpdate();

                    // Update room occupancy count
                    ps = con.prepareStatement("UPDATE rooms SET occupied = occupied + 1 WHERE room_number = ?");
                    ps.setInt(1, roomNumber);
                    ps.executeUpdate();
                }
            }
        } 
        else if ("delete".equals(action)) {
            int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));

            // Delete allocations first
            ps = con.prepareStatement("DELETE FROM room_allocation WHERE room_number = ?");
            ps.setInt(1, roomNumber);
            ps.executeUpdate();

            // Delete room
            ps = con.prepareStatement("DELETE FROM rooms WHERE room_number = ?");
            ps.setInt(1, roomNumber);
            ps.executeUpdate();
        }

        response.sendRedirect("RoomManagement.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (ps != null) ps.close();
        DatabaseConnection.closeConnection(con);
    }
%>
