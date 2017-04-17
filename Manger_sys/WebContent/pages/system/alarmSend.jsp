<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />	
<!DOCTYPE HTML>
<html>
  <style>
    .title{font-size: 24px;color: #333;margin-bottom: 16px;}
  </style>
  <body>
  	<div class="container-fluid">
  		<div class="row">
  			<div class="col-sm-6">
  				<div class='col-sm-10 col-sm-offset-2'>
					<p class="title">邮件告警发件箱设置</p>
				</div>
			 	<form id='email_form' class='form-horizontal'>
				    	<div class='row'>
					  	     <div class='form-group'>
							    <label  class='col-sm-4 control-label'>邮箱地址*:</label>
							    <div class='col-sm-5' id='emailaddress_alert'  data-toggle='popover' data-trigger='manual'>
							      <input type='text' name='email.emailaddress'  class='form-control' id='emailaddress'/>
							    </div>
							  </div>
					  	     <div class='form-group'>
							    <label  class='col-sm-4 control-label'>账号名称*:</label>
							    <div class='col-sm-5' id='name_alert'  data-toggle='popover' data-trigger='manual'>
							      <input type='text' name='email.name'  class='form-control' id='name'/>
							    </div>
							  </div>
					  	     <div class='form-group'>
							    <label  class='col-sm-4 control-label'>邮箱密码*:</label>
							    <div class='col-sm-5' id='password_alert'  data-toggle='popover' data-trigger='manual'>
							      <input type='password' name='email.password'  class='form-control' id='password'/>
							    </div>
							 </div>
					  	     <div class='form-group'>
							    <label  class='col-sm-4 control-label'>发件服务器*:</label>
							    <div class='col-sm-5' id='host_alert'  data-toggle='popover' data-trigger='manual'>
							      <input type='text' name='email.host'  class='form-control' id='host' placeholder='smtp.sohu.com'/>
							    </div>
							 </div>
							 <div class='form-group'>
							    <label  class='col-sm-4 control-label'>端口*:</label>
							    <div class='col-sm-5' id='port_alert'  data-toggle='popover' data-trigger='manual'>
							      <input type='text' name='email.port'  class='form-control' id='port' value='25'/>
							    </div>
							 </div>
							 <div  class='form-group'>
							    <div class='col-sm-offset-2 col-sm-6'>
							    	<input type='checkbox' name='email.validates' id='validate' value='true' >身份验证&nbsp;&nbsp;&nbsp;
							    	<input type='checkbox' name='email.validateSSL' id='validateSSL' value='true' >SSL验证
							    </div>
							 </div>
							 <div  class='form-group'>
							 	<div class='col-sm-2 col-sm-offset-2'>
							 	 <a type="button" class="btn btn-success  btn-block" id="saveEmail">保存</a>
							 	</div>
							 	<div class='col-sm-2'>
							 	  <a type="button" class="btn btn-success  btn-block" id="testButton">测试</a>
							 	</div>
							 	<div class='col-sm-2'>
							 	  <a type="button" class="btn btn-default  btn-block" id="eamilRemove">移除</a>
							 	</div>
							 </div>
						</div>
					</form>
  			</div>
  			<!-- <div class="col-sm-6">
  				<div class='col-sm-8 col-sm-offset-4'>
					<p class="title">短信猫设置</p>
				</div>
  				<form id='phone_form' class='form-horizontal'>
					<div class='row'>
			  	      <div class='form-group'>
					    <label  class='col-sm-4 control-label'>是否在线:</label>
					    <div class='col-sm-6'>
					      <input type='text'   class='form-control' id='onLine' disabled="disabled"/>
					    </div>
					  </div>
					  <div class='form-group'>
					    <label  class='col-sm-4 control-label'>端口:</label>
					    <div class='col-sm-6'>
					      <input type='text'   class='form-control' id='portName' disabled="disabled"/>
					    </div>
					  </div>
					  <div class='form-group'>
					    <label  class='col-sm-4 control-label'>波特率:</label>
					    <div class='col-sm-6'>
					      <input type='text'   class='form-control' id='baud' disabled="disabled"/>
					    </div>
					  </div>
					  <div class='form-group' style="margin-top: 46px;">
					  	<h4 class='col-sm-5 col-sm-offset-1'>短信猫在线测试:</h4>
					  </div>
					  <div class='form-group'>
					    <label  class='col-sm-4 control-label'>测试收信手机号*:</label>
					    <div class='col-sm-6' id='phone_alert'  data-toggle='popover' data-trigger='manual'>
					      <input type='text'  name="phone" class='form-control' id='phone' />
					    </div>
					  </div>
		  	 		  <div  class='form-group'>
					 	<div class='col-sm-3 col-sm-offset-1'>
					 	 <a type="button" class="btn btn-success  btn-block" id="test">短信接收测试</a>
					 	</div>
					 	<div class='col-sm-4'>
					 	  <a type="button" class="btn btn-success  btn-block" id="tryAgain">重新搜索短信猫</a>
					 	</div>
					 	<div class='col-sm-3'>
					 	  <a type="button" class="btn btn-default  btn-block" id="phoneRemove">移除短信猫</a>
					 	</div>
					  </div>
					</div>
  				</form>
  			</div> -->
  		</div>
  	</div>
	<script type="text/javascript">
		//邮件的回显
		$.post("${ctx}/json/emailAction!showEmail.action",function(data){
			if(data.success){
				$("#emailaddress").val(data.email.emailaddress);
				$("#name").val(data.email.name);
				$("#password").val(data.email.password);
				$("#host").val(data.email.host);
				$("#port").val(data.email.port);
				if(data.email.validates!="" && data.email.validates=="1"){
					$("#validate").attr("checked","checked");
				}else{
					$("#validate").removeAttr("checked");
				}
				if(data.email.validateSSL!="" && data.email.validateSSL=="1"){
					$("#validateSSL").attr("checked","checked");
				}else{
					$("#validateSSL").removeAttr("checked");
				}
			}
		});
		//短信猫回显
		$.post("${ctx}/json/smsAction!checkState.action",function(data){
			if(data.success){
				$("#onLine").val("在线");
				$("#portName").val(data.smsModel.comPort);
				$("#baud").val(data.smsModel.baud);
				$("#test").removeAttr("disabled");
			}else{
				$("#onLine").val("离线");
				$("#portName").val("");
				$("#baud").val("");
				$("#test").attr("disabled","disabled");
			}
		});
		$('#emailaddress').focus(function(){
			$('#emailaddress_alert').popover('hide');
		});
	    $('#name').focus(function(){
			$('#name_alert').popover('hide');
		});
	    $('#password').focus(function(){
			$('#password_alert').popover('hide');
		});
	    $('#host').focus(function(){
			$('#host_alert').popover('hide');
		});
	    $('#phone').focus(function(){
			$('#phone_alert').popover('hide');
		});
		//保存修改
		$("#saveEmail").click(function(){
			var checkSubmitFlg=false;
			var emailaddress=$("#emailaddress").val();
			var name=$("#name").val();
			var password=$("#password").val();
			var host=$("#host").val();
			if(emailaddress==""){
				$("#emailaddress_alert").attr("data-content","邮箱地址不能为空");
				$("#emailaddress_alert").popover('show');
				return;
			}else{
				if(!/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(emailaddress) && emailaddress!=""){
					$("#emailaddress_alert").attr("data-content","邮箱格式不正确");
					$("#emailaddress_alert").popover('show');
					return;
				}
			}
			if(name==""){
				$("#name_alert").attr("data-content","名称不能为空");
				$("#name_alert").popover('show');
				return;
			}
			if(password==""){
				$("#password_alert").attr("data-content","邮箱密码不能为空");
				$("#password_alert").popover('show');
				return;
			}else{
				if($.trim(password).length<=8 && $.trim(password).length>=32){
					$("#password_alert").attr("data-content","邮箱密码应为8-30位");
					$("#password_alert").popover('show');
					return;
				}
			}
			if(host==""){
				$("#host_alert").attr("data-content","服务器地址不能为空");
				$("#host_alert").popover('show');
				return;
			}
			if(checkSubmitFlg ==true){ 
				return false;
			}else{
				$.ajax({
					type:"POST",
					url:"${ctx}/json/emailAction!save.action",
					data:$("#email_form").serialize(),
					success:function(data){
						if(data.success==true){
							parent.$.messager.show({title:'提示信息',msg:data.msg});
							$("#emailaddress").val(data.email.emailaddress);
							$("#name").val(data.email.name);
							$("#password").val(data.email.password);
							$("#host").val(data.email.host);
							$("#port").val(data.email.port);
							if(data.email.validate!="" && data.email.validate=="1"){
								$("#validate").attr("checked","checked");
							}else{
								$("#validate").removeAttr("checked");
							}
							if(data.email.validateSSL!="" && data.email.validateSSL=="1"){
								$("#validateSSL").attr("checked","checked");
							}else{
								$("#validateSSL").removeAttr("checked");
							}
						}else{
							parent.$.messager.show({title:'提示信息',msg:data.msg});
						}
					}
				});
				checkSubmitFlg=true;
			} 
		});
		//测试发送
		$("#testButton").click(function(){
			var email=$("#emailaddress").val();
			$.post('${ctx}/json/emailAction!testEmail.action',{'emailaddress':email},function(data){
				 if(data.success==true){
					 parent.$.messager.show({title:'提示信息',msg:data.msg});
				 }else{
					 parent.$.messager.show({title:'提示信息',msg:data.msg});
				 } 
			});
		});
		//短信猫的重新搜索
		$("#tryAgain").click(function(){
			$.post('${ctx}/json/smsAction!initMsg.action',function(data){
				if(data.success){
					$("#onLine").val("在线");
					$("#portName").val(data.smsModel.comPort);
					$("#baud").val(data.smsModel.baud);
					$("#test").removeAttr("disabled");
					parent.$.messager.show({title:'提示信息',msg:data.msg});
				}else{
					$("#onLine").val("离线");
					$("#portName").val("");
					$("#baud").val("");
					$("#test").attr("disabled","disabled");
					parent.$.messager.show({title:'提示信息',msg:data.msg});
				}
			});
		});
		//短信发送测试
		$("#test").click(function(){
			var  phone=$("#phone").val();
			if(phone=="" || phone==null){
				$("#phone_alert").attr("data-content","请填写手机号");
				$("#phone_alert").popover('show');
				return;
			}else{
				if(!/^(13|15|18|17)\d{9}$/i.test(phone) && phone!=""){
					$("#phone_alert").attr("data-content","手机格式不正确");
					$("#phone_alert").popover('show');
					return;
				}
			}
			$.post('${ctx}/json/smsAction!testMsg.action',{'phone':$("#phone").val()},function(data){
				if(data.success){
					parent.$.messager.show({title:'提示信息',msg:data.msg});
				}else{
					parent.$.messager.show({title:'提示信息',msg:data.msg});
				}
			});
		});
		
		//短信猫移除  
		$("#phoneRemove").click(function(){
			$.post('${ctx}/json/smsAction!stopMsg.action',function(data){
				if(data.success){
					$("#onLine").val("离线");
					$("#portName").val("");
					$("#baud").val("");
					$("#test").attr("disabled","disabled");
					parent.$.messager.show({title:'提示信息',msg:data.msg});
				}else{
					parent.$.messager.show({title:'提示信息',msg:data.msg});
				}
			});
		});
		
		//邮件移除
		$("#eamilRemove").click(function(){
			$.post('${ctx}/json/emailAction!delete.action',function(data){
				if(data.success){
					$("#emailaddress").val("");
					$("#name").val("");
					$("#password").val("");
					$("#host").val("");
					$("#port").val("25");
					$("#validate").removeAttr("checked");
					$("#validateSSL").removeAttr("checked");
					parent.$.messager.show({title:'提示信息',msg:data.msg});
				}else{
					parent.$.messager.show({title:'提示信息',msg:data.msg});
				}
			});
		});
	</script>
  </body>
</html>