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
 	<table id="logList" class="table table-condensed table-hover table-striped" ajax="true">
	    <thead>
	        <tr>
		        	<th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">编号</th>
					<th data-column-id="name">申请人</th>
					<th data-column-id="idCard">身份证</th>
					<th data-column-id="phone">电话</th>
					<th data-column-id="money">提现资金（元）</th>
					<th data-column-id="cardNum">银行卡号</th>
					<th data-column-id="cardAddr">开户地</th>
					<th data-column-id="logTime">时间</th>
					<th data-column-id="state">状态</th>
	        </tr>
	    </thead>
	</table>
	<div class="modal fade bs-example-modal-sm" id="stateModal" tabindex="-1" role="dialog" aria-labelledby="showInfomyModalLabelLg" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog modal-sm" role="document">
	      <div class="modal-content">
		      <div class="modal-header" >
		      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
		     	<h4 class='modal-title' id='showInfomyModalLabelLg'>提现开关</h4>
		      </div>
		      <div class="modal-body" id='showInfo-bodyLg'>
		      	<h3 id = "money_state_info"></h3>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-success" onclick="changeState(1)" >开启</button>
		        <button type="button" class="btn btn-danger"  onclick="changeState(0)">关闭</button>
		        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		      </div>
	     </div>
		</div>
	</div>
	<script type="text/javascript">
	
		var rowIds = [];
		state = 0 ;
		$("#logList")
				.bootgrid(
						{
							ajax : true,
							post : function() {
								return{
								state:state
								}
							},
							url : "${ctx}/json/moneyAction!findByPage.action",
							selection : true,
							multiSelect : true,
							rowSelect : true,
							rowCount : 10,
							
							formatters : {
								"logTime" : function(column, row) {
									var dataTime = row.datetime;
									return dataTime.substr(0, 10);
								}
							}
						}).on("selected.rs.jquery.bootgrid", function(e, rows) {
					for (var i = 0; i < rows.length; i++) {
						rowIds.push(rows[i].id);
					}
				}).on("deselected.rs.jquery.bootgrid", function(e, rows) {
					var newIds = [];
					for (var i = 0; i < rows.length; i++) {
						for (var j = 0; j < rowIds.length; j++) {
							if (rows[i].id == rowIds[j]) {
								continue;
							}
							newIds.push(rowIds[j]);
						}
					}
					rowIds = newIds;
				}).on("loaded.rs.jquery.bootgrid", function(e, rows) {
					rowIds = [];
				});
		//添加按钮
		var html = "<div class='col-sm-6' id='button_div'>"
				+ "<a id='ask_0'  class='a-btn btn-primary' >"
				+ "<span class='glyphicon glyphicon-hourglass' ></span>"
				+ "<span class='a-btn-slide-text'>未审核申请</span>"
				+ "</a>"
				+ "<a id='ask_1'  class='a-btn btn-info' >"
				+ "<span class='glyphicon glyphicon-saved' ></span>"
				+ "<span class='a-btn-slide-text'>已审核申请</span>"
				+ "</a>"
				+ "<a id='ask_2'  class='a-btn btn-warning' >"
				+ "<span class='glyphicon glyphicon-minus-sign' ></span>"
				+ "<span class='a-btn-slide-text'>已拒绝申请</span>"
				+ "</a>"
				+ "<a id='ask_01'  class='a-btn btn-info' >"
				+ "<span class='glyphicon glyphicon-list' ></span>"
				+ "<span class='a-btn-slide-text'>全部申请</span>"
				+ "</a>" 
				+ "<a id='pass_but'  class='a-btn btn-success' >"
				+ "<span class='glyphicon glyphicon-ok-sign' ></span>"
				+ "<span class='a-btn-slide-text'>通过</span>"
				+ "</a>" 
				+ "<a id='stop_but'  class='a-btn btn-danger' >"
				+ "<span class='glyphicon glyphicon-remove-sign' ></span>"
				+ "<span class='a-btn-slide-text'>拒绝</span>"
				+ "</a>" 
				+ "<a id='get_excel'  class='a-btn btn-info' >"
				+ "<span class='glyphicon glyphicon-download-alt' ></span>"
				+ "<span class='a-btn-slide-text'>导出EXCEL</span>"
				+ "</a>" 
				+ "<a id='money_state_but'  class='a-btn btn-warning' >"
				+ "<span class='glyphicon glyphicon-off' ></span>"
				+ "<span class='a-btn-slide-text'>提现开关</span>"
				+ "</a>" 
				+ "</div>";
		$("#headerRow").before(html);

		//通过
		$("#pass_but").click(function() {
			if (rowIds.length == 0) {
				var txt = "请选择需要通过的申请";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			$.confirm({
				title : '提示信息!',
				content : '你确定要通过这些申请吗？',
				confirm : function() {
					$.post('${ctx}/json/moneyAction!pass.action', {
						'ids' : rowIds.toString()
					}, function(data) {
						if (data.success == true) {
							$("#logList").bootgrid("reload");
							rowIds = [];
							$.messager.show({
								title : '提示信息',
								msg : data.msg
							});
						} else {
							$.messager.show({
								title : '提示信息',
								msg : data.msg
							});
						}
					});
				}

			});
		});
		
		//拒绝
		$("#stop_but").click(function() {
			if (rowIds.length == 0) {
				var txt = "请选择需要拒绝的申请";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			$.confirm({
				title : '提示信息!',
				content : '你确定要拒绝这些申请吗？',
				confirm : function() {
					$.post('${ctx}/json/moneyAction!stop.action', {
						'ids' : rowIds.toString()
					}, function(data) {
						if (data.success == true) {
							$("#logList").bootgrid("reload");
							rowIds = [];
							$.messager.show({
								title : '提示信息',
								msg : data.msg
							});
						} else {
							$.messager.show({
								title : '提示信息',
								msg : data.msg
							});
						}
					});
				}

			});
		});
		
		$("#ask_0").click(function() {
			state = 0;
			$("#logList").bootgrid("reload");
		});
		$("#ask_1").click(function() {
			state = 1;
			$("#logList").bootgrid("reload");
		});
		$("#ask_2").click(function() {
			state = 2;
			$("#logList").bootgrid("reload");
		});
		$("#ask_01").click(function() {
			state = -1;
			$("#logList").bootgrid("reload");
		});
		//Excel导出
		$("#get_excel").click(function() {
			$.confirm({
    		    title: '提示信息!',
    		    content: '是否Excel导出？',
    		    confirm: function(){   		    	
    		    	 window.location.href = "${ctx}/json/moneyAction!downExcel.action?state="+state; 
    		    }
			});
		});
		//开启关闭提现
		$("#money_state_but").click(function() {
			$('#stateModal').modal('show');
			$.post('${ctx}/json/userAction!checkState.action', {
			}, function(data) {
				if (data.success == true) {
					$("#money_state_info").html("提现功能开启")
				} else {
					$("#money_state_info").html("提现功能关闭")
				}
			});
		});
		
		function changeState(state){
			ac:state
			$.post('${ctx}/json/userAction!changeState.action', {
				ac:state
			}, function(data) {
				if (data.success == true) {
					$.messager.show({
						title : '提示信息',
						msg : data.msg
					});
				} else {
					$.messager.show({
						title : '提示信息',
						msg : data.msg
					});
				}
			$('#stateModal').modal('hide');
			});
		}

	</script>
  </body>
</html>
