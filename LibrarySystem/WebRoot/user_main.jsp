<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="s" uri="/struts-tags"%>
<% 
request.setCharacterEncoding("UTF-8"); 
response.setCharacterEncoding("UTF-8"); 
response.setContentType("text/html; charset=utf-8"); 
%> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>欢迎进入图书管系统</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="css/index.css"/>
	<link rel="icon" href="img/favicon.ico">
	<link rel="shortcut icon" href="img/favicon.ico">
	
  </head>
  
  <body>
		<div id="main">
			<div id="left"><img src="img/hitlib.png"/>
				<div id="title">
					<h1>欢迎进入图书管系统</h1>
				</div>
			</div>
		 	<div id="right">
		 		<div id="fun1">
					<h2><a class="hwj" href='<s:url action="user_querybook"></s:url>'>书目查询</a></h2>
				</div>
				<div id="fun2">
					<h2><a class="hwj" href='<s:url action="user_note"></s:url>'>借阅记录</a></h2>
				</div>
				<div id="fun3">
					<h2><a class="hwj" href='<s:url action="user_discovery"></s:url>'>经典推荐</a></h2>
				</div>
				<div id="fun4">
					<h2><a class="hwj" href='<s:url action="user_detail"></s:url>'>资料修改</a></h2>
				</div>
		    </div>
		</div>
		<div id="hwj727"><p style="color:#FFFFFF">Copyright © 2014 软工坊 All Rights Reserved</p></div>
  </body>
</html>