package Classes.Login;

import java.sql.*;

public class AccountManager {

    // An enum to represent the different outcomes of a login attempt.
    public enum LoginResult {
        SUCCESS,
        USER_NOT_FOUND,
        INCORRECT_PASSWORD,
        DB_ERROR
    }

    // --- Database Connection Details ---
    private static final String DB_URL = "jdbc:mysql://localhost:3306/quizdb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Alerteki1!"; // Update if you have a different password

    public AccountManager() {
        // Explicitly load the MySQL JDBC driver.
        // This is a robust way to ensure the driver is available.
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            // This error happens if the MySQL Connector/J JAR is not in the classpath.
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
        }
    }

    // Hash a password using SHA-1 (from Cracker.java)
    public static String hashPassword(String password) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-1");
            md.update(password.getBytes());
            byte[] digest = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                int val = b & 0xff;
                if (val < 16) sb.append('0');
                sb.append(Integer.toString(val, 16));
            }
            return sb.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-1 algorithm not found", e);
        }
    }

    /**
     * Authenticates a user by first finding the user, then checking the password.
     * @param username The user's username.
     * @param password The user's password.
     * @return A LoginResult enum indicating the outcome.
     */
    public LoginResult authenticateUser(String username, String password) {
        if (username == null || password == null) {
            return LoginResult.DB_ERROR; // Or a more specific error
        }

        // Step 1: Find the user and retrieve their stored password hash.
        String sql = "SELECT password FROM Users WHERE username = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (!rs.next()) {
                    return LoginResult.USER_NOT_FOUND;
                }
                String storedHash = rs.getString("password");
                String inputHash = hashPassword(password);
                if (inputHash.equals(storedHash)) {
                    return LoginResult.SUCCESS;
                } else {
                    return LoginResult.INCORRECT_PASSWORD;
                }
            }
        } catch (SQLException e) {
            System.err.println("Database authentication error: " + e.getMessage());
            e.printStackTrace();
            return LoginResult.DB_ERROR;
        }
    }

    public boolean usernameExists(String username) {
        String sql = "SELECT 1 FROM Users WHERE username = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("Database error in usernameExists: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean registerUser(String username, String password, String email) {
        String sql = "INSERT INTO Users (username, password, email, administrator, requestNotification) VALUES (?, ?, ?, false, false)";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, hashPassword(password));
            pstmt.setString(3, email);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Database error in registerUser: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public Boolean getRequestNotification(String username) {
        String sql = "SELECT requestNotification FROM Users WHERE username = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getBoolean("requestNotification");
                }
            }
        } catch (SQLException e) {
            System.err.println("Database error in getRequestNotification: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public int getUserIdByUsername(String username) {
        String sql = "SELECT id FROM Users WHERE username = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id");
                }
            }
        } catch (SQLException e) {
            System.err.println("Database error in getUserIdByUsername: " + e.getMessage());
            e.printStackTrace();
        }
        return -1;
    }

    public int getUserPoints(int userId) {
        String sql = "SELECT points FROM UserPoints WHERE user_id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("points");
                }
            }
        } catch (SQLException e) {
            System.err.println("Database error in getUserPoints: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public boolean insertUserPoints(int userId, int points) {
        String sql = "INSERT INTO UserPoints (user_id, points) VALUES (?, ?)";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, points);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Database error in insertUserPoints: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateUserPoints(int userId, int points) {
        String sql = "UPDATE UserPoints SET points = ? WHERE user_id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, points);
            pstmt.setInt(2, userId);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Database error in updateUserPoints: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean isAdministrator(String username) {
        String sql = "SELECT administrator FROM Users WHERE username = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getBoolean("administrator");
                }
            }
        } catch (SQLException e) {
            System.err.println("Database error in isAdministrator: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}
