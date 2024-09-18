import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddBookController")
public class AddBookController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String booktitle = request.getParameter("booktitle");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        int yearOfPublish = Integer.parseInt(request.getParameter("year_of_publish"));
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        InventoryPojo book = new InventoryPojo();
        book.setBooktitle(booktitle);
        book.setAuthor(author);
        book.setIsbn(isbn);
        book.setYearOfPublish(yearOfPublish);
        book.setPrice(price);
        book.setQuantity(quantity);
        
        InventoryDAO dao = new InventoryDAO();
        boolean result = dao.addBook(book);
        
        if (result) {
            request.getRequestDispatcher("InventryHomePage.jsp").forward(request, response);
        } else {
            response.sendRedirect("addBook.jsp?error=Failed to add book");
        }
    }
}
