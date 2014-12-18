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
    
    <title>意见反馈</title>
    
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
	#hwj
	{
		position: absolute;
		left:985px;
		top:110px;
	}
    </style>
  </head>
  
  <body>
	<br/>
  <center>
  	<h2>用户意见反馈</h2>
  </center>
  <p id="hwj">总计：<s:property value="Advice_Total"/></p>
  <table align="center">
	<tr align="center">
	<td align="right" height="20">
		
	
	<a href='<s:url action="user_index"></s:url>'>返回用户列表</a>
	&nbsp;&nbsp;
	<a href="index.jsp">返回主菜单</a>
	
	</td>
	</tr>
	</table>
	
	<br/>
	<h3 align="center"><s:property value="user_tag"/></h3>
    <table align="center" border="1" style="font-size:18px">
	    <tr align="center" style="background-color:#CD853F;">
	    	<td align="center" style="word-break:break-all;width:40px">序号</td>
	    	<td align="center" style="word-break:break-all;width:100px">用户账号</td>
	    	<td align="center" style="word-break:break-all;width:100px">反馈时间</td>
	    	<td align="center" style="word-break:break-all;width:450px">意见内容</td>
	   	</tr>
	    <s:iterator value="advicedetails_temp">
	        <tr align="center">
	            <td align="center" style="word-break:break-all;width:40px"><s:property value="Num"/></td>
	            <td align="center" style="word-break:break-all;width:100px"><s:property value="UserID"/></td>
	            <td align="center" style="word-break:break-all;width:100px"><s:property value="Time"/></td>
	            <td align="center" style="word-break:break-all;width:450px;height:60px;"><s:property value="Words"/></td>
	        </tr>
	    </s:iterator>
	    <tr align="right">
			<td colspan="4">
				共<s:property value="TotalRow"/>行&nbsp;
				<a href="<s:url value="advice_index.action">
				<s:param name="searchName" value="searchName"/>
				<s:param name="searchValue" value="searchValue"/>
				<s:param name="CurrentPage" value="CurrentPage"/>
				<s:param name="PagerMethod" value="'first'"/>
				</s:url>" style="text-decoration:none;">首页</a>
				<a href="<s:url value="advice_index.action">
				<s:param name="searchName" value="searchName"/>
				<s:param name="searchValue" value="searchValue"/>
				<s:param name="CurrentPage" value="CurrentPage"/>
				<s:param name="PagerMethod" value="'previous'"/>
				</s:url>" style="text-decoration:none;">上一页</a>
				第<s:property value="CurrentPage"/>页&nbsp;
				<a href="<s:url value="advice_index.action">
				<s:param name="searchName" value="searchName"/>
				<s:param name="searchValue" value="searchValue"/>
				<s:param name="CurrentPage" value="CurrentPage"/>
				<s:param name="PagerMethod" value="'next'"/>
				</s:url>" style="text-decoration:none;">下一页</a>
				<a href="<s:url value="advice_index.action">
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