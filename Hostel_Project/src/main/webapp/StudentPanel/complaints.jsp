<%@ page contentType="text/html; charset=UTF-8" language="java" %>
   <%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaints</title>
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700&display=swap">
    <link rel="stylesheet" href="complaints.css">
</head>
<body>
    

    <section id="complaints">
        <h2>Create a Complaint</h2>
        <form id="complaint-form" method="POST" action="submitComplaint.jsp">
            <label for="complaint-type">Type of Complaint:</label>
            <select id="complaint-type" name="complaint-type" required>
                <option value="maintenance">Maintenance</option>
                <option value="room-cleaning">Room Cleaning</option>
                <option value="food-quality">Food Quality</option>
                <option value="other">Other</option>
            </select>
            <label for="complaint-description">Description:</label>
            <textarea id="complaint-description" name="complaint-description" rows="5" required></textarea>
            <button type="submit">Submit</button>
            <button type="button" id="trackerButton">Track Your Complaints</button>
        </form>

        <div id="trackerSection">
            <h2>Complaint Tracker</h2>
            <%-- Example dynamic complaint data --%>
            <div class="complaint-item">
                <h3>Maintenance</h3>
                <p><strong>Description:</strong> The fan in room 516 is not working properly.</p>
                <p><strong>Status:</strong> <span class="status-in-progress">In Progress</span></p>
            </div>
            <div class="complaint-item">
                <h3>Room Cleaning</h3>
                <p><strong>Description:</strong> Room 516 was not cleaned properly last week.</p>
                <p><strong>Status:</strong> <span class="status-resolved">Resolved</span></p>
            </div>
            <div class="complaint-item">
                <h3>Food Quality</h3>
                <p><strong>Description:</strong> The food served in the mess yesterday was undercooked.</p>
                <p><strong>Status:</strong> <span class="status-in-progress">In Progress</span></p>
            </div>
            <div class="complaint-item">
                <h3>Other</h3>
                <p><strong>Description:</strong> The Wi-Fi connection is unstable in the hostel common area.</p>
                <p><strong>Status:</strong> <span class="status-pending">Pending</span></p>
            </div>
        </div>
    </section>
    <footer>
        <p>&copy; 2024 Hostel Management</p>
    </footer>

    <!-- The Modal -->
    <div id="successModal" class="modal">
        <div class="modal-content">
            <span class="close" aria-label="Close">&times;</span>
            <h2>Success!</h2>
            <p>Your complaint has been submitted successfully.</p>
        </div>
    </div>

    <!-- Link to external JavaScript file -->
    <script src="./Components/Scripting/complaints.js"></script>
</body>
</html>
