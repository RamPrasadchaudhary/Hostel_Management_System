<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   <%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    if (session.getAttribute("username") == null || session.getAttribute("role") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${param.title}</title>
<link rel="stylesheet" href="../assets/css/styles.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="icon" href="${pageContext.request.contextPath}/assets/img/img.png" type="image/png">
</head>
<body>
   
    
    <header>
        <h1>${param.title}</h1>
       
    </header>
    <nav>
        <ul class="navbar">
            <li><a href="../staff/index.jsp" class="${param.active == 'dashboard' ? 'active' : ''}">Dashboard</a></li>
            <li><a href="../staff/complaints.jsp" class="${param.active == 'complaints' ? 'active' : ''}">Complaints</a></li>
             <p>Welcome, <%= session.getAttribute("username") %></p>
            
        </ul>
    </nav>