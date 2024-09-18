import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/deleteinventory")
public class DeleteInventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String URL = "jdbc:mysql://localhost:3306/bookorganizer";
    private static final String USER = "root";
    private static final String PASSWORD = "student";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Retrieve the book ID from the request
        String bookId = request.getParameter("id");

        // SQL query to delete the record
        String sql = "DELETE FROM inventoryrecords WHERE id = ?";

        boolean isDeleted = false;
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            // Set the book ID in the query
            stmt.setString(1, bookId);

            // Execute the delete operation
            int rowsAffected = stmt.executeUpdate();
            isDeleted = rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect based on deletion success or failure
        if (isDeleted) {
            response.sendRedirect("InventryHomePage.jsp");
        } else {
            response.sendRedirect("errorPage.jsp");
        }
    }
}
