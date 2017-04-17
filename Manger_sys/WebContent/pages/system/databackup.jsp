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
			     <a id='backupButton'    class='a-btn btn-success'>
				     <span class='glyphicon glyphicon-floppy-open' ></span>
				     <span class='a-btn-slide-text'>备&nbsp;&nbsp;&nbsp;&nbsp;份</span>
				 </a>
				 <a id='recoveryButton'  class='a-btn btn-primary'>
				     <span class='glyphicon glyphicon-floppy-save' ></span>
				     <span class='a-btn-slide-text'>恢&nbsp;&nbsp;&nbsp;&nbsp;复</span>
				 </a>
				 <a id='onloadButton'  class='a-btn btn-info'>
				     <span class='glyphicon glyphicon-download-alt' ></span>
				     <span class='a-btn-slide-text'>下&nbsp;&nbsp;&nbsp;&nbsp;载</span>
				 </a>   
			</div>
  			<div class="col-sm-12" style="margin-top:20px;">
			 	<table id="databackList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				        	<th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">编号</th>
				            <th data-column-id="backupDate" data-formatter="backupDate">备份时间</th>
				            <th data-column-id="username">备份人</th>
				            <th data-column-id="filePath">备份选项</th>
				        </tr>
				     </thead>
				</table>
			</div>
		</div>
    <!-- 备份数据包模态框 -->
		<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
				      <div class="modal-header" >
				      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
		       			<h4 class='modal-title' id='myModalLabel'>数据包选择</h4>
				      </div>
				      <div class="modal-body">
				      	<form id='backuppackage_form' class='form-horizontal' role='form' enctype='multipart/form-data'>
						    <div class='row'>
							    <div class='form-group'>
								    <label  class='col-sm-3 control-label'>备份数据包*:</label>
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
		$("#databackList").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/dataBackUpAction!findByPage.action",
	        selection: true,
	        multiSelect: true,
	        rowSelect: true,
	        rowCount:10,
	        navigation:2,
	        formatters: {
	            "backupDate": function(column, row)
	            {
	            	var backupDate=row.backupDate;
	                return backupDate.replace("T", " ");
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
		$('#backuppackage').focus(function(){
			$('#backuppackage_alert').popover('hide');
		});
		//数据备份
		$("#backupButton").click(function(){
			$.post('${ctx}/json/dataBackUpAction!backup.action',function(data) {
				if(data.success==true){
					$.messager.show({title:'提示信息',msg:data.msg});
					$("#databackList").bootgrid("reload");
				}else{
					$.messager.show({title:'提示信息',msg:data.msg});
				}	
			});
			
		});
		
		//数据恢复
		var checkSubmitFlg=false;
		$("#recoveryButton").click(function(){
			checkSubmitFlg=false;
			$('#backuppackage_alert').popover('hide');
			$("#backuppackage").val("");
			$('#infoModal').modal('show');
		});
		
		//保存
		function save(){
			if(checkSubmitFlg ==true){ 
				return false;
			}else{
				 $('#backuppackage_form').ajaxSubmit({  
					type:"POST",
					url:"${ctx}/json/dataBackUpAction!recovery.action",	
					success:function(data){								
						if(data.success==true){									
							$('#infoModal').modal('hide');
							$("#databackList").bootgrid("reload");
							rowIds=[];
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
			if(rowIds.length==0){
				var txt=  "请选择要下载的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			if(rowIds.length>1){
				var txt=  "请选择一个下载";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			$.confirm({
    		    title: '提示信息!',
    		    content: '是否下载此安装包？',
    		    confirm: function(){   		    	
    		    	 window.location.href ="${ctx}/json/dataBackUpAction!downLoad.action?id="+rowIds[0]; 
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
