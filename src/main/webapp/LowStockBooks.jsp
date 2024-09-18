<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Low Stock Books</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            color: #333;
            padding: 0;
        }

        /* Navigation Bar */
        .navbar {
            background-color: #34495e;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .navbar a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            padding: 10px 15px;
            transition: background-color 0.3s ease;
        }

        .navbar a:hover {
            background-color: #2c3e50;
            border-radius: 4px;
        }

        .navbar a.active {
            background-color: #2980b9;
            border-radius: 4px;
        }

        /* Content */
        h2 {
            text-align: center;
            margin-top: 30px;
            font-size: 28px;
            color: #2c3e50;
        }

        table {
            width: 90%;
            max-width: 1200px;
            margin: 40px auto;
            border-collapse: collapse;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
            background-color: white;
        }

        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #2980b9;
            color: white;
            font-size: 18px;
        }

        td {
            font-size: 16px;
            color: #34495e;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e6f7ff;
        }

        .message-container {
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 40px auto;
            text-align: center;
        }

        .message-container h2 {
            color: #4CAF50; /* Green color */
            font-size: 24px;
            margin: 0;
        }

        .message-container p {
            color: #555;
            font-size: 16px;
            margin: 10px 0 0;
        }

        @media screen and (max-width: 768px) {
            table {
                width: 100%;
            }
            th, td {
                padding: 10px;
            }
            .navbar a {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <div class="navbar">
        <a href="HomePage.jsp" class="active">Home</a>
    </div>

    <!-- Page Content -->
    <%
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        // Load the MySQL driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookorganizer", "root", "student");

        String query = "SELECT id, booktitle, author, isbn, price, quantity FROM inventoryrecords WHERE quantity < 5";
        ps = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        rs = ps.executeQuery();

        if (rs.next()) { // Check if there are records
    %>

    <h2>Low Stock Books</h2>
    <table>
        <thead>
            <tr>
                <th>Book Id</th>
                <th>Book Title</th>
                <th>Author</th>
                <th>ISBN</th>
                <th>Price</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody>
            <%
            // Reset the cursor to the beginning
            rs.beforeFirst();
            
            while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("booktitle") %></td>
                <td><%= rs.getString("author") %></td>
                <td><%= rs.getString("isbn") %></td>
                <td><%= rs.getDouble("price") %></td>
                <td><%= rs.getInt("quantity") %></td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
    <%
        } else {
    %>
    <div class="message-container">
        <h2>Your Inventory is Up-to-Date</h2>
        <p>Stock is currently available.</p>
    </div>
    <%
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Handle SQL specific exceptions
    } catch (Exception e) {
        e.printStackTrace(); // Handle general exceptions
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions during resource cleanup
        }
    }
    %>
</body>
</html>
