import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get username and password from the login form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Create a UserLoginPojo object with the entered credentials
        UserLoginPojo user = new UserLoginPojo(username, password);

        // Create an instance of UserLoginDao to validate user credentials
        UserLoginDao userDao = new UserLoginDao();

        // Validate user credentials
        boolean isValidUser = userDao.validateUser(user);

        if (isValidUser) {
            // If valid, redirect to the home page (or any other desired page)
            response.sendRedirect("HomePage.jsp");
        } else {
            // If not valid, redirect back to the login page with an error message
            response.sendRedirect("Register.jsp?error=invalid");
        }
    }
}
