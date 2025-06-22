package Classes.Quiz;

import java.sql.Timestamp;
import java.util.List;

public class Quiz {
    private int id;
    private String title;
    private String description;
    private int createdBy;
    private boolean isActive;
    private Integer timeLimitMinutes;
    private int passingScore;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private List<Question> questions;
    
    // Constructors
    public Quiz() {}
    
    public Quiz(String title, String description, int createdBy, Integer timeLimitMinutes, int passingScore) {
        this.title = title;
        this.description = description;
        this.createdBy = createdBy;
        this.timeLimitMinutes = timeLimitMinutes;
        this.passingScore = passingScore;
        this.isActive = true;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public int getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
    
    public Integer getTimeLimitMinutes() {
        return timeLimitMinutes;
    }
    
    public void setTimeLimitMinutes(Integer timeLimitMinutes) {
        this.timeLimitMinutes = timeLimitMinutes;
    }
    
    public int getPassingScore() {
        return passingScore;
    }
    
    public void setPassingScore(int passingScore) {
        this.passingScore = passingScore;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public List<Question> getQuestions() {
        return questions;
    }
    
    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }
    
    @Override
    public String toString() {
        return "Quiz{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", createdBy=" + createdBy +
                ", isActive=" + isActive +
                ", timeLimitMinutes=" + timeLimitMinutes +
                ", passingScore=" + passingScore +
                ", createdAt=" + createdAt +
                '}';
    }
} 