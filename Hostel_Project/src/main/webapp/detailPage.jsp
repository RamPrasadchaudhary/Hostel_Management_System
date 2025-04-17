<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="Header.jsp" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Learn More - Munnu Hostel</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    /* Reset and Global Styles */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #edf2f7;
      color: #333;
      line-height: 1.6;
    }
    a {
      text-decoration: none;
      color: inherit;
    }
    
    /* Main Container */
    .container {
      max-width: 1100px;
      margin: 40px auto;
      background: #fff;
      border-radius: 8px;
      padding: 20px 40px;
      box-shadow: 0 8px 16px rgba(0,0,0,0.1);
      animation: fadeIn 1s ease forwards;
      opacity: 0;
    }
    
    /* Hero Section */
    .hero {
      position: relative;
      width: 100%;
      height: 300px;
      background: url('Image/Mission1.png') center/cover no-repeat;
      border-radius: 8px;
      margin-bottom: 30px;
    }
    .hero::after {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      height: 100%;
      width: 100%;
      background: rgba(0, 0, 0, 0.5);
      border-radius: 8px;
    }
    .hero h1 {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      color: #fff;
      font-size: 2.8rem;
      text-align: center;
    }
    
    /* Grid Sections for Alternating Content */
    .section {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 20px;
      margin-bottom: 40px;
    }
    .card {
      background: #f7fafc;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.05);
      transition: transform 0.3s ease;
      overflow: hidden;
    }
    .card:hover {
      transform: translateY(-5px);
    }
    .card h2 {
      margin-bottom: 10px;
      color: #2d3748;
      border-bottom: 2px solid #2d3748;
      padding-bottom: 5px;
    }
    .card p {
      color: #4a5568;
    }
    
    /* Image-Text Cards: Centered Image Version */
    .image-card {
      display: flex;
      flex-direction: column;
      align-items: center;
      text-align: center;
    }
    .image-card img {
      max-width: 100%;
      height: auto;
      border-radius: 5px;
      margin-bottom: 15px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      transition: transform 0.3s ease;
    }
    .image-card img:hover {
      transform: scale(1.02);
    }
    
    /* Essential Animation: Fade In */
    @keyframes fadeIn {
      from {
        opacity: 0;
        transform: translateY(20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
    
    /* Responsive Adjustments */
    @media (max-width: 1024px) {
      .container {
        padding: 20px 30px;
      }
    }
    
    /* For screens below 768px, stack the grid columns into one column */
    @media (max-width: 768px) {
      .container {
        padding: 15px 20px;
        margin: 20px auto;
      }
      .hero {
        height: 220px;
      }
      .hero h1 {
        font-size: 2rem;
      }
      .section {
        grid-template-columns: 1fr;
        gap: 15px;
      }
      .card {
        padding: 15px;
      }
      .card h2 {
        font-size: 1.5rem;
      }
      .card p {
        font-size: 0.95rem;
      }
    }
    
    @media (max-width: 480px) {
      .hero h1 {
        font-size: 1.8rem;
        padding: 0 10px;
      }
      .card h2 {
        font-size: 1.4rem;
      }
      .card p {
        font-size: 0.9rem;
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <!-- Hero Section -->
    <div class="hero">
      <h1>Discover Munnu Hostel</h1>
    </div>
    
    <!-- About Section -->
    <div class="section">
      <div class="card image-card">
        <img src="Image/Mission5.jpg" alt="About Munnu Hostel">
      </div>
      <div class="card">
        <h2>Our Story</h2>
        <p>
          Munnu Hostel began as a vision to create affordable, quality accommodation. Today, it’s a trusted name in hospitality, offering a warm and inviting space for travelers, students, and professionals.
        </p>
      </div>
    </div>
    
    <!-- Mission & Values Section -->
    <div class="section">
      <div class="card">
        <h2>Our Mission &amp; Values</h2>
        <p>
          We are committed to delivering an exceptional living experience that blends modern amenities, security, and community. Our core values—integrity, respect, and excellence—are at the heart of everything we do.
        </p>
      </div>
      <div class="card image-card">
        <img src="Image/Mission4.jpg" alt="Our Mission">
      </div>
    </div>
    	
    <!-- Facilities Section -->
    <div class="section">
      <div class="card image-card">
        <img src="Image/Mission2.jpg" alt="Our Facilities">
      </div>
      <div class="card">
        <h2>Our Facilities</h2>
        <p>
          Experience modern, well-maintained rooms, high-speed internet, 24/7 security, and freshly prepared meals—all designed to enhance your stay and make you feel at home.
        </p>
      </div>
    </div>
    
    <!-- Community Section -->
    <div class="section">
      <div class="card">
        <h2>The Munnu Hostel Community</h2>
        <p>
          More than just accommodation, Munnu Hostel is a community where guests connect, share experiences, and create memories. Join us for social events and become part of our vibrant family.
        </p>
      </div>
      <div class="card image-card">
        <img src="Image/Mission3.jpg" alt="Our Community">
      </div>
    </div>
  </div>
  <jsp:include page="Footer.jsp" />
</body>
</html>
