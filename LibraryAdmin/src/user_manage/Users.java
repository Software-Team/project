package user_manage;


import java.sql.*;
import java.util.ArrayList;
import java.util.Date;

import com.opensymphony.xwork2.ActionSupport;

public class Users extends ActionSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	ArrayList<UserDetail> userdetails;
	ArrayList<NoteDetail> notedetails;
	private ResultSet Result;
	private String user_tag;
	private int User_Total;

	private String searchName = "";
	private String searchValue = "";
	
	private String ISBN;
	
	private String UserID;
	private String UserName = "";
	private String UserPassword;
	
	//主页查询书籍信息
	public String execute() throws SQLException
	{	
		String sql;
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		
		//查询数据
		if(UserName.equals("")&&searchName.equals("")&&searchValue.equals(""))
		{
			user_tag = "用户列表";
			sql = "select * from users";
		}
			
		else
		{
			user_tag = "查询结果";
			sql = "select * from users where "+searchName+" = '"+searchValue + "'";
		}
		
		Refresh(sql,connection,statement);
		return "user_display_success";
	}
	
	public String Alter_prepare() throws SQLException
	{
		return "user_Alter_prepare";
	}
	
	public String Alter() throws SQLException
	{
		String sql;
		user_tag = "用户列表";
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		
		//查询数据
		
		sql = "update users set UserID = '"+UserID+"',UserName = '"+UserName+"',UserPassword = '"+UserPassword+"' where UserID = '"+UserID+"'";
		statement.executeUpdate(sql);
		
		sql = "select * from Users";
		// 执行SQL语句并返回结果集
		Refresh(sql,connection,statement);
		return "user_Alter_success";
	}
	public String Delete() throws SQLException
	{
		String sql;
		user_tag = "用户列表";
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		
		//查询数据
		sql = "delete from users where UserID='"+UserID+"'";
		statement.executeUpdate(sql);
		
		sql = "drop table note"+UserID;
		statement.executeUpdate(sql);
		
		sql = "select * from Users";
		// 执行SQL语句并返回结果集
		Refresh(sql,connection,statement);
		return "user_Delete_success";
	}
	public String Addbook() throws SQLException
	{
		String sql;
		user_tag = "用户列表";
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		
		sql = "select * from users where UserID = '"+UserID+"'";
		Result = statement.executeQuery(sql);
		if (Result.next() == false)
		{
			sql = "insert into users values ('"+UserID+"','"+UserName+"','"+UserPassword+"')";
			statement.executeUpdate(sql);
			//查询数据
			sql = "CREATE TABLE `note"+UserID+"` (`ISBN` varchar(20) NOT NULL,`Title` varchar(50) DEFAULT NULL,`OutTime` date DEFAULT NULL,`Expiration` date DEFAULT NULL,`Num` int(11) DEFAULT NULL,PRIMARY KEY (`ISBN`)) ENGINE=InnoDB DEFAULT CHARSET=utf8";
			statement.executeUpdate(sql);
		}
		else
		{
			System.out.println("用户已存在！");
		}
		
		
		sql = "select * from users";
		// 执行SQL语句并返回结果集
		Refresh(sql,connection,statement);
		return "user_Add_New_success";
	}

	public String GetDetail() throws SQLException
	{
		String sql;
		user_tag = "用户列表";
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		
		//查询数据
		sql = "select * from users where UserID = '"+UserID+"'";
		// 执行SQL语句并返回结果集
		Result = statement.executeQuery(sql);
		while(Result.next()) {
			// 输出结果	
			UserID = Result.getString("UserID");
			UserName = Result.getString("UserName");
			UserPassword = Result.getString("UserPassword");
		}
		//查询数据
		sql = "select * from note"+UserID+" order by `OutTime`";
		notedetails = new ArrayList<NoteDetail>();	
		// 执行SQL语句并返回结果集
		Result = statement.executeQuery(sql);
		notedetails.clear();
		while(Result.next()) {
			// 输出结果
			NoteDetail notedetail = new NoteDetail();
			
			notedetail.setISBN(Result.getString("ISBN"));
			notedetail.setTitle(Result.getString("Title"));
			notedetail.setOutTime(Result.getDate("OutTime"));
			notedetail.setExpiration(Result.getDate("Expiration"));
			notedetail.setNum(Result.getInt("Num"));

			notedetails.add(notedetail);
		}
		// 关闭结果集
		Result.close();
		// 关闭连接
		connection.close();	
		return "user_GetDetail_success";
	}
	
	public void Refresh(String sql,Connection connection,Statement statement) throws SQLException
	{
		userdetails = new ArrayList<UserDetail>();
		Result = statement.executeQuery("SELECT COUNT(*) FROM users");
		while(Result.next())
		{
			User_Total =  Result.getInt("COUNT(*)");
		}
		// 执行SQL语句并返回结果集
		Result = statement.executeQuery(sql);
		userdetails.clear();
		while(Result.next()) {
			// 输出结果
			UserDetail userdetail = new UserDetail();
			
			userdetail.setUserID(Result.getString("UserID"));
			userdetail.setUserName(Result.getString("UserName"));
			userdetail.setUserPassword(Result.getString("UserPassword"));
			
			userdetails.add(userdetail);
		}
		// 关闭结果集
		Result.close();
		// 关闭连接
		connection.close();	
	}
	
	public String ReturnBook() throws SQLException
	{
		String sql;
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		sql = "update `libdb`.`books` SET `Status`='在馆' WHERE `ISBN`='"+ISBN+"'";
		statement.executeUpdate(sql);
		
		sql = "delete from note"+UserID+" where ISBN='"+ISBN+"'";
		statement.executeUpdate(sql);
		GetDetail();
		return "return_success";
	}
	
	public Connection Connect()
	{
		Connection connection = null;
		try {
			// 加载驱动程序
			Class.forName("com.mysql.jdbc.Driver");
			// URL指向要访问的数据库名test
			String url = "jdbc:mysql://localhost:3306/libdb";	
			// MySQL配置时的用户名
			String user = "root";
			// MySQL配置时的密码
			String password = "5179";
			// 连续数据库
			connection = DriverManager.getConnection(url, user, password);
			if(!connection.isClosed())
				System.out.println("Succeeded connecting to the Database!");
			return connection;
		
		} catch(ClassNotFoundException e) {
			System.out.println("Sorry,can`t find the Driver!");
			System.out.println(e);
			e.printStackTrace();
			return connection;
		} catch(SQLException e) {
			System.out.println("Sorry,can`t find the Driver!");
			e.printStackTrace();
			return connection;
		} catch(Exception e) {
			System.out.println("Sorry,can`t find the Driver!");
			e.printStackTrace();
			return connection;
		}
	}

	public ArrayList<UserDetail> getUserdetails() {
		return userdetails;
	}

	public void setUserdetails(ArrayList<UserDetail> userdetails) {
		this.userdetails = userdetails;
	}
	
	public ArrayList<NoteDetail> getNotedetails() {
		return notedetails;
	}

	public void setNotedetails(ArrayList<NoteDetail> notedetails) {
		this.notedetails = notedetails;
	}

	public ResultSet getResult() {
		return Result;
	}

	public void setResult(ResultSet result) {
		Result = result;
	}
	
	public String getUser_tag() {
		return user_tag;
	}

	public void setUser_tag(String user_tag) {
		this.user_tag = user_tag;
	}
	
	public int getUser_Total() {
		return User_Total;
	}

	public void setUser_Total(int user_Total) {
		User_Total = user_Total;
	}

	public String getSearchName() {
		return searchName;
	}

	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	
	public String getUserID() {
		return UserID;
	}

	public void setUserID(String userID) {
		UserID = userID;
	}

	public String getUserName() {
		return UserName;
	}

	public void setUserName(String userName) {
		UserName = userName;
	}

	public String getUserPassword() {
		return UserPassword;
	}

	public void setUserPassword(String userPassword) {
		UserPassword = userPassword;
	}
	
	public String getISBN() {
		return ISBN;
	}

	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
}
class UserDetail
{
	private String UserID;
	private String UserName;
	private String UserPassword;
	
	public String getUserID() {
		return UserID;
	}
	public void setUserID(String userID) {
		UserID = userID;
	}
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String userName) {
		UserName = userName;
	}
	public String getUserPassword() {
		return UserPassword;
	}
	public void setUserPassword(String userPassword) {
		UserPassword = userPassword;
	}
}	
class NoteDetail
{
	private String ISBN;
	private String Title;
	private Date OutTime;
	private Date Expiration;
	private int Num; 
	public String getISBN() {
		return ISBN;
	}
	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public Date getOutTime() {
		return OutTime;
	}
	public void setOutTime(Date outTime) {
		OutTime = outTime;
	}
	public Date getExpiration() {
		return Expiration;
	}
	public void setExpiration(Date expiration) {
		Expiration = expiration;
	}
	public int getNum() {
		return Num;
	}
	public void setNum(int num) {
		Num = num;
	}
}