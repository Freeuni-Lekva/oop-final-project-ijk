package Classes.Admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminManager {
    public boolean removeUser(Connection conn, int userId) throws SQLException {
        String sql = "DELETE FROM Users WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean removeQuiz(Connection conn, int quizId) throws SQLException {
        String sql = "DELETE FROM Quizzes WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quizId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean promoteUserToAdmin(Connection conn, int userId) throws SQLException {
        String sql = "UPDATE Users SET administrator = true WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    public int getUserCount(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Users";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    public int getQuizAttemptsCount(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) FROM QuizAttempts";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    public java.util.List<User> getAllUsers(Connection conn) throws SQLException {
        java.util.List<User> users = new java.util.ArrayList<>();
        String sql = "SELECT id, username, email, administrator FROM Users";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    users.add(new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getBoolean("administrator")
                    ));
                }
            }
        }
        return users;
    }
    public java.util.List<Quiz> getAllQuizzes(Connection conn) throws SQLException {
        java.util.List<Quiz> quizzes = new java.util.ArrayList<>();
        String sql = "SELECT id, name, category FROM Quizzes";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    quizzes.add(new Quiz(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("category")
                    ));
                }
            }
        }
        return quizzes;
    }
    public static class User {
        public int id;
        public String username;
        public String email;
        public boolean administrator;
        public User(int id, String username, String email, boolean administrator) {
            this.id = id;
            this.username = username;
            this.email = email;
            this.administrator = administrator;
        }
    }
    public static class Quiz {
        public int id;
        public String name;
        public String category;
        public Quiz(int id, String name, String category) {
            this.id = id;
            this.name = name;
            this.category = category;
        }
    }
} 