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
        String updateNotificationSql = "UPDATE Users SET requestNotification = true WHERE username = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Insert friend request
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fromUser);
            stmt.setString(2, toUser);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("Inserted friend request: " + fromUser + " -> " + toUser + ", rows affected: " + rowsAffected);
            // Set notification flag
            PreparedStatement updateStmt = conn.prepareStatement(updateNotificationSql);
            updateStmt.setString(1, toUser);
            updateStmt.executeUpdate();
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
        // Check for remaining requests
        String checkPendingSql = "SELECT COUNT(*) FROM FriendRequests WHERE usernameTo = ?";
        String resetNotificationSql = "UPDATE Users SET requestNotification = false WHERE username = ?";
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
                // Check if any pending requests remain
                PreparedStatement checkStmt = conn.prepareStatement(checkPendingSql);
                checkStmt.setString(1, toUser);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) == 0) {
                    PreparedStatement resetStmt = conn.prepareStatement(resetNotificationSql);
                    resetStmt.setString(1, toUser);
                    resetStmt.executeUpdate();
                }
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

    public static boolean declineFriendRequest(String fromUser, String toUser) {
        String removeRequestSql = "DELETE FROM FriendRequests WHERE usernameFrom = ? AND usernameTo = ?";
        String checkPendingSql = "SELECT COUNT(*) FROM FriendRequests WHERE usernameTo = ?";
        String resetNotificationSql = "UPDATE Users SET requestNotification = false WHERE username = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Remove request
            PreparedStatement stmt = conn.prepareStatement(removeRequestSql);
            stmt.setString(1, fromUser);
            stmt.setString(2, toUser);
            stmt.executeUpdate();
            // Check if any pending requests remain
            PreparedStatement checkStmt = conn.prepareStatement(checkPendingSql);
            checkStmt.setString(1, toUser);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) == 0) {
                PreparedStatement resetStmt = conn.prepareStatement(resetNotificationSql);
                resetStmt.setString(1, toUser);
                resetStmt.executeUpdate();
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<String> getFriendsList(String username) {
        List<String> friends = new ArrayList<>();
        String sql = "SELECT CASE WHEN usernameFrom = ? THEN usenameTo ELSE usernameFrom END AS friend FROM Friends WHERE usernameFrom = ? OR usenameTo = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, username);
            stmt.setString(3, username);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                friends.add(rs.getString("friend"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return friends;
    }
}
