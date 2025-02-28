function toggleTable(tableId) {
    let tables = document.querySelectorAll('.table-container');
    tables.forEach(table => {
        if (table.id === tableId) {
            table.style.display = table.style.display === 'none' || table.style.display === '' ? 'block' : 'none';
        } else {
            table.style.display = 'none';
        }
    });
}

function allowUser(id, role) {
    let username = document.getElementById(`username_${role}_${id}`).value;
    let password = document.getElementById(`password_${role}_${id}`).value;

    if (username.trim() === "" || password.trim() === "") {
        alert("Username and Password cannot be empty!");
        return;
    }

    let form = document.createElement("form");
    form.method = "POST";
    form.action = "Hostel-Project/UserServlet"; // Ensure correct servlet path

    let userIdField = document.createElement("input");
    userIdField.type = "hidden";
    userIdField.name = "user_id";
    userIdField.value = id;

    let usernameField = document.createElement("input");
    usernameField.type = "hidden";
    usernameField.name = "username";
    usernameField.value = username;

    let passwordField = document.createElement("input");
    passwordField.type = "hidden";
    passwordField.name = "password";
    passwordField.value = password;

    let roleField = document.createElement("input");
    roleField.type = "hidden";
    roleField.name = "role";
    roleField.value = role;

    form.appendChild(userIdField);
    form.appendChild(usernameField);
    form.appendChild(passwordField);
    form.appendChild(roleField);
    document.body.appendChild(form);
    form.submit();
}

function allowAdmin() {
    allowUser(0, "Admin");
}

// Hide message box after 5 seconds


function updateUser(userId, role) {
    let username = document.getElementById(`username_${role}_${userId}`).value.trim();
    let password = document.getElementById(`password_${role}_${userId}`).value.trim();

    if (username === "" || password === "") {
        alert("Username and Password cannot be empty!");
        return;
    }

    let formData = new FormData();
    formData.append("user_id", userId);
    formData.append("username", username);
    formData.append("password", password);
    formData.append("role", role);

    fetch("UpdateUserServlet", {
        method: "POST",
        body: formData,
    })
    .then(response => response.text())
    .then(data => {
        console.log("Response from server:", data);
        if (data.includes("success")) {
            alert("User updated successfully!");
            window.location.reload(); // Refresh only on success
        } else {
            alert("Update failed: " + data);
        }
    })
    .catch(error => {
        console.error("Error:", error);
        alert("Error updating user. Please try again.");
    });
}
