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
    
    <title>信息修改</title>
    
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
  
  <body>
  <br/>
  <br/>
    <center>
    <s:form action="book_alter">
    	<h3>书籍信息修改</h3>
		<s:textfield name="ISBN" label="ISBN" readonly="true" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="Title" label="书名" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="AuthorName" label="作者" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="AuthorCountry" label="国籍" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="Publisher" label="出版社" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="PublishDate" label="出版日期" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="RegisterDate" label="上架日期" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="Type" label="类别" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="PageNum" label="页码" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="CallNum" label="索取号" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="Price" label="价格" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="Status" label="状态" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="Place" label="馆藏位置" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:textfield name="Love" label="推荐" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
		<s:submit value="确认修改" align="right"/>
	</s:form>
    </center>
  </body>
</html>
