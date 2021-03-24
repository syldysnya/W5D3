PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Ned', 'Miller'),
  ('Kush', 'Mi'),
  ('Earl', 'Doe');


CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  associated_author INTEGER NOT NULL,

  FOREIGN KEY (associated_author) REFERENCES users(id)
);

INSERT INTO
    questions(title, body, associated_author)
VALUES
  ('Basics', 'What is diff between integer and string?', (SELECT id FROM users WHERE fname = 'Ned')),
  ('SQLite3', 'What is ORM?', (SELECT id FROM users WHERE fname = 'Kush')),
  ('Food', 'What is the best breakfast?', (SELECT id FROM users WHERE fname = 'Earl'));



CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    question_follows(user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fName = 'Ned'),(SELECT id FROM questions WHERE title = 'SQLite3')),
    ((SELECT id FROM users WHERE fName = 'Kush'),(SELECT id FROM questions WHERE title = 'Food'));              

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    author_id INTEGER,
    body TEXT NOT NULL,
    parent_id INTEGER,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (author_id) REFERENCES users(id),
    FOREIGN KEY (parent_id) REFERENCES replies(id)
);

INSERT INTO
    replies(question_id, author_id, body, parent_id)
VALUES
    ((SELECT id FROM questions WHERE title = 'SQLite3'), (SELECT id FROM users WHERE fname = 'Ned'), 'Great question, Kush', NULL),
    ((SELECT id FROM questions WHERE title = 'SQLite3'), (SELECT id FROM users WHERE fname = 'Earl'), 'Good response, Ned', (SELECT id FROM replies WHERE body = 'Great question, Kush'));



CREATE TABLE question_likes(
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    question_likes(user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = 'Ned'), (SELECT id FROM questions WHERE title = 'SQLite3'));



