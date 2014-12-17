<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户信息修改</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
  	body
	{
		background-image:url(img/bg2.jpg);
		background-repeat: repeat;
	}
    </style>
    <script type="text/javascript">
		function Show_UserAlter(User_Data,User_Alter){
			User_Data.style.display='none';
		   	User_Alter.style.display='block';
		}
	</script>
    
  </head>
  
  <body bgcolor="#BCD2EE">
  <br/>
  <br/>
    <center>
    
    <div id="User_Data" style="display: block;">
    	<h2>用户信息</h2>
    	<a href="user_main.jsp">返回主菜单</a>
	  	<br/>
	  	<br/>
    	<table border="1" style="font-size:18px">
		    <tr style="background-color:#CD853F;">
		    	<td align="center">账户</td>
		    	<td align="center">用户名</td>
		    	<td align="center">密码</td>
		    	<td align="center">修改</td>
		   	</tr>
		    <tr>
		        <td align="center"><s:property value="UserID" /></td>
		        <td align="center"><s:property value="UserName"/></td>
		        <td align="center"><s:property value="UserPassword"/></td>
		        <td align="center"><a href="javascript:void(0);" onclick="Show_UserAlter(User_Data,User_Alter)">修改</a></td>
		    </tr>    
	    </table>
    </div>
    
    <div id="User_Alter" style="display: none;">
    	<h3>用户信息修改</h3>
	    <s:form action="user_data_alter">
			<s:textfield name="UserID" label="账户（禁止修改）"/>
			<s:textfield name="UserName" label="书名"/>
			<s:textfield name="UserPassword" label="密码"/>
			<s:submit value="确认修改" align="right"/>
		</s:form>
	</div>
    </center>
  </body>
</html>
