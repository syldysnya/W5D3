
DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  associated_author INTEGER NOT NULL,

  FOREIGN KEY (associated_author) REFERENCES users(id)
);

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL,
);

DROP TABLE IF EXISTS question_follows;
CREATE TABLE question_follows (
    SELECT
        *
    FROM
        questions
    JOIN 
        users
    ON
        questions.associated_author = users.id 
        ---?????????^^^^^^^
);

DROP TABLE IF EXISTS replies;
CREATE TABLE replies (
    -- Each reply: questions.id,??????, user.id
    SELECT
        body, 
    FROM
        questions
    JOIN 
        users
    ON
        questions.title = questions.body
        ---?????????^^^^^^^
);