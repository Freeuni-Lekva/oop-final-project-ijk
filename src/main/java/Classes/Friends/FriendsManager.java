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
    private static final String DB_PASSWORD = "Alerteki1!";

    public static List<String> searchUserForFriend(String currentUser, String searchUsername) {
        List<String> result = new ArrayList<>();
        String sql = "SELECT username FROM users WHERE username LIKE ? AND username != ? AND username NOT IN (SELECT CASE WHEN usernameFrom = ? THEN usenameTo ELSE usernameFrom END FROM friends WHERE usernameFrom = ? OR usenameTo = ?) AND username NOT IN (SELECT usernameTo FROM FriendRequests WHERE usernameFrom = ?)";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + searchUsername + "%");
            stmt.setString(2, currentUser);
            stmt.setString(3, currentUser);
            stmt.setString(4, currentUser);
            stmt.setString(5, currentUser);
            stmt.setString(6, currentUser);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(rs.getString("username"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public static boolean sendFriendRequest(String fromUser, String toUser) {
        if (hasPendingRequest(fromUser, toUser)) {
            System.out.println("Friend request already pending from " + fromUser + " to " + toUser);
            return false;
        }
        String sql = "INSERT INTO FriendRequests (usernameFrom, usernameTo, date) VALUES (?, ?, NOW())";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, fromUser);
            stmt.setString(2, toUser);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("Inserted friend request: " + fromUser + " -> " + toUser + ", rows affected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("SQL Exception while inserting friend request: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        }
    }

    public static List<String> getPendingFriendRequests(String currentUser) {
        List<String> result = new ArrayList<>();
        String sql = "SELECT usernameFrom FROM FriendRequests WHERE usernameTo = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, currentUser);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                result.add(rs.getString("usernameFrom"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public static boolean acceptFriendRequest(String fromUser, String toUser) {
        // First, add to Friends table
        String addFriendSql = "INSERT INTO Friends (usernameFrom, usenameTo) VALUES (?, ?)";
        // Then, remove from FriendRequests table
        String removeRequestSql = "DELETE FROM FriendRequests WHERE usernameFrom = ? AND usernameTo = ?";
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            conn.setAutoCommit(false);
            try {
                // Add to friends
                PreparedStatement addStmt = conn.prepareStatement(addFriendSql);
                addStmt.setString(1, fromUser);
                addStmt.setString(2, toUser);
                addStmt.executeUpdate();
                
                // Remove request
                PreparedStatement removeStmt = conn.prepareStatement(removeRequestSql);
                removeStmt.setString(1, fromUser);
                removeStmt.setString(2, toUser);
                removeStmt.executeUpdate();
                
                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
                return false;
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean hasPendingRequest(String fromUser, String toUser) {
        String sql = "SELECT COUNT(*) FROM FriendRequests WHERE usernameFrom = ? AND usernameTo = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, fromUser);
            stmt.setString(2, toUser);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
