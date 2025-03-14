<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700&display=swap">
    <style>
        /* General Styles */
        body {
            margin: 0;
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f4;
        }

        /* Header Styles */
        header {
            background-color: #007bff;
            color: white;
            text-align: center;
            padding: 30px 0;
            font-size: 24px;
            font-weight: bold;
        }

        /* Navigation Styles */
        nav {
            background: blue;
        }

        .navbar {
            display: flex;
            justify-content: center;
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        .navbar li {
            margin: 0;
        }

        .navbar a {
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
        }

        .navbar a:hover, .navbar a.active {
            background-color: #0056b3;
        }

        /* Responsive Design */
        @media (max-width: 600px) {
            .navbar {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <header>
        Student Dashboard
       
    </header>
    <nav>
        <ul class="navbar">
            <li><a href="dashboard.jsp" >Dashboard</a></li>
            <li><a href="payments.jsp">Payments</a></li>
            <li><a href="complaints.jsp">Complaints</a></li>
        </ul>
    </nav>
</body>
</html>
