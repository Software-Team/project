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
    
    <title>经典推荐</title>
    
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
	#hwj
	{
		position: absolute;
		left:1155px;
		top:100px;
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
		function warn1(str)
		{
			if (str=="")
			{
				alert("内容不能为空，请输入书籍简介！");
				return false;
			}
			else
			{
				alert("编辑成功！");
				return ture;
			}
		}
	</script>
  </head>
  
  <body>
	  <br/>
	  <center>
	  	<h2>经典推荐</h2>
	  	<a href="index.jsp" id="hwj" style="text-decoration:none;">返回主菜单</a>
	  	<br/>
	  	<br/>
	  </center>
  	  <center>
	    <table border="1" style="font-size:18px">
		    <tr style="background-color:#CD853F;">
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
		    <s:iterator value="bookdetails" status="num">
		        <tr>
		            <td align="center" style="word-break:break-all;width:150px"><s:property value="ISBN"/></td>
		            <td align="center" style="word-break:break-all;width:220px"><a href="goodbook_index.action#mulu<s:property value="#num.count"/>" style="text-decoration:none;"><s:property value="Title"/></a></td>
		            <td align="center" style="word-break:break-all;width:140px"><s:property value="AuthorName"/></td>
		            <td align="center" style="word-break:break-all;width:140px"><s:property value="Publisher"/></td>
		            <td align="center" style="word-break:break-all;width:70px"><s:property value="PublishDate"/></td>
		            <td align="center" style="word-break:break-all;width:77px"><s:property value="Type"/></td>
		            <td align="center" style="word-break:break-all;width:40px"><s:property value="Status"/></td>
		            <td align="center" style="word-break:break-all;width:70px"><s:property value="Place"/></td>
		            <td align="center"><s:property value="Love"/></td>
		            <td align="center"><a href='<s:url action="book_getdetail"><s:param name="page_tag" value="page_tag" /><s:param name="ISBN" value="ISBN" /></s:url>' style="text-decoration:none;">详细</a></td>
		            <td align="center"><input type="button" name="删除" id="删除" value="删除" onclick="warn('<s:property value="ISBN"/>')" /></td>
		        </tr>
		    </s:iterator>
	    </table>
	<br/>
	<h3>书籍简介</h3>
	<s:iterator value="goodbookdetails" status="num">
	 	<s:form action="write_summary">
		 	<div id="mulu<s:property value="#num.count"/>"><s:textarea name="Num" style="display:none"/></div>
		 	<s:textarea label="书名" name="Title" cssStyle="background-color:transparent;border-color: #8B7500;border-width: thin;width:600px;height:25px;font-size:15px;"/>
		 	<s:textarea label="作者" name="Author" cssStyle="background-color:transparent;border-color: #8B7500;border-width: thin;width:600px;height:25px;font-size:15px;font-family:华文楷体"/>
			<s:textarea label="简介" name="Words" cssStyle="background-color:transparent;border-color: #8B7500;border-width: thin;width:600px;height:150;font-size:14px;"/>
			<s:submit value="提交编辑" align="right"/>
		</s:form>
	</s:iterator>
	</center>
  </body>
</html>
