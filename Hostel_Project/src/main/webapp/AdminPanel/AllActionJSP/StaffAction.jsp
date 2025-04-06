<%@ page import="java.sql.*" %>
<%@ page import="database.DatabaseConnection" %>
<%
response.setIntHeader("Refresh", 5);
    Connection con = null;
    PreparedStatement pst = null;
    String message = "";
    try {
        con = DatabaseConnection.getConnection();
        // Check if this is a deletion request.
        if(request.getParameter("deleteId") != null){
            String deleteId = request.getParameter("deleteId");
            pst = con.prepareStatement("DELETE FROM staff WHERE id = ?");
            pst.setString(1, deleteId);
            pst.executeUpdate();
            message = "Staff member deleted successfully!";
        }
        // Else if it's an add/update request.
        else if(request.getParameter("name") != null && 
                request.getParameter("role") != null && 
                request.getParameter("joiningDate") != null && 
                request.getParameter("contact") != null){
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String roleVal = request.getParameter("role");
            String joiningDate = request.getParameter("joiningDate");
            String contact = request.getParameter("contact");
            
            if(id == null || id.trim().isEmpty()){
                // Insert new staff record.
                pst = con.prepareStatement("INSERT INTO staff (name, role, join_date, contact) VALUES (?, ?, ?, ?)");
                pst.setString(1, name);
                pst.setString(2, roleVal);
                pst.setString(3, joiningDate);
                pst.setString(4, contact);
                pst.executeUpdate();
                message = "Staff member added successfully!";
            } else {
                // Update existing staff record.
                pst = con.prepareStatement("UPDATE staff SET name=?, role=?, join_date=?, contact=? WHERE id=?");
                pst.setString(1, name);
                pst.setString(2, roleVal);
                pst.setString(3, joiningDate);
                pst.setString(4, contact);
                pst.setString(5, id);
                pst.executeUpdate();
                message = "Staff details updated successfully!";
            }
        }
    } catch(SQLException e){
        message = "Error occurred: " + e.getMessage();
        e.printStackTrace();
    } finally {
        if(pst != null) { pst.close(); }
        if(con != null) { con.close(); }
    }
    session.setAttribute("message", message);
    // Redirect back to Staff.jsp (adjust the relative path as needed)
    response.sendRedirect("../Staff.jsp");
%>
