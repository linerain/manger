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
	<title>世尊会员</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="renderer" content="webkit">
	<meta name="viewport" content="width=device-width, initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no">
    <meta name="applicable-device" content="pc,mobile">
	<link href="${ctx }/css/index.css" rel="stylesheet">
</head>

<body style="background:#f5f5f5;">
    <nav class="nav">
		<div class="container nav-top-cont">
			<div class="navbar-header">
			  <a href="#">
				<h1><span class="glyphicon glyphicon-tower" aria-hidden="true"></span>  世尊会员</h1>
			  </a>
	  		</div>
			<div id="navbar-menu" >
			  	<span id="nav-login-area" style="display: inline-block;">
			  		<span >&nbsp;</span>
					<a  class="btn" id="editPwd" data-toggle="modal" data-target="#editPwdModal">修改密码</a>
					<a  class="btn" id="logout">退出</a>
				</span>
			</div>
		</div>
	</nav>
	<div class="container index-body">
		<div class="row" style="margin-top:20px;">
			<div class="col-offset-1 col-md-12 i-c-g" id="homeContent">
				<div class="jumbotron">
  					<h2><span class="glyphicon glyphicon-user" aria-hidden="true"></span>  ${sessionScope.user.name} </h2>
  					<p><a id="setInfoBut" class="btn btn-primary btn-lg" href="#" role="button" >修改个人信息</a></p>
				</div>
				<div class="row">
  					<div class="col-md-3">
  						<div class="panel panel-info">
  							<div class="panel-heading"><h2>利息</h2></div>
  							<div class="panel-body">
    							<h1>${sessionScope.user.money_one}</h1>
  							</div>
						</div>
  					</div>
  					<div class="col-md-3">
  						<div class="panel panel-success">
  							<div class="panel-heading"><h2>剩余保证金</h2></div>
  							<div class="panel-body">
    							<h1>${sessionScope.user.money_two}</h1>
  							</div>
						</div>
					</div>
  					<div class="col-md-6">
  						<div class="panel panel-primary">
  							<div class="panel-heading">
  							<h2>可提现金
  							<button type="button" id="getMoneyBut" class="btn btn-info ">
  							提现</button>
  							</h2>
  							</div>
  							<div class="panel-body">
    							<h1 id = "can_get_money">${sessionScope.user.canGetMoney}</h1>
  							</div>
						</div>
  					</div>
				</div>
				<div class="row">
				<div class="col-md-12">
  						<div class="panel panel-warning">
  							<div class="panel-heading">提现记录</div>
  								<div class="panel-body">
				<div class="row">
				<div class="col-sm-12" id="tableDiv">
			 		<table id="logList" class="table table-condensed table-hover table-striped" ajax="true">
					    <thead>
					        <tr>
					        	<th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">编号</th>
					            <th data-column-id="money">提现资金（元）</th>
					            <th data-column-id="cardNum">银行卡号</th>
					            <th data-column-id="logTime">时间</th>
					            <th data-column-id="state">状态</th>
					        </tr>
					    </thead>
					</table>
				</div>
				</div>
  			</div>
				</div>
			</div>
			</div>
			</div>
			<!-- end of i-c-g index contract group -->
		</div>
	</div>
    <div class="modal fade" id="editPwdModal" tabindex="-1" role="dialog" aria-labelledby="editPwdLabel" data-backdrop="static" data-keyboard="false">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="editPwdLabel">修改密码</h4>
	      </div>
	      <div class="modal-body">
	        <form id="updPassword_form" class="form-horizontal">
	        	<div class="row">
	        	 <div class="form-group">
				    <label  class="col-sm-3 control-label">原始密码:</label>
				    <div class="col-sm-6">
				      <input type="password" name="oldPassword" id="oldPassword" class="form-control"/>
				    </div>
				    <div class="col-sm-1" id="oldPassword_alert"  data-toggle="popover" data-trigger="focus"></div>
				  </div>
				  <div class="form-group">
				    <label  class="col-sm-3 control-label">新密码:</label>
				    <div class="col-sm-6">
						<input type="password" name="newPassword" id="newPassword" class="form-control" />
				    </div>
				    <div class="col-sm-1" id="newPassword_alert"  data-toggle="popover" data-trigger="focus"></div>
				  </div>
				  <div class="form-group">
				    <label  class="col-sm-3 control-label">确认新密码:</label>
				    <div class="col-sm-6">
						<input type="password" name="relNewPassword"  id="relNewPassword" class="form-control"/>
				    </div>
				    <div class="col-sm-1" id="relNewPassword_alert"  data-toggle="popover" data-trigger="focus"></div>
				  </div>
				</div>
				<input name="module" type="hidden" id="module" />
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="save">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	     <!-- 个人信息 -->
     	<div class="modal fade" id="setInfo" tabindex="-1" role="dialog" aria-labelledby="resetPasswordLabel" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog" role="document">
			  <div class="modal-content">
				  <div class="modal-header" >
				  	<button type='button' class='close' data-dismiss='modal' aria-label='Close' ><span aria-hidden='true'>&times;</span></button>
	       			<h4 class='modal-title' id='resetPasswordLabel'>设置个人信息</h4>
				  </div>
				  <input type="hidden" id = "money_id">
				  <div class="modal-body">
			  			<form id='resetPassword_form' class='form-horizontal' role='form'>
					    	<div class='row'>
							  	  <div class='form-group'>
								    <label  class='col-sm-3 control-label'>银行卡号:</label>
								    <div class='col-sm-5' id='resetPassword_alert'  data-toggle='popover' data-trigger='manual'>
								      <input type='text'  class='form-control' id='info_bank_card' value="${sessionScope.user.bankCard}" />
								    </div>
								  </div>
							</div>
					    	<div class='row'>
							  	  <div class='form-group'>
								    <label  class='col-sm-3 control-label'>开户地址:</label>
								    <div class='col-sm-5' id='resetPassword_alert'  data-toggle='popover' data-trigger='manual'>
								      <input type='text'  class='form-control' id='info_bank_addr' value="${sessionScope.user.bankAddr}" />
								    </div>
								  </div>
							</div>
					    	<div class='row'>
							  	  <div class='form-group'>
								    <label  class='col-sm-3 control-label'>手机号:</label>
								    <div class='col-sm-5' id='resetPassword_alert'  data-toggle='popover' data-trigger='manual'>
								      <input type='text' class='form-control' id='info_phone' value="${sessionScope.user.phone}" />
								    </div>
								  </div>
							</div>
						</form>
				  </div>
				  <div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
					<button type="button" class="btn btn-primary" onclick="toSetInfo()">确定</button>
				  </div>
			 </div>
		</div>
     </div>
     
     <!-- 提现 -->
	 <div class="modal fade" id="getMoneyDiv" tabindex="-1" role="dialog" aria-labelledby="resetPasswordLabel" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog" role="document">
			  <div class="modal-content">
				  <div class="modal-header" >
				  	<button type='button' class='close' data-dismiss='modal' aria-label='Close' ><span aria-hidden='true'>&times;</span></button>
	       			<h4 class='modal-title' id='resetPasswordLabel'>提取现金</h4>
				  </div>
				  <input type="hidden" id = "money_id">
				  <div class="modal-body">
			  			<form id='resetPassword_form' class='form-horizontal' role='form'>
					    	<div class='row'>
							  	  <div class='form-group'>
								    <label  class='col-sm-3 control-label'>金额（500的倍数）:</label>
								    <div class='col-sm-5' id='get_money_alert'  data-toggle='popover' data-trigger='manual'>
								      <input type="text" class='form-control' id='get_money' />
								    </div>
								  </div>
							</div>
						</form>
				  </div>
				  <div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
					<button type="button" class="btn btn-primary" onclick="getMoneyFn()">确定</button>
				  </div>
			 </div>
		</div>
     </div>
	
	
    <script type="text/javascript">
 	var rowIds = [];
	$("#logList").bootgrid({
    	ajax: true,
        post: function (){},
        url: "${ctx}/json/moneyAction!findByPage.action?userId=${sessionScope.user.id}" ,
        selection: true,
        multiSelect: true,
        rowSelect: true,
        rowCount:10,
        navigation:2,
        formatters: {
            "logTime": function(column, row)
            {
            	var dataTime=row.datetime;
                return dataTime.substr(0, 10);
            }
        }
    }).on("selected.rs.jquery.bootgrid", function(e, rows){
        for (var i = 0; i < rows.length; i++){
            rowIds.push(rows[i].id);
        }
    }).on("deselected.rs.jquery.bootgrid", function(e, rows){
    	var newIds = [];
        for (var i = 0; i < rows.length; i++)
        {
            for(var j = 0;j<rowIds.length;j++){
            	if(rows[i].id==rowIds[j]){
            		continue;
            	}
            	newIds.push(rowIds[j]);
            }
        }
        rowIds = newIds;
    }).on("loaded.rs.jquery.bootgrid", function(e, rows){
    	rowIds=[];
    });
	    //修改密码
    	$("#save").click(function(){
    		
    		var key;
    		
    		var module;
    		
    		$.post('${ctx}/json/loginAction!getPubKey.action',function(data){
    			//alert(data.empoent);
    			module=data.module;
    			RSAUtils.setMaxDigits(512);  
    			key = new RSAUtils.getKeyPair(data.empoent, "",data.module);  
    		
    		
    		if($("#oldPassword").val()==""){
    			$("#oldPassword_alert").attr("data-content","原始密码不能为空");
    			$("#oldPassword_alert").popover('show');
    			return;
    		}else if($("#oldPassword").val().length>20){
    			$("#oldPassword_alert").attr("data-content","原始密码长度不能超过20");
    			$("#oldPassword_alert").popover('show');
    			return;
    		}
    		if($("#newPassword").val()==""){
    			$("#newPassword_alert").attr("data-content","新密码不能为空");
    			$("#newPassword_alert").popover('show');
    			return;
    		}else if($("#newPassword").val().length>20){
    			$("#newPassword_alert").attr("data-content","新密码长度不能超过20");
    			$("#newPassword_alert").popover('show');
    			return;
    		}
    		if($("#relNewPassword").val()==""){
    			$("#relNewPassword_alert").attr("data-content","确认密码不能为空");
    			$("#relNewPassword_alert").popover('show');
    			return;
    		}else if($("#relNewPassword").val().length>20){
				$("#relNewPassword_alert").attr("data-content","确认密码长度不能超过20");
				$("#relNewPassword_alert").popover('show');
    			return;
			}else{
    			if($("#relNewPassword").val()!=$("#newPassword").val()){
    				$("#relNewPassword_alert").attr("data-content","两次密码不一致");
    				$("#relNewPassword_alert").popover('show');
        			return;
    			}
    		}
    		
    	 	//加密
    	 	var opwd = $("#oldPassword").val() ;
    	 	var oresult = RSAUtils.encryptedString(key,opwd);  
    	 	$("#oldPassword").val(oresult);
    	 	
    	 	var npwd = $("#newPassword").val() ;
    	 	var nresult = RSAUtils.encryptedString(key,npwd);  
    	 	$("#newPassword").val(nresult);
    	 	
    	 	$("#module").val(module);
    		
    		$.ajax({
				type:"POST",
				url:"${ctx}/json/userAction!updatePwd.action",
				data:$("#updPassword_form").serialize(),
				success:function(data){
					if(data.success==true){
						$("#editPwdModal").modal('hide');
						$.messager.show({title:'提示信息',msg:data.msg});
					}else{
						$("#editPwdModal").modal('hide');
						$.messager.show({title:'提示信息',msg:data.msg});
					}
				}
			});
    	});  
    	});
    	 //清除修改密码框内容
	    $("#editPwd").click(function(){
	    	$("#oldPassword").val("");
	    	$("#newPassword").val("");
	    	$("#relNewPassword").val("");
	    });
	    //取消提示框
	    $("#oldPassword").focus(function(){
			$("#oldPassword_alert").popover('hide');
		});
	    $("#newPassword").focus(function(){
			$("#newPassword_alert").popover('hide');
		});
	    $("#relNewPassword").focus(function(){
			$("#relNewPassword_alert").popover('hide');
		});
	    //退出
    	$("#logout").click(function(){
    		$.confirm({
    		    title: '提示信息!',
    		    content: '确认要退出吗？',
    		    confirm: function(){
    		    	window.top.location.href = "${ctx}/json/loginAction!logout.action";
    		    }
    		    
    		});
    	});
	    
	    //修改个人信息
    
					$("#setInfoBut").click(function() {
						$('#setInfo').modal('show');
					});

					//提交个人信息
					function toSetInfo() {
						$.post('${ctx}/json/userAction!setInfo.action', {
							'bankcard' : $("#info_bank_card").val(),
							'bankaddr' : $("#info_bank_addr").val(),
							'phone' : $("#info_phone").val()
						}, function(data) {
							$('#setInfo').modal('hide');
							if (data.success == true) {
								$.messager.show({
									title : '提示信息',
									msg : data.msg
								});
							} else {
								$.messager.show({
									title : '提示信息',
									msg : data.msg
								});
							}
						});
					}
				//提现
				
				var all_money = "${sessionScope.user.canGetMoney}";
				
				
					$("#getMoneyBut").click(function() {
						
						$.post('${ctx}/json/userAction!checkState.action', {
						}, function(data) {
							if (data.success == false) {
								window.wxc.xcConfirm("目前不能提现", window.wxc.xcConfirm.typeEnum.info);
							}else{
						$("#get_money_alert").popover('hide');
						$('#getMoneyDiv').modal('show');
								
							}
							});
					});
				
					function getMoneyFn() {
						
						var money_val = $("#get_money").val();
						
						$.post('${ctx}/json/userAction!checkMoney.action', {
							money_value:money_val
						}, function(data) {
							if (data.success == false) {
								$("#get_money_alert").attr("data-content","资金不足");
								$("#get_money_alert").popover('show');
								return;
							}
								
						else if(money_val%500==0&&money_val>0){
							$('#getMoneyDiv').modal('hide');
						$.post('${ctx}/json/userAction!getMoney.action', {
							'money_val' : money_val
						}, function(data) {
							if (data.success == true) {
								 $("#logList").bootgrid("reload");
								$("#can_get_money").html(data.money_now);
								all_money = data.money_now;
								$.messager.show({
									title : '提示信息',
									msg : data.msg
								});
							} else {
								$.messager.show({
									title : '提示信息',
									msg : data.msg
								});
							}
						});
							
						}else{
							
							$("#get_money_alert").attr("data-content","输入格式错误");
							$("#get_money_alert").popover('show');
							
						}
						
							
							});
						
						
						
					}
				
		</script>
</body>
</html>