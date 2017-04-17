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
	    <div>
	    	<div id="linechart" style="margin-left:30px;width:70%;height:50%;"></div>
   		</div>
 	<script>
 	//查看出现数据
 	var beginDateTime="",endDateTime="";
 	 $("#selectdate").on('click',function(){
 		beginDateTime=$('#beginDateTime').val();
 		endDateTime=$('#endDateTime').val();
 		showchart();
 	}); 
	//柱形图调用方法
	showchart();
	function showchart(){
	 	$.post('${ctx}/json/chartAction!reportCount.action',{"startTime":beginDateTime,"endTime":endDateTime}, function(data) {
			var list=data.list;
			var lineXname=[];
			var lineYvalue=[];
			for(var i=0;i<list.length;i++){
				lineXname.push(list[i].ip);
				lineYvalue.push(list[i].number);
			}
			/* lineXname=['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
			lineYvalue=[10, 52, 200, 334, 390, 330, 220]; */
			createLine("linechart","汇总报告",lineXname,lineYvalue);
		});
	};
	function createLine(iddiv,titlename,xname,yvalue){
		var myChart=echarts.init(document.getElementById(iddiv));
 	    var option = {
 	        title : {
 	            text: titlename,
	            itemGap: 15,
 	            textStyle: {
 	                color: '#dhdhdh'        
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
        				 stack:"数据",
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
