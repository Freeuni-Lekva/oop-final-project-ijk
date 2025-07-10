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