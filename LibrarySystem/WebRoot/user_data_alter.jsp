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
    
    <title>用户信息修改</title>
    
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
    <script type="text/javascript">
		function Show_UserAlter(User_Data,User_Alter){
			User_Data.style.display='none';
		   	User_Alter.style.display='block';
		}
		function warn(str)
		{
			if (str=="")
			{
				alert("内容不能为空，请输入您的意见！");
				return false;
			}
			else
			{
				alert("提交成功，感谢您提出的宝贵意见！");
				return ture;
			}
		}
	</script>
    
  </head>
  
  <body bgcolor="#BCD2EE">
  <br/>
  <br/>
    <center>
    
    <div id="User_Data" style="display: block;">
    	<h2>用户信息</h2>
    	<a href="user_main.jsp">返回主菜单</a>
	  	<br/>
	  	<br/>
    	<table border="1" style="font-size:18px">
		    <tr style="background-color:#CD853F;">
		    	<td align="center">账户</td>
		    	<td align="center">用户名</td>
		    	<td align="center">密码</td>
		    	<td align="center">修改</td>
		   	</tr>
		    <tr>
		        <td align="center"><s:property value="UserID" /></td>
		        <td align="center"><s:property value="UserName"/></td>
		        <td align="center"><s:property value="UserPassword"/></td>
		        <td align="center"><a href="javascript:void(0);" onclick="Show_UserAlter(User_Data,User_Alter)" style="text-decoration:none;">修改</a></td>
		    </tr>    
	    </table>
    </div>
    
    <div id="User_Alter" style="display: none;">
    	<h3>用户信息修改</h3>
	    <s:form action="user_data_alter">
			<s:textfield name="UserID" label="账户（禁止修改）"/>
			<s:textfield name="UserName" label="书名"/>
			<s:textfield name="UserPassword" label="密码"/>
			<s:submit value="确认修改" align="right"/>
		</s:form>
	</div>
	<br/>
	<br/>
	<p>意见反馈</p>
	<s:form action="write_advice">
		<s:textarea id="hwj" name="Advice" cssStyle="background-color:transparent;border-color: #8B7500;border-width: thin;width:300px;height:77"/>
		<s:submit value="提交意见" align="right" onclick = "return warn(document.getElementById('hwj').value)"/>
	</s:form>
    </center>
  </body>
</html>
