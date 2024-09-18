import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FetchBookServlet")
public class FetchBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection parameters
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bookorganizer";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "student";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("bookid");
        String bookQuantity = request.getParameter("quantity");
        
        String customerName = request.getParameter("customerName");
        String customerContact = request.getParameter("customerContact");
        String error = null;

        // Retrieve the list of books from the session
        List<String[]> books = (List<String[]>) request.getSession().getAttribute("books");
        if (books == null) {
            books = new ArrayList<>();
        }
       
        if (bookId != null && !bookId.trim().isEmpty()) {
            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                    String sql = "SELECT * FROM inventoryrecords WHERE id = ?";
                    try (PreparedStatement statement = connection.prepareStatement(sql)) {
                        statement.setString(1, bookId);
                        try (ResultSet resultSet = statement.executeQuery()) {
                            if (resultSet.next()) {
                            	String bookid = resultSet.getString("id");
                                String bookTitle = resultSet.getString("booktitle");
                                String author = resultSet.getString("author");
                                String isbn = resultSet.getString("isbn");
                                String yearOfPublish = resultSet.getString("year_of_publish");
                                String price = resultSet.getString("price");
                                String quantity = resultSet.getString("quantity");

                                // Add book details to the list
                                String[] bookDetails = {bookTitle, author, isbn, yearOfPublish, price, quantity,customerContact,customerName,bookid,bookQuantity};
                                books.add(bookDetails);
                                request.getSession().setAttribute("books", books);
                               
                            } else {
                                error = "Book not found!";
                            }
                        }
                    }
                }
            } catch (ClassNotFoundException e) {
                error = "JDBC Driver not found: " + e.getMessage();
            } catch (SQLException e) {
                error = "Database error: " + e.getMessage();
            }
        } else {
            error = "Invalid Book ID!";
        }

      
       

        if (error != null) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("GenerateBill.jsp").forward(request, response);
        } else {
            response.sendRedirect("GenerateBill.jsp");
        }
    }
}