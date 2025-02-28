package dao;

import database.DatabaseConnection;
import model.Room;
import java.sql.*;
import java.util.*;

public class RoomDAO {
    public static List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT id, room_number FROM rooms";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                rooms.add(new Room(rs.getInt("id"), rs.getString("room_number"), 0, new ArrayList<>()));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return rooms;
    }

    public static boolean addRoom(String roomNumber) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String checkQuery = "SELECT COUNT(*) FROM rooms WHERE room_number=?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, roomNumber);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return false;
            }

            String query = "INSERT INTO rooms (room_number) VALUES (?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, roomNumber);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public static boolean allocateRoom(int roomId, int studentId) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String countQuery = "SELECT COUNT(*) FROM allocations WHERE room_id=?";
            PreparedStatement countStmt = conn.prepareStatement(countQuery);
            countStmt.setInt(1, roomId);
            ResultSet rs = countStmt.executeQuery();
            if (rs.next() && rs.getInt(1) >= 3) {
                return false;
            }

            String query = "INSERT INTO allocations (room_id, student_id) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, roomId);
            ps.setInt(2, studentId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public static boolean deleteRoom(int roomId) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String deleteAllocations = "DELETE FROM allocations WHERE room_id=?";
            PreparedStatement psAlloc = conn.prepareStatement(deleteAllocations);
            psAlloc.setInt(1, roomId);
            psAlloc.executeUpdate();

            String query = "DELETE FROM rooms WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, roomId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}
