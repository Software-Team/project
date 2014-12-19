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
    
    <title>添加书籍</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="icon" href="img/favicon.ico">
	<link rel="shortcut icon" href="img/favicon.ico">
	<style type="text/css">
  	body
	{
		background-image:url(img/bg2.jpg);
		background-repeat: repeat;
	}
    </style>

  </head>
  
  <body  bgcolor="#BCD2EE">
    <center>
    	<br>
    	<br>
    	<br>
    	<h3>请输入用户信息</h3>
    	<s:form action="user_add">
		<s:textfield name="UserID" label="账户" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="UserName" label="用户名" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="UserPassword" label="密码" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:submit value="添加用户" align="right"/>
	</s:form>
	<s:form action="user_index">
		<s:submit value = "返回用户管理界面"/>
	</s:form>
    </center>
  </body>
</html>
