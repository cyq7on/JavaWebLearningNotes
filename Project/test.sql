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
SELECT * FROM student NATURAL JOIN score;
SELECT * FROM student NATURAL LEFT JOIN score;
SELECT * FROM student NATURAL RIGHT JOIN score;
ALTER TABLE score DROP FOREIGN KEY fk_student_score_stuid;
ALTER TABLE student CHANGE id stuid INT;
ALTER TABLE score ADD CONSTRAINT fk_student_score_stuid FOREIGN KEY(stuid) REFERENCES student(stuid);
CREATE TABLE emp(
	empno		INT,
	ename		VARCHAR(50),
	job		VARCHAR(50),
	mgr		INT,
	hiredate	DATE,
	sal		DECIMAL(7,2),
	comm		DECIMAL(7,2),
	deptno		INT
) ;
INSERT INTO emp VALUES(7369,'SMITH','CLERK',7902,'1980-12-17',800,NULL,20);
INSERT INTO emp VALUES(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
INSERT INTO emp VALUES(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,500,30);
INSERT INTO emp VALUES(7566,'JONES','MANAGER',7839,'1981-04-02',2975,NULL,20);
INSERT INTO emp VALUES(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,1400,30);
INSERT INTO emp VALUES(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850,NULL,30);
INSERT INTO emp VALUES(7782,'CLARK','MANAGER',7839,'1981-06-09',2450,NULL,10);
INSERT INTO emp VALUES(7788,'SCOTT','ANALYST',7566,'1987-04-19',3000,NULL,20);
INSERT INTO emp VALUES(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000,NULL,10);
INSERT INTO emp VALUES(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO emp VALUES(7876,'ADAMS','CLERK',7788,'1987-05-23',1100,NULL,20);
INSERT INTO emp VALUES(7900,'JAMES','CLERK',7698,'1981-12-03',950,NULL,30);
INSERT INTO emp VALUES(7902,'FORD','ANALYST',7566,'1981-12-03',3000,NULL,20);
INSERT INTO emp VALUES(7934,'MILLER','CLERK',7782,'1982-01-23',1300,NULL,10);
CREATE TABLE dept(
	deptno		INT,
	dname		VARCHAR(14),
	loc		VARCHAR(13)
);
INSERT INTO dept VALUES(10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES(20, 'RESEARCH', 'DALLAS');
INSERT INTO dept VALUES(30, 'SALES', 'CHICAGO');
INSERT INTO dept VALUES(40, 'OPERATIONS', 'BOSTON');
/*工资高于JONES的员工*/
SELECT * FROM emp WHERE sal > (SELECT sal FROM emp WHERE ename='JONES');
/*工资高于30号部门所有人的员工信息*/
SELECT * FROM emp WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno=30);
SELECT * FROM emp WHERE sal > ALL (SELECT sal FROM emp WHERE deptno=30)
/*查询工作和工资与MARTIN（马丁）完全相同的员工信息*/
SELECT * FROM emp WHERE (job,sal) IN (SELECT job,sal FROM emp WHERE ename='MARTIN');
/*查询有2个以上直接下属的员工信息*/
SELECT * FROM emp WHERE empno IN (SELECT mgr FROM emp GROUP BY mgr HAVING COUNT(mgr)>2);
/*查询员工编号为7788的员工名称、员工工资、部门名称、部门地址*/
SELECT e.ename,e.sal,d.dname,d.loc FROM emp e,dept d WHERE e.deptno=d.deptno AND e.empno=7788;
SELECT e.ename, e.sal, d.dname, d.loc 
FROM emp e, (SELECT dname,loc,deptno FROM dept) d 
WHERE e.deptno=d.deptno AND e.empno=7788
SELECT * FROM emp WHERE empno=7369;
SELECT e1.empno,e1.ename,e2.mgr,e2.ename FROM emp e1,emp e2 WHERE e1.empno=7369 AND e1.mgr=e2.empno;
/*查询各个部门薪水最高的员工所有信息*/
INSERT INTO emp VALUES(7782,'test','MANAGER',7839,'1981-06-09',3000,NULL,10);
/*有问题的查询方式*/
SELECT * FROM emp WHERE sal IN (SELECT MAX(sal)FROM emp GROUP BY deptno);
/*正解*/
SELECT e.* FROM emp e,(SELECT MAX(sal) MAX,deptno FROM emp GROUP BY deptno)m WHERE e.deptno=m.deptno AND e.sal=m.max;