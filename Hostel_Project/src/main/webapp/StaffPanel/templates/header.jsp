<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    // Ensure user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }
%>
  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>staff</title>
<link rel="stylesheet" href="../assets/css/styles.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="icon" href="${pageContext.request.contextPath}/assets/img/img.png" type="image/png">
</head>
<body>
   
    
    <header  style="height:7vh;">
        <h3 style="padding:1px;">Staff Panel</h3>
    </header>
    <nav>
        <ul class="navbar">
            <li><a href="../staff/index.jsp" class="">Dashboard</a></li>
            <li><a href="../staff/complaints.jsp" class="">Complaints</a></li>
             <p>Welcome, <%= session.getAttribute("username") %> </p>
            
        </ul>
    </nav>