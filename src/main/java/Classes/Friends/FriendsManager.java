package Classes.Friends;

import java.sql.*;

public class FriendsManager {

    public enum LoginResult {
        SUCCESS,
        USER_NOT_FOUND,
        DB_ERROR
    }

    private static final String DB_URL = "jdbc:mysql://localhost:3306/quizdb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Alerteki1!";

    public static String searchUserForFriend(String currentUser, String searchUsername) {
        String sql = "SELECT username FROM users WHERE username != ?";
        return "";

    }
}
