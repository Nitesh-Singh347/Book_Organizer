import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserLoginDao {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bookorganizer";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "student";
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver"; // Change if you use a different driver

    public boolean validateUser(UserLoginPojo user) {
        String query = "SELECT * FROM register WHERE username = ? AND password = ?";
        boolean isValidUser = false;

        try {
            Class.forName(JDBC_DRIVER);
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement statement = connection.prepareStatement(query)) {

                statement.setString(1, user.getUsername());
                statement.setString(2, user.getPassword());

                ResultSet resultSet = statement.executeQuery();
                isValidUser = resultSet.next();

            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return isValidUser;
    }
}
