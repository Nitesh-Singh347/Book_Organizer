import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SaveReceiptServlet")
public class SaveReceiptServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/bookorganizer";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "student";
    
    // Method to update the quantity of a book
    public void updateQuantity(Connection connection, int bookId, int newQuantity) throws SQLException {
        String updateQuery = "UPDATE inventoryrecords SET quantity = ? WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(updateQuery)) {
            preparedStatement.setInt(1, newQuantity);
            preparedStatement.setInt(2, bookId);
            preparedStatement.executeUpdate();
        }
    }
    
    // SQL to insert data into the 'customers' table
    private static final String INSERT_SQL = "INSERT INTO customers (customername, customercontact, totalpurchase, purchasequantity, purchase_date) VALUES (?, ?, ?, ?, ?)";
    
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        List<String[]> books = (List<String[]>) session.getAttribute("books");
        
        // Retrieve customer information from session
        String customerContact = (String) session.getAttribute("customerContact");
        String customerName = (String) session.getAttribute("customerName");
        double totalPurchase = 0.0;
        int totalQuantity = 0;
        
        // Calculate total purchase and total quantity from the books list
        if (books != null) {
            for (String[] book : books) {
                double price = Double.parseDouble(book[4]);
                int bookquantity=Integer.parseInt(book[9]);
                totalPurchase += price*bookquantity;
                totalQuantity += Integer.parseInt(book[9]);
            }
        }
        
        // Get the current date for purchase_date
        LocalDate purchaseDate = LocalDate.now();
        
        // Define the SQL statements
        String INSERT_CUSTOMER_SQL = "INSERT INTO customers (customerName, customerContact, totalPurchase, purchasequantity, purchase_date) VALUES (?, ?, ?, ?, ?)";
        
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("MySQL Driver not found");
        }
        
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement customerStmt = conn.prepareStatement(INSERT_CUSTOMER_SQL)) {
            
            // Set the values for the customers table
            customerStmt.setString(1, customerName);
            customerStmt.setString(2, customerContact);
            customerStmt.setDouble(3, totalPurchase);
            customerStmt.setInt(4, totalQuantity);
            customerStmt.setDate(5, java.sql.Date.valueOf(purchaseDate));
            
            int rowsAffected = customerStmt.executeUpdate();
            if (rowsAffected > 0) {
                // If insertion is successful, update the inventory records
                if (books != null) {
                    for (String[] book : books) {
                        int bookId = Integer.parseInt(book[8]);  // Assuming book ID is at index 8
                        int currentQuantity = Integer.parseInt(book[5]);  // Assuming current quantity is at index 5
                        int newQuantity = currentQuantity - Integer.parseInt(book[9]);  // Adjust based on totalQuantity
                        
                        updateQuantity(conn, bookId, newQuantity);  // Update book quantity in inventory
                    }
                }
                
                // Clear the session attributes
                session.removeAttribute("books");
                session.removeAttribute("customerName");
                session.removeAttribute("customerContact");
                
                // Redirect to the homepage after successful operation
                response.sendRedirect("HomePage.jsp");
            } else {
                // If insertion fails, forward to error page
                request.setAttribute("error", "Failed to save receipt. Please try again.");
                request.getRequestDispatcher("PayReceipt.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("books null");
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("payReceipt.jsp").forward(request, response);
        }
    }

}
