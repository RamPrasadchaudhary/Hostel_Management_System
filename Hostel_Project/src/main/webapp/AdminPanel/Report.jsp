<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="SideBar.jsp" %> <!-- Sidebar Included -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Report</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="report.css">
    <link rel="stylesheet" href="Heading.css">

</head>
<body>
 <div class="heading-container">
        <h3 class="heading-title"> Record</h3>
        <p class="heading-subtitle">This is the monthly record page</p>
    </div>
    <div class="report">
        <header class="report__header">
        <!--    <h1 class="report__title">Monthly Hostel Report</h1>
            <p class="report__month-label">Report for <strong><span id="report-month">September</span> <span id="report-year">2024</span></strong></p>
       --> </header>
        <div class="report__print-section">
            <button onclick="window.print()" class="report__print-btn">
                <i class="fas fa-print"></i> Print Report
            </button>
        </div>
        <div class="report__container">
            <section class="report__card report__card--financial-summary">
                <div class="report__heading-container">
                    <h2 class="report__heading">Financial Summary</h2>
                    <a href="managepayment.html" class="report__section-btn">Go to Payments</a>
                </div>
                <div class="report__card-content">
                    <p>Total Payment Received from Mess: <strong>₹<span id="mess-fee">50,000</span></strong></p>
                    <p>Total Payment Received from Maintenance: <strong>₹<span id="maintenance-fee">20,000</span></strong></p>
                </div>
            </section>

            <section class="report__card report__card--complaint-summary">
                <div class="report__heading-container">
                    <h2 class="report__heading">Complaints Summary</h2>
                    <a href="update.html" class="report__section-btn">View Complaints</a>
                </div>
                <div class="report__card-content">
                    <p>Electricity Issues: <strong><span id="electricity-complaints">15</span></strong></p>
                    <p>Food Quality Issues: <strong><span id="food-complaints">8</span></strong></p>
                    <p>Wifi Issues: <strong><span id="wifi-complaints">10</span></strong></p>
                    <p>Room Cleaning Issues: <strong><span id="cleaning-complaints">5</span></strong></p>
                </div>
            </section>

            <section class="report__card report__card--staff-summary">
                <div class="report__heading-container">
                    <h2 class="report__heading">Staff and Residents</h2>
                    <a href="index.html" class="report__section-btn">View Dashboard</a>
                </div>
                <div class="report__card-content">
                    <p>Total Students in Hostel: <strong><span id="total-students">250</span></strong></p>
                    <p>Total Staff: <strong><span id="total-staff">30</span></strong></p>
                    <p>Total Wardens: <strong><span id="total-wardens">5</span></strong></p>
                </div>
            </section>
        </div>
        <div class="report__logo-container">
            <img src="logo.jpg" alt="Hostel Logo" class="report__logo-img">
        </div>
    </div>

    <script>
        // Automatically update the month and year label to the current month and year
        const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        const currentDate = new Date();
        const currentMonth = monthNames[currentDate.getMonth()];
        const currentYear = currentDate.getFullYear();
        document.getElementById('report-month').innerText = currentMonth;
        document.getElementById('report-year').innerText = currentYear;
    </script>
</body>
</html>
