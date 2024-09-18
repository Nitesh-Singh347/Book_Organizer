import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private UserRegistrationDao userDao;

    public void init() {
        userDao = new UserRegistrationDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form parameters
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String password = request.getParameter("password");

        // Create UserRegistrationPojo object
        UserRegistrationPojo user = new UserRegistrationPojo(username, email, contact, password);

        // Add user to database
        boolean success = userDao.addUser(user);

        if (success) {
            // Registration successful, redirect to login page
            response.sendRedirect("Login.jsp");
        } else {
            // Registration failed, redirect back to registration page with error message
            response.sendRedirect("Register.jsp?error=true");
        }
    }
}
