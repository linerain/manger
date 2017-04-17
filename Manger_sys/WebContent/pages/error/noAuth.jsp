<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML>
<html>
  <head>
    <title>IT资产管理系统无权限</title>
	<meta name="pragma" content="no-cache">
	<meta name="cache-control" content="no-cache">
	<meta name="expires" content="0">    
	<meta name="keywords" content="keyword1,keyword2,keyword3">
	<meta name="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
	function countDown(secs,surl)
	{               
	  var jumpTo = document.getElementById('jumpTo');    
	  jumpTo.innerHTML=secs;      
	  if(--secs>0)
	  {         
	    setTimeout("countDown("+secs+",'"+surl+"')",1000);         
	  }
	  else
	  {           
	     location.href=surl;       
	  }         
	 } 
	</script>
  </head>
  
  <body>
  		<h3>你没有权限访问，请使用管理员账号登录，将在<span id="jumpTo">5</span>秒钟跳到登录页面</h3>
    <script type="text/javascript">countDown(5,'${ctx}/login.jsp');</script>  
  </body>
</html>
