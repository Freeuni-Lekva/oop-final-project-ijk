# Quiz Database Documentation

This document describes the database structure for the quiz application that supports four types of questions: Multiple Choice, Fill in the Blank, Question Response, and Image Questions.

## Database Schema Overview

The database consists of the following main tables:

### Core Tables
1. **Users** - User accounts and authentication
2. **Quizzes** - Quiz metadata and settings
3. **Questions** - All questions with their type and content
4. **QuizAttempts** - Tracks when users take quizzes
5. **UserAnswers** - Stores individual question responses

### Question Type Specific Tables
6. **MultipleChoiceOptions** - Options for multiple choice questions
7. **FillInBlankOptions** - Acceptable answers for fill in the blank questions
8. **ImageQuestionOptions** - Options for image-based questions

## Question Types

### 1. Multiple Choice Questions
- **Description**: Questions with predefined answer options (A, B, C, D, etc.)
- **Database Storage**: 
  - Main question in `Questions` table with `question_type = 'multiple_choice'`
  - Options stored in `MultipleChoiceOptions` table
- **Example**: "What is the capital of France?" with options: London, Paris, Berlin, Madrid

### 2. Fill in the Blank Questions
- **Description**: Questions where users type their answer
- **Database Storage**:
  - Main question in `Questions` table with `question_type = 'fill_in_blank'`
  - Multiple acceptable answers stored in `FillInBlankOptions` table
- **Features**: Supports case-insensitive matching and multiple acceptable answers
- **Example**: "The chemical symbol for gold is ____." with acceptable answers: "Au", "AU", "au"

### 3. Question Response Questions
- **Description**: Simple text input questions with one correct answer
- **Database Storage**: Only in `Questions` table with `question_type = 'question_response'`
- **Example**: "What is 2 + 2?" with answer "4"

### 4. Image Questions
- **Description**: Questions that include an image with multiple choice options
- **Database Storage**:
  - Main question in `Questions` table with `question_type = 'image_question'`
  - Image URL stored in `image_url` field
  - Options stored in `ImageQuestionOptions` table
- **Example**: "What animal is shown in this image?" with an image and options: Tiger, Lion, Leopard, Cheetah

## Database Setup

### 1. Create the Database
```sql
CREATE DATABASE quizdb;
USE quizdb;
```

### 2. Run the Schema
Execute the `src/main/java/Database/queries.sql` file to create all tables and sample data.

### 3. Verify Installation
The script includes sample data for testing:
- Sample users (admin, teacher1, student1, student2)
- Sample quizzes (General Knowledge Quiz, Math Quiz)
- Sample questions of all four types

## Java Classes

### Core Classes
- **QuizManager**: Manages quiz operations (create, retrieve quizzes)
- **QuestionManager**: Handles adding different types of questions
- **Quiz**: Represents a quiz entity
- **Question**: Represents a question entity
- **QuestionType**: Enum for the four question types

### Usage Examples

#### Creating a Quiz
```java
QuizManager quizManager = new QuizManager();
boolean success = quizManager.createQuiz(
    "My Quiz", 
    "A test quiz", 
    1, // created_by user ID
    30, // time limit in minutes
    70  // passing score percentage
);
```

#### Adding Multiple Choice Question
```java
QuestionManager questionManager = new QuestionManager();
List<String> options = Arrays.asList("London", "Paris", "Berlin", "Madrid");
boolean success = questionManager.addMultipleChoiceQuestion(
    1, // quiz ID
    "What is the capital of France?",
    1, // points
    1, // question order
    "Paris", // correct answer
    "Paris is the capital and largest city of France.",
    options
);
```

#### Adding Fill in the Blank Question
```java
List<String> acceptableAnswers = Arrays.asList("Au", "AU", "au");
boolean success = questionManager.addFillInBlankQuestion(
    1, // quiz ID
    "The chemical symbol for gold is ____.",
    1, // points
    2, // question order
    "Au", // correct answer
    "Au comes from the Latin word 'aurum' meaning gold.",
    acceptableAnswers
);
```

#### Adding Question Response Question
```java
boolean success = questionManager.addQuestionResponseQuestion(
    1, // quiz ID
    "What is 2 + 2?",
    1, // points
    3, // question order
    "4", // correct answer
    "Basic arithmetic: 2 + 2 = 4"
);
```

#### Adding Image Question
```java
List<String> options = Arrays.asList("Tiger", "Lion", "Leopard", "Cheetah");
boolean success = questionManager.addImageQuestion(
    1, // quiz ID
    "What animal is shown in this image?",
    1, // points
    4, // question order
    "Lion", // correct answer
    "This is a lion, the king of the jungle.",
    "/images/lion.jpg", // image URL
    options
);
```

## Database Features

### Quiz Management
- **Time Limits**: Optional time limits for quizzes
- **Passing Scores**: Configurable passing score percentages
- **Active/Inactive**: Quizzes can be marked as active or inactive
- **Audit Trail**: Creation and update timestamps

### Question Features
- **Point Values**: Each question can have different point values
- **Ordering**: Questions are ordered within quizzes
- **Explanations**: Optional explanations for correct answers
- **Multiple Acceptable Answers**: For fill in the blank questions

### User Experience
- **Attempt Tracking**: All quiz attempts are recorded
- **Score Calculation**: Automatic score calculation and pass/fail determination
- **Answer History**: Individual question responses are stored
- **Time Tracking**: Time taken for each quiz attempt

## Security Considerations

1. **Password Storage**: Passwords should be hashed (currently stored as plain text for simplicity)
2. **SQL Injection Prevention**: All queries use PreparedStatements
3. **Input Validation**: Validate all user inputs before database operations
4. **Access Control**: Check user permissions before allowing quiz creation/modification

## Performance Optimizations

1. **Indexes**: Added on frequently queried columns
2. **Foreign Keys**: Proper relationships with CASCADE deletes
3. **Connection Pooling**: Consider implementing connection pooling for production
4. **Query Optimization**: Use specific queries instead of loading all data

## Future Enhancements

1. **Question Categories**: Add categories/tags for questions
2. **Question Banks**: Reusable question pools
3. **Randomization**: Random question and option ordering
4. **Advanced Scoring**: Partial credit, negative points, etc.
5. **Question Media**: Support for videos, audio, and other media types
6. **Analytics**: Detailed quiz performance analytics
7. **Export/Import**: Quiz and question import/export functionality

## Troubleshooting

### Common Issues
1. **Database Connection**: Ensure MySQL is running and credentials are correct
2. **Driver Issues**: Make sure MySQL JDBC driver is in the classpath
3. **Foreign Key Constraints**: Ensure referenced records exist before creating relationships
4. **Character Encoding**: Use UTF-8 for proper text handling

### Testing
Use the sample data provided in the SQL script to test all question types and functionality. 