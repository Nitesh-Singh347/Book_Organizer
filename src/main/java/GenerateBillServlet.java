import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/GenerateBillServlet")
public class GenerateBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get customer details from request
        String customerName = request.getParameter("customerName");
        String customerContact = request.getParameter("customerContact");

        // Store customer details in session
        HttpSession session = request.getSession();
        session.setAttribute("customerName", customerName);
        session.setAttribute("customerContact", customerContact);

        

        // Forward to the JSP page for displaying
        request.getRequestDispatcher("FetchBook.jsp").forward(request, response);
    }
}
