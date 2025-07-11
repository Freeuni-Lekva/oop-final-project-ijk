package Classes.Achievements;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class Achievements {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/quizdb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Alerteki1!";

    // Fetch all achievements for a user as a map
    public Map<String, Boolean> getAchievementsForUser(int userId) {
        Map<String, Boolean> achievements = new HashMap<>();
        String sql = "SELECT * FROM Achievements WHERE user_id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    achievements.put("FAST_LEARNER", rs.getBoolean("FAST_LEARNER"));
                    achievements.put("ON_FIRE", rs.getBoolean("ON_FIRE"));
                    achievements.put("GENIUS", rs.getBoolean("GENIUS"));
                    achievements.put("CHAMPION", rs.getBoolean("CHAMPION"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return achievements;
    }

    // Normalize achievement name to DB column
    private String normalizeAchievementColumn(String achievement) {
        String key = achievement.toUpperCase().replace(" ", "_");
        switch (key) {
            case "FAST_LEARNER": return "FAST_LEARNER";
            case "ON_FIRE": return "ON_FIRE";
            case "GENIUS": return "GENIUS";
            case "CHAMPION": return "CHAMPION";
            default: throw new IllegalArgumentException("Unknown achievement: " + achievement);
        }
    }

    // Set a specific achievement for a user
    public boolean setAchievement(int userId, String achievement, boolean value) {
        String column = normalizeAchievementColumn(achievement);
        String sql = "UPDATE Achievements SET " + column + " = ? WHERE user_id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setBoolean(1, value);
            pstmt.setInt(2, userId);
            int affected = pstmt.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Insert a new row for a user (all achievements false by default)
    public boolean insertAchievementsRow(int userId) {
        String sql = "INSERT INTO Achievements (user_id, FAST_LEARNER, ON_FIRE, GENIUS, CHAMPION) VALUES (?, false, false, false, false)";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            int affected = pstmt.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Returns true if the user has completed 2 or more quizzes in the last hour
    public boolean isOnFire(int userId) {
        String sql = "SELECT COUNT(*) FROM QuizAttempts WHERE user_id = ? AND taken_at >= DATE_SUB(NOW(), INTERVAL 1 HOUR)";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) >= 2;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Updates the ON_FIRE achievement for the user based on the rule
    public void updateOnFireAchievement(int userId) {
        boolean onFire = isOnFire(userId);
        setAchievement(userId, "ON_FIRE", onFire);
    }

    // Returns true if the user has completed 5 different quizzes
    public boolean isFastLearner(int userId) {
        String sql = "SELECT COUNT(DISTINCT quiz_id) FROM QuizAttempts WHERE user_id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) >= 5;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updateFastLearnerAchievement(int userId) {
        boolean fastLearner = isFastLearner(userId);
        setAchievement(userId, "FAST_LEARNER", fastLearner);
    }

    // Returns true if the user has scored max points on 10 different quizzes
    public boolean isGenius(int userId) {
        // For each quiz, check if user has ever achieved max points
        String sql = "SELECT qa.quiz_id, MAX(qa.score) as best, COUNT(qt.id) as total FROM QuizAttempts qa JOIN QuestionsTable qt ON qa.quiz_id = qt.id WHERE qa.user_id = ? GROUP BY qa.quiz_id HAVING best = total";
        int count = 0;
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    count++;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count >= 10;
    }

    public void updateGeniusAchievement(int userId) {
        boolean genius = isGenius(userId);
        setAchievement(userId, "GENIUS", genius);
    }

    // Returns true if the user is currently #1 on the leaderboard
    public boolean isChampion(int userId) {
        Classes.Leaderboard.LeaderboardManager leaderboard = new Classes.Leaderboard.LeaderboardManager();
        return leaderboard.getUserRank(userId) == 1;
    }

    // Mark CHAMPION as true if user is/was ever #1, never set back to false
    public void markChampionIfTop(int userId) {
        if (isChampion(userId)) {
            setAchievement(userId, "CHAMPION", true);
        }
    }

    // Ensure a row exists for the user in Achievements table
    public void ensureAchievementsRow(int userId) {
        String checkSql = "SELECT 1 FROM Achievements WHERE user_id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setInt(1, userId);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (!rs.next()) {
                    insertAchievementsRow(userId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Updates all achievements for the user
    public void updateAllAchievements(int userId) {
        ensureAchievementsRow(userId);
        updateOnFireAchievement(userId); // already correct
        updateFastLearnerAchievement(userId);
        updateGeniusAchievement(userId);
        markChampionIfTop(userId);
    }
}
