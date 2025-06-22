package Classes.Quiz;

public enum QuestionType {
    MULTIPLE_CHOICE("multiple_choice"),
    FILL_IN_BLANK("fill_in_blank"),
    QUESTION_RESPONSE("question_response"),
    IMAGE_QUESTION("image_question");
    
    private final String databaseValue;
    
    QuestionType(String databaseValue) {
        this.databaseValue = databaseValue;
    }
    
    public String getDatabaseValue() {
        return databaseValue;
    }
    
    public static QuestionType fromDatabaseValue(String databaseValue) {
        for (QuestionType type : values()) {
            if (type.databaseValue.equals(databaseValue)) {
                return type;
            }
        }
        throw new IllegalArgumentException("Unknown question type: " + databaseValue);
    }
    
    @Override
    public String toString() {
        return databaseValue;
    }
} 