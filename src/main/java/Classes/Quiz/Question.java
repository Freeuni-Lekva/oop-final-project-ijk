package Classes.Quiz;

import java.sql.Timestamp;
import java.util.List;

public class Question {
    private int id;
    private int quizId;
    private String questionText;
    private QuestionType questionType;
    private int points;
    private int questionOrder;
    private String imageUrl;
    private String correctAnswer;
    private String explanation;
    private Timestamp createdAt;
    private List<String> options; // For multiple choice and image questions
    private List<String> fillInBlankOptions; // For fill in the blank questions
    
    // Constructors
    public Question() {}
    
    public Question(int quizId, String questionText, QuestionType questionType, int points, int questionOrder, String correctAnswer) {
        this.quizId = quizId;
        this.questionText = questionText;
        this.questionType = questionType;
        this.points = points;
        this.questionOrder = questionOrder;
        this.correctAnswer = correctAnswer;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getQuizId() {
        return quizId;
    }
    
    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }
    
    public String getQuestionText() {
        return questionText;
    }
    
    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }
    
    public QuestionType getQuestionType() {
        return questionType;
    }
    
    public void setQuestionType(QuestionType questionType) {
        this.questionType = questionType;
    }
    
    public int getPoints() {
        return points;
    }
    
    public void setPoints(int points) {
        this.points = points;
    }
    
    public int getQuestionOrder() {
        return questionOrder;
    }
    
    public void setQuestionOrder(int questionOrder) {
        this.questionOrder = questionOrder;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public String getCorrectAnswer() {
        return correctAnswer;
    }
    
    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
    }
    
    public String getExplanation() {
        return explanation;
    }
    
    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public List<String> getOptions() {
        return options;
    }
    
    public void setOptions(List<String> options) {
        this.options = options;
    }
    
    public List<String> getFillInBlankOptions() {
        return fillInBlankOptions;
    }
    
    public void setFillInBlankOptions(List<String> fillInBlankOptions) {
        this.fillInBlankOptions = fillInBlankOptions;
    }
    
    @Override
    public String toString() {
        return "Question{" +
                "id=" + id +
                ", quizId=" + quizId +
                ", questionText='" + questionText + '\'' +
                ", questionType=" + questionType +
                ", points=" + points +
                ", questionOrder=" + questionOrder +
                ", imageUrl='" + imageUrl + '\'' +
                ", correctAnswer='" + correctAnswer + '\'' +
                ", explanation='" + explanation + '\'' +
                '}';
    }
} 