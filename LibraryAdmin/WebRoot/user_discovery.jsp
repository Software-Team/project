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
    
    <title>经典推荐</title>
    
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
	  	<h2>经典推荐</h2>
	  	<a href="user_main.jsp">返回主菜单</a>
	  	<br/>
	  	<br/>
	  </center>
  	  <center>
  	  	<h4><s:property value="book_tag"/></h4>
	    <table border="1" style="font-size:18px">
		    <tr style="background-color:#CD853F;">
		    	<td align="center">ISBN</td>
		    	<td align="center">书名</td>
		    	<td align="center">作者</td>
		    	<td align="center">出版日期</td>
		    	<td align="center">类别</td>
		    	<td align="center">状态</td>
		    	<td align="center">馆藏位置</td>
		    	<td align="center">推荐</td>
		    	<td align="center">详细信息</td>
		    	<td align="center">预借</td>
		   	</tr>
		    <s:iterator value="userbookdetails" status="num">
		        <tr>
		            <td align="center"><s:property value="ISBN"/></td>
		            <td align="center"><a href="user_discovery.action#mulu<s:property value="#num.count"/>" style="text-decoration:none;"><s:property value="Title"/></a></td>
		            <td align="center"><s:property value="AuthorName"/></td>
		            <td align="center"><s:property value="PublishDate"/></td>
		            <td align="center"><s:property value="Type"/></td>
		            <td align="center"><s:property value="Status"/></td>
		            <td align="center"><s:property value="Place"/></td>
		            <td align="center"><s:property value="Love"/></td>
		            <td align="center"><a href='<s:url action="user_book_detail"><s:param name="ISBN" value="ISBN" /></s:url>' style="text-decoration:none;">详细</a></td>
		            <td align="center"><a href='<s:url action="user_good_book_reserve"><s:param name="ISBN" value="ISBN" /><s:param name="Title" value="Title" /></s:url>' style="text-decoration:none;">预借</a></td>
		        </tr>
		    </s:iterator>
	    </table>
	</center>
    
	<br>
	<s:iterator value="userbookdetails" status="num">
	 	<div id="mulu<s:property value="#num.count"/>" style="height:500px;width:80px;"><s:property value="Title"/></div>
	</s:iterator>
  </body>
</html>
