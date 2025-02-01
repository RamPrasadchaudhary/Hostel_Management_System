<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="SideBar.jsp" %> <!-- Sidebar Included -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Complaints</title>
    <link rel="stylesheet" href="complaints.css">
      <link rel="stylesheet" href="Heading.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>
<body>
    <!-- Main Content -->
    <div class="heading-container">
        <h3 class="heading-title">Complaints  Record</h3>
        <p class="heading-subtitle">This is the complaints page</p>
    </div>
    <div class="main-content">
          

        <!-- Complaint Categories -->
        <div class="complaints-dashboard">
            <!-- Electrician Box -->
            <div class="complaint-box" id="electrician-box">
                <div class="complaint-heading" onclick="toggleComplaints('electrician-box')">
                    <h2>Electrician Complaints</h2>
                    <i class="fas fa-chevron-down arrow-icon"></i>
                </div>
                <div class="complaint-details">
                    <div class="complaint">
                        <p><strong>Complaint by:</strong> <span>John Doe</span></p>
                        <p><strong>Date:</strong> <span>12th September 2024, Time: 10:00 AM</span></p>
                        <p><strong>Student ID:</strong> <span>12345</span></p>
                        <p><strong>Room Number:</strong> <span>101</span></p>
                        <p><strong>Description:</strong> <span>The room's light is flickering intermittently, and the switch seems to be malfunctioning.</span></p>
                        <p><strong>Status:</strong> <span class="status pending">Pending</span></p>
                        <button class="view-details-btn">View Details</button>
                    </div>
                </div>
            </div>

            <!-- Mess Box -->
            <div class="complaint-box" id="mess-box">
                <div class="complaint-heading" onclick="toggleComplaints('mess-box')">
                    <h2>Mess Complaints</h2>
                    <i class="fas fa-chevron-down arrow-icon"></i>
                </div>
                <div class="complaint-details">
                    <div class="complaint">
                        <p><strong>Complaint by:</strong> <span>Mark Smith</span></p>
                        <p><strong>Date:</strong> <span>10th September 2024, Time: 9:30 AM</span></p>
                        <p><strong>Student ID:</strong> <span>44556</span></p>
                        <p><strong>Room Number:</strong> <span>404</span></p>
                        <p><strong>Description:</strong> <span>The food served today was cold and undercooked.</span></p>
                        <p><strong>Status:</strong> <span class="status in-progress">In Progress</span></p>
                        <button class="view-details-btn">View Details</button>
                    </div>
                </div>
            </div>

            <!-- WiFi Complaints -->
            <div class="complaint-box" id="wifi-box">
                <div class="complaint-heading" onclick="toggleComplaints('wifi-box')">
                    <h2>WiFi Complaints</h2>
                    <i class="fas fa-chevron-down arrow-icon"></i>
                </div>
                <div class="complaint-details">
                    <div class="complaint">
                        <p><strong>Complaint by:</strong> <span>Sarah Lee</span></p>
                        <p><strong>Date:</strong> <span>15th September 2024, Time: 11:45 AM</span></p>
                        <p><strong>Student ID:</strong> <span>98765</span></p>
                        <p><strong>Room Number:</strong> <span>202</span></p>
                        <p><strong>Description:</strong> <span>The WiFi connection is unstable and keeps dropping.</span></p>
                        <p><strong>Status:</strong> <span class="status pending">Pending</span></p>
                        <button class="view-details-btn">View Details</button>
                    </div>
                </div>
            </div>

            <!-- Water Complaints -->
            <div class="complaint-box" id="water-box">
                <div class="complaint-heading" onclick="toggleComplaints('water-box')">
                    <h2>Water Complaints</h2>
                    <i class="fas fa-chevron-down arrow-icon"></i>
                </div>
                <div class="complaint-details">
                    <div class="complaint">
                        <p><strong>Complaint by:</strong> <span>Alice Cooper</span></p>
                        <p><strong>Date:</strong> <span>18th September 2024, Time: 2:00 PM</span></p>
                        <p><strong>Student ID:</strong> <span>11223</span></p>
                        <p><strong>Room Number:</strong> <span>303</span></p>
                        <p><strong>Description:</strong> <span>No hot water in the bathroom.</span></p>
                        <p><strong>Status:</strong> <span class="status resolved">Resolved</span></p>
                        <button class="view-details-btn">View Details</button>
                    </div>
                </div>
            </div>

            <!-- Sanitary Complaints -->
            <div class="complaint-box" id="sanitary-box">
                <div class="complaint-heading" onclick="toggleComplaints('sanitary-box')">
                    <h2>Sanitary Complaints</h2>
                    <i class="fas fa-chevron-down arrow-icon"></i>
                </div>
                <div class="complaint-details">
                    <div class="complaint">
                        <p><strong>Complaint by:</strong> <span>Jessica Brown</span></p>
                        <p><strong>Date:</strong> <span>20th September 2024, Time: 1:30 PM</span></p>
                        <p><strong>Student ID:</strong> <span>65432</span></p>
                        <p><strong>Room Number:</strong> <span>404</span></p>
                        <p><strong>Description:</strong> <span>The toilet flush is not working properly.</span></p>
                        <p><strong>Status:</strong> <span class="status in-progress">In Progress</span></p>
                        <button class="view-details-btn">View Details</button>
                    </div>
                </div>
            </div>

            <!-- Plumber Complaints -->
            <div class="complaint-box" id="plumber-box">
                <div class="complaint-heading" onclick="toggleComplaints('plumber-box')">
                    <h2>Plumber Complaints</h2>
                    <i class="fas fa-chevron-down arrow-icon"></i>
                </div>
                <div class="complaint-details">
                    <div class="complaint">
                        <p><strong>Complaint by:</strong> <span>George King</span></p>
                        <p><strong>Date:</strong> <span>22nd September 2024, Time: 4:00 PM</span></p>
                        <p><strong>Student ID:</strong> <span>22110</span></p>
                        <p><strong>Room Number:</strong> <span>102</span></p>
                        <p><strong>Description:</strong> <span>The sink is leaking water.</span></p>
                        <p><strong>Status:</strong> <span class="status pending">Pending</span></p>
                        <button class="view-details-btn">View Details</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function toggleComplaints(boxId) {
            const box = document.getElementById(boxId);
            const details = box.querySelector('.complaint-details');
            const arrowIcon = box.querySelector('.arrow-icon');
            
            if (details.style.display === 'block') {
                details.style.display = 'none';
                arrowIcon.classList.remove('rotate');
            } else {
                details.style.display = 'block';
                arrowIcon.classList.add('rotate');
            }
        }
    </script>
</body>
</html>
