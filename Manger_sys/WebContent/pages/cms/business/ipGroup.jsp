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
				 <a id='updateButton'  class='a-btn btn-info' >
			     	<span class='glyphicon glyphicon-pencil' ></span>
			     	<span class='a-btn-slide-text'>修&nbsp;&nbsp;&nbsp;&nbsp;改</span>
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
				            <th data-column-id="items">IP</th>
				            <th data-column-id="remark">备注</th>
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
		       			<h4 class='modal-title' id='myModalLabel'>添加/修改IP组</h4>
				      </div>
				      <div class="modal-body">
				      	<form id='ipGroupform' class='form-horizontal' role='form'>
						    <div class='row'>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>名称*:</label>
							    <div class='col-sm-5' id='name_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text' name='ipGroupPageModel.name'   class='form-control' id='name'/>
								</div>
							  </div>
							  <div class='form-group'>
							    <label  class='col-sm-3 control-label'>备注:</label>
							    <div class='col-sm-5' id='remark_alert'  data-toggle='popover' data-trigger='manual'>
									<input type='text'  name='ipGroupPageModel.remark'   class='form-control' id='remark'/>
							    </div>
							  </div>
							  <div class='form-group' id='addinput'>
							    <div class='col-sm-offset-3 col-sm-5' >
							    	<button type="button" class='col-sm-12 btn btn-info' id="addport">添加IP组</button>   
							  	</div>
							  </div>
							  <div id="portgroup"> 
								  	<!-- <div class='form-group'> 
								  		<div class='col-sm-offset-3 col-sm-11'  id='aa_alert'  data-toggle='popover' data-trigger='manual'>
										 <div class='col-sm-4'  >
											<input type='text'  name='processGroupPageModel.remark'   class='form-control' />
								    	</div>
										 <p class='col-sm-1' style="padding:5px;">——</i> 
										<div class='col-sm-4' >
											<input type='text'  name='processGroupPageModel.remark'   class='form-control'/>
								   		</div>
								   		<button type='button' class=' btn btn-danger col-sm-2'>删除</button> 		   								   		
								    </div> 
							    </div> -->
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
		$("#ipGroupList").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/ipGroupAction!findByPage.action",
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
			$("#portgroup").empty();
			$("#name_alert").popover('hide');
			$("#remark_alert").popover('hide');
			$("#remark").val("");
			$("#name").val("");
			$('#infoModal').modal('show');
			checkSubmitFlg=false;
		});
		//修改
		var oldname="";
		$("#updateButton").click(function(){
			if(rowIds.length==1){
				savaState="修改";
				$("#remark_alert").popover('hide');
				$("#name_alert").popover('hide');
				$("#portgroup").empty();
				index=1;
				$.post('${ctx}/json/ipGroupAction!findById.action',{'id':rowIds[0]}, function(data) {
					$("#name").val(data.ipGroupPageModel.name);
					oldname=data.ipGroupPageModel.name;
					$("#remark").val(data.ipGroupPageModel.remark);
					var items=data.ipGroupPageModel.items;
					console.log(items);
					if(null!=items && ""!=items){
						var item=items.split(",");
						for(var i=0;i<item.length;i++){
							var inputs=item[i].split("-");
							console.log(inputs);
							var html="<div class='form-group' id='itemdiv_"+(i+1)+"'>"+
										"<div class='col-sm-offset-2 col-sm-8' id='item"+(i+1)+"_alert'  data-toggle='popover' data-trigger='manual'>"+
											"<div class='col-sm-4'>"+
												"<input type='text' name='item' value='"+inputs[0]+"' placeholder='格式如下:1.1.1.1' id='groupInput_"+(i+1)+"_begin' class='form-control col-sm-3' onfocus='hiddenalert("+(i+1)+")'/>"+
										 	"</div>"+
										 	"<p class='col-sm-1' style='padding:5px;'>——</p>"+
										 	"<div class='col-sm-4'>"+
												"<input type='text' name='item' value='"+inputs[1]+"' placeholder='最后数字大于前一空' id='groupInput_"+(i+1)+"' class='form-control col-sm-3' onfocus='hiddenalert("+(i+1)+")'/>"+
											"</div>"+
											"<button type='button' class=' btn btn-danger col-sm-2' id='del"+(i+1)+"' onclick='delGroup("+(i+1)+")'>删除</button>"+
										"</div>"+			
									 "</div>";
						 $("#portgroup").append(html);
						}
						index=item.length+1;
					}
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
			if(remark.length>30){
				$("#remark_alert").attr("data-content","备注长度不能超过30");
				$("#remark_alert").popover('show');
				return;
			}
			var items="";
			var inputs=$("input[name='item']");
			for(var i=0;i<inputs.length;i+=2){
				if(i==0){
					items+=inputs[i].value+"-"+inputs[i+1].value;
				}else{
					items+=","+inputs[i].value+"-"+inputs[i+1].value;
				}
			};
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
		        if ((temp1[3]>temp2[3]) ||  (temp1[0]!=temp2[0]
                	|| temp1[1]!=temp2[1] || temp1[2]!=temp2[2])){ 
		        	$("#item"+(j/2+1)+"_alert").attr("data-content","ip格式不正确");
					$("#item"+(j/2+1)+"_alert").popover('show');
					return;   
                };
		        
			}
			/* for(var i=1;i<=index-1;i++){
				var item=$("#item"+i).val();
				if(item==""){
					$("#item"+i+"_alert").attr("data-content","名单不能为空");
					$("#item"+i+"_alert").popover('show');
					return;
				}
				items+=item+",";
			} */
			$.post('${ctx}/json/ipGroupAction!checkNameExist.action',{'name':name},function(datas){
				if(savaState=="新增"){
					if(checkSubmitFlg==true){ 
						return false;
					}else{	
						if(datas.success==true){
							$.messager.show({title:'提示信息',msg:datas.msg});
							return;
						}else{
							$.ajax({
									type:"POST",
									url:"${ctx}/json/ipGroupAction!save.action?ipGroupPageModel.items="+items,
									data:$("#ipGroupform").serialize(),
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
					}else{
						if(datas.success==true&&oldname!=name){
							$.messager.show({title:'提示信息',msg:datas.msg});
							return;
						}else{
							$.ajax({
								type:"POST",
								url:"${ctx}/json/ipGroupAction!update.action?ipGroupPageModel.id="+rowIds[0]+"&&ipGroupPageModel.items="+items,
								data:$("#ipGroupform").serialize(),
								success:function(data){
									if(data.success==true){
										$('#infoModal').modal('hide');
										$("#ipGroupList").bootgrid("reload");
										//rowIds=[];
										$.messager.show({title:'提示信息',msg:data.msg});
									}else{
										$('#infoModal').modal('hide');
										$.messager.show({title:'提示信息',msg:data.msg});
									}
								}
							});
						}
				  }
			})
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
    		    	$.post('${ctx}/json/ipGroupAction!delete.action',{'ids':rowIds.toString()},function(data){
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
