#一、sql概述
sql：Structure Query Language，结构化查询语言
#二、sql分类
##1、DDL
DDL，即Data Definition Language，数据定义语言，用来定义数据库对象：库、表和列等。  
使用的关键字：CREATE,ALTER,DROP
###1.1、操作数据库：
`create database mydb character set utf8 collate gbk_chinese_ci `

collate：指定数据库字符集的比较方式
```sql
show databases
show create database mydb
alter database mydb character set gbk
drop database mydb
use mydb
select database()
```
###1.2、操作数据表：
MySQL常用数据类型：  
      int：整型  
      double：浮点型，例如double(5,2)表示最多5位，其中必须有2位小数，即最大值为999.99  
			char：固定长度字符串类型； char(10)  'abc'  
			varchar：可变长度字符串类型；varchar(10) 'abc'  
			text：字符串类型  
			blob：字节类型  
			date：日期类型，格式为：yyyy-MM-dd  
			time：时间类型，格式为：hh:mm:ss  
			timestamp：时间戳类型 yyyy-MM-dd hh:mm:ss  会自动赋值  
			datetime:日期时间类型 yyyy-MM-dd hh:mm:ss  

```sql
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
show tables
desc emp
alter table emp add image blob
alter table emp modify job varchar(60)
alter table emp drop image
rename table emp to user
show create table user
alter table user character set gbk
alter table user change name username varchar(20)
```
##2、DML
DML，即Data Manipulation Language，数据操作语言，用来操作数据库表中的数据。  
使用的关键字：INSERT,UPDATE,DELETE
```sql
INSERT INTO USER(id,username,gender,birthday,Entry_data,job,Salary,RESUME) 
VALUES(1,'周杰伦','m','1978-5-12','2016-11-22','actor','100000.00','Music King')
INSERT INTO USER VALUES
(2,'周杰伦2','m','1978-5-12','2016-11-22','actor','100000.00','Music King'),
(3,'周杰伦3','m','1978-5-12','2016-11-22','actor','100000.00','Music King')
update user set job='actor&singer'
update user set job='singer' where id=2
update user set Salary=Salary * 9 where id=3
delete from user where username='周杰伦'
delete from user
truncate table user
```
DELETE：  
    删除表中的数据，表结构还在  
    删除后的数据可以找回  

TRUNCATE：  
    把表直接DROP掉，然后再创建一个同样的新表  
    删除的数据不能找回  
    执行速度比DELETE快  
**Attention：以上的sql语句句末都没有分号，单句执行没有问题，但是想要多句一起执行就血崩了，所以，以后还是都加上分号。**
##3、DQL  

DQL，即Data Query Language，数据操作语言，用来查询记录（数据）。查询返回的结果集是一张虚拟表，对数据库本身没有影响。  
关键字：SELECT  
语法：  
SELECT 列名 FROM表名【WHERE --> GROUP BY -->HAVING--> ORDER BY】  
SELECT selection_list /*要查询的列名称*/  
FROM table_list /*要查询的表名称*/  
WHERE condition /*行条件*/  
GROUP BY grouping_columns /*对结果分组*/  
HAVING condition /*分组后的行条件*/  
ORDER BY sorting_columns /*对结果分组*/  
LIMIT offset_start, row_count /*结果限定*/  
首选建一个供之后查询用的表：
```sql
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
```
###3.1、基础查询  
```sql
SELECT * FROM stu;
select sname,gender from stu;
```
###3.2、条件查询  
使用关键字where，运算符和关键字如下：  

 - =、!=、<>、<、<=、>、>=；
 - BETWEEN…AND； 
 - IN(set)；
 - IS NULL； IS NOT NULL
 - AND；
 - 	OR；
 - NOT；    
 
其中between ... and... 等价于>= <=

```sql
select * from stu where gender='female' and age>=50;
select * from stu where age between 25 and 45;
select * from stu where sid in ('s_1001','s_1003','s_1005');
select * from stu where age is null;
```
###3.3、模糊查询  
使用关键字like，通配符：  

 - _表示任意一个字符
 - %表示任意多个字符

```sql
select * from stu where sname like '%c%';
select * from stu where sname like '_h';
```

###3.4、字段控制查询
**去重查询**
使用关键字distinct。

```sql
select distinct gender from stu;
```
**数值类型做四则运算**
增加一列数值以便测试：

```sql
ALTER TABLE stu ADD height DOUBLE;
UPDATE stu SET height=174;
UPDATE stu SET height=NULL WHERE age<20;
```
*注意任何值与NULL相加结果还是NULL，所以要使用ifnull函数。*

```sql
SELECT *,age+height FROM stu;
SELECT *,IFNULL(age,0)+IFNULL(height,0) FROM stu;
```
 **给列名添加别名**  
 使用关键字as，可省略。
 

```sql
SELECT *,IFNULL(age,0)+IFNULL(height,0) AS total FROM stu;
SELECT *,IFNULL(age,0)+IFNULL(height,0) 合计 FROM stu;
```
###3.5、排序
使用关键字order by。

 - asc，默认值，升序
 - desc，降序
 

```sql
UPDATE stu SET age='5' WHERE age IS NULL;
UPDATE stu SET height=178 WHERE height IS NULL;
/*以上对数据进行改造以便测试*/

SELECT * FROM stu ORDER BY age;
SELECT * FROM stu ORDER BY age,height DESC;
```