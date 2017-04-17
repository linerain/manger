<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />	
<!DOCTYPE HTML>
<html>
  <style>
  	#button_div .btn{margin-right: 6px;}
  	#arreaPanel {border-bottom:0;border-bottom-color: #fff;height:60%;}
  	#arreaPanel .panel-heading {padding: 4px 15px;}
  	#arreaTitle{margin-left: 0;}
  	#arreaPanel{display:none;}
  	#setTreeList{margin-top:18px;}
  	/* 数据列表 */
	.text-left {text-align: left;font-size: 14px;}
	.bootgrid-table th>.column-header-anchor>.text {display: block;margin: 0 16px 0 0;
    overflow: hidden;-ms-text-overflow: ellipsis;-o-text-overflow: ellipsis;
    text-overflow: ellipsis; white-space: nowrap; font-size: 14px;}
  </style>
  <script type="text/javascript" src="${ctx }/js/bootstrap-slider.js"></script>
  <link href="${ctx }/css/bootstrap-slider.css" rel="stylesheet">
  <body>
  	<div class="container-fluid">
  		<div class="row">
  			<div class="col-sm-12" id="tableDiv">
			 		<table id="userList" class="table table-condensed table-hover table-striped" ajax="true">
					    <thead>
					        <tr>
					        	<th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">编号</th>
					            <th data-column-id="account">用户账号</th>
					            <th data-column-id="name">用户姓名</th>
					            <th data-column-id="phone">手机号</th>
					            <th data-column-id="admin">用户类型</th>
					            <th data-column-id="canGetMoney">可提现资金</th>
					        </tr>
					    </thead>
					</table>
  			</div>
	  		<div class="col-sm-3">
	  			<div class="panel panel-info" id="arreaPanel">
			      <div class="panel-heading">
	      				<h3 class="panel-title" id="panel-title">地域权限设置</h3>
			      </div>
			      <div class="panel-body">
			      	<div class="container-fluid">
			      		<div class="row">
			      			 <div class="col-sm-7">
			      			 	<h3 class="panel-title" id="arreaTitle"></h3>
			      			 </div>
			      			 <div class="col-sm-2">
						      	<button id='savearrea' type='button' class='btn btn-success'>
							 		 <span class='glyphicon glyphicon-floppy-saved' aria-hidden='true'></span>&nbsp;保存
							 	</button>
			      			</div>
			      		</div>
			      	</div>
			        <ul id="setTreeList" class="ztree" style="width: 80%" ></ul>
			      </div>
			   </div>
	  		</div>
  		</div>
  	</div>
	<!-- 添加和修改模态框 -->
	<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog" role="document">
		      <div class="modal-content">
			      <div class="modal-header">
			      	<button type='button' class='close' data-dismiss='modal' aria-label='Close' ><span aria-hidden='true'>&times;</span></button>
	       			<h4 class='modal-title' id='myModalLabel'>添加/修改用户信息</h4>
			      </div>
			      <div class="modal-body">
			      	<form id='user_form' class='form-horizontal' role='form'>
					    	<div class='row'>
					    	
							  	  <div class='form-group'>
								    <label  class='col-sm-3 control-label'>账号类型*:</label>
								    <div class='col-sm-5' id='account_alert'  data-toggle='popover' data-trigger='manual'>
										<div class="btn-group" role="group" aria-label="...">
  											<button type="button" id = "costomer" class="btn btn-default" >客户</button>
 											<button type="button" id = "manger" class="btn btn-default" >管理员</button>
								  		</div>
								  	</div>
								  	</div>
							  	  <div class='form-group'>
								    <label  class='col-sm-3 control-label'>用户账号*:</label>
								    <div class='col-sm-5' id='account_alert'  data-toggle='popover' data-trigger='manual'>
								      <input type='text' name='user.account'  class='form-control' id='account'/>
								    </div>
								  </div>
								  <div class='form-group'>
								    <label  class='col-sm-3 control-label'>用户姓名*:</label>
								    <div class='col-sm-5' id='name_alert'  data-toggle='popover' data-trigger='manual'>
										<input type='text' name='user.name'  class='form-control' id='name'/>
								    </div>
								  </div>
								  <div class='form-group' id='passwordDiv'>
								    <label  class='col-sm-3 control-label'>密码*:</label>
								    <div class='col-sm-5' id='password_alert'  data-toggle='popover' data-trigger='manual'>
										<input type='password' name='user.password'  class='form-control' id='password'/>
								    </div>
								  </div>
								  <div class='form-group' id='rePasswordDiv'>
								    <label  class='col-sm-3 control-label'>确认密码*:</label>
								    <div class='col-sm-5' id='rePassword_alert'  data-toggle='popover' data-trigger='manual'>
										<input type='password'   class='form-control' id='rePassword'/>
								    </div>
								  </div>
								  <div class='form-group' id="phone_arr" >
								    <label  class='col-sm-3 control-label'>手机号:</label>
								    <div class='col-sm-5' id='phone_alert'  data-toggle='popover' data-trigger='manual'>
										<input type='text'  name='user.phone' class='form-control' id='phone'/>
								    </div>
								  </div>
								  <div class='form-group' id="idcard_arr">
								    <label  class='col-sm-3 control-label'>身份证号:</label>
								    <div class='col-sm-5' id='email_alert'  data-toggle='popover' data-trigger='manual'>
										<input type='text'  name='user.idCard' class='form-control' id='idcard'/>
								    </div>
								  </div>
								  <div class='form-group' id="bankcard_arr">
								    <label  class='col-sm-3 control-label'>银行卡号:</label>
								    <div class='col-sm-5' id='email_alert'  data-toggle='popover' data-trigger='manual'>
										<input type='text'  name='user.bankCard' class='form-control' id='bankcard'/>
								    </div>
								  </div>
								  <div class='form-group' id="bankaddr_arr">
								    <label  class='col-sm-3 control-label'>开户地址:</label>
								    <div class='col-sm-5' id='email_alert'  data-toggle='popover' data-trigger='manual'>
										<input type='text'  name='user.bankAddr' class='form-control' id='bankaddr'/>
								    </div>
								  </div>
								 </div>
							<input name="module" type="hidden" id="module" />
						</form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
			        <button type="submit" class="btn btn-primary" onclick="save()">保存</button>
			      </div>
		     </div>
		</div> 
	</div>
	<!-- 重置密码 -->
	<div class="modal fade" id="resetPasswordModal" tabindex="-1" role="dialog" aria-labelledby="resetPasswordLabel" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog" role="document">
			  <div class="modal-content">
				  <div class="modal-header" >
				  	<button type='button' class='close' data-dismiss='modal' aria-label='Close' ><span aria-hidden='true'>&times;</span></button>
	       			<h4 class='modal-title' id='resetPasswordLabel'>重置密码</h4>
				  </div>
				  <div class="modal-body">
			  			<form id='resetPassword_form' class='form-horizontal' role='form'>
					    	<div class='row'>
							  	  <div class='form-group'>
								    <label  class='col-sm-3 control-label'>新密码*:</label>
								    <div class='col-sm-5' id='resetPassword_alert'  data-toggle='popover' data-trigger='manual'>
								      <input type='password' name='password'  class='form-control' id='newResetPassword'/>
								    </div>
								  </div>
							</div>
						</form>
				  </div>
				  <div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
					<button type="button" class="btn btn-primary" onclick="savePassword()">确定</button>
				  </div>
			 </div>
		</div>
     </div>
     <!-- 设置资金 -->
     	<div class="modal fade" id="setMoneyModal" tabindex="-1" role="dialog" aria-labelledby="resetPasswordLabel" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog" role="document">
			  <div class="modal-content">
				  <div class="modal-header" >
				  	<button type='button' class='close' data-dismiss='modal' aria-label='Close' ><span aria-hidden='true'>&times;</span></button>
	       			<h4 class='modal-title' id='resetPasswordLabel'>设置资金</h4>
				  </div>
				  <input type="hidden" id = "money_id">
				  <div class="modal-body">
			  			<form id='resetPassword_form' class='form-horizontal' role='form'>
					    	<div class='row'>
							  	  <div class='form-group'>
								    <label  class='col-sm-3 control-label'>*利息:</label>
								    <div class='col-sm-5' id='resetPassword_alert'  data-toggle='popover' data-trigger='manual'>
								      <input type='number' name='money_1'  class='form-control' id='money_1'/>
								    </div>
								  </div>
							</div>
					    	<div class='row'>
							  	  <div class='form-group'>
								    <label  class='col-sm-3 control-label'>*剩余保证金:</label>
								    <div class='col-sm-5' id='resetPassword_alert'  data-toggle='popover' data-trigger='manual'>
								      <input type='number' name='money_2'  class='form-control' id='money_2'/>
								    </div>
								  </div>
							</div>
					    	<div class='row'>
							  	  <div class='form-group'>
								    <label  class='col-sm-3 control-label'>*可提现金:</label>
								    <div class='col-sm-5' id='resetPassword_alert'  data-toggle='popover' data-trigger='manual'>
								      <input type='number' name='money_get'  class='form-control' id='money_get'/>
								    </div>
								  </div>
							</div>
						</form>
				  </div>
				  <div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
					<button type="button" class="btn btn-primary" onclick="saveMoneySet()">确定</button>
				  </div>
			 </div>
		</div>
     </div>
	<script type="text/javascript">
	 	var rowIds = [];
	 	var name;
		$("#userList").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/userAction!findUsersByPage.action",
	        selection: true,
	        multiSelect: true,
	        rowSelect: true,
	        rowCount:[8,10,20,25]
	    }).on("selected.rs.jquery.bootgrid", function(e, rows){
	        for (var i = 0; i < rows.length; i++){
	            rowIds.push(rows[i].id);
	            name=rows[i].name;
	        }
	    }).on("deselected.rs.jquery.bootgrid", function(e, rows){
	    	$("#tableDiv").attr("class","col-sm-12");
			$("#arreaPanel").hide();
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
	        name="";
	    }).on("loaded.rs.jquery.bootgrid", function(e, rows){
	    	rowIds=[];
	    });
		//添加按钮
		var html="<div class='col-sm-6' id='button_div'>"+
				    "<a id='saveButton'  class='a-btn btn-success' >"+
						 "<span class='glyphicon glyphicon-plus' ></span>"+
						 "<span class='a-btn-slide-text'>添加用户</span>"+
					"</a>"+
					"<a id='updateButton'  class='a-btn btn-info' >"+
						 "<span class='glyphicon glyphicon-pencil' ></span>"+
						 "<span class='a-btn-slide-text'>修改用户</span>"+
					"</a>"+
					"<a id='setMoneyButton'  class='a-btn btn-info'>"+
			     	 	"<span class='glyphicon glyphicon-usd' ></span>"+
			     	 	"<span class='a-btn-slide-text'>资金设置</span>"+
			        "</a>"+
			        "<s:if test='#session.isAdmin'>"+
						"<a id='resetPassword'  class='a-btn btn-info'>"+
				     	 	"<span class='glyphicon glyphicon-lock' ></span>"+
				     	 	"<span class='a-btn-slide-text'>重置密码</span>"+
				        "</a>"+
				    "</s:if>"+
				    "<a id='delButton'  class='a-btn btn-default active'>"+
				     	"<span class='glyphicon glyphicon-trash'></span>"+
				    	"<span class='a-btn-slide-text'>删除用户</span>"+
				    "</a>"+
				"</div>";
		$("#headerRow").before(html);
		
		function onBodyDown(event){
			if(!(event.target.id == 'parent' || event.target.id == 'menuContent' || $(event.target).parents('#menuContent').length>0)){
				$('#menuContent').hide();
			}
		}
		$('#account').focus(function(){
			$('#account_alert').popover('hide');
		});
		$('#name').focus(function(){
			$('#name_alert').popover('hide');
		});
		$('#password').focus(function(){
			$('#password_alert').popover('hide'); 
		});
		$('#rePassword').focus(function(){
			$('#rePassword_alert').popover('hide');
		});
		$('#parent').focus(function(){
			$('#department_alert').popover('hide'); 
		});
		$('#roles').focus(function(){
			$('#roles_alert').popover('hide');
		});
		$('#phone').focus(function(){
			$('#phone_alert').popover('hide');
		});
		$('#email').focus(function(){
			$('#email_alert').popover('hide');
		});
		//添加
		var checkSubmitFlg=false;
		var state="添加";
		var usertype = "costomer";
		$("#manger").click(function(){
			$("#manger").removeClass("btn-default");
			$("#manger").addClass("btn-primary");
			
			$("#costomer").removeClass("btn-primary");
			$("#costomer").addClass("btn-default");
			
			$("#phone_arr").hide();
			$("#idcard_arr").hide();
			$("#bankcard_arr").hide();
			$("#bankaddr_arr").hide();
			
			usertype = "manger";
		});
		$("#costomer").click(function(){
			$("#costomer").removeClass("btn-default");
			$("#costomer").addClass("btn-primary");
			
			$("#manger").removeClass("btn-primary");
			$("#manger").addClass("btn-default");
			
			$("#phone_arr").show();
			$("#idcard_arr").show();
			$("#bankcard_arr").show();
			$("#bankaddr_arr").show();
			
			usertype = "costomer";
		});
		
		$("#saveButton").click(function(){
			state="添加";
			usertype = "costomer";
			$("#manger").show();
			$("#costomer").show();
			$("#phone_arr").show();
			$("#idcard_arr").show();
			$("#bankcard_arr").show();
			$("#bankaddr_arr").show();
			//rowIds=[];
			checkSubmitFlg=false;
			$("[id$=_alert]").popover('hide');
			
			$("#costomer").removeClass("btn-default");
			$("#costomer").addClass("btn-primary");
			
			$("#manger").removeClass("btn-primary");
			$("#manger").addClass("btn-default");
			
			$("#name").val("");
			$("#account").val("");
			$("#password").val("");
			$("#rePassword").val("");
			$("#phone").val("");
			$("#idcard").val("");
			$("#bankcard").val("");
			$("#bankaddr").val("");
			
			$("#passwordDiv").show();
			$("#rePasswordDiv").show();
			$("#account").removeAttr("readonly");
			
			$('#infoModal').modal('show');
		});
		
		//修改回显
		$("#updateButton").click(function(){
			state="修改";
			$("#account_alert").popover('hide');
			$("#name_alert").popover('hide');
			$("#rePassword_alert").popover('hide'); 
			$("#password_alert").popover('hide');
			$("#phone_alert").popover('hide');
			
			$("#passwordDiv").hide();
			$("#rePasswordDiv").hide();
			$("#account").attr("readonly", "readonly");
			if(rowIds.length==1){
				$.post('${ctx}/json/userAction!getUserInfo.action',{id:rowIds[0]},function(data){
					$("#account").val(data.user.account);
					$("#name").val(data.user.name);
					$("#phone").val(data.user.phone);
					$("#idcard").val(data.user.idCard);
					$("#bankcard").val(data.user.bankCard);
					$("#bankaddr").val(data.user.bankAddr);
					if(data.user.admin){
						$("#manger").show();
						$("#costomer").hide();
						
						$("#manger").removeClass("btn-default");
						$("#manger").addClass("btn-primary");
						
						$("#costomer").removeClass("btn-primary");
						$("#costomer").addClass("btn-default");
						
						$("#phone_arr").hide();
						$("#idcard_arr").hide();
						$("#bankcard_arr").hide();
						$("#bankaddr_arr").hide();
						
						usertype = "manger";
					}else{
						$("#manger").hide();
						$("#costomer").show();
						
						$("#costomer").removeClass("btn-default");
						$("#costomer").addClass("btn-primary");
						
						$("#manger").removeClass("btn-primary");
						$("#manger").addClass("btn-default");
						
						$("#phone_arr").show();
						$("#idcard_arr").show();
						$("#bankcard_arr").show();
						$("#bankaddr_arr").show();
						
						usertype = "costomer";
					}
				});
				$('#infoModal').modal('show');
			}else if(rowIds.length>1){ 
				var txt=  "只能选择一个要修改的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}else{
				var txt=  "请选择要修改的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
		});
		//保存修改
		function save(){
				var account=$("#account").val();
				var name=$("#name").val();
				var password=$("#password").val();
				var rePassword=$("#rePassword").val();
				var phone=$("#phone").val();
				var id="";
				if(account==""){
					$("#account_alert").attr("data-content","账号不能为空");
					$("#account_alert").popover('show');
					return;
				}
				if(account.length>30){
					$("#account_alert").attr("data-content","账号长度不能超过30");
					$("#account_alert").popover('show');
					return;
				}
				if(name==""){
					$("#name_alert").attr("data-content","姓名不能为空");
					$("#name_alert").popover('show');
					return;
				}
				if(name.length>30){
					$("#name_alert").attr("data-content","姓名长度不能超过30");
					$("#name_alert").popover('show');
					return;
				}
				if(!/^(13|15|18|17)\d{9}$/i.test(phone) && phone!=""){
					$("#phone_alert").attr("data-content","手机格式不正确");
					$("#phone_alert").popover('show');
					return;
				}
				if(state=="添加"){
					if(password==""){
						$("#password_alert").attr("data-content","密码不能为空");
						$("#password_alert").popover('show');
						return;
					}
					if(!/^[A-Za-z0-9]+$/.test(password)){
						$("#password_alert").attr("data-content","密码只能由字母或数字组成");
						$("#password_alert").popover('show');
						return;
					}
					if(password.length>30){
						$("#password_alert").attr("data-content","密码长度不能超过30");
						$("#password_alert").popover('show');
						return;
					}
					if(rePassword==""){
						$("#rePassword_alert").attr("data-content","确认密码不能为空");
						$("#rePassword_alert").popover('show');
						return;
					}else if(rePassword.length>30){
						$("#rePassword_alert").attr("data-content","确认密码长度不能超过30");
						$("#rePassword_alert").popover('show');
						return;
					}else{
						if(rePassword!=password){
							$("#rePassword_alert").attr("data-content","两次密码不一致");
							$("#rePassword_alert").popover('show');
							return;
						}
					}
					
					var key;
					var module;
					//RSA 加密
					$.post('${ctx}/json/loginAction!getPubKey.action',function(data){
		    			//alert(data.empoent);
		    			module=data.module;
		    			RSAUtils.setMaxDigits(512);  
		    			key = new RSAUtils.getKeyPair(data.empoent, "",data.module);  
					
		    	 	//加密
		    	 	var opwd = $("#password").val() ;
		    	 	var oresult = RSAUtils.encryptedString(key,opwd);  
		    	 	$("#password").val(oresult);
		    	 	
		    	 	$("#module").val(module);
					
					$.post("${ctx}/json/userAction!checkNameExist.action",{'name':account},function(data){
						if(data.success==true){
							$("#account_alert").attr("data-content",data.msg);
							$("#account_alert").popover('show');
							return;
						}else{
							if(checkSubmitFlg ==true){ 
								return false;
							}else{
								$.ajax({
									type:"POST",
									url:"${ctx}/json/userAction!saveOrupdate.action?usertype="+usertype,
									data:$("#user_form").serialize(),
									success:function(data){
										if(data.success==true){
											$('#infoModal').modal('hide');
											$("#userList").bootgrid("reload");
											//rowIds=[];
											$.messager.show({title:'提示信息',msg:data.msg});
											$('body').unbind('mousedown');
										}else{
											$('#infoModal').modal('hide');
											$.messager.show({title:'提示信息',msg:data.msg});
											$('body').unbind('mousedown');
										}
									}
								});
								checkSubmitFlg=true;
							} 
						}
					});
					});
				}else{
					id=rowIds[0];
					$.ajax({
						type:"POST",
						url:"${ctx}/json/userAction!saveOrupdate.action?user.id="+id+"&roles="+roles,
						data:$("#user_form").serialize(),
						success:function(data){
							if(data.success==true){
								$('#infoModal').modal('hide');
								$("#userList").bootgrid("reload");
								//rowIds=[];
								$.messager.show({title:'提示信息',msg:data.msg});
								$('body').unbind('mousedown');
							}else{
								$('#infoModal').modal('hide');
								$.messager.show({title:'提示信息',msg:data.msg});
								$('body').unbind('mousedown');
							}
						}
					});
				}
			
			
		}
		
		//重置密码
		$("#resetPassword").click(function(){
			$("#resetPassword_alert").popover('hide');
			$("#newResetPassword").val("");
			if(rowIds.length==1){
				$('#resetPasswordModal').modal('show');
			}else if(rowIds.length>1){ 
				var txt=  "只能选择一个要重置密码的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}else{
				var txt=  "请选择要重置密码的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
		});
		function savePassword(){
			var newPassword=$("#newResetPassword").val();
			var key;
			var module;
			//RSA 加密
			$.post('${ctx}/json/loginAction!getPubKey.action',function(data){
				if(newPassword==""){
					$("#resetPassword_alert").attr("data-content","新密码不能为空");
					$("#resetPassword_alert").popover('show');
					return;
				}
				if(newPassword.length>30){
					$("#resetPassword_alert").attr("data-content","新密码长度不能超过30");
					$("#resetPassword_alert").popover('show');
					return;
				}
				if(!/^[A-Za-z0-9]+$/.test(newPassword)){
					$("#resetPassword_alert").attr("data-content","密码只能由字母或数字组成");
					$("#resetPassword_alert").popover('show');
					return;
				}
				module=data.module;
    			RSAUtils.setMaxDigits(512);  
    			key = new RSAUtils.getKeyPair(data.empoent, "",data.module);  
    		 	//加密
    		 	var result = RSAUtils.encryptedString(key,newPassword);  
    		 	$("#newResetPassword").val(result);
				$.post("${ctx}/json/userAction!resetPassword.action",{"userId":rowIds[0],"newPassword":$("#newResetPassword").val(),"module":module},function(data){
					if(data.success){
						$('#resetPasswordModal').modal('hide');
						$("#userList").bootgrid("reload");
						//rowIds=[];
						$.messager.show({title:'提示信息',msg:data.msg});
					}else{
						$('#resetPasswordModal').modal('hide');
						$.messager.show({title:'提示信息',msg:data.msg});
					}
				});
			});
		}
		
		//删除
		$("#delButton").click(function(){
			if(rowIds.length==0){
				var txt=  "请选择要删除的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			$.confirm({
    		    title: '提示信息!',
    		    content: '你确定要删除这些数据吗？',
    		    confirm: function(){
    		    	$.post('${ctx}/json/userAction!deleteUser.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#userList").bootgrid("reload");
							 rowIds=[];
							 $.messager.show({title:'提示信息',msg:data.msg});
						 }else{
							 $.messager.show({title:'提示信息',msg:data.msg});
						 } 
					});
    		    }
    		    
    		});
		});
		
		//设置资金
			$("#setMoneyButton").click(function(){
			if(rowIds.length==1){
				$.post('${ctx}/json/userAction!getUserMoney.action',{id:rowIds[0]},function(data){
					if(data.admin){
						var txt=  "不能对管理员进行操作";
						window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
						return;
					}else{
					$("#money_id").val(data.money_id)
					$("#money_1").val(data.money_1);
					$("#money_2").val(data.money_2);
					$("#money_get").val(data.money_get);
					$('#setMoneyModal').modal('show');
					}
				});
			}else if(rowIds.length>1){ 
				var txt=  "只能选择一个要设置";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}else{
				var txt=  "请选择要设置的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
		});
		//保存资金设计
		function saveMoneySet(){
		    	$.post('${ctx}/json/userAction!setUserMoney.action',{'id': $("#money_id").val(),'money_1': $("#money_1").val(),'money_2': $("#money_2").val(),'money_get': $("#money_get").val()},function(data){
					 if(data.success==true){
						 $('#setMoneyModal').modal('hide');
						 $("#userList").bootgrid("reload");
						 rowIds=[];
						 $.messager.show({title:'提示信息',msg:data.msg});
					 }else{
						 $.messager.show({title:'提示信息',msg:data.msg});
					 } 
				});
		}		

		//得到id
		function getTreeIds(){
			var treeObj = $.fn.zTree.getZTreeObj("setTreeList");
			var nodes = treeObj.getCheckedNodes(true);
			var ids="";
            for (var i = 0; i < nodes.length; i++) {
                if (ids != '') 
                	ids += ',';
                ids += nodes[i].id;
            }
            return ids;
		}
		document.onkeydown=function(){
			 if(event.keyCode==13)
           {
               event.returnValue=false;
           }
		};
	</script>
  </body>
</html>
