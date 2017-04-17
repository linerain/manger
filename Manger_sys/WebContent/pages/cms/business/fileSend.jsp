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
    #detailModalLg .bootgrid-table th > .column-header-anchor > .text{font-size:13px;font-weight:normal;}
   /*  .text-left{font-size:13px;} */
  </style>
  
  <body>
  	<div class="container-fluid">
	  	<div class="row">
	  		<div class='col-sm-12' id='button_div'>
			     <a id='uploadButton'  class='a-btn btn-success'   >
			 		 <span class='glyphicon glyphicon-plus'></span>
			 		 <span class='a-btn-slide-text'>添加下发的文件</span>
			 	 </a>
			 	 <a id='sendButton'  class='a-btn btn-success'  >
			     	<span class='glyphicon glyphicon-floppy-save' ></span>
			     	<span class='a-btn-slide-text'>下发文件</span>
			     </a> 
			     <a id='detailButton'  class='a-btn btn-info'  >
			     	<span class='glyphicon glyphicon-info-sign' ></span>
			     	<span class='a-btn-slide-text'>文件下发历史</span>
			     </a> 
				 <a id='delButton'  class='a-btn btn-default active'  >
			     	<span class='glyphicon glyphicon-trash' ></span>
			     	<span class='a-btn-slide-text'>删除文件</span>
			     </a> 
			</div>
  			<div class="col-sm-12" style="margin-top:20px;" id="filepage_List">
			 	<table id="filesendList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">id</th>
				            <th data-column-id="filename">主题</th>
				            <th data-column-id="times" data-formatter="times">创建时间</th>
				            <th data-column-id="filepath">路径</th>
				        </tr>
				     </thead>
				</table>
			</div>
			<!-- 上传文件 -->
			<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
					      <div class="modal-header" >
					      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
			       			<h4 class='modal-title' id='myModalLabel'>文件选择</h4>
					      </div>
					      <div class="modal-body">
					      	<form id='backuppackage_form' class='form-horizontal' role='form' enctype='multipart/form-data'>
							    <div class='row'>
								    <div class='form-group'>
									    <label  class='col-sm-3 control-label'>下发文件选择*:</label>
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
			<!-- 下发客户端 -->
			<div class="modal fade fade bs-example-modal-lg" id="userModalLg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog modal-lg" role="document">
				      <div class="modal-content">
					      <div class="modal-header" >
					      	<button type='button' class='close' data-dismiss='modal' aria-label='Close' ><span aria-hidden='true'>&times;</span></button>
							<h4 class='modal-title' id='myModalLabelThree'>下发文件</h4>
					      </div>
					      <div class="modal-body">
						 	<table id="userList" class="table table-condensed table-hover table-striped" ajax="true">
							    <thead>
							        <tr>
							            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">id</th>
							            <th data-column-id="name">名称</th>
				            			<th data-column-id="ipSection">ip组</th>
							            <!-- <th data-column-id="userName">用户名</th>
							            <th data-column-id="deviceIp">设备IP</th>
							            <th data-column-id="deviceName">设备名称</th>
							            <th data-column-id="macAddress">MAC地址</th>
							            <th data-column-id="deviceType">设备类型</th> -->
							        </tr>
							     </thead>
							</table>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
					        <button type="submit" class="btn btn-primary" onclick="confirm()">确定</button>
					      </div>
				     </div>
				</div>
			</div>
			<!-- 下发选择-->
			<div class="modal fade" id="slectinfoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
					      <div class="modal-header" >
					      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
			       			<h4 class='modal-title' id='Modalhead'>文件下发策略</h4>
					      </div>
					      <div class="modal-body">
					      	<form id='leadtoselect_form' class='form-horizontal' role='form' enctype='multipart/form-data'>
							    <div class='row'>
								    <div class='form-group'>
									    <label  class='col-sm-3 control-label'>接收完是否运行*:</label>
									    <div class='col-sm-7' id='receive_alert'  data-toggle='popover' data-trigger='manual'>
									        <select name="ooc" id="receive" class="form-control">
												<option value="" id="receiveNone">--请选择--</option>
												<option value="0" id="receive0">不运行</option>
												<option value="1" id="receive1">运行</option>
											</select>
									    </div>
									</div>
									<div class='form-group'>
									    <label  class='col-sm-3 control-label'>判断成功的条件*:</label>
									    <div class='col-sm-7' id='judge_alert'  data-toggle='popover' data-trigger='manual'>
									        <select name="fot" id="judge" class="form-control">
												<option value="" id="judgeNone">--请选择--</option>
												<option value="0" id="judge0">判断文件存在</option>
												<option value="1" id="judge1">判断进程存在</option>
											</select>
									    </div>
									</div>
									<div class='form-group'>
									    <label  class='col-sm-3 control-label'>判断成功的内容*:</label>
									    <div class='col-sm-7' id='content_alert'  data-toggle='popover' data-trigger='manual'>
									        <input type="text"  name="fotname" id="content" class="form-control">
									    </div>
									</div>
								</div>
							</form>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					        <button type="submit" class="btn btn-primary" onclick="leadto()">下发</button>
					      </div>
				     </div>
				</div>
			</div>	
			<!-- 查看	 -->
			<div class="modal fade fade bs-example-modal-lg" id="detailModalLg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog modal-lg" role="document">
				      <div class="modal-content">
					      <div class="modal-header" >
					      	<button type='button' class='close' data-dismiss='modal' aria-label='Close' ><span aria-hidden='true'>&times;</span></button>
							<h4 class='modal-title' id='detail'>详细信息</h4>
					      </div>
					      <div class="modal-body ">					    
							  <div style='margin-left:3%'>
						      		<h5 style='font-weight:bold;'>基本信息</h5>
							      	<ul style='margin-left:16%' id="essential">
							      	</ul>
					      	  </div>
							  <div style='margin-left:3%;margin-top:70px;padding:0 11px;' class="table-responsive col-sm-12"> 
						      		<h5 style='font-weight:bold;margin:0 -11px;'>发送历史列表</h5>
								 	<table id="ipGroupList" class="table table-condensed table-hover table-striped" ajax="true">
									    <thead>
									        <tr>
									            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">id</th>
									            <th data-column-id="devname">客户端</th>
									            <th data-column-id="filename">文件名</th>
									            <th data-column-id="time">发送时间</th>
									        	<th data-column-id="succezz">是否成功</th>
									        </tr>
									     </thead>
									</table>
							  </div>
						  </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
					        <button type="submit" class="btn btn-primary" onclick="save()">确定</button>
					      </div>
				     </div>
				</div>
			</div>	
		</div>
    </div>
	<script type="text/javascript">
	 	var rowIds = [];
		$("#filesendList").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/fileModelAction!findByPage.action",
	        selection: true,
	        multiSelect: true,
	        rowSelect:true,
	        rowCount:10,
	        navigation:2,
	        formatters: {
	            "times": function(column, row)
	            {
	            	var time=row.times.replace("T"," ");
	                return time;
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
		
		var checkSubmitFlg=false;
		/* 文件上传 */
		$("#uploadButton").click(function(){
			checkSubmitFlg=false;
			$("#backuppackage").val("");
			$('#backuppackage_alert').popover('hide');
			$("#infoModal").modal('show');
		});
		//文件上传保存
		function save(){
			var backuppackage=$("#backuppackage").val();
			var newFileName=backuppackage.substring(backuppackage.lastIndexOf("\\")+1);
			if(backuppackage==""){
				$("#backuppackage_alert").attr("data-content","文件选择不能为空");
				$("#backuppackage_alert").popover('show');
				return;
			}else{
				$.post("${ctx}/json/fileModelAction!havename.action",{"name":newFileName},function(data){
					/* if(checkSubmitFlg==true){ 
						return false;
					}else{ */	 
						if(!data.has){
							$.confirm({
				    		    title: '提示信息!',
				    		    content: '你上传的文件已存在，是否要覆盖，如果是点击确定。',
				    		    confirm: function(){ 
									$('#backuppackage_form').ajaxSubmit({
										type:"POST",
										url:"${ctx}/json/fileSendAction!upload.action",
										success:function(data){
											if(data.success==true){
												$("#filesendList").bootgrid("reload");
												$("#infoModal").modal('hide');
												$.messager.show({title:'提示信息',msg:data.msg});
											}else{
												$("#infoModal").modal('hide');
												$.messager.show({title:'提示信息',msg:data.msg});
											}
											checkSubmitFlg=true;	
										}
									});
				    		    }
							});
						//}
					}else{
						$('#backuppackage_form').ajaxSubmit({
							type:"POST",
							url:"${ctx}/json/fileSendAction!upload.action",
							success:function(data){
								if(data.success==true){
									$("#filesendList").bootgrid("reload");
									$("#infoModal").modal('hide');
									$.messager.show({title:'提示信息',msg:data.msg});
								}else{
									$("#infoModal").modal('hide');
									$.messager.show({title:'提示信息',msg:data.msg});
								}
							}
						});   
					}
				});
			}			
		};
			
		/* 下发文件 */
		var nrowIds=[];
		$("#sendButton").click(function(){
			if(rowIds.length==0){
				var txt="请选择要下发的文件";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}else if(rowIds.length>1){
				var txt="只能选择一份文件下发";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}else{  
				$('#userList').bootgrid("destroy");
				$('#userList').bootgrid({
	  				ajax: true,
	      			post: function (){},
	      			url: "${ctx}/json/groupAction!findByPage.action",
	      			selection: true,
	      			multiSelect: true,
	      			columnSelection:false,
	      			rowSelect: true,
	      			rowCount:[8,10,20,25],
	      			navigation:2,
	      			formatters: {
						operationtime:function(column, row){
							return row.operationtime.substr(0,10);
						},
					}
		 	 	}).on('selected.rs.jquery.bootgrid', function(e, rows){
			        for (var i = 0; i < rows.length; i++){
			            nrowIds.push(rows[i].id);
			        }
			    }).on('deselected.rs.jquery.bootgrid', function(e, rows){
			    	var newIds = [];
			    	if(nrowIds.length==rows.length){
		   				nrowIds=[];
		   			}else{ 
			        	for (var i = 0; i < rows.length; i++){
			            	for(var j = 0;j<nrowIds.length;j++){
			            		if(rows[i].id==nrowIds[j]){
			            			continue;
			            		}
			            		newIds.push(nrowIds[j]);
			            	}
			        	}
			        	nrowIds = newIds;
			        
		        	}
			    });
				$('#userModalLg').modal('show');
			}
		});
		//确定选择客户端
		function confirm(){
			 if(nrowIds.length==0){
				var txt="请至少选择一项";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			} 
			$("#userModalLg").modal('hide');
			$("#slectinfoModal").modal('show');
		}
		//确定下发
		function leadto(){
			var receive=$("#receive").val();
			var judge=$("#judge").val();
			var content=$("#content").val();
			if(receive==""){
				$("#receive_alert").attr("data-content","接收完是否运行不能为空");
				$("#receive_alert").popover('show');
				return;
			}
			if(judge==""){
				$("#judge_alert").attr("data-content","判断成功的条件不能为空");
				$("#judge_alert").popover('show');
				return;
			}
			if(content==""){
				$("#content_alert").attr("data-content","判断成功的内容不能为空");
				$("#content_alert").popover('show');
				return;
			}
			$.post("${ctx}/json/groupAction!sendFile.action",{'fileid':rowIds[0],'groupId':nrowIds.toString(),
				'ooc':receive,'fot':judge,'fotname':content},function(data){
				if(data.success==true){
					$("#slectinfoModal").modal('hide');
					$("#filesendList").bootgrid("reload");
					$.messager.show({title:'提示信息',msg:data.msg});
				}else{
					$("#slectinfoModal").modal('hide');
					$("#filesendList").bootgrid("reload");
					$.messager.show({title:'提示信息',msg:data.msg});
				}
			});	
		}

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
    		    onOpen: function(){
    		    	$(".jconfirm-scrollpane .jconfirm-box-container>.jconfirm-box").css("margin-top","300px");
    		    }, 
    		    //offset : ['220px' , '20%'],
    		    confirm: function(){
    		    	$.post('${ctx}/json/fileModelAction!delete.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#filesendList").bootgrid("reload");
							 rowIds=[];
							 $.messager.show({title:'提示信息',msg:data.msg});
						 }else{
							 $.messager.show({title:'提示信息',msg:data.msg});
						 } 
					});
    		    }
    		    
    		});
		});
		$("#detailButton").click(function(){
			if(rowIds.length==0){
				var txt="请选择文件";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			if(rowIds.length>1){
				var txt="只能选择一份文件";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			/* $("#msgHistoryList").bootgrid("destory");  */
			/* var rowIds = []; */
			$("#ipGroupList").bootgrid({
		    	ajax: true,
		        post: function (){},
		        url:'${ctx}/json/fileSendRecordAction!findByPage.action?id='+rowIds[0],
		       /*  selection: true,
		        multiSelect: true,
		        rowSelect:true, */
		        rowCount:10,
		        navigation:2,
			})/* .on("selected.rs.jquery.bootgrid", function(e, rows){
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
		  	            	newIds.push(rowIsds[j]);
		  	            }
		  	        }
		  	        rowIds = newIds;
		    	}
		    }).on("loaded.rs.jquery.bootgrid", function(e, rows){
		    	rowIds=[];
		    })  */; 
			$.post("${ctx}/json/fileModelAction!findById.action",{"id":rowIds[0]},function(data){
				var content="<li  class='col-sm-5' style='margin-bottom:10px;padding-right:2px'>主题："+
				  				"<span style='word-wrap:break-word;'>"+data.rows.filename+"</span></li>"+
				  			"<li  class='col-sm-5' style='margin-bottom:10px;padding-right:2px'>创建时间："+
				  				"<span style='word-wrap:break-word;'>"+data.rows.times.replace("T"," ")+"</span></li>"+
				  			"<li  class='col-sm-10' style='margin-bottom:10px;padding-right:2px'>路径："+
				  				"<span style='word-wrap:break-word;'>"+data.rows.filepath+"</span></li>"; 	
				$("#essential").html(content);
			})
			$("#detailModalLg").modal("show");
		});
		
		/* 确定框 */
		
		//$(".jconfirm-scrollpane .jconfirm-box-container>.jconfirm-box").css("margin-top","400px");
		//$(".jconfirm.jconfirm-white .jconfirm-box").css("margin-top","400px");
		document.onkeydown=function(){
			 if(event.keyCode==13)
          {
              event.returnValue=false;
          }
		};
	</script>
  </body>
</html>
