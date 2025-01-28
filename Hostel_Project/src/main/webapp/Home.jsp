

<!-- Include Header -->
<jsp:include page="Header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Munnu Hostel</title>
    <link rel="stylesheet" href="Style/Home.css">
    
    <style>
    .hero-section {
  padding: 40px 20px;
  background: linear-gradient(135deg, #eef2f3, #d4e4ed);
}

.carousel-news-container {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
  justify-content: space-between;
}

.carousel {
  flex: 2;
  position: relative;
  overflow: hidden;
  border-radius: 12px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  background-color: white;
}

.carousel-item {
  display: none;
  position: relative;
  text-align: center;
}

.carousel-item.active {
  display: block;
}

.carousel img {
  border-radius: 12px;
  display: block;
  height: 70vh;
  width: 100%;
  opacity: 1;
}

.carousel-caption {
  position: absolute;
  bottom: 30%;
  left: 50%;
  transform: translateX(-50%);
  color: #f1dbdb;
  padding: 15px 20px;
  border-radius: 8px;
  font-size: 1.2rem;
  text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.5);
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.carousel-caption h1 {
  opacity: 0.8;
  background-color: rgb(100, 172, 196) !important;
  color: #f8eff3;
}

.carousel-caption p {
  background-color: #666;
}

/* Latest News Section */
.latest-news {
  flex: 1;
  background: #44688c;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  color: black;
}

.latest-news h3 {
  font-size: 1.5rem;
  margin-bottom: 15px;
  font-weight: bold;
}

.news-container {
  overflow: hidden;
  height: 400px;
  display: flex;
  background-color: #dce2e7;
  flex-direction: column;
  justify-content: center;
}

.news-scroller {
  display: flex;
  flex-direction: column;
  animation: scroll-news 5s linear infinite;
}

.news-item {
  font-size: 1rem;
  margin-bottom: 10px;
  padding: 10px;
  background: rgba(0, 0, 0, 0.2);
  border-radius: 8px;
  text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.4);
}

@keyframes scroll-news {
  0% {
    transform: translateY(0);
  }
  100% {
    transform: translateY(-100%);
  }
}
    </style>
</head>
<body>
    <div class="home">
        <!-- Hero Section -->
        <div class="hero-section">
            <div class="carousel-news-container">
                <div class="carousel">
                    <% 
                        String[][] carouselImages = {
                            {"image3.png", "Comfortable Rooms for a Relaxing Stay"},
                            {"image2.png", "Enjoy Delicious and Nutritious Meals"},
                            {"Hostel.png", "A Friendly Community You'll Love"}
                        };
                        for (int i = 0; i < carouselImages.length; i++) {
                    %>
                    <div class="carousel-item">
                        <img src="<%= carouselImages[i][0] %>" alt="Slide <%= i + 1 %>" />
                        <div class="carousel-caption">
                            <h1>Welcome To Munnu Hostel</h1>
                            <p><%= carouselImages[i][1] %></p>
                        </div>
                    </div>
                    <% } %>
                </div>
                <div class="latest-news">
                    <h3>Notice and News</h3>
                    <div class="news-container">
                        <div class="news-scroller">
                            <% 
                                String[] latestNews = {
                                    "🌟 Exclusive Deal: Stay for 5 nights, pay for 4!",
                                    "🍳 Breakfast is now included with all bookings.",
                                    "🛏 Private rooms now available for solo travelers!",
                                    "🎨 Art and craft workshop this Sunday at 4 PM.",
                                    "📚 Study zones upgraded with high-speed WiFi.",
                                    "🎶 Join our weekly karaoke nights every Thursday!",
                                    "🚴 Bike rentals are now available for exploring the area.",
                                    "🎂 Celebrate your special day with us and enjoy a free dinner!",
                                    "🧹 Deep cleaning scheduled for all rooms this weekend.",
                                    "🔥 Bonfire night: Join us for marshmallows and stories on Saturday!"
                                };
                                for (String news : latestNews) {
                            %>
                            <div class="news-item"><%= news %></div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- About Section -->
        <section class="about">
            <div class="about-content">
                <h2>About Munnu Hostel</h2>
                <p>
                    Munnu Hostel offers a unique blend of comfort and affordability.
                    With spacious rooms, delicious meals, and friendly staff, we ensure
                    that your stay is unforgettable.
                </p>
                <button class="btn-secondary">Learn More</button>
            </div>
            <div class="about-image">
                <img src="Hostel.png" alt="About Munnu Hostel" />
            </div>
        </section>

        <!-- Features Section -->
        <section class="features">
            <h2>Our Amenities</h2>
            <div class="features-cards">
                <div class="feature-card">
                    <img src="Wifi.png" alt="Free WiFi" />
                    <h3>Free WiFi</h3>
                    <p>Stay connected with high-speed internet throughout the hostel.</p>
                </div>
                <div class="feature-card">
                    <img src="Food.png" alt="Delicious Meals" />
                    <h3>Delicious Meals</h3>
                    <p>Enjoy freshly prepared, nutritious meals daily.</p>
                </div>
                <div class="feature-card">
                    <img src="Security.png" alt="24/7 Security" />
                    <h3>24/7 Security</h3>
                    <p>Your safety is our top priority, with round-the-clock security.</p>
                </div>
            </div>
        </section>

        <!-- Testimonials Section -->
        <section class="testimonials">
            <h2>What Our Guests Say</h2>
            <div class="testimonial-cards">
                <div class="testimonial-card">
                    <p>"The perfect place to stay! Clean, friendly staff, and great food."</p>
                    <span>- Ashish Sah</span>
                </div>
                <div class="testimonial-card">
                    <p>"Affordable and comfortable. I felt at home throughout my stay."</p>
                    <span>- Ram Prasad</span>
                </div>
                <div class="testimonial-card">
                    <p>"Affordable and comfortable. I felt at home throughout my stay."</p>
                    <span>- Ram Prasad</span>
                </div>
                <div class="testimonial-card">
                    <p>"Affordable and comfortable. I felt at home throughout my stay."</p>
                    <span>- Ram Prasad</span>
                </div>
            </div>
        </section>
    </div>
</body>
</html>
<!-- Include Header -->
<jsp:include page="Footer.jsp" />