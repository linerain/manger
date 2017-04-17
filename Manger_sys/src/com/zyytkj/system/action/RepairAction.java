package com.zyytkj.system.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.zyytkj.system.action.base.BaseAction;
import com.zyytkj.system.service.RepairServiceI;
@SuppressWarnings("all")
@Namespace("/json")
@Action(value = "repairAction", results = { @Result(name = "success", type = "json", params = {
		"root", "dataMap" }) })
public class RepairAction extends BaseAction {

	@Autowired
	private RepairServiceI repairService;
	
	public RepairServiceI getRepairService() {
		return repairService;
	}
	public void setRepairService(RepairServiceI repairService) {
		this.repairService = repairService;
	}

	public void init(){
		repairService.initDataBase();
	}
}
