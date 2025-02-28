package servlet;

import dao.RoomDAO;
import model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import com.google.gson.Gson;

@WebServlet("/RoomServlet")
public class RoomServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Room> rooms = RoomDAO.getAllRooms();
        String jsonResponse = new Gson().toJson(rooms);

        response.setContentType("application/json");
        response.getWriter().write(jsonResponse);
    }
}
