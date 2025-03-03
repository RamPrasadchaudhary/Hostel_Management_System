<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="SideBar.jsp" %> <!-- Sidebar Included -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Payments</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="Style/Payment.css">
       <link rel="stylesheet" href="Heading.css">
</head>
<body>
    <div class="heading-container">
        <h3 class="heading-title">Payment  Record</h3>
        <p class="heading-subtitle">This is the Payment page</p>
    </div>
    <!-- Main Content -->
    <div class="main-content">
      
        <!-- Payment Table -->
        <div class="payment-table">
            <table>
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Name</th>
                        <th>Due Amount</th>
                        <th>Paid Amount</th>
                        <th>Remaining Amount</th>
                        <th>Last Payment Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1001</td>
                        <td>Ashish Raj</td>
                        <td>₹1500</td>
                        <td>₹1200</td>
                        <td>₹300</td>
                        <td>2024-09-10</td>
                        <td>
                            <a href="updatepayment.jsp" class="update-button">Update</a>
                            <a href="acceptpayment.jsp" class="accept-button">Accept Payment</a>
                        </td>
                    </tr>
                    <tr>
                        <td>1002</td>
                        <td>Rishu Kumar</td>
                        <td>₹2600</td>
                        <td>₹1400</td>
                        <td>₹1200</td>
                        <td>2024-09-09</td>
                        <td>
                            <a href="updatepayment.jsp" class="update-button">Update</a>
                            <a href="acceptpayment.jsp" class="accept-button">Accept Payment</a>
                        </td>
                    </tr>
                    <!-- Additional rows can be added here -->
                </tbody>
            </table>
        </div>
    </div>
</body>

<script>

//Function to handle the 'Update' button click
function handleUpdate(studentId) {
    // Redirect to the update payment page with the student's ID
    window.location.href = `updatepayment.html?studentId=${studentId}`;
}

// Function to handle the 'Accept Payment' button click
function handleAcceptPayment(studentId) {
    // Confirm the payment acceptance
    const confirmation = confirm(`Are you sure you want to accept the payment for Student ID: ${studentId}?`);
    if (confirmation) {
        // Proceed with payment acceptance logic
        // For example, update the payment status in the database
        alert(`Payment for Student ID: ${studentId} has been accepted.`);
        // Optionally, you can refresh the page or update the table to reflect the changes
        location.reload();
    }
}

// Add event listeners to the 'Update' and 'Accept Payment' buttons
document.addEventListener('DOMContentLoaded', () => {
    const updateButtons = document.querySelectorAll('.update-button');
    const acceptButtons = document.querySelectorAll('.accept-button');

    updateButtons.forEach(button => {
        button.addEventListener('click', (event) => {
            const studentId = event.target.closest('tr').querySelector('td:first-child').textContent;
            handleUpdate(studentId);
        });
    });

    acceptButtons.forEach(button => {
        button.addEventListener('click', (event) => {
            const studentId = event.target.closest('tr').querySelector('td:first-child').textContent;
            handleAcceptPayment(studentId);
        });
    });
});

</script>
</html>
