// Helper function to get contact value (either from an input or span)

        function getContactValue(role, id) {
            let element = document.getElementById(`contact_${role}_${id}`);
            if (element) {
                // If it's an input, return its value; otherwise, return the text content.
                if (element.tagName.toLowerCase() === "input") {
                    return element.value;
                } else {
                    return element.textContent;
                }
            }
            return "";
        }

        // Function to allow a user by submitting a form to the UserServlet.
        function allowUser(id, role) {
            let contact = getContactValue(role, id);
            let password = document.getElementById(`password_${role}_${id}`).value;

            if (contact.trim() === "" || password.trim() === "") {
                alert("Contact and Password cannot be empty!");
                return;
            }

            // Create a form dynamically.
            let form = document.createElement("form");
            form.method = "POST";
            // Use contextPath so the URL is correct (e.g., "/Hostel_Project/servlet/UserServlet")
            form.action = contextPath + "/servlet/UserServlet";

            // Create hidden fields.
            let userIdField = document.createElement("input");
            userIdField.type = "hidden";
            userIdField.name = "user_id";
            userIdField.value = id;
            form.appendChild(userIdField);

            let contactField = document.createElement("input");
            contactField.type = "hidden";
            contactField.name = "contact";
            contactField.value = contact;
            form.appendChild(contactField);

            let passwordField = document.createElement("input");
            passwordField.type = "hidden";
            passwordField.name = "password";
            passwordField.value = password;
            form.appendChild(passwordField);

            let roleField = document.createElement("input");
            roleField.type = "hidden";
            roleField.name = "role";
            roleField.value = role;
            form.appendChild(roleField);

            // Append form to body and submit.
            document.body.appendChild(form);
            form.submit();
        }

        // Function to update a user using fetch.
        function updateUser(userId, role) {
            let contact = getContactValue(role, userId).trim();
            let password = document.getElementById(`password_${role}_${userId}`).value.trim();

            if (contact === "" || password === "") {
                alert("Contact and Password cannot be empty!");
                return;
            }

            let formData = new FormData();
            formData.append("user_id", userId);
            formData.append("contact", contact);
            formData.append("password", password);
            formData.append("role", role);

            // Build the URL with contextPath.
            fetch(contextPath + "/servlet/UpdateUserServlet", {
                method: "POST",
                body: formData,
            })
            .then(response => response.text())
            .then(data => {
                console.log("Response from server:", data);
                if (data.includes("success")) {
                    alert("User updated successfully!");
                    window.location.reload();
                } else {
                    alert("Update failed: " + data);
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("Error updating user. Please try again.");
            });
        }

        // Function to allow admin user.
        function allowAdmin() {
            let contact = document.getElementById("contact_Admin_0").value;
            let password = document.getElementById("password_Admin_0").value;

            if (contact.trim() === "" || password.trim() === "") {
                alert("Contact and Password cannot be empty!");
                return;
            }

            let form = document.createElement("form");
            form.method = "POST";
            form.action = contextPath + "/servlet/UserServlet";

            let contactField = document.createElement("input");
            contactField.type = "hidden";
            contactField.name = "contact";
            contactField.value = contact;
            form.appendChild(contactField);

            let passwordField = document.createElement("input");
            passwordField.type = "hidden";
            passwordField.name = "password";
            passwordField.value = password;
            form.appendChild(passwordField);

            let roleField = document.createElement("input");
            roleField.type = "hidden";
            roleField.name = "role";
            roleField.value = "Admin";
            form.appendChild(roleField);

            document.body.appendChild(form);
            form.submit();
        }