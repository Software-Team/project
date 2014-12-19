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
    
    <title>详细信息</title>
    
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
    <center>
    	<br/>
    	<br/>
    	<h3>书籍信息</h3>
    	<table border="1" style="font-size:18px">
		    <tr style="background-color:#CD853F;">
		    	<td align="center">ISBN</td>
		    	<td align="center">书名</td>
		    	<td align="center">作者</td>
		    	<td align="center">国籍</td>
		    	<td align="center">出版社</td>
		    	<td align="center">出版日期</td>
		    	<td align="center">上架日期</td>
		    	<td align="center">类别</td>
		    	<td align="center">页码</td>
		    	<td align="center">索取号</td>
		    	<td align="center">价格</td>
		    	<td align="center">状态</td>
		    	<td align="center">馆藏位置</td>
		    	<td align="center">推荐</td>

		   	</tr>
		    <tr>
		        <td align="center"><s:property value="ISBN" /></td>
		        <td align="center"><s:property value="Title"/></td>
		        <td align="center"><s:property value="AuthorName"/></td>
		        <td align="center"><s:property value="AuthorCountry"/></td>
		        <td align="center"><s:property value="Publisher"/></td>
		        <td align="center"><s:property value="PublishDate"/></td>
		        <td align="center"><s:property value="RegisterDate"/></td>
		        <td align="center"><s:property value="Type"/></td>
		        <td align="center"><s:property value="PageNum"/></td>
		        <td align="center"><s:property value="CallNum"/></td>
		        <td align="center"><s:property value="Price"/></td>
		        <td align="center"><s:property value="Status"/></td>
		        <td align="center"><s:property value="Place"/></td>
		        <td align="center"><s:property value="Love"/></td>
		    </tr>    
	    </table>
    	
    	<br/>
    	<br/>
	    <table align="center">
			<tr align="center">
				<td align="right" height="20">
					<a href='<s:url action="user_querybook"></s:url>'>返回新书列表</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href='<s:url action="user_note"></s:url>'>返回借阅记录</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href='<s:url action="user_discovery"></s:url>'>返回经典推荐</a>
				</td>
			</tr> 
		</table>
	    	
	</center>
  </body>
</html>
