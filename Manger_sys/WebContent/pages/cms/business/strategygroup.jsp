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
	  		<div class='col-sm-12' id='button_div'>
			     <a id='saveButton'  class='a-btn btn-success'>
			 		 <span class='glyphicon glyphicon-plus'></span>
			 		 <span class='a-btn-slide-text'>添&nbsp;&nbsp;&nbsp;&nbsp;加</span>
			 	 </a>			
			     <a id='detailButton'  class='a-btn btn-info'>
			     	<span class='glyphicon glyphicon-info-sign' ></span>
			     	<span class='a-btn-slide-text'>详细信息</span>
			     </a> 
				 <a id='delButton'  class='a-btn btn-default active'>
			     	<span class='glyphicon glyphicon-trash' ></span>
			     	<span class='a-btn-slide-text'>删&nbsp;&nbsp;&nbsp;&nbsp;除</span>
			     </a> 
			</div>
  			<div class="col-sm-12" style="margin-top:20px;">
			 	<table id="ipGroupList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				            <th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">id</th>
				            <th data-column-id="name">名称</th>
				            <th data-column-id="ipSection">ip组</th>
				        </tr>
				     </thead>
				</table>
			</div>
		</div>
		<!-- 添加和修改模态框 -->
		<div class="modal fade bs-example-modal-lg" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog  modal-lg" role="document">
				<div class="modal-content">
				      <div class="modal-header" >
				      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
		       			<h4 class='modal-title' id='myModalLabel'>添加/修改策略IP组</h4>
				      </div>
				      <div class="modal-body">
				      	<form id='ipGroupform' class='form-horizontal' role='form'>
						    <div class='row'>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>名称*:</label>
							    <div class='col-sm-5' id='name_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='GroupPageModel.name'   class='form-control' id='name'/>
								</div>
							  </div>
							  <div class='form-group' id='addinput'>
							    <div class='col-sm-offset-3 col-sm-5' >
							    	<button type="button" class='col-sm-12 btn btn-info' id="addport">添加IP组</button>   
							  	</div>
							  </div>
							  <div id="portgroup"> 
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
		<!-- 详细信息 -->
		<div class="modal fade bs-example-modal-lg" id="detailinforModalLg" tabindex="-1" role="dialog" aria-labelledby="showInfomyModalLabelLg" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog modal-lg" role="document">
		      <div class="modal-content">
			      <div class="modal-header" >
			      	<button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>
			     	<h4 class='modal-title' id='showInfomyModalLabelLg'>详细信息</h4>
			      </div>
			      <div class="modal-body" id='detailinfor-bodyLg'>
			      	
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			      </div>
		     	</div>
			</div>
		</div>	
    </div>
	<script type="text/javascript">
		var savaState="新增";
	 	var rowIds = [];
		$("#ipGroupList").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/groupAction!findByPage.action",
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
		var index=1;//端口组的次序
		$("#addport").click(function(){
			var html="<div class='form-group' id='itemdiv_"+index+"'>"+
						"<div class='col-sm-offset-2 col-sm-8' id='item"+index+"_alert'  data-toggle='popover' data-trigger='manual'>"+
							"<div class='col-sm-4'>"+
								"<input type='text' name='item' placeholder='格式如下:1.1.1.1' id='groupInput_"+index+"_begin' class='form-control col-sm-3' onfocus='hiddenalert("+index+")'/>"+
						 	"</div>"+
						 	"<i class='col-sm-1' >—</i>"+
						 	"<div class='col-sm-4'>"+
								"<input type='text' name='item'  placeholder='大于起始IP如：1.1.1.2' id='groupInput_"+index+"' class='form-control col-sm-3' onfocus='hiddenalert("+index+")'/>"+
							"</div>"+
							"<button type='button' class=' btn btn-danger col-sm-2' id='del"+index+"' onclick='delGroup("+index+")'>删除</button>"+
						"</div>"+			
					 "</div>";
			$("#portgroup").append(html);
			index++;
		});
		//删除端口组的文本框
		function delGroup(num){
			$("#itemdiv_"+num).remove();
			index--;
		}
		//点击input框让提示消失
		function hiddenalert(num){
			$("#item"+num+"_alert").popover('hide');
			
		}
		///提示框隐藏
		$("#name").focus(function(){
			$("#name_alert").popover('hide');
		});
		$("#remark").focus(function(){
			$("#remark_alert").popover('hide');
		});
		//新增
		var checkSubmitFlg=false;
		$("#saveButton").click(function(){
			savaState="新增";
			index=1;
			$("#name_alert").popover('hide');
			$("#remark_alert").popover('hide');
			$("#portgroup").empty();
			$("#remark").val("");
			$("#name").val("");
			$('#infoModal').modal('show');
			checkSubmitFlg=false;
		});
		
		//保存
		function save(){
			var remark=$("#remark").val();
			var name=$("#name").val();
			if(name==""){
				$("#name_alert").attr("data-content","名称不能为空");
				$("#name_alert").popover('show');
				return;
			}
			if(name.length>30){
				$("#name_alert").attr("data-content","名称长度不能超过30");
				$("#name_alert").popover('show');
				return;
			}
			/* if(remark.length>30){
				$("#remark_alert").attr("data-content","备注长度不能超过30");
				$("#remark_alert").popover('show');
				return;
			} */
			var items="";
			var inputs=$("input[name='item']");
			var startip="";
			var endip="";
			/* for(var i=0;i<inputs.length;i+=2){
				if(i==0){
					items+=inputs[i].value+"-"+inputs[i+1].value;
				}else{
					items+=","+inputs[i].value+"-"+inputs[i+1].value;
				}
			} */
			for(var i=0;i<inputs.length;i+=2){
				if(i==0){
					startip+=inputs[i].value;
					endip+=inputs[i+1].value;
				}else{
					startip+=","+inputs[i].value;
					endip+=","+inputs[i+1].value;
				}
			}
			for(var j=0;j<inputs.length;j+=2){
				var temp1=inputs[j].value.split(".");
		        var temp2=inputs[j+1].value.split(".");
		        console.log(j);
		        if(inputs[j].value==""||inputs[j+1].value==""){
		        	$("#item"+(j/2+1)+"_alert").attr("data-content","ip不能为空");
					$("#item"+(j/2+1)+"_alert").popover('show');
					return; 
		        };
		        if(!/((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))/.test(inputs[j].value)){
		        	$("#item"+(j/2+1)+"_alert").attr("data-content","ip格式不正确");
					$("#item"+(j/2+1)+"_alert").popover('show');
					return; 
		  		} 
		        if ((parseInt(temp1[3])>parseInt(temp2[3])) || (temp1[0]!=temp2[0]
                	|| temp1[1]!=temp2[1] || temp1[2]!=temp2[2])){ 
		        	$("#item"+(j/2+1)+"_alert").attr("data-content","ip格式不正确");
					$("#item"+(j/2+1)+"_alert").popover('show');
					return;   
                };    
			}
			$.post('${ctx}/json/groupAction!nameIsExist.action',{'name':name},function(datas){
				if(savaState=="新增"){
					if(checkSubmitFlg==true){ 
						return false;
					}else{	
						if(datas.msg==true){
							$.messager.show({title:'提示信息',msg:"名称重复"});
							return;
						}else{
							$.ajax({
									type:"POST",
									//url:"${ctx}/json/groupAction!saveIpSection.action?ipGroupPageModel.items="+items,
									url:"${ctx}/json/groupAction!save.action",
									data:{"startIp":startip,"endIp":endip,"groupName":name},
									success:function(data){
										if(data.success==true){
											$('#infoModal').modal('hide');
											$("#ipGroupList").bootgrid("reload");
											$.messager.show({title:'提示信息',msg:data.msg});
										}else{
											$('#infoModal').modal('hide');
											$.messager.show({title:'提示信息',msg:data.msg});
										}
										checkSubmitFlg=true;	
									}
								});
							}
						}				 
					}
			})
		};	
		//详细信息
		$("#detailButton").click(function(){
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
			$.post('${ctx}/json/groupAction!showDetail.action',{'groupId':rowIds[0]},function(data){
				// 基本信息：
				 var datasname=["名称","生成时间"];	
				 var namevalue=["name","startTime"];
			  	 var content="<div style='margin-left:5%'>"+
							"<h5>基本信息</h5>";						
				 content+="<ul style='margin-left:16%'>";				
				 for (var i=0;i<datasname.length;i++){
					var nthnamevalue=namevalue[i];
					content+="<li  class='col-sm-5' style='margin-bottom:10px'>"+
			   				  datasname[i]+"："+
			    			  "<span>"; 	
					if(data.groupDetailPageModel[nthnamevalue]==null||data.groupDetailPageModel[nthnamevalue]==""){
			    		content+="无";
			    	}else if(i==1){
			    		content+=data.groupDetailPageModel[nthnamevalue].replace("T"," ");
			    		}else{
				    		content+=data.groupDetailPageModel[nthnamevalue];	
				    	}
			         content+="</span>"+ "</li>"; 	
					}
				 content+="</ul>"+
						  "</div>"+
						  "<div style='clear:both'></div>"+
						  "<div style='margin-left:5%'>"+
							"<h5>ip段信息</h5>"+
							"<ul style='margin-left:16%'>";				
				var nthnamevalue=data.groupDetailPageModel.ipSection;
				content+="<li  class='col-sm-10' style='margin-bottom:10px'>"+
						"<span>"; 	
				if(nthnamevalue.length==0){
					content+="未分配ip组";
				}else{
					content+="<table class='table table-bordered' style='font-size:13px;'>";
					content+="<tr>"+
								"<th>起始ip</th>"+
								"<th>终止ip</th>"+
				 			 "</tr>";
					for(var i=0;i<nthnamevalue.length;i++){
						content+="<tr>"+
									"<td>"+nthnamevalue[i].startip+"</td>"+
									"<td>"+nthnamevalue[i].endip+"</td>"+
								 "</tr>";
					}
					content+="</table>";	
				}
				content+="</span>"+ "</li>"; 	
				content+="</ul></div>";
				content+="<div style='clear:both'></div>";
				$('#detailinfor-bodyLg').html(content);
				$('#detailinforModalLg').modal('show'); 
			});
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
    		    	$.post('${ctx}/json/groupAction!deleteGroup.action',{'ids':rowIds.toString()},function(data){
						 if(data.success==true){
							 $("#ipGroupList").bootgrid("reload");
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
