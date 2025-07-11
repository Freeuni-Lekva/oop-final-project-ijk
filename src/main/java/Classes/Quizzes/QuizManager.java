package Classes.Quizzes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

public class QuizManager {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/quizdb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Alerteki1!";

    public static class Quiz {
        public int id;
        public String name;
        public String category;
        public int difficulty;
        public String user;
        public String description;
        public boolean random;
        public boolean onePage;
        public boolean immediateCorrection;
        public int duration; // duration in minutes
        // Add more fields as needed (e.g., number of questions, taken count)
    }

    public static class Question {
        public int id;
        public int type;
        public String question;
        public String possibleAnswers;
        public String answer;
        public int quizId; // Add this if you have a quiz_id column in QuestionsTable
    }

    // QuizAttempt class for returning attempts
    public static class QuizAttempt {
        public int id;
        public int userId;
        public int quizId;
        public double score;
        public Timestamp takenAt;
        public int durationSeconds;
    }

    public List<Quiz> getAllQuizzes() {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT * FROM Quizzes";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement pstmt = conn.prepareStatement(sql);
                 ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.id = rs.getInt("id");
                    quiz.name = rs.getString("name");
                    quiz.category = rs.getString("category");
                    quiz.difficulty = rs.getInt("difficulty");
                    quiz.user = rs.getString("user");
                    quiz.description = rs.getString("description");
                    quiz.random = rs.getBoolean("random");
                    quiz.onePage = rs.getBoolean("onePage");
                    quiz.immediateCorrection = rs.getBoolean("immediateCorrection");
                    quiz.duration = rs.getInt("duration");
                    quizzes.add(quiz);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return quizzes;
    }

    public Map<String, Integer> getQuizCountByCategory() {
        Map<String, Integer> categoryCounts = new HashMap<>();
        String sql = "SELECT category, COUNT(*) as count FROM Quizzes GROUP BY category";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement pstmt = conn.prepareStatement(sql);
                 ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    String category = rs.getString("category");
                    int count = rs.getInt("count");
                    categoryCounts.put(category, count);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categoryCounts;
    }

    public Quiz getQuizById(int id) {
        String sql = "SELECT * FROM Quizzes WHERE id = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, id);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        Quiz quiz = new Quiz();
                        quiz.id = rs.getInt("id");
                        quiz.name = rs.getString("name");
                        quiz.category = rs.getString("category");
                        quiz.difficulty = rs.getInt("difficulty");
                        quiz.user = rs.getString("user");
                        quiz.description = rs.getString("description");
                        quiz.random = rs.getBoolean("random");
                        quiz.onePage = rs.getBoolean("onePage");
                        quiz.immediateCorrection = rs.getBoolean("immediateCorrection");
                        quiz.duration = rs.getInt("duration");
                        return quiz;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Question> getAllQuestions() {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM QuestionsTable";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement pstmt = conn.prepareStatement(sql);
                 ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Question q = new Question();
                    q.id = rs.getInt("id");
                    q.type = rs.getInt("type");
                    q.question = rs.getString("question");
                    q.possibleAnswers = rs.getString("possibleAnswers");
                    q.answer = rs.getString("answer");
                    // q.quizId = rs.getInt("quiz_id"); // Uncomment if you have this column
                    questions.add(q);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return questions;
    }

    // Optionally, fetch questions by quiz id if you have a quiz_id column
    public List<Question> getQuestionsByQuizId(int quizId) {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM QuestionsTable WHERE id = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, quizId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Question q = new Question();
                        q.id = rs.getInt("id");
                        q.type = rs.getInt("type");
                        q.question = rs.getString("question");
                        q.possibleAnswers = rs.getString("possibleAnswers");
                        q.answer = rs.getString("answer");
                        // q.quizId = rs.getInt("quiz_id"); // Uncomment if you have this column
                        questions.add(q);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return questions;
    }

    public int getQuestionCountForQuiz(int quizId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM QuestionsTable WHERE id = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, quizId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        count = rs.getInt(1);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean insertQuizAttempt(int userId, int quizId, double score, int durationSeconds) {
        String sql = "INSERT INTO QuizAttempts (user_id, quiz_id, score, duration_seconds) VALUES (?, ?, ?, ?)";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, userId);
                pstmt.setInt(2, quizId);
                pstmt.setDouble(3, score);
                pstmt.setInt(4, durationSeconds);
                int affected = pstmt.executeUpdate();
                return affected > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<QuizAttempt> getQuizAttemptsForUser(int userId) {
        List<QuizAttempt> attempts = new ArrayList<>();
        String sql = "SELECT * FROM QuizAttempts WHERE user_id = ? ORDER BY taken_at DESC";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, userId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        QuizAttempt a = new QuizAttempt();
                        a.id = rs.getInt("id");
                        a.userId = rs.getInt("user_id");
                        a.quizId = rs.getInt("quiz_id");
                        a.score = rs.getDouble("score");
                        a.takenAt = rs.getTimestamp("taken_at");
                        a.durationSeconds = rs.getInt("duration_seconds");
                        attempts.add(a);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return attempts;
    }

    // Returns today's quiz attempts for a user
    public List<QuizAttempt> getTodayQuizAttemptsForUser(int userId) {
        List<QuizAttempt> attempts = new ArrayList<>();
        String sql = "SELECT * FROM QuizAttempts WHERE user_id = ? AND DATE(taken_at) = CURDATE() ORDER BY taken_at DESC";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, userId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        QuizAttempt a = new QuizAttempt();
                        a.id = rs.getInt("id");
                        a.userId = rs.getInt("user_id");
                        a.quizId = rs.getInt("quiz_id");
                        a.score = rs.getDouble("score");
                        a.takenAt = rs.getTimestamp("taken_at");
                        a.durationSeconds = rs.getInt("duration_seconds");
                        attempts.add(a);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return attempts;
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
            e.printStackTrace();
        }
        return 0;
    }

    // Upsert user points: insert or update as needed
    public boolean upsertUserPoints(int userId, int points) {
        String sql = "INSERT INTO UserPoints (user_id, points) VALUES (?, ?) ON DUPLICATE KEY UPDATE points = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, points);
            pstmt.setInt(3, points);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void recalculateAndUpdateUserPoints(int userId) {
        Map<Integer, Double> bestScoreByQuiz = new HashMap<>();
        List<QuizAttempt> attempts = getQuizAttemptsForUser(userId);
        for (QuizAttempt attempt : attempts) {
            int quizId = attempt.quizId;
            double score = attempt.score;
            if (!bestScoreByQuiz.containsKey(quizId) || score > bestScoreByQuiz.get(quizId)) {
                bestScoreByQuiz.put(quizId, score);
            }
        }
        int totalPoints = 0;
        for (Map.Entry<Integer, Double> entry : bestScoreByQuiz.entrySet()) {
            int quizId = entry.getKey();
            double score = entry.getValue();
            Quiz quiz = getQuizById(quizId);
            int multiplier = 1;
            if (quiz != null) {
                if (quiz.difficulty == 2) multiplier = 2;
                else if (quiz.difficulty == 3) multiplier = 3;
            }
            totalPoints += (int)Math.round(score * multiplier);
        }
        upsertUserPoints(userId, totalPoints);
    }

    // Returns the number of quizzes completed today by the user
    public int getDailyGoalsCompleted(int userId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM QuizAttempts WHERE user_id = ? AND DATE(taken_at) = CURDATE()";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // Returns the user's quiz accuracy as a percent (0-100) for today only
    public int getQuizAccuracy(int userId) {
        int totalCorrect = 0;
        int totalQuestions = 0;
        List<QuizAttempt> attempts = getTodayQuizAttemptsForUser(userId);
        for (QuizAttempt attempt : attempts) {
            int quizId = attempt.quizId;
            int numQuestions = getQuestionCountForQuiz(quizId);
            totalCorrect += (int)Math.round(attempt.score);
            totalQuestions += numQuestions;
        }
        if (totalQuestions == 0) return 0;
        return (int)Math.round(100.0 * totalCorrect / totalQuestions);
    }

    // Returns the number of days in the last 7 where the user earned points (completed at least one quiz)
    public int getDailyPointsStreak(int userId) {
        int streak = 0;
        String sql = "SELECT DATE(taken_at) as day, COUNT(*) FROM QuizAttempts WHERE user_id = ? AND taken_at >= DATE_SUB(CURDATE(), INTERVAL 6 DAY) GROUP BY day";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    streak++;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return streak;
    }

    // Returns the sum of the user's max points from each quiz for today only
    public int getUserMaxPointsSum(int userId) {
        Map<Integer, Double> bestScoreByQuiz = new HashMap<>();
        List<QuizAttempt> attempts = getTodayQuizAttemptsForUser(userId);
        for (QuizAttempt attempt : attempts) {
            int quizId = attempt.quizId;
            double score = attempt.score;
            if (!bestScoreByQuiz.containsKey(quizId) || score > bestScoreByQuiz.get(quizId)) {
                bestScoreByQuiz.put(quizId, score);
            }
        }
        int totalPoints = 0;
        for (Map.Entry<Integer, Double> entry : bestScoreByQuiz.entrySet()) {
            int quizId = entry.getKey();
            double score = entry.getValue();
            Quiz quiz = getQuizById(quizId);
            int multiplier = 1;
            if (quiz != null) {
                if (quiz.difficulty == 2) multiplier = 2;
                else if (quiz.difficulty == 3) multiplier = 3;
            }
            totalPoints += (int)Math.round(score * multiplier);
        }
        return totalPoints;
    }
}
