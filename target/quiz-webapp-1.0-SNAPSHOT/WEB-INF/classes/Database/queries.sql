USE quizdb;

DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password TEXT,
    email TEXT,
    administrator BOOLEAN,
    requestNotification BOOLEAN
);

DROP TABLE IF EXISTS FriendRequests;
CREATE TABLE FriendRequests (
    usernameFrom TEXT,
    usernameTo TEXT,
    date TIMESTAMP
);

DROP TABLE IF EXISTS Friends;
CREATE TABLE Friends (
    usernameFrom TEXT,
    usenameTo TEXT
);

DROP TABLE IF EXISTS QuestionsTable;
CREATE TABLE QuestionsTable (
    id INT,
    ordered SERIAL,
    type INT,
    question TEXT,
    possibleAnswers TEXT,
    answer TEXT
);

DROP TABLE IF EXISTS Quizzes;
CREATE TABLE Quizzes (
    id SERIAL PRIMARY KEY,
    name TEXT,
    category TEXT,
    difficulty INT,
    duration INT,
    user TEXT,
    description TEXT,
    random BOOLEAN,
    onePage BOOLEAN,
    immediateCorrection BOOLEAN
);

DROP TABLE IF EXISTS QuizAttempts;
CREATE TABLE QuizAttempts (
    id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED,
    quiz_id BIGINT UNSIGNED,
    score DECIMAL,
    taken_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    duration_seconds INT,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (quiz_id) REFERENCES Quizzes(id)
);

DROP TABLE IF EXISTS UserPoints;
CREATE TABLE UserPoints (
    user_id BIGINT UNSIGNED PRIMARY KEY ,
    points BIGINT
);

DROP TABLE IF EXISTS Achievements;
CREATE TABLE Achievements (
    user_id BIGINT UNSIGNED,
    FAST_LEARNER BOOLEAN,
    ON_FIRE BOOLEAN,
    GENIUS BOOLEAN,
    CHAMPION BOOLEAN
);