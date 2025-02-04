<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <div class="loader-wrapper">
        <div class="card">
            <div class="loader">
                <p>Loading</p>
                <div class="words">
                    <span class="word">Dashboard</span>
                    <span class="word">Complaints</span>
                </div>
            </div>
        </div>
    </div>
    <header>
        <h1>${param.title}</h1>
    </header>
    <nav>
        <ul class="navbar">
            <li><a href="../staff/index.jsp" class="${param.active == 'dashboard' ? 'active' : ''}">Dashboard</a></li>
            <li><a href="../staff/complaints.jsp" class="${param.active == 'complaints' ? 'active' : ''}">Complaints</a></li>
        </ul>
    </nav>