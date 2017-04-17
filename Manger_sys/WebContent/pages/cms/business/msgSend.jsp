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
    /* .bootgrid-table th > .column-header-anchor > .text{font-size:13px;font-weight:normal;}
    .text-left{font-size:13px;} */
  </style>
  
  <body>
  	<div class="container-fluid">
	  	<div class="row">
	  		<div class='col-sm-12' id='button_div'>
			     <a id='saveButton'  class='a-btn btn-success'  >
			 		 <span class='glyphicon glyphicon-plus'></span>
			 		 <span class='a-btn-slide-text'>添加消息</span>
			 	 </a>
				 <a id='updateButton'  class='a-btn btn-info'  >
			     	<span class='glyphicon glyphicon-pencil' ></span>
			     	<span class='a-btn-slide-text'>修改消息</span>
			     </a>
			     <a id='sendButton'  class='a-btn btn-success'  >
			     	<span class='glyphicon glyphicon-floppy-save' ></span>
			     	<span class='a-btn-slide-text'>下发消息</span>
			     </a> 
			     <a id='detailButton'  class='a-btn btn-info'  >
			     	<span class='glyphicon glyphicon-info-sign' ></span>
			     	<span class='a-btn-slide-text'>消息下发记录</span>
			     </a> 
				 <a id='delButton'  class='a-btn btn-default active'  >
			     	<span class='glyphicon glyphicon-trash' ></span>
			     	<span class='a-btn-slide-text'>删除消息</span>
			     </a> 
			</div>
  			<div class="col-sm-12" style="margin-top:20px;" id="filepage_List">
			 	<table id="msgsendList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">id</th>
				            <th data-column-id="name">主题</th>
				            <th data-column-id="bigMessage">内容</th>
				            <th data-column-id="times">创建时间</th>
				            <th data-column-id="days">有效时间</th>
				        </tr>
				     </thead>
				</table>
			</div>
			<!-- 添加 -->
			<div id="add_div" style="display:none;width: 100%;height: 100%;overflow: hidden;margin-top:60px;">
				<form action="" id="add_form" class='form-inline'  method="post">
					<div class='form-group col-sm-6' >
						<label class="control-label ">主&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题：</label>
						<input type="text" name="messageManage.name" id="name_input" class="form-control"/>
					</div>
					<div class='form-group col-sm-6'>
						<label class="control-label ">有效时间*：</label>
						<select class="form-control" id="days_input" name="messageManage.days">
							<option value="1" id="days1">1天</option>
							<option value="2" id="days2">2天</option>
							<option value="3" id="days3">3天</option>
						</select><br/>
					</div>
					<div class='form-group col-sm-12'  style="margin-top:30px">
						<label class="control-label ">消息内容*：</label>
						<!-- 加载编辑器的容器 -->
				        <script id="editContainer"  name="messageManage.bigMessage" type="text/plain"  style="padding-left:80px;margin-top:-13px">
	        				内容可以是文字、图片等
						</script>
					</div>
					<div class='form-group col-sm-3 col-sm-offset-9' id="operationBtn" style="margin-top:20px">	
	       				<a id='saveSubmit' class="btn btn-primary" href='javascript:void(0)' >保存</a>
						<a id='cancelBtn' class="btn btn-default" href='javascript:void(0)' onclick="cancelback()">返回</a>
					</div>
				</form>
				<!-- 查看	 -->
				 <div class='col-sm-12' id="msgHistorydiv" style="margin-top:10px;"> 
		      		<h3 style='font-weight:bold;'>发送历史列表</h3>
				 	<table id="msgHistoryList" class="table table-condensed table-hover table-striped" ajax="true">
					    <thead>
					        <tr>
					            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">id</th>
					            <th data-column-id="devName">客户端</th>
					            <th data-column-id="msg">内容</th>
					            <th data-column-id="time">发送时间</th>
					        	<th data-column-id="succe">是否成功</th>
					        	<td data-column-id="riad">是否已阅</td>
					        </tr>
					     </thead>
					</table>
					<a id="backBtn" style="margin-top:40px;" class="btn btn-primary col-sm-offset-11" onclick="cancelback()" href='javascript:void(0)' >返回</a>
			    </div>	
			</div>
			
			<!-- 下发 -->
			<div class="modal fade fade bs-example-modal-lg" id="userModalLg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog modal-lg" role="document">
				      <div class="modal-content">
					      <div class="modal-header" >
					      	<button type='button' class='close' data-dismiss='modal' aria-label='Close' ><span aria-hidden='true'>&times;</span></button>
							<h4 class='modal-title' id='myModalLabelThree'>下发信息</h4>
					      </div>
					      <div class="modal-body">
						 	<table id="userList" class="table table-condensed table-hover table-striped" ajax="true">
							    <thead>
							        <tr>
							            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">id</th>
							            <th data-column-id="name">名称</th>
				            			<th data-column-id="ipSection">ip组</th>
							            <!-- <th data-column-id="userName">用户名</th>
							            <th data-column-id="deviceIp">设备IP</th>
							            <th data-column-id="deviceName">设备名称</th>
							            <th data-column-id="macAddress">MAC地址</th>
							            <th data-column-id="deviceType">设备类型</th> -->
							        </tr>
							     </thead>
							</table>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
					        <button type="submit" class="btn btn-primary" onclick="save()">确定</button>
					      </div>
				     </div>
				</div>
			</div>
		</div>
    </div>
	<script type="text/javascript">
	 	var rowIds = [];
		$("#msgsendList").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/messageManageAction!findByPage.action",
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
		//列表
		/* $("#listButton").click(function(){
			$("#filepage_List").show();	
			$("#update_div").hide();
			$("#add_div").hide();
		}); */
		/* $("#cancelBtn").click(function(){
			$("#update_div").hide();
			$("#add_div").hide();
			$("#msgsendList").bootgrid("reload");
			$("#filepage_List").show();	
			
		}); */
		function cancelback(){
			$("#update_div").hide();
			$("#add_div").hide();
			$("#msgsendList").bootgrid("reload");
			$("#filepage_List").show();	
		}
		//添加
		var checkSubmitFlg=false;
		if(typeof(editor) !='undefined'){
				editor.destroy();
				editor = UE.getEditor('editContainer');
		}
		var editor = UE.getEditor('editContainer');
		$("#saveButton").click(function(){
			checkSubmitFlg=false;
			saveBtn="新增";
			$("#msgHistorydiv").hide();
			$("#filepage_List").hide();	
			$("#update_div").hide();
	    	$("#name_input").val("");
	    	$("#operationBtn").show();
	    	/* $("#backBtn").hide(); */
			$("#add_div").show();
	    	$("#days_input").removeAttr("disabled");
			$("#name_input").removeAttr("disabled");
			editor.ready(function() {
				editor.setContent("");
				editor.setEnabled();
			}); 
				
			//}
		});
		//修改
		$("#updateButton").click(function(){
			if(rowIds.length>1){
				var txt="只能选择一个要修改的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}else if(rowIds.length<1){
				var txt="请选择要修改的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}else{
				saveBtn="修改";
				$("#msgHistorydiv").hide();
				$("#filepage_List").hide();	
				$("#update_div").hide();
				$("#operationBtn").show();
				/* $("#backBtn").hide(); */
				$("#days_input").removeAttr("disabled");
				$("#name_input").removeAttr("disabled");
		    	$("#name_input").val("");
		    	$("#add_div").show();
				/* var editor = UE.getEditor('editContainer'); */   
		        $.post('${ctx}/json/messageManageAction!findById.action',{'id':rowIds[0]},function(data){
		        	var manage=data.manage;
					$("#name_input").val(manage.name);
					if(manage.days==1){
						$("#days1").attr("selected","selected");
					}else if(manage.days==2){
						$("#days2").attr("selected","selected");
					}else if(manage.days==3){
						$("#days3").attr("selected","selected");
					}
					var content=manage.bigMessage;
					editor.ready(function() {
						editor.setContent(content);
						editor.setEnabled();
					});
				});
			}	
		});
		//新增保存
		var saveBtn="新增";
		$("#saveSubmit").click(function(){
			var name_input=$("#name_input").val();
			var days_input=$("#days_input").val();
			if(days_input==""){
				var txt="有效时间不能为空";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			if(name_input.length>30){
				var txt="主题长度不能超过30";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			var content = UE.getEditor('editContainer').hasContents();
			if (content == false) {
				var txt="内容不能为空";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				UE.getEditor('editContainer').focus();//光标返回编辑器中
				return false;
			}	
			if(saveBtn=="新增"){
				if(checkSubmitFlg==true){ 
					return false;
				}else{	
					$.ajax({
						type:"post",
						url:"${ctx}/json/messageManageAction!save.action",
						data:$('#add_form').serialize(),
						success:function(data){
							if(data.success){
		                   		$("#filepage_List").show();	
		            			$("#add_div").hide();
								$("#msgsendList").bootgrid("reload");
								$.messager.show({title:'提示信息',msg:data.msg});
		                   	}else{
		                   		$("#filepage_List").show();	
		            			$("#add_div").hide();
								$("#msgsendList").bootgrid("reload");
		                   		$.messager.show({title:'提示信息',msg:data.msg});
		                   	}
							checkSubmitFlg=true;	
						}
					});
				}
			}else{
				//if($('#update_form').form('validate')){
					//var content = UE.getEditor('editContainer').hasContents();
					/* if (content == false) {
						$.messager.alert("提示信息","内容不能为空"); 
						UE.getEditor('editContainer').focus();//光标返回编辑器中
						return false;
					} */
					$.ajax({
						type:"post",
						url:"${ctx}/json/messageManageAction!update.action?messageManage.id="+rowIds[0],
						data:$('#add_form').serialize(),
						success:function(data){
							if(data.success){
		                   		$("#filepage_List").show();	
		            			$("#add_div").hide();
								$("#msgsendList").bootgrid("reload");
								$.messager.show({title:'提示信息',msg:data.msg});
	                    	}else{
	                    		$("#filepage_List").show();	
		            			$("#add_div").hide();
								$("#msgsendList").bootgrid("reload");
								$.messager.show({title:'提示信息',msg:data.msg});
	                    	}
						}
					});
				//}
			}
		});
		
		/* 下发策略 */
		var nrowIds=[];
		$("#sendButton").click(function(){
			if(rowIds.length==0){
				var txt="请选择要下发的消息";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}else{ 
				nrowIds=[];
				$('#userList').bootgrid("destroy");
				$('#userList').bootgrid({
	  				ajax: true,
	      			post: function (){},
	      			url: "${ctx}/json/groupAction!findByPage.action",
	      			selection: true,
	      			multiSelect: true,
	      			columnSelection:false,
	      			rowSelect: true,
	      			rowCount:[8,10,20,25],
	      			navigation:2,
	      			/* formatters: {
						operationtime:function(column, row){
							return row.operationtime.substr(0,10);
						},
					} */
		 	 	}).on('selected.rs.jquery.bootgrid', function(e, rows){
			        for (var i = 0; i < rows.length; i++){
			            nrowIds.push(rows[i].id);
			        }
			    }).on('deselected.rs.jquery.bootgrid', function(e, rows){
			    	var newIds = [];
			    	if(nrowIds.length==rows.length){
		   				nrowIds=[];
		   			}else{ 
			        	for (var i = 0; i < rows.length; i++){
			            	for(var j = 0;j<nrowIds.length;j++){
			            		if(rows[i].id==nrowIds[j]){
			            			continue;
			            		}
			            		newIds.push(nrowIds[j]);
			            	}
			        	}
			        	nrowIds = newIds;
			        
		        	}
			    });
				$('#userModalLg').modal('show');
			}
		});
		
		//保存
		function save(){
			if(nrowIds.length==0){
				var txt="至少选择一项";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}else{
				$.post("${ctx}/json/groupAction!sendMessage.action",{'msgids':rowIds.toString(),'groupId':nrowIds.toString()},function(data){	
					if(data.success==true){
						$('#userModalLg').modal('hide');
						$("#msgsendList").bootgrid("reload");
						$.messager.show({title:'提示信息',msg:data.msg});
					}else{
						$('#userModalLg').modal('hide');
						$.messager.show({title:'提示信息',msg:data.msg});
					}	
				});
			}	
		}

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
    		    	$.post('${ctx}/json/messageManageAction!delete.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#msgsendList").bootgrid("reload");
							 rowIds=[];
							 $.messager.show({title:'提示信息',msg:data.msg});
						 }else{
							 $.messager.show({title:'提示信息',msg:data.msg});
						 } 
					});
    		    }
    		    
    		});
		});		
		$("#detailButton").click(function(){
			if(rowIds.length>1){
				var txt="只能选择一个消息";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}else if(rowIds.length<1){
				var txt="请选择消息";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}else{
				$("#filepage_List").hide();	
				$("#update_div").hide();
				$("#operationBtn").hide();
				/* $("#backBtn").show(); */
				$("#add_div").show();
				$("#msgHistorydiv").show();
		    	$("#name_input").val("");
				//var editor = UE.getEditor('editContainer');   
		        $.post('${ctx}/json/messageManageAction!findById.action',{'id':rowIds[0]},function(data){
		        	var manage=data.manage;
					$("#name_input").val(manage.name);
					$("#name_input").attr("disabled","true");
					if(manage.days==1){
						$("#days1").attr("selected","selected");
					}else if(manage.days==2){
						$("#days2").attr("selected","selected");
					}else if(manage.days==3){
						$("#days3").attr("selected","selected");
					}
					$("#days_input").attr("disabled","true");
					var content=manage.bigMessage;
					editor.ready(function() {
						editor.setContent(content);
						editor.setDisabled();
					});
					
				});
		        $("#msgHistoryList").bootgrid({
			    	ajax: true,
			        post: function (){},
			        url: '${ctx}/json/messageSendHistoryAction!findByPage.action?id='+rowIds[0],
			        rowCount:10,
			        navigation:2,
				}); 
			}	
		});
		
		
		
		
	</script>
  </body>
</html>
