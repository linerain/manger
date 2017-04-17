<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<html>
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
		    <div  id="searchDiv" >
		    	<div class='col-sm-12' >					
			     	<a id='updataButton'  class='a-btn btn-info'>
			     		<span class='glyphicon glyphicon-pencil' ></span>
			     		<span class='a-btn-slide-text'>修&nbsp;&nbsp;&nbsp;&nbsp;改</span>
			     	</a>
			     	 <a id='openlockButton'  class='a-btn btn-success'>
			     		<span class='glyphicon glyphicon-lock' ></span>
			     		<span class='a-btn-slide-text'>设备解锁</span>
			     	</a>
			     	 <a id='sendButton'  class='a-btn btn-primary'>
			     		<span class='glyphicon glyphicon-arrow-down' ></span>
			     		<span class='a-btn-slide-text'>下发策略</span>
			     	</a>
			     	<a id='deleteButton'  class='a-btn btn-primary'>
			     		<span class='glyphicon glyphicon-floppy-remove' ></span>
			     		<span class='a-btn-slide-text'>设备卸载</span>
			     	</a>
			     	<a id='closedeviceButton'  class='a-btn btn-primary'>
			     		<span class='glyphicon glyphicon-off' ></span>
			     		<span class='a-btn-slide-text'>关闭设备</span>
			     	</a>
			     	 <a id='closewifiButton'  class='a-btn btn-primary'>
			     		<span class='glyphicon glyphicon-remove-circle' ></span>
			     		<span class='a-btn-slide-text'>关闭内网</span>
			     	</a>
			     	<a id='openwifiButton'  class='a-btn btn-primary'>
			     		<span class='glyphicon glyphicon-ok-circle' ></span>
			     		<span class='a-btn-slide-text'>开启内网</span>
			     	</a>
			     	<a id='lookupButton'  class='a-btn btn-info'>
			     		<span class='glyphicon glyphicon-info-sign' ></span>
			     		<span class='a-btn-slide-text'>查看策略</span>
			     	</a>
			     	<a id='createScanButton'  class='a-btn btn-success' >
			     		<span class='glyphicon glyphicon-plus' ></span>
			     		<span class='a-btn-slide-text'>创建扫描器</span>
			     	</a>	
			     	<a id='delectButton'  class='a-btn btn-default active'>
			     		<span class='glyphicon glyphicon-trash' ></span>
			     		<span class='a-btn-slide-text'>删&nbsp;&nbsp;&nbsp;&nbsp;除</span>
			     	</a>
				</div>
				
				<div class='col-sm-12' style="margin:25px 0;">
			  		<form id='return_form' class='form-inline' role='form'>
			  			 <div class='form-group'  style="margin-bottom:10px;">
							 <!-- <label>结构：</label> -->
							 <div style="display: inline-block;">
							    <input type='text' name="depId" placeholder="结构" class='form-control' id='parent'  readonly/>
								<div id='territoryContent' class='menuContent' style='display:none; position: absolute;z-index:999;'>
									<ul id='territoryTree' class='ztree menuTree' style='margin-top:0; width:178px;'></ul>
								</div>
							 </div>
					  	 </div>
						
			 			<div class='form-group' style="margin-bottom:10px;">
							<!-- <label>用户名:</label> -->
							<div style="display: inline-block;">
							  	<input  type='text'  name='deviceSearchModel.name' placeholder="用户名"  class='form-control' id="user"  />
						  	</div>
						</div>
						<div class='form-group' style="margin-bottom:10px;">
							 <!-- <label>IP:</label> -->
							 <div style="display: inline-block;">
							   	<input type='text'  name='deviceSearchModel.IP' placeholder="IP地址"  class='form-control' id="ipadress" />
							</div>	
						</div>
						<div class='form-group' style="margin-bottom:10px;">
							<!--  <label>MAC地址:</label> -->
							 <div style="display: inline-block;">
							   	<input type='text'  name='deviceSearchModel.MAC' placeholder="MAC地址"  class='form-control' id="MACadress" />
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
  	<!-- 设备解锁账户再次确认 -->
	<div class="modal fade" id="passwordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
			      <div class="modal-header" >
			      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
	       			<h4 class='modal-title' id='myModalLabel'>确认管理员密码</h4>
			      </div>
			      <div class="modal-body">
			      	<form id='password_form' class='form-horizontal' role='form'>
					    <div class='row'>
						  <div class='form-group'>
						    <label  class='col-sm-3 control-label'>密码*:</label>
						    <div class='col-sm-5' id='password_alert'  data-toggle='popover' data-trigger='manual'>
								<input type='password' name='password'   class='form-control' id='password'/>
							</div>
						  </div>			
						</div>
					</form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			        <button type="submit" class="btn btn-primary" onclick="confirm()">保存</button>
			      </div>
		     </div>
		</div>
	</div>
	<!-- 修改信息 -->
	<div class="modal fade" id="resetdataModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
		      	 <div class="modal-header" >
			      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
	       			<h4 class='modal-title' >修改信息</h4>
			     </div>
			     <div class="modal-body">
			      	<form id='resetdata_form' class='form-horizontal' role='form'>	    
						<div class='form-group'>
						    <label  class='col-sm-3 control-label'>用户姓名*:</label>
						    <div class='col-sm-5' id='userName_alert'  data-toggle='popover' data-trigger='manual'>
								<input type='text' name='device.userName'   class='form-control' id='userName'/>
							</div>
						</div>			
						<div class='form-group'>
						    <label  class='col-sm-3 control-label'>联系电话*:</label>
						    <div class='col-sm-5' id='phoneNumber_alert'  data-toggle='popover' data-trigger='manual'>
								<input type='text' name='device.phoneNumber'   class='form-control' id='phoneNumber'/>
							</div>
						</div>			
						<div class='form-group'>
						    <label  class='col-sm-3 control-label'>位置*:</label>
						    <div class='col-sm-5' id='address_alert'  data-toggle='popover' data-trigger='manual'>
								<input type='text' name='device.address'   class='form-control' id='address'/>
							</div>
						</div>	
						<div class='form-group'>
						    <label  class='col-sm-3 control-label'>组织机构*:</label>
						    <div class='col-sm-5' id='department_alert'  data-toggle='popover' data-trigger='manual'>
								<input type='text' name='department' readonly  class='form-control' id='department'/>
								<div id='organizeContent' class='menuContent' style='display:none; position: absolute;z-index:999;'>
									<ul id='organizeTree' class='ztree menuTree' style='margin-top:0; width:218px;'></ul>
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
	<!-- 下发策略 -->
	<div class="modal fade bs-example-modal-lg" id="issuedModalLg" tabindex="-1" role="dialog" aria-labelledby="detailinforLabelLg" data-backdrop="static" data-keyboard="false">
  		<div class="modal-dialog modal-lg" role="document">
			  <div class="modal-content">
				  <div class="modal-header" >
				  	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true' >&times;</span></button>
		     		<h4 class='modal-title' >下发策略</h4>
				  </div>
				  <div class="modal-body" >
			      	<table id="issuedList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visibleInSelection="false">编号</th>
				            <th data-column-id="name">策略名称</th>
				         	<th data-column-id="antivirusName">杀毒软件</th>
				            <th data-column-id="violationLinkStaticText" >违规外联是否启用</th>	
				            <th data-column-id="weakPasswordStaticText">弱口令</th>
				            <th data-column-id="portGroupName">封堵端口组</th>		
				            <th data-column-id="ipGroupName" >违规后仍可联通IP地址</th>
				            <th data-column-id="whiteProcessGroupName">进程白名单组</th>
				            <th data-column-id="blackProcessGroupName">进程黑名单组</th>					            
				        </tr>
				    </thead>		  
				</table>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			        <button type="submit" class="btn btn-primary" onclick="save()">保存</button>
			      </div>
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
  	<!-- 创建模态框 -->
	  	<div class="modal fade bs-example-modal" id="scanInfoModal"  tabindex="-1" role="dialog" aria-labelledby="scanInfoModalLabel" data-backdrop="static" data-keyboard="false">
	  		<div class="modal-dialog " role="document">
				  <div class="modal-content">
					  <div class="modal-header" >
					  	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true' >&times;</span></button>
			     		<h4 class='modal-title' id='scanInfoModalLabel'>创建扫描器</h4>
					  </div>
					  <div class="modal-body" id="detailinfor-bodyLg">
						  <form id='scan_form' class='form-horizontal' role='form'>	    
								<div class='form-group'>
								    <label  class='col-sm-4 control-label'>起始ip*:</label>
								    <div class='col-sm-5' id='start'  data-toggle='popover' data-trigger='manual'>
										<input type='text' name='scanReg.startIp'  class='form-control' id='startIP'/>
									</div>
								</div>		
								<div class='form-group'>
								    <label  class='col-sm-4 control-label'>结束ip*:</label>
								    <div class='col-sm-5' id='end'  data-toggle='popover' data-trigger='manual'>
										<input type='text' name='scanReg.endIp'  class='form-control' id='endIP'/>
									</div>
								</div>
								<div class='form-group'>
								    <label  class='col-sm-4 control-label'>辰信易端口*:</label>
								    <div class='col-sm-5' id='cms'  data-toggle='popover' data-trigger='manual'>
										<input type='text' name='scanReg.cmsPort'  class='form-control' id='cmsPort'/>
									</div>
								</div>	
								<input type="hidden" name="scanReg.ip" id="scanIp"/>	
							</form>			  
					  </div>
					  <div class="modal-footer">
						  <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				          <button type="button" class="btn btn-primary" onclick="saveScan()">保存</button>
				      </div>
				 </div>
			</div>
	  	</div>
	<script type="text/javascript">
	 	document.onkeydown=function(){
			 if(event.keyCode==13){
	       		event.returnValue=false;
	   		}
  		};
	    var savestate="";//保存状态
	    var queryId="";//树的id
	    var confirmstate="";//密码保存状态
	 	var rowIds = [];	
	    var scanIp=[];//扫描器ip
		var issuedIds=[];//下发策略的id
	 	showList();
	 	function showList(){
	 		$("#deviceList").bootgrid("destroy");
			$("#deviceList").bootgrid({
				ajax: true,
		 		post: function ()
		 	    {
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
		            scanIp.push(rows[i].deviceIp);
		        }
		    }).on("deselected.rs.jquery.bootgrid", function(e, rows){
		    	var newIds = [];
		    	var newScanIp=[];
		    	if(rowIds.length==rows.length){
		    		rowIds=[];
		    		scanIp=[];
		    	}else{
		    		for (var i = 0; i < rows.length; i++){
		  	            for(var j = 0;j<rowIds.length;j++){
		  	            	if(rows[i].id==rowIds[j]){
		  	            		continue;
		  	            	}
		  	            	newIds.push(rowIds[j]);
		  	            	newScanIp.push(scanIp[j]);
		  	            }
		  	        }
		  	        rowIds = newIds;
		  	        scanIp=newScanIp;
		    	}
		    }).on("loaded.rs.jquery.bootgrid", function(e, rows){
		    	rowIds=[];
		    }) ;
	 	};
	 	$('#password').focus(function(){
			$('#password_alert').popover('hide');
		});
	 	$('#userName').focus(function(){
			$('#userName_alert').popover('hide');
		});
	 	$('#phoneNumber').focus(function(){
			$('#phoneNumber_alert').popover('hide');
		});
	 	$('#department').focus(function(){
			$('#department_alert').popover('hide');
		});
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
						url:"${ctx}/json/departmentAction!getDepartmentTree.action?id="+depId,
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
	  	//设备解锁
	    $("#openlockButton").click(function(){
	    	if(rowIds.length==0){
				window.wxc.xcConfirm("请选择要解锁的设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			}
	    	$.confirm({
    		    title: '提示信息!',
    		    content: '你确定要将解锁此设备吗？',
    		    confirm: function(){
    		    	$("#password").val("");
    				$("#password_alert").popover('hide');
    				$('#passwordModal').modal('show');
    				confirmstate="设备解锁";
    		    }    
    		});
		});
		//修改信息
	    $("#updataButton").click(function(){
	    	if(rowIds.length==0){
				window.wxc.xcConfirm("请选择要修改的设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			}
	    	if(rowIds.length>1){
				window.wxc.xcConfirm("只能选择一项要修改的设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			} 
	    	savestate="修改";
	    	$("[id$=_alert]").popover('hide');
	    	$('#resetdataModal').modal('show');
	    	showdepartment();
	    	$.post('${ctx}/json/deviceAction!findById.action',{'id':rowIds[0]},function(data){
				$("#userName").attr("value",data.device.userName);
				$("#phoneNumber").attr("value",data.device.phoneNumber);
				$("#address").attr("value",data.device.address);
				$("#department").attr("value",data.device.department.name);
				var depId=data.device.department.id;
				departmentId=depId;
				showdepartment(depId);
			});
		});
		//下发策略
	    function showissuedList(){
	 		$("#issuedList").bootgrid("destroy");
			$("#issuedList").bootgrid({
				ajax: true,
		 		post: function (){},
		 		url: "${ctx}/json/strategyAction!findByPage.action",
				selection: true,
		        multiSelect: true,
		        navigation:2,
		        rowSelect: true,
		        rowCount:[8,10,20,25],
		    }).on("selected.rs.jquery.bootgrid", function(e, rows){
		        for (var i = 0; i < rows.length; i++){
		        	issuedIds.push(rows[i].id);
		        }
		    }).on("deselected.rs.jquery.bootgrid", function(e, rows){
		    	var newIds = [];
		    	if(issuedIds.length==rows.length){
		    		issuedIds=[];
		    	}else{
		    		for (var i = 0; i < rows.length; i++){
		  	            for(var j = 0;j<issuedIds.length;j++){
		  	            	if(rows[i].id==issuedIds[j]){
		  	            		continue;
		  	            	}
		  	            	newIds.push(issuedIds[j]);
		  	            }
		  	        }
		    		issuedIds = newIds;
		    	  }
		    }).on("loaded.rs.jquery.bootgrid", function(e, rows){
		    	issuedIds=[];
		    }) ;
	 	}
		$("#sendButton").click(function(){
			 if(rowIds.length==0){
				window.wxc.xcConfirm("请至少选择一个设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			} 
			showissuedList();
			savestate="下发策略";
			issuedIds=[];
			$('#issuedModalLg').modal('show');
		});
		//设备卸载
		$("#deleteButton").click(function(){
			if(rowIds.length==0){
				window.wxc.xcConfirm("请选择要卸载的设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			}
	    	$.confirm({
    		    title: '提示信息!',
    		    content: '你确定要卸载此设备吗？',
    		    confirm: function(){
    		    	$("#password").val("");
    				$("#password_alert").popover('hide');
    				$('#passwordModal').modal('show');
    		    	confirmstate="设备卸载";
    		    }    
    		});			
		});
		//关闭设备
	    $("#closedeviceButton").click(function(){    	
	    	if(rowIds.length==0){
				window.wxc.xcConfirm("请选择要关闭的设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			}
	    	$.confirm({
    		    title: '提示信息!',
    		    content: '你确定要关闭此设备吗？',
    		    confirm: function(){
    		    	$("#password").val("");
    				$("#password_alert").popover('hide');
    				$('#passwordModal').modal('show');
    		    	confirmstate="设备关闭";
    		    }    
    		});			    	
		});
		//关闭内网
	    $("#closewifiButton").click(function(){    	
	    	if(rowIds.length==0){
				window.wxc.xcConfirm("请选择要关闭内网的设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			}
	    	$.confirm({
    		    title: '提示信息!',
    		    content: '你确定要关闭设备内网吗？',
    		    confirm: function(){
    		    	$("#password").val("");
    				$("#password_alert").popover('hide');
    				$('#passwordModal').modal('show');
    		    	confirmstate="关闭内网";
    		    }    
    		});	    	
		});
		//开启内网
		$("#openwifiButton").click(function(){    	
	    	if(rowIds.length==0){
				window.wxc.xcConfirm("请选择要开启内网的设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			}
	    	$.confirm({
    		    title: '提示信息!',
    		    content: '你确定要开启设备内网吗？',
    		    confirm: function(){
    		    	$("#password").val("");
    				$("#password_alert").popover('hide');
    				$('#passwordModal').modal('show');
    		    	confirmstate="开启内网";
    		    }    
    		});
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
		//删除
		$("#delectButton").click(function(){
			if(rowIds.length==0){
				window.wxc.xcConfirm("请选择要删除的设备", window.wxc.xcConfirm.typeEnum.info);
				return;
			}
	    	$.confirm({
    		    title: '提示信息!',
    		    content: '你确定要删除吗？',
    		    confirm: function(){
    		    	$("#password").val("");
    				$("#password_alert").popover('hide');
    				$('#passwordModal').modal('show');
    		    	confirmstate="删除";
    		    }    
    		});
			
		});
		//保存
		function save(){
			var phoneNumber=$("#phoneNumber").val();			
			if(savestate=="修改"){
				var userName=$("#userName").val();
				var address=$("#address").val();
				if(userName==""){
					$("#userName_alert").attr("data-content","用户名不能为空");
					$("#userName_alert").popover('show');
					return;
				}
				if(userName.length>30){
					$("#userName_alert").attr("data-content","用户名长度不能超过30");
					$("#userName_alert").popover('show');
					return;
				}
				if(phoneNumber==""){
					$("#phoneNumber_alert").attr("data-content","联系方式不能为空");
					$("#phoneNumber_alert").popover('show');
					return;
				}
				if(phoneNumber.length>30){
					$("#phoneNumber_alert").attr("data-content","联系方式长度不能超过30");
					$("#phoneNumber_alert").popover('show');
					return;
				}
				if(address==""){
					$("#address_alert").attr("data-content","位置不能为空");
					$("#address_alert").popover('show');
					return;
				}
				if(address.length>30){
					$("#address_alert").attr("data-content","位置长度不能超过30");
					$("#address_alert").popover('show');
					return;
				}
				$('#resetdataModal').modal('hide');
				$("#password").val("");
				$("#password_alert").popover('hide');
				$('#passwordModal').modal('show');
				confirmstate="修改密码确认";
			}
			if(savestate=="下发策略"){
				if(issuedIds.length==0){
					$.messager.show({title:'提示信息',msg:"请选择策略"});
					return;
				}else{
					$('#issuedModalLg').modal('hide');
					$("#password").val("");
    		    	$("#password_alert").popover('hide');
					$('#passwordModal').modal('show');
					confirmstate="下发策略密码确认";
				}
			}
		};	
	  //二次密码确认
	  function confirm(){
		  var newPassword=$("#password").val();
		  if(newPassword==""){
			    $("#password_alert").attr("data-content","密码不能为空");
			    $("#password_alert").popover('show');
			    return;
			}
		  if(newPassword.length>30){
			    $("#password_alert").attr("data-content","密码长度不能超过30");
			    $("#password_alert").popover('show');
			    return;
			}
		  if(!/^[A-Za-z0-9]+$/.test(newPassword)){
				$("#password_alert").attr("data-content","密码只能由字母或数字组成");
				$("#password_alert").popover('show');
				return;
			}
		  //加密
		  var result = RSAUtils.encryptedString(key,newPassword);  
		  $("#password").val(result);
		  if(confirmstate=="设备解锁"){
				$.ajax({
					type:"POST",
					url:"${ctx}/json/deviceAction!nulockeDevice.action?id="+rowIds.toString()+"&&module="+module,
					data:$("#password_form").serialize(),
					success:function(data){
						if(data.success==true){
							$('#passwordModal').modal('hide');
							$("#deviceList").bootgrid("reload");
							$.messager.show({title:'提示信息',msg:data.msg});
						}else{
							$('#passwordModal').modal('hide');
							$.messager.show({title:'提示信息',msg:data.msg});
						}
						 $.post('${ctx}/json/userAction!getPubKey.action',function(data){
							module=data.module;
							RSAUtils.setMaxDigits(512);  
							key = new RSAUtils.getKeyPair(data.empoent, "",data.module);  
						}); 
					}
				});	
			}
		  if(confirmstate=="修改密码确认"){
				$.ajax({
					type:"POST",
					url:"${ctx}/json/deviceAction!saveOrupdate.action?departmentId="+departmentId+"&id="+rowIds[0]
					+"&password="+$("#password").val()+"&module="+module,
					data:$("#resetdata_form").serialize(),
					success:function(data){
						if(data.success==true){
							$('#passwordModal').modal('hide');
							$("#deviceList").bootgrid("reload");
							$.messager.show({title:'提示信息',msg:data.msg});
						}else{
							$('#passwordModal').modal('hide');
							$.messager.show({title:'提示信息',msg:data.msg});
						}
						$.post('${ctx}/json/userAction!getPubKey.action',function(data){
							module=data.module;
							RSAUtils.setMaxDigits(512);  
							key = new RSAUtils.getKeyPair(data.empoent, "",data.module);  
						}); 
					}
				});
		  }
		  if(confirmstate=="下发策略密码确认"){
			  $.post("${ctx}/json/deviceAction!sendStrategy.action",{'devices':rowIds.toString(),'strategy':issuedIds[0],"password":$("#password").val(),"module":module},function(data){
					if(data.success==true){
						$('#passwordModal').modal('hide');
						$("#deviceList").bootgrid("reload");
						$.messager.show({title:'提示信息',msg:data.msg});
					}else{		
						$('#passwordModal').modal('hide');
						$.messager.show({title:'提示信息',msg:data.msg});
					}
					 $.post('${ctx}/json/userAction!getPubKey.action',function(data){
						module=data.module;
						RSAUtils.setMaxDigits(512);  
						key = new RSAUtils.getKeyPair(data.empoent, "",data.module);  
					}); 
				});
			}
			if(confirmstate=="设备卸载"){
				$.ajax({
					type:"POST",
					url:"${ctx}/json/deviceAction!uninstall.action?ids="+rowIds.toString()+"&&module="+module,
					data:$("#password_form").serialize(),
					success:function(data){
						if(data.success==true){
							$('#passwordModal').modal('hide');
							$("#deviceList").bootgrid("reload");
							$.messager.show({title:'提示信息',msg:data.msg});
						}else{
							$('#passwordModal').modal('hide');
							$.messager.show({title:'提示信息',msg:data.msg});
						}
						 $.post('${ctx}/json/userAction!getPubKey.action',function(data){
							module=data.module;
							RSAUtils.setMaxDigits(512);  
							key = new RSAUtils.getKeyPair(data.empoent, "",data.module);  
						}); 
					}
				});
			}
			if(confirmstate=="设备关闭"){
    			$.post('${ctx}/json/deviceAction!sendCommand.action', {'ids' : rowIds.toString(),'code' : '0',"password":$("#password").val(),"module":module}, function(data) {
					if(data.success==true){
						$('#passwordModal').modal('hide');
						$("#deviceList").bootgrid("reload");
						$.messager.show({title:'提示信息',msg:data.msg});
					}else{
						$('#passwordModal').modal('hide');
						$.messager.show({title:'提示信息',msg:data.msg});
					}
					 $.post('${ctx}/json/userAction!getPubKey.action',function(data){
						module=data.module;
						RSAUtils.setMaxDigits(512);  
						key = new RSAUtils.getKeyPair(data.empoent, "",data.module);  
					}); 
				});
			}
			if(confirmstate=="关闭内网"){	
				$.post('${ctx}/json/deviceAction!sendCommand.action', {'ids' :rowIds.toString(),'code' : '1',"password":$("#password").val(),"module":module}, function(data) {
					if(data.success==true){
						$('#passwordModal').modal('hide');
						$("#deviceList").bootgrid("reload");
						$.messager.show({title:'提示信息',msg:data.msg});
					}else{
						$('#passwordModal').modal('hide');
						$.messager.show({title:'提示信息',msg:data.msg});
					}
					$.post('${ctx}/json/userAction!getPubKey.action',function(data){
						module=data.module;
						RSAUtils.setMaxDigits(512);  
						key = new RSAUtils.getKeyPair(data.empoent, "",data.module);  
					}); 
				});
			}
			if(confirmstate=="开启内网"){
				$.post('${ctx}/json/deviceAction!sendCommand.action', {'ids' : rowIds.toString(),'code' : '2',"password":$("#password").val(),"module":module}, function(data) {
					if (data.success == true) {
							$('#passwordModal').modal('hide');
							$("#deviceList").bootgrid("reload");
							$.messager.show({title:'提示信息',msg:data.msg});
						}else{
							$('#passwordModal').modal('hide');
							$.messager.show({title:'提示信息',msg:data.msg});
						}
						 $.post('${ctx}/json/userAction!getPubKey.action',function(data){
							module=data.module;
							RSAUtils.setMaxDigits(512);  
							key = new RSAUtils.getKeyPair(data.empoent, "",data.module);  
						}); 
				});
			}
			if(confirmstate=="删除"){
				$.post('${ctx}/json/deviceAction!deleteDevice.action', {'ids' : rowIds.toString(),"password":$("#password").val(),"module":module}, function(data) {
					if(data.success==true){
						$('#passwordModal').modal('hide');
						$("#deviceList").bootgrid("reload");
						rowIds=[];
						$.messager.show({title:'提示信息',msg:data.msg});
					}else{
						$('#passwordModal').modal('hide');
						$.messager.show({title:'提示信息',msg:data.msg});
					}
					 $.post('${ctx}/json/userAction!getPubKey.action',function(data){
						module=data.module;
						RSAUtils.setMaxDigits(512);  
						key = new RSAUtils.getKeyPair(data.empoent, "",data.module);  
					}); 
				});
			}	   	
	};
	 
	var checkSubmitFlg=false;
	//创建扫描器
	$('#startIP').focus(function(){
		$('#start').popover('hide');
	});
	$('#endIP').focus(function(){
		$('#end').popover('hide');
	});
	$('#cms').focus(function(){
		$('#cms').popover('hide');
	});
	$("#createScanButton").click(function(){
		$("#startIP").val("");
		$("#endIP").val("");
		$("#cmsPort").val("");
		$("#scanIp").val("");
		if(rowIds.length==1){
			$('#scanInfoModal').modal('show');
			$("#scanIp").val(scanIp);
		}else if(rowIds.length==0){
			window.wxc.xcConfirm("请选择客户端", window.wxc.xcConfirm.typeEnum.info);
			return;
		}else if(rowIds.length>1){
			window.wxc.xcConfirm("只能选择一个客户端", window.wxc.xcConfirm.typeEnum.info);
			return;
		}
	});
	//保存扫描器
	function saveScan(){
		var checkSubmitFlg=false;
		var startIP=$("#startIP").val();
		var endIP=$("#endIP").val();
		var cmsPort = $("#cmsPort").val();
		if(startIP==""){
			$("#start").attr("data-content","ip不能为空");
			$("#start ").popover('show');
			return;
		}else{
			 if(!/((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))/.test(startIP)){
	        	$("#start").attr("data-content","ip格式不正确");
				$("#start").popover('show');
				return; 
	  		} 
		}
		if(endIP==""){
			$("#end").attr("data-content","ip不能为空");
			$("#end ").popover('show');
			return;
		}else{
			 if(!/((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))/.test(endIP)){
	        	$("#end").attr("data-content","ip格式不正确");
				$("#end").popover('show');
				return; 
	  		} 
		}
		var startIp_input=startIP.split(".");
    	var endIp_input=endIP.split(".");
        for (var i = 0; i < 4; i++){
     		if(i<3&&startIp_input[i]!=endIp_input[i]){
     			$("#end").attr("data-content","前三位ip段要保持一致");
				$("#end").popover('show');
				return;
     		}
            if ( i==3 &&parseInt(startIp_input[i])>=parseInt(endIp_input[i])){   
            	$("#end").attr("data-content","终止ip应大于起始ip");
				$("#end").popover('show');
				return;
            }
        }
    	if(cmsPort==""){
			$("#cms").attr("data-content","不能为空");
			$("#cms ").popover('show');
			return;
		}else{
			if(!/^([0-9]|[1-9]\d|[1-9]\d{2}|[1-9]\d{3}|[1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-5])$/i.test(cmsPort)){
	        	$("#cms").attr("data-content","格式不正确");
				$("#cms").popover('show');
				return; 
	  		} 
		}
		if(checkSubmitFlg==true){ 
				return false;
		}else{			
			$.ajax({
				type:"POST",
				url:"${ctx}/json/scanAction!save.action",
				data:$("#scan_form").serialize(),
				success:function(data){
					$('#scanInfoModal').modal('hide');
					if(data.success==true){
						$.messager.show({title:'提示信息',msg:data.msg});
					}else{
						$.messager.show({title:'提示信息',msg:data.msg});
					}
					checkSubmitFlg=true;	
				}
			});					
		}	
	}
	/*   
	//二次密码确认
	  function confirm(url,){
		  var newPassword=$("#password").val();
		  if(newPassword==""){
			    $("#password_alert").attr("data-content","密码不能为空");
			    $("#password_alert").popover('show');
			    return;
			}
		  //加密
		  var result = RSAUtils.encryptedString(key,newPassword);  
		  $("#password").val(result);
		  $.post('${ctx}/json/deviceAction!deleteDevice.action', {'ids' : rowIds.toString(),"password":$("#password").val(),"module":module}, function(data) {
				if (data.success == true) {
					var result = RSAUtils.encryptedString(key,newPassword); 
					if(data.success==true){
						$('#passwordModal').modal('hide');
						$("#deviceList").bootgrid("reload");
						rowIds=[];
						$.messager.show({title:'提示信息',msg:data.msg});
					}else{
						$('#passwordModal').modal('hide');
						$.messager.show({title:'提示信息',msg:data.msg});
					}
					 $.post('${ctx}/json/userAction!getPubKey.action',function(data){
						module=data.module;
						RSAUtils.setMaxDigits(512);  
						key = new RSAUtils.getKeyPair(data.empoent, "",data.module);  
					}); 
				}
			});
			   	
	  }; */
	</script>
  </body>
</html>
