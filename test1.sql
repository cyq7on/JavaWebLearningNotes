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
SELECT * FROM USER

CREATE TABLE stu (
	sid	CHAR(6),
	sname		VARCHAR(50),
	age		INT,
	gender	VARCHAR(50)
);
INSERT INTO stu VALUES('S_1001', 'liuYi', 35, 'male');
INSERT INTO stu VALUES('S_1002', 'chenEr', 15, 'female');
INSERT INTO stu VALUES('S_1003', 'zhangSan', 95, 'male');
INSERT INTO stu VALUES('S_1004', 'liSi', 65, 'female');
INSERT INTO stu VALUES('S_1005', 'wangWu', 55, 'male');
INSERT INTO stu VALUES('S_1006', 'zhaoLiu', 75, 'female');
INSERT INTO stu VALUES('S_1007', 'sunQi', 25, 'male');
INSERT INTO stu VALUES('S_1008', 'zhouBa', 45, 'female');
INSERT INTO stu VALUES('S_1009', 'wuJiu', 85, 'male');
INSERT INTO stu VALUES('S_1010', 'zhengShi', 5, 'female');
INSERT INTO stu VALUES('S_1011', 'xxx', NULL, NULL);
SELECT * FROM stu;
SELECT sname,gender FROM stu;
SELECT * FROM stu WHERE gender='female' AND age>=50;
SELECT * FROM stu WHERE age BETWEEN 25 AND 45;
SELECT * FROM stu WHERE sid IN ('s_1001','s_1003','s_1005');
SELECT * FROM stu WHERE age IS NULL;
SELECT * FROM stu WHERE sname LIKE '%c%';
SELECT * FROM stu WHERE sname LIKE '_h%';
SELECT DISTINCT gender FROM stu;
ALTER TABLE stu ADD height DOUBLE;
UPDATE stu SET height=174;
UPDATE stu SET height=NULL WHERE age<20;
SELECT *,age+height FROM stu;
SELECT *,IFNULL(age,0)+IFNULL(height,0) FROM stu;
SELECT *,IFNULL(age,0)+IFNULL(height,0) AS total FROM stu;
SELECT *,IFNULL(age,0)+IFNULL(height,0) 合计 FROM stu;
UPDATE stu SET age='5' WHERE age IS NULL;
UPDATE stu SET height=178 WHERE height IS NULL;
/*以上对数据进行改造以便测试*/
SELECT * FROM stu ORDER BY age;
SELECT * FROM stu ORDER BY age,height DESC;

SELECT COUNT(age) FROM stu;
SELECT COUNT(*) FROM stu WHERE age>50;
SELECT COUNT(*) FROM stu WHERE IFNULL(age,0)+IFNULL(height,0)>250;
INSERT INTO stu VALUES('S_1012', 'test', 23, NULL,NULL);
SELECT SUM(height),SUM(age),SUM(gender),AVG(age) FROM stu;
SELECT MAX(age),MIN(height) FROM stu;
SELECT gender,AVG(age) FROM stu GROUP BY gender;
SELECT gender,AVG(age) FROM stu WHERE gender IS NOT NULL GROUP BY gender;
SELECT gender,AVG(age) FROM stu WHERE gender IS NOT NULL GROUP BY gender HAVING AVG(age)>50;
SELECT * FROM stu LIMIT 1,3;

CREATE TABLE student(
id INT PRIMARY KEY,
NAME VARCHAR(50)
);
DROP TABLE student;
CREATE TABLE student(
id INT,
NAME VARCHAR(50),
PRIMARY KEY(id)
);
CREATE TABLE student(
stuid INT,
classid INT,
NAME VARCHAR(50),
PRIMARY KEY(stuid,classid)
);
CREATE TABLE student(
id INT,
NAME VARCHAR(50)
);
ALTER TABLE student ADD PRIMARY KEY(id);
ALTER TABLE student ADD CONSTRAINT pk_stu_id PRIMARY KEY(id);
ALTER TABLE student DROP PRIMARY KEY;
CREATE TABLE student(
id INT PRIMARY KEY,
NAME VARCHAR(50) NOT NULL,
sex VARCHAR(10) DEFAULT '女'
);
INSERT INTO student VALUES(1,'张小凡','男');
INSERT INTO student VALUES(2,'碧瑶',DEFAULT);
INSERT INTO student(id,NAME) VALUES(3,'陆师姐');
SELECT * FROM student;
CREATE TABLE score(
scoreid INT,
score DOUBLE,
stuid INT,
CONSTRAINT fk_student_score_stuid FOREIGN KEY(stuid) REFERENCES student(id)
)
ALTER TABLE score DROP FOREIGN KEY fk_student_score_stuid;
SELECT * FROM score;
DROP TABLE score;
CREATE TABLE score(
scoreid INT,
scorename VARCHAR(50),
score DOUBLE,
stuid INT,
CONSTRAINT fk_student_score_stuid FOREIGN KEY(stuid) REFERENCES student(id)
)
INSERT INTO score VALUES(1,'java',99,1),
                        (2,'java',90,2),
                        (3,'java',92,3),
                        (4,'mysql',95,1);
SELECT * FROM student,score;
SELECT * FROM student stu,score sco WHERE stu.id=sco.stuid;
SELECT * FROM student stu JOIN score sco ON stu.id=sco.stuid; 
INSERT INTO student VALUES(4,'花千骨',DEFAULT);
SELECT * FROM student stu LEFT JOIN score sco ON stu.id=sco.stuid;
SELECT * FROM student stu RIGHT JOIN score sco ON stu.id=sco.stuid;