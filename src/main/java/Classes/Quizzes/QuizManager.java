package Classes.Quizzes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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
        // Add more fields as needed (e.g., number of questions, duration, taken count)
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
                    quizzes.add(quiz);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return quizzes;
    }
}
