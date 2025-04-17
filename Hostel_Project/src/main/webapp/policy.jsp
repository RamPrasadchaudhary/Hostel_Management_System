<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="Header.jsp" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Privacy Policy - Munnu Hostel</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Style/Footer.css">
    <style>
        .policy-container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            font-family: Arial, sans-serif;
            line-height: 1.7;
        }

        h1, h2 {
            color: #333;
        }

        p {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="policy-container">
    <h1>Privacy Policy</h1>
    <p>Last Updated: April 16, 2025</p>

    <p>At Munnu Hostel, we respect your privacy and are committed to protecting the personal information you share with us. This Privacy Policy outlines how we collect, use, and safeguard your data when you use our website or services.</p>

    <h2>1. Information We Collect</h2>
    <p>We may collect the following information:</p>
    <ul>
        <li>Personal information such as name, email, phone number, and address during registration or inquiries.</li>
        <li>Room preferences and stay history for hostel management.</li>
        <li>Technical data like IP address, browser type, and usage patterns via cookies.</li>
    </ul>

    <h2>2. How We Use Your Information</h2>
    <p>Your information is used to:</p>
    <ul>
        <li>Manage hostel bookings and services.</li>
        <li>Respond to your queries and support requests.</li>
        <li>Send newsletters or service updates (with your consent).</li>
        <li>Improve our website and services based on usage data.</li>
    </ul>

    <h2>3. Cookies</h2>
    <p>We use cookies to enhance your experience. Cookies help us remember your preferences and understand how you use our site.</p>

    <h2>4. Data Security</h2>
    <p>We implement strict security measures to ensure your data is protected against unauthorized access, alteration, or disclosure.</p>

    <h2>5. Sharing of Information</h2>
    <p>We do not sell, trade, or share your personal information with third parties, except as required by law or to provide necessary services through trusted partners under confidentiality agreements.</p>

    <h2>6. Your Rights</h2>
    <p>You have the right to access, update, or delete your personal data. To do so, please contact us at <strong>support@munnuhostel.com</strong>.</p>

    <h2>7. Changes to This Policy</h2>
    <p>We may update this Privacy Policy periodically. Any changes will be posted on this page with an updated revision date.</p>

    <h2>8. Contact Us</h2>
    <p>If you have any questions about our Privacy Policy, you can contact us at:</p>
    <p><strong>Email:</strong> support@munnuhostel.com<br/>
       <strong>Phone:</strong> +91-9876543210</p>
</div>

</body>
</html>
<jsp:include page="Footer.jsp" />
