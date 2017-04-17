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
  	#treeList{margin-top:20px}
  </style>
  <body>
  	<div class="container-fluid">
	  	<div class="row" id="buttonDiv">
	  	</div>
	  	<div  class="row">
	  		<div class='col-sm-12'>
		  		<ul id="treeList" class="ztree" style="width: 80%" ></ul>
	  		</div>
	  	</div>
  	</div>
  	<!-- 添加和修改模态框  -->
  	<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
	  	<div class="modal-dialog" role="document">
		      <div class="modal-content">
			      <div class="modal-header">
			      	<button type='button' class='close' data-dismiss='modal' aria-label='Close' onclick='colse()'><span aria-hidden='true'>&times;</span></button>
	       			<h4 class='modal-title' id='myModalLabel'>添加/修改菜单信息</h4>
			      </div>
			      <div class="modal-body">
			      	<form id='menu_form' class='form-horizontal'>
					    <div class='row'>
					  	  <div class='form-group'>
						    <label  class='col-sm-3 control-label'>菜单名称*:</label>
						    <div class='col-sm-5' id='name_alert'  data-toggle='popover' data-trigger='manual'>
						      <input type='text' name='menu.name'  class='form-control' id='name'/>
						    </div>
						  </div>
						  <div class='form-group'>
						    <label  class='col-sm-3 control-label'>菜单图标:</label>
						    <div class='col-sm-5'>
						      <input type='text' name='menu.describe'  class='form-control' id='describe'/>
						    </div>
						  </div>
						  <div class='form-group'>
						    <label  class='col-sm-3 control-label'>菜单地址*:</label>
						    <div class='col-sm-5' id='address_alert'  data-toggle='popover' data-trigger='manual'>
								<input type='text' name='menu.address'  class='form-control' id='address'/>
						    </div>
						  </div>
						  <div class='form-group'>
						    <label  class='col-sm-3 control-label'>菜单序号*:</label>
						    <div class='col-sm-5' id='seq_alert'  data-toggle='popover' data-trigger='manual'>
								<input type='text' name='menu.seq'  class='form-control' id='seq'/>
						    </div>
						 </div>
						<div class='form-group'>
						    <label  class='col-sm-3 control-label'>菜单类型*:</label>
						    <div class='col-sm-5'>
						    	<select name='menu.type' class='form-control' id='type'>
						    	<option value='菜单' id='type_select_01' selected='selected'>菜单</option>
						    	<option value='页面' id='type_select_02'>页面</option></select>
						    </div>
						</div>
						<div class='form-group'>  
						    <label  class='col-sm-3 control-label'>上级菜单*:</label>
						    <div class='col-sm-5'>
								<input type='text'  class='form-control' id='parent' readonly/>
								<input type='hidden' name='parentId' id='parentId'/>
								<div id='menuContent' class='menuContent' style='display:none; position: absolute;'>
									<ul id='menuTree' class='ztree menuTree' style='margin-top:0; width:230px;'></ul>
								</div>
						    </div> 
						 </div>
						 <p class='col-sm-offset-2'>备注：上级菜单不选择则为父级菜单</p>
					   </div>
					</form>;
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
		//添加按钮
		var html="<div class='col-sm-12' id='button_div'>"+
				     "<a id='saveButton'  class='a-btn btn-success'>"+
						 "<span class='glyphicon glyphicon-plus' ></span>"+
						 "<span class='a-btn-slide-text'>添&nbsp;&nbsp;&nbsp;&nbsp;加</span>"+
					"</a>"+
					"<a id='updateButton'  class='a-btn btn-info'>"+
						 "<span class='glyphicon glyphicon-pencil' ></span>"+
						 "<span class='a-btn-slide-text'>修&nbsp;&nbsp;&nbsp;&nbsp;改</span>"+
					"</a>"+
				    "<a id='delButton'  class='a-btn btn-default active'>"+
				     	"<span class='glyphicon glyphicon-trash' ></span>"+
				     	 "<span class='a-btn-slide-text'>删&nbsp;&nbsp;&nbsp;&nbsp;除</span>"+
				    "</a>"+
				"</div>";
		$("#buttonDiv").html(html);
		
		//加载上级菜单树
		$('#parent').click(function(){
			$('#menuContent').show();
			var setting = {
				async: {
					enable: true,
					type:'post',
					url:'${ctx}/json/menuAction!getMenuTree.action',
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
					onClick:function(e, treeId, treeNode) {
						$('#parentId').val(treeNode.id);
						$('#parent').val(treeNode.name);
					}
				}
			};
			$.fn.zTree.init($('#menuTree'), setting);
			$('body').bind('mousedown', onBodyDown);
		});
		function onBodyDown(event){
			if(!(event.target.id == 'parent' || event.target.id == 'menuContent' || $(event.target).parents('#menuContent').length>0)){
				$('#menuContent').hide();
			}
		}
		
		$('#name').focus(function(){
			$('#name_alert').popover('hide');
		});
		$('#address').focus(function(){
			$('#address_alert').popover('hide');
		});
		$('#seq').focus(function(){
			$('#seq_alert').popover('hide');
		});
       
       	//添加
       	var checkSubmitFlg=false;
		$("#saveButton").click(function(){
			rowId="";
			checkSubmitFlg=false;
			$("#address_alert").popover('hide');
			$("#seq_alert").popover('hide');
			$("#name_alert").popover('hide');
			$("#name").val("");
			$("#describe").val("");
			$("#seq").val("");
			$("#address").val("");
			$("#parent").val("");
			$('#infoModal').modal('show');
		});
		
		//修改回显
		var oldName;
		$("#updateButton").click(function(){
			$("#name_alert").popover('hide');
			$("#address_alert").popover('hide');
			$("#seq_alert").popover('hide');
			$("#parent").val("");
			if(rowId!=""){
				$.post('${ctx}/json/menuAction!callBackMenu.action',{id:rowId},function(data){
					$("#name").val(data.menu.name);
					oldName=data.menu.name;
					$("#describe").val(data.menu.describe);
					$("#seq").val(data.menu.seq);
					$("#address").val(data.menu.address);
					if(data.menu.parent!=null){
						$("#parentId").val(data.menu.parent.id);
						$("#parent").val(data.menu.parent.name);
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
			var seq=$("#seq").val();
			var address=$("#address").val();
			var type=$("#type").val();
			if(name==""){
				$("#name_alert").attr("data-content","菜单名称不能为空");
				$("#name_alert").popover('show');
				return;
			}
			if(type=="菜单"){
				$("#address_alert").popover('hide');
			}else{
				if(address==""){
					$("#address_alert").attr("data-content","菜单地址不能为空");
					$("#address_alert").popover('show');
					return;
				}else{
					if(address.length>100){
						$("#address_alert").attr("data-content","菜单地址长度不能大于100");
						$("#address_alert").popover('show');
						return;
					}
				}
			}
			if(seq==""){
				$("#seq_alert").attr("data-content","序号不能为空");
				$("#seq_alert").popover('show');
				return;
			}else{
				if(!/^\d+(\.\d+)?$/i.test(seq)){
					$("#seq_alert").attr("data-content","序号只能为数值");
					$("#seq_alert").popover('show');
					return;
				}
			}
			if(null==rowId || rowId==""){
				$.post("${ctx}/json/menuAction!checkNameExist.action",{'name':name},function(data){
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
								url:"${ctx}/json/menuAction!saveOrUpdate.action",
								data:$("#menu_form").serialize(),
								success:function(data){
									if(data.success==true){
										$('#infoModal').modal('hide');
										var treeObj = $.fn.zTree.getZTreeObj("treeList");
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
				var newName=$("#name").val();
				if(newName!=oldName){
					$.post("${ctx}/json/menuAction!checkNameExist.action",{'name':newName},function(data){
						if(data.success==true){
							$("#name_alert").attr("data-content",data.msg);
							$("#name_alert").popover('show');
							return;
						}else{
							$.ajax({
								type:"POST",
								url:"${ctx}/json/menuAction!saveOrUpdate.action?id="+rowId,
								data:$("#menu_form").serialize(),
								success:function(data){
									if(data.success==true){
										$('#infoModal').modal('hide');
										var treeObj = $.fn.zTree.getZTreeObj("treeList");
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
						url:"${ctx}/json/menuAction!saveOrUpdate.action?id="+rowId,
						data:$("#menu_form").serialize(),
						success:function(data){
							if(data.success==true){
								$('#infoModal').modal('hide');
								var treeObj = $.fn.zTree.getZTreeObj("treeList");
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
    		    	$.post('${ctx}/json/menuAction!delete.action',{'id':rowId},function(data){
						 if(data.success==true){
							 var treeObj = $.fn.zTree.getZTreeObj("treeList");
							 treeObj.reAsyncChildNodes(null, "refresh");
							 $.messager.show({title:'提示信息',msg:data.msg});
						 }else{
							 $.messager.show({title:'提示信息',msg:data.msg});
						 } 
					});
    		    }
    		    
    		});
		});
		
		//模态框关闭
		function colse(){
			$('body').unbind('mousedown');
		}
	</script>
  </body>
</html>
