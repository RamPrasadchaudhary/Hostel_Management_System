<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="Header.jsp" />
<!DOCTYPE html>
<html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hostel Dashboard Login</title>
 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
        <link rel="stylesheet" href="Style/Login.css">
    <style>
    /* General reset and box-sizing */
    
   label{
 font-weight:Bold;
 font-size:16px;
   }
    </style>
  </head>
  <body>
    <div class="login-container">
      <div class="form-wrapper">
        <h2>Hostel Dashboard Login</h2>
        <form id="login-form" class="form">
          <div class="flex-column">
            <label for="role">Select Role</label>
            <div class="inputForm">
              <i class="fa-solid fa-user-tie" id="role-icon"></i>
              <select name="role" id="role" class="input" required>
                <option value="" disabled selected>Select your role</option>
                <option value="student" data-icon="fa-solid fa-user-graduate">
                  Student
                </option>
                <option value="staff" data-icon="fa-solid fa-users">
                  Staff
                </option>
                <option value="warden" data-icon="fa-solid fa-person-cane">
                  Warden
                </option>
                <option value="admin" data-icon="fa-solid fa-user-shield">
                  Admin
                </option>
              </select>
            </div>
            <p id="role-message" class="role-message">
              Please select your role
            </p>
          </div>
          <div class="flex-column">
            <label for="username">Username</label>
            <div class="inputForm">
              <i class="fa-solid fa-user"></i>
              <input
                type="text"
                name="username"
                id="username"
                class="input"
                placeholder="Enter your username"
                required
              />
            </div>
          </div>
          <div class="flex-column">
            <label for="password">Password</label>
            <div class="inputForm">
              <i class="fa-solid fa-lock"></i>
              <input
                type="password"
                name="password"
                id="password"
                class="input"
                placeholder="Enter your password"
                required
              />
            </div>
          </div>
          <button type="submit" id="login-btn" class="button-submit">
            Login
          </button>
          <p id="forgot-password" class="forgot-password">Forgot Password?</p>
          <p id="forgot-password-message" class="forgot-password-message"></p>
          
      </div>
    </div>

    <script src="script.js"></script>
  </body>
</html>

  <jsp:include page="Footer.jsp" />