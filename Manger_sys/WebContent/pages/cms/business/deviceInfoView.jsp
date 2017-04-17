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
		    		<a id='lookupButton'  class='a-btn btn-primary'>
			     		<span class='glyphicon glyphicon-search' ></span>
			     		<span class='a-btn-slide-text'>查看策略</span>
			     	</a>					
			     	<a id='installButton'  class='a-btn btn-info'  >
			     		<span class='glyphicon glyphicon-tasks' ></span>
			     		<span class='a-btn-slide-text'>安装软件信息</span>
			     	</a>
			     	 <a id='upgradenowButton'  class='a-btn btn-warning'  >
			     		<span class='glyphicon glyphicon-arrow-up' ></span>
			     		<span class='a-btn-slide-text'>立即升级</span>
			     	</a>
			     	<a id='upgradeallButton'  class='a-btn btn-danger'  >
			     		<span class='glyphicon glyphicon-circle-arrow-up' ></span>
			     		<span class='a-btn-slide-text'>全部升级</span>
			     	</a>
			     	<a id='exceltoButton'  class='a-btn btn-info'  >
			     		<span class='glyphicon glyphicon-download-alt' ></span>
			     		<span class='a-btn-slide-text'>Excel导出</span>
			     	</a>
			     	<a id='lookdeviceButton'  class='a-btn btn-success'>
			     		<span class='glyphicon glyphicon-info-sign' ></span>
			     		<span class='a-btn-slide-text'>查看设备资产信息</span>
			     	</a>
				</div>
				
				<div class='col-sm-12' style="margin:25px 0;">
			  		<form id='return_form' class='form-inline' role='form'>
			  			 <div class='form-group'  style="margin-bottom:10px;">
							<!--  <label>结构：</label> -->
							 <div style="display: inline-block;">
							    <input type='text' placeholder="结构" name="depId" class='form-control' id='parent'  readonly/>
								<div id='territoryContent' class='menuContent' style='display:none; position: absolute;z-index:999;'>
									<ul id='territoryTree' class='ztree menuTree' style='margin-top:0; width:178px;'></ul>
								</div>
							 </div>
					  	 </div>
						
			 			<div class='form-group' style="margin-bottom:10px;">
							<!-- <label>用户名:</label> -->
							<div style="display: inline-block;">
							  	<input  type='text' placeholder="用户名"  name='deviceSearchModel.name'  class='form-control' id="user"  />
						  	</div>
						</div>
						<div class='form-group' style="margin-bottom:10px;">
							 <!-- <label>IP:</label> -->
							 <div style="display: inline-block;">
							   	<input type='text' placeholder="IP地址"  name='deviceSearchModel.IP'  class='form-control' id="ipadress" />
							</div>	
						</div>
						<div class='form-group' style="margin-bottom:10px;">
							<!--  <label>MAC地址:</label> -->
							 <div style="display: inline-block;">
							   	<input type='text' placeholder="MAC地址"  name='deviceSearchModel.MAC'  class='form-control' id="MACadress" />
							</div>	
						</div>
						<div class='form-group' style="margin-bottom:10px;">
						 	<button type="reset"  class="btn btn-info"  id="resetdata" style="margin-left:10px">重置</button>
					 		<button type="button"  class="btn btn-info"  id="screendata" >查看</button>
						</div>	
					</form>
				</div>   
			 </div>	
			
	  		<div class="col-sm-12" id="tableDiv" style="margin-top:20px;">
			 	<table id="deviceList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visibleInSelection="false">编号</th>
				            <th data-column-id="userName">用户名</th>
				         	<th data-column-id="deviceIp">设备IP</th>
				            <th data-column-id="deviceName" >设备名称</th>	
				            <th data-column-id="macAddress">MAC地址</th>
				            <th data-column-id="phoneNumber" >联系电话</th>		
				            <th data-column-id="strategy" >策略</th>
				            <th data-column-id="nulockNumber">解锁码</th>
				            <th data-column-id="deviceName">设备类型</th>					            
				        </tr>
				    </thead>		  
				</table>
  			</div> 		
  		</div>
  	</div>
  	 <!-- 详细信息 -->
  	<div class="modal fade bs-example-modal-lg" id="detailinforModalLg" tabindex="-1" role="dialog" aria-labelledby="detailinforLabelLg" data-backdrop="static" data-keyboard="false">
  		<div class="modal-dialog modal-lg" role="document">
			  <div class="modal-content">
				  <div class="modal-header" >
				  	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true' >&times;</span></button>
		     		<h4 class='modal-title' id='detailinforLabel'>详细信息</h4>
				  </div>
				  <div class="modal-body" id="detailinfor-bodyLg">
					  <form id='detail_form' class='form-horizontal' role='form'>	    
							<div class='form-group'>
							    <label  class='col-sm-4 control-label'>策略名称*:</label>
							    <div class='col-sm-5' id='userName_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='name' disabled  class='form-control' id='userName'/>
								</div>
							</div>			
							<div class='form-group'>
							    <label  class='col-sm-4 control-label'>杀毒软件违规处理方式*:</label>
							    <div class='col-sm-5' id='antivirusAction_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='device.antivirusAction'   disabled  class='form-control' id='antivirusAction'/>
								</div>
							</div>	
							<div class='form-group' id="antivirus_div" style="display:none">
							    <label  class='col-sm-4 control-label'>杀毒软件*:</label>
							    <div class='col-sm-5' id='antivirus_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='device.antivirus'  disabled  class='form-control' id='antivirus'/>
								</div>
							</div>			
							<div class='form-group'>
							    <label  class='col-sm-4 control-label'>违规外联处理方式*:</label>
							    <div class='col-sm-5' id='violationLink_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='violationLink'  disabled   class='form-control' id='violationLink'/>
								</div>
							  </div>			
							<div class='form-group'>
							    <label  class='col-sm-4 control-label'>弱口令*:</label>
							    <div class='col-sm-5' id='weakPassword_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='weakPassword' disabled    class='form-control' id='weakPassword'/>
								</div>
							</div>	
							<div class='form-group'>
							    <label  class='col-sm-4 control-label'>白名单进程未启动处理方式*:</label>
							    <div class='col-sm-5' id='whiteProcessGroupAction_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='whiteProcessGroupAction' disabled   class='form-control' id='whiteProcessGroupAction'/>
								</div>
							</div>
							<div class='form-group' id="whiteProcessGroup_div" style="display:none">
							    <label  class='col-sm-4 control-label'>进程白名单*:</label>
							    <div class='col-sm-5' id='whiteProcessGroup_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='whiteProcessGroup' disabled   class='form-control' id='whiteProcessGroup'/>
								</div>
							</div>		
							<div class='form-group'>
							    <label  class='col-sm-4 control-label'>黑名单进程启动处理方式*:</label>
							    <div class='col-sm-5' id='blackProcessGroupAction_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='blackProcessGroupAction' disabled   class='form-control' id='blackProcessGroupAction'/>
								</div>
							</div>
							<div class='form-group' id="blackProcessGroup_div" style="display:none">
							    <label  class='col-sm-4 control-label'>进程黑名单组*:</label>
							    <div class='col-sm-5' id='blackProcessGroup_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='blackProcessGroup' disabled  class='form-control' id='blackProcessGroup'/>
								</div>
							</div>		
							<div class='form-group' id="portGroup_div" style="display:none">
							    <label  class='col-sm-4 control-label'>封堵端口组*:</label>
							    <div class='col-sm-5' id='portGroup_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='portGroup' disabled  class='form-control' id='portGroup'/>
								</div>
							</div>	
							<div class='form-group' id="ipGroup_div" style="display:none">
							    <label  class='col-sm-4 control-label'>违规后仍可联通IP地址*:</label>
							    <div class='col-sm-5' id='ipGroup_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='ipGroup' disabled  class='form-control' id='ipGroup'/>
								</div>
							</div>			
						</form>			  
				  </div>
				  <div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				  </div>
			 </div>
		</div>
  	</div>
  	<!-- 设备资产信息 -->
	<div class="modal fade bs-example-modal-lg" id="deviceShowInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
		      	 <div class="modal-header" >
			      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
	       			<h4 class='modal-title' >设备资产信息</h4>
			     </div>
			     <div class="modal-body" id="showAssectInfo">
			      	
			     </div>
			     <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			     </div>
		     </div>
		</div>
	</div>
	<!-- 安装软件信息 -->
	<div class="modal fade bs-example-modal-lg" id="softWareInfoDiv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
		      	 <div class="modal-header" >
			      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
	       			<h4 class='modal-title' >安装软件信息</h4>
			     </div>
			     <div class="modal-body" id="showSoftWareInfo">
			     </div>
			     <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			     </div>
		     </div>
		</div>
	</div>
	<script type="text/javascript">
	    var savestate="";//保存状态
	    var queryId="";//树的id
	    var confirmstate="";//密码保存状态
	 	var rowIds = [];	
	 	showList();
	 	function showList(){
	 		$("#deviceList").bootgrid("destroy");
			$("#deviceList").bootgrid({
				ajax: true,
		 		post: function (){
		 	         return {
		 	        	depId:queryId,
		 	        }; 
		 	    },
		 		url: "${ctx}/json/deviceAction!findByPage.action?deviceSearchModel.name="+$("#user").val()+
		 				"&&deviceSearchModel.MAC="+$("#MACadress").val()+"&&deviceSearchModel.IP="+$("#ipadress").val(),
				selection: true,
		        multiSelect: true,
		        navigation:2,
		        rowSelect: true,
		        rowCount:[8,10,20,25],
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
	 	var key;
	 	var module="";
	 	$.post('${ctx}/json/userAction!getPubKey.action',function(data){
			module=data.module;
			RSAUtils.setMaxDigits(512);  
			key = new RSAUtils.getKeyPair(data.empoent, "",data.module);  
		});
	 	/* $.post('${ctx}/json/strategyAction!findAll.action',function(data){
			var strategies=data.strategies;
			for(var i=0;i<strategies.length;i++){
				$("#strategy").append("<option value='"+strategies[i].id+"'>"+strategies[i].name+"</option>");
			}
		}); */
		
		//结构显示
	  	$('#parent').click(function(){
			$('#territoryContent').show();
			var setting = {
				async: {
					enable: true,
					type:'post',
					url:"${ctx}/json/departmentAction!getDepartmentTree.action",
					autoParam:['id'],
					dataType:'json'
				},
				data:{
					simpleDate:{
						enable:true,
						idKey:'id',
					}
				},
				callback : {
					onClick:function(e, treeId, treeNode) {
						var nodename = treeNode.name;
						var nodeIds=treeNode.id;
						queryId=nodeIds;
						$('#parent').val(nodename);
					}
				}
			};
			$.fn.zTree.init($('#territoryTree'), setting);
			$('body').bind('mousedown', function(event){
				if(!(event.target.id == 'parent' || event.target.id == ('territoryContent') || $(event.target).parents('#territoryContent').length>0)){
					$('#territoryContent').hide();
				}
			});
		});
		//组织机构
		var departmentId="";
		function showdepartment(depId){
			$('#department').click(function(){
				$('#organizeContent').show();
				var setting = {
					async: {
						enable: true,
						type:'post',
						url:"${ctx}/json/departmentAction!getDepTree.action?id="+depId,
						//url:"${ctx}/json/departmentAction!getDepartmentTree.action",
						autoParam:['id'],
						dataType:'json'
					},
					data:{
						simpleDate:{
							enable:true,
							idKey:'id',
						}
					},
					callback : {
						onClick:function(e, treeId, treeNode) {
							var nodename = treeNode.name;
							var nodeIds=treeNode.id;
							departmentId=nodeIds;
							$('#department').val(nodename);
						}
					}
				};
				$.fn.zTree.init($('#organizeTree'), setting);
				$('body').bind('mousedown', function(event){
					if(!(event.target.id == 'department' || event.target.id == ('organizeContent') || $(event.target).parents('#organizeContent').length>0)){
						$('#organizeContent').hide();
					}
				});
			});
		}		
		//查询
		$("#screendata").click(function(){
	  		var ipadress=$("#ipadress").val();
	  		if(ipadress!=""&&!/((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))/.test(ipadress)){
	  			var txt=  "ip地址格式不正确";
	            window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
	            return;
	  		}
			showList();
		});
		//重置
		$("#resetdata").click(function(){
	  		$("#user").val("");
	  		$("#parent").val("");
	  		$("#MACadress").val("");
	  		$("#ipadress").val("");
	  		showList();
  		}); 	
		//查看策略
	    $("#lookupButton").click(function(){   
	    	if(rowIds.length==0){
				window.wxc.xcConfirm("请选择要查看策略的设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			}
	    	if(rowIds.length>1){
				window.wxc.xcConfirm("只能选择一个设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			} 
			$("#detailinforModalLg").modal('show');
	    	$.post('${ctx}/json/deviceAction!showStrategy.action',{'id' : rowIds[0]}, function(dataMap) {
	    		$("#name").val(dataMap.strategyPageModel.name);
	    		$("#antivirusAction").val(dataMap.strategyPageModel.antivirusActionString);
	    		var antivirusAction=dataMap.strategyPageModel.antivirusAction;
	    		if(antivirusAction==0){
	    			$("#antivirus_div").hide();
	    		}else{
	    			$("#antivirus_div").show();
	    			$("#antivirus").val(dataMap.strategyPageModel.antivirusName);
	    		}
	    		$("#violationLink").val(dataMap.strategyPageModel.violationLinkStaticText);
	    		$("#weakPassword").val(dataMap.strategyPageModel.weakPasswordStaticText);
	    		$("#whiteProcessGroupAction").val(dataMap.strategyPageModel.whiteProcessGroupActionString);
	    		var whiteProcessGroupAction=dataMap.strategyPageModel.whiteProcessGroupAction;
	    		if(whiteProcessGroupAction==0){
	    			$("#whiteProcessGroup_div").hide();
	    		}else{
	    			$("#whiteProcessGroup_div").show();
	    			$("#whiteProcessGroup").val(dataMap.strategyPageModel.whiteProcesses);
	    			
	    		}
	    		$("#blackProcessGroupAction").val(dataMap.strategyPageModel.blackProcessGroupActionString);
	    		var blackProcessGroupAction=dataMap.strategyPageModel.blackProcessGroupAction;
	    		if(blackProcessGroupAction==0){
	    			$("#blackProcessGroup_div").hide();
	    		}else{
	    			$("#blackProcessGroup_div").show();
	    			$("#blackProcessGroup").val(dataMap.strategyPageModel.blackProcesses);
	    		}
	    		var portGroupName=dataMap.strategyPageModel.portGroupName;
	    		if(portGroupName!=null && portGroupName!=""){
	    			$("#portGroup_div").show();
	    			$("#portGroup").val(dataMap.strategyPageModel.ports);
	    		}else{
	    			$("#portGroup_div").hide();
	    		}
	    		var ipGroupName=dataMap.strategyPageModel.ipGroupName;
	    		if(ipGroupName!=null && ipGroupName!=""){
	    			$("#ipGroup_div").show();
	    			$("#ipGroup").val(dataMap.strategyPageModel.ips);
	    		}else{
	    			$("#ipGroup_div").hide();
	    		}
			});
		});
		//查看设备资产信息
		$("#lookdeviceButton").click(function(){
			if(rowIds.length==0){
				window.wxc.xcConfirm("请选择要查看的设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			}
	    	if(rowIds.length>1){
				window.wxc.xcConfirm("只能选择一个设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			} 
			$("#deviceShowInfo").modal('show');
			$.post('${ctx}/json/deviceInfoAction!getInfo.action',{'id' : rowIds[0]}, function(dataMap) {
	    		if(dataMap.deviceInfo!=null || dataMap.deviceInfo!=""){
					var html="<table>"+
								"<tr><td>cpu编号</td><td>"+dataMap.deviceInfo.cpuId+"</td></tr>"+
								"<tr><td>系统版本信息</td><td>"+dataMap.deviceInfo.osInfo+"</td></tr>"+
								"<tr><td>内存大小</td><td>"+dataMap.deviceInfo.memorySize+"</td></tr>"+
								"<tr><td>硬盘信息</td><td>";
								var diskInfo=dataMap.deviceInfo.diskInfo;
								for(var i=0;i<diskInfo.length;i++){
									html+=""+diskInfo[i]+"<br/>";
								}
							html+="</td></tr>"+
								"<tr><td>网卡信息</td><td>";
								var netWorkCardInfo=dataMap.deviceInfo.netWorkCardInfo;
								for(var i=0;i<netWorkCardInfo.length;i++){
									html+=""+netWorkCardInfo[i]+"<br/>";
								}
							html+="</td></tr>"+
							"</table>";
					$("#showAssectInfo").html(html);	
	    		}
	    	});
		});
		//安装软件信息
		$("#installButton").click(function() {
			if(rowIds.length==0){
				window.wxc.xcConfirm("请选择要查看的设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			}
	    	if(rowIds.length>1){
				window.wxc.xcConfirm("只能选择一个设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			} 
			$("#softWareInfoDiv").modal('show');
			$.post('${ctx}/json/deviceAction!getSoftWareInfo.action',{'id' : rowIds[0]}, function(dataMap) {
	    		var softwareinfolist=dataMap.softwareinfolist;
	    		if(softwareinfolist!=null ||softwareinfolist!=""){
					var html="<table class='table'>"+
								"<tr><th>软件名称</th><th>开发者</th><th>安装时间</th><th>版本号</th></th>";
	    			for(var i=0;i<softwareinfolist.length;i++){
	    				html+="<tr><td>"+softwareinfolist[i].name+"</td>"+
								"<td>"+softwareinfolist[i].publisher+"</td>"+
								"<td>"+softwareinfolist[i].installTime+"</td>"+
								"<td>"+softwareinfolist[i].version+"</td></tr>";
	    			}
					html+="</table>";
					$("#showSoftWareInfo").html(html);	
	    		}
	    	});
		});
		//立即升级
		$("#upgradenowButton").click(function() {
			if(rowIds.length==0){
				window.wxc.xcConfirm("请选择要升级的设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			$.confirm({
    		    title: '提示信息!',
    		    content: '你确定要立即升级吗？',
    		    confirm: function(){   		    	
   					$.post('${ctx}/json/deviceAction!sendCommand.action', {'ids' : rowIds.toString(),'code' : '3'}, function(data) {
   						if (data.success == true) {
   							$("#deviceList").bootgrid("reload");
   							$.messager.show({title:'提示信息',msg:data.msg});
   						} else {
   							$.messager.show({title:'提示信息',msg:data.msg});
   						}
   					});
    		    }
			});
		});
		//立即升级
		$("#upgradeallButton").click(function() {
			$.confirm({
    		    title: '提示信息!',
    		    content: '你确定要全部升级吗？',
    		    confirm: function(){   		    	
    		    	$.post('${ctx}/json/deviceAction!updateall.action', {}, function(data) {
						if (data.success == true) {
							$("#deviceList").bootgrid("reload");
							$.messager.show({title:'提示信息',msg:data.msg});
						} else {
							$.messager.show({title:'提示信息',msg:data.msg});
						}
					});
    		    }
			});
		});
		//Excel导出
		$("#exceltoButton").click(function() {
			$.confirm({
    		    title: '提示信息!',
    		    content: '是否Excel导出？',
    		    confirm: function(){   		    	
    		    	 window.location.href = "${ctx}/json/deviceAction!getDevicesExcel.action"; 
    		    }
			});
		});
	</script>
  </body>
</html>
