﻿package function;

import java.sql.*;
import java.util.ArrayList;

import com.opensymphony.xwork2.ActionSupport;

public class Function extends ActionSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	ArrayList<BookDetail> bookdetails;
	private ResultSet Result;
	ResultSet Result_temp;
	private String book_tag;

	private int Book_Total;
	private int Book_Remain;
	
	private String searchName = "";
	private String searchValue = "";
		
	private String ISBN;
	private String Title;
	private String AuthorName = "";
	private String AuthorCountry;
	private String Publisher;
	private Date PublishDate;
	private Date RegisterDate;
	private String Type;
	private String CallNum;
	private int PageNum;
	private float Price;
	private String Status;
	private String Place;
	private int Love;
	
	//主页查询书籍信息
	public String execute() throws SQLException
	{	
		String sql;
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		
		//查询数据
		if(AuthorName.equals("")&&searchName.equals("")&&searchValue.equals(""))
		{
			book_tag = "书籍列表";
			sql = "select * from books";
		}		
		else
		{
			book_tag = "查询结果";
			sql = "select * from books where "+searchName+" like '%"+searchValue + "%'";
		}
		//刷新书籍列表
		Refresh(sql,connection,statement);
		return "book_display_success";
	}
	
	public String Alter_prepare() throws SQLException
	{
		return "book_Alter_prepare";
	}
	
	public String Alter() throws SQLException
	{
		String sql;
		book_tag = "书籍列表";
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		
		//更改数据
		
		sql = "update books set Title = '"+Title+"',AuthorName = '"+AuthorName+"',AuthorCountry = '"+AuthorCountry+"',Publisher = '"+Publisher+"', PublishDate = '"+PublishDate+"', RegisterDate = '"+RegisterDate+"', Type = '"+Type+"',PageNum = '"+PageNum+"',CallNum = '"+CallNum+"',Price = '"+Price+"',Status = '"+Status+"',Place = '"+Place+"', Love = '"+Love+"' where ISBN = '"+ISBN+"'";
		statement.executeUpdate(sql);
		
		sql = "select * from books";
		//刷新书籍列表
		Refresh(sql,connection,statement);
		return "book_Alter_success";
	}
	public String Delete() throws SQLException
	{
		String sql;
		book_tag = "书籍列表";
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		
		//删除数据
		sql = "delete from books where ISBN='"+ISBN+"'";
		statement.executeUpdate(sql);
		
		sql = "select * from books";
		//刷新书籍列表
		Refresh(sql,connection,statement);
		return "book_Delete_success";
	}
	public String Addbook() throws SQLException
	{
		String sql;
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		book_tag = "书籍列表";
		sql = "select * from books where ISBN = '"+ISBN+"'";
		Result = statement.executeQuery(sql);
		if (Result.next() == false)
		{
			sql = "insert into books values ('"+ISBN+"','"+Title+"','"+AuthorName+"','"+AuthorCountry+"','"+Publisher+"','"+PublishDate+"','"+RegisterDate+"','"+Type+"','"+PageNum+"','"+CallNum+"','"+Price+"','"+Status+"','"+Place+"','"+Love+"')";
			statement.executeUpdate(sql);
		}
		else
		{
			System.out.println("书籍已存在");
		}
		
		sql = "select * from books";
		//刷新书籍列表
		Refresh(sql,connection,statement);
		return "book_Add_New_success";
	}
	
	public String GetDetail() throws SQLException
	{
		String sql;
		book_tag = "书籍列表";
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		
		//查询数据
		sql = "select * from books where ISBN = '"+ISBN+"'";
		// 执行SQL语句并返回结果集
		Result = statement.executeQuery(sql);
		while(Result.next()) {
			// 输出结果	
			ISBN = Result.getString("ISBN");
			Title = Result.getString("Title");
			AuthorName = Result.getString("AuthorName");
			AuthorCountry = Result.getString("AuthorCountry");
			Publisher = Result.getString("Publisher");
			PublishDate = Result.getDate("PublishDate");
			RegisterDate = Result.getDate("RegisterDate");
			Type = Result.getString("Type");
			PageNum = Result.getInt("PageNum");
			CallNum = Result.getString("CallNum");
			Price = Result.getFloat("Price");
			Status = Result.getString("Status");
			Place = Result.getString("Place");
			Love = Result.getInt("Love");
		}
		// 关闭结果集
		Result.close();
		// 关闭连接
		connection.close();	
		return "book_GetDetail_success";
	}
	
	public String NewBook() throws SQLException
	{
		String sql;
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		//查询数据
		sql = "select * from books order by `RegisterDate` desc limit 10";
		Refresh(sql,connection,statement);
		return "NewBook_success";
	}
	
	public String GoodBook() throws SQLException
	{
		String sql;
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		//查询数据
		sql = "select * from books order by `Love` desc limit 10";
		Refresh(sql,connection,statement);
		return "GoodBook_success";
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
	//刷新数据
	public void Refresh(String sql,Connection connection,Statement statement) throws SQLException
	{
		bookdetails = new ArrayList<BookDetail>();	
		
		Result = statement.executeQuery("SELECT COUNT(*) FROM books");
		while(Result.next())
		{
			Book_Total =  Result.getInt("COUNT(*)");
		}
		Result = statement.executeQuery("SELECT COUNT(*) FROM books where Status = '在馆'");
		while(Result.next())
		{
			Book_Remain =  Result.getInt("COUNT(*)");
		}
		
		// 执行SQL语句并返回结果集
		Result = statement.executeQuery(sql);
		bookdetails.clear();
		while(Result.next()) {
			// 输出结果
			BookDetail bookdetail = new BookDetail();
			
			bookdetail.setISBN(Result.getString("ISBN"));
			bookdetail.setTitle(Result.getString("Title"));
			bookdetail.setAuthorName(Result.getString("AuthorName"));
			bookdetail.setAuthorCountry(Result.getString("AuthorCountry"));
			bookdetail.setPublisher(Result.getString("Publisher"));
			bookdetail.setPublishDate(Result.getDate("PublishDate"));
			bookdetail.setRegisterDate(Result.getDate("RegisterDate"));
			bookdetail.setType(Result.getString("Type"));
			bookdetail.setPageNum(Result.getInt("PageNum"));
			bookdetail.setCallNum(Result.getString("CallNum"));
			bookdetail.setPrice(Result.getFloat("Price"));
			bookdetail.setStatus(Result.getString("Status"));
			bookdetail.setPlace(Result.getString("Place"));
			bookdetail.setLove(Result.getInt("Love"));
			
			bookdetails.add(bookdetail);
		}
		// 关闭结果集
		Result.close();
		// 关闭连接
		connection.close();	
	}

	public ArrayList<BookDetail> getBookdetails() {
		return bookdetails;
	}

	public void setBookdetails(ArrayList<BookDetail> bookdetails) {
		this.bookdetails = bookdetails;
	}

	public ResultSet getResult() {
		return Result;
	}

	public void setResult(ResultSet result) {
		Result = result;
	}
	
	public ResultSet getResult_temp() {
		return Result_temp;
	}

	public void setResult_temp(ResultSet result_temp) {
		Result_temp = result_temp;
	}
	
	public String getBook_tag() {
		return book_tag;
	}

	public void setBook_tag(String book_tag) {
		this.book_tag = book_tag;
	}
	
	public int getBook_Total() {
		return Book_Total;
	}

	public void setBook_Total(int book_Total) {
		Book_Total = book_Total;
	}

	public int getBook_Remain() {
		return Book_Remain;
	}

	public void setBook_Remain(int book_Remain) {
		Book_Remain = book_Remain;
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

	public String getAuthorName() {
		return AuthorName;
	}

	public void setAuthorName(String authorName) {
		AuthorName = authorName;
	}

	public String getAuthorCountry() {
		return AuthorCountry;
	}

	public void setAuthorCountry(String authorCountry) {
		AuthorCountry = authorCountry;
	}

	public String getPublisher() {
		return Publisher;
	}

	public void setPublisher(String publisher) {
		Publisher = publisher;
	}

	public Date getPublishDate() {
		return PublishDate;
	}

	public void setPublishDate(Date publishDate) {
		PublishDate = publishDate;
	}

	public String getType() {
		return Type;
	}

	public void setType(String type) {
		Type = type;
	}

	public String getCallNum() {
		return CallNum;
	}

	public void setCallNum(String callNum) {
		CallNum = callNum;
	}

	public int getPageNum() {
		return PageNum;
	}

	public void setPageNum(int pageNum) {
		PageNum = pageNum;
	}

	public float getPrice() {
		return Price;
	}

	public void setPrice(float price) {
		Price = price;
	}

	public String getStatus() {
		return Status;
	}

	public void setStatus(String status) {
		Status = status;
	}

	public String getPlace() {
		return Place;
	}

	public void setPlace(String place) {
		Place = place;
	}
	
	public Date getRegisterDate() {
		return RegisterDate;
	}

	public void setRegisterDate(Date registerDate) {
		RegisterDate = registerDate;
	}

	public int getLove() {
		return Love;
	}

	public void setLove(int love) {
		Love = love;
	}

}

class BookDetail
{
	private String ISBN;
	private String Title;
	private String AuthorName = "";
	private String AuthorCountry;
	private String Publisher;
	private Date PublishDate;
	private Date RegisterDate;
	private String Type;
	private String CallNum;
	private int PageNum;
	private float Price;
	private String Status;
	private String Place;
	private int Love;
	
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
	public String getAuthorName() {
		return AuthorName;
	}
	public void setAuthorName(String authorName) {
		AuthorName = authorName;
	}
	public String getAuthorCountry() {
		return AuthorCountry;
	}
	public void setAuthorCountry(String authorCountry) {
		AuthorCountry = authorCountry;
	}
	public String getPublisher() {
		return Publisher;
	}
	public void setPublisher(String publisher) {
		Publisher = publisher;
	}
	public Date getPublishDate() {
		return PublishDate;
	}
	public void setPublishDate(Date publishDate) {
		PublishDate = publishDate;
	}
	public String getType() {
		return Type;
	}
	public void setType(String type) {
		Type = type;
	}
	public String getCallNum() {
		return CallNum;
	}
	public void setCallNum(String callNum) {
		CallNum = callNum;
	}
	public int getPageNum() {
		return PageNum;
	}
	public void setPageNum(int pageNum) {
		PageNum = pageNum;
	}
	public float getPrice() {
		return Price;
	}
	public void setPrice(float price) {
		Price = price;
	}
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}
	public String getPlace() {
		return Place;
	}
	public void setPlace(String place) {
		Place = place;
	}
	public Date getRegisterDate() {
		return RegisterDate;
	}
	public void setRegisterDate(Date registerDate) {
		RegisterDate = registerDate;
	}
	public int getLove() {
		return Love;
	}
	public void setLove(int love) {
		Love = love;
	}

}