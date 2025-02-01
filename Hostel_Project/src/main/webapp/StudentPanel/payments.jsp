<%@ page contentType="text/html; charset=UTF-8" language="java" %>
  <%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Monthly Dues</title>
    <link rel="icon" href="./Components/Images/img.png" type="image/png">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="payments.css">
</head>
<body>
   
    <section id="payments">
        <h2>Monthly Dues</h2>
        <table>
            <thead>
                <tr>
                    <th>Month</th>
                    <th>Amount Due</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%-- Example dynamic data: you will need to fetch this from the database in your backend (e.g., via a servlet or JSTL). --%>
                <c:forEach var="payment" items="${payments}">
                    <tr>
                        <td>${payment.month}</td>
                        <td>₹${payment.amountDue}</td>
                        <td>${payment.status}</td>
                        <td class="actions">
                            <c:if test="${payment.status == 'Paid'}">
                                <a href="#" class="download-receipt">Download Receipt</a>
                            </c:if>
                            <c:if test="${payment.status != 'Paid'}">
                                <a href="#" class="na">N/A</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="total-balance">
            <h3>Total Balance Due</h3>
            <p>₹${totalBalance}</p>
            <a href="payment-options.jsp" class="button">Pay Now</a>
        </div>
    </section>
    <footer>
        <p>&copy; 2024 Hostel Management</p>
    </footer>
</body>
</html>
