package model;

import java.util.List;

public class Room {
    private int id;
    private String roomNumber;
    private int occupants;
    private List<String> occupantNames;

    // Constructor
    public Room() {}

    public Room(int id, String roomNumber, int occupants, List<String> occupantNames) {
        this.id = id;
        this.roomNumber = roomNumber;
        this.occupants = occupants;
        this.occupantNames = occupantNames;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public int getOccupants() {
        return occupants;
    }

    public void setOccupants(int occupants) {
        this.occupants = occupants;
    }

    public List<String> getOccupantNames() {
        return occupantNames;
    }

    public void setOccupantNames(List<String> occupantNames) {
        this.occupantNames = occupantNames;
    }
}

