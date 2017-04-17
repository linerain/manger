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
			 	<table id="whiteList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">id</th>
				            <th data-column-id="name">名称</th>
				            <th data-column-id="itemList">进程</th>
				            <th data-column-id="remark">备注</th>
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
		       			<h4 class='modal-title' id='myModalLabel'>添加/修改白名单信息</h4>
				      </div>
				      <div class="modal-body">
				      	<form id='whiteform' class='form-horizontal' role='form'>
						    <div class='row'>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>名称*:</label>
							    <div class='col-sm-5' id='name_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='processGroupPageModel.name'   class='form-control' id='name'/>
								</div>
							  </div>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>备注:</label>
							    <div class='col-sm-5' id='remark_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text'  name='processGroupPageModel.remark'   class='form-control' id='remark'/>
							    </div>
							  </div>
							  <input type="hidden" name="processGroupPageModel.type" value="1"/>
							  <div class='form-group'   id='addinput'>
							  		<div class='col-sm-offset-3 col-sm-5' >
							    		<button type="button" class='col-sm-12 btn btn-info' id="addport">添加白名单</button>   
							  		</div>
							  </div>
							  <div id="portgroup"> 
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
		$("#whiteList").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/processGroupAction!findWhiteGroupByPage.action",
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
		var index=1;//端口组的次序
		$("#addport").click(function(){
			var html="<div class='form-group' id='itemdiv_"+index+"'>"+
						"<div class='col-sm-5 col-sm-offset-3' id='item"+index+"_alert'  data-toggle='popover' data-trigger='manual'>"+
							"<input type='text'  name='itemList'   class='form-control' id='item"+index+"' onfocus='hiddenalert("+index+")'/>"+
						"</div>"+
						" <button type='button' class=' btn btn-danger col-sm-1' id='del"+index+"' onclick='delGroup("+index+")'>删除</button>"+
					 "</div>";
			$("#portgroup").append(html);
			index++;
		});
		//删除端口组的文本框
		function delGroup(num){
			$("#itemdiv_"+num).remove();
			index--;
		}
		//点击input框让提示消失
		function hiddenalert(num){
			$("#item"+num+"_alert").popover('hide');
		}
		///提示框隐藏
		$("#name").focus(function(){
			$("#name_alert").popover('hide');
		});
		$("#remark").focus(function(){
			$("#remark_alert").popover('hide');
		});
		//新增
		var checkSubmitFlg=false;
		$("#saveButton").click(function(){
			savaState="新增";
			index=1;
			$("#portgroup").empty();
			$("#remark_alert").popover('hide');
			$("#name_alert").popover('hide');
			$("#remark").val("");
			$("#name").val("");
			$('#infoModal').modal('show');
			checkSubmitFlg=false;
		});
		//修改
		var oldname="";
		$("#updateButton").click(function(){
			if(rowIds.length==1){
				savaState="修改";
				$("#remark_alert").popover('hide');
				$("#name_alert").popover('hide');
				$("#portgroup").empty();
				index=1;
				$.post('${ctx}/json/processGroupAction!findById.action',{'id':rowIds[0]}, function(data) {
					$("#name").val(data.groupPageModel.name);
					oldname=data.groupPageModel.name;
					$("#remark").val(data.groupPageModel.remark);
					var items=data.groupPageModel.itemList;
					if(null!=items && ""!=items){
						var item=items.split(",");
						for(var i=1;i<=item.length;i++){
							var html="<div class='form-group' id='itemdiv_"+i+"'>"+
								"<div class='col-sm-5 col-sm-offset-3' id='item"+i+"_alert'  data-toggle='popover' data-trigger='manual'>"+
									"<input type='text'  name='item'   class='form-control' value='"+item[i-1]+"' id='item"+i+"' onfocus='hiddenalert("+i+")'/>"+
								"</div>"+
								" <button type='button' class=' btn btn-danger col-sm-1' id='del"+i+"' onclick='delGroup("+i+")'>删除</button>"+
							 "</div>";
							$("#portgroup").append(html);
						}
						index=item.length+1;
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
			var remark=$("#remark").val();
			var name=$("#name").val();
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
			if(remark.length>30){
				$("#remark_alert").attr("data-content","备注长度不能超过30");
				$("#remark_alert").popover('show');
				return;
			}
			var items="";
			for(var i=1;i<=index-1;i++){
				var item=$("#item"+i).val();
				if(item==""){
					$("#item"+i+"_alert").attr("data-content","名单不能为空");
					$("#item"+i+"_alert").popover('show');
					return;
				}
				if(item.length>30){
					$("#item"+i+"_alert").attr("data-content","名单长度不能超过30");
					$("#item"+i+"_alert").popover('show');
					return;
				}
				items+=item+",";
			}
			items=items.substring(0,items.length-1);
			$.post('${ctx}/json/processGroupAction!checkWhiteNameExist.action',{'name':name},function(datamap){
				if(savaState=="新增"){
					if(checkSubmitFlg==true){ 
						return false;
					}else{
						if(datamap.success==true){
							 $.messager.show({title:'提示信息',msg:datamap.msg});
							 return;
						 }else{
							$.ajax({
									type:"POST",
									url:"${ctx}/json/processGroupAction!save.action",
									/* data:$("#whiteform").serialize(), */
									data:{"processGroupPageModel.type":1,"processGroupPageModel.name":$("#name").val(),"processGroupPageModel.remark":$("#remark").val(),"processGroupPageModel.itemList":items},
									success:function(data){
										if(data.success==true){
											$('#infoModal').modal('hide');
											$("#whiteList").bootgrid("reload");
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
					if(datamap.success==true&&oldname!=name){
						 $.messager.show({title:'提示信息',msg:datamap.msg});
						 return;
					 }else{
						$.ajax({
							type:"POST",
							url:"${ctx}/json/processGroupAction!update.action?processGroupPageModel.id="+rowIds[0],
							data:{"processGroupPageModel.type":1,"processGroupPageModel.name":$("#name").val(),"processGroupPageModel.remark":$("#remark").val(),"processGroupPageModel.itemList":items},
							success:function(data){
								if(data.success==true){
									$('#infoModal').modal('hide');
									$("#whiteList").bootgrid("reload");
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
    		    	$.post('${ctx}/json/processGroupAction!delete.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#whiteList").bootgrid("reload");
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
