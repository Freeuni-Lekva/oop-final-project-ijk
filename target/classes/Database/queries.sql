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
    id SERIAL PRIMARY KEY,
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
    user TEXT,
    description TEXT,
    random BOOLEAN,
    onePage BOOLEAN,
    immediateCorrection BOOLEAN
);