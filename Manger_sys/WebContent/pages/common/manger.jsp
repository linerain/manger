<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />	
<%@ include file="/pages/common/headjsp.jsp"%>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="utf-8">
	<title>世尊会员管理系统</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="renderer" content="webkit">
	<meta name="viewport" content="width=device-width, initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
    <meta name="applicable-device" content="pc,mobile">
	<link href="${ctx }/css/index.css" rel="stylesheet">
</head>

<body style="background:#f5f5f5;">
      <%@ include file="/pages/common/header.jsp"%>
      <div class="container-fluid index-body">
		<div class="row depot-outer">
			<div class="col-xs-2 col-sm-2  depot-list-outer">
				<ul class="row depot-list-left" id="leftMenu">
					<li ><a href='javascript:void(0);' class='depot-list money' onClick='showPage("${ctx }/json/moneyAction!moneyLogAction.action","money")'><h2><span class='glyphicon glyphicon-usd' ></span>  提现管理</h2></a></li>
 					<li ><a href='javascript:void(0);' class='depot-list user' onClick='showPage("${ctx }/json/userAction!userAction.action","user")'><h2><span class='glyphicon glyphicon-user' ></span>  用户管理</h2></a></li>
 					<li ><a href='javascript:void(0);' class='depot-list log' onClick='showPage("${ctx }/json/systemLogAction!systemLogAction.action","log")'><h2><span class='glyphicon glyphicon-info-sign' ></span>  系统日志</h2></a></li>
				</ul>
			</div>
			<div class="col-xs-10 col-sm-10  dl-cont-outer">
				<div class="row">
					<div class="col-sm-12 col-xs-12" id="rightContent">
					
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
    <script type="text/javascript">
	    //根菜单
/*     	var childrens =${childrens}; 
    	var childrenId="${childrenId}";
    	var childrenHtml="";
    	for(var i=0;i<childrens.length;i++){
    		if(childrenId!="" && childrenId!=null && childrenId==childrens[i].id){
    			childrenHtml+="<li><a href='javascript:void(0);' onClick='showPage(\""+childrens[i].address+"\",\""+childrens[i].describe+"\")' class='depot-list "+childrens[i].describe+" sel' id='"+childrens[i].id+"'><h2>"+childrens[i].name+"</h2></a></li>";
    			showPage(childrens[i].address,childrens[i].describe);
    		}else if((childrenId=="" || childrenId==null) && i==0){
    			childrenHtml+="<li><a href='javascript:void(0);' onClick='showPage(\""+childrens[i].address+"\",\""+childrens[i].describe+"\")' class='depot-list "+childrens[i].describe+" sel'><h2>"+childrens[i].name+"</h2></a></li>";
    			showPage(childrens[0].address,childrens[0].describe);
    		}else if(childrenId!=childrens[i].id  || i!=0){
    			childrenHtml+="<li><a href='javascript:void(0);' onClick='showPage(\""+childrens[i].address+"\",\""+childrens[i].describe+"\")' class='depot-list "+childrens[i].describe+"'><h2>"+childrens[i].name+"</h2></a></li>";
    		}
    	}
    	$("#leftMenu").html(childrenHtml); */
    	showPage("${ctx }/json/moneyAction!moneyLogAction.action","money");
    	
	    function showPage(address,describe){
	    	$(".depot-list").removeClass("sel");
	    	$("."+describe).addClass("sel");
	    	$("#rightContent").load("${ctx}"+address);
	    }
    </script>
</body>
</html>