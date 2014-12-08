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
	<style type="text/css">
  	body
	{
		background-image:url(img/bg2.jpg);
		background-repeat: repeat;
	}
    </style>
    <script type="text/javascript">
		function warn()
		{		
				var ret = window.confirm("确定删除该用户?");
				//当点击确定时 返回 true 
				if(ret){
				    window.location.href='<s:url action="user_delete"><s:param name="UserID" value="UserID"/></s:url>';
				}
		}	
	</script>
  </head>
  
  <body bgcolor="#BCD2EE">
    <center>
    	<br/>
    	<br/>
    	<h3>用户信息</h3>
    	<s:form action="user_index">
			<s:submit value = "返回用户管理界面"/>
		</s:form>
    	<table border="1" style="font-size:18px">
		    <tr style="background-color:#CD853F;">
		    	<td align="center">账户</td>
		    	<td align="center">用户名</td>
		    	<td align="center">密码</td>
		    	<td align="center">修改</td>
		    	<td align="center">删除</td>
		   	</tr>
		    <tr>
		        <td align="center"><s:property value="UserID" /></td>
		        <td align="center"><s:property value="UserName"/></td>
		        <td align="center"><s:property value="UserPassword"/></td>
		        <td align="center"><a href='<s:url action="user_alter_prepare"><s:param name="UserID" value="UserID" /><s:param name="UserName" value="UserName" /><s:param name="UserPassword" value="UserPassword" /></s:url>'>修改</a></td>
		        <td align="center"><input type="button" name="删除" id="删除" value="删除" onclick="warn()"/></td>
		    </tr>    
	    </table>
	    <br/>
	    <h3>借阅记录</h3>
    	<table border="1" style="font-size:18px">
		    <tr style="background-color:#CD853F;">
		    	<td align="center">ISBN</td>
		    	<td align="center">书名</td>
		    	<td align="center">借出日期</td>
		    	<td align="center">归还日期</td>
		    	<td align="center">续借次数</td>
		    	<td align="center">还书</td>
		   	</tr>
		    <s:iterator value="notedetails">
		        <tr>
		            <td align="center"><s:property value="ISBN"/></td>
		            <td align="center"><s:property value="Title"/></td>
		            <td align="center"><s:property value="OutTime"/></td>
		            <td align="center"><s:property value="Expiration"/></td>
		            <td align="center"><s:property value="Num"/></td>
		            <td align="center"><a href='<s:url action="return_book"><s:param name="ISBN" value="ISBN" /><s:param name="UserID" value="UserID" /></s:url>' style="text-decoration:none;">还书</a></td>
		        </tr>
		    </s:iterator>
	    </table>
    </center>
  </body>
</html>
