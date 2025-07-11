package Classes.Leaderboard;

import java.sql.*;
import java.util.*;

public class LeaderboardManager {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/quizdb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Alerteki1!";

    public static class UserPointsEntry {
        public int userId;
        public String username;
        public int points;
        public UserPointsEntry(int userId, String username, int points) {
            this.userId = userId;
            this.username = username;
            this.points = points;
        }
    }

    // Returns a list of the top N users by points (descending)
    public List<UserPointsEntry> getTopUsersByPoints(int topN) {
        List<UserPointsEntry> result = new ArrayList<>();
        String sql = "SELECT u.id, u.username, up.points FROM UserPoints up JOIN Users u ON up.user_id = u.id ORDER BY up.points DESC, u.username ASC LIMIT ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, topN);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int userId = rs.getInt("id");
                    String username = rs.getString("username");
                    int points = rs.getInt("points");
                    result.add(new UserPointsEntry(userId, username, points));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // Returns the rank (1-based) of the user by points (ties: same points = same rank, next rank is skipped)
    public int getUserRank(int userId) {
        String sql = "SELECT user_id, points FROM UserPoints ORDER BY points DESC, user_id ASC";
        int rank = 1;
        int prevPoints = -1;
        int actualRank = 1;
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int uid = rs.getInt("user_id");
                int points = rs.getInt("points");
                if (prevPoints != -1 && points < prevPoints) {
                    rank = actualRank;
                }
                if (uid == userId) {
                    return rank;
                }
                prevPoints = points;
                actualRank++;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // not found
    }

    // Returns all users with their points, sorted descending
    public List<UserPointsEntry> getAllUserPoints() {
        List<UserPointsEntry> result = new ArrayList<>();
        String sql = "SELECT u.id, u.username, up.points FROM UserPoints up JOIN Users u ON up.user_id = u.id ORDER BY up.points DESC, u.username ASC";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int userId = rs.getInt("id");
                String username = rs.getString("username");
                int points = rs.getInt("points");
                result.add(new UserPointsEntry(userId, username, points));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}
