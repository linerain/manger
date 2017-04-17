<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
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
		    <div  id="searchDiv" >
		    	<div class='col-sm-12' >
			     	<a id='openButton'  class='a-btn btn-success' >
			     		<span class='glyphicon glyphicon-ok-circle' ></span>
			     		<span class='a-btn-slide-text'>开启扫描器</span>
			     	</a>
			     	<a id='closedButton'  class='a-btn btn-success' >
			     		<span class='glyphicon glyphicon-remove-circle' ></span>
			     		<span class='a-btn-slide-text'>关闭扫描器</span>
			     	</a>
			     	<a id='lookButton'  class='a-btn btn-info' >
			     		<span class='glyphicon glyphicon-info-sign' ></span>
			     		<span class='a-btn-slide-text'>查看扫描器记录</span>
			     	</a>
				</div>
			 </div>	
	  		<div class="col-sm-12" id="tableDiv" style="margin-top:20px;">
			 	<table id="scanList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visibleInSelection="false">编号</th>
				            <th data-column-id="startIp" >扫描起始ip</th>	
				            <th data-column-id="endIp">扫描结束ip</th>
				            <th data-column-id="cmsPort">辰信易端口号</th>
				            <th data-column-id="state"  data-formatter="state">开启状态</th>
				        </tr>
				    </thead>		  
				</table>
  			</div> 		
  		</div>
  	</div>
	  	<!-- 详细信息 -->
	  	<div class="modal fade bs-example-modal-lg" id="detailsModel" tabindex="-1" role="dialog" aria-labelledby="detailinforLabelLg" data-backdrop="static" data-keyboard="false">
	  		<div class="modal-dialog modal-lg" role="document">
				  <div class="modal-content">
					  <div class="modal-header" >
					  	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true' >&times;</span></button>
			     		<h4 class='modal-title' id='detailinforLabel'>详细信息</h4>
					  </div>
					  <div class="modal-body" id="detailinfor-bodyLg">
					  			<table id="scanTable" class="table table-condensed table-hover table-striped" ajax="true">
								    <thead>
								        <tr>
								            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visibleInSelection="false">编号</th>
								            <th data-column-id="clientIp">记录所在客户端ip</th>
								             <th data-column-id="os">操作系统类型</th>
								             <th data-column-id="name">计算机名称</th>
								       		 <th data-column-id="cmsState" data-formatter="cmsState">辰信易是否安装</th>
								       		 <th data-column-id="date">记录日期</th>
								       		 <th data-column-id="state">是否在线</th>
								        </tr>
								    </thead>		  
								</table>
					  </div>
					  <div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					  </div>
				 </div>
			</div>
	  	</div>
	<script type="text/javascript">
 		var rowIds = [];
 		$("#scanList").bootgrid("destroy");
		$("#scanList").bootgrid({
	    	ajax: true,
	        url: "${ctx}/json/scanAction!findByPage.action",
	        selection: true,
	        multiSelect: true,
	        rowSelect:true,
	        rowCount:10,
	        navigation:2,
	        formatters: {
	            "state": function(column, row){
	            	if(row.state==true){
	            		return "开启";
	            	}else{
	            		return "关闭";
	            	}
	            	return "";
	            }
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
		//开启
		$("#openButton").click(function(){
			if(rowIds.length==0){
				var txt="请选择要开启的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			$.confirm({
    		    title: '提示信息!',
    		    content: '你确定要开启扫描器吗？',
    		    confirm: function(){
    		    	$.post('${ctx}/json/scanAction!startScan.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#scanList").bootgrid("reload");
							 $.messager.show({title:'提示信息',msg:data.msg});
						 }else{
							 $.messager.show({title:'提示信息',msg:data.msg});
						 } 
					});
    		    }
    		    
    		});
		});
		//关闭
		$("#closedButton").click(function(){
			if(rowIds.length==0){
				var txt="请选择要关闭的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			$.confirm({
    		    title: '提示信息!',
    		    content: '你确定要关闭扫描器吗？',
    		    confirm: function(){
    		    	$.post('${ctx}/json/scanAction!stopScan.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#scanList").bootgrid("reload");
							 $.messager.show({title:'提示信息',msg:data.msg});
						 }else{
							 $.messager.show({title:'提示信息',msg:data.msg});
						 } 
					});
    		    }
    		    
    		});
		});
		//查看记录
		 $("#lookButton").click(function(){   
	     	if(rowIds.length==0){
				window.wxc.xcConfirm("请选择要查看的扫描器", window.wxc.xcConfirm.typeEnum.info);
				return;
			}
	    	if(rowIds.length>1){
				window.wxc.xcConfirm("只能选择一个扫描器", window.wxc.xcConfirm.typeEnum.info);
				return;
			}  
			$("#scanTable").bootgrid({
		    	ajax: true,
		        url: "${ctx}/json/scanValueAction!findByPage.action?scanId="+rowIds[0],
		        rowCount:10,
		        navigation:2,
		        formatters: {
		            "cmsState": function(column, row){
		            	if(row.cmsState==true){
		            		return "安装";
		            	}else{
		            		return "未安装";
		            	}
		            	return "";
		            }
		        }
			});	
			$("#detailsModel").modal('show');			
		});
	</script>
  </body>
</html>
