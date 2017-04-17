<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/pages/common/headjsp.jsp"%>

<!DOCTYPE HTML>
<html>
  <style>
  	#button_div .btn{margin-right: 6px;}
  	.panel-info {border-bottom:0;border-bottom-color: #fff;}
  	.panel-heading {padding: 4px 15px;}
  	.panel{height:94%;}
  	.powerTitle{background: #5cb85c;color: #fff;}
  	#savePowerHeader{display:none;}
  	#setTreeList{margin-top:18px;}
  	/* 数据列表 */
	.text-left {text-align: left;font-size: 14px;}
	.bootgrid-table th>.column-header-anchor>.text {display: block;margin: 0 16px 0 0;
    overflow: hidden;-ms-text-overflow: ellipsis;-o-text-overflow: ellipsis;
    text-overflow: ellipsis; white-space: nowrap; font-size: 14px;}
  </style>
  <body>
 	<table id="testList" class="table table-condensed table-hover table-striped" ajax="true">
	    <thead>
	        <tr>
	        	<th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">编号</th>
	            <th data-column-id="account">用户账号</th>
	            <th data-column-id="name">用户姓名</th>
	            <th data-column-id="roleName">所属角色</th>
	            <th data-column-id="departmentName">所属部门</th>
	        </tr>
	    </thead>
	</table>
	<div class='col-sm-12'>
		<ul id="treeList" class="ztree" style="width: 80%" ></ul>
	</div>
	<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
			  <div class="modal-dialog" role="document">
			      <div class="modal-content">
				      <div class="modal-header" id="modal-header">
				      	<button type='button' class='close' data-dismiss='modal' aria-label='Close' onclick='ifone.window.colse()'><span aria-hidden='true'>&times;</span></button>
       				  	<h4 class='modal-title' id='myModalLabel'>添加/修改</h4>
				      </div>
				      <div class="modal-body" id="model-body">
				      	<form id='test_form' class='form-horizontal' role='form'>
					    	<div class='row'>
							  	  <div class='form-group'>
								    <div class='col-sm-5' id='account_alert'  data-toggle='popover' data-trigger='focus'>
								      <input type='text' name='user.account'  class='form-control' id='account'/>
								    </div>
								  </div>
						</form>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="ifone.window.colse();">关闭</button>
				        <button type="button" class="btn btn-primary" onclick="save();">保存</button>
				      </div>
			     </div>
			</div> 
		 </div>
	<script type="text/javascript">
		var rowId="";
		var setting = {//zTree基本设置 
			async: {
				enable: true,// 是否延迟加载 
				type:"post",
				url:"${ctx}/json/menuAction!getMenuTree.action",
				autoParam:["id"],
				dataType:"json"
			},
			data:{
				simpleDate:{
					enable:false,//数据是否采用简单 Array 格式，默认false 
					idKey:"id",
				}
			},
			callback : {
				onClick:function(e, treeId, treeNode) {
					rowId=treeNode.id;
				}
			}
		};
		$.fn.zTree.init($("#treeList"), setting);//初始化ZTree树结构
		
		//列表
	 	var rowIds = [];
		$("#testList").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/userAction!findUsersByPage.action",
	        selection: true,
	        multiSelect: true,
	        rowSelect: true,
	        keepSelection: false,
	        rowCount:[8,10,20,25]
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
	    });
		//添加按钮
		var html="<div class='col-sm-6' id='button_div'>"+
					 "<button id='saveButton' type='button' class='btn btn-success'  >"+
				 		 "<span class='glyphicon glyphicon-plus' aria-hidden='true'></span>&nbsp;&nbsp;添加"+
				 	"</button>"+
				     "<button id='updateButton' type='button' class='btn btn-info'  >"+
				     	"<span class='glyphicon glyphicon-pencil' aria-hidden='true'></span>&nbsp;&nbsp;修改"+
				     "</button>"+
				     "<button id='delButton' type='button' class='btn btn-default'>"+
				     	"<span class='glyphicon glyphicon-trash' aria-hidden='true'></span>&nbsp;&nbsp;删除"+
				     "</button>"+
				"</div>";
		$("#headerRow").before(html);
		//添加
		$("#saveButton").click(function(){
			rowIds=[];
		/* 	$.post("${ctx}/json/roleAction!findRoles.action",function(dataMap){
				var roleList=dataMap.roles;
				var optionHtml="";
				for(var i=0;i<roleList.length;i++){
					optionHtml+="<option value='"+roleList[i].id+"'>"+roleList[i].name+"</option>";
				}
				$("#roles").html(optionHtml);
			}); */
			
			$('#infoModal').modal('show');
		});
		
		//修改回显
		$("#updateButton").click(function(){
			if(rowIds.length==1){
				$.post('${ctx}/json/userAction!getUserInfo.action',{id:rowIds[0]},function(data){
					$("#account").val(data.user.account);
					$("#name").val(data.user.name);
					$("#phone").val(data.user.phone);
					$("#email").val(data.user.email);
					$("#parent").val(data.user.department.name);
					$("#department").val(data.user.department.id);
					$("#describe").val(data.user.describe);
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
			if(null==rowIds || rowIds==""){
				var checkSubmitFlg=false;
							$.ajax({
								type:"POST",
								url:"${ctx}/json/userAction!saveOrupdate.action",
								data:$("#test_form").serialize(),
								success:function(data){
									if(data.success==true){
										$('#infoModal').modal('hide');
										$("#testList").bootgrid("reload");
										rowIds=[];
										$.messager.show({title:'提示信息',msg:data.msg});
									}else{
										$('#infoModal').modal('hide');
										$.messager.show({title:'提示信息',msg:data.msg});
									}
								}
							});
							checkSubmitFlg=true;
			}else{
				id=rowIds[0];
				$.ajax({
					type:"POST",
					url:"${ctx}/json/userAction!saveOrupdate.action?user.id="+id,
					data:parent.$("#test_form").serialize(),
					success:function(data){
						if(data.success==true){
							$('#infoModal').modal('hide');
							$("#testList").bootgrid("reload");
							rowIds=[];
							$.messager.show({title:'提示信息',msg:data.msg});
						}else{
							$('#infoModal').modal('hide');
							$.messager.show({title:'提示信息',msg:data.msg});
						}
					}
				});
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
    		    	$.post('${ctx}/json/userAction!deleteUser.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#testList").bootgrid("reload");
							 rowIds=[];
							 $.messager.show({title:'提示信息',msg:data.msg});
						 }else{
							$.messager.show({title:'提示信息',msg:data.msg});
						 } 
					});
    		    }
    		    
    		});
		});
		
		//关闭时执行
		function colse(){
			 rowIds=[];
			 $("#testList").bootgrid("reload");
		}
	</script>
  </body>
</html>
