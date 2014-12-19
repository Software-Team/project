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
    
    <title>图书管理界面</title>
    
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
	#hwj
	{
		position: absolute;
		left:1130px;
		top:180px;
	}
    </style>
    <script type="text/javascript">
		function warn(e)
		{		
				var ret = window.confirm("确定删除该书?");
				//当点击确定时 返回 true 
				if(ret){
				    window.location.href='<s:url action="book_delete"></s:url>'+'?ISBN='+e;
				}
		}	
		
		function add()
		{
			window.location.href="book_add.jsp";
		}
	</script>
    
  </head>
  <br/>
  <body>
  <center>
  	<h2>图书管理</h2>
  </center>
  <table align="center">
	<tr align="center">
	<td align="right" height="20">
		
		<s:form action="book_index" theme="simple">
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
		
		<input type="button" value="新增书籍" onclick="add()" />
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href='<s:url action="book_index"></s:url>'>返回书籍列表</a>
		&nbsp;&nbsp;&nbsp;
		<a href="index.jsp">返回主菜单</a>
		
	</td>
	</tr>
	</table>
	
		<p id="hwj">在馆/总数：<s:property value="Book_Remain"/>/<s:property value="Book_Total"/></p>
		<h3 align="center"><s:property value="book_tag"/></h3>
	    <table align="center" border="1" style="font-size:18px">
		    <tr align="center" style="background-color:#CD853F;">
		    	<td align="center">ISBN</td>
		    	<td align="center">书名</td>
		    	<td align="center">作者</td>
		    	<td align="center">出版社</td>
		    	<td align="center">出版年份</td>
		    	<td align="center">类别</td>
		    	<td align="center">状态</td>
		    	<td align="center">馆藏位置</td>
		    	<td align="center">推荐</td>
		    	<td align="center">详细信息</td>
		    	<td align="center">删除</td>
		   	</tr>
		    <s:iterator value="bookdetails_temp">
		        <tr align="center">
		            <td align="center" style="word-break:break-all;width:150px"><s:property value="ISBN"/></td>
		            <td align="center" style="word-break:break-all;width:220px"><s:property value="Title"/></td>
		            <td align="center" style="word-break:break-all;width:140px"><s:property value="AuthorName"/></td>
		            <td align="center" style="word-break:break-all;width:140px"><s:property value="Publisher"/></td>
		            <td align="center" style="word-break:break-all;width:70px"><s:property value="PublishDate"/></td>
		            <td align="center" style="word-break:break-all;width:77px"><s:property value="Type"/></td>
		            <td align="center" style="word-break:break-all;width:40px"><s:property value="Status"/></td>
		            <td align="center" style="word-break:break-all;width:70px"><s:property value="Place"/></td>
		            <td align="center"><s:property value="Love"/></td>
		            <td align="center"><a href='<s:url action="book_getdetail"><s:param name="ISBN" value="ISBN" /></s:url>' style="text-decoration:none;">详细</a></td>
		            <td align="center"><input type="button" name="删除" id="删除" value="删除" onclick="warn('<s:property value="ISBN"/>')" /></td>
		            
		        </tr>
		    </s:iterator>
		    <tr align="right">
				<td colspan="17">
					共<s:property value="TotalRow"/>行&nbsp;
					<a href="<s:url value="book_index.action">
					<s:param name="searchName" value="searchName"/>
					<s:param name="searchValue" value="searchValue"/>
					<s:param name="CurrentPage" value="CurrentPage"/>
					<s:param name="PagerMethod" value="'first'"/>
					</s:url>" style="text-decoration:none;">首页</a>
					<a href="<s:url value="book_index.action">
					<s:param name="searchName" value="searchName"/>
					<s:param name="searchValue" value="searchValue"/>
					<s:param name="CurrentPage" value="CurrentPage"/>
					<s:param name="PagerMethod" value="'previous'"/>
					</s:url>" style="text-decoration:none;">上一页</a>
					第<s:property value="CurrentPage"/>页&nbsp;
					<a href="<s:url value="book_index.action">
					<s:param name="searchName" value="searchName"/>
					<s:param name="searchValue" value="searchValue"/>
					<s:param name="CurrentPage" value="CurrentPage"/>
					<s:param name="PagerMethod" value="'next'"/>
					</s:url>" style="text-decoration:none;">下一页</a>
					<a href="<s:url value="book_index.action">
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