<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />	
<%@ include file="/pages/common/headjsp.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>系统注册</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style type="text/css">
		#system_register_div{padding:1px;background:#fafafa;height: 99%;}
		.submit{display: inline-block;background: #3BC1C4;border: 0;border-radius: 4px;color: #fff;
  				width: 100px;height: 30px;line-height: 30px;text-align: center;margin-top: 10px;text-decoration:none;}
		#file{width: 210px}		
	</style>
</head>
<body>
	<div id="system_register_div">  
		<form id="sys_rester_form" method="post" action="">
			<br><br>
			<br><br>
			<div align="center">
				<table>
					<tr>
						<td><label>License：</label></td>
						<td>
							<input type="file" name="file" id="file"/>
						</td>	
						<td>
							<div id="alert" data-toggle="popover" data-trigger="focus"  data-content="请选择要上传的文件"></div>
						</td>
					</tr>
					<tr>
						<td colspan="3" align="center"><a href="javascript:void(0);"  id="submit" class="submit">注&nbsp;&nbsp;册</a></td>	
					</tr>
				</table>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		var totalHeight = $(document).height();
		$("#system_register_div").css("height",(totalHeight-6));
		
		$("#file").click(function(){
			$("#alert").popover('hide');
		});
		$("#submit").click(function(){
			var file=$("#file").val();
		    if(file==""){
		    	$("#alert").attr("data-content","请选择要上传的文件");
		    	$("#alert").popover('show');
		    	return false;
		    }else{
		    	var type=file.substr(file.length-7);
		    	if(type!="license"){
		    		$("#alert").attr("data-content","请上传以.license结尾的文件");
		    		$("#alert").popover('show');
		    		return false;
		    	}
		    }
			$("#sys_rester_form").ajaxSubmit({
				type:"POST",
				url:"${ctx}/json/licenseAction!saveLicense.action",
				success:function(data){
					if(data.success==true){
						window.location.href="${ctx}/login.jsp";
					}else{
						$.messager.show({title:'提示信息',msg:data.msg});
					}
				}
			});
	});
</script>
</body>
</html>