
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="SideBar.jsp" %> <!-- Sidebar Included -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Wardens</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="Heading.css"> <!-- Link to CSS -->
         <link rel="stylesheet" href="Warden.css">
</head>
<body>

<div class="heading-container">
    <h3 class="heading-title">Warden  Record</h3>
    <p class="heading-subtitle">This is Warden Record</p>
</div>

<div class="manage-wardens">
    <button class="add-warden-btn" onclick="openModal('add')">Add New Warden</button>
    
    <div class="warden-list">
        <div class="warden-card">
            <h3>Warden 1</h3>
            <p><strong>Name:</strong> Suman Kumar</p>
            <p><strong>Contact:</strong> kumarsuman@example.com</p>
            <p><strong>Phone:</strong> +91 12345 67890</p>
            <div class="warden-buttons">
                <button class="edit-btn" onclick="openModal('edit', this)">Edit</button>
                <button class="remove-btn" onclick="deleteWarden(1)">Remove</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div id="wardenModal" class="modal">
    <div class="modal-content">
        <h3 id="modalTitle"></h3>
        <form id="wardenForm">
            <div class="form-group">
                <label>Name:</label>
                <input type="text" name="name" required>
            </div>
            <div class="form-group">
                <label>Contact Email:</label>
                <input type="email" name="contact" required>
            </div>
            <div class="form-group">
                <label>Phone:</label>
                <input type="text" name="phone" required>
            </div>
            <div class="modal-buttons">
                <button type="submit" class="add-btn">Save</button>
                <button type="button" class="cancel-btn" onclick="closeModal()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openModal(mode, element) {
        document.getElementById('wardenModal').style.display = 'flex';
        document.getElementById('modalTitle').textContent = mode === 'add' ? 'Add New Warden' : 'Edit Warden';
    }

    function closeModal() {
        document.getElementById('wardenModal').style.display = 'none';
    }

    function deleteWarden(id) {
        if (confirm('Are you sure you want to delete this warden?')) {
            alert('Warden deleted (demo only)');
        }
    }
</script>

</body>
</html>
