<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ include file="SideBar.jsp" %> <!-- Sidebar Included -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Management System</title>  
    <!-- Link to External CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="Student.css">
    <link rel="stylesheet" href="Heading.css">
     
</head>
<body>
 

<div class="heading-container">
      <h3 class="heading-title">Student Record</h3>
     <p class="heading-subtitle">This is Student Record</p>
      
    </div>

    <div class="student-container">
    
        <div class="student-header">
            <h1>Manage Students</h1>
        </div>

        <form method="GET">
            <div class="student-search-section">
                <input type="text" class="student-search-box" name="searchQuery" placeholder="Search by name or ID">
                <button type="submit" class="student-search-btn">Search</button>
                <button type="button" class="student-reset-btn" onclick="resetForm()">Reset</button>
            </div>

            <div class="student-filter-section">
                <label>Filter by Branch:</label>
                <select name="branchFilter" class="student-filter-dropdown" onchange="this.form.submit()">
                    <option value="all">All Branches</option>
                    <option value="Computer Science (Data Science)">Computer Science (Data Science)</option>
                    <option value="Electrical">Electrical</option>
                </select>
            </div>
        </form>

        <button class="student-add-btn" onclick="toggleForm('add')">Add New Student</button>

        <!-- Student Form Popup -->
        <div id="studentForm" class="student-form-popup">
            <div class="student-form-container">
                <h2>Add Student</h2>
                <form method="POST">
                    <input type="hidden" name="formType" value="insert">
                    <div class="student-form-group">
                        <label>ID:</label>
                        <input type="text" name="id" required>
                    </div>
                    <div class="student-form-group">
                        <label>Name:</label>
                        <input type="text" name="name" required>
                    </div>
                    <div class="student-form-group">
                        <label>Room No:</label>
                        <input type="text" name="roomNo" required>
                    </div>
                    <div class="student-form-group">
                        <label>Branch:</label>
                        <select name="branch">
                            <option value="Computer Science (Data Science)">Computer Science (Data Science)</option>
                            <option value="Electrical">Electrical</option>
                        </select>
                    </div>
                    <div class="student-form-group">
                        <label>Contact:</label>
                        <input type="tel" name="contact" required>
                    </div>
                    <div class="student-form-group">
                        <label>Admission Date:</label>
                        <input type="date" name="admissionDate" required>
                    </div>
                    <button type="submit" class="student-submit-btn">Submit</button>
                    <button type="button" class="student-cancel-btn" onclick="toggleForm('close')">Cancel</button>
                </form>
            </div>
        </div>

        <table class="student-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Room No.</th>
                    <th>Branch</th>
                    <th>Contact</th>
                    <th>Admission Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <!-- Example Row -->
                <tr>
                    <td>1</td>
                    <td>John Doe</td>
                    <td>101</td>
                    <td>Computer Science (Data Science)</td>
                    <td>1234567890</td>
                    <td>2023-10-01</td>
                    <td class="student-action-buttons">
                        <a href="?id=1&name=John Doe&roomNo=101&branch=Computer Science (Data Science)&contact=1234567890&admissionDate=2023-10-01" class="student-edit-link">Edit</a>
                        <a href="?action=delete&id=1" class="student-delete-link" onclick="return confirm('Are you sure?')">Delete</a>
                    </td>
                </tr>
                <!-- Add more rows dynamically from server-side data -->
            </tbody>
        </table>
    </div>

    <script>
        function toggleForm(action) {
            const form = document.getElementById('studentForm');
            if (action === 'add' || action === 'edit') {
                form.style.display = "block";
            } else {
                form.style.display = "none";
                window.history.replaceState({}, document.title, window.location.pathname);
            }
        }

        window.onload = function () {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('id')) {
                toggleForm('edit');
            }
        };

        function resetForm() {
            window.location = window.location.pathname;
        }
    </script>
</body>
</html>
