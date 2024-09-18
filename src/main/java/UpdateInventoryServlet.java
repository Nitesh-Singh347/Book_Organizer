import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/updateInventory")
public class UpdateInventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the form data and handle potential null values
        String idStr = request.getParameter("id");
        String booktitle = request.getParameter("bookTitle");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String yearOfPublishStr = request.getParameter("yearOfPublish");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");

        // Check for null values and provide default or error handling
        if (idStr == null || booktitle == null || author == null || isbn == null || 
            yearOfPublishStr == null || priceStr == null || quantityStr == null) {
            request.setAttribute("errorMessage", "All fields are required.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            // Convert string parameters to appropriate types
            int id = Integer.parseInt(idStr);
            int yearOfPublish = Integer.parseInt(yearOfPublishStr);
            double price = Double.parseDouble(priceStr);
            int quantity = Integer.parseInt(quantityStr);

            // Database connection parameters
            String jdbcURL = "jdbc:mysql://localhost:3306/bookorganizer";
            String jdbcUsername = "root";
            String jdbcPassword = "student";

            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a database connection
            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // SQL query to update the record
            String sql = "UPDATE inventoryrecords SET booktitle=?, author=?, isbn=?, year_of_publish=?, price=?, quantity=? WHERE id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, booktitle);
            statement.setString(2, author);
            statement.setString(3, isbn);
            statement.setInt(4, yearOfPublish);
            statement.setDouble(5, price);
            statement.setInt(6, quantity);
            statement.setInt(7, id);

            // Execute the update
            int rowsUpdated = statement.executeUpdate();
            if (rowsUpdated > 0) {
                // Forward to the inventory homepage if the update was successful
                RequestDispatcher dispatcher = request.getRequestDispatcher("InventryHomePage.jsp");
                dispatcher.forward(request, response);
            } else {
                // Handle case where the update failed (optional)
                request.setAttribute("errorMessage", "Error updating record.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
                dispatcher.forward(request, response);
            }

            // Close the connection
            connection.close();
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid data format.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Handle any other errors that occur
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}
