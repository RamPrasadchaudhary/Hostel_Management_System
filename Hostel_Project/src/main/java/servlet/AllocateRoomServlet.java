package servlet;

import dao.RoomDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/AllocateRoomServlet")
public class AllocateRoomServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        int studentId = Integer.parseInt(request.getParameter("studentId"));

        boolean success = RoomDAO.allocateRoom(roomId, studentId);
        response.getWriter().write("{\"success\": " + success + "}");
    }
}
