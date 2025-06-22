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