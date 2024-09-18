<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .btn-success {
            font-size: 1.1rem;
            border-radius: 50px;
        }
        @media (max-width: 992px) {
            .btn-success {
                margin-top: 10px;
            }
        }
        .table-container {
            margin: 20px;
        }
        .search-bar {
            margin-bottom: 30px;
            text-align: center;
        }
        .input-group {
            max-width: 50%;
            margin: 0 auto;
            border-radius: 50px;
        }
        .input-group input {
            border-top-left-radius: 50px;
            border-bottom-left-radius: 50px;
            padding: 15px 20px;
            height: 50px;
            font-size: 1rem;
            border: 1px solid #ced4da;
        }
        .input-group-append {
            background-color: #fff;
            border-top-right-radius: 50px;
            border-bottom-right-radius: 50px;
        }
        .input-group-text {
            border-top-right-radius: 50px;
            border-bottom-right-radius: 50px;
            background-color: #fff;
            border: 1px solid #ced4da;
            padding: 0 15px;
        }
        .fa-search {
            color: #6c757d;
        }
        .input-group input:focus {
            box-shadow: none;
            border-color: #007bff;
        }
        .action-buttons {
            display: flex;
            justify-content: space-around;
        }
         .btn-warning {
            background: linear-gradient(to right, #ffb347, #ffcc33);
            border: none;
        }
        .btn-danger {
            background: linear-gradient(to right, #fc4a1a, #f7b733);
            border: none;
        }
    </style>
</head>

<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="InventryHomePage.jsp">Manage Inventory</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"> 
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <a href="HomePage.jsp" class="btn btn-secondary my-2 my-lg-0 mr-2">Go to Homepage</a> <!-- Added Go to Homepage button -->
        <a href="addBook.jsp" class="btn btn-primary my-2 my-lg-0 add-book-button">Add Book</a>
    </div>
</nav>

<div class="container mt-4 table-container">
    <h2 class="text-center mb-4">Inventory Records</h2>

    <!-- Redesigned Search Bar -->
    <div class="search-bar">
        <div class="input-group">
            <input type="text" class="form-control" id="bookSearch" placeholder="Search for books...">
            <div class="input-group-append">
                <span class="input-group-text" id="searchIcon">
                    <i class="fa fa-search"></i> <!-- Search icon -->
                </span>
            </div>
        </div>
    </div>

    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
            <tr>
                <th>ID</th>
                <th>Book Title</th>
                <th>Author</th>
                <th>ISBN</th>
                <th>Year of Publish</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody id="bookTable">
            <% 
                String jdbcURL = "jdbc:mysql://localhost:3306/bookorganizer";
                String jdbcUsername = "root";
                String jdbcPassword = "student";
                
                String SELECT_ALL_BOOKS = "SELECT * FROM inventoryrecords";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                    Statement statement = connection.createStatement();
                    ResultSet resultSet = statement.executeQuery(SELECT_ALL_BOOKS);

                    while (resultSet.next()) {
                        int id = resultSet.getInt("id");
                        String booktitle = resultSet.getString("booktitle");
                        String author = resultSet.getString("author");
                        String isbn = resultSet.getString("isbn");
                        int yearOfPublish = resultSet.getInt("year_of_publish");
                        double price = resultSet.getDouble("price");
                        int quantity = resultSet.getInt("quantity");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= booktitle %></td>
                <td><%= author %></td>
                <td><%= isbn %></td>
                <td><%= yearOfPublish %></td>
                <td><%= price %></td>
                <td><%= quantity %></td>
                <td class="action-buttons">
                    <!-- Update Button -->
                    <form action="updateinventory.jsp" method="get" style="display: inline;">
                        <input type="hidden" name="id" value="<%= id %>">
                        <button type="submit" class="btn btn-warning btn-sm">Update</button>
                    </form>
                    <!-- Delete Button -->
                    <form action="deleteinventory" method="post" style="display: inline;" onsubmit="return confirmDelete();">
                        <input type="hidden" name="id" value="<%= id %>">
                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                    </form>
                </td>
            </tr>
            <% 
                    }
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <tr>
                <td colspan="8" class="text-center text-danger">Error retrieving data</td>
            </tr>
            <% 
                }
            %>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS and dependencies (jQuery and Popper.js) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Custom JS for search functionality -->
<script>
    $(document).ready(function(){
        $("#bookSearch").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#bookTable tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
    });

    function confirmDelete() {
        return confirm("Delete this record?");
    }
</script>
</body>
</html>
