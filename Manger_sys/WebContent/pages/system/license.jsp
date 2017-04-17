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
  	/* 数据列表 */
	.text-left {text-align: left;font-size: 14px;}
	.bootgrid-table th>.column-header-anchor>.text {display: block;margin: 0 16px 0 0;
    overflow: hidden;-ms-text-overflow: ellipsis;-o-text-overflow: ellipsis;
    text-overflow: ellipsis; white-space: nowrap; font-size: 14px;}
  </style>
  <body>
  	<div class="container-fluid">
	  	<div class="row">
	  		<div class='col-sm-12' id='button_div'>		    
				 <a id='recoveryButton'  class='a-btn btn-info'>
				     <span class='glyphicon glyphicon-pencil' ></span>
				     <span class='a-btn-slide-text'>更换授权</span>
				 </a>
			</div>
  			<div class="col-sm-12" style="margin-top:30px;">
	  			<form id='license_form' class='form-horizontal' role='form' >
				 	<div class='row'>
					    <div class='form-group'>
						    <label   class='col-sm-3 control-label'>授权截至日期:</label>
						    <div  class='col-sm-5' id='date_alert'  data-toggle='popover' data-trigger='manual'>
						      <input type='text' disabled name='date'  class='form-control' id='date'/>
						    </div>
						</div>
						<div class='form-group'>
						    <label  class='col-sm-3 control-label'>授权最大数量:</label>
						    <div class='col-sm-5' id='number_alert'  data-toggle='popover' data-trigger='manual'>
						      <input type='text' disabled name='number'  class='form-control' id='number'/>
						    </div>
						</div>
						<div class='form-group'>
						    <label  class='col-sm-3 control-label'>授权MAC地址:</label>
						    <div class='col-sm-5' id='MAC_alert'  data-toggle='popover' data-trigger='manual'>
						      <input type='text' disabled name='MAC'  class='form-control' id='MAC'/>
						    </div>
						</div>
						 <div class='form-group'>
						    <label  class='col-sm-3 control-label'>授权公司名称:</label>
						    <div class='col-sm-5' id='company_alert'  data-toggle='popover' data-trigger='manual'>
						      <input type='text' disabled name='company'  class='form-control' id='company'/>
						    </div>
						 </div>
					</div>
				</form>
			</div>
		</div>
    <!-- 添加和修改模态框 -->
		<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
				      <div class="modal-header" >
				      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
		       			<h4 class='modal-title' id='myModalLabel'>授权文件选择</h4>
				      </div>
				      <div class="modal-body">
				      	<form id='licensefile_form' class='form-horizontal' role='form' enctype='multipart/form-data'>
						    <div class='row'>
							    <div class='form-group'>
								    <label  class='col-sm-3 control-label'>授权文件*:</label>
								    <div class='col-sm-7' id='licensefile_alert'  data-toggle='popover' data-trigger='manual'>
								      <input type='file' name='file'  class='form-control' id='licensefile'/>
								    </div>
								</div>
							</div>
						</form>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				        <button type="submit" class="btn btn-primary" onclick="save()">保存</button>
				      </div>
			     </div>
			</div>
		</div>		
    </div>
	<script type="text/javascript">
		//初始化数据
		$("#date").val("${date}");
		$("#number").val("${count}");
		$("#MAC").val("${mac}");
		$("#company").val("${company}");
		$('#licensefile').focus(function(){
			$('#licensefile_alert').popover('hide');
		});
		
		//更换授权
		var checkSubmitFlg=false;
		$("#recoveryButton").click(function(){
			checkSubmitFlg=false;
			$('#licensefile_alert').popover('hide');
			$("#licensefile").val("");
			$('#infoModal').modal('show');
		});		
		//保存
		function save(){
			if(checkSubmitFlg ==true){ 
				return false;
			}else{
				 $('#licensefile_form').ajaxSubmit({  
					type:"POST",
					url:"${ctx}/json/licenseAction!updateLicense.action",						
					success:function(data){								
						if(data.success==true){									
							$('#infoModal').modal('hide');
							$("#date").val(data.info[0]);
							$("#number").val(data.info[1]);
							$("#MAC").val(data.info[2]);
							$("#company").val(data.info[3]);
							$.messager.show({title:'提示信息',msg:data.msg});
						}else{
							$('#infoModal').modal('hide');
							$.messager.show({title:'提示信息',msg:data.msg});
						}
						checkSubmitFlg=false;
					}
				});	
			}
		};	
		document.onkeydown=function(){
			 if(event.keyCode==13)
         {
             event.returnValue=false;
         }
		};
	</script>
  </body>
</html>
