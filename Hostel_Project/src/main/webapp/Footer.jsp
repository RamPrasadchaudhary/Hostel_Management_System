<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Footer</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Style/Footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-dyE/Xg8fOa4qV2F5kAvpEr6Kkg5Aupc/V6nCE8k6KIL7S/XtB7o3wT54miWxFgYzI+9Vf9G06nQw2K48DExCA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <footer class="footer">
        <div class="footer-container">
            <!-- About Us Section -->
            <div class="footer-section">
                <h4>About Us</h4>
                <ul>
                    <li><a href="#">Our Story</a></li>
                    <li><a href="#">Our Team</a></li>
                    <li><a href="#">Careers</a></li>
                </ul>
            </div>

            <!-- Help & Support Section -->
            <div class="footer-section">
                <h4>Help & Support</h4>
                <ul>
                    <li><a href="#">FAQs</a></li>
                    <li><a href="#">Contact Us</a></li>
                    <li><a href="#">Terms & Conditions</a></li>
                </ul>
            </div>

            <!-- Follow Us Section -->
            <div class="footer-section">
                <h4>Follow Us</h4>
                <ul>
                    <li><a href="#" target="_blank" rel="noopener noreferrer"><i class="fa fa-facebook" aria-hidden="true"></i> Facebook</a></li>
                    <li><a href="#" target="_blank" rel="noopener noreferrer"><i class="fa fa-twitter" aria-hidden="true"></i> Twitter</a></li>
                    <li><a href="#" target="_blank" rel="noopener noreferrer"><i class="fa fa-instagram" aria-hidden="true"></i> Instagram</a></li>
                </ul>
            </div>

            <!-- Newsletter Section -->
            <div class="footer-section">
                <h4>Newsletter</h4>
                <p>Stay up to date with our latest news and updates.</p>
                <form action="#" method="post">
                    <input type="email" name="email" placeholder="Enter your email address" required />
                    <button type="submit">Subscribe</button>
                </form>
            </div>
        </div>

        <!-- Footer Bottom Section -->
        <div class="footer-bottom">
            <p>&copy; 2025 Munnu Hostel. All rights reserved.</p>
            <ul>
                <li><a href="policy.jsp">Privacy Policy</a></li>
                <li><a href="#">Cookies Policy</a></li>
            </ul>
        </div>
    </footer>
</body>
</html>
