<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard</title>
<!-- Font Awesome CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
<style>
body {
    font-family: 'Arial', sans-serif; /* Changed font-family for a different look */
    background: linear-gradient(135deg, #f0f4f8, #e4e9f0);
    margin: 0;
    display: flex;
    color: #333;
}

.dashboard {
    display: flex;
    width: 100%;
}

.sidebar {
    background-color: #004d40; /* Deep teal color */
    color: white;
    width: 250px;
    padding: 20px;
    height: 100vh;
    position: fixed;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.sidebar h2 {
    margin: 0;
    margin-left: 10px;
    font-size: 28px;
    font-weight: 600;
}

.sidebar ul {
    list-style-type: none;
    padding: 0;
    width: 100%;
    
}

.sidebar ul li {
    margin: 20px 0;
    border-radius: 12px;
    background-color: #00796b;
    width: 100%;
    transition: background-color 0.3s ease, transform 0.3s ease;
     margin-top: 30px;
}

.sidebar ul li:hover {
    background-color: #004d40;
    transform: scale(1.05);
}

.sidebar ul li a {
    color: white;
    text-decoration: none;
    display: block;
    padding: 12px 20px;
    border-radius: 12px;
    transition: color 0.3s ease;
   
}

.sidebar ul li a:hover {
    color: #b2dfdb;
}

.sidebar ul li a i {
    margin-right: 10px;
}

.main-content {
    margin-left: 250px; /* Sidebar width */
    padding: 20px;
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.cards-container {
    display: grid;
    grid-template-columns: repeat(2, 1fr); /* 2 cards per row */
    gap: 20px; /* Margin between cards */
    max-width: 1200px;
    width: 90%;
}

.card {
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
    padding: 20px;
    color: #333;
    text-align: center;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 220px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    font-family: 'Arial', sans-serif; /* Updated font for cards */
}

.card:hover {
    transform: translateY(-10px);
    box-shadow: 0 16px 32px rgba(0, 0, 0, 0.2);
}

.card.red {
    background: linear-gradient(135deg, #ff6b6b, #ff3f3f);
    color: white;
}

.card.blue {
    background: linear-gradient(135deg, #4a90e2, #003b6c);
    color: white;
}

.card.green {
    background: linear-gradient(135deg, #7ed321, #4caf50);
    color: white;
}

.card.yellow {
    background: linear-gradient(135deg, #f8e71c, #fbc02d);
    color: white;
}

h3 {
    margin: 0;
    font-size: 24px;
    margin-bottom: 10px;
    font-family: 'Arial', sans-serif; /* Updated font for headings */
}

p {
    margin: 0;
    font-size: 20px; /* Adjusted font size for better readability */
    font-weight: 600;
    margin-top:20px;
}

select {
    padding: 10px;
    font-size: 16px;
    border-radius: 8px;
    border: 1px solid #ddd;
}
</style>
</head>
<body>
    <div class="dashboard">
        <div class="sidebar">
            <h2>Book Organizer</h2>
            <ul>
                <li><a href="InventryHomePage.jsp"><i class="fas fa-boxes"></i>Manage Inventory</a></li>
                <li><a href="ManageCustomer.jsp"><i class="fas fa-users"></i>Manage Customer</a></li>
                <li><a href="GenerateBill.jsp"><i class="fas fa-file-invoice-dollar"></i> Generate Bill</a></li>
                <li><a href="logout"><i class="fas fa-sign-out-alt"></i> Log Out</a></li>
            </ul>
        </div>
        <div class="main-content">
            <div class="cards-container">
                <%-- Define connection and statement variables once --%>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    String selectedMonth = request.getParameter("month");
                    if (selectedMonth == null) selectedMonth = "1"; // Default to January if no month is selected
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookorganizer", "root", "student");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
                <!-- Total Books Available -->
                <div class="card red">
                    <h3>Total Books Available</h3>
                    <p>
                        <%
                            int totalBooks = 0;
                            try {
                                String query = "SELECT SUM(quantity) AS totalQuantity FROM inventoryrecords";
                                ps = conn.prepareStatement(query);
                                rs = ps.executeQuery();
                                if (rs.next()) {
                                    totalBooks = rs.getInt("totalQuantity");
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) rs.close();
                                if (ps != null) ps.close();
                            }
                            out.print(totalBooks);
                        %>
                    </p>
                </div>
                <!-- Total Book Sales -->
                <div class="card blue">
                    <h3>Total Book Sales</h3>
                    <p>
                        <%
                            int totalBookSales = 0;
                            try {
                                String query = "SELECT SUM(purchasequantity) AS totalSales FROM customers";
                                ps = conn.prepareStatement(query);
                                rs = ps.executeQuery();
                                if (rs.next()) {
                                    totalBookSales = rs.getInt("totalSales");
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) rs.close();
                                if (ps != null) ps.close();
                            }
                            out.print(totalBookSales);
                        %>
                    </p>
                </div>
                <!-- Books Sales This Month -->
                <div class="card green">
    <h3>Books Sales This Month</h3>
    <form method="GET" action="HomePage.jsp">
        <label for="month">Select Month:</label>
        <select id="month" name="month" onchange="this.form.submit()">
            <option value="1" <%= "1".equals(selectedMonth) ? "selected" : "" %>>January</option>
            <option value="2" <%= "2".equals(selectedMonth) ? "selected" : "" %>>February</option>
            <option value="3" <%= "3".equals(selectedMonth) ? "selected" : "" %>>March</option>
            <option value="4" <%= "4".equals(selectedMonth) ? "selected" : "" %>>April</option>
            <option value="5" <%= "5".equals(selectedMonth) ? "selected" : "" %>>May</option>
            <option value="6" <%= "6".equals(selectedMonth) ? "selected" : "" %>>June</option>
            <option value="7" <%= "7".equals(selectedMonth) ? "selected" : "" %>>July</option>
            <option value="8" <%= "8".equals(selectedMonth) ? "selected" : "" %>>August</option>
            <option value="9" <%= "9".equals(selectedMonth) ? "selected" : "" %>>September</option>
            <option value="10" <%= "10".equals(selectedMonth) ? "selected" : "" %>>October</option>
            <option value="11" <%= "11".equals(selectedMonth) ? "selected" : "" %>>November</option>
            <option value="12" <%= "12".equals(selectedMonth) ? "selected" : "" %>>December</option>
        </select>
    </form>

    <%
        int totalBookSalesThisMonth = 0;
       
        
        try {
            // Initialize database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookorganizer", "root", "student");
            
            // Get current year
            java.util.Calendar cal = java.util.Calendar.getInstance();
            int year = cal.get(java.util.Calendar.YEAR);
            
            // Prepare SQL query
            String query = "SELECT SUM(purchasequantity) AS totalSalesThisMonth FROM customers WHERE MONTH(purchase_date) = ? AND YEAR(purchase_date) = ?";
            ps = conn.prepareStatement(query);
            ps.setInt(1, Integer.parseInt(selectedMonth));
            ps.setInt(2, year);
            rs = ps.executeQuery();
            
            // Process the result
            if (rs.next()) {
                totalBookSalesThisMonth = rs.getInt("totalSalesThisMonth");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
    <p>
        <%= totalBookSalesThisMonth %>
    </p>
</div>

                <!-- Low Stock List -->
                <div class="card yellow" onclick="window.location.href='LowStockBooks.jsp';" style="cursor: pointer;">
                    <h3>Low Stock List</h3>
                </div>
            </div>
        </div>
    </div>

    <%
    if (conn != null) conn.close(); // Ensure connection is closed
    session.removeAttribute("books");
    session.removeAttribute("customerName");
    session.removeAttribute("customerContact");
    %>
</body>
</html>
