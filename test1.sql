SHOW DATABASES
SHOW CREATE DATABASE test
CREATE DATABASE mydb
USE mydb
CREATE TABLE emp(
id INT,
NAME VARCHAR(20),
gender VARCHAR(10),
birhtday DATE,
Entry_data DATE,
job VARCHAR(20),
Salary DOUBLE,
RESUME TEXT
)
SHOW TABLES
DESC emp
ALTER TABLE emp ADD image BLOB
ALTER TABLE emp MODIFY job VARCHAR(60)
ALTER TABLE emp DROP image
RENAME TABLE emp TO USER
DESC USER
SHOW CREATE TABLE USER
ALTER TABLE USER CHARACTER SET gbk
ALTER TABLE USER CHANGE NAME username VARCHAR(60)
ALTER TABLE USER CHANGE birhtday birthday VARCHAR(20)
INSERT INTO USER(id,username,gender,birthday,Entry_data,job,Salary,RESUME) 
VALUES(1,'周杰伦','m','1978-5-12','2016-11-22','actor','100000.00','Music King')
INSERT INTO USER VALUES
(2,'周杰伦2','m','1978-5-12','2016-11-22','actor','100000.00','Music King'),
(3,'周杰伦3','m','1978-5-12','2016-11-22','actor','100000.00','Music King')
UPDATE USER SET job='singer & actor'
UPDATE USER SET job='singer' WHERE id=2
UPDATE USER SET Salary=Salary * 9 WHERE username='周杰伦2'
SELECT * FROM user