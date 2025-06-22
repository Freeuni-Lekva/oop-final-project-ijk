USE quizdb;

DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL,
    password TEXT,
    email TEXT,
    administrator BOOLEAN,
    requestNotification BOOLEAN
);