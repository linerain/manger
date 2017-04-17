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
				 <a id='updateButton'  class='a-btn btn-info' >
			     	<span class='glyphicon glyphicon-pencil' ></span>
			     	<span class='a-btn-slide-text'>修&nbsp;&nbsp;&nbsp;&nbsp;改</span>
			     </a>
				 <a id='delButton'  class='a-btn btn-default active'>
			     	<span class='glyphicon glyphicon-trash' ></span>
			     	<span class='a-btn-slide-text'>删&nbsp;&nbsp;&nbsp;&nbsp;除</span>
			     </a> 
			</div>
  			<div class="col-sm-12" style="margin-top:20px;">
			 	<table id="illegalList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">id</th>
				            <th data-column-id="code">行为类型编码</th>
				            <th data-column-id="type">行为类型</th>
				            <th data-column-id="level" data-formatter="level">违规级别</th>
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
		       			<h4 class='modal-title' id='myModalLabel'>添加/修改行为类型</h4>
				      </div>
				      <div class="modal-body">
				      	<form id='illegalform' class='form-horizontal' role='form'>
						    <div class='row'>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>行为类型编码*:</label>
							    <div class='col-sm-5' id='code_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='clientType.code'   class='form-control' id='code'/>
								</div>
							  </div>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>行为类型*:</label>
							    <div class='col-sm-5' id='type_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text'  name='clientType.type'   class='form-control' id='type'/>
							    </div>
							  </div>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>违规级别*:</label>
							    <div class='col-sm-5' id='level_alert'  data-toggle='popover' data-trigger='manual'>
									<select name="clientType.level" id="level" class='form-control'>  
										<option value="0" id="level_input_0" selected="selected">恢复</option>
										<option value="1" id="level_input_1">一级</option>
										<option value="2" id="level_input_2">二级</option>
									    <option value="3" id="level_input_3">三级</option>
									    <option value="4" id="level_input_4">四级</option>
									    <option value="5" id="level_input_5">其他</option>		
									</select>
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
		$("#illegalList").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/clientTypeAction!findByPage.action",
	        selection: true,
	        multiSelect: true,
	        rowSelect:true,
	        rowCount:10,
	        navigation:2,
	        formatters: {
	            "level": function(column, row)
	            {
	            	var level="";
	            	switch(row.level){
	            	case 0:
	            		level="恢复";
	            		break;
	            	case 1:
	            		level="一级";
	            		break;
	            	case 2:
	            		level="二级";
	            		break;
	            	case 3:
	            		level="三级";
	            		break;
	            	case 4:
	            		level="四级";
	            		break;
		            case 5:
	            		level="其他";
	            		break;
	            	}
	                return level;
	            },
	          }
		}).on("selected.rs.jquery.bootgrid", function(e, rows){
	        for (var i = 0; i < rows.length; i++){
	            rowIds.push(rows[i].id);
	        }
	 	}).on("deselected.rs.jquery.bootgrid", function(e, rows){
	    	var newIds = [];
	    	if(rowIds.length==rows.length){
	    		rowIds=[];
	    	}else{
	    		for (var i = 0; i < rows.length; i++){
	  	            for(var j = 0;j<rowIds.length;j++){
	  	            	if(rows[i].id==rowIds[j]){
	  	            		continue;
	  	            	}
	  	            	newIds.push(rowIds[j]);
	  	            }
	  	        }
	  	        rowIds = newIds;
	    	}
	    }).on("loaded.rs.jquery.bootgrid", function(e, rows){
	    	rowIds=[];
	    }) ; 
		///提示框隐藏
		$("#code").focus(function(){
			$("#code_alert").popover('hide');
		});
		$("#type").focus(function(){
			$("#type_alert").popover('hide');
		});
		$("#level").focus(function(){
			$("#level_alert").popover('hide');
		});
		//新增
		var checkSubmitFlg=false;
		$("#saveButton").click(function(){
			savaState="新增";
			$("#code_alert").popover('hide');
			$("#type_alert").popover('hide');
			$("#level_alert").popover('hide');
			$("#type").val("");
			$("#code").val("");
			//$("#level").val("");
			$('#infoModal').modal('show');
			checkSubmitFlg=false;
		});
		//修改
		var oldcode="";
		$("#updateButton").click(function(){
			if(rowIds.length==1){
				savaState="修改";
				$("#type_alert").popover('hide');
				$("#code_alert").popover('hide'); 
				$("#level_alert").popover('hide');
				$.post('${ctx}/json/clientTypeAction!showInfo.action',{'id' : rowIds[0]}, function(data) {
					$("#type").val(data.clientType.type);
					$("#code").val(data.clientType.code);
					oldcode=data.clientType.code;
					//$("[id^=level_input_]").removeAttr("selected");
					if(data.clientType.level==0){
						$("#level").val("0");
						$("#level_input_0").attr("selected","selected");
					}else if(data.clientType.level==1){
						$("#level").val("1");
						$("#level_input_1").attr("selected","selected");
					}else if(data.clientType.level==2){
						$("#level").val("2");
						$("#level_input_2").attr("selected","selected");
					}else if(data.clientType.level==3){
						$("#level").val("3");
						$("#level_input_3").attr("selected","selected");
					}else if(data.clientType.level==4){
						$("#level").val("4");
						$("#level_input_4").attr("selected","selected");
					}else if(data.clientType.level==5){
						$("#level").val("5");
						$("#level_input_5").attr("selected","selected");
					}
					if(data.clientType.sys==1){
                    $("#code").attr("readonly","readonly");
                    $("#type").attr("readonly","readonly");
                    }else{
                    $("#code").removeAttr("readonly");
                    $("#type").removeAttr("readonly");
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
		
		//保存
		function save(){
			var type=$("#type").val();
			var code=$("#code").val();
			var level=$("#level").val();
			if(code==""){
				$("#code_alert").attr("data-content","编码不能为空");
				$("#code_alert").popover('show');
				return;
			}
			if(code.length>30){
				$("#code_alert").attr("data-content","编码长度不能超过30");
				$("#code_alert").popover('show');
				return;
			}
			if(type==""){
				$("#type_alert").attr("data-content","行为类型不能为空");
				$("#type_alert").popover('show');
				return;
			}
			if(type.length>30){
				$("#type_alert").attr("data-content","行为类型长度不能超过30");
				$("#type_alert").popover('show');
				return;
			}
			if(level==""){
				$("#level_alert").attr("data-content","违规级别不能为空");
				$("#level_alert").popover('show');
				return;
			}
			$.post('${ctx}/json/clientTypeAction!checkCodeExist.action',{'name':code},function(datas){
				if(savaState=="新增"){
					if(checkSubmitFlg==true){ 
						return false;
					}else{			
						if(datas.success==true){
							$.messager.show({title:'提示信息',msg:datas.msg});
							return;
						}else{
							$.ajax({
									type:"POST",
									url:"${ctx}/json/clientTypeAction!saveOrUpdate.action",
									data:$("#illegalform").serialize(),
									success:function(data){
										if(data.success==true){
											$('#infoModal').modal('hide');
											$("#illegalList").bootgrid("reload");
											$.messager.show({title:'提示信息',msg:data.msg});
										}else{
											$('#infoModal').modal('hide');
											$.messager.show({title:'提示信息',msg:data.msg});
										}
										checkSubmitFlg=true;	
									}
								});	
							}
						}				 
					}else{
						if(datas.success==true&&oldcode!=code){
							$.messager.show({title:'提示信息',msg:datas.msg});
							return;
						}else{
							$.ajax({
								type:"POST",
								url:"${ctx}/json/clientTypeAction!saveOrUpdate.action?id="+rowIds[0],
								data:$("#illegalform").serialize(),
								success:function(data){
									if(data.success==true){
										$('#infoModal').modal('hide');
										$("#illegalList").bootgrid("reload");
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
			})
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
    		    	$.post('${ctx}/json/clientTypeAction!delete.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#illegalList").bootgrid("reload");
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
