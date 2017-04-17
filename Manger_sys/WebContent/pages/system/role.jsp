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
  	#powerPanel {border-bottom:0;border-bottom-color: #fff;height:60%;}
  	#powerPanel .panel-heading {padding: 4px 15px;}
  	#powerTitle{margin-left: 0;}
  	#powerPanel{display:none;}
  	#setTreeList{margin-top:18px;}
  	/* 数据列表 */
	.text-left {text-align: left;font-size: 14px;}
	.bootgrid-table th>.column-header-anchor>.text {display: block;margin: 0 16px 0 0;
    overflow: hidden;-ms-text-overflow: ellipsis;-o-text-overflow: ellipsis;
    text-overflow: ellipsis; white-space: nowrap; font-size: 14px;}
  </style>
  <body>
  	<div class="container-fluid">
  		<div class="row">
  			<div class="col-sm-12" id="tableDiv">
			 	<table id="roleList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				        	<th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">编号</th>
				            <th data-column-id="name">名称</th>
				            <th data-column-id="describe">描述</th>
				        </tr>
				    </thead>
				</table>
  			</div>
	  		<div class="col-sm-3">
	  			<div class="panel panel-info" id="powerPanel">
			      <div class="panel-heading">
	      				<h3 class="panel-title" id="panel-title">菜单权限设置</h3>
			      </div>
			      <div class="panel-body">
			      	<div class="container-fluid">
			      		<div class="row">
			      			 <div class="col-sm-7 powerTitle">
			      			 	<h3 class="panel-title" id="powerTitle"></h3>
			      			 </div>
			      			 <div class="col-sm-2">
						      	<button id='savePower' type='button' class='btn btn-success'>
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
			      <div class="modal-header" >
			      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
	       			<h4 class='modal-title' id='myModalLabel'>添加/修改角色信息</h4>
			      </div>
			      <div class="modal-body">
			      	<form id='role_form' class='form-horizontal'>
				    	<div class='row'>
					  	  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>角色名称*:</label>
							    <div class='col-sm-5' id='name_alert'  data-toggle='popover' data-trigger='manual'>
							      <input type='text' name='role.name'  class='form-control' id='name'/>
							    </div>
							  </div>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>角色描述:</label>
							    <div class='col-sm-5' id='describe_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='role.describe'  class='form-control' id='describe'/>
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
	<script type="text/javascript">
	 	var rowIds = [];
	 	var isAdmin;
	 	var rowname=[];
		$("#roleList").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/roleAction!findAllRoles.action",
	        selection: true,
	        multiSelect: true,
	        rowSelect: true,
	        rowCount:[8,10,20,25]
	    }).on("selected.rs.jquery.bootgrid", function(e, rows){
	        for (var i = 0; i < rows.length; i++){
	            rowIds.push(rows[i].id);
	            isAdmin=rows[i].isadmin;
	            rowname.push(rows[i].name);
	        }
	    }).on("deselected.rs.jquery.bootgrid", function(e, rows){
	    	$("#tableDiv").attr("class","col-sm-12");
			$("#powerPanel").hide();
			var newIds = [];
			var newNames = [];
			if(rowIds.length==rows.length){
	    		rowIds=[];
	    		rowname=[];
	    	}else{
				for (var i = 0; i < rows.length; i++)
		        {
		            for(var j = 0;j<rowIds.length;j++){
		            	if(rows[i].id==rowIds[j]){
		            		continue;
		            	}
		            	newIds.push(rowIds[j]);
		            	newNames.push(rowname[j]);
		            }
		        }
		        isAdmin="";
		        rowIds = newIds;
		        rowname=newNames;
	    	}
	    }).on("loaded.rs.jquery.bootgrid", function(e, rows){
	    	rowIds=[];
	    	rowname=[];
	    });
    	 
		//添加按钮
		var html="<div class='col-sm-6' id='button_div'>"+
					"<a id='saveButton'  class='a-btn btn-success'>"+
						 "<span class='glyphicon glyphicon-plus' ></span>"+
						 "<span class='a-btn-slide-text'>添&nbsp;&nbsp;&nbsp;&nbsp;加</span>"+
					"</a>"+
					"<a id='updateButton'  class='a-btn btn-info'>"+
						 "<span class='glyphicon glyphicon-pencil' ></span>"+
						 "<span class='a-btn-slide-text'>修&nbsp;&nbsp;&nbsp;&nbsp;改</span>"+
					"</a>"+
				    "<a id='set'  class='a-btn btn-info'>"+
			     	 "<span class='glyphicon glyphicon-edit' ></span>"+
			     	 "<span class='a-btn-slide-text'>设备权限</span>"+
			        "</a>"+
				    "<a id='delButton'  class='a-btn btn-default active'>"+
				    	"<span class='glyphicon glyphicon-trash' ></span>"+
				    	 "<span class='a-btn-slide-text'>删&nbsp;&nbsp;&nbsp;&nbsp;除</span>"+
				    "</a>"+
				"</div>";
		$("#headerRow").before(html);
		
		$('#name').focus(function(){
			$('#name_alert').popover('hide');
		});
		//添加
		var state="添加";
		var checkSubmitFlg=false;
		$("#saveButton").click(function(){
			state="添加";
			//rowIds=[];
			checkSubmitFlg=false;
			$("#name_alert").popover('hide');
			$("#name").val("");
			$("#describe").val("");
			$('#infoModal').modal('show');
		});
		
		//修改回显
		var oldName;
		$("#updateButton").click(function(){
			$("#name_alert").popover('hide');
			state="修改";
			if(isAdmin){
				var txt= "不能修改管理员";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}else{
				if(rowIds.length==1){
					$.post('${ctx}/json/roleAction!findRolesById.action',{id:rowIds[0]},function(data){
						$("#name").val(data.role.name);
						oldName=data.role.name;
						$("#describe").val(data.role.describe);
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
			}
			
			
		});
		//保存修改
		function save(){
			var name=$("#name").val();
			var id="";
			if(name==""){
				$("#name_alert").attr("data-content","名称不能为空");
				$("#name_alert").popover('show');
				return;
			}
			if(name.length>30){
				$("#name_alert").attr("data-content","名称长度不能超过30");
				$("#name_alert").popover('show');
				return;
			}
			if(describe.length>30){
				$("#describe_alert").attr("data-content","角色描述长度不能超过30");
				$("#describe_alert").popover('show');
				return;
			}
			if(state=="添加"){
				$.post("${ctx}/json/roleAction!checkNameExist.action",{'rolename':name},function(data){
					if(data.success==true){
						$("#name_alert").attr("data-content",data.msg);
						$("#name_alert").popover('show');
						return;
					}else{
						if(checkSubmitFlg ==true){ 
							return false;
						}else{
							$.ajax({
								type:"POST",
								url:"${ctx}/json/roleAction!saveOrUpdate.action",
								data:$("#role_form").serialize(),
								success:function(data){
									if(data.success==true){
										$('#infoModal').modal('hide');
										$("#roleList").bootgrid("reload");
										//rowIds=[];
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
				});
			}else{
				id=rowIds[0];
				var newName=$("#name").val();
				if(newName!=oldName){
					$.post("${ctx}/json/roleAction!checkNameExist.action",{'rolename':newName},function(data){
						if(data.success==true){
							$("#name_alert").attr("data-content",data.msg);
							$("#name_alert").popover('show');
							return;
						}else{
							$.ajax({
								type:"POST",
								url:"${ctx}/json/roleAction!saveOrUpdate.action?role.id="+id,
								data:$("#role_form").serialize(),
								success:function(data){
									if(data.success==true){
										$('#infoModal').modal('hide');
										$("#roleList").bootgrid("reload");
										//rowIds=[];
										$.messager.show({title:'提示信息',msg:data.msg});
									}else{
										$('#infoModal').modal('hide');
										$.messager.show({title:'提示信息',msg:data.msg});
									}
								}
							});
						}
					});
				}else{
					$.ajax({
						type:"POST",
						url:"${ctx}/json/roleAction!saveOrUpdate.action?role.id="+id,
						data:$("#role_form").serialize(),
						success:function(data){
							if(data.success==true){
								$('#infoModal').modal('hide');
								$("#roleList").bootgrid("reload");
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
    		    	$.post('${ctx}/json/roleAction!delete.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#roleList").bootgrid("reload");
							 rowIds=[];
							 $.messager.show({title:'提示信息',msg:data.msg});
						 }else{
							 $.messager.show({title:'提示信息',msg:data.msg});
						 } 
					});
    		    }
    		    
    		});
		});
		//展示设置权限树
		$("#set").click(function(){
			if(rowIds.length==1){
				newNames=[];
				$("#powerTitle").html(rowname);
				$("#tableDiv").attr("class","col-sm-9");
				$("#powerPanel").show();
				var id=rowIds[0];
				loadTree(id);
			}else if(rowIds.length>1){
				var txt=  "只能选择一个设置权限的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}else{
				var txt=  "请选择要设置权限的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
		});
		//保存权限设置
		$("#savePower").click(function(){
			var menuIds=getTreeIds();
			$.post("${ctx}/json/roleAction!saveMenuByRoleId.action",{"id":rowIds[0],"ids":menuIds},function(data){
					if(data.success==true){
						$.messager.show({title:'提示信息',msg:data.msg});
						$("#tableDiv").attr("class","col-sm-12");
						$("#powerPanel").hide();
						 $("#roleList").bootgrid("reload");
						 //rowIds=[];
						 //rowname=[];
					}else{
						$.messager.show({title:'提示信息',msg:data.msg});
					}
			});
		});
		
		//加载树
		function loadTree(id){
			var setting = {//zTree基本设置 
					async: {
						enable: true,// 是否延迟加载 
						type:"post",
						url:"${ctx}/json/roleAction!showMenus.action?roleId="+id,
						autoParam:["id"],
						dataType:"json"
					},
					check: {
						enable: true,
						chkStyle: "checkbox"
					},
					data:{
						simpleDate:{
							enable:false,//数据是否采用简单 Array 格式，默认false 
							idKey:"id",
						}
					},
					callback : {
					}
				};
				$.fn.zTree.init($("#setTreeList"), setting);//初始化ZTree树结构
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
	</script>
  </body>
</html>
