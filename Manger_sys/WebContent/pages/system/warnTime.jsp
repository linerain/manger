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
  			<div class="col-sm-12" >
			 	<table id="formate_List" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				        	<th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">编号</th>
				            <th data-column-id="name">名称</th>		
				            <th data-column-id="code">编码</th> 
				            <th data-column-id="param">参数</th>	
				            <th data-column-id="nuit">单位</th>				       
				        </tr>
				    </thead>
				</table>
			</div>
		</div>
	</div>
	<!-- 添加和修改模态框 -->
	<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog" role="document">
		      <div class="modal-content">
			      <div class="modal-header" >
			      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
	       		    <h4 class='modal-title' id='myModalLabel'>信息修改</h4>
			      </div>
			      <div class="modal-body">
			      	<form id='updata_form' class='form-horizontal' role='form'>
					    	<div class='row'>
							  	  <div class='form-group'>
								    <label  class='col-sm-3 control-label'>参数*:</label>
								    <div class='col-sm-5' id='param_alert'  data-toggle='popover' data-trigger='focus'>
								      <input type='text' name='configInfo.param'  class='form-control' id='param' placeholder="只能输入数字"/>
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
		$("#formate_List").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/configInfoAction!findByPage.action",
	        selection: true,
	        multiSelect: true,
	        rowSelect: true,
	        keepSelection: true,
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
	    }).on("loaded.rs.jquery.bootgrid", function(e, rows){
	    	rowIds=[];
	    }); 
		var html="<div class='col-sm-6' id='button_div'>"+
					"<a id='updateButton'  class='btn btn-info' title='修改'>"+
			     		"<span class='glyphicon glyphicon-pencil'></span>"+
			     	"</a>"+
				"</div>";
		$("#headerRow").before(html);
		
		//修改
		$("#updateButton").click(function(){
			$("#param_alert").popover('hide');
			if(rowIds.length==1){
				$.post('${ctx}/json/configInfoAction!findById.action',{'id':rowIds[0]},function(data){
					$("#param").val(data.rows.param);				
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
			var param=$("#param").val();
		 	if(param==""){
				$("#param_alert").attr("data-content","参数不能为空");
				$("#param_alert").popover('show');
				return;
		   	}else if(!/^[0-9]*$/.test(param)){
		   		$("#param_alert").attr("data-content","参数格式不正确");
				$("#param_alert").popover('show');
				return;
		   	}			
			$.ajax({
				type:"POST",
				url:"${ctx}/json/configInfoAction!updateConfiginfo.action?id="+rowIds[0],
				data:$("#updata_form").serialize(),
				success:function(data){
					if(data.success==true){
						$('#infoModal').modal('hide');
						$("#formate_List").bootgrid("reload");
						//rowIds=[];
						$.messager.show({title:'提示信息',msg:data.msg});
					}else{
						$('#infoModal').modal('hide');
						$.messager.show({title:'提示信息',msg:data.msg});
					}
				}
			});
			
		}
	</script>
  </body>
</html>
