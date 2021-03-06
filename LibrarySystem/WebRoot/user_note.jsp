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
    
    <title>借阅记录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="icon" href="img/favicon.ico">
	<link rel="shortcut icon" href="img/favicon.ico">
	<style type="text/css">
  	body
	{
		background-image:url(img/bg2.jpg);
		background-repeat: repeat;
	}
	#hwj727
	{
		position: absolute;
		left:1028px;
		top:125px;
	}
    </style>
  </head>
  
  <body>
	  <br/>
	  <br/>
	  <center>
	  	<h2>借阅记录</h2>
	  	<a href="user_main.jsp" id="hwj727" style="text-decoration:none;">返回主菜单</a>
	  	<br/>
	  	
	  </center>
  	  <center>
  	  	<h4 style="color: red;"><s:property value="book_tag"/></h4>
	    <table border="1" style="font-size:18px">
		    <tr style="background-color:#CD853F;">
		    	<td align="center" style="word-break:break-all;width:150px;">ISBN</td>
		    	<td align="center" style="word-break:break-all;width:220px;">书名</td>
		    	<td align="center" style="word-break:break-all;width:100px;">借出日期</td>
		    	<td align="center" style="word-break:break-all;width:100px;">归还日期</td>
		    	<td align="center" style="word-break:break-all;width:80px;">续借次数</td>
		    	<td align="center">详细信息</td>
		    	<td align="center">推荐</td>
		    	<td align="center">续借</td>
		   	</tr>
		    <s:iterator value="notedetails_temp">
		        <tr>
		            <td align="center" ><s:property value="ISBN"/></td>
		            <td align="center" ><s:property value="Title"/></td>
		            <td align="center" ><s:property value="OutTime"/></td>
		            <td align="center" ><s:property value="Expiration"/></td>
		            <td align="center" ><s:property value="Num"/></td>
		            <td align="center"><a href='<s:url action="user_book_detail"><s:param name="page_tag" value="page_tag" /><s:param name="ISBN" value="ISBN" /></s:url>' style="text-decoration:none;">详细</a></td>
		            <td align="center"><a href='<s:url action="book_love"><s:param name="ISBN" value="ISBN" /></s:url>' style="text-decoration:none;">推荐</a></td>
		            <td align="center"><a href='<s:url action="user_borrowagain"><s:param name="ISBN" value="ISBN" /></s:url>' style="text-decoration:none;">续借</a></td>
		        </tr>
		    </s:iterator>
		    <tr align="right">
				<td colspan="17">
					共<s:property value="TotalRow"/>行&nbsp;
					<a href="<s:url value="user_note.action">
					<s:param name="searchName" value="searchName"/>
					<s:param name="searchValue" value="searchValue"/>
					<s:param name="CurrentPage" value="CurrentPage"/>
					<s:param name="PagerMethod" value="'first'"/>
					</s:url>" style="text-decoration:none;">首页</a>
					<a href="<s:url value="user_note.action">
					<s:param name="searchName" value="searchName"/>
					<s:param name="searchValue" value="searchValue"/>
					<s:param name="CurrentPage" value="CurrentPage"/>
					<s:param name="PagerMethod" value="'previous'"/>
					</s:url>" style="text-decoration:none;">上一页</a>
					第<s:property value="CurrentPage"/>页&nbsp;
					<a href="<s:url value="user_note.action">
					<s:param name="searchName" value="searchName"/>
					<s:param name="searchValue" value="searchValue"/>
					<s:param name="CurrentPage" value="CurrentPage"/>
					<s:param name="PagerMethod" value="'next'"/>
					</s:url>" style="text-decoration:none;">下一页</a>
					<a href="<s:url value="user_note.action">
					<s:param name="searchName" value="searchName"/>
					<s:param name="searchValue" value="searchValue"/>
					<s:param name="CurrentPage" value="CurrentPage"/>
					<s:param name="PagerMethod" value="'last'"/>
					</s:url>" style="text-decoration:none;">尾页</a>
					共<s:property value="TotalPage"/>页&nbsp;
				</td>
			</tr>
	    </table>
	    
	</center>
      
  </body>
</html>
