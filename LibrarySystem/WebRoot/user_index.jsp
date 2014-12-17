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
    
    <title>用户管理界面</title>
    
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
		left:830px;
		top:180px;
	}
    </style>
     <script type="text/javascript">
		function warn(e)
		{		
				var ret = window.confirm("确定删除该用户?");
				//当点击确定时 返回 true 
				if(ret){
				    window.location.href='<s:url action="user_delete"></s:url>'+'?UserID='+e;
				}
		}	
		
		function add()
		{
			window.location.href="user_add.jsp";
		}
	</script>
  </head>
  
  <body>
	<br/>
  <center>
  	<h2>用户管理</h2>
  </center>
  <p id="hwj">总计：<s:property value="User_Total"/></p>
  <table align="center">
	<tr align="center">
	<td align="right" height="20">
		
	<s:form action="user_index" theme="simple">
		<select name="searchName">
			<option value="UserID">账号</option>
			<option value="UserName">用户名</option>	
		</select>
		<s:textfield name="searchValue"/>
		<s:submit value="查询" align="right"/>
	</s:form>
	<input type="button" value="新增用户" onclick="add()" />
	&nbsp;&nbsp;
	<a href='<s:url action="user_index"></s:url>'>返回用户列表</a>
	&nbsp;&nbsp;
	<a href="index.jsp">返回主菜单</a>
	
	</td>
	</tr>
	</table>
	
	
		<h3 align="center"><s:property value="user_tag"/></h3>
	    <table align="center" border="1" style="font-size:18px">
		    <tr align="center" style="background-color:#CD853F;">
		    	<td align="center">账号</td>
		    	<td align="center">用户名</td>
		    	<td align="center">密码</td>
		    	<td align="center">详细信息</td>
		    	<td align="center">修改</td>
		    	<td align="center">删除</td>
		   	</tr>
		    <s:iterator value="userdetails_temp">
		        <tr align="center">
		            <td align="center"><s:property value="UserID"/></td>
		            <td align="center"><s:property value="UserName"/></td>
		            <td align="center">*********</td>
		            <td align="center"><a href='<s:url action="user_getdetail"><s:param name="UserID" value="UserID"/></s:url>' style="text-decoration:none;">详细</a></td>
		            <td align="center"><a href='<s:url action="user_alter_prepare"><s:param name="UserID" value="UserID" /><s:param name="UserName" value="UserName" /><s:param name="UserPassword" value="UserPassword" /></s:url>' style="text-decoration:none;">修改</a></td>
		            <td align="center"><input type="button" name="删除" id="删除" value="删除" onclick="warn('<s:property value="UserID"/>')"/></td>
		        </tr>
		    </s:iterator>
		    <tr align="right">
				<td colspan="17">
					共<s:property value="TotalRow"/>行&nbsp;
					<a href="<s:url value="user_index.action">
					<s:param name="searchName" value="searchName"/>
					<s:param name="searchValue" value="searchValue"/>
					<s:param name="CurrentPage" value="CurrentPage"/>
					<s:param name="PagerMethod" value="'first'"/>
					</s:url>" style="text-decoration:none;">首页</a>
					<a href="<s:url value="user_index.action">
					<s:param name="searchName" value="searchName"/>
					<s:param name="searchValue" value="searchValue"/>
					<s:param name="CurrentPage" value="CurrentPage"/>
					<s:param name="PagerMethod" value="'previous'"/>
					</s:url>" style="text-decoration:none;">上一页</a>
					第<s:property value="CurrentPage"/>页&nbsp;
					<a href="<s:url value="user_index.action">
					<s:param name="searchName" value="searchName"/>
					<s:param name="searchValue" value="searchValue"/>
					<s:param name="CurrentPage" value="CurrentPage"/>
					<s:param name="PagerMethod" value="'next'"/>
					</s:url>" style="text-decoration:none;">下一页</a>
					<a href="<s:url value="user_index.action">
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