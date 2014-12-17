package login;

import java.sql.*;
import com.opensymphony.xwork2.ActionSupport;

public class Login extends ActionSupport
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String Signal;
	private String AdminID;
	private String AdminPassword;
	
	private ResultSet AdminResult;
	
	public String execute() throws SQLException
	{
		String sql;
		String AdminPassword_temp = null;
		
		Connection connection = Connect();
		// statement用来执行SQL语句
		Statement statement = connection.createStatement();
		// 要执行的SQL语句
		
		//查询数据
		sql = "select * from admins where AdminID = '" + AdminID + "'";
		// 执行SQL语句并返回结果集
		AdminResult = statement.executeQuery(sql);
		
		while(AdminResult.next()) 
		{
			// 输出结果	
			AdminPassword_temp = AdminResult.getString("AdminPassword");
		}

		// 关闭结果集
		AdminResult.close();
		// 关闭连接
		connection.close();	
		
		if(AdminPassword.equals(AdminPassword_temp))
		{
			System.out.println("登陆成功！");
			Signal = "ture";
			return "success";
		}
		else
		{
			System.out.println("用户名或密码错误！");
			Signal = "账号或密码错误，请重新输入";
			return "failure";
		}
	}
	public Connection Connect()
	{
		Connection connection = null;
		try {
			// 加载驱动程序
			Class.forName("com.mysql.jdbc.Driver");
			// URL指向要访问的数据库名test
			String url = "jdbc:mysql://localhost:3306/bookdb";	
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
	public String back()
	{
		return "back";
	}

	public String getSignal() {
		return Signal;
	}
	public void setSignal(String signal) {
		Signal = signal;
	}
	public String getAdminID() {
		return AdminID;
	}
	public void setAdminID(String adminID) {
		AdminID = adminID;
	}
	public String getAdminPassword() {
		return AdminPassword;
	}
	public void setAdminPassword(String adminPassword) {
		AdminPassword = adminPassword;
	}
	public ResultSet getAdminResult() {
		return AdminResult;
	}
	public void setAdminResult(ResultSet adminResult) {
		AdminResult = adminResult;
	}
}