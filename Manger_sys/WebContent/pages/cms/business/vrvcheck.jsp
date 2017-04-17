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
				 <a id='recoveryButton'  class='a-btn btn-primary'  >
				     <span class='glyphicon glyphicon-arrow-up' ></span>
				     <span class='a-btn-slide-text'>上传VRV表格</span>
				 </a>
				 <a id='onloadButton'  class='a-btn btn-success' >
				     <span class='glyphicon glyphicon-arrow-down' ></span>
				     <span class='a-btn-slide-text'>下载最新结果表格</span>
				 </a>   
			</div>
  			<div class="col-sm-12" id="showlist" style="margin-top:20px;display:none">
			 	<table id="databackList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				        	<th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">编号</th>
				            <th data-column-id="area">所属区域</th>
				            <th data-column-id="company">单位名称</th>
				            <th data-column-id="dep">部门名称</th>
				            <th data-column-id="user">使用人</th>
				            <th data-column-id="tel">联系电话</th>
				            <th data-column-id="ip">IP地址</th>
				            <th data-column-id="mac">MAC地址</th>
				            <th data-column-id="name">设备名称</th>
				            <th data-column-id="type">设备类型</th>
				            <th data-column-id="address">设备地址</th>
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
		       			<h4 class='modal-title' id='myModalLabel'>上传VRV设备表</h4>
				      </div>
				      <div class="modal-body">
				      	<form id='backuppackage_form' class='form-horizontal' role='form' enctype='multipart/form-data'>
						    <div class='row'>
							    <div class='form-group'>
								    <label  class='col-sm-3 control-label'>VRV设备表*:</label>
								    <div class='col-sm-7' id='backuppackage_alert'  data-toggle='popover' data-trigger='manual'>
								      <input type='file' name='upload'  class='form-control' id='backuppackage'/>
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
	 	var rowIds = [];
	 	function listshow(){
	 		$("#databackList").bootgrid("destroy");
			$("#databackList").bootgrid({
		    	ajax: true,
		        post: function (){},
		        url: "${ctx}/json/vrvCheckAction!excelSave.action",
		        selection: true,
		        multiSelect: true,
		        rowSelect: true,
		        rowCount:10,
		        navigation:2,
		        formatters: {
		            "datetime": function(column, row)
		            {
		            	var dataTime=row.datetime;
		                return dataTime.substr(0, 10);
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
		};
		$('#backuppackage').focus(function(){
			$('#backuppackage_alert').popover('hide');
		});
		var checkSubmitFlg=false;
		//上传vrv数据表
		$("#recoveryButton").click(function(){
			$('#backuppackage_alert').popover('hide');
			$("#backuppackage").val("");
			$('#infoModal').modal('show');
			checkSubmitFlg=false;
		});	
		//保存
		function save(){
			if(checkSubmitFlg==true){ 
				return false;
			}else{
				 $('#backuppackage_form').ajaxSubmit({  
					type:"POST",
					url:"${ctx}/json/vrvCheckAction!excelSave.action",	
					success:function(data){
						if(data.success==true){	
							$('#infoModal').modal('hide');
							$("#databackList").bootgrid("reload");
							$("#showlist").show();
							listshow();
							$.messager.show({title:'提示信息',msg:data.msg});
						}else{
							$('#infoModal').modal('hide');
							$.messager.show({title:'提示信息',msg:data.msg});
						}
						checkSubmitFlg=true;
					}
				});
			}
		};	

		
		//数据下载
		$("#onloadButton").click(function(){
			$.confirm({
    		    title: '提示信息!',
    		    content: '是否下载最新结果表格？',
    		    confirm: function(){   		    	
    		    	window.location = '${ctx}/json/vrvCheckAction!getCheckExcel.action';
    		    }
			});	
    	});
		document.onkeydown=function(){
			 if(event.keyCode==13)
          {
              event.returnValue=false;
          }
		};
		
	</script>
  </body>
</html>
