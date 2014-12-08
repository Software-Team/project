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
    
    <title>借阅记录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
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
	  <center>
	  	<h2>借阅记录</h2>
	  	<a href="user_main.jsp">返回主菜单</a>
	  	<br/>
	  	<br/>
	  </center>
  	  <center>
  	  	<h4 style="color: red;"><s:property value="book_tag"/></h4>
	    <table border="1" style="font-size:18px">
		    <tr style="background-color:#CD853F;">
		    	<td align="center">ISBN</td>
		    	<td align="center">书名</td>
		    	<td align="center">借出日期</td>
		    	<td align="center">归还日期</td>
		    	<td align="center">续借次数</td>
		    	<td align="center">详细信息</td>
		    	<td align="center">推荐</td>
		    	<td align="center">续借</td>
		   	</tr>
		    <s:iterator value="notedetails">
		        <tr>
		            <td align="center"><s:property value="ISBN"/></td>
		            <td align="center"><s:property value="Title"/></td>
		            <td align="center"><s:property value="OutTime"/></td>
		            <td align="center"><s:property value="Expiration"/></td>
		            <td align="center"><s:property value="Num"/></td>
		            <td align="center"><a href='<s:url action="user_book_detail"><s:param name="ISBN" value="ISBN" /></s:url>' style="text-decoration:none;">详细</a></td>
		            <td align="center"><a href='<s:url action="book_love"><s:param name="ISBN" value="ISBN" /></s:url>' style="text-decoration:none;">推荐</a></td>
		            <td align="center"><a href='<s:url action="user_borrowagain"><s:param name="ISBN" value="ISBN" /></s:url>' style="text-decoration:none;">续借</a></td>
		        </tr>
		    </s:iterator>
	    </table>
	    
	</center>
      
  </body>
</html>
