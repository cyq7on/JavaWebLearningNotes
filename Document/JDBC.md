#һ������
JDBC��java database connectivity��SUN��˾�ṩ��һ�ײ������ݿ�ı�׼�淶��  
JDBC�����ݿ������Ĺ�ϵ���ӿ���ʵ�ֵĹ�ϵ�����ݿ����������ݿ⳧���ṩ��һ������������jar�ļ����ɡ�
JDBC�淶��

 - DriverManager������ע������
 - Connection����ʾ�����ݿⴴ��������
 - Statement:���������ݿ�sql���Ķ���
 - ResultSet���������һ�������
 
#����JDBC����ʵ��

 - ע������
 - ��������
 - �õ�ִ��sql����Statement����
 - ִ��sql��䣬�����ؽ��
 - ������
 - �ر���Դ
 
 ���Ĵ�����try�������棬���٣����඼�Ǵ����쳣�͹ر���Դ�ġ�
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
#����JDBC������ͽӿ�
##1��java.sql.DriverManager��
###1.1��ע������

```
DriverManager.registerDriver(new Driver());
```
��ʵ������ʽ�ǲ�����ʹ�õģ�ԭ�����£�

 - �����ᱻע������
 - ǿ���������ݿ�������jar�ļ�������Ը�
 
��ԭ��һ��һ��˵����  

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
��������������com.mysql.jdbc.Driver���ɼ�������Ҳע����һ�Ρ�
�Ƽ��÷���  

```
Class.forName("com.mysql.jdbc.Driver");
```
###1.2�������ݿ⽨������
�����ַ�ʽ�����÷�ʽһ��

```
DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "root");
Properties info = new Properties();
info.setProperty("user", "root");
info.setProperty("password","root");
DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb",info);
DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?user=root&password=root");
```
���е�һ������Ϊurl����sun��˾�����ݿ⳧��֮���Э�飺  
jdbc:mysql://localhost:3306/mydb  
Э�� ��Э��  IP :�˿ں� ���ݿ�  
Ĭ�����ӱ�����jdbc:mysql:///mydb  
##2��java.sql.Connection�ӿ�
���ã�����ִ��sql���Ķ���  

```
Statement statement = connection.createStatement();
```
##3��java.sql.Statement�ӿ�
���ã�ִ��sql��䲢���ؽ����  

 - ResultSet  executeQuery(String sql) ���ݲ�ѯ��䷵�ؽ������ֻ��ִ��select���
 - int executeUpdate(String sql) ����ִ�е�DML��insert update delete����䣬������Ӱ�������
 - boolean execute(String sql)  �˷�������ִ������sql��䣬����booleanֵ����ʾ�Ƿ񷵻�ResultSet�����������ִ��select��䣬���з��ؽ��ʱ����true, ������䶼����false�����Կ���������ֵ��ֵ������˺���ʹ��
 
�ṩһ���α꣬Ĭ���α�ָ��������һ��֮ǰ��  
����һ��next()���α������ƶ�һ�С�  
�ṩһЩget������  

��װ���ݵķ�����  

```
/*�������ȡֵ��������1��ʼ*/
Object getObject(int columnIndex); 
/*��������ȡֵ*/
Object getObject(String ColomnName);
```
���Ǿ���ʹ�õ���getĳ�־������͵ķ��������磺

```
getInt(int colIndex)
getInt(String colLabel)
```
Java���������������ݿ��е����͵Ĺ�ϵ��

| Java| ���ݿ�
| :-------------|:-------------
| byte   | tityint
| short  | smallint
| int    | int  
| long   | bigint  
| double    | double  
| String    | char,varchar  
| Date    | date  
#�ġ�sqlע��
sqlע����ָͨ�������������䣬��Ӧ��������������Ҫִ�е�sql��䡣  
����һ����¼��sql���������£�

```
select * from user where name='root' and password='root'
```
name��password�����û�����ģ�������������ע�뷽ʽ��

 - ֪�����ڵ��û�����name����`root' --`�������Ͱ�֮���������������
 - �û����������룬password����`anything' OR 'x'='x`������������Զ����
 
 ���������
 ����Statement����Ϊ������PreparedStatement����һ���棬��Ч��Ҳ���ߡ�  
 ���Ĵ��룺
```
Class.forName("com.mysql.jdbc.Driver");
connection = DriverManager.getConnection(url, "root", "amm");
statement = connection.prepareStatement(sql);
statement.setString(1, "���ӻ�");
resultSet = statement.executeQuery();
```
��Ȼ�����ڷ�ֹsqlע��ԶԶ��ֹ����һ������ô��һ�������������ש��������