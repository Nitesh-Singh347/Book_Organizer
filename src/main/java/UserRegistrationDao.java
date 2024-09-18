

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserRegistrationDao {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bookorganizer";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "student";

    public boolean addUser(UserRegistrationPojo user) {
        String query = "INSERT INTO register (username, email, contact, password) VALUES (?, ?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement statement = connection.prepareStatement(query)) {

                statement.setString(1, user.getUsername());
                statement.setString(2, user.getEmail());
                statement.setString(3, user.getContact());
                statement.setString(4, user.getPassword());

                int rowsInserted = statement.executeUpdate();
                return rowsInserted > 0;

            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
}
