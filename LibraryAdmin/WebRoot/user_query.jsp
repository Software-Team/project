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
    
    <title>书目查询</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<!-- <link rel="stylesheet" type="text/css" href="styles.css"> -->
	
	
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
  	<h2>书目查询</h2>
  </center>
  <table align="center">
	<tr align="center">
	<td align="right" height="20">
		
		<s:form action="user_querybook" theme="simple">
			<select name="searchName">
				<option value="ISBN">ISBN</option>
				<option selected value="Title">书名</option>
				<option value="AuthorName">作者</option>
				<option value="Type">类型</option>	
				<option value="CallNum">索取号</option>	
				<option value="Place">馆藏位置</option>
			</select>
			<s:textfield name="searchValue"/>
			<s:submit value="查询" align="right"/>
		</s:form>
		
		<a href='<s:url action="user_querybook"></s:url>'>返回新书列表</a>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="user_main.jsp">返回主菜单</a>
	</td>
	</tr> 
	</table>
	
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
		    <s:iterator value="userbookdetails">
		        <tr>
		            <td align="center"><s:property value="ISBN"/></td>
		            <td align="center"><s:property value="Title"/></td>
		            <td align="center"><s:property value="AuthorName"/></td>
		            <td align="center"><s:property value="PublishDate"/></td>
		            <td align="center"><s:property value="Type"/></td>
		            <td align="center"><s:property value="Status"/></td>
		            <td align="center"><s:property value="Place"/></td>
		            <td align="center"><s:property value="Love"/></td>
		            <td align="center"><a href='<s:url action="user_book_detail"><s:param name="ISBN" value="ISBN" /></s:url>' style="text-decoration:none;">详细</a></td>
		            <td align="center"><a href='<s:url action="user_book_reserve"><s:param name="ISBN" value="ISBN" /><s:param name="Title" value="Title" /></s:url>' style="text-decoration:none;">预借</a></td>
		        </tr>
		    </s:iterator>
	    </table>
	</center>
  </body>
</html>