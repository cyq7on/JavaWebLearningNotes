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
###3.6、聚合函数
聚合函数是用来做纵向运算的函数：

 - COUNT()：统计指定列不为NULL的记录行数
 - MAX()：计算指定列的最大值，如果指定列是字符串类型，那么使用字符串排序运算
 - MIN()：计算指定列的最小值，如果指定列是字符串类型，那么使用字符串排序运算；
 - SUM()：计算指定列的数值和，如果指定列类型不是数值类型，那么计算结果为0；
 - AVG()：计算指定列的平均值，如果指定列类型不是数值类型，那么计算结果为0；

```sql
select count(*) from stu;
/*查询有年龄的，即age不为null*/
select count(age) from stu;
select count(*) from stu where age>50;
select count(*) from stu where ifnull(age,0)+ifnull(height,0)>250;
select sum(height),sum(age),sum(gender),avg(age) from stu;
select max(age),min(height) from stu;
```
###3.7、分组查询
使用关键字group by  

```sql
select gender,avg(age) from stu group by gender;
select gender,avg(age) from stu where gender is not null group by gender;
select gender,avg(age) from stu where gender is not null group by gender having avg(age)>50;
```
**having与where的区别:**

 - having是在分组后对数据进行过滤，where是在分组前对数据进行过滤
 - having后面可以使用聚合函数(统计函数)，where后面不可以使用聚合函数
 - where是对分组前记录的条件，如果某行记录没有满足where子句的条件，那么这行记录不会参加分组；而having是对分组后数据的约束  
###3.8、limit

```sql
/*查询m行记录，起始行从n开始*/
select * from stu limit n,m;
```

 - 查询语句书写顺序：select – from- where- group by- having- order by-limit
 - 查询语句执行顺序：from - where -group by - having - select - order by-limit	
	
#三、数据完整性
##1、实体完整性
实体：表中的一行，或者说一条记录。  
作用：标识每一行数据不重复。
约束类型：

 - 主键约束（primary key）
 - 唯一约束（unique）
 - 自动增长列（auto_increment）
   
###1.1、主键约束
每个表中都要有一个主键，数据唯一，不能为null。  
添加方式如下：  

```sql
create table student(
id int primary key,
name varchar(50)
);
/*此方式可以创立联合主键*/
create table student(
id int,
name varchar(50),
primary key(id)
);
create table student(
stuid int,
classid int,
name varchar(50),
primary key(stuid,classid)
);
create table student(
id int,
name varchar(50)
);
alter table student add primary key(id);
alter table student add constraint pk_stu_id primary key(id);
/*删除主键约束*/
alter table student drop primary key;
```
###1.2、唯一约束
特点：数据不能重复。  

```sql
create table student(
id int primary key,
name varchar(50),
tag varchar(50) unique
);
```
###1.3、自动增长列
并不是只能用于主键，但该列只能是整数类型  
其他数据库关键字：

 - sqlserver：identity
 - oracle：sequence
 

```sql
create table student (
id int primary key auto_increment,
name varchar(50)
)
insert into student(name) values('Jay');
```
##2、域完整性
作用：限制此单元格的数据正确，域代表当前单元格。  
域完整性约束：

 - 数据类型约束
 - 非空约束（not null）
 - 默认值约束（default）
 - check约束，check（sex='男' or sex='女'），MySQL不支持
 

```sql
create table student(
id int primary key,
name varchar(50) not null,
sex varchar(10) default '女'
);
insert into student values(1,'张小凡','男');
insert into student values(2,'碧瑶',default);
insert into student(id,name) values(3,'陆师姐');
```
##3、引用完整性
外键约束：foreign key  
```sql
create table student(
id int primary key,
name varchar(50) not null,
sex varchar(10) default '女'
);
create table score(
scoreid int,
score double,
stuid int,
constraint fk_student_score_stuid foreign key(stuid) references student(id)
);
/*另一种方式*/
alter table score add constraint fk_student_score_stuid foreign key(stuid) references student(id);
/*删除外键约束*/
alter table score drop foreign key fk_student_score_stuid;
```
##4、表与表之间的关系

 - 一对一，比如人和身份证
 - 一对多（多对一），比如学生和考试
 - 多对多，比如老师和学生
 
 ![关系](http://img.blog.csdn.net/20161128160253420)
#四、多表查询
种类：

 - 合并结果集：union、union all
 - 连接查询
 - 内连接：[inner] join on
    -  外连接：outer join on
          - 左外连接：left [outer] join
          - 右外连接：right [outer] join
          - 全连接：full join（MySQL不支持）
 - 子查询 
##1、合并结果集
作用：把两个select语句的查询结果合并到一起。  
方式：

 - union：去除重复记录
 - union all：不去除重复记录
 
要求：被合并的两个结果，列数、列类型必须相同。
```sql
select * from t1 union select * from t2;
select * from t1 union all select * from t2;
```
![union](http://img.blog.csdn.net/20161128162108100)
![union all](http://img.blog.csdn.net/20161128162050735)
##2、连接查询
连接查询就是求出多个表的乘积，例如t1连接t2，那么查询出的结果就是t1*t2。
![连接查询](http://img.blog.csdn.net/20161128162521299)
显然，一般情况下这都不是我们想要的结果，所以，要使用主外键关系来去除无用信息。  

```sql
drop table score;
CREATE TABLE score(
scoreid INT,
scorename varchar(50),
score DOUBLE,
stuid INT,
CONSTRAINT fk_student_score_stuid FOREIGN KEY(stuid) REFERENCES student(id)
)
insert into score values(1,'java',99,1),
                        (2,'java',90,2),
                        (3,'java',92,3),
                        (4,'mysql',95,1);
SELECT * FROM student,score;
SELECT * FROM student stu,score sco WHERE stu.id=sco.stuid;
```
###2.1、内连接
上述的语句就是内连接，但不是sql中标准的查询方式，标准的内连接如下：

```sql
select * from student stu join score sco on stu.id=sco.stuid; 
```
再向student表中插入一条数据：

```sql
insert into student values(4,'花千骨',default);
```
但是score表里没有花千骨的记录，也就是说她缺考了，此时使用内连接就只能查出参加了考试的学生。想要查出所有学生，那么就得使用外连接。  
###2.2、外连接
特点：查询出的结果存在不满足条件的情况。  

 - 左连接：先查询出左表（即以左表为主），然后查询右表，右表中满足条件的显示出来，不满足条件的显示NULL
 - 右连接：先把右表中所有记录都查询出来，然后左表满足条件的显示，不满足显示NULL

```sql
select * from student stu left join score sco on stu.id=sco.stuid;
```
![左连接](http://img.blog.csdn.net/20161128165710412)
```sql
select * from student stu right join score sco on stu.id=sco.stuid;
```
![右连接](http://img.blog.csdn.net/20161128165730366)