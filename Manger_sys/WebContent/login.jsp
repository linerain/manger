<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="/pages/common/headjsp.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>世尊会员</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="X-UA-Compatible" content="IE=edge">
		<link href="${ctx }/css/login.css" rel="stylesheet" type="text/css" />
		<script src="${ctx }/js/rsa/security.js" type="text/javascript"></script>
		<link rel="icon" href="${ctx }/favicon.ico">
		<script type="text/javascript">
			$.post('${ctx}/json/loginAction!getPubKey.action',function(data){
				module=data.module;
				RSAUtils.setMaxDigits(512);  
				key = new RSAUtils.getKeyPair(data.empoent, "",data.module);  
			});
			if("${user}"=="noSession"){
			  window.parent.location.href="${ctx}/login.jsp";
			}
		</script>
	</head>
	<body class="loginBody">
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-xs-12 containerBody">
					<div class="row">
						<div class="col-md-5 col-xs-12 col-md-offset-1">
							<div class="jumbotron" style="background-color: transparent">
  								<h1><span class='glyphicon glyphicon-tower' ></span>  世尊会员</h1>
							</div>
						</div>
						<div class="col-md-4 col-xs-12  col-md-offset-1">
							<div class="row">
								<div class="col-md-12 col-xs-12 loginDiv">
									<div class="row">
										<p class="col-md-12 col-xs-12 title">用户登录</p>
										<form action="${ctx}/json/loginAction!login.action" method="post" class="form-horizontal loginForm" role="form">
											<c:if test="${request.msg !=null || !empty request.msg}">
												<div class="col-sm-10 col-xs-10 col-md-offset-1 col-xs-offset-1" style="margin-bottom:18px">
													<span id="errorInfo" style="color:red">${request.msg }</span>
												</div>
											</c:if>
											<div class="col-sm-10 col-xs-10 col-md-offset-1 col-xs-offset-1">
										      <input type="text" name="account" class="form-control loginuser" id="username" placeholder="请输入账号" autofocus="autofocus" autocomplete="off">
										    </div>
											<div class="col-sm-10 col-xs-10 col-md-offset-1 col-xs-offset-1">
										      <input type="password" name="password" class="form-control loginpwd" id="password" autocomplete="off" placeholder="请输入密码">
										    </div>
											<div class="col-sm-9 col-xs-9 col-md-offset-2 col-xs-offset-2">
												<input type="submit" class="btn loginbtn" value="登录" onclick="return check(this.form)" />
										    </div>
										    <input name="module" type="hidden" id="module" />
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			var key;
			var module;
			function check(form) {
			    if(form.account.value=='') {
			          form.username.focus();
			          $("#username").removeAttr("placeholder");
			          $("#username").attr("placeholder","账号不能为空");
			          return false;
			     }
			    if(form.account.value.length>20) {
			          form.username.focus();
			          $("#username").removeAttr("placeholder");
			          $("#username").attr("placeholder","账号长度不能超过20");
			          return false;
			     }
			 	if(form.password.value==''){
			          form.password.focus();
			          $("#password").removeAttr("placeholder");
			          $("#password").attr("placeholder","密码不能为空");
			          return false;
			   }
			 	if(form.password.value.length>20){
			          form.password.focus();
			          $("#password").removeAttr("placeholder");
			          $("#password").attr("placeholder","密码长度不能超过20");
			          return false;
			   }
			 	//加密
			 	var pwd = form.password.value ;
			 	var result = RSAUtils.encryptedString(key,pwd);  
			 	form.password.value = result;
			 	form.module.value = module;
			 	
			   return true;
			}
		</script>
	</body>
</html>