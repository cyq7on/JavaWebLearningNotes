#一、sql概述
sql：Structure Query Language，结构化查询语言
#二、sql分类
##1、DDL
DDL，即Data Definition Language，数据定义语言，用来定义数据库对象：库、表和列等。  
使用的关键字：CREATE,ALTER,DROP
###操作数据库：
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
###操作数据表：
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
##3、DQL  

DQL，即Data Query Language，数据操作语言，用来查询记录（数据）。
