<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <%@ include file="SideBar.jsp" %> <!-- Sidebar Included -->	
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Staff</title>
    <link rel="stylesheet" type="text/css" href="staff.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
          <link rel="stylesheet" type="text/css" href="Heading.css">
    
</head>
<body>
<%@ include file="Heading.jsp" %>  
    <div class="manage-staff-wrapper">
        <div class="manage-staff-container">
            <div class="staff-filters">
                <form method="get" action="ManageStaff.jsp">
                    <input type="text" name="searchQuery" placeholder="Search staff...">
                    <button type="submit" class="search-button"><i class="fas fa-eye"></i> Search</button>
                    <button type="reset" class="reset-button"><i class="fas fa-trash"></i> Reset</button>
                    <select name="selectedRole">
                        <option value="All Roles">All Roles</option>
                        <option value="Electrician">Electrician</option>
                        <option value="Manager">Manager</option>
                        <option value="Plumber">Plumber</option>
                    </select>
                    <button type="button" class="add-staff-button" onclick="openModal('add')">
                        <i class="fas fa-plus"></i> Add New Staff
                    </button>
                </form>
            </div>
            <div class="staff-list">
                <table class="staff-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Role</th>
                            <th>Joining Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>STF001</td>
                            <td>Amarjeet Kumar</td>
                            <td>Electrician</td>
                            <td>2024-01-15</td>
                            <td>
                                <button class="action-button view" onclick="openModal('view', 'STF001')">
                                    <i class="fas fa-eye"></i> View
                                </button>
                                <button class="action-button edit" onclick="openModal('edit', 'STF001')">
                                    <i class="fas fa-edit"></i> Edit
                                </button>
                                <button class="action-button delete" onclick="deleteStaff('STF001')">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div id="staffModal" class="modal" style="display:none;">
        <div class="modal-content">
            <h3 id="modalTitle"></h3>
            <form method="post" action="ManageStaffServlet">
                <input type="hidden" name="id" id="staffId">
                <label>Name:</label>
                <input type="text" name="name" id="staffName" required>
                <label>Role:</label>
                <input type="text" name="role" id="staffRole" required>
                <label>Joining Date:</label>
                <input type="date" name="joiningDate" id="staffJoiningDate" required>
                <button type="submit" id="modalActionBtn"></button>
                <button type="button" onclick="closeModal()">Cancel</button>
            </form>
        </div>
    </div>

    <script>
        function openModal(type, id) {
            document.getElementById("staffModal").style.display = "block";
            document.getElementById("modalTitle").innerText = type === 'add' ? "Add New Staff" : "Edit Staff";
            document.getElementById("modalActionBtn").innerText = type === 'add' ? "Add" : "Save";
            if (type === 'edit') {
                document.getElementById("staffId").value = id;
            }
        }
        function closeModal() {
            document.getElementById("staffModal").style.display = "none";
        }
        function deleteStaff(id) {
            if (confirm("Are you sure you want to delete this staff member?")) {
                window.location.href = "ManageStaffServlet?deleteId=" + id;
            }
        }
    </script>
</body>
</html>
