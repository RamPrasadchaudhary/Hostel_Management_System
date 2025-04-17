<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="SideBar.jsp" %> <!-- Sidebar Included -->
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/hostelproject";
    String user = "root";
    String password = "9821574168";
    
    // Variables to hold the data from the database
    double totalPaidAmount = 0.0; // Sum of paid_amount from updated_payments without any filter
    double totalRemaining = 0.0;
    double totaldueAmount = 0.0;
    
    // Initialize complaint counters
    int electricityComplaints = 0;
    int messComplaints = 0;
    int wifiComplaints = 0;
    int waterComplaints = 0;
    int sanitaryComplaints = 0;
    int plumberComplaints = 0;
    int foodComplaints = 0;  // if needed
    
    int totalStudents = 0;
    int totalStaff = 0;
    int totalWardens = 0;
    
    Connection conn = null;
    
    try {
        // Load the JDBC driver and establish a connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        
        Statement stmt = conn.createStatement();
        ResultSet rs = null;
        
        // Retrieve total paid, remaining, and due amounts
        rs = stmt.executeQuery("SELECT SUM(paid_amount) AS totalPaid, SUM(remaining_amount) AS totalRemaining, SUM(due_amount) AS totalDue FROM updated_payments");
        if (rs.next()) {
            totalPaidAmount = rs.getDouble("totalPaid");
            totalRemaining = rs.getDouble("totalRemaining");
            totaldueAmount = rs.getDouble("totalDue");
        }
        rs.close();
        
        // Query and count complaints by type
        rs = stmt.executeQuery("SELECT complaint_type, COUNT(*) AS count FROM complaints GROUP BY complaint_type");
        while (rs.next()) {
            // Normalize complaint type (trim any extra white space and use lower case)
            String type = rs.getString("complaint_type").trim().toLowerCase();
            int count = rs.getInt("count");
            switch (type) {
                case "electrical":
                    electricityComplaints = count;
                    break;
                case "mess":
                    messComplaints = count;
                    break;
                case "wifi":
                    wifiComplaints = count;
                    break;
                case "water":
                    waterComplaints = count;
                    break;
                case "sanitary":
                    sanitaryComplaints = count;
                    break;
                case "plumber":
                    plumberComplaints = count;
                    break;
                // Add more cases as needed
            }
        }
        rs.close();
        
        rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM students");
        if (rs.next()) {
            totalStudents = rs.getInt("total");
        }
        rs.close();
        
        rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM staff");
        if (rs.next()) {
            totalStaff = rs.getInt("total");
        }
        rs.close();
        
        rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM wardens");
        if (rs.next()) {
            totalWardens = rs.getInt("total");
        }
        rs.close();
        
        stmt.close();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Monthly Report</title>
    
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- External CSS files for screen if needed -->
    <link rel="stylesheet" href="Style/report.css">
    <link rel="stylesheet" href="Heading.css">
    
    <!-- CSS for print media -->
    <style>
        /* Print specific styling */
        @media print {
            body {
                font-family: Arial, sans-serif;
                color: #000;
                margin: 0;
                padding: 0;
            }
            /* Hide buttons and non-essential UI */
            .no-print {
                display: none;
            }
            /* Force page breaks between sections if needed */
            .report__card {
                page-break-inside: avoid;
                border: 1px solid #333;
                padding: 10px;
                margin-bottom: 15px;
            }
            /* Print header style */
            .print-header {
                text-align: center;
                border-bottom: 2px solid #000;
                margin-bottom: 20px;
                padding-bottom: 10px;
            }
            .print-header h1 {
                margin: 0;
            }
        }
        
        /* Screen styling - if different from print */
        .report__container {
            padding: 20px;
        }
    </style>
    
    <!-- JavaScript print function -->
    <script>
      // The printReport function will simply call the window.print() function.
      function printReport() {
          // For a cleaner print view, you may add any pre-print formatting here.
          window.print();
      }
    </script>
</head>
<body>
    <div class="heading-container">
        <h3 class="heading-title">Record</h3>
        <p class="heading-subtitle">This is the monthly record page</p>
    </div>
    <div class="report">
        <!-- Print button for screen view -->
        <div class="report__print-section no-print">
            <button onclick="printReport()" class="report__print-btn">
                <i class="fas fa-print"></i> Print Report
            </button>
        </div>
        
        <!-- This hidden div will serve as a print header that appears only during printing -->
        <div class="print-header no-print">
           
        </div>
        
        <div class="report__container">
            <!-- Financial Summary Section -->
            <section class="report__card report__card--financial-summary">
                <div class="report__heading-container">
                    <h2 class="report__heading">Financial Summary</h2>
                    <a href="Payment.jsp" class="report__section-btn no-print">Go to Payments</a>
                </div>
                <div class="report__card-content">
                    <p>Total Payment Due: <strong>₹<span id="total-due"><%= totaldueAmount %></span></strong></p>
                    <p>Total Payment Remaining: <strong>₹<span id="total-remaining"><%= totalRemaining %></span></strong></p>
                    <p>Total Payment Received: <strong>₹<span id="total-paid"><%= totalPaidAmount %></span></strong></p>
                </div>
            </section>
            <!-- Complaints Summary Section -->
            <section class="report__card report__card--complaint-summary">
                <div class="report__heading-container">
                    <h2 class="report__heading">Complaints Summary</h2>
                    <a href="complaint.jsp" class="report__section-btn no-print">View Complaints</a>
                </div>
                <div class="report__card-content">
                    <p>Electrical Issues: <strong><span id="electricity-complaints"><%= electricityComplaints %></span></strong></p>
                    <p>Mess Issues: <strong><span id="mess-complaints"><%= messComplaints %></span></strong></p>
                    <p>WiFi Issues: <strong><span id="wifi-complaints"><%= wifiComplaints %></span></strong></p>
                    <p>Water Issues: <strong><span id="water-complaints"><%= waterComplaints %></span></strong></p>
                    <p>Sanitary Issues: <strong><span id="sanitary-complaints"><%= sanitaryComplaints %></span></strong></p>
                    <p>Plumber Issues: <strong><span id="plumber-complaints"><%= plumberComplaints %></span></strong></p>
                </div>
            </section>
            <!-- Staff and Residents Section -->
            <section class="report__card report__card--staff-summary">
                <div class="report__heading-container">
                    <h2 class="report__heading">Staff and Residents</h2>
                    <a href="MainContent.jsp" class="report__section-btn no-print">View Dashboard</a>
                </div>
                <div class="report__card-content">
                    <p>Total Students in Hostel: <strong><span id="total-students"><%= totalStudents %></span></strong></p>
                    <p>Total Staff: <strong><span id="total-staff"><%= totalStaff %></span></strong></p>
                    <p>Total Wardens: <strong><span id="total-wardens"><%= totalWardens %></span></strong></p>
                </div>
            </section>
        </div>
        <div class="report__logo-container">
            <img src="logo.jpg" alt="Hostel Logo" class="report__logo-img">
        </div>
    </div>
    
    <!-- JavaScript to update print header with current date -->
    <script>
        // Set the current month and year in the non-print header
        const monthNames = ["January", "February", "March", "April", "May", "June",
                            "July", "August", "September", "October", "November", "December"];
        const currentDate = new Date();
        document.getElementById('report-month') && (document.getElementById('report-month').innerText = monthNames[currentDate.getMonth()]);
        document.getElementById('report-year') && (document.getElementById('report-year').innerText = currentDate.getFullYear());
        
        // Update print header with full date information for formal record
        var printDate = currentDate.toLocaleDateString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
        var printHeader = document.getElementById('print-date');
        if (printHeader) {
            printHeader.innerText = "Printed on " + printDate;
        }
    </script>
</body>
</html>
