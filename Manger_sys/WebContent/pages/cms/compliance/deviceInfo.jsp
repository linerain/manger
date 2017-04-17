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
	#deviceform input,#deviceform select{width:170px;}
	.bootgrid-table th>.column-header-anchor>.text {display: block;margin: 0 16px 0 0;
    overflow: hidden;-ms-text-overflow: ellipsis;-o-text-overflow: ellipsis;
    text-overflow: ellipsis; white-space: nowrap; font-size: 14px;}
  </style>
  <body>
  	<div class="container-fluid">
	  	<div class="row">
	  		<div class='col-sm-12' >					
			     <a id='detaileButton'  class='a-btn btn-info'>
			     	<span class='glyphicon glyphicon-info-sign' ></span>
			     	<span class='a-btn-slide-text'>状态信息</span>
			     </a>
			</div>
			<div class='col-sm-12' style="margin-top:20px;">
				<form id='deviceform' class='form-inline' role='form'>
					<div class='form-group' style="margin-bottom:10px;">
						<!-- <label>&nbsp;&nbsp;&nbsp;&nbsp;用户名:</label> -->
						<div style="display: inline-block;">
						  	<input  type='text'  name='userName' placeholder="用户名"   class='form-control' id="userName"  />
					  	</div>
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						<!--  <label>&nbsp;&nbsp;&nbsp;&nbsp;设备名称:</label> -->
						 <div style="display: inline-block;">
						   	<input type='text' placeholder="设备名称"  name='device'  class='form-control' id="device" />
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						<!--  <label>&nbsp;&nbsp;&nbsp;&nbsp;IP:</label> -->
						 <div style="display: inline-block;">
						   	<input type='text' placeholder="IP地址"  name='deviceSearchModel.IP'  class='form-control' id="ip" />
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						<!--  <label>&nbsp;&nbsp;&nbsp;&nbsp;状态:</label> -->
						 <div style="display: inline-block;">
						 	<select name="deviceSearchModel.state" id="state"  class='form-control'>
								<option value="" selected="selected" id="state_no">请选择状态</option>
								<option value="1">正常</option>
								<option value="0">异常</option>
							</select>
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						 <!-- <label>&nbsp;&nbsp;&nbsp;&nbsp;锁定状态:</label> -->
						 <div style="display: inline-block;">
						 	<select name="deviceSearchModel.lockState" id="lockState"  class='form-control'>
								<option value="" selected="selected" id="lockState_no">请选择锁定状态</option>
								<option value="1">正常</option>
								<option value="0">异常</option>
							</select>
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						<!--  <label>&nbsp;&nbsp;&nbsp;&nbsp;在线状态:</label> -->
						 <div style="display: inline-block;">
						 	<select name="deviceSearchModel.lineState" id="lineState"  class='form-control'>
								<option value="" selected="selected" id="lineState_no">请选择在线状态</option>
								<option value="1">正常</option>
								<option value="0">异常</option>
							</select>
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						<!--  <label>&nbsp;&nbsp;&nbsp;&nbsp;VRV状态:</label> -->
						 <div style="display: inline-block;">
						 	<select name="deviceSearchModel.VRVstate" id="VRVstate"  class='form-control'>
								<option value="" selected="selected" id="VRVstate_no">请选择VRV状态</option>
								<option value="1">正常</option>
								<option value="0">异常</option>
							</select>
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						 <!-- <label>&nbsp;&nbsp;&nbsp;&nbsp;违规外联状态:</label> -->
						 <div style="display: inline-block;">
						 	<select name="deviceSearchModel.clientState" id="clientState"  class='form-control'>
								<option value="" selected="selected" id="clientState_no">请选择违规外联状态</option>
								<option value="1">正常</option>
								<option value="0">异常</option>
							</select>
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						<!--  <label>&nbsp;&nbsp;&nbsp;&nbsp;杀毒软件状态:</label> -->
						 <div style="display: inline-block;">
						 	<select name="deviceSearchModel.antivirusState" id="antivirusState"  class='form-control'>
								<option value="" selected="selected" id="antivirusState_no">请选择杀毒软件状态</option>
								<option value="1">正常</option>
								<option value="0">异常</option>
							</select>
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						<!--  <label>&nbsp;&nbsp;&nbsp;&nbsp;黑名单进程状态:</label> -->
						 <div style="display: inline-block;">
						 	<select name="deviceSearchModel.blackState" id="blackState"  class='form-control'>
								<option value="" selected="selected" id="blackState_no">请选择黑名单进程状态</option>
								<option value="1">正常</option>
								<option value="0">异常</option>
							</select>
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						<!--  <label>&nbsp;&nbsp;&nbsp;&nbsp;白名单进程状态:</label> -->
						 <div style="display: inline-block;">
						 	<select name="deviceSearchModel.whiteState" id="whiteState"  class='form-control'>
								<option value="" selected="selected" id="whiteState_no">请选择白名单进程状态</option>
								<option value="1">正常</option>
								<option value="0">异常</option>
							</select>
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						<!--  <label>&nbsp;&nbsp;&nbsp;&nbsp;弱口令状态:</label> -->
						 <div style="display: inline-block;">
						 	<select name="deviceSearchModel.weakpasswordState" id="weakpasswordState"  class='form-control'>
								<option value="" selected="selected" id="weakpasswordState_no">请选择弱口令状态</option>
								<option value="1">正常</option>
								<option value="0">异常</option>
							</select>
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;margin-left:10px;">
					 	<button type="reset"  class="btn btn-info"  id="resetdata" style="margin-left:10px">重置</button>
				 		<button type="button"  class="btn btn-info"  id="screendata" >查看</button>
					</div>	
				</form>
			</div>
  			<div class="col-sm-12" style="margin-top:20px;">
			 	<table id="deviceList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">id</th>
				          <!--   <th data-column-id="name">行号</th> -->
				            <th data-column-id="userName">用户名 </th>
				            <th data-column-id="deviceIp">设备IP </th>
				            <th data-column-id="deviceName">设备名称</th>
				            <th data-column-id="phoneNumber">联系电话 </th>
				            <th data-column-id="state">整体状态 </th>
				            <th data-column-id="dealState">处理动作</th>      
				        	<th data-column-id="VRVstate">VRV状态 </th>
				        	<th data-column-id="cmsOnline">在线状态  </th>
				        </tr>
				     </thead>
				</table>
			</div>
			<!-- <div id="condition_form" class="col-sm-12" style="display:none">
				<div class="panel panel-info">
					<div class="panel-heading" style="padding:0 10px;">
						<h3 class="panel-title">状态信息</h3>
					</div>
					<div class="panel-body row" >
					  		
					</div>	
				</div> 
			</div>	 -->	
		</div>
		<!-- 详细信息 -->
		<div class="modal fade bs-example-modal-lg" id="showInfoModalLg" tabindex="-1" role="dialog" aria-labelledby="showInfomyModalLabelLg" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog modal-lg" role="document">
		      <div class="modal-content">
			      <div class="modal-header" >
			      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
			     	<h4 class='modal-title' id='showInfomyModalLabelLg'>详细信息</h4>
			      </div>
			      <div class="modal-body" id='function-panel'>
			      	
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			      </div>
		     	</div>
			</div>
		</div>
    </div>
	<script type="text/javascript">
	 	var rowIds = [];
	 	var param=$("#deviceform").serialize();
	 	showList();
	 	function showList(){
	 		$("#deviceList").bootgrid("destroy");
			$("#deviceList").bootgrid({
		    	ajax: true,
		    	 post: function ()
		    	    {
		    	        return {
		    	            name: $("#userName").val(),
		    	            deviceName:$("#device").val()
		    	        };
		    	    },
		        url: "${ctx}/json/deviceAction!findByPage.action?"+param,
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
	  		var ip=$("#ip").val(); 
			if(ip!=""&&!/((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))/.test(ip)){
	  			var txt=  "ip地址格式不正确";
	            window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
	            return;
	  		} 
			param=$("#deviceform").serialize();
			showList();
		});
		//重置
		$("#resetdata").click(function(){
	  		$("#device").val("");
	  		$("#userName").val("");
	  		$("#ip").val("");
	  		$("#state_no").attr("selected","selected");
	  		$("#lockState_no").attr("selected","selected");
	  		$("#lineState_no").attr("selected","selected");
	  		$("#VRVstate_no").attr("selected","selected");
	  		$("#clientState_no").attr("selected","selected");
	  		$("#antivirusState_no").attr("selected","selected");
	  		$("#blackState_no").attr("selected","selected");
	  		$("#whiteState_no").attr("selected","selected");
	  		$("#weakpasswordState_no").attr("selected","selected");
	  		param=$("#deviceform").serialize();
	  		showList();
  		});
		//状态信息
		$("#detaileButton").click(function(){
			if(rowIds.length>1){
				var txt=  "只能选择一个查看";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			if(rowIds.length==0){
				var txt=  "请至少选择一个";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			$('#showInfoModalLg').modal('show'); 
			$('#function-panel').html("");
	    	$.post('${ctx}/json/deviceAction!showStates.action',{'id':rowIds[0]},function(data){
	    		var device=data.devicePageModel;
    		    var blackProcessNames="";
				 	var blackProcessErrorList=device.blackProcessErrorList;
				 	for(var i=0;i<blackProcessErrorList.length;i++){
				 		if(i==0){
				 			blackProcessNames+=blackProcessErrorList[i].processName;
				 		}else{
				 			blackProcessNames+="、"+blackProcessErrorList[i].processName;
				 		}
				 	}
				 	var whiteProcessNames="";
    			var whiteProcessErrorList=device.whiteProcessErrorList;
				 	for(var i=0;i<whiteProcessErrorList.length;i++){
				 		if(i==0){
				 			whiteProcessNames+=whiteProcessErrorList[i].processName;
				 		}else{
				 			whiteProcessNames+="、"+whiteProcessErrorList[i].processName;
				 		}
				 	}
	    		var html="<table style='' class='table table-bordered table-hover'>"+
	    					"<tr>"+
	    						"<td>检测项</td>"+
	    						"<td>当前状态</td>"+
	    						"<td>处理动作</td>"+
	    					"</tr>"+
	    					"<tr>"+
	    						"<td>违规外联</td>"+
	    						"<td>"+device.violationLinkState+"</td>"+
	    						"<td>"+device.violationLinkAction+"</td>"+
	    					"</tr>"+
	    					"<tr>"+
	    						"<td>杀毒软件</td>"+
	    						"<td>"+device.antState+"</td>"+
	    						"<td>"+device.antivirusAction+"</td>"+
	    					"</tr>"+
	    					"<tr>"+
	    						"<td>弱口令</td>"+
	    						"<td>"+device.weakPasswordState+"</td>"+
	    						"<td>"+device.weakPasswordAction+"</td>"+
	    					"</tr>"+
	    					"<tr>"+
	    						"<td>黑名单进程</td>"+
	    						"<td>"+device.processBlackState+"</td>"+
	    						"<td>"+device.blackProcessGroupAction+"</td>"+
	    					"</tr>"+
	    					"<tr>"+
	    						"<td>白名单进程</td>"+
	    						"<td>"+device.processWhiteState+"</td>"+
	    						"<td>"+device.whiteProcessGroupAction+"</td>"+
	    					"</tr>"+
	    				"</table>"+
	    				 "<table style=''  class='table'>"+
	    				 	"<tr><td colspan=2 style='text-align: center;'>黑白名单进程状态</td></tr>"+
	    				 	"<tr>"+
	    				 		"<td>黑名单进程</td>"+
	    				 		"<td>"+(blackProcessNames==""?'无':blackProcessNames)+"</td>"+
	    				 	"</tr>"+
	    				 	"<tr>"+
	    				 		"<td>白名单进程</td>"+
	    				 		"<td>"+(whiteProcessNames==""?'无':whiteProcessNames)+"</td>"+
	    				 	"</tr>"+
	    				 "</table>";
	    		$("#function-panel").append(html);
	    	});
		});
	</script>
  </body>
</html>
