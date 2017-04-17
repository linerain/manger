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
			 	<table id="softwareList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">id</th>
				            <th data-column-id="name">杀毒软件名称</th>
				            <th data-column-id="code">特征码</th>
				            <th data-column-id="process">进程</th>
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
		       			<h4 class='modal-title' id='myModalLabel'>添加/修改杀毒软件</h4>
				      </div>
				      <div class="modal-body">
				      	<form id='softwareform' class='form-horizontal' role='form'>
						    <div class='row'>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>杀毒软件名称*:</label>
							    <div class='col-sm-5' id='name_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='antivirusInfo.name'   class='form-control' id='name'/>
								</div>
							  </div>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>特征码*:</label>
							    <div class='col-sm-5' id='code_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text'  name='antivirusInfo.code'   class='form-control' id='code'/>
							    </div>
							  </div>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>进程*:</label>
							    <div class='col-sm-5' id='process_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text'  name='antivirusInfo.process'   class='form-control' id='process'/>
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
		$("#softwareList").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/antivirusInfoAction!findByPage.action",
	        selection: true,
	        multiSelect: true,
	        rowSelect:true,
	        rowCount:10,
	        navigation:2,
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
		$("#name").focus(function(){
			$("#name_alert").popover('hide');
		});
		$("#code").focus(function(){
			$("#code_alert").popover('hide');
		});
		$("#process").focus(function(){
			$("#process_alert").popover('hide');
		});
		//新增
		var checkSubmitFlg=false;
		$("#saveButton").click(function(){
			savaState="新增";
			$("#name_alert").popover('hide');
			$("#code_alert").popover('hide');
			$("#process_alert").popover('hide');
			$("#name").val("");
			$("#code").val("");
			$("#process").val("");
			$('#infoModal').modal('show');
			checkSubmitFlg=false;
		});
		//修改
		var oldcode="";
		$("#updateButton").click(function(){
			if(rowIds.length==1){
				savaState="修改";
				$("#name_alert").popover('hide');
				$("#code_alert").popover('hide'); 
				$("#process_alert").popover('hide');
				$.post('${ctx}/json/antivirusInfoAction!showInfo.action',{'id' : rowIds[0]}, function(data) {
					$("#name").val(data.antivirusInfo.name);
					$("#code").val(data.antivirusInfo.code);
					oldcode=data.antivirusInfo.code;
					$("#process").val(data.antivirusInfo.process);
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
			var name=$("#name").val();
			var code=$("#code").val();
			var process=$("#process").val();
			if(name==""){
				$("#name_alert").attr("data-content","软件名称不能为空");
				$("#name_alert").popover('show');
				return;
			}
			if(name.length>30){
				$("#name_alert").attr("data-content","软件名称长度不能超过30");
				$("#name_alert").popover('show');
				return;
			}
			if(code==""){
				$("#code_alert").attr("data-content","特征码不能为空");
				$("#code_alert").popover('show');
				return;
			}
			if(code.length>30){
				$("#code_alert").attr("data-content","特征码长度不能超过30");
				$("#code_alert").popover('show');
				return;
			}
			if(process==""){
				$("#process_alert").attr("data-content","进程不能为空");
				$("#process_alert").popover('show');
				return;
			}
			if(process.length>30){
				$("#process_alert").attr("data-content","进程长度不能超过30");
				$("#process_alert").popover('show');
				return;
			}
			$.post('${ctx}/json/antivirusInfoAction!checkCodeExist.action',{'name':code},function(datas){
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
									url:"${ctx}/json/antivirusInfoAction!saveOrUpdate.action",
									data:$("#softwareform").serialize(),
									success:function(data){
										if(data.success==true){
											$('#infoModal').modal('hide');
											$("#softwareList").bootgrid("reload");
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
							url:"${ctx}/json/antivirusInfoAction!saveOrUpdate.action?id="+rowIds[0],
							data:$("#softwareform").serialize(),
							success:function(data){
								if(data.success==true){
									$('#infoModal').modal('hide');
									$("#softwareList").bootgrid("reload");
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
    		    	$.post('${ctx}/json/antivirusInfoAction!delete.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#softwareList").bootgrid("reload");
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
