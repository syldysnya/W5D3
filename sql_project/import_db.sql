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
  ('Arthur', 'Miller'),
  ('blah blah', 'Miller'),
  ('testing', 'Miller'),
  ('Eugene O','Neill');


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
  ('All My Sons', 'body body body ', (SELECT id FROM users WHERE fname = 'Arthur')),
  ('How do you use SQL?', 'body jalsdkfljalsdf', (SELECT id FROM users WHERE fname = 'testing'));



CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    follower_id INTEGER NOT NULL,
    following_id INTEGER NOT NULL,
    
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (following_id) REFERENCES users(id)
);


CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    subject_question TEXT NOT NULL,
    qustion_parent INTEGER,
    reply_body TEXT NOT NULL,
    reply_user INTEGER NOT NULL,

    FOREIGN KEY (subject_question) REFERENCES questions(title),
    FOREIGN KEY (qustion_parent) REFERENCES replies(id),
    FOREIGN KEY (reply_user) REFERENCES users(id)
);



CREATE TABLE question_likes(
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);



INSERT INTO
    question_follows(follower_id, following_id)
VALUES
    ((SELECT id FROM users WHERE fName = 'Arthur'),(SELECT id FROM users WHERE fName = 'testing')),
    ((SELECT id FROM users WHERE fName = 'testing'),(SELECT id FROM users WHERE fName = 'blah blah'));              
