package com.zyytkj.system.action;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;

import com.zyytkj.system.action.base.BaseAction;
import com.zyytkj.system.model.SystemLog;
import com.zyytkj.system.model.User;
import com.zyytkj.system.service.SystemLogServiceI;

/**
 * 系统日志控制类
 * 
 * @author 白云
 * @company 北京众谊越泰科技有限公司
 * @data 3月17日
 * 
 */
@SuppressWarnings("all")
@Namespace("/json")
@Action(value = "systemLogAction", results = { 
		@Result(name = "success", type = "json", params = { "root", "dataMap" }),
		@Result(name = "systemLogJsp", location = "/pages/system/log.jsp") })
public class SystemLogAction extends BaseAction {

	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static final long serialVersionUID = 1L;

	private SystemLog systemLog;
	// json返回集合
	private Map<String, Object> dataMap;

	@JSON(serialize = false)
	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	@Autowired
	private SystemLogServiceI systemLogService;

	public SystemLog getSystemLog() {
		return systemLog;
	}

	public void setSystemLog(SystemLog systemLog) {
		this.systemLog = systemLog;
	}

	/**
	 * 分页获取系统日志
	 * 
	 * @edit fjj
	 */
	public String findPage() {
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String userCount = request.getParameter("searchPhrase");
		try {
			Timestamp startTime = null;
			Timestamp endTime = null;
			if (start != null && !"".equals(start)) {
				startTime = new Timestamp(sdf.parse(start).getTime());
			}
			if (end != null && !"".equals(end)) {
				endTime = new Timestamp(sdf.parse(end).getTime());
			}
			dataMap = new HashMap<String, Object>();
			Integer pageSize = Integer.parseInt(this.request.getParameter("rowCount"));
			Integer pageNumber = Integer.parseInt(this.request.getParameter("current"));
			User user = (User)session.get("user");
			List<SystemLog> syslogList = new ArrayList<SystemLog>();
			syslogList = systemLogService.findPage(pageSize, pageNumber, startTime, endTime, userCount,user);
			Long total = systemLogService.getCount(startTime, endTime, userCount,user);

			dataMap.put("rows", syslogList);
			dataMap.put("total", total);
			dataMap.put("current", pageNumber);
			dataMap.put("rowCount", pageSize);
		} catch (java.text.ParseException e) {
			e.printStackTrace();
		}

		return "success";
	}

	/**
	 * 删除日志
	 */
	public String deleteLog() {
		dataMap = new HashMap<String, Object>();
		User userObj = (User) session.get("user");
		String ids = request.getParameter("ids");
		if (ids == null || ids.equals("")) {
			dataMap.put("msg", "删除失败！");
			dataMap.put("success", false);
		} else {
			if (userObj != null) {
				String msg = systemLogService.deleteSystemLog(ids, userObj);
				dataMap.put("msg", msg);
				dataMap.put("success", true);
			} else {
				dataMap.put("msg", "登录已过期，请重新登录");
				dataMap.put("success", false);
			}
		}
		return "success";
	}

	/**
	 * 详细信息
	 */
	public String findOne() {
		dataMap = new HashMap<String, Object>();
		String id = request.getParameter("id");
		SystemLog log = systemLogService.findById(id);
		dataMap.put("log", log);
		return "success";
	}

	public String systemLogAction() {
		return "systemLogJsp";
	}
}
