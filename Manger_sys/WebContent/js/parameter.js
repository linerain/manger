var parameterFlag=false;
var thresholdFlag=false;
function validatorParameter(){
	$('#Parameter_form').bootstrapValidator({
	            message: '此值无效',
	            excluded: [':disabled'],
	            feedbackIcons: {
	                valid: 'glyphicon glyphicon-ok',
	                invalid: 'glyphicon glyphicon-remove',
	                validating: 'glyphicon glyphicon-refresh'
	            },
	            fields: {
	            	"equipmentParameterPageModel.highTemperatureAlarmTwolevel": {
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.highTemperatureAlarm":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	                "equipmentParameterPageModel.upperTemperatureLimit":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.lowerTemperatureLimit":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.lowTemperatureAlarm":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.lowTemperatureAlarmTwolevel":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.returnTemperature":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-10之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 10;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.wetAlarmTwolevel":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.wetAlarm":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.upperHumidityLimit":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },	
	               "equipmentParameterPageModel.lowerHumidityLimit":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.dryAlarm":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	                "equipmentParameterPageModel.dryAlarmTwolevel":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.returnHumidity":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-10之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 10;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.PDUOvervoltageAlarm1Tow":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-600之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 600;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.PDUOvervoltageAlarm1":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-600之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 600;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.PDUupperNdervoltage":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-600之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 600;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }

	                       
	                    }
	                },
	               "equipmentParameterPageModel.PDUlowerNdervoltage":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-600之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 600;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }

	                       
	                    }
	                },
	               "equipmentParameterPageModel.PDUUndervoltageAlarm1":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-600之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <=600;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.PDUUndervoltageAlarm1Tow":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-600之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 600;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.returnPDUo":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-10之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 10;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.PDUOverflowingAlarm1Tow":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	                "equipmentParameterPageModel.PDUOverflowingAlarm1":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.PDUupperVerflowing":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.returnPDUf":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-5之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 5;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.PDUOvervoltageAlarm2":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-255之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 255;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.PDUUndervoltageAlarm2":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-255之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 255;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.PDUOverflowingAlarm2":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入1-99之间的数',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value >= 1 && value <= 99;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.frontDoorOpeningDelay":{
	                    message: '此值无效',
	                    validators: {
	                    	regexp: {
	                            regexp: /^[0-9]\d*$/,
	                            message: '只能输入数值'
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.backDoorOpeningDelay":{
	                    message: '此值无效',
	                    validators: {
	                    	regexp: {
	                            regexp: /^[0-9]\d*$/,
	                            message: '只能输入数值'
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.smokeMonitorSwitch":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入0或1',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value ==0 || value == 1;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.powersupplyMonitoringSwitch":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入0或1',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value ==0 || value == 1;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.waterimmersionMonitoringSwitch":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入0或1',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value ==0 || value == 1;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.vibrationMonitoringSwitch":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入0或1',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value ==0 || value == 1;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.standbyMonitorSwitch":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入0或1',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value ==0 || value == 1;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	               "equipmentParameterPageModel.netPduMonitoringSwitch":{
	                    message: '此值无效',
	                    validators: {
	                        notEmpty: {
	                            message: '该项不能为空'
	                        },
	                        callback: {
	                            message: '只能输入0或1',
	                            callback: function(value, validator) {
	                            	if(/^[0-9]\d*$/.test(value)){
	                                    return value ==0 || value == 1;
	                                  }else{
	                                    return false;
	                                  }
	                            }
	                        }
	                    }
	                },
	                                                                    
	            }
	        }).on('success.form.bv', function(e) {
	        	parameterFlag=true;
	        });
}
function validatorThreshold(){  
	$('#Threshold_form').bootstrapValidator({
        message: '此值无效',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	"threshold.upperTemperatureLimit":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-99之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 99;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.upperTemperatureLimit_lv2":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-99之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 99;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.lowerTemperatureLimit":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-99之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 99;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.lowerTemperatureLimit_lv2":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-99之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 99;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.upperHumidityLimit":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-99之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 99;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.upperHumidityLimit_lv2":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-99之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 99;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.lowerHumidityLimit":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-99之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 99;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.lowerHumidityLimit_lv2":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-99之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 99;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.upperCurrentLimit":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-99之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 99;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.upperCurrentLimit_lv2":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-99之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 99;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.lowerCurrentLimit":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-99之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 99;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.lowerCurrentLimit_lv2":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-99之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 99;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.upperVoltageLimit":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-600之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 600;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.upperVoltageLimit_lv2":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-600之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 600;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.lowerVoltageLimit":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-600之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 600;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
        	"threshold.lowerVoltageLimit_lv2":{
                message: '此值无效',
                validators: {
                    notEmpty: {
                        message: '该项不能为空'
                    },
                    callback: {
                        message: '只能输入1-600之间的数',
                        callback: function(value, validator) {
                        	if(/^[0-9]\d*$/.test(value)){
                                return value >= 1 && value <= 600;
                              }else{
                                return false;
                              }
                        }
                    }
                }
            },
	     }
    }).on('success.form.bv', function(e) {
    	thresholdFlag=true;
    });
}