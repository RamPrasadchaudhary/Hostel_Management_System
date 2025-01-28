<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="MainContent.css"> <!-- Link to your CSS file -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
    /* General Styling for the Heading Component */
.heading-container {
margin-left:110px;
margin-bottom:100px;
    text-align: center; /* Center align the heading */
    padding: 10px 15px; /* Space around the heading */
     background-color: blue; /* Blue background color */
    color: white; /* White text color */
    border-bottom: 4px solid #0056b3; /* Add a darker border for effect */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Subtle shadow below the header */
  }
  
  .heading-title {
  color:white;
    font-size: 2.5rem; /* Large font size for the title */
    margin: 0; /* Remove default margin */
    font-weight: bold; /* Bold font */
    color:white;
  }
  
  .heading-subtitle {
    font-size: 1.2rem; /* Smaller font size for the subtitle */
    margin: 10px 0 0 0; /* Add space above the subtitle */
    font-weight: 400; /* Regular font weight */
    color:white;
  }
 
  /* Responsive Styles */
  @media (max-width: 768px) {
    .heading-title {
      font-size: 2rem; /* Adjust title font size for tablets */
    }
  .heading-container{
  margin-bottom:10px;
  margin-left:0px}
    .heading-subtitle {
      font-size: 1rem; /* Adjust subtitle font size */
    }
  }
  
  @media (max-width: 480px) {
    .heading-title {
      font-size: 1.8rem; /* Smaller font size for mobile devices */
    }
  
    .heading-subtitle {
      font-size: 0.9rem; /* Adjust subtitle font size for mobile */
    }
  }
  
    </style>
</head>
<body>
      <div class="heading-container">
      <h3 class="heading-title">Admin Dashboard</h3>
     <p class="heading-subtitle">This is admin Panel</p>
      
    </div>
    <div class="main-content">
        <!-- Header Section -->
   
        <!-- Dashboard Overview Section -->
        <div class="dashboard-overview">
            <div class="overview-card">
                <i class="fas fa-users"></i> <!-- FontAwesome Icon for Users -->
                <div class="overview-info">
                    <h3>150</h3> <!-- Static Value for Total Users -->
                    <p>Total Users</p>
                </div>
            </div>
            <div class="overview-card">
                <i class="fas fa-user-graduate"></i> <!-- FontAwesome Icon for Students -->
                <div class="overview-info">
                    <h3>80</h3> <!-- Static Value for Students -->
                    <p>Students</p>
                </div>
            </div>
            <div class="overview-card">
                <i class="fas fa-user-tie"></i> <!-- FontAwesome Icon for Staff Members -->
                <div class="overview-info">
                    <h3>20</h3> <!-- Static Value for Staff Members -->
                    <p>Staff Members</p>
                </div>
            </div>
            <div class="overview-card">
                <i class="fas fa-user-cog"></i> <!-- FontAwesome Icon for Wardens -->
                <div class="overview-info">
                    <h3>5</h3> <!-- Static Value for Wardens -->
                    <p>Wardens</p>
                </div>
            </div>
            <div class="overview-card">
                <i class="fas fa-tools"></i> <!-- FontAwesome Icon for Maintenance Requests -->
                <div class="overview-info">
                    <h3>5</h3> <!-- Static Value for Maintenance Requests -->
                    <p>Maintenance Requests</p>
                </div>
            </div>
             <div class="overview-card">
                <i class="fas fa-user-cog"></i> <!-- FontAwesome Icon for Wardens -->
                <div class="overview-info">
                    <h3>5</h3> <!-- Static Value for Wardens -->
                    <p>Wardens</p>
                </div>
            </div>
            <div class="overview-card">
                <i class="fas fa-tools"></i> <!-- FontAwesome Icon for Maintenance Requests -->
                <div class="overview-info">
                    <h3>5</h3> <!-- Static Value for Maintenance Requests -->
                    <p>Maintenance Requests</p>
                </div>
            </div>
            <div class="overview-card">
                <i class="fas fa-tools"></i> <!-- FontAwesome Icon for Maintenance Requests -->
                <div class="overview-info">
                    <h3>5</h3> <!-- Static Value for Maintenance Requests -->
                    <p>Maintenance Requests</p>
                </div>
            </div>
        </div>

        <!-- Section Content Section -->
        <div class="section-content">
            <h2>Welcome, Admin!</h2>
            <p>Select a menu item from the left to get started.</p>
        </div>
    </div>

    <!-- JavaScript Section (if needed for interactivity) -->
    <script src="path-to-your-javascript-file.js"></script> <!-- Link to any JS file -->

</body>
</html>
