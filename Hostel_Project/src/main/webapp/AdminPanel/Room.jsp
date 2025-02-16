<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ include file="SideBar.jsp" %> <!-- Sidebar Included -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
     <link rel="stylesheet" href="room.css">
    <link rel="stylesheet" href="Heading.css">
   
</head>
<body>
    <!-- Sidebar Included -->

    <!-- Main Content -->
     <div class="heading-container">
                <h3 class="heading-title">Room Management</h3>
                <p class="heading-subtitle">Manage all rooms in one place</p>
            </div>
    <div class="main-content">
        <div class="container">
           

            <div class="filters">
                <input type="text" placeholder="Search by room number or occupant">
                <select>
                    <option value="all">All Rooms</option>
                    <option value="vacant">Vacant Rooms</option>
                    <option value="filled">Filled Rooms</option>
                </select>
                <button class="add-room-button" onclick="openModal('add')">Add Room</button>
            </div>

            <div class="room-list">
                <table>
                    <thead>
                        <tr>
                            <th>Room Number</th>
                            <th>Status</th>
                            <th>Occupant</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>101</td>
                            <td>Vacant</td>
                            <td>N/A</td>
                            <td>
                                <button class="allocate-button" onclick="openModal('allocate')">Allocate</button>
                                <button class="delete-button">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>102</td>
                            <td>Filled</td>
                            <td>Ashish Raj</td>
                            <td>
                                <button class="delete-button">Delete</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add Room Modal -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <h3>Add New Room</h3>
            <div class="form-group">
                <label>Room Number</label>
                <input type="text" placeholder="Enter Room Number">
            </div>
            <div class="modal-buttons">
                <button class="add-btn">Add Room</button>
                <button class="cancel-btn" onclick="closeModal()">Cancel</button>
            </div>
        </div>
    </div>

    <!-- Allocate Room Modal -->
    <div id="allocateModal" class="modal">
        <div class="modal-content">
            <h3>Allocate Room</h3>
            <div class="form-group">
                <label>Occupant Name</label>
                <input type="text" placeholder="Enter Name">
            </div>
            <div class="modal-buttons">
                <button class="allocate-btn">Allocate</button>
                <button class="cancel-btn" onclick="closeModal()">Cancel</button>
            </div>
        </div>
    </div>

    <script>
        function openModal(type) {
            document.getElementById(type + "Modal").style.display = "flex";
        }

        function closeModal() {
            document.querySelectorAll('.modal').forEach(modal => modal.style.display = "none");
        }
    </script>
</body>
</html>
