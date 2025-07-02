package Classes.Friends;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FriendsManager {

    public enum LoginResult {
        SUCCESS,
        USER_NOT_FOUND,
        DB_ERROR
    }

    private static final String DB_URL = "jdbc:mysql://localhost:3306/quizdb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "sql107";

    public static List<String> searchUserForFriend(String currentUser, String searchUsername) {
        List<String> result = new ArrayList<>();
        String sql = "SELECT username FROM users WHERE username LIKE ? AND username != ? AND username NOT IN (SELECT CASE WHEN usernameFrom = ? THEN usenameTo ELSE usernameFrom END FROM friends WHERE usernameFrom = ? OR usenameTo = ?)";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + searchUsername + "%");
            stmt.setString(2, currentUser);
            stmt.setString(3, currentUser);
            stmt.setString(4, currentUser);
            stmt.setString(5, currentUser);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(rs.getString("username"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}
