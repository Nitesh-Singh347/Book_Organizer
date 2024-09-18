<%@ page import="java.util.List"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Generate Bill</title>
<style>
/* General Page Styling */
body {
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
    height: 100%;
    margin: 0;
    background-color: white;
    font-family: 'Roboto', sans-serif;
    color: #333;
}

.container {
    background-color: white;
    padding: 50px 40px;
    border-radius: 12px;
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2), 0 6px 6px rgba(0, 0, 0, 0.15);
    max-width: 500px;
    width: 100%;
}

/* Navbar Styling */
header {
    width: 100%;
    background-color: #34495e;
}

.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 50px;
}

.navbar-brand {
    font-size: 1.8rem;
    color: #ecf0f1;
    font-weight: bold;
    letter-spacing: 1px;
    text-decoration: none;
}

.navbar .btn-custom {
    border-radius: 30px;
    text-decoration:none;
    font-size: 1rem;
    padding: 10px 20px;
    background-color: #ecf0f1;
    color: #34495e;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.navbar .btn-custom:hover {
    background-color: #bdc3c7;
}

/* Form and Table Styling */
h2 {
    text-align: center;
    margin-bottom: 30px;
    font-size: 24px;
    color: #222;
    font-weight: 600;
}

.form-group {
    margin-bottom: 20px;
    margin-top:20px;
}

.form-group label {
    font-size: 16px;
    font-weight: 500;
    color: #555;
}

.form-group input {
    width: 100%;
    padding: 10px;
    margin-top: 8px;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 16px;
    box-sizing: border-box;
}

.form-group input:focus {
    border-color: #667eea;
    outline: none;
}

button {
    width: 100%;
    padding: 15px;
    margin: 20px 0;
    border: none;
    border-radius: 8px;
    background: linear-gradient(to right, #667eea, #764ba2);
    color: white;
    font-size: 18px;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.3s;
}

button:hover {
    background: linear-gradient(to right, #764ba2, #667eea);
}

.added-books {
    margin-top: 40px;
    border-top: 2px solid #e0e0e0;
    padding-top: 20px;
}

.added-books table {
    width: 100%;
    border-collapse: collapse;
}

.added-books table th, .added-books table td {
    padding: 14px;
    border: 1px solid #ddd;
    font-size: 16px;
}

.added-books table th {
    background-color: #f1f1f1;
    color: #667eea;
    font-weight: 700;
}

.error-message {
    color: red;
    text-align: center;
    margin-top: 20px;
    font-size: 14px;
}
</style>

<script>
// Function to validate "Add Book" form submission
function validateAddBookForm() {
    const customerName = document.getElementById('customerName').value;
    const customerContact = document.getElementById('customerContact').value;
    
    if (customerName.trim() === "" || customerContact.trim() === "") {
        alert("Please enter both Customer Name and Contact.");
        return false;
    }
    return true;
}

// Function to validate before generating bill
function validateGenerateBill() {
    const bookRows = document.querySelectorAll('.added-books tbody tr');
    const noBooksAdded = bookRows.length === 1 && bookRows[0].textContent.includes("No books added yet.");
    
    if (noBooksAdded) {
        alert("Please add at least one book before generating the bill.");
        return false;
    }
    return true;
}
</script>

</head>
<body>

<!-- Navbar at the top of the page -->
<header>
    <nav class="navbar">
        <a class="navbar-brand" href="GenerateBill.jsp">Generate Bill</a>
        <a href="HomePage.jsp" class="btn-custom">Go To Home</a>
    </nav>
</header>

<!-- Main content container -->
<div class="container">
    <h2>Generate Bill</h2>

    <!-- Customer details form -->
    <form action="GenerateBillServlet" method="post" onsubmit="return validateAddBookForm()">
        <div class="form-group">
            <label for="customerName">Customer Name:</label>
            <input type="text" id="customerName" name="customerName"
                value="<%=session.getAttribute("customerName") != null ? session.getAttribute("customerName") : ""%>"
                required>
        </div>
        <div class="form-group">
            <label for="customerContact">Customer Contact:</label>
            <input type="text" id="customerContact" name="customerContact"
                value="<%=session.getAttribute("customerContact") != null ? session.getAttribute("customerContact") : ""%>"
                required>
        </div>
        <button type="submit">Add Book</button>
    </form>

    <!-- Added books section -->
    <div class="added-books">
        <h3>Added Books</h3>
        <table>
            <thead>
                <tr>
                    <th>Book Title</th>
                    <th>Price</th>
                    <th>Quantity</th>
                </tr>
            </thead>
            <tbody>
                <%
                List<String[]> books = (List<String[]>) session.getAttribute("books");
                if (books != null) {
                    for (String[] book : books) {
                        String bookTitle = book[0];
                        String price = book[4];
                        int Quantity = Integer.parseInt(book[9]);
                %>
                <tr>
                    <td><%=bookTitle%></td>
                    <td>$<%=price%></td>
                    <td><%=Quantity%></td>
                </tr>
                <%
                }
                } else {
                %>
                <tr>
                    <td colspan="3" style="text-align: center;">No books added yet.</td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>

    <!-- Generate bill button -->
    <form action="payReceipt.jsp" method="post" onsubmit="return validateGenerateBill()">
        <button type="submit">Generate Bill</button>
    </form>

    <!-- Error message -->
    <%
    String error = (String) request.getAttribute("error");
    if (error != null) {
    %>
    <div class="error-message">
        <%=error%>
    </div>
    <%
    }
    %>
</div>

</body>
</html>
