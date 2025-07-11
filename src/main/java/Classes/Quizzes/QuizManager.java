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
        String sql = "SELECT * FROM QuestionsTable WHERE quiz_id = ?";
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
}
