package user_manage;


import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.opensymphony.xwork2.ActionSupport;

public class Users extends ActionSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	ArrayList<UserDetail> userdetails;
	List<UserDetail> userdetails_temp;
	ArrayList<NoteDetail> notedetails;
	
	private int PageSize = 7;
	private int CurrentPage = 1;
	private int TotalPage;
	private int TotalRow;
	private String PagerMethod = "first";
	
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
		
		sql = "select * from users";
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
		
//		sql = "drop table note"+UserID;
//		statement.executeUpdate(sql);
		
		sql = "select * from users";
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
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
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
		sql = "select * from note where UserID = '"+UserID+"' order by `OutTime`";
		notedetails = new ArrayList<NoteDetail>();	
		// 执行SQL语句并返回结果集
		Result = statement.executeQuery(sql);
		notedetails.clear();
		while(Result.next()) {
			// 输出结果
			NoteDetail notedetail = new NoteDetail();
			
			notedetail.setISBN(Result.getString("ISBN"));
			notedetail.setUserID(Result.getString("UserID"));
			notedetail.setTitle(Result.getString("Title"));
			notedetail.setOutTime(df.format(Result.getDate("OutTime")));
			notedetail.setExpiration(df.format(Result.getDate("Expiration")));
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
		TotalRow = userdetails.size();
		User_Total = TotalRow;
		TotalPage = TotalRow/PageSize;
		if((TotalRow%PageSize) != 0)
			TotalPage++;
		
		if(PagerMethod.equals("first"))
		{
			CurrentPage = 1;
			if (TotalPage < 2)
				userdetails_temp = userdetails.subList(0,TotalRow);
			else
				userdetails_temp = userdetails.subList((CurrentPage-1)*PageSize, CurrentPage*PageSize);
		}
		else if(PagerMethod.equals("previous"))
		{
			if(CurrentPage > 1)
				CurrentPage--;
			if (TotalPage < 2)
				userdetails_temp = userdetails.subList(0,TotalRow);
			else
				userdetails_temp = userdetails.subList((CurrentPage-1)*PageSize, CurrentPage*PageSize);
		}
		else if(PagerMethod.equals("next"))
		{
			if(CurrentPage < TotalPage)
				CurrentPage++;
			if (TotalPage < 2)
				userdetails_temp = userdetails.subList(0,TotalRow);
			else
			{
				if(CurrentPage == TotalPage)
					userdetails_temp = userdetails.subList((CurrentPage-1)*PageSize, TotalRow);
				else
					userdetails_temp = userdetails.subList((CurrentPage-1)*PageSize, CurrentPage*PageSize);
			}
		}
		else
		{
			CurrentPage = TotalPage;
			if (TotalPage < 2)
				userdetails_temp = userdetails.subList(0,TotalRow);
			else
				userdetails_temp = userdetails.subList((CurrentPage-1)*PageSize, TotalRow);
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
		sql = "update `bookdb`.`books` SET `Status`='在馆' WHERE `ISBN`='"+ISBN+"'";
		statement.executeUpdate(sql);
		
		sql = "delete from note where ISBN='"+ISBN+"'";
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
			String url = "jdbc:mysql://localhost:3306/bookdb?characterEncoding=utf8";	
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
	
	public List<UserDetail> getUserdetails_temp() {
		return userdetails_temp;
	}

	public void setUserdetails_temp(List<UserDetail> userdetails_temp) {
		this.userdetails_temp = userdetails_temp;
	}

	public int getPageSize() {
		return PageSize;
	}

	public void setPageSize(int pageSize) {
		PageSize = pageSize;
	}

	public int getCurrentPage() {
		return CurrentPage;
	}

	public void setCurrentPage(int currentPage) {
		CurrentPage = currentPage;
	}

	public int getTotalPage() {
		return TotalPage;
	}

	public void setTotalPage(int totalPage) {
		TotalPage = totalPage;
	}

	public int getTotalRow() {
		return TotalRow;
	}

	public void setTotalRow(int totalRow) {
		TotalRow = totalRow;
	}

	public String getPagerMethod() {
		return PagerMethod;
	}

	public void setPagerMethod(String pagerMethod) {
		PagerMethod = pagerMethod;
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
	private String UserID;
	private String Title;
	private String OutTime;
	private String Expiration;
	private int Num; 
	public String getISBN() {
		return ISBN;
	}
	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
	public String getUserID() {
		return UserID;
	}
	public void setUserID(String userID) {
		UserID = userID;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public String getOutTime() {
		return OutTime;
	}
	public void setOutTime(String outTime) {
		OutTime = outTime;
	}
	public String getExpiration() {
		return Expiration;
	}
	public void setExpiration(String expiration) {
		Expiration = expiration;
	}

	public int getNum() {
		return Num;
	}
	public void setNum(int num) {
		Num = num;
	}
}