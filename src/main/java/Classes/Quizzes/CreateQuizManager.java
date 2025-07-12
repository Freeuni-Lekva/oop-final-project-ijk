package Classes.Quizzes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CreateQuizManager {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/quizdb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Alerteki1!";

    public static class QuizCreationResult {
        public boolean success;
        public String message;
        public int quizId;

        public QuizCreationResult(boolean success, String message, int quizId) {
            this.success = success;
            this.message = message;
            this.quizId = quizId;
        }
    }

    public static class QuestionData {
        public String questionText;
        public int questionType;
        public String correctAnswer;
        public String options; // ';' separated string for multiple choice, empty for others
        public String imagePath; // For picture-response questions, relative file path

        public QuestionData(String questionText, int questionType, String correctAnswer) {
            this.questionText = questionText;
            this.questionType = questionType;
            this.correctAnswer = correctAnswer;
            this.options = "";
            this.imagePath = null;
        }
    }

    public static class QuizData {
        public String name;
        public String category;
        public int difficulty;
        public String description;
        public int duration;
        public boolean randomQuestions;
        public boolean onePageMode;
        public boolean immediateCorrection;
        public String username;
        public List<QuestionData> questions;

        public QuizData(String name, String category, int difficulty, String description, 
                       int duration, boolean randomQuestions, boolean onePageMode, 
                       boolean immediateCorrection, String username) {
            this.name = name;
            this.category = category;
            this.difficulty = difficulty;
            this.description = description;
            this.duration = duration;
            this.randomQuestions = randomQuestions;
            this.onePageMode = onePageMode;
            this.immediateCorrection = immediateCorrection;
            this.username = username;
            this.questions = new ArrayList<>();
        }
    }

    public QuizCreationResult createQuiz(QuizData quizData) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            conn.setAutoCommit(false); // Start transaction

            // If randomQuestions is true, override category and skip user questions
            if (quizData.randomQuestions) {
                quizData.category = "Random Quiz";
            }

            // Insert quiz into Quizzes table
            String insertQuizSQL = "INSERT INTO Quizzes (name, category, difficulty, duration, user, description, random, onePage, immediateCorrection) " +
                                 "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            pstmt = conn.prepareStatement(insertQuizSQL, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, quizData.name);
            pstmt.setString(2, quizData.category); // Store as display text
            pstmt.setInt(3, quizData.difficulty);
            pstmt.setInt(4, quizData.duration);
            pstmt.setString(5, quizData.username);
            pstmt.setString(6, quizData.description);
            pstmt.setBoolean(7, quizData.randomQuestions);
            pstmt.setBoolean(8, quizData.onePageMode);
            pstmt.setBoolean(9, quizData.immediateCorrection);

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows == 0) {
                conn.rollback();
                return new QuizCreationResult(false, "Failed to create quiz", -1);
            }

            // Get the generated quiz ID
            rs = pstmt.getGeneratedKeys();
            int quizId = -1;
            if (rs.next()) {
                quizId = rs.getInt(1);
            } else {
                conn.rollback();
                return new QuizCreationResult(false, "Failed to get quiz ID", -1);
            }

            if (quizData.randomQuestions) {
                // Select 10 random questions (not type 4)
                String selectRandomSQL = "SELECT * FROM QuestionsTable WHERE type != 4 ORDER BY RAND() LIMIT 10";
                Statement selectStmt = conn.createStatement();
                ResultSet randomQs = selectStmt.executeQuery(selectRandomSQL);
                String insertQuestionSQL = "INSERT INTO QuestionsTable (id, ordered, type, question, possibleAnswers, answer, image) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement insertQ = conn.prepareStatement(insertQuestionSQL);
                int order = 1;
                while (randomQs.next()) {
                    insertQ.setInt(1, quizId);
                    insertQ.setInt(2, order++);
                    insertQ.setInt(3, randomQs.getInt("type"));
                    insertQ.setString(4, randomQs.getString("question"));
                    insertQ.setString(5, randomQs.getString("possibleAnswers"));
                    insertQ.setString(6, randomQs.getString("answer"));
                    insertQ.setString(7, randomQs.getString("image"));
                    insertQ.executeUpdate();
                }
                insertQ.close();
                randomQs.close();
                selectStmt.close();
            } else {
                // Insert user-provided questions as before
                String insertQuestionSQL = "INSERT INTO QuestionsTable (id, ordered, type, question, possibleAnswers, answer, image) VALUES (?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(insertQuestionSQL);
                for (int i = 0; i < quizData.questions.size(); i++) {
                    QuestionData question = quizData.questions.get(i);
                    pstmt.setInt(1, quizId); // id (quiz id)
                    pstmt.setInt(2, i + 1); // ordered
                    pstmt.setInt(3, question.questionType); // type
                    pstmt.setString(4, question.questionText); // question
                    pstmt.setString(5, question.options); // possibleAnswers (';' separated for MC, empty for others)
                    pstmt.setString(6, question.correctAnswer); // answer
                    pstmt.setString(7, question.imagePath); // image path as TEXT
                    pstmt.executeUpdate();
                }
            }

            conn.commit(); // Commit transaction
            return new QuizCreationResult(true, "Quiz created successfully", quizId);

        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback(); // Rollback on error
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            return new QuizCreationResult(false, "Database error: " + e.getMessage(), -1);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // For multiple choice, join options with ';'. For others, return empty string.
    public static String buildOptionsString(List<String> options) {
        if (options == null || options.isEmpty()) {
            return "";
        }
        return String.join(";", options);
    }
}
