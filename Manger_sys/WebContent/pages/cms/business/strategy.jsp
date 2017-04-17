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
	  		<div class='col-sm-5' id='button_div'>
			     <a id='saveButton'  class='a-btn btn-success'>
			 		 <span class='glyphicon glyphicon-plus'></span>
			 		 <span class='a-btn-slide-text'>添&nbsp;&nbsp;&nbsp;&nbsp;加</span>
			 	 </a>
				 <a id='updateButton'  class='a-btn btn-info'>
			     	<span class='glyphicon glyphicon-pencil' ></span>
			     	<span class='a-btn-slide-text'>修&nbsp;&nbsp;&nbsp;&nbsp;改</span>
			     </a>
				 <a id='delButton'  class='a-btn btn-default active'>
			     	<span class='glyphicon glyphicon-trash'></span>
			     	<span class='a-btn-slide-text'>删&nbsp;&nbsp;&nbsp;&nbsp;除</span>
			     </a> 
			</div>
			<div class='col-sm-5' >
				<form id='return_form' class='form-inline' role='form'>
					<div class='form-group' style="margin-bottom:10px;">
						 <label>名称:</label>
						 <div style="display: inline-block;">
						   	<input type='text'  name='name'  class='form-control' id="name" />
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
				            <th data-column-id="name">策略名称</th>
				            <th data-column-id="antivirusName">杀毒软件</th>
				            <th data-column-id="antivirusActionString">杀毒软件处理方式</th>
				            <th data-column-id="violationLinkStaticText">违规外联处理方式</th>
				            <th data-column-id="weakPasswordStaticText">弱口令处理方式</th>
				            <th data-column-id="whiteProcessGroupName">进程白名单组</th>
				            <th data-column-id="whiteProcessGroupActionString">进程白名单处理方式</th>
				            <th data-column-id="blackProcessGroupName">进程黑名单组</th>
				            <th data-column-id="blackProcessGroupActionString">进程黑名单处理方式</th>
				            <th data-column-id="portGroupName">封堵端口组</th>
				            <th data-column-id="ipGroupName">违规后仍可联通IP地址</th>
				        </tr>
				     </thead>
				</table>
			</div>
		</div>
		<!-- 添加和修改模态框 -->
	  	<div class="modal fade bs-example-modal-lg" id="infoModal"  tabindex="-1" role="dialog" aria-labelledby="infoModalLabelLg" data-backdrop="static" data-keyboard="false">
	  		<div class="modal-dialog modal-lg" role="document">
				  <div class="modal-content">
					  <div class="modal-header" >
					  	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true' >&times;</span></button>
			     		<h4 class='modal-title' id='detailinforLabel'>添加/修改</h4>
					  </div>
					  <div class="modal-body" id="detailinfor-bodyLg">
						  <form id='detail_form' class='form-horizontal' role='form'>	    
								<div class='form-group'>
								    <label  class='col-sm-4 control-label'>策略名称*:</label>
								    <div class='col-sm-5' id='userName_alert'  data-toggle='popover' data-trigger='manual'>
										<input type='text' name='strategy.name'  class='form-control' id='userName'/>
									</div>
								</div>			
								<div class='form-group'>
								    <label  class='col-sm-4 control-label'>杀毒软件违规处理方式*:</label>
								    <div class='col-sm-5' id='antivirusAction_alert'  data-toggle='popover' data-trigger='manual'>
										<select name="strategy.antivirusAction"  id="antivirusAction" class='form-control' >
				                            <option value="0" selected="selected" id="antivirusAction_0">禁用</option>
											<option value="1" id="antivirusAction_1">启用，仅提示</option>
											<option value="2" id="antivirusAction_2">启用，提示并断网</option>
											<option value="3" id="antivirusAction_3">启用，提示、断网并锁屏</option>
										</select>
									</div>
								</div>	
								<div class='form-group' id="antivirus_div" style="display:none">
								    <label  class='col-sm-4 control-label'>杀毒软件*:</label>
								    <div class='col-sm-5' id='antivirus_alert'  data-toggle='popover' data-trigger='manual'>
										<select name="strategy.antivirus"  id="antivirus" class='form-control' >
										</select>
									</div>
								</div>			
								<div class='form-group'>
								    <label  class='col-sm-4 control-label'>违规外联处理方式*:</label>
								    <div class='col-sm-5' id='violationLink_alert'  data-toggle='popover' data-trigger='manual'>
										<select name="strategy.violationLink"  id="violationLink" class='form-control'>
											<option value="0" selected="selected" id="violationLink_0">禁用</option>
											<option value="1" id="violationLink_1">启用，仅提示</option>
											<option value="2" id="violationLink_2">启用，提示并断网</option>
											<option value="3" id="violationLink_3">启用，提示、断网并锁屏</option>
										</select>
									</div>
								  </div>			
								<div class='form-group'>
								    <label  class='col-sm-4 control-label'>弱口令*:</label>
								    <div class='col-sm-5' id='weakPassword_alert'  data-toggle='popover' data-trigger='manual'>
										<select name="strategy.weakPassword"  id="weakPassword" class='form-control'  >
											<option value="0" id="weakPassword_0">禁用</option>
											<option value="1" id="weakPassword_1">启用</option>
			                            </select>
									</div>
								</div>	
								<div class='form-group'>
								    <label  class='col-sm-4 control-label'>白名单进程未启动处理方式*:</label>
								    <div class='col-sm-5' id='whiteProcessGroupAction_alert'  data-toggle='popover' data-trigger='manual'>
										<select name="strategy.whiteProcessGroupAction"  id="whiteProcessGroupAction" class='form-control'>
											<option value="0" selected id="whiteProcessGroupAction_0">禁用</option>
											<option value="1" id="whiteProcessGroupAction_1">启用</option>			
										</select>
									</div>
								</div>
								<div class='form-group' id="whiteProcessGroup_div" style="display:none">
								    <label  class='col-sm-4 control-label'>进程白名单*:</label>
								    <div class='col-sm-5' id='whiteProcessGroup_alert'  data-toggle='popover' data-trigger='manual'>
										<select name="strategy.whiteProcessGroup"  id="whiteProcessGroup" class='form-control' ></select>
									</div>
								</div>		
								<div class='form-group'>
								    <label  class='col-sm-4 control-label'>黑名单进程启动处理方式*:</label>
								    <div class='col-sm-5' id='blackProcessGroupAction_alert'  data-toggle='popover' data-trigger='manual'>
										<select name="strategy.blackProcessGroupAction"  id="blackProcessGroupAction" class='form-control'>
											<option value="0" selected id="blackProcessGroupAction_0">禁用</option>
											<option value="1" id="blackProcessGroupAction_1">启用</option>
											<option value="4" id="blackProcessGroupAction_4">启用，并杀进程</option>
										</select>
									</div>
								</div>
								<div class='form-group' id="blackProcessGroup_div" style="display:none">
								    <label  class='col-sm-4 control-label'>进程黑名单组*:</label>
								    <div class='col-sm-5' id='blackProcessGroup_alert'  data-toggle='popover' data-trigger='manual'>
										<select name="strategy.blackProcessGroup"  id="blackProcessGroup" class='form-control'></select>
									</div>
								</div>		
								<div class='form-group' id="portGroup_div" style="display:none">
								    <label  class='col-sm-4 control-label'>封堵端口组*:</label>
								    <div class='col-sm-5' id='portGroup_alert'  data-toggle='popover' data-trigger='manual'>
										<select name="strategy.portGroup"  id="portGroup" class='form-control'></select>
									</div>
								</div>	
								<div class='form-group' id="ipGroup_div" style="display:none">
								    <label  class='col-sm-4 control-label'>违规后仍可联通IP地址*:</label>
								    <div class='col-sm-5' id='ipGroup_alert'  data-toggle='popover' data-trigger='manual'>
										<select name="strategy.ipGroup"  id="ipGroup" class='form-control'></select>
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
		        	/* return {
		        		name:$("#name").val()
		        	} */
		        },
		        url: "${ctx}/json/strategyAction!findByPage.action?name="+$("#name").val(),
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
			showList();
		});
		//重置
		$("#resetdata").click(function(){
	  		$("#name").val("");
	  		showList();
  		});
		///提示框隐藏
		$("#userName").focus(function(){
			$("#userName_alert").popover('hide');
		});
		$("#antivirusAction").focus(function(){
			$("#antivirusAction_alert").popover('hide');
		});
		$("#antivirus").focus(function(){
			$("#antivirus_alert").popover('hide');
		});
		$("#violationLink").focus(function(){
			$("#violationLink_alert").popover('hide');
		});
		$("#weakPassword").focus(function(){
			$("#weakPassword_alert").popover('hide');
		});
		$("#whiteProcessGroupAction").focus(function(){
			$("#whiteProcessGroupAction_alert").popover('hide');
		});
		$("#whiteProcessGroup").focus(function(){
			$("#whiteProcessGroup_alert").popover('hide');
		});
		$("#blackProcessGroupAction").focus(function(){
			$("#blackProcessGroupAction_alert").popover('hide');
		});
		$("#blackProcessGroup").focus(function(){
			$("#blackProcessGroup_alert").popover('hide');
		});
		$("#portGroup").focus(function(){
			$("#portGroup_alert").popover('hide');
		});
		$("#ipGroup").focus(function(){
			$("#ipGroup_alert").popover('hide');
		});
		//新增
		var checkSubmitFlg=false;
		$("#saveButton").click(function(){
			savaState="新增";
			$("#userName").val("");
			$("[id$=_alert]").popover('hide');
			$('#infoModal').modal('show');
			//document.getElementById("detail_form").reset();
			$("#userName").removeAttr("readonly");
			$("#antivirus_div").hide();
			$("#whiteProcessGroup_div").hide();
			$("#blackProcessGroup_div").hide();
			$("#portGroup_div").hide();
			$("#ipGroup_div").hide();
			$("#violationLink>option").removeAttr("selected");
			$("#antivirusAction>option").removeAttr("selected");
			$("#blackProcessGroupAction>option").removeAttr("selected");
			$("#whiteProcessGroupAction>option").removeAttr("selected");
			$("#userName>option").removeAttr("selected"); 
			//杀毒软件
	    	$.post('${ctx}/json/antivirusInfoAction!findAll.action',function(data){
	    	      $("#antivirus").html("<option value=''>---请选择---</option>");
	    		var antivirus=data.antiList;
	    		for (var i = 0; i < antivirus.length; i++) {
					$("#antivirus").append("<option value='"+antivirus[i].code+"'>"+antivirus[i].name+"</option>");
				}
	    	});
	    	//端口组
	    	$.post('${ctx}/json/portGroupAction!findAll.action',function(data){
	    		$("#portGroup").html("<option value=''>---请选择---</option>");
	    		var protGroup=data.list;
				for (var i = 0; i < protGroup.length; i++) {
					$("#portGroup").append("<option value='"+protGroup[i].id+"'>"+protGroup[i].name+"</option>");
				}
	    	});
	    	//IP组
	    	$.post('${ctx}/json/ipGroupAction!findAll.action',function(data){
	    		$("#ipGroup").html("<option value=''>---请选择---</option>");
	    		var ipGroup=data.list;
				for (var i = 0; i < ipGroup.length; i++) {
					$("#ipGroup").append("<option value='"+ipGroup[i].id+"'>"+ipGroup[i].name+"</option>");
				}
	    	});
	    	//白名单组  
	    	$.post('${ctx}/json/processGroupAction!findAllWhite.action',function(data){
	    		$("#whiteProcessGroup").html("<option value=''>---请选择---</option>");
	    		var whiteProcessGroup=data.list;
				for (var i = 0; i < whiteProcessGroup.length; i++) {
					$("#whiteProcessGroup").append("<option value='"+whiteProcessGroup[i].id+"'>"+whiteProcessGroup[i].name+"</option>");
				}
	    	});
	    	//黑名单组
	    	$.post('${ctx}/json/processGroupAction!findAllBlack.action',function(data){
	    		$("#blackProcessGroup").html("<option value=''>---请选择---</option>");
	    		var blackProcessGroup=data.list;
				for (var i = 0; i < blackProcessGroup.length; i++) {
					$("#blackProcessGroup").append("<option value='"+blackProcessGroup[i].id+"'>"+blackProcessGroup[i].name+"</option>");
				}
	    	});
			checkSubmitFlg=false;
		});
		//修改
		$("#updateButton").click(function(){
			if(rowIds.length==1){
				savaState="修改";
				$("[id$=_alert]").popover('hide');
				/* $("#userName_alert").popover('hide');
				$("#antivirusAction_alert").popover('hide');				
				$("#antivirus_alert").popover('hide');			
				$("#violationLink_alert").popover('hide');				
				$("#weakPassword_alert").popover('hide');				
				$("#whiteProcessGroupAction_alert").popover('hide');				
				$("#whiteProcessGroup_alert").popover('hide');		
				$("#blackProcessGroupAction_alert").popover('hide');			
				$("#blackProcessGroup_alert").popover('hide');			
				$("#portGroup_alert").popover('hide');				
				$("#ipGroup_alert").popover('hide'); */
				$.post('${ctx}/json/strategyAction!findById.action',{'id' : rowIds[0]}, function(dataMap) {
					$("#userName").val(dataMap.strategyPageModel.name);
					oldName=dataMap.strategyPageModel.name;
					if(dataMap.strategyPageModel.isSys){
                    	$("#userName").attr("readonly","readonly");
                    }
					//杀毒软件
					var antiviru=dataMap.strategyPageModel.antivirus;
			    	$.post('${ctx}/json/antivirusInfoAction!findAll.action',function(data){
			    		var antivirus=data.antiList;
			    		$("#antivirus").html("<option value=''>---请选择---</option>");
			    		for (var i = 0; i < antivirus.length; i++) {
			    			if(antivirus[i].code==antiviru){
								$("#antivirus").append("<option value='"+antivirus[i].code+"' selected='selected'>"+antivirus[i].name+"</option>");
			    			}else{
								$("#antivirus").append("<option value='"+antivirus[i].code+"'>"+antivirus[i].name+"</option>");
			    			}
						}
			    	});	
			    	//弱口令
			    	if(dataMap.strategyPageModel.weakPassword==0){
			    		$("#weakPassword").val("0");
				    	$("#weakPassword_0").attr("selected","selected");
			    	}else if(dataMap.strategyPageModel.weakPassword==1){
			    		$("#weakPassword").val("1");
			    		$("#weakPassword_1").attr("selected","selected");
			    	}
					//杀毒软件执行方式
					if(dataMap.strategyPageModel.antivirusAction==0){
						$("#antivirusAction").val("0");
						$("#antivirusAction_0").attr("selected","selected");
						$("#antivirus_div").hide();
					}else if(dataMap.strategyPageModel.antivirusAction==1){
						$("#antivirusAction").val("1");
						$("#antivirusAction_1").attr("selected","selected");
						$("#antivirus_div").show();
					}else if(dataMap.strategyPageModel.antivirusAction==2){
						$("#antivirusAction").val("2");
						$("#antivirusAction_2").attr("selected","selected");
						$("#antivirus_div").show();
					}else if(dataMap.strategyPageModel.antivirusAction==3){
						$("#antivirusAction").val("3");
						$("#antivirusAction_3").attr("selected","selected");
						$("#antivirus_div").show();
					}
					//违规外联
					var violationLink=dataMap.strategyPageModel.violationLink;
					if(violationLink==0){
						$("#violationLink").val("0");
						$("#violationLink_0").attr("selected","selected");
					}else if(violationLink==1){
						$("#violationLink").val("1");
						$("#violationLink_1").attr("selected","selected");
					}else if(violationLink==2){
						$("#violationLink").val("2");
						$("#violationLink_2").attr("selected","selected");
					}else if(violationLink==3){
						$("#violationLink").val("3");
						$("#violationLink_3").attr("selected","selected");
					}
					//白名单组  
			    	$.post('${ctx}/json/processGroupAction!findAllWhite.action',function(data){
			    		$("#whiteProcessGroup").html("<option value=''>---请选择---</option>");
			    		var whiteProcessGroup=data.list;
						for (var i = 0; i < whiteProcessGroup.length; i++) {
							if(whiteProcessGroup[i].id==dataMap.strategyPageModel.whiteProcessGroup){
								$("#whiteProcessGroup").append("<option value='"+whiteProcessGroup[i].id+"' selected='selected'>"+whiteProcessGroup[i].name+"</option>");
							}else{
								$("#whiteProcessGroup").append("<option value='"+whiteProcessGroup[i].id+"'>"+whiteProcessGroup[i].name+"</option>");
							}
						}
			    	});
			    	//白名单执行动作
			    	var whiteProcessGroupAction=dataMap.strategyPageModel.whiteProcessGroupAction;
					if(whiteProcessGroupAction==0){
						$("#whiteProcessGroupAction").val("0");
						$("#whiteProcessGroupAction_0").attr("selected","selected");
						$("#whiteProcessGroup_div").hide();
					}else if(whiteProcessGroupAction==1){
						$("#whiteProcessGroupAction").val("1");
						$("#whiteProcessGroupAction_1").attr("selected","selected");
						$("#whiteProcessGroup_div").show();
					}
					//黑名单组
			    	$.post('${ctx}/json/processGroupAction!findAllBlack.action',function(data){
			    		$("#blackProcessGroup").html("<option value=''>---请选择---</option>");
			    		var blackProcessGroup=data.list;
						for (var i = 0; i < blackProcessGroup.length; i++) {
							if(blackProcessGroup[i].id==dataMap.strategyPageModel.blackProcessGroup){
								$("#blackProcessGroup").append("<option value='"+blackProcessGroup[i].id+"' selected='selected'>"+blackProcessGroup[i].name+"</option>");
							}else{
								$("#blackProcessGroup").append("<option value='"+blackProcessGroup[i].id+"'>"+blackProcessGroup[i].name+"</option>");
							}
						}
			    	});
			    	//黑名单执行动作
			    	var blackProcessGroupAction=dataMap.strategyPageModel.blackProcessGroupAction;
			    	if(blackProcessGroupAction==0){
			    		$("#blackProcessGroupAction").val("0");
						$("#blackProcessGroupAction_0").attr("selected","selected");
						$("#blackProcessGroup_div").hide();
					}else if(blackProcessGroupAction==1){
						$("#blackProcessGroupAction").val("1");
						$("#blackProcessGroupAction_1").attr("selected","selected");
						$("#blackProcessGroup_div").show();
					}else if(blackProcessGroupAction==4){
						$("#blackProcessGroupAction").val("4");
						$("#blackProcessGroupAction_4").attr("selected","selected");
						$("#blackProcessGroup_div").show();
					}
					//端口组
			    	$.post('${ctx}/json/portGroupAction!findAll.action',function(data){
			    		$("#portGroup").html("<option value=''>---请选择---</option>");
			    		var protGroup=data.list;
						for (var i = 0; i < protGroup.length; i++) {
							if(protGroup[i].id==dataMap.strategyPageModel.portGroup){
								$("#portGroup").append("<option value='"+protGroup[i].id+"' selected='selected'>"+protGroup[i].name+"</option>");
							}else{
								$("#portGroup").append("<option value='"+protGroup[i].id+"' >"+protGroup[i].name+"</option>");
							}
						}
			    	});
			    	//IP组
			    	$.post('${ctx}/json/ipGroupAction!findAll.action',function(data){
			    		$("#ipGroup").html("<option value=''>---请选择---</option>");
			    		var ipGroup=data.list;
						for (var i = 0; i < ipGroup.length; i++) {
							if(ipGroup[i].id==dataMap.strategyPageModel.ipGroup){
								$("#ipGroup").append("<option value='"+ipGroup[i].id+"' selected='selected'>"+ipGroup[i].name+"</option>");
							}else{
								$("#ipGroup").append("<option value='"+ipGroup[i].id+"'>"+ipGroup[i].name+"</option>");
							}
						}
			    	});
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
			var userName=$("#userName").val();
			var antivirusAction=$("#antivirusAction").val();
			var antivirus=$("#antivirus").val();
			var violationLink=$("#violationLink").val();
			var weakPassword=$("#weakPassword").val();
			var whiteProcessGroupAction=$("#whiteProcessGroupAction").val();
			var whiteProcessGroup=$("#whiteProcessGroup").val();
			var blackProcessGroupAction=$("#blackProcessGroupAction").val();
			var blackProcessGroup=$("#blackProcessGroup").val();
			var portGroup=$("#portGroup").val();
			var ipGroup=$("#ipGroup").val();
			if(userName==""){
				$("#userName_alert").attr("data-content","策略名称不能为空");
				$("#userName_alert").popover('show');
				return;
			}
			if(userName.length>30){
				$("#userName_alert").attr("data-content","策略名称长度不能超过30");
				$("#userName_alert").popover('show');
				return;
			}
			if(antivirusAction==""){
				$("#antivirusAction_alert").attr("data-content","杀毒软件违规处理方式不能为空");
				$("#antivirusAction_alert").popover('show');
				return;
			}
			if($("#antivirus_div").is(':visible')){
				if(antivirus==""){
					$("#antivirus_alert").attr("data-content","杀毒软件不能为空");
					$("#antivirus_alert").popover('show');
					return;
				}
			}else{
				$("#antivirus").val("");
			}
			
			if(violationLink==""){
				$("#violationLink_alert").attr("data-content","违规外联处理方式不能为空");
				$("#violationLink_alert").popover('show');
				return;
			}
			if(weakPassword==""){
				$("#weakPassword_alert").attr("data-content","弱口令不能为空");
				$("#weakPassword_alert").popover('show');
				return;
			}
			if(whiteProcessGroupAction==""){
				$("#whiteProcessGroupAction_alert").attr("data-content","白名单进程未启动处理方式不能为空");
				$("#whiteProcessGroupAction_alert").popover('show');
				return;
			}
			if($("#whiteProcessGroup_div").is(':visible')){
				if(whiteProcessGroup==""){
					$("#whiteProcessGroup_alert").attr("data-content","进程白名单不能为空");
					$("#whiteProcessGroup_alert").popover('show');
					return;
				}
			}else{
				$("#whiteProcessGroup").val("");
			}
			if(blackProcessGroupAction==""){
				$("#blackProcessGroupAction_alert").attr("data-content","黑名单进程启动处理方式不能为空");
				$("#blackProcessGroupAction_alert").popover('show');
				return;
			}
			if($("#blackProcessGroup_div").is(':visible')){
				if(blackProcessGroup==""){
					$("#blackProcessGroup_alert").attr("data-content","进程黑名单组不能为空");
					$("#blackProcessGroup_alert").popover('show');
					return;
				}
			}else{
				$("#blackProcessGroup").val("");
			}
			if($("#portGroup_div").is(':visible')){
				if(portGroup==""){
					$("#portGroup_alert").attr("data-content","封堵端口组不能为空");
					$("#portGroup_alert").popover('show');
					
					return;
				}
			}
			if($("#ipGroup_div").is(':visible')){
				if(ipGroup==""){
					$("#ipGroup_alert").attr("data-content","违规后仍可联通IP地址不能为空");
					$("#ipGroup_alert").popover('show');
					return;
				}
			}else{
				$("#ipGroup").val("");
			}			
			if(savaState=="新增"){
				if(checkSubmitFlg==true){ 
					return false;
				}else{			
					$.ajax({
							type:"POST",
							url:"${ctx}/json/strategyAction!save.action",
							data:$("#detail_form").serialize(),
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
				$.ajax({
					type:"POST",
					url:"${ctx}/json/strategyAction!update.action?strategy.id="+rowIds[0],
					data:$("#detail_form").serialize(),
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
    		    	$.post('${ctx}/json/strategyAction!delete.action',{'ids':rowIds.toString()},function(data){
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
		 //弹出杀毒软件
		$("#antivirusAction").change(function() {
            var antivirusAction =$("#antivirusAction").val();
            if(antivirusAction!=0){
              $("#antivirus_div").show();
            }else if(antivirusAction==0){
	            $("#antivirus").find("option:selected").attr("selected",false);
	            $("#antivirus_div").hide();            
            }
		});
		
		//弹出白名单
		$("#whiteProcessGroupAction").change(function() {
            var whiteProcessGroup =$("#whiteProcessGroupAction").val();
            if(whiteProcessGroup!=0){
              $("#whiteProcessGroup_div").show();
            }else if(whiteProcessGroup==0){
	            $("#whiteProcessGroup").find("option:selected").attr("selected",false);
	            $("#whiteProcessGroup_div").hide();            
            }
		});
		
		//弹出黑名单
		$("#blackProcessGroupAction").change(function() {
            var blackProcessGroup =$("#blackProcessGroupAction").val();
            if(blackProcessGroup!=0){
               $("#blackProcessGroup_div").show();
            }else if(blackProcessGroup==0){
	           $("#blackProcessGroup").find("option:selected").attr("selected",false);
	           $("#blackProcessGroup_div").hide();            
            }
		});
		
	</script>
  </body>
</html>
