﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
    
    <title>用户信息修改</title>
    
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
  
  <body bgcolor="#BCD2EE">
  <br/>
  <br/>
    <center>
    <s:form action="user_alter">
    	<h3>用户信息修改</h3>
		<s:textfield name="UserID" label="账号" readonly="true" style="background-color:transparent;border-color: #8B7500;border-width: thin;color:#969696;"/>
		<s:textfield name="UserName" label="用户名" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="UserPassword" label="密码" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:submit value="确认修改" align="right"/>
	</s:form>
    </center>
  </body>
</html>
