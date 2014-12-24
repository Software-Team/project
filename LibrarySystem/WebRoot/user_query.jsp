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
    
    <title>书目查询</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<!-- <link rel="stylesheet" type="text/css" href="styles.css"> -->
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
		left:645px;
		top:150px;
	}
	#nlh923
	{
		position: absolute;
		left:1105px;
		top:150px;
	}
    </style>
    
  </head>
  
  <body>
	<br/>
  <center>
  	<h2>书目查询</h2>
  </center>
  	<h3><a id="hwj727" style="text-decoration:none;" href='<s:url action="user_querybook"></s:url>'>新书列表</a></h3>
	<a id="nlh923" href="user_main.jsp" style="text-decoration:none;">返回主菜单</a>
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
		</td>
		</tr> 
	</table>
	<br/>
	<br/>

		<h4 align="center" style="color:red"><s:property value="book_tag"/></h4>
	    <table align="center" border="1" style="font-size:18px">
		    <tr align="center" style="background-color:#CD853F;">
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
		    <s:iterator value="userbookdetails_temp">
		        <tr align="center">
		            <td align="center" style="word-break:break-all;width:150px"><s:property value="ISBN"/></td>
		            <td align="center" style="word-break:break-all;width:225px"><s:property value="Title"/></td>
		            <td align="center" style="word-break:break-all;width:140px"><s:property value="AuthorName"/></td>
		            <td align="center" style="word-break:break-all;width:100px"><s:property value="PublishDate"/></td>
		            <td align="center" style="word-break:break-all;width:77px"><s:property value="Type"/></td>
		            <td align="center" style="word-break:break-all;width:40px"><s:property value="Status"/></td>
		            <td align="center" style="word-break:break-all;width:70px"><s:property value="Place"/></td>
		            <td align="center"><s:property value="Love"/></td>
		            <td align="center"><a href='<s:url action="user_book_detail"><s:param name="page_tag" value="page_tag" /><s:param name="ISBN" value="ISBN" /></s:url>' style="text-decoration:none;">详细</a></td>
		            <td align="center"><a href='<s:url action="user_book_reserve"><s:param name="ISBN" value="ISBN" /><s:param name="Title" value="Title" /></s:url>' style="text-decoration:none;">预借</a></td>
		        </tr>
		    </s:iterator>
		    <tr align="right">
				<td colspan="17">
					共<s:property value="TotalRow"/>行&nbsp;
					<a href="<s:url value="user_querybook.action">
					<s:param name="searchName" value="searchName"/>
					<s:param name="searchValue" value="searchValue"/>
					<s:param name="CurrentPage" value="CurrentPage"/>
					<s:param name="PagerMethod" value="'first'"/>
					</s:url>" style="text-decoration:none;">首页</a>
					<a href="<s:url value="user_querybook.action">
					<s:param name="searchName" value="searchName"/>
					<s:param name="searchValue" value="searchValue"/>
					<s:param name="CurrentPage" value="CurrentPage"/>
					<s:param name="PagerMethod" value="'previous'"/>
					</s:url>" style="text-decoration:none;">上一页</a>
					第<s:property value="CurrentPage"/>页&nbsp;
					<a href="<s:url value="user_querybook.action">
					<s:param name="searchName" value="searchName"/>
					<s:param name="searchValue" value="searchValue"/>
					<s:param name="CurrentPage" value="CurrentPage"/>
					<s:param name="PagerMethod" value="'next'"/>
					</s:url>" style="text-decoration:none;">下一页</a>
					<a href="<s:url value="user_querybook.action">
					<s:param name="searchName" value="searchName"/>
					<s:param name="searchValue" value="searchValue"/>
					<s:param name="CurrentPage" value="CurrentPage"/>
					<s:param name="PagerMethod" value="'last'"/>
					</s:url>" style="text-decoration:none;">尾页</a>
					共<s:property value="TotalPage"/>页&nbsp;
				</td>
			</tr>
	    </table>
  </body>
</html>