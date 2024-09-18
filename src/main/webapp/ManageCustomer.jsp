<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Customer</title>
<!-- Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom CSS -->
<style>
body {
	background-color: #f4f7fc;
	font-family: 'Roboto', sans-serif;
}

.navbar {
	background-color: #34495e;
}

.navbar-brand {
	font-size: 1.8rem;
	color: #ecf0f1;
	font-weight: bold;
	letter-spacing: 1px;
}

.btn-custom {
	border-radius: 30px;
	font-size: 1rem;
	padding: 10px 20px;
}

.btn-update {
	background-color: #2ecc71;
	color: #fff;
	border-radius: 20px;
	padding: 5px 15px;
	transition: 0.3s;
}

.btn-update:hover {
	background-color: #27ae60;
}

.btn-delete {
	background-color: #e74c3c;
	color: #fff;
	border-radius: 20px;
	padding: 5px 15px;
	transition: 0.3s;
}

.btn-delete:hover {
	background-color: #c0392b;
}

.table-container {
	margin-top: 50px;
}

.search-bar {
	display: flex;
	justify-content: center;
	margin-bottom: 30px;
}

.search-bar input {
	width: 50%;
	height: 45px;
	border-radius: 30px;
	padding-left: 20px;
	border: 1px solid #ced4da;
}

.table {
	background-color: #fff;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.table thead {
	background-color: #34495e;
	color: #fff;
}

.table tbody tr {
	transition: 0.3s;
}

.table tbody tr:hover {
	background-color: #ecf0f1;
}

.action-buttons button {
	margin: 0 5px;
	transition: 0.3s;
}
</style>
</head>
<body>

	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark">
		<a class="navbar-brand" href="ManageCustomer.jsp">Manage Customer</a>
		<div class="collapse navbar-collapse justify-content-end">
			<a href="HomePage.jsp" class="btn btn-light btn-custom">Go To Home</a>
		</div>
	</nav>

	<!-- Main Content -->
	<div class="container table-container">
		<h2 class="text-center mb-4">Customer Transactions</h2>

		<!-- Search Bar -->
		<div class="search-bar">
			<input type="text" id="customerSearch" class="form-control" placeholder="Search for Customers...">
		</div>

		<!-- Customer Table -->
		<table class="table table-bordered table-hover">
			<thead>
				<tr>
					<th>Customer ID</th>
					<th>Name</th>
					<th>Contact</th>
					<th>Total Purchase</th>
					<th>Purchase Quantity</th>
					<th>Purchase Date</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody id="customerTable">
				<%
				// Database connection details
				String jdbcURL = "jdbc:mysql://localhost:3306/bookorganizer";
				String jdbcUser = "root";
				String jdbcPassword = "student";

				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPassword);

					String sql = "SELECT * FROM customers";
					PreparedStatement statement = conn.prepareStatement(sql);
					ResultSet resultSet = statement.executeQuery();

					while (resultSet.next()) {
						int customerId = resultSet.getInt("customerid");
						String customerName = resultSet.getString("customername");
						String customerContact = resultSet.getString("customercontact");
						double totalPurchase = resultSet.getDouble("totalpurchase");
						int purchaseQuantity = resultSet.getInt("purchasequantity");
						java.sql.Date purchaseDate = resultSet.getDate("purchase_date");
				%>
				<tr>
					<td><%=customerId%></td>
					<td><%=customerName%></td>
					<td><%=customerContact%></td>
					<td><%=totalPurchase%></td>
					<td><%=purchaseQuantity%></td>
					<td><%=purchaseDate%></td>
					<td class="action-buttons">
						<form action="DeleteCustomerServlet" method="post">
							<button type="submit" class="btn btn-delete btn-sm delete-btn" data-id="<%=customerId%>">Delete</button>
							<input type="hidden" name="customerId" value="<%=customerId%>">
						</form>
					</td>
				</tr>
				<%
				}
				resultSet.close();
				statement.close();
				conn.close();
				} catch (SQLException | ClassNotFoundException e) {
				e.printStackTrace();
				out.println("<tr><td colspan='7' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
				}
				%>
			</tbody>
		</table>
	</div>

	<!-- Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<!-- Custom JavaScript -->
	<script>
		$(document).ready(function() {
			// Search functionality
			$("#customerSearch").on("keyup", function() {
				var value = $(this).val().toLowerCase();
				$("#customerTable tr").filter(function() {
					$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
				});
			});

			// Handle delete button click
			$(".delete-btn").on("click", function(event) {
				event.preventDefault();
				var customerId = $(this).data("id");
				var confirmation = confirm("Are you sure you want to delete this record?");
				if (confirmation) {
					// Submit the form to delete the customer
					$(this).closest('form').submit();
				}
			});
		});
	</script>
</body>
</html>
