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
  		<div style="float:right">
  			<form id='return_form' class='form-inline' role='form'>
 			 	<div class='form-group'>
					  <label>开始时间:</label>
				  	  <input  type='text'  name='assetLifecycle.fixedDateReturn'  class='form-control' id="beginDateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:$('#endDateTime').val()})" />
			  	</div>
			  	<div class='form-group'>
					<label>结束时间:</label>
				  	<input type='text'  name='assetLifecycle.fixedDateReturn'  class='form-control' id="endDateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:$('#beginDateTime').val(),maxDate:'%y-%M-%d'})" />
				</div>	
				<button type="button" class="btn btn-info"  id="selectdate">查看</button>			
			</form>
		</div>
		<div style="clear:both"></div>	
		<hr>
	  	<div class="row">
  			<div class="col-sm-12">
			 	<table id="realtimeList" class="table table-condensed table-hover table-striped" ajax="true">
				    <thead>
				        <tr>
				        	<th data-column-id="id"  data-identifier="true" data-visible="false" data-visible-in-selection="false">编码</th>
				            <th data-column-id="depName">部门名称</th> 
				            <th data-column-id="link">违规外联</th> 
				            <th data-column-id="anti">杀毒软件未安装</th> 
				            <th data-column-id="vrv">未安装vrv</th> 
				            <th data-column-id="weakPassword">存在弱口令</th> 
				            <th data-column-id="whiteList">白名单程序未运行</th>
				            <th data-column-id="blackList">黑名单程序未阻止</th>
				        </tr>
				     </thead>
				</table>
			</div>
			<div class="col-sm-12">
				<div style="width:50%;height:500px;" class="col-md-5" id="linechart"></div>
				<div style="width:50%;height:500px;" class="col-md-5" id="piechart"></div>
			</div>
		</div>
    </div>
	<script type="text/javascript">
	 	var rowIds = [];
		$("#realtimeList").bootgrid({
	    	ajax: true,
	        post: function (){},
	        url: "${ctx}/json/chartAction!stortDepartmentList.action",
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
		//查看
		showLine();
	 	showPie();
		var beginDateTime="",endDateTime="";
	 	$("#selectdate").on('click',function(){
	 		beginDateTime=$('#beginDateTime').val();
	 		endDateTime=$('#endDateTime').val();
	 		showLine();
	 		showPie();
	 	}); 
		//柱形图调用
		function showLine(){
			$.post('${ctx}/json/chartAction!reportRank.action',{"startTime":beginDateTime,"endTime":endDateTime}, function(data) {
				var list=data.list;
				var lineXname=[];
				var lineYvalue=[];
				for(var i=0;i<list.length;i++){
					lineXname.push(list[i].clientType_ID);
					lineYvalue.push(list[i].number);
				}
				createLine("linechart","",lineXname,lineYvalue);
			});
		};
		//饼图调用
		function showPie(){
			$.post('${ctx}/json/chartAction!reportDepartmentInfo.action',{"startTime":beginDateTime,"endTime":endDateTime,"id":rowIds[0]}, function(data) {
				var list=data.list;
				var xname=[];
				for(var i=0;i<list.length;i++){
					xname.push(list[i].type);
				}
				createPie("piechart","",xname,list);
			});
		};
		function createPie(divid,titlename,legenddata,datatotal){
			var pieChart=echarts.init(document.getElementById(divid));
			option = {
				    title : {
				        text: titlename,
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    legend: {
				        orient: 'vertical',
				        left: 'left',
				        data: legenddata
				    },
				    series : [
				        {
				            name: '数据统计',
				            type: 'pie',
				            radius : '55%',
				            center: ['50%', '60%'],
				            data:datatotal,
				            itemStyle: {
				                emphasis: {
				                    shadowBlur: 10,
				                    shadowOffsetX: 0,
				                    shadowColor: 'rgba(0, 0, 0, 0.5)'
				                }
				            }
				        }
				    ]
				};
			if(datatotal.length<1){
				pieChart.showLoading({
		          type:false,
				  text: '暂无数据',
				  color: '#c23531',
		          textColor: '#000',
				  maskColor: 'rgba(255, 255, 255, 0.8)',
				  zlevel:41
		        });
			 }else{
				 pieChart.hideLoading();
			 } 		 	    	
			pieChart.setOption(option);	
		}
		//柱形图调用方法
		function createLine(iddiv,titlename,xname,yvalue){
			var myChart=echarts.init(document.getElementById(iddiv));
	 	    var option = {
	 	        title : {
	 	            text: titlename,
		            itemGap: 15,
	 	            textStyle: {
	 	                color: '#dhdhdh'          // 标题文字颜色
	 	            }
	 	        },
	 	        tooltip : {
	 	            trigger: 'axis',
	 	           	axisPointer : {            
	 	              type : 'shadow'       
	 	          }
	 	        },
	 	        legend: {data:[]},
	 	       	dataZoom: [
			                 {
			                     show: true,
			                     realtime: true,
			                     start: 0,
			                     end: 100
			                 },
			                 {
			                	type: 'inside',
			                     realtime: true,
			                     start: 0,
			                     end: 100
			                 }
			             ],
	 	        grid:{
	 	        	left: '3%',
	 	           	right: '4%',
	 	           	bottom: '12%',
	 	            borderWidth:0,
	 	            borderColor:'#e3b',
	 	            //containLabel:true
	 	        },
	 	        xAxis : [
	 	            {
	 	                type : 'category',
	 	                axisLabel : {
	 	                    show : true,
	 	                    interval: '0',
	 	                    textStyle : {
	 	                        color : '#frfrfr',
	 	                        align : 'center'
	 	                    }
	 	                },
	 	                
	 	                 splitLine:{
	 	                    show:false
	 	                }, 
	 	                data : []
	 	            }
	 	        ],
	 	        yAxis : [
	 	            {
	 	                type : 'value',
	 	                splitLine:{
	 	                    show:false
	 	                },
	 	                axisLabel : {
	 	                    show : true,
	 	                    textStyle : {
	 	                        color : '#swswsw',
	 	                        align : 'center'
	 	                    }
	 	                }
	 	            }
	 	        ],
	 	        series : [
							{
	       					 name:"数据",
	       					 type:'bar',
	        				 barWidth:20,
	        				 data:[],
	        				 stack:"数据",//相同类型可以堆积在一起
	        				 itemStyle: {
	        		                normal: {
	        		                    barBorderColor: 'blue',
	        		                    color:'#4169E1'
	        		                },
	        		                emphasis: {
	        		                    barBorderColor: 'grean',
	        		                    color: '#1E90FF'
	        		                }
	        		            },
	   				 }
	 	        ]
	 	    };
	 	    option.xAxis[0].data=xname;
	 	    option.series[0].data=yvalue; 
	 	   if(yvalue.length<1){
				myChart.showLoading({
		          type:false,
				  text: '暂无数据',
				  color: '#c23531',
		          textColor: '#000',
				  maskColor: 'rgba(255, 255, 255, 0.8)',
				  zlevel:41
		        });
			 }else{
				myChart.hideLoading();
			 } 
	 	  myChart.setOption(option);
		}
		
		
	</script>
  </body>
</html>
