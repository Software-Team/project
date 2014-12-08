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
    
    <title>新书通报</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<style type="text/css">
  	body
	{
		background-image:url(img/bg2.jpg);
		background-repeat: repeat;
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
	</script>
  </head>
  
  <body>
	  <br/>
	  <center>
	  	<h2>新书通报</h2>
	  	<a href="index.jsp">返回主菜单</a>
	  	<br/>
	  	<br/>
	  </center>
  	  <center>
		<h3><s:property value="book_tag"/></h3>
	    <table border="1" style="font-size:18px">
		    <tr style="background-color:#CD853F;">
		    	<td align="center">ISBN</td>
		    	<td align="center">书名</td>
		    	<td align="center">作者</td>
		    	<td align="center">国籍</td>
		    	<td align="center">出版社</td>
		    	<td align="center">出版日期</td>
		    	<td align="center">上架日期</td>
		    	<td align="center">类别</td>
		    	<td align="center">页码</td>
		    	<td align="center">索取号</td>
		    	<td align="center">价格</td>
		    	<td align="center">状态</td>
		    	<td align="center">馆藏位置</td>
		    	<td align="center">推荐</td>
		    	<td align="center">详细信息</td>
		    	<td align="center">修改</td>
		    	<td align="center">删除</td>
		   	</tr>
		    <s:iterator value="bookdetails">
		        <tr>
		            <td align="center"><s:property value="ISBN"/></td>
		            <td align="center"><s:property value="Title"/></td>
		            <td align="center"><s:property value="AuthorName"/></td>
		            <td align="center"><s:property value="AuthorCountry"/></td>
		            <td align="center"><s:property value="Publisher"/></td>
		            <td align="center"><s:property value="PublishDate"/></td>
		            <td align="center"><s:property value="RegisterDate"/></td>
		            <td align="center"><s:property value="Type"/></td>
		            <td align="center"><s:property value="PageNum"/></td>
		            <td align="center"><s:property value="CallNum"/></td>
		            <td align="center"><s:property value="Price"/></td>
		            <td align="center"><s:property value="Status"/></td>
		            <td align="center"><s:property value="Place"/></td>
		            <td align="center"><s:property value="Love"/></td>
		            <td align="center"><a href='<s:url action="book_getdetail"><s:param name="ISBN" value="ISBN" /></s:url>' style="text-decoration:none;">详细</a></td>
		            <td align="center"><a href='<s:url action="book_alter_prepare"><s:param name="ISBN" value="ISBN" /><s:param name="Title" value="Title" /><s:param name="AuthorName" value="AuthorName" /><s:param name="AuthorCountry" value="AuthorCountry" /><s:param name="Publisher" value="Publisher" /><s:param name="PublishDate" value="PublishDate" /><s:param name="RegisterDate" value="RegisterDate" /><s:param name="Type" value="Type" /><s:param name="PageNum" value="PageNum" /><s:param name="CallNum" value="CallNum" /><s:param name="Price" value="Price" /><s:param name="Status" value="Status" /><s:param name="Place" value="Place" /><s:param name="Love" value="Love" /></s:url>' style="text-decoration:none;">修改</a></td>
		            <td align="center"><input type="button" name="删除" id="删除" value="删除" onclick="warn('<s:property value="ISBN"/>')" /></td>
		            
		        </tr>
		    </s:iterator>
	    </table>
	</center>
      
  </body>
</html>
