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
			     <a id='saveButton'  class='a-btn btn-success'>
			 		 <span class='glyphicon glyphicon-plus'></span>
			 		 <span class='a-btn-slide-text'>添&nbsp;&nbsp;&nbsp;&nbsp;加</span>
			 	 </a>
				 <a id='updateButton'  class='a-btn btn-info'>
			     	<span class='glyphicon glyphicon-pencil' ></span>
			     	<span class='a-btn-slide-text'>修&nbsp;&nbsp;&nbsp;&nbsp;改</span>
			     </a>
				 <a id='delButton'  class='a-btn btn-default active'>
			     	<span class='glyphicon glyphicon-trash' ></span>
			     	<span class='a-btn-slide-text'>删&nbsp;&nbsp;&nbsp;&nbsp;除</span>
			     </a> 
			</div>
  			<div class="col-sm-12" style="margin-top:20px;">
			 	<table id="parameterList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				            <th data-column-id="name"  data-identifier="true" data-visible="true" data-visible-in-selection="false">名称</th>
				            <th data-column-id="param">参数</th>
				        </tr>
				     </thead>
				</table>
			</div>
		</div>
		<!-- 添加和修改模态框 -->
		<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
				      <div class="modal-header" >
				      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
		       			<h4 class='modal-title' id='myModalLabel'>添加/修改参数</h4>
				      </div>
				      <div class="modal-body">
				      	<form id='parameter_form' class='form-horizontal' role='form'>
						    <div class='row'>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>名称*:</label>
							    <div class='col-sm-5' id='name_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='systemParam.name'   class='form-control' id='name'/>
								</div>
							  </div>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>参数*:</label>
							    <div class='col-sm-5' id='parameter_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text'  name='systemParam.param'   class='form-control' id='parameter'/>
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
		var savaState="新增";
	 	var rowIds = [];
		$("#parameterList").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/systemParamAction!findByPage.action",
	        selection: true,
	        multiSelect: true,
	        rowSelect:true,
	        rowCount:10,
	        navigation:2,
		}).on("selected.rs.jquery.bootgrid", function(e, rows){
	        for (var i = 0; i < rows.length; i++){
	            rowIds.push(rows[i].name);
	            console.log(rowIds);
	        }
	 	}).on("deselected.rs.jquery.bootgrid", function(e, rows){
	    	var newIds = [];
	    	if(rowIds.length==rows.length){
	    		rowIds=[];
	    	}else{
	    		for (var i = 0; i < rows.length; i++){
	  	            for(var j = 0;j<rowIds.length;j++){
	  	            	if(rows[i].name==rowIds[j]){
	  	            		continue;
	  	            	}
	  	            	newIds.push(rowIds[j]);
	  	            }
	  	        }
	  	        rowIds = newIds;
	    	}
	    }).on("loaded.rs.jquery.bootgrid", function(e, rows){
	    	rowIds=[];
	    }); 
		//新增
		var checkSubmitFlg=false;
		$("#saveButton").click(function(){
			savaState="新增";
			$("#code").val("");
			$("#name").val("");
			$("#parameter").val("");
			$('#infoModal').modal('show');
			checkSubmitFlg=false;
		});

		//修改
		var oldname="";
		$("#updateButton").click(function(){
			savaState="修改";
			$("#code_alert").popover('hide');
			$("#name_alert").popover('hide'); 
			$("#parameter_alert").popover('hide');
			if(rowIds.length==1){
				$.post('${ctx}/json/systemParamAction!getParam.action',{'name':rowIds[0]},function(data){
					//$("#code").val(data.param.code);
					$("#name").val(data.param.name);
					$("#parameter").val(data.param.param);
					oldname=data.param.name;
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
		
		//保存
		function save(){
			var code=$("#code").val();
			var name=$("#name").val();
			var parameter=$("#parameter").val();
			var id="";
			/* if(code==""||!/^\d$/.test(parameter)){
				$("#code_alert").attr("data-content","编码格式不正确");
				$("#code_alert").popover('show');
				return;
			}
			if(code.length>255){
				$("#code_alert").attr("data-content","编码长度不能超过255");
				$("#code_alert").popover('show');
				return;
			} */
			if(name==""){
				$("#name_alert").attr("data-content","名称不能为空");
				$("#name_alert").popover('show');
				return;
			}
			if(name.length>255){
				$("#name_alert").attr("data-content","名称长度不能超过255");
				$("#name_alert").popover('show');
				return;
			}
			if(parameter==""){
				$("#parameter_alert").attr("data-content","参数不能为空");
				$("#parameter_alert").popover('show');
				return;
			}
			if(parameter.length>255){
				$("#parameter_alert").attr("data-content","参数长度不能大于255");
				$("#parameter_alert").popover('show');
				return;
			}
			var isRepeat="";
			$.post('${ctx}/json/systemParamAction!nameIsExist.action',{'name':name},function(datamap){	
				isRepeat=datamap.success;
				if(savaState=="新增"){
					if(checkSubmitFlg==true){ 
						return false;
					}else{
						console.log(isRepeat);
						if(isRepeat==false){
							var txt=  "名称已经存在";
							window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
							return;
						}else{
							$.ajax({
									type:"POST",
									url:"${ctx}/json/systemParamAction!save.action",
									data:$("#parameter_form").serialize(),
									success:function(data){
										if(data.success==true){
											$('#infoModal').modal('hide');
											$("#parameterList").bootgrid("reload");
											$.messager.show({title:'提示信息',msg:data.msg});
										}else{
											$('#infoModal').modal('hide');
											$.messager.show({title:'提示信息',msg:data.msg});
										}
									}
								});
							checkSubmitFlg=true;						
						}
					}	
				}else{
					if(isRepeat==false&&oldname!=name){
						var txt=  "名称已经存在";
						window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
						return;
					}else{
						$.ajax({
							type:"POST",
							url:"${ctx}/json/systemParamAction!updateParam.action?name="+rowIds[0],
							data:$("#parameter_form").serialize(),
							success:function(data){
								if(data.success==true){
									$('#infoModal').modal('hide');
									$("#parameterList").bootgrid("reload");
									//rowIds=[];
									$.messager.show({title:'提示信息',msg:data.msg});
								}else{
									$('#infoModal').modal('hide');
									$.messager.show({title:'提示信息',msg:data.msg});
								}
							}
						});
					}		
				}
			
			});	   
		};	

		//删除
		$("#delButton").click(function(){
			if(rowIds.length==0){
				var txt="请选择要删除的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			$.confirm({
    		    title: '提示信息!',
    		    content: '你确定要删除这些数据吗？',
    		    confirm: function(){
    		    	$.post('${ctx}/json/systemParamAction!delete.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#parameterList").bootgrid("reload");
							 rowIds=[];
							 $.messager.show({title:'提示信息',msg:data.msg});
						 }else{
							 $.messager.show({title:'提示信息',msg:data.msg});
						 } 
					});
    		    }
    		    
    		});
		});

	</script>
  </body>
</html>
