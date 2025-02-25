<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700&display=swap">
    <link rel="stylesheet" href="profile.css">
</head>
<body>
    <header>
        <h1>Student Dashboard</h1>
    </header>
    <a href="dashboard.jsp" class="dashboard-link">Back to Dashboard</a>
    <section id="edit-profile">
        <div class="section">
            <h2>Edit Profile</h2>
            <form id="profile-form" action="saveProfile.jsp" method="POST">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" value="Ashish Raj" >
                </div>
                <div class="form-group">
                    <label for="father-name">Father's Name</label>
                    <input type="text" id="father-name" name="father-name" value="Yaad Nhi Hai" >
                </div>
                <div class="form-group">
                    <label for="room">Room Allotted</label>
                    <input type="text" id="room" name="room" value="516" >
                </div>
                <div class="form-group">
                    <label for="admission-date">Admission Date</label>
                    <input type="date" id="admission-date" name="admission-date" value="2024-01-15" >
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="ashishraulin@gmail.com" >
                    <span class="edit-icon" onclick="toggleEdit('email')">&#9998;</span>
                </div>
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" value="1234567890" readonly>
                    <span class="edit-icon" onclick="toggleEdit('phone')">&#9998;</span>
                </div>
                <div class="form-group">
                    <button type="submit">Save Changes</button>
                </div>
            </form>
        </div>
    </section>
    <div id="popup" class="popup">
        <p>Are you sure you want to save the changes?</p>
        <button id="confirm-btn">Yes</button>
        <button class="cancel" id="cancel-btn">No</button>
    </div>
    <div id="success-message" class="success-message">
        <p>Changes saved successfully!</p>
        <button onclick="closeSuccessMessage()">OK</button>
    </div>
    <footer>
        <p>&copy; 2024 Hostel Management</p>
    </footer>
    <script src="${pageContext.request.contextPath}/Components/Scripting/edit-profile.js"></script>
</body>
</html>
