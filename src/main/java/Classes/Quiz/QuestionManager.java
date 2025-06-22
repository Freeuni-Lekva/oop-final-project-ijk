package Classes.Quiz;

import java.sql.*;
import java.util.List;

public class QuestionManager {
    
    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/quizdb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "12345";
    
    public QuestionManager() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
        }
    }
    
    /**
     * Adds a multiple choice question to a quiz
     */
    public boolean addMultipleChoiceQuestion(int quizId, String questionText, int points, int questionOrder, 
                                           String correctAnswer, String explanation, List<String> options) {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            conn.setAutoCommit(false);
            
            // Insert the question
            String questionSql = "INSERT INTO Questions (quiz_id, question_text, question_type, points, question_order, correct_answer, explanation) VALUES (?, ?, 'multiple_choice', ?, ?, ?, ?)";
            int questionId;
            try (PreparedStatement pstmt = conn.prepareStatement(questionSql, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setInt(1, quizId);
                pstmt.setString(2, questionText);
                pstmt.setInt(3, points);
                pstmt.setInt(4, questionOrder);
                pstmt.setString(5, correctAnswer);
                pstmt.setString(6, explanation);
                pstmt.executeUpdate();
                
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        questionId = rs.getInt(1);
                    } else {
                        throw new SQLException("Failed to get generated question ID");
                    }
                }
            }
            
            // Insert the options
            String optionSql = "INSERT INTO MultipleChoiceOptions (question_id, option_text, option_letter, is_correct, option_order) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(optionSql)) {
                char optionLetter = 'A';
                for (int i = 0; i < options.size(); i++) {
                    String option = options.get(i);
                    boolean isCorrect = option.equals(correctAnswer);
                    pstmt.setInt(1, questionId);
                    pstmt.setString(2, option);
                    pstmt.setString(3, String.valueOf(optionLetter));
                    pstmt.setBoolean(4, isCorrect);
                    pstmt.setInt(5, i + 1);
                    pstmt.executeUpdate();
                    optionLetter++;
                }
            }
            
            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            System.err.println("Error adding multiple choice question: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    /**
     * Adds a fill in the blank question to a quiz
     */
    public boolean addFillInBlankQuestion(int quizId, String questionText, int points, int questionOrder,
                                        String correctAnswer, String explanation, List<String> acceptableAnswers) {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            conn.setAutoCommit(false);
            
            // Insert the question
            String questionSql = "INSERT INTO Questions (quiz_id, question_text, question_type, points, question_order, correct_answer, explanation) VALUES (?, ?, 'fill_in_blank', ?, ?, ?, ?)";
            int questionId;
            try (PreparedStatement pstmt = conn.prepareStatement(questionSql, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setInt(1, quizId);
                pstmt.setString(2, questionText);
                pstmt.setInt(3, points);
                pstmt.setInt(4, questionOrder);
                pstmt.setString(5, correctAnswer);
                pstmt.setString(6, explanation);
                pstmt.executeUpdate();
                
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        questionId = rs.getInt(1);
                    } else {
                        throw new SQLException("Failed to get generated question ID");
                    }
                }
            }
            
            // Insert acceptable answers
            String answerSql = "INSERT INTO FillInBlankOptions (question_id, acceptable_answer, is_case_sensitive, is_exact_match) VALUES (?, ?, FALSE, TRUE)";
            try (PreparedStatement pstmt = conn.prepareStatement(answerSql)) {
                for (String answer : acceptableAnswers) {
                    pstmt.setInt(1, questionId);
                    pstmt.setString(2, answer);
                    pstmt.executeUpdate();
                }
            }
            
            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            System.err.println("Error adding fill in blank question: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    /**
     * Adds a question response question to a quiz
     */
    public boolean addQuestionResponseQuestion(int quizId, String questionText, int points, int questionOrder,
                                             String correctAnswer, String explanation) {
        String sql = "INSERT INTO Questions (quiz_id, question_text, question_type, points, question_order, correct_answer, explanation) VALUES (?, ?, 'question_response', ?, ?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, quizId);
            pstmt.setString(2, questionText);
            pstmt.setInt(3, points);
            pstmt.setInt(4, questionOrder);
            pstmt.setString(5, correctAnswer);
            pstmt.setString(6, explanation);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding question response question: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Adds an image question to a quiz
     */
    public boolean addImageQuestion(int quizId, String questionText, int points, int questionOrder,
                                  String correctAnswer, String explanation, String imageUrl, List<String> options) {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            conn.setAutoCommit(false);
            
            // Insert the question
            String questionSql = "INSERT INTO Questions (quiz_id, question_text, question_type, points, question_order, correct_answer, explanation, image_url) VALUES (?, ?, 'image_question', ?, ?, ?, ?, ?)";
            int questionId;
            try (PreparedStatement pstmt = conn.prepareStatement(questionSql, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setInt(1, quizId);
                pstmt.setString(2, questionText);
                pstmt.setInt(3, points);
                pstmt.setInt(4, questionOrder);
                pstmt.setString(5, correctAnswer);
                pstmt.setString(6, explanation);
                pstmt.setString(7, imageUrl);
                pstmt.executeUpdate();
                
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        questionId = rs.getInt(1);
                    } else {
                        throw new SQLException("Failed to get generated question ID");
                    }
                }
            }
            
            // Insert the options
            String optionSql = "INSERT INTO ImageQuestionOptions (question_id, option_text, option_letter, is_correct, option_order) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(optionSql)) {
                char optionLetter = 'A';
                for (int i = 0; i < options.size(); i++) {
                    String option = options.get(i);
                    boolean isCorrect = option.equals(correctAnswer);
                    pstmt.setInt(1, questionId);
                    pstmt.setString(2, option);
                    pstmt.setString(3, String.valueOf(optionLetter));
                    pstmt.setBoolean(4, isCorrect);
                    pstmt.setInt(5, i + 1);
                    pstmt.executeUpdate();
                    optionLetter++;
                }
            }
            
            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            System.err.println("Error adding image question: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
} 