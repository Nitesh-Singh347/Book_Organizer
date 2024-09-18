import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class InventoryDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bookorganizer";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "student";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public boolean addBook(InventoryPojo book) {
        String query = "INSERT INTO inventoryrecords (booktitle, author, isbn, year_of_publish, price, quantity) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            preparedStatement.setString(1, book.getBooktitle());
            preparedStatement.setString(2, book.getAuthor());
            preparedStatement.setString(3, book.getIsbn());
            preparedStatement.setInt(4, book.getYearOfPublish());
            preparedStatement.setDouble(5, book.getPrice());
            preparedStatement.setInt(6, book.getQuantity());

            int result = preparedStatement.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
