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
	  		<div class='col-sm-7' id='button_div'>
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
			<div class='col-sm-5' >
				<form id='return_form' class='form-inline' role='form'>
					<div class='form-group' style="margin-bottom:10px;">
						 <label>IP地址:</label>
						 <div style="display: inline-block;">
						   	<input type='text'  name='ip'  class='form-control' id="ip" />
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
					 	<button type="reset"  class="btn btn-info"  id="resetdata" style="margin-left:10px">重置</button>
				 		<button type="button"  class="btn btn-info"  id="screendata" >查看</button>
					</div>	
				</form>
			</div>
  			<div class="col-sm-12" style="margin-top:20px;">
			 	<table id="ipinfoList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">id</th>
				            <th data-column-id="startIp">起始地址</th>
				            <th data-column-id="endIp">终止地址</th>
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
		       			<h4 class='modal-title' id='myModalLabel'>添加/修改特殊IP地址</h4>
				      </div>
				      <div class="modal-body">
				      	<form id='ipinfoform' class='form-horizontal' role='form'>
						    <div class='row'>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>起始地址*:</label>
							    <div class='col-sm-5' id='startIp_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='ipSeg.startIp'   class='form-control' id='startIp'/>
								</div>
							  </div>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>终止地址*:</label>
							    <div class='col-sm-5' id='endIp_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text'  name='ipSeg.endIp'   class='form-control' id='endIp'/>
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
		var savaState="新增";
	 	var rowIds = [];
	 	showList();
	 	function showList(){
	 		$("#ipinfoList").bootgrid("destroy");
			$("#ipinfoList").bootgrid({
		    	ajax: true,
		        post: function (){
		        	return {
		        		ip:$("#ip").val()
		        	}
		        },
		        url: "${ctx}/json/ipSegmentAction!findByPage.action",
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
	 	};
		//查询
		$("#screendata").click(function(){
	  		/* if(ipadress!=""&&!/((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))/.test(ipadress)){
	  			var txt=  "ip地址格式不正确";
	            window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
	            return;
	  		} */
			showList();
		});
		//重置
		$("#resetdata").click(function(){
	  		$("#ip").val("");
	  		showList();
  		});
		///提示框隐藏
		$("#startIp").focus(function(){
			$("#startIp_alert").popover('hide');
		});
		$("#endIp").focus(function(){
			$("#endIp_alert").popover('hide');
		});
		//新增
		var checkSubmitFlg=false;
		$("#saveButton").click(function(){
			savaState="新增";
			$("#startIp").val("");
			$("#endIp").val("");
			$("#startIp_alert").popover('hide');
			$("#endIp_alert").popover('hide');
			$('#infoModal').modal('show');
			checkSubmitFlg=false;
		});
		//修改
		
		$("#updateButton").click(function(){
			if(rowIds.length==1){
				savaState="修改";
				$("#endIp").val("");
				$("#startIp").val("");
				$("#startIp_alert").popover('hide');
				$("#endIp_alert").popover('hide'); 
				$.post('${ctx}/json/ipSegmentAction!findById.action',{'id' : rowIds[0]}, function(data) {
					$("#endIp").val(data.ipseg.startIp);
					$("#startIp").val(data.ipseg.endIp);
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
			var startIp=$("#startIp").val();
			var endIp=$("#endIp").val();
			
			if(startIp==""){
				$("#startIp_alert").attr("data-content","起始地址不能为空");
				$("#startIp_alert").popover('show');
				return;
			}
			if(startIp.length>30){
				$("#startIp_alert").attr("data-content","起始地址长度不能超过30");
				$("#startIp_alert").popover('show');
				return;
			}
			if(endIp==""){
				$("#endIp_alert").attr("data-content","终止地址不能为空");
				$("#endIp_alert").popover('show');
				return;
			}
			if(endIp.length>30){
				$("#endIp_alert").attr("data-content","终止地址长度不能超过30");
				$("#endIp_alert").popover('show');
				return;
			}
			if(savaState=="新增"){
				if(checkSubmitFlg==true){ 
					return false;
				}else{			
					$.ajax({
							type:"POST",
							url:"${ctx}/json/ipSegmentAction!saveIpSegment.action",
							data:$("#ipinfoform").serialize(),
							success:function(data){
								if(data.success==true){
									$('#infoModal').modal('hide');
									$("#ipinfoList").bootgrid("reload");
									$.messager.show({title:'提示信息',msg:data.msg});
								}else{
									$('#infoModal').modal('hide');
									$.messager.show({title:'提示信息',msg:data.msg});
								}
								checkSubmitFlg=true;	
							}
							
						});					
				}				 
			}else{
				//id=rowIds[0];
				$.ajax({
					type:"POST",
					url:"${ctx}/json/ipSegmentAction!saveIpSegment.action?ipSeg.id="+rowIds[0],
					data:$("#ipinfoform").serialize(),
					success:function(data){
						if(data.success==true){
							$('#infoModal').modal('hide');
							$("#ipinfoList").bootgrid("reload");
							//rowIds=[];
							$.messager.show({title:'提示信息',msg:data.msg});
						}else{
							$('#infoModal').modal('hide');
							$.messager.show({title:'提示信息',msg:data.msg});
						}
					}
				});	 
			}	  	   
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
    		    	$.post('${ctx}/json/ipSegmentAction!deleteIpSegment.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#ipinfoList").bootgrid("reload");
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
