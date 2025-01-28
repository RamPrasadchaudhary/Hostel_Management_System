<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Title</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Style/layout.css">
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="Header.jsp" />

<jsp:include page="Home.jsp" />

    <!-- Include Footer -->
    <jsp:include page="Footer.jsp" />
</body>
</html>
