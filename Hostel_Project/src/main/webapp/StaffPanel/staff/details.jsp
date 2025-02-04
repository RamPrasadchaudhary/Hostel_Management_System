<%@include file="../templates/header.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setAttribute("title", "Complaint Details");
%>

<section id="complaint-details">
    <div class="back-to-list">
        <a href="complaints.jsp" class="btn">Back to Complaints List</a>
    </div>

    <div class="complaint-info">
        <h2><i class="fa-solid fa-clipboard-list"></i> Complaint Information</h2>
        <p><strong>Complaint ID:</strong> #12345</p>
        <p><strong>Complaint Type:</strong> Electrical Issue</p>
        <p><strong>Date Filed:</strong> 2024-08-25</p>
        <p><strong>Status:</strong> <span id="complaint-status" class="status-In-Progress">In Progress</span></p>
    </div>

    <div class="student-info">
        <h2><i class="fa-solid fa-user"></i> Student Information</h2>
        <p><strong>Name:</strong> Ashish Raj</p>
        <p><strong>Room Number:</strong> 516</p>
        <p><strong>Email:</strong> ashishraulin@gmail.com</p>
        <p><strong>Phone Number:</strong> 1234567890</p>
    </div>

    <div class="complaint-description">
        <h2><i class="fa-solid fa-file-alt"></i> Complaint Description</h2>
        <p>The electrical socket in my room is malfunctioning. It sparks when I try to plug in any device, and this poses a serious safety hazard. Kindly address this issue as soon as possible.</p>
    </div>

    <div class="actions">
        <button class="btn resolve-btn"><i class="fa-solid fa-check-circle"></i> Mark as Resolved</button>
        <button class="btn update-btn"><i class="fa-solid fa-edit"></i> Update Status</button>
    </div>
</section>

<%@include file="../templates/footer.jsp"%>