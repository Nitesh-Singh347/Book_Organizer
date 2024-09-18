
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerIdStr = request.getParameter("id");

        if (customerIdStr != null) {
            try {
                int customerId = Integer.parseInt(customerIdStr);

                // Database connection details
                String jdbcURL = "jdbc:mysql://localhost:3306/bookorganizer";
                String jdbcUser = "root";
                String jdbcPassword = "student";

                // Establish connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPassword);

                // SQL query to delete customer record
                String sql = "DELETE FROM Customers WHERE customerid = ?";
                PreparedStatement statement = conn.prepareStatement(sql);
                statement.setInt(1, customerId);

                int rowsAffected = statement.executeUpdate();

                // Close resources
                statement.close();
                conn.close();

                if (rowsAffected > 0) {
                    response.sendRedirect("ManageCustomer.jsp");
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Customer not found");
                }

            } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error occurred");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid customer ID");
        }
    }
}
