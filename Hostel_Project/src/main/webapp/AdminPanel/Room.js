/**
 * 
 */
function openModal(type, roomId = null) {
           if (type === 'allocate') {
               document.getElementById("roomId").value = roomId;
               fetchStudents();
           }
           document.getElementById(type + "Modal").style.display = "flex";
       }

       function closeModal() {
           document.querySelectorAll('.modal').forEach(modal => modal.style.display = "none");
       }

       function fetchStudents() {
           fetch("GetStudentsServlet")
               .then(response => response.json())
               .then(data => {
                   let studentDropdown = document.getElementById("studentDropdown");
                   studentDropdown.innerHTML = "";
                   data.students.forEach(student => {
                       let option = document.createElement("option");
                       option.value = student.id;
                       option.textContent = student.name;
                       studentDropdown.appendChild(option);
                   });
               })
               .catch(error => console.error("Error fetching students:", error));
       }

       function allocateRoom() {
           let roomId = document.getElementById("roomId").value;
           let studentId = document.getElementById("studentDropdown").value;

           fetch("AllocateRoomServlet", {
               method: "POST",
               headers: { "Content-Type": "application/json" },
               body: JSON.stringify({ roomId, studentId })
           })
           .then(response => response.json())
           .then(data => {
               if (data.success) {
                   alert("Room allocated successfully!");
                   closeModal();
                   location.reload();
               } else {
                   alert("Allocation failed: " + data.message);
               }
           })
           .catch(error => console.error("Error allocating room:", error));
       }

       function addRoom() {
           let roomNumber = document.getElementById("roomNumber").value;

           fetch("AddRoomServlet", {
               method: "POST",
               headers: { "Content-Type": "application/json" },
               body: JSON.stringify({ roomNumber })
           })
           .then(response => response.json())
           .then(data => {
               if (data.success) {
                   alert("Room added successfully!");
                   closeModal();
                   location.reload();
               } else {
                   alert("Failed to add room: " + data.message);
               }
           })
           .catch(error => console.error("Error adding room:", error));
       }

       function deleteRoom(roomId) {
           if (confirm("Are you sure you want to delete this room?")) {
               fetch("DeleteRoomServlet", {
                   method: "POST",
                   headers: { "Content-Type": "application/json" },
                   body: JSON.stringify({ roomId })
               })
               .then(response => response.json())
               .then(data => {
                   if (data.success) {
                       alert("Room deleted successfully!");
                       location.reload();
                   } else {
                       alert("Deletion failed: " + data.message);
                   }
               })
               .catch(error => console.error("Error deleting room:", error));
           }
       }