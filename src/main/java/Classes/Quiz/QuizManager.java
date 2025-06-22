package Classes.Quiz;

import java.sql.*;
import java.util.*;

public class QuizManager {
    
    // Database connection details (same as AccountManager)
    private static final String DB_URL = "jdbc:mysql://localhost:3306/quizdb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "12345";
    
    public QuizManager() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
        }
    }
    
    // Quiz Management Methods
    
    /**
     * Creates a new quiz
     */
    public boolean createQuiz(String title, String description, int createdBy, Integer timeLimit, int passingScore) {
        String sql = "INSERT INTO Quizzes (title, description, created_by, time_limit_minutes, passing_score) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, title);
            pstmt.setString(2, description);
            pstmt.setInt(3, createdBy);
            pstmt.setObject(4, timeLimit); // Can be null
            pstmt.setInt(5, passingScore);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating quiz: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Gets all active quizzes
     */
    public List<Quiz> getAllQuizzes() {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT * FROM Quizzes WHERE is_active = TRUE ORDER BY created_at DESC";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setId(rs.getInt("id"));
                quiz.setTitle(rs.getString("title"));
                quiz.setDescription(rs.getString("description"));
                quiz.setCreatedBy(rs.getInt("created_by"));
                quiz.setTimeLimitMinutes(rs.getObject("time_limit_minutes", Integer.class));
                quiz.setPassingScore(rs.getInt("passing_score"));
                quiz.setCreatedAt(rs.getTimestamp("created_at"));
                quizzes.add(quiz);
            }
        } catch (SQLException e) {
            System.err.println("Error getting quizzes: " + e.getMessage());
            e.printStackTrace();
        }
        return quizzes;
    }
    
    /**
     * Gets a quiz by ID with all its questions
     */
    public Quiz getQuizWithQuestions(int quizId) {
        Quiz quiz = getQuizById(quizId);
        if (quiz != null) {
            quiz.setQuestions(getQuestionsForQuiz(quizId));
        }
        return quiz;
    }
    
    private Quiz getQuizById(int quizId) {
        String sql = "SELECT * FROM Quizzes WHERE id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, quizId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setId(rs.getInt("id"));
                    quiz.setTitle(rs.getString("title"));
                    quiz.setDescription(rs.getString("description"));
                    quiz.setCreatedBy(rs.getInt("created_by"));
                    quiz.setTimeLimitMinutes(rs.getObject("time_limit_minutes", Integer.class));
                    quiz.setPassingScore(rs.getInt("passing_score"));
                    quiz.setCreatedAt(rs.getTimestamp("created_at"));
                    return quiz;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting quiz: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Gets all questions for a specific quiz
     */
    private List<Question> getQuestionsForQuiz(int quizId) {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM Questions WHERE quiz_id = ? ORDER BY question_order";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, quizId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Question question = new Question();
                    question.setId(rs.getInt("id"));
                    question.setQuizId(rs.getInt("quiz_id"));
                    question.setQuestionText(rs.getString("question_text"));
                    question.setQuestionType(QuestionType.fromDatabaseValue(rs.getString("question_type")));
                    question.setPoints(rs.getInt("points"));
                    question.setQuestionOrder(rs.getInt("question_order"));
                    question.setImageUrl(rs.getString("image_url"));
                    question.setCorrectAnswer(rs.getString("correct_answer"));
                    question.setExplanation(rs.getString("explanation"));
                    
                    // Load options based on question type
                    switch (question.getQuestionType()) {
                        case MULTIPLE_CHOICE:
                            question.setOptions(getMultipleChoiceOptions(question.getId()));
                            break;
                        case FILL_IN_BLANK:
                            question.setFillInBlankOptions(getFillInBlankOptions(question.getId()));
                            break;
                        case IMAGE_QUESTION:
                            question.setOptions(getImageQuestionOptions(question.getId()));
                            break;
                        case QUESTION_RESPONSE:
                            // No options needed for question response
                            break;
                    }
                    
                    questions.add(question);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting questions: " + e.getMessage());
            e.printStackTrace();
        }
        return questions;
    }
    
    private List<String> getMultipleChoiceOptions(int questionId) {
        List<String> options = new ArrayList<>();
        String sql = "SELECT option_text FROM MultipleChoiceOptions WHERE question_id = ? ORDER BY option_order";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, questionId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    options.add(rs.getString("option_text"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting multiple choice options: " + e.getMessage());
            e.printStackTrace();
        }
        return options;
    }
    
    private List<String> getFillInBlankOptions(int questionId) {
        List<String> options = new ArrayList<>();
        String sql = "SELECT acceptable_answer FROM FillInBlankOptions WHERE question_id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, questionId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    options.add(rs.getString("acceptable_answer"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting fill in blank options: " + e.getMessage());
            e.printStackTrace();
        }
        return options;
    }
    
    private List<String> getImageQuestionOptions(int questionId) {
        List<String> options = new ArrayList<>();
        String sql = "SELECT option_text FROM ImageQuestionOptions WHERE question_id = ? ORDER BY option_order";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, questionId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    options.add(rs.getString("option_text"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting image question options: " + e.getMessage());
            e.printStackTrace();
        }
        return options;
    }
} 