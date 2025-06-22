-- Quiz Database Schema
-- This schema supports four types of questions: multiple choice, fill in the blank, question response, and image questions

USE quizdb;

-- Drop existing tables in reverse dependency order
DROP TABLE IF EXISTS QuizAttempts;
DROP TABLE IF EXISTS UserAnswers;
DROP TABLE IF EXISTS MultipleChoiceOptions;
DROP TABLE IF EXISTS FillInBlankOptions;
DROP TABLE IF EXISTS ImageQuestionOptions;
DROP TABLE IF EXISTS Questions;
DROP TABLE IF EXISTS Quizzes;
DROP TABLE IF EXISTS Users;

-- Users table (existing structure)
CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password TEXT NOT NULL,
    email TEXT,
    administrator BOOLEAN DEFAULT FALSE,
    requestNotification BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Quizzes table
CREATE TABLE Quizzes (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_by INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    time_limit_minutes INT DEFAULT NULL, -- NULL means no time limit
    passing_score INT DEFAULT 70, -- Percentage required to pass
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES Users(id) ON DELETE CASCADE
);

-- Questions table - supports all four question types
CREATE TABLE Questions (
    id SERIAL PRIMARY KEY,
    quiz_id INT NOT NULL,
    question_text TEXT NOT NULL,
    question_type ENUM('multiple_choice', 'fill_in_blank', 'question_response', 'image_question') NOT NULL,
    points INT DEFAULT 1,
    question_order INT NOT NULL, -- For ordering questions within a quiz
    image_url VARCHAR(500) DEFAULT NULL, -- For image questions
    correct_answer TEXT NOT NULL, -- The correct answer text
    explanation TEXT DEFAULT NULL, -- Optional explanation for the correct answer
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (quiz_id) REFERENCES Quizzes(id) ON DELETE CASCADE,
    INDEX idx_quiz_order (quiz_id, question_order)
);

-- Multiple Choice Options table
CREATE TABLE MultipleChoiceOptions (
    id SERIAL PRIMARY KEY,
    question_id INT NOT NULL,
    option_text TEXT NOT NULL,
    option_letter CHAR(1) NOT NULL, -- A, B, C, D, etc.
    is_correct BOOLEAN DEFAULT FALSE,
    option_order INT NOT NULL,
    FOREIGN KEY (question_id) REFERENCES Questions(id) ON DELETE CASCADE,
    UNIQUE KEY unique_question_option (question_id, option_letter),
    INDEX idx_question_order (question_id, option_order)
);

-- Fill in the Blank Options table (for multiple acceptable answers)
CREATE TABLE FillInBlankOptions (
    id SERIAL PRIMARY KEY,
    question_id INT NOT NULL,
    acceptable_answer TEXT NOT NULL,
    is_case_sensitive BOOLEAN DEFAULT FALSE,
    is_exact_match BOOLEAN DEFAULT TRUE, -- TRUE for exact match, FALSE for contains
    FOREIGN KEY (question_id) REFERENCES Questions(id) ON DELETE CASCADE
);

-- Image Question Options table (for image-based multiple choice)
CREATE TABLE ImageQuestionOptions (
    id SERIAL PRIMARY KEY,
    question_id INT NOT NULL,
    option_text TEXT NOT NULL,
    option_letter CHAR(1) NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE,
    option_order INT NOT NULL,
    image_url VARCHAR(500) DEFAULT NULL, -- Optional image for each option
    FOREIGN KEY (question_id) REFERENCES Questions(id) ON DELETE CASCADE,
    UNIQUE KEY unique_question_option (question_id, option_letter),
    INDEX idx_question_order (question_id, option_order)
);

-- Quiz Attempts table (tracks when users take quizzes)
CREATE TABLE QuizAttempts (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    quiz_id INT NOT NULL,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL,
    score INT DEFAULT NULL, -- Percentage score
    passed BOOLEAN DEFAULT NULL,
    time_taken_seconds INT DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id) REFERENCES Quizzes(id) ON DELETE CASCADE,
    INDEX idx_user_quiz (user_id, quiz_id),
    INDEX idx_completed_at (completed_at)
);

-- User Answers table (stores individual question responses)
CREATE TABLE UserAnswers (
    id SERIAL PRIMARY KEY,
    attempt_id INT NOT NULL,
    question_id INT NOT NULL,
    user_answer TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT NULL,
    points_earned INT DEFAULT 0,
    answered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (attempt_id) REFERENCES QuizAttempts(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES Questions(id) ON DELETE CASCADE,
    UNIQUE KEY unique_attempt_question (attempt_id, question_id),
    INDEX idx_attempt_id (attempt_id),
    INDEX idx_question_id (question_id)
);

-- Insert sample data for testing

-- Sample Users
INSERT INTO Users (username, password, email, administrator) VALUES
('admin', 'admin123', 'admin@quiz.com', TRUE),
('teacher1', 'teacher123', 'teacher1@quiz.com', TRUE),
('student1', 'student123', 'student1@quiz.com', FALSE),
('student2', 'student123', 'student2@quiz.com', FALSE);

-- Sample Quiz
INSERT INTO Quizzes (title, description, created_by, time_limit_minutes, passing_score) VALUES
('General Knowledge Quiz', 'Test your knowledge with various question types', 1, 30, 70),
('Math Quiz', 'Basic mathematics questions', 2, 20, 80);

-- Sample Questions for the General Knowledge Quiz
INSERT INTO Questions (quiz_id, question_text, question_type, points, question_order, correct_answer, explanation) VALUES
-- Multiple Choice Question
(1, 'What is the capital of France?', 'multiple_choice', 1, 1, 'Paris', 'Paris is the capital and largest city of France.'),
-- Fill in the Blank Question
(1, 'The chemical symbol for gold is ____.', 'fill_in_blank', 1, 2, 'Au', 'Au comes from the Latin word "aurum" meaning gold.'),
-- Question Response Question
(1, 'What is 2 + 2?', 'question_response', 1, 3, '4', 'Basic arithmetic: 2 + 2 = 4'),
-- Image Question
(1, 'What animal is shown in this image?', 'image_question', 1, 4, 'Lion', 'This is a lion, the king of the jungle.');

-- Multiple Choice Options for Question 1
INSERT INTO MultipleChoiceOptions (question_id, option_text, option_letter, is_correct, option_order) VALUES
(1, 'London', 'A', FALSE, 1),
(1, 'Paris', 'B', TRUE, 2),
(1, 'Berlin', 'C', FALSE, 3),
(1, 'Madrid', 'D', FALSE, 4);

-- Fill in the Blank Options for Question 2
INSERT INTO FillInBlankOptions (question_id, acceptable_answer, is_case_sensitive, is_exact_match) VALUES
(2, 'Au', FALSE, TRUE),
(2, 'AU', FALSE, TRUE),
(2, 'au', FALSE, TRUE);

-- Image Question Options for Question 4
INSERT INTO ImageQuestionOptions (question_id, option_text, option_letter, is_correct, option_order) VALUES
(4, 'Tiger', 'A', FALSE, 1),
(4, 'Lion', 'B', TRUE, 2),
(4, 'Leopard', 'C', FALSE, 3),
(4, 'Cheetah', 'D', FALSE, 4);

-- Sample Questions for the Math Quiz
INSERT INTO Questions (quiz_id, question_text, question_type, points, question_order, correct_answer, explanation) VALUES
(2, 'What is 5 x 6?', 'question_response', 1, 1, '30', '5 multiplied by 6 equals 30.'),
(2, 'What is the square root of 16?', 'fill_in_blank', 1, 2, '4', '4 x 4 = 16, so the square root of 16 is 4.'),
(2, 'Which of the following is a prime number?', 'multiple_choice', 1, 3, '7', '7 is a prime number as it has no divisors other than 1 and itself.');

-- Multiple Choice Options for Math Question 3
INSERT INTO MultipleChoiceOptions (question_id, option_text, option_letter, is_correct, option_order) VALUES
(7, '4', 'A', FALSE, 1),
(7, '6', 'B', FALSE, 2),
(7, '7', 'C', TRUE, 3),
(7, '8', 'D', FALSE, 4);

-- Fill in the Blank Options for Math Question 2
INSERT INTO FillInBlankOptions (question_id, acceptable_answer, is_case_sensitive, is_exact_match) VALUES
(6, '4', FALSE, TRUE),
(6, 'four', FALSE, TRUE),
(6, 'FOUR', FALSE, TRUE);