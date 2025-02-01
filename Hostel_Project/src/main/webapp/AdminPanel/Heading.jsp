<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Staff</title>
 <style>
    /* General Styling for the Heading Component */
.heading-container {
margin-left:110px;
margin-bottom:100px;
    text-align: center; /* Center align the heading */
    padding: 10px 15px; /* Space around the heading */
     background-color: blue; /* Blue background color */
    color: white; /* White text color */
    border-bottom: 4px solid #0056b3; /* Add a darker border for effect */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Subtle shadow below the header */
  }
  
  .heading-title {
  color:white;
    font-size: 2.5rem; /* Large font size for the title */
    margin: 0; /* Remove default margin */
    font-weight: bold; /* Bold font */
    color:white;
  }
  
  .heading-subtitle {
    font-size: 1.2rem; /* Smaller font size for the subtitle */
    margin: 10px 0 0 0; /* Add space above the subtitle */
    font-weight: 400; /* Regular font weight */
    color:white;
  }
 
  /* Responsive Styles */
  @media (max-width: 768px) {
    .heading-title {
      font-size: 2rem; /* Adjust title font size for tablets */
    }
  .heading-container{
  margin-bottom:10px;
  margin-left:0px}
    .heading-subtitle {
      font-size: 1rem; /* Adjust subtitle font size */
    }
  }
  
  @media (max-width: 480px) {
    .heading-title {
      font-size: 1.8rem; /* Smaller font size for mobile devices */
    }
  
    .heading-subtitle {
      font-size: 0.9rem; /* Adjust subtitle font size for mobile */
    }
  }
  
    </style>
</head>
<body>
<div class="heading-container">
      <h3 class="heading-title">Staff Record</h3>
     <p class="heading-subtitle">This is Staff Record</p>
      
    </div>
</body>
</html>



