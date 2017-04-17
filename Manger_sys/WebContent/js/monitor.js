function creatOption(data,min,max) {
	var option = {
		title : {
			show : false,
		},
		grid : {
			top : 0,
			right : 0,
			bottom : 0,
			left : 0
		},
		tooltip : {
			trigger : 'axis',
			formatter : function(params) {
				params = params[0];
				var date = new Date(params.name);
				return date.getHours() + ':' + (date.getMinutes() + 1) + ':'
						+ date.getSeconds() + ' : ' + params.value[1];
			},
			axisPointer : {
				animation : false
			}
		},
		xAxis : {
			type : 'time',
			splitLine : {
				show : false
			},
			axisTick : {
				show : false
			},
			axisLabel : {
				show : false
			}
		},
		yAxis : {
			type : 'value',
			min : min,
			max : max,
			splitLine : {
				show : false
			},
			axisTick : {
				show : false
			},
			axisLabel : {
				show : false
			}
		},
		series : [ {
			name : 'value',
			type : 'line',
			showSymbol : false,
			hoverAnimation : false,
			data : data,
			lineStyle : {
				normal : {
					color : '#00BFA5'
				},
			},
			areaStyle : {
				normal : {
					color : '#00BFA5'
				}
			}
		} ]
	};
	return option;
}

function createData(valu) {
	var nowtime = new Date()
	return {
		name : nowtime.toString(),
		value : [ new Date(), valu ]
	}
}

function addData(charts, val, data) {
	if (data.length > 200) {
		data.shift();
	}
	data.push(createData(val));
	charts.setOption({
		series : [ {
			data : data
		} ]
	})
}

function chartAlarm(charts,level){
	if(level==1){
		var color = '#fde910';
	}else if(level==2){
		var color = '#ff5454';
	}else{
		var color = '#00BFA5';
	}
	
	charts.setOption({
		series : [ {
			lineStyle : {
				normal : {
					color : color
				},
			},
			areaStyle : {
				normal : {
					color : color
				}
			}
		} ]
	})
}