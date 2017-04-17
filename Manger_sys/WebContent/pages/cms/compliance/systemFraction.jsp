<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />	
<!DOCTYPE HTML>
<html>
  <script src="${ctx }/js/justGage/raphael.2.1.0.min.js"></script>
  <script src="${ctx }/js/justGage/justgage.1.0.1.min.js"></script>
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
	  		<div class="col-sm-6 col-md-4 ">
				<div id="g1"  style="height:15%;"></div>
			</div>
			<div class="col-sm-6 col-md-4">
				<div id="g2"  style="height:15%;"></div>
			</div>
			<div class="col-sm-6 col-md-4">
				<div id="g5" style="height:18%"></div>
				<%-- <div style="height:30%;">
					<span id="showInfo" style="font-size:50px;" class="showInfo"></span>
				</div> --%>
			</div>
			<div class="col-sm-6 col-md-4 col-md-push-8">
				<div style="height:18%;text-align:center;vertical-align:middle;margin:auto;font-size:50px;">
					<span id="showInfo"  class="showInfo"></span>
				</div> 
			</div>
			<div class="col-sm-6 col-md-4 col-md-pull-4">
				<div id="g3"  style="height: 15%;"></div>
			</div>
			<div class="col-sm-6 col-md-4 col-md-pull-4">
				<div id="g4"  style="height: 15%;"></div>
			</div>
			
		</div>	
    </div>
	<script type="text/javascript">
	var v1 = 0;
	var v2 = 0;
	var v3 = 0;
	var v4 = 0;
	var v5 = 0;
	$(function() {
			$.post('${ctx}/json/chartAction!getFraction.action', function(data) {
				if (data.success == true) {
					v1 = data.v1;
					v2 = data.v2;
					v3 = data.v3;
					v4 = data.v4;
					v5 = data.v5;
					
					
				var g1 = new JustGage({
					id : "g1",
					value : v1,
					min : 0,
					max : 100,
					title : "CMS客户端在线率",
					gaugeWidthScale: 0.5 ,
					levelColors: [
		         		 "#ff0000",
		        		 "#ffff00",
		        		 "#00ff00"
		       					 ]          
					
				});
		
				var g2 = new JustGage({
					id : "g2",
					value : v2,
					min : 0,
					max : 100,
					title : "弱口令合格率",
					gaugeWidthScale: 0.5 ,
					levelColors: [
		         		 "#ff0000",
		        		 "#ffff00",
		        		 "#00ff00"
		       					 ]          
				});
		
				var g3 = new JustGage({
					id : "g3",
					value : v3,
					min : 0,
					max : 100,
					title : "杀毒软件合格率",
					gaugeWidthScale: 0.5 ,
					levelColors: [
		         		 "#ff0000",
		        		 "#ffff00",
		        		 "#00ff00"
		       					 ]          
				});
		
				var g4 = new JustGage({
					id : "g4",
					value : v4,
					min : 0,
					max : 100,
					title : "违规外联合格率",
					gaugeWidthScale: 0.5 ,
					levelColors: [
		         		 "#ff0000",
		        		 "#ffff00",
		        		 "#00ff00"
		       					 ]          
				});
		
				var g5 = new JustGage({
					id : "g5",
					value : v5,
					min : 0,
					max : 100,
					title : "总体合规指数",
					levelColors: [
		         		 "#ff0000",
		        		 "#ffff00",
		        		 "#00ff00"
		       					 ]          
				});
				
				if(v5>=90){
					$("#showInfo").html("健&nbsp;&nbsp;&nbsp康");
					$("#showInfo").css("color","#58FB71");
				}else if(v5>=80 && v5<90){
					$("#showInfo").html("亚健康");
					$("#showInfo").css("color","#00F886");
				}else if(v5>=60 && v5<80){
					$("#showInfo").html("危&nbsp;&nbsp;&nbsp险");
					$("#showInfo").css("color","#FB5858");
				}else if(v5<60){
					$("#showInfo").html("高&nbsp;&nbsp;&nbsp危");
					$("#showInfo").css("color","#FB0909");
				}	
			} 
		});	
	});
	</script>
  </body>
</html>
