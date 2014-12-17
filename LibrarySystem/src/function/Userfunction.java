package function;

import java.sql.*;
import java.util.Date;
import java.util.List;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import com.opensymphony.xwork2.ActionSupport;

public class Userfunction extends ActionSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	ArrayList<UserBookDetail> userbookdetails;
	List<UserBookDetail> userbookdetails_temp;
	
	ArrayList<UserDetail> userdetails;
	
	ArrayList<NoteDetail> notedetails;
	List<NoteDetail> notedetails_temp;
	
	private int PageSize = 2;
	private int CurrentPage = 1;
	private int TotalPage;
	private int TotalRow;
	private String PagerMethod = "first";
	
	
	private ResultSet UserResult;
	private ResultSet Result;
	ResultSet Result_temp;
	private String book_tag;
	private String Signal;
	public static String User;
	public static int Page;
	
	private String searchName = "";
	private String searchValue = "";
		
	private String ISBN;
	private String Title;
	private String AuthorName = "";
	private String AuthorCountry;
	private String Publisher;
	
	private String PublishDate;
	private String RegisterDate;
	private String Type;
	private String CallNum;
	private int PageNum;
	private float Price;
	private String Status;
	private String Place;
	private int Love;
	
	private String UserID;
	private String UserName;
	private String UserPassword;
	
	private Date OutTime;
	private Date Expiration;
	private int Num; 
	
	//主页查询书籍信息
	public String execute() throws SQLException
	{	
		String sql;
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		Page = 0;
		
		//查询数据
		if(AuthorName.equals("")&&searchName.equals("")&&searchValue.equals(""))
		{
			book_tag = "新书列表";
			sql = "select * from books order by `RegisterDate` desc limit 10";
		}		
		else
		{
			book_tag = "查询结果";
			sql = "select * from books where "+searchName+" like '%"+searchValue + "%'";
		}
		//刷新书籍列表
		Refresh(sql,connection,statement);
		return "book_query_success";
	}
	
	public String UserLogin() throws SQLException
	{
		String sql;
		String UserPassword_temp = null;
		
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		
		//查询数据
		sql = "select * from users where UserID = '" + UserID + "'";
		// 执行SQL语句并返回结果集
		UserResult = statement.executeQuery(sql);
		
		while(UserResult.next()) 
		{
			// 输出结果	
			UserPassword_temp = UserResult.getString("UserPassword");
		}

		// 关闭结果集
		UserResult.close();
		// 关闭连接
		connection.close();	
		
		if(UserPassword.equals(UserPassword_temp))
		{
			System.out.println("登陆成功！");
			Signal = "ture";
			User = UserID;
			return "login_success";
		}
		else
		{
			System.out.println("用户名或密码错误！");
			Signal = "账号或密码错误，请重新输入";
			return "login_failure";
		}
	}
	public String UserRegist() throws SQLException
	{
		String sql;
		
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		sql = "select * from users where UserID = '"+UserID+"'";
		UserResult = statement.executeQuery(sql);
		if (UserResult.next() == false)
		{
			//查询数据
			sql = "insert into users values ('"+UserID+"','"+UserName+"','"+UserPassword+"')";
			statement.executeUpdate(sql);
			//查询数据
			sql = "CREATE TABLE `note"+UserID+"` (`ISBN` varchar(20) NOT NULL,`Title` varchar(50) DEFAULT NULL,`OutTime` date DEFAULT NULL,`Expiration` date DEFAULT NULL,`Num` int(11) DEFAULT NULL,PRIMARY KEY (`ISBN`)) ENGINE=InnoDB DEFAULT CHARSET=utf8";
			statement.executeUpdate(sql);
			// 关闭结果集
			UserResult.close();
			// 关闭连接
			connection.close();
			System.out.println("注册成功！");
			Signal = "注册成功！";
			return "regist_success";
		}
		else
		{
			// 关闭结果集
			UserResult.close();
			// 关闭连接
			connection.close();	
			System.out.println("用户已存在！");
			Signal = "用户已存在，请重新输入！";
			return "regist_failure";
		}
	}
	
	public String BookReserve() throws SQLException, ParseException
	{
		String sql;
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
		String OutTime_temp;
		String Expiration_temp;
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		sql = "select * from books where ISBN = '"+ISBN+"'";
		Result = statement.executeQuery(sql);
		while(Result.next()) 
		{
			// 输出结果
			Title = Result.getString("Title");
			Status = Result.getString("Status");
		}
		
		if (Status.equals("在馆"))
		{
			OutTime_temp = date.format(new Date());
			Expiration_temp = date.format(new Date(new Date().getTime() + 30 * 24 * 60 * 60 * 1000L));
			Num = 0;
			sql = "insert into note"+User+" values ('"+ISBN+"','"+Title+"','"+OutTime_temp+"','"+Expiration_temp+"','"+Num+"')";
			statement.executeUpdate(sql);
			sql = "update `libdb`.`books` SET `Status`='借出' WHERE `ISBN`='"+ISBN+"'";
			statement.executeUpdate(sql);
			book_tag = "预借成功！";
			if(Page == 0)
				sql = "select * from books order by `RegisterDate` desc limit 10";
			else
				sql = "select * from books order by `Love` desc limit 10";
			//刷新书籍列表
			Refresh(sql,connection,statement);
			return "book_reserve_success";
		}
		else
		{
			System.out.println("书籍已借出！");
			book_tag = "预借失败，书籍已借出！";
			if(Page == 0)
				sql = "select * from books order by `RegisterDate` desc limit 10";
			else
				sql = "select * from books order by `Love` desc limit 10";
			//刷新书籍列表
			Refresh(sql,connection,statement);
			return "book_reserve_failure";
		}
	}
	public String BookLove() throws SQLException
	{
		String sql;
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		
		sql = "select * from books where ISBN = '"+ISBN+"'";
		Result = statement.executeQuery(sql);
		while(Result.next()) 
		{
			// 输出结果
			Love = Result.getInt("Love");
		}
		Love++;
		sql = "update `libdb`.`books` SET `Love`='"+Love+"' WHERE `ISBN`='"+ISBN+"'";
		statement.executeUpdate(sql);
		book_tag = "推荐成功";
		//查询数据
		sql = "select * from note"+User+" order by `OutTime`";
		NoteRefresh(sql,connection,statement);
		
		return "book_Love_success";
	}
	public String BorrowNote() throws SQLException
	{
		String sql;
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		
		//查询数据
		sql = "select * from note"+User+" order by `OutTime`";
		NoteRefresh(sql,connection,statement);
		return "display_borrownote_success";
	}
	
	public String BorrowAgain() throws SQLException
	{
		String sql;
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		
		sql = "select * from note"+User+" where ISBN = '"+ISBN+"'";
		Result = statement.executeQuery(sql);
		while(Result.next()) 
		{
			// 输出结果
			Expiration = Result.getDate("Expiration");
			Num = Result.getInt("Num");
		}
		
		if (Num == 0)
		{
			String Expiration_temp;
			Expiration_temp = date.format(new Date(Expiration.getTime() + 30 * 24 * 60 * 60 * 1000L));
			sql = "update `libdb`.`note"+User+"` SET `Num`='1',`Expiration`='"+Expiration_temp+"' WHERE `ISBN`='"+ISBN+"'";
			statement.executeUpdate(sql);
			book_tag = "续借成功！";
			
			//查询数据
			sql = "select * from note"+User+" order by `OutTime`";
			NoteRefresh(sql,connection,statement);
			return "book_borrowagain_success";
		}
		else
		{
			System.out.println("已到达最大续借次数！");
			book_tag = "续借失败，已到达最大续借次数！";
			//查询数据
			sql = "select * from note"+User+" order by `OutTime`";
			NoteRefresh(sql,connection,statement);
			return "book_borrowagain_failure";
		}
		
	}
	
	public String UserAlter() throws SQLException
	{
		String sql;
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		sql = "update users set UserID = '"+UserID+"',UserName = '"+UserName+"',UserPassword = '"+UserPassword+"' where UserID = '"+UserID+"'";
		statement.executeUpdate(sql);
		UserGetDetail();
		return "UserAlter_success";
	}
	
	public String UserGetDetail() throws SQLException
	{
		String sql;
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		
		//查询数据
		sql = "select * from users where UserID = '"+User+"'";
		// 执行SQL语句并返回结果集
		Result = statement.executeQuery(sql);
		while(Result.next()) {
			// 输出结果	
			UserID = Result.getString("UserID");
			UserName = Result.getString("UserName");
			UserPassword = Result.getString("UserPassword");
		}
		// 关闭结果集
		Result.close();
		// 关闭连接
		connection.close();	
		return "user_GetDetail_success";
	}

	public String GetDetail() throws SQLException
	{
		String sql;
		book_tag = "书籍列表";
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
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
			PublishDate = df.format(Result.getDate("PublishDate"));
			RegisterDate = df.format(Result.getDate("RegisterDate"));
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
	
	public String GoodBook() throws SQLException
	{
		String sql;
		Page = 1;
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
	
	public void NoteRefresh(String sql,Connection connection,Statement statement) throws SQLException
	{
		PageSize = 5;
		notedetails = new ArrayList<NoteDetail>();	
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		// 执行SQL语句并返回结果集
		Result = statement.executeQuery(sql);
		notedetails.clear();
		while(Result.next()) {
			// 输出结果
			NoteDetail notedetail = new NoteDetail();
			
			notedetail.setISBN(Result.getString("ISBN"));
			notedetail.setTitle(Result.getString("Title"));
			notedetail.setOutTime(df.format(Result.getDate("OutTime")));
			notedetail.setExpiration(df.format(Result.getDate("Expiration")));
			notedetail.setNum(Result.getInt("Num"));

			notedetails.add(notedetail);
		}
		TotalRow = notedetails.size();
		TotalPage = TotalRow/PageSize;
		if((TotalRow%PageSize) != 0)
			TotalPage++;
		
		if(PagerMethod.equals("first"))
		{
			CurrentPage = 1;
			if (TotalPage < 2)
				notedetails_temp = notedetails.subList(0,TotalRow);
			else
				notedetails_temp = notedetails.subList((CurrentPage-1)*PageSize, CurrentPage*PageSize);
		}
		else if(PagerMethod.equals("previous"))
		{
			if(CurrentPage > 1)
				CurrentPage--;
			if (TotalPage < 2)
				notedetails_temp = notedetails.subList(0,TotalRow);
			else
				notedetails_temp = notedetails.subList((CurrentPage-1)*PageSize, CurrentPage*PageSize);
		}
		else if(PagerMethod.equals("next"))
		{
			if(CurrentPage < TotalPage)
				CurrentPage++;
			if (TotalPage < 2)
				notedetails_temp = notedetails.subList(0,TotalRow);
			else
			{
				if(CurrentPage == TotalPage)
					notedetails_temp = notedetails.subList((CurrentPage-1)*PageSize, TotalRow);
				else
					notedetails_temp = notedetails.subList((CurrentPage-1)*PageSize, CurrentPage*PageSize);
			}
		}
		else
		{
			CurrentPage = TotalPage;
			if (TotalPage < 2)
				notedetails_temp = notedetails.subList(0,TotalRow);
			else
				notedetails_temp = notedetails.subList((CurrentPage-1)*PageSize, TotalRow);
		}
		// 关闭结果集
		Result.close();
		// 关闭连接
		connection.close();	
	}
	//刷新数据
	public void Refresh(String sql,Connection connection,Statement statement) throws SQLException
	{
		PageSize = 10;
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		userbookdetails = new ArrayList<UserBookDetail>();	
		// 执行SQL语句并返回结果集
		Result = statement.executeQuery(sql);
		userbookdetails.clear();
		while(Result.next()) {
			// 输出结果
			UserBookDetail bookdetail = new UserBookDetail();
			
			bookdetail.setISBN(Result.getString("ISBN"));
			bookdetail.setTitle(Result.getString("Title"));
			bookdetail.setAuthorName(Result.getString("AuthorName"));
			bookdetail.setPublishDate(df.format(Result.getDate("PublishDate")));		
			bookdetail.setType(Result.getString("Type"));
			bookdetail.setStatus(Result.getString("Status"));
			bookdetail.setPlace(Result.getString("Place"));
			bookdetail.setLove(Result.getInt("Love"));
			
			userbookdetails.add(bookdetail);
		}
		TotalRow = userbookdetails.size();
		TotalPage = TotalRow/PageSize;
		if((TotalRow%PageSize) != 0)
			TotalPage++;
		
		if(PagerMethod.equals("first"))
		{
			CurrentPage = 1;
			if (TotalPage < 2)
				userbookdetails_temp = userbookdetails.subList(0,TotalRow);
			else
				userbookdetails_temp = userbookdetails.subList((CurrentPage-1)*PageSize, CurrentPage*PageSize);
		}
		else if(PagerMethod.equals("previous"))
		{
			if(CurrentPage > 1)
				CurrentPage--;
			if (TotalPage < 2)
				userbookdetails_temp = userbookdetails.subList(0,TotalRow);
			else
				userbookdetails_temp = userbookdetails.subList((CurrentPage-1)*PageSize, CurrentPage*PageSize);
		}
		else if(PagerMethod.equals("next"))
		{
			if(CurrentPage < TotalPage)
				CurrentPage++;
			if (TotalPage < 2)
				userbookdetails_temp = userbookdetails.subList(0,TotalRow);
			else
			{
				if(CurrentPage == TotalPage)
					userbookdetails_temp = userbookdetails.subList((CurrentPage-1)*PageSize, TotalRow);
				else
					userbookdetails_temp = userbookdetails.subList((CurrentPage-1)*PageSize, CurrentPage*PageSize);
			}
		}
		else
		{
			CurrentPage = TotalPage;
			if (TotalPage < 2)
				userbookdetails_temp = userbookdetails.subList(0,TotalRow);
			else
				userbookdetails_temp = userbookdetails.subList((CurrentPage-1)*PageSize, TotalRow);
		}	
		// 关闭结果集
		Result.close();
		// 关闭连接
		connection.close();	
	}

	public ArrayList<UserBookDetail> getUserbookdetails() {
		return userbookdetails;
	}

	public void setUserbookdetails(ArrayList<UserBookDetail> userbookdetails) {
		this.userbookdetails = userbookdetails;
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
	

	public int getLove() {
		return Love;
	}

	public void setLove(int love) {
		Love = love;
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
	public ArrayList<UserDetail> getUserdetails() {
		return userdetails;
	}

	public void setUserdetails(ArrayList<UserDetail> userdetails) {
		this.userdetails = userdetails;
	}

	public ResultSet getUserResult() {
		return UserResult;
	}

	public void setUserResult(ResultSet userResult) {
		UserResult = userResult;
	}

	public String getSignal() {
		return Signal;
	}

	public void setSignal(String signal) {
		Signal = signal;
	}

	public static String getUser() {
		return User;
	}

	public static void setUser(String user) {
		User = user;
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
	
	public List<UserBookDetail> getUserbookdetails_temp() {
		return userbookdetails_temp;
	}

	public void setUserbookdetails_temp(List<UserBookDetail> userbookdetails_temp) {
		this.userbookdetails_temp = userbookdetails_temp;
	}


	public List<NoteDetail> getNotedetails_temp() {
		return notedetails_temp;
	}

	public void setNotedetails_temp(List<NoteDetail> notedetails_temp) {
		this.notedetails_temp = notedetails_temp;
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
	
	public String getPublishDate() {
		return PublishDate;
	}

	public void setPublishDate(String publishDate) {
		PublishDate = publishDate;
	}

	public String getRegisterDate() {
		return RegisterDate;
	}

	public void setRegisterDate(String registerDate) {
		RegisterDate = registerDate;
	}


}

class UserBookDetail
{
	private String ISBN;
	private String Title;
	private String AuthorName = "";
	private String AuthorCountry;
	private String Publisher;
	private String PublishDate;
	private String RegisterDate;
	private String Type;
	private String CallNum;
	private int PageNum;
	private float Price;
	private String Status;
	private String Place;
	private int Love;
	
	public String getPublishDate() {
		return PublishDate;
	}
	public void setPublishDate(String publishDate) {
		PublishDate = publishDate;
	}
	public String getRegisterDate() {
		return RegisterDate;
	}
	public void setRegisterDate(String registerDate) {
		RegisterDate = registerDate;
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

	public int getLove() {
		return Love;
	}
	public void setLove(int love) {
		Love = love;
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
	private String OutTime;
	private String Expiration;
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