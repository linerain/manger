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
	            <th data-column-id="userCount">用户账号</th>
	            <th data-column-id="userName">用户姓名</th>
	            <th data-column-id="action">操作行为</th>
	            <th data-column-id="datetime" data-formatter="datetime">日志时间</th>
	            <th data-column-id="ip">ip</th>
	            <th data-column-id="type">操作类型</th>
	        </tr>
	    </thead>
	</table>
	<div class="modal fade bs-example-modal-lg" id="showInfoModalLg" tabindex="-1" role="dialog" aria-labelledby="showInfomyModalLabelLg" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog modal-lg" role="document">
	      <div class="modal-content">
		      <div class="modal-header" >
		      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
		     	<h4 class='modal-title' id='showInfomyModalLabelLg'>详细信息</h4>
		      </div>
		      <div class="modal-body" id='showInfo-bodyLg'>
		      	
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		      </div>
	     </div>
		</div>
	</div>
	<script type="text/javascript">
	 	var rowIds = [];
		$("#logList").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/systemLogAction!findPage.action",
	        selection: true,
	        multiSelect: true,
	        rowSelect: true,
	        rowCount:10,
	        formatters: {
	            "datetime": function(column, row)
	            {
	            	var dataTime=row.datetime;
	                return dataTime.substr(0, 10);
	            }
	        }
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
		//添加按钮
		var html="<div class='col-sm-6' id='button_div'>"+
					 "<a id='detailinforButton'  class='a-btn btn-info' >"+
			     	     "<span class='glyphicon glyphicon-list-alt' ></span>"+
			     	     "<span class='a-btn-slide-text'>详细信息</span>"+
			         "</a>"+
			         "<s:if test='%{#session.isAdmin}'>"+
					     "<a id='delButton'  class='a-btn btn-default active'>"+
					     	"<span class='glyphicon glyphicon-trash' ></span>"+
					     	"<span class='a-btn-slide-text'>删&nbsp;&nbsp;&nbsp;&nbsp;除</span>"+
					     "</a>"+
					 "</s:if>"+
				"</div>";
		$("#headerRow").before(html);
		
		
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
    		    	$.post('${ctx}/json/systemLogAction!deleteLog.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#logList").bootgrid("reload");
							 rowIds=[];
							 $.messager.show({title:'提示信息',msg:data.msg});
						 }else{
							 $.messager.show({title:'提示信息',msg:data.msg});
						 } 
					});
    		    }
    		    
    		});
		});
		
		//详细信息
		$("#detailinforButton").click(function(){
			if(rowIds.length>1){
				var txt=  "只能选择一个查看";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			if(rowIds.length==0){
				var txt=  "请选择要查看的";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return;
			}
			$.post('${ctx}/json/systemLogAction!findOne.action',{'id':rowIds[0]},function(data){
				// 基本信息：
				 var datasname=["用户名称", "用户账号","操作行为","时间","登陆IP","操作类型"];	
				 var namevalue=["userName","userCount","action","datetime","ip","type"];
			  	 var content="<div style='margin-left:5%'>"+
								"<h5>基本信息</h5>"+						
				 				"<ul style='margin-left:16%'>";				
				 for (var i=0;i<datasname.length;i++){
					var nthnamevalue=namevalue[i];
					content+="<li  class='col-sm-5' style='margin-bottom:10px'>"+
			   				  datasname[i]+"："+
			    			  "<span style='word-wrap:break-word;'>"; 	
					if(data.log[nthnamevalue]==null||data.log[nthnamevalue]==""){
			    		content+="无";
			    	}else if(i==3){
			    		content+=data.log[nthnamevalue].replace("T"," ");
			    	}else{
				    	content+=data.log[nthnamevalue];	
				    }
			        content+="</span>"+ "</li>"; 	
				}
				content+="</ul>"+
						"</div>"+
						"<div style='clear:both'></div>"+
						"<div style='margin-left:5%'>"+
							"<h5>操作详情</h5>"+
							"<ul style='margin-left:16%'>";				
					var nthnamevalue=data.log.details;
					content+="<li  class='col-sm-10' style='margin-bottom:10px'>"+
							"<span>"; 	
					if(nthnamevalue==null||nthnamevalue==""){
    					content+="无";
    				}else{
    					content+=nthnamevalue;	
    				}
         			content+="</span>"+ "</li>"; 	
				content+="</ul></div>";
				content+="<div style='clear:both'></div>";	
				$('#showInfo-bodyLg').html(content);
				$('#showInfoModalLg').modal('show'); 
			});
		});
	</script>
  </body>
</html>
