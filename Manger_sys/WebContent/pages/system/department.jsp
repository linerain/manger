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
  	#depList{margin-top:20px}
  </style>
  <body>
  	<div class="container-fluid">
	  	<div class="row" id="buttonDiv">
	  	</div>
	  	<div  class="row">
	  		<div class='col-sm-12'>
		  		<ul id="depList" class="ztree" style="width: 80%" ></ul>
	  		</div>
	  	</div>
  	</div>
  	<!-- 添加和修改模态框 -->
  	<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog" role="document">
		      <div class="modal-content">
			      <div class="modal-header" >
			      	<button type='button' class='close' data-dismiss='modal' aria-label='Close' onclick='colse()'><span aria-hidden='true'>&times;</span></button>
	       			<h4 class='modal-title' id='myModalLabel'>添加/修改菜单信息</h4>
			      </div>
			      <div class="modal-body">
			      	<form id='dep_form' class='form-horizontal'>
					    	<div class='row'>
						  	  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>组织机构名称*:</label>
							    <div class='col-sm-5' id='name_alert'  data-toggle='popover' data-trigger='manual'>
							      <input type='text' name='department.name'  class='form-control' id='name'/>
							    </div>
							  </div>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>组织机构编码*:</label>
							    <div class='col-sm-5' id='deparCoding_alert'  data-toggle='popover' data-trigger='manual'>
							      <input type='text' name='department.deparCoding'  class='form-control' id='deparCoding'/>
							    </div>
							  </div>
							<div class='form-group'>
							    <label  class='col-sm-3 control-label'>组织机构类型*:</label>
							    <div class='col-sm-5'>
							    	<select name='department.type' class='form-control' id='type'>
							    	<option value='公司' id='type_select_01' selected='selected'>公司</option>
							    	<option value='部门' id='type_select_02'>部门</option></select>
							    </div>
							</div>
							<div class='form-group'>  
							    <label  class='col-sm-3 control-label'>上级机构*:</label>
							    <div class='col-sm-5' id='parent_alert' data-toggle='popover' data-trigger='manual'>
									<input type='text'  class='form-control' id='parent' readonly/>
									<input type='hidden' name='parentId' id='parentId'/>
									<div id='depContent' class='menuContent' style='display:none; position: absolute;z-index:9999'>
										<ul id='depTree' class='ztree menuTree' style='margin-top:0; width:230px;'></ul>
									</div>
							    </div> 
							 </div>
							 <div class='form-group'>
							    <label  class='col-sm-3 control-label'>组织机构描述:</label>
							    <div class='col-sm-5'  id='describe_alert' data-toggle='popover' data-trigger='manual'>
									<input type='text' name='department.describe'  class='form-control' id='describe'/>
							    </div>
							  </div>
						   </div>
						</form>
			      </div>	
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="colse()">关闭</button>
			        <button type="submit" class="btn btn-primary" onclick="save()">保存</button>
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
				url:"${ctx}/json/departmentAction!getDepartmentTree.action",
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
		$.fn.zTree.init($("#depList"), setting);//初始化ZTree树结构
		//添加按钮
		var html="<div class='col-sm-12' id='button_div'>"+
				     "<a id='saveButton'  class='a-btn btn-success' title='添加'>"+
						 "<span class='glyphicon glyphicon-plus' ></span>"+
						 "<span class='a-btn-slide-text'>添&nbsp;&nbsp;&nbsp;&nbsp;加</span>"+
					"</a>"+
					"<a id='updateButton'  class='a-btn btn-info'  title='修改'>"+
						 "<span class='glyphicon glyphicon-pencil' ></span>"+
						 "<span class='a-btn-slide-text'>修&nbsp;&nbsp;&nbsp;&nbsp;改</span>"+
					"</a>"+
				     "<a id='delButton'  class='a-btn btn-default active'  title='删除'>"+
				     	"<span class='glyphicon glyphicon-trash' ></span>"+
				     	"<span class='a-btn-slide-text'>删&nbsp;&nbsp;&nbsp;&nbsp;除</span>"+
				     "</a>"+
				"</div>";
		$("#buttonDiv").html(html);
		
		//上级机构树
		$('#parent').click(function(){
			$('#depContent').show();
			var setting = {
				async: {
					enable: true,
					type:'post',
					url:'${ctx}/json/departmentAction!getDepartmentTree.action',
					autoParam:['id'],
					dataType:'json'
				},
				data:{
					simpleDate:{
						enable:false,
						idKey:'id',
					}
				},
				callback : {
					beforeClick:function(treeId, treeNode, clickFlag){
						if($('#type').val()=='公司' && treeNode.type=='部门'){
							var txt='部门下不能添加公司';
							window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
							return false;
						}
					},
					onClick:function(e, treeId, treeNode) {
						$('#parentId').val(treeNode.id);
						$('#parent').val(treeNode.name);
					}
				}
			};
			$.fn.zTree.init($('#depTree'), setting);
			$('body').bind('mousedown', onBodyDown);
		});
		function onBodyDown(event){
			if(!(event.target.id == 'parent' || event.target.id == 'depContent' || $(event.target).parents('#depContent').length>0)){
				$('#depContent').hide();
			}
		}
		$('#name').focus(function(){
			$('#name_alert').popover('hide');
		});
		$('#parent').focus(function(){
			$('#parent_alert').popover('hide');
		});
		$('#deparCoding').focus(function(){
			$('#deparCoding_alert').popover('hide');
		});
		$('#describe').focus(function(){
			$('#describe_alert').popover('hide');
		});
       
       	//添加
       	var checkSubmitFlg=false;
		$("#saveButton").click(function(){
			rowId="";
			checkSubmitFlg=false;
			$("[id$=_alert]").popover('hide');
			$("#name").val("");
			$("#describe").val("");
			$("#deparCoding").val("");
			$("#parent").val("");
			$('#parentId').val("");
			$("#type_select_01").attr("selected","selected");
			$('#infoModal').modal('show');
		});
		
		//修改回显
		var oldDeparCoding;
		$("#updateButton").click(function(){
			if(rowId!=""){
				$("[id$=_alert]").popover('hide');
				$("#parentId").val("");
				$("#parent").val("");
				$.post('${ctx}/json/departmentAction!findById.action',{id:rowId},function(data){
					$("#name").val(data.dep.name);
					$("#describe").val(data.dep.describe);
					$("#deparCoding").val(data.dep.deparCoding);
					oldDeparCoding=data.dep.deparCoding;
					var type=data.dep.type;
					if(type=="公司"){
						$("#type").val("公司");
						$("#type_select_01").attr("selected","selected");
						$("#type_select_02").removeAttr("selected");
					}else if(type=="部门"){
						$("#type").val("部门");
						$("#type_select_02").attr("selected","selected");
						$("#type_select_01").removeAttr("selected");
					}
					if(data.dep.parent!=null && data.dep.parent!="" ){
						$("#parentId").val(data.dep.parent.id);
						$("#parent").val(data.dep.parent.name);
					}
				});
				$('#infoModal').modal('show');
			}else{
				var txt=  "请选择要修改的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			
			
		});
		//保存修改
		function save(){
			var name=$("#name").val();
			var deparCoding=$("#deparCoding").val();
			$("#deparCoding_alert").popover('hide');
			$("#parent_alert").popover('hide');
			var type=$("#type").val();
			var parentId=$("#parentId").val();
			var deparent=$("#parent").val();
			var describe=$("#describe").val();
			if(name==""){
				$("#name_alert").attr("data-content","组织机构名称不能为空");
				$("#name_alert").popover('show');
				return;
			}
			if(name.length>30){
				$("#name_alert").attr("data-content","组织机构名称长度不能超过30");
				$("#name_alert").popover('show');
				return;
			}
			if(deparCoding==""){
				$("#deparCoding_alert").attr("data-content","组织机构编码不能为空");
				$("#deparCoding_alert").popover('show');
				return;
			}
			if(deparCoding.length>30){
				$("#deparCoding_alert").attr("data-content","组织机构编码长度不能超过30");
				$("#deparCoding_alert").popover('show');
				return;
			}
			if(type=="部门"&&deparent==""){
				$("#parent_alert").attr("data-content","请选择上级机构");
				$("#parent_alert").popover('show');
				return;
			}
			if(describe.length>30){
				$("#describe_alert").attr("data-content","组织机构描述长度不能超过100");
				$("#describe_alert").popover('show');
				return;
			}
			if(null==rowId || rowId==""){
				$.post("${ctx}/json/departmentAction!checkCodeExist.action",{'code':deparCoding},function(data){
					if(data.success==true){
						$("#deparCoding_alert").attr("data-content",data.msg);
						$("#deparCoding_alert").popover('show');
						return;
					}else{
						if(checkSubmitFlg ==true){ 
							return false;
						}else{
							$.ajax({
								type:"POST",
								url:"${ctx}/json/departmentAction!saveOrUpdateDepartment.action?type="+type+"&parentId="+parentId,
								data:$("#dep_form").serialize(),
								success:function(data){
									if(data.success==true){
										$('#infoModal').modal('hide');
										var treeObj = $.fn.zTree.getZTreeObj("depList");
										treeObj.reAsyncChildNodes(null, "refresh");
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
			}else{
				var newDeparCoding=$("#deparCoding").val();
				if(newDeparCoding!=oldDeparCoding){
					$.post("${ctx}/json/departmentAction!checkCodeExist.action",{'code':newDeparCoding},function(data){
						if(data.success==true){
							$("#deparCoding_alert").attr("data-content",data.msg);
							$("#deparCoding_alert").popover('show');
							return;
						}else{
							$.ajax({
								type:"POST",
								url:"${ctx}/json/departmentAction!saveOrUpdateDepartment.action?id="+rowId+"&type="+type+"&parentId="+parentId,
								data:$("#dep_form").serialize(),
								success:function(data){
									if(data.success==true){
										$('#infoModal').modal('hide');
										var treeObj = $.fn.zTree.getZTreeObj("depList");
										treeObj.reAsyncChildNodes(null, "refresh");
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
					});
				}else{
					$.ajax({
						type:"POST",
						url:"${ctx}/json/departmentAction!saveOrUpdateDepartment.action?id="+rowId+"&type="+type+"&parentId="+parentId,
						data:$("#dep_form").serialize(),
						success:function(data){
							if(data.success==true){
								$('#infoModal').modal('hide');
								var treeObj = $.fn.zTree.getZTreeObj("depList");
								treeObj.reAsyncChildNodes(null, "refresh");
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
		}
		
		//删除
		$("#delButton").click(function(){
			if(rowId==""){
				var txt=  "请选择要删除的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			$.confirm({
    		    title: '提示信息!',
    		    content: '你确定要删除这些数据吗？',
    		    confirm: function(){
    		    	$.post('${ctx}/json/departmentAction!deleteDepartment.action',{'id':rowId},function(data){
						 if(data.success==true){
							 var treeObj = $.fn.zTree.getZTreeObj("depList");
							 treeObj.reAsyncChildNodes(null, "refresh");
							 $.messager.show({title:'提示信息',msg:data.msg});
						 }else{
							 $.messager.show({title:'提示信息',msg:data.msg});
						 } 
					});
    		    }
    		    
    		});
		});
		
		//关闭
		function colse(){
			$('body').unbind('mousedown');
		}
	</script>
  </body>
</html>
