#一、概述
JDBC：java database connectivity，SUN公司提供的一套操作数据库的标准规范。  
JDBC与数据库驱动的关系：接口与实现的关系。数据库驱动由数据库厂商提供，一般我们引用其jar文件即可。
JDBC规范：

 - DriverManager，用于注册驱动
 - Connection，表示与数据库创建的连接
 - Statement:，操作数据库sql语句的对象
 - ResultSet，结果集或一张虚拟表
 
#二、JDBC程序实现

 - 注册驱动
 - 创建连接
 - 得到执行sql语句的Statement对象
 - 执行sql语句，并返回结果
 - 处理结果
 - 关闭资源
 
 核心代码在try语句块里面，很少，其余都是处理异常和关闭资源的。
```
		String url = "jdbc:mysql://localhost:3306/mydb";
		String sql = "SELECT * FROM student";
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
		try {
			DriverManager.registerDriver(new Driver());
			connection = DriverManager.getConnection(url, "root", "root");
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				System.out.println(resultSet.getInt("stuid"));
				System.out.println(resultSet.getString("name"));
				System.out.println(resultSet.getString("sex"));
				System.out.println("-------------------------");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (resultSet != null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
```
#三、JDBC常用类和接口
##1、java.sql.DriverManager类
###1.1、注册驱动

```
DriverManager.registerDriver(new Driver());
```
其实上述方式是不建议使用的，原因如下：

 - 驱动会被注册两次
 - 强烈依赖数据库驱动的jar文件，耦合性高
 
对原因一做一下说明：  

```
	// Register ourselves with the DriverManager
	static {
		try {
			java.sql.DriverManager.registerDriver(new Driver());
		} catch (SQLException E) {
			throw new RuntimeException("Can't register driver!");
		}
	}
```
上述代码来自于com.mysql.jdbc.Driver，可见其自身也注册了一次。
推荐用法：  

```
Class.forName("com.mysql.jdbc.Driver");
```
###1.2、与数据库建立连接
有三种方式，常用方式一：

```
DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root");
Properties info = new Properties();
info.setProperty("user", "root");
info.setProperty("password","root");
DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb",info);
DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?user=root&password=root");
```
其中第一个参数为url，是sun公司与数据库厂商之间的协议：  
jdbc:mysql://localhost:3306/mydb  
协议 子协议  IP :端口号 数据库  
默认连接本机：jdbc:mysql:///mydb  
##2、java.sql.Connection接口
作用：创建执行sql语句的对象：  

```
Statement statement = connection.createStatement();
```
##3、java.sql.Statement接口
作用：执行sql语句并返回结果：  

 - ResultSet  executeQuery(String sql) 根据查询语句返回结果集，只能执行select语句
 - int executeUpdate(String sql) 根据执行的DML（insert update delete）语句，返回受影响的行数
 - boolean execute(String sql)  此方法可以执行任意sql语句，返回boolean值，表示是否返回ResultSet结果集，仅当执行select语句，且有返回结果时返回true, 其它语句都返回false，可以看出，返回值价值不大，因此很少使用
 
提供一个游标，默认游标指向结果集第一行之前。  
调用一次next()，游标向下移动一行。  
提供一些get方法。  

封装数据的方法：  

```
/*根据序号取值，索引从1开始*/
Object getObject(int columnIndex); 
/*根据列名取值*/
Object getObject(String ColomnName);
```
我们经常使用的是get某种具体类型的方法，比如：

```
getInt(int colIndex)
getInt(String colLabel)
```
Java的数据类型与数据库中的类型的关系：

| Java| 数据库
| :-------------|:-------------
| byte   | tityint
| short  | smallint
| int    | int  
| long   | bigint  
| double    | double  
| String    | char,varchar  
| Date    | date  
#四、sql注入
sql注入是指通过特殊的输入语句，让应用运行输入者想要执行的sql语句。  
比如一个登录的sql，可能如下：

```
select * from user where name='root' and password='root'
```
name和password都是用户输入的，常见的有如下注入方式：

 - 知道存在的用户名，name输入`root' --`，这样就把之后的条件都屏蔽了
 - 用户名随意输入，password输入`anything' OR 'x'='x`，这样条件永远成立
 
 解决方法：
 弃用Statement，改为其子类PreparedStatement，另一方面，其效率也更高。  
 核心代码：
```
Class.forName("com.mysql.jdbc.Driver");
connection = DriverManager.getConnection(url, "root", "amm");
statement = connection.prepareStatement(sql);
statement.setString(1, "白子画");
resultSet = statement.executeQuery();
```
当然，关于防止sql注入远远不止更换一个类这么单一，这里仅仅是抛砖引玉啦。