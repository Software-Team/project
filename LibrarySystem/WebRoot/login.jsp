<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>图书馆登录注册界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="icon" href="img/favicon.ico">
	<link rel="shortcut icon" href="img/favicon.ico">
	
	<link rel="stylesheet" type="text/css" href="css/login.css"/>
	<script type="text/javascript">
		function Show_AdminLogin(AdminLogin_input,UserLogin_input,UserRegist_input,UserRegist_pic){
			AdminLogin_input.style.display='block';
		   	UserLogin_input.style.display='none';
		   	UserRegist_input.style.display='none';
		   	UserRegist_pic.style.display='none';
		}
		function Show_UserLogin(AdminLogin_input,UserLogin_input,UserRegist_input,UserRegist_pic){
			AdminLogin_input.style.display='none';
		   	UserLogin_input.style.display='block';
		   	UserRegist_input.style.display='none';
		   	UserRegist_pic.style.display='block';
		}
		function Show_UserRegist(AdminLogin_input,UserLogin_input,UserRegist_input,UserRegist_pic){
			AdminLogin_input.style.display='none';
		   	UserLogin_input.style.display='none';
		   	UserRegist_input.style.display='block';
		   	UserRegist_pic.style.display='none';
		}
	</script>

  </head>
  
  <body>
    <div id="bg">
    	<p id="hwj" style="color: red;"><s:property value="Signal"/></p>
		<div id="AdminLogin_input" style="display: none;" class="input">	
			<s:form action="login" >
				<s:textfield name="AdminID" label=" 账号" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>					
				<s:password name="AdminPassword" label=" 密码" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
				<s:submit value="管理员登录" align="right"/>
			</s:form>
		</div>
		<div id="UserLogin_input" style="display: block;" class="input">
			<s:form action="userlogin" >
				<s:textfield name="UserID" label=" 账号" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>					
				<s:password name="UserPassword" label=" 密码"  style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
				<s:submit value="用户登录" align="right"/>
			</s:form>
		</div>
		<div id="UserRegist_input" style="display: none;" class="input">
			<s:form action="userregist" >
				<s:textfield name="UserID" label=" 账号" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>	
				<s:textfield name="UserName" label=" 姓名" style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>				
				<s:password name="UserPassword" label=" 密码"  style="background-color:transparent;border-color: #8B7500;border-width: thin;"/>
				<s:submit value="用户注册" align="right"/>
			</s:form>
		</div>
		<br/>
		<div id="AdminLogin_pic"><a href="javascript:void(0);" onclick="Show_AdminLogin(AdminLogin_input,UserLogin_input,UserRegist_input,UserRegist_pic)"><img src="img/admin.png"/></a></div>
	  	<div id="UserLogin_pic"><a href="javascript:void(0);" onclick="Show_UserLogin(AdminLogin_input,UserLogin_input,UserRegist_input,UserRegist_pic)"><img src="img/student.png"/></a></div>
	  	<div id="UserRegist_pic" style="display: block;"><a href="javascript:void(0);" onclick="Show_UserRegist(AdminLogin_input,UserLogin_input,UserRegist_input,UserRegist_pic)" style="text-decoration:none;">用户注册</a></div>
	  	<div id="Admin">管理员登陆</div>
	  	<div id="User">用户登录</div>
	</div>
  </body>
</html>
