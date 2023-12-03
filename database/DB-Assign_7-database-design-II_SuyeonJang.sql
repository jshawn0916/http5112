--YOUR NAME HERE	ASSIGNMENT 7 GROUPING RESULTS
--Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 5; your query for question 1B should go on line 7...
-- 1 
--A
CREATE TABLE authors 
(authors_id INT(3) NOT NULL AUTO_INCREMENT primary key,
 name VARCHAR(25),
 email VARCHAR(25),
 website VARCHAR(255),
 joinDate DATE)
 ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT = "authors table";

 CREATE TABLE posts 
(posts_id INT(3) NOT NULL AUTO_INCREMENT primary key,
 title VARCHAR(25),
 content TEXT,
 authors_id SMALLINT(4) REFERENCES authors(authors_id),
 uploadDate DATE)
 ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT = "posts table";
--B
INSERT INTO authors (name,email,website,joinDate) 
VALUES ("Sean Doyle", "sean.doyle@humber.ca", "humber.ca","2023-11-07"),
("Skylor Lee", "skylor.lee@humber.ca", "humber.ca","2023-11-05"),
("Jenn Huh", "jenn.huh@humber.ca", "humber.ca","2023-11-05"),
("Eric Nam", "eric.nam@humber.ca", "humber.ca","2023-11-06");

INSERT INTO posts(title,content,authors_id,uploadDate)
VALUES ("Blog title1", "Blog1 content text", 3, "2023-11-07"),
("Blog title2", "Blog2 content text", 2, "2023-11-06"),
("Blog title3", "Blog3 content text", 4, "2023-11-07");

-- 2
--A
CREATE TABLE comments
(comment_id INT(3) NOT NULL AUTO_INCREMENT primary key,
name VARCHAR(25),
post SMALLINT(4) REFERENCES posts(posts_id),
content TEXT)
ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT = "comments table";
--B
INSERT INTO comments(name,post,content)
VALUES ("John Doe", 2, "comment text"),
("Bob Dylan", 3, "comment text"),
("Autumn Kim",1, "comment text");

-- 3
--A
ALTER TABLE comments
ADD comment_date DATE;

UPDATE comments SET comment_date = "2023-11-12" WHERE comment_id = 1;
UPDATE comments SET comment_date = "2023-11-13" WHERE comment_id = 2;
UPDATE comments SET comment_date = "2023-11-11" WHERE comment_id = 3;
--B
DELETE authors, posts
FROM authors
INNER JOIN posts ON authors.authors_id = posts.authors_id
WHERE authors.authors_id = 1 OR authors.authors_id = 2;
