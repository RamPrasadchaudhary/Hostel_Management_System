package dao;

import model.Student;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    private Connection conn;

    public StudentDAO() {
        conn = database.DatabaseConnection.getConnection();
    }

    public List<Student> getAllStudents() throws SQLException {
        List<Student> students = new ArrayList<>();
        String query = "SELECT * FROM students";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);
        while (rs.next()) {
            Student student = new Student();
            student.setId(rs.getString("id"));
            student.setName(rs.getString("name"));
            student.setRoomNo(rs.getInt("roomNo"));
            student.setBranch(rs.getString("branch"));
            student.setContact(rs.getLong("contact"));
            student.setAdmissionDate(rs.getString("admissionDate"));
            students.add(student);
        }
        return students;
    }

    public void addStudent(Student student) throws SQLException {
        String query = "INSERT INTO students (id, name, roomNo, branch, contact, admissionDate) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, student.getId());
        pstmt.setString(2, student.getName());
        pstmt.setInt(3, student.getRoomNo());
        pstmt.setString(4, student.getBranch());
        pstmt.setLong(5, student.getContact());
        pstmt.setString(6, student.getAdmissionDate());
        pstmt.executeUpdate();
    }

    public void updateStudent(Student student) throws SQLException {
        String query = "UPDATE students SET name=?, roomNo=?, branch=?, contact=?, admissionDate=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, student.getName());
        pstmt.setInt(2, student.getRoomNo());
        pstmt.setString(3, student.getBranch());
        pstmt.setLong(4, student.getContact());
        pstmt.setString(5, student.getAdmissionDate());
        pstmt.setString(6, student.getId());
        pstmt.executeUpdate();
    }

    public void deleteStudent(String id) throws SQLException {
        String query = "DELETE FROM students WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, id);
        pstmt.executeUpdate();
    }
}
