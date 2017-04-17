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
	#historyform input,#historyform select{width:165.8px;}
	.bootgrid-table th>.column-header-anchor>.text {display: block;margin: 0 16px 0 0;
    overflow: hidden;-ms-text-overflow: ellipsis;-o-text-overflow: ellipsis;
    text-overflow: ellipsis; white-space: nowrap; font-size: 14px;}
  </style>
  <body>
  	<div class="container-fluid">
	  	<div class="row">
	  		<div class='col-sm-12' id='button_div'>
				 <a id='delButton'  class='a-btn btn-default active'>
			     	<span class='glyphicon glyphicon-trash' ></span>
			     	<span class='a-btn-slide-text'>删&nbsp;&nbsp;&nbsp;&nbsp;除</span>
			     </a> 
			</div>
			<div class='col-sm-12' style="margin-top:20px;">
				<form id='historyform' class='form-inline' role='form'>
					<div class='form-group' style="margin-bottom:10px;">
						<!-- <label>用户名:</label> -->
						<div style="display: inline-block;">
						  	<input  type='text' placeholder="用户名"  name='userName'  class='form-control' id="userName"  />
					  	</div>
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						 <!-- <label>&nbsp;设备名:</label> -->
						 <div style="display: inline-block;">
						   	<input type='text' placeholder="设备名"   name='device'  class='form-control' id="device" />
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						 <!-- <label>&nbsp;级别:</label> -->
						 <div style="display: inline-block;">
						 	<select name="level" id="level"  class='form-control'>
								<option value="" selected="selected" id="level_no">请选择级别</option>
								<option value="1">一级</option>
								<option value="2">二级</option>
								<option value="3">三级</option>
								<option value="4">四级</option>
							</select>
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						 <!-- <label>&nbsp;IP:</label> -->
						 <div style="display: inline-block;">
						   	<input type='text'  name='ip' placeholder="IP地址"  class='form-control' id="ip" />
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						 <!-- <label>&nbsp;起始时间:</label> -->
						 <div style="display: inline-block;">
						   	<input type='text'  name='datetime' placeholder="起始时间"  class='form-control' id="datetime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:$('#recovertime').val()})" />
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						<!--  <label>&nbsp;结束时间</label> -->
						 <div style="display: inline-block;">
						   	<input type='text'  name='recovertime' placeholder="结束时间"  class='form-control' id="recovertime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:$('#datetime').val(),maxDate:'%y-%M'})"/>
						</div>	
					</div>
					<div class='form-group' style="margin-bottom:10px;">
						<!--  <label>&nbsp;类型:</label> -->
						 <div style="display: inline-block;">
						   	<select name="type" id="type" class='form-control' >
								<option value="" selected="selected" id="type_no">请选择类型</option>
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
			 	<table id="historyList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">id</th>
				            <th data-column-id="userName">用户姓名</th>
				            <th data-column-id="level">级别</th>
				            <th data-column-id="device">设备名称</th>
				            <th data-column-id="ip">IP</th>
				            <th data-column-id="datetime">操作时间</th>
				            <th data-column-id="type">类型</th>
				            <th data-column-id="phoneNumber">联系电话</th>      
				        </tr>
				     </thead>
				</table>
			</div>
		</div>
    </div>
	<script type="text/javascript">
	 	var rowIds = [];
	 	showList();
	 	function showList(){
	 		$("#historyList").bootgrid("destroy");
			$("#historyList").bootgrid({
		    	ajax: true,
		        post: function (){
		        	return {
		        		name:$("#name").val(),
		        		deviceName:$("#device").val(),
		        		level:$("#level").val(),
		        		startTime:$("#datetime").val(),
		        		endTime:$("#recovertime").val(),
		        		type:$("#type").val(),
		        		ip:$("#ip").val()
		        	}
		        },
		        url: "${ctx}/json/clientLogInfoAction!findbyPage.action",
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
	 	//类型
	 	$.post('${ctx}/json/clientTypeAction!findType.action',function(data){
			var clientTypes=data.clientTypes;
			for(var i=0;i<clientTypes.length;i++){
				$("#type").append("<option value='"+clientTypes[i].id+"'>"+clientTypes[i].type+"</option>");
			}
		});
		//查询
		$("#screendata").click(function(){
	  		var ip=$("#ip").val(); 
			if(ip!=""&&!/((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))/.test(ip)){
	  			var txt=  "ip地址格式不正确";
	            window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
	            return;
	  		} 
			showList();
		});
		//重置
		$("#resetdata").click(function(){
	  		$("#device").val("");
	  		$("#userName").val("");
	  		$("#ip").val("");
	  		$("#datetime").val("");
	  		$("#recovertime").val("");
	  		$("#type").val("");
	  		$("#level_no").attr("selected","selected");
	  		showList();
  		});
			
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
    		    	$.post('${ctx}/json/clientLogInfoAction!delete.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#historyList").bootgrid("reload");
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
