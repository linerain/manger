<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
    <nav class="nav">
		<div class="container nav-top-cont">
			<div class="navbar-header">
			  <a href="#">
				<h1><span class="glyphicon glyphicon-tower" aria-hidden="true"></span>  世尊会员</h1>
			  </a>
	  		</div>
			<div id="navbar-menu">
			    <a href="javascript:toggleMore();" class="btn" id="top-nav-bt"><i class="fa fa-bars" aria-hidden="true"></i></a>
			  	<span id="nav-login-area" style="display: inline-block;">
					<a href="${ctx }/json/loginAction!indexAction.action" class="btn">首页</a>
			  		<span class="split">&nbsp;</span>
					<a  class="btn" id="editPwd" data-toggle="modal" data-target="#editPwdModal">修改密码</a>
					<a  class="btn" id="logout">退出</a>
				</span>
			</div>
		</div>
	</nav>
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
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="save">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	<script type="text/javascript">
	    //修改密码
    	$("#save").click(function(){
    		if($("#oldPassword").val()==""){
    			$("#oldPassword_alert").attr("data-content","原始密码不能为空");
    			$("#oldPassword_alert").popover('show');
    			return;
    		}
    		if($("#oldPassword").val().length>20){
    			$("#oldPassword_alert").attr("data-content","原始密码长度不能超过20");
    			$("#oldPassword_alert").popover('show');
    			return;
    		}
    		if($("#newPassword").val()==""){
    			$("#newPassword_alert").attr("data-content","新密码不能为空");
    			$("#newPassword_alert").popover('show');
    			return;
    		}
    		if($("#newPassword").val().length>20){
    			$("#newPassword_alert").attr("data-content","新密码长度不能超过20");
    			$("#newPassword_alert").popover('show');
    			return;
    		}
    		if($("#relNewPassword").val()==""){
    			$("#relNewPassword_alert").attr("data-content","确认密码不能为空");
    			$("#relNewPassword_alert").popover('show');
    			return;
    		}else{
    			if($("#relNewPassword").val().length>20){
    				$("#relNewPassword_alert").attr("data-content","确认密码长度超过20");
    				$("#relNewPassword_alert").popover('show');
        			return;
    			}else if($("#relNewPassword").val()!=$("#newPassword").val()){
    				$("#relNewPassword_alert").attr("data-content","两次密码不一致");
    				$("#relNewPassword_alert").popover('show');
        			return;
    			}		
    		}
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
    </script>