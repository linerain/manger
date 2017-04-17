package com.zyytkj.manger.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.zyytkj.manger.service.GetMoneyLogServiceI;
import com.zyytkj.system.action.base.BaseAction;
import com.zyytkj.system.model.User;
import com.zyytkj.system.pageModel.ExcelPageModel;
import com.zyytkj.system.util.ExportExcel;
import com.zyytkj.system.util.UploadOrDownLoad;

@SuppressWarnings("all")
@Namespace("/json")
@Action(value = "moneyAction", results = { @Result(name = "success", type = "json", params = { "root", "dataMap" }),
		@Result(name = "moneylog", location = "/pages/manger/moneylog.jsp") })
public class GetMoneyLogAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Autowired
	private GetMoneyLogServiceI getMoneyLogService;

	// json返回集合
	private Map<String, Object> dataMap;

	public String findByPage() {
		String state = request.getParameter("state");
		String userId = request.getParameter("userId");
		try {
			dataMap = new HashMap<String, Object>();
			Integer pageSize = Integer.parseInt(this.request.getParameter("rowCount"));
			Integer pageNumber = Integer.parseInt(this.request.getParameter("current"));
			Integer stateNum;
			if (state != null && !state.equals("")) {
				stateNum = Integer.parseInt(state);
			} else {
				stateNum = -1;
			}
			User user = (User) session.get("user");

			Object[] objs = getMoneyLogService.findByPage(pageNumber, pageSize, stateNum, userId);

			dataMap.put("rows", objs[0]);
			dataMap.put("total", objs[1]);
			dataMap.put("current", pageNumber);
			dataMap.put("rowCount", pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}
	

	public String pass() {
		dataMap = new HashMap<String, Object>();
		User userObj = (User) session.get("user");
		String ids = request.getParameter("ids");
		if (ids == null || ids.equals("")) {
			dataMap.put("msg", "操作失败！");
			dataMap.put("success", false);
		} else {
			if (userObj != null) {
				this.getMoneyLogService.pass(ids);
				dataMap.put("msg", "操作成功！");
				dataMap.put("success", true);
			} else {
				dataMap.put("msg", "登录已过期，请重新登录");
				dataMap.put("success", false);
			}
		}
		return "success";
	}
	
	public String stop() {
		dataMap = new HashMap<String, Object>();
		User userObj = (User) session.get("user");
		String ids = request.getParameter("ids");
		if (ids == null || ids.equals("")) {
			dataMap.put("msg", "操作失败！");
			dataMap.put("success", false);
		} else {
			if (userObj != null) {
				this.getMoneyLogService.stop(ids);
				dataMap.put("msg", "操作成功！");
				dataMap.put("success", true);
			} else {
				dataMap.put("msg", "登录已过期，请重新登录");
				dataMap.put("success", false);
			}
		}
		return "success";
	}
	
	public void downExcel(){
		String state = request.getParameter("state");
		Integer stateNum;
		if (state != null && !state.equals("")) {
			stateNum = Integer.parseInt(state);
		} else {
			stateNum = -1;
		}
		List<ExcelPageModel> logs = this.getMoneyLogService.findForExcel(stateNum);
		
		ExportExcel<ExcelPageModel> exp = new ExportExcel<>();
		String path = ServletActionContext.getServletContext().getRealPath("/Cousom.xls");
		System.out.println(path);
		exp.exportExcel("客户提现申请单", new String[]{"用户","身份证","手机","提现额（元）","银行卡号","开户地址","申请时间","状态"}, logs, path);
		UploadOrDownLoad.downLoad(path, this.response);
		
	}

	public String moneyLogAction() {
		return "moneylog";
	}
	
	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}

}
