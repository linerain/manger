package com.zyytkj.system.action.base;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.util.ServletContextAware;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ActionSupport;
import com.zyytkj.system.model.SystemLog;
import com.zyytkj.system.model.User;
import com.zyytkj.system.service.SystemLogServiceI;

@ParentPackage("basePackage")
@Namespace("/")
public class BaseAction extends ActionSupport
		implements ServletContextAware, ServletResponseAware, ServletRequestAware, SessionAware {
	@Autowired
	private SystemLogServiceI systemLogService;
	private static final long serialVersionUID = 1L;
	protected ServletContext servletContext;
	protected HttpServletResponse response;
	protected HttpServletRequest request;
	protected Map<String, Object> session;

	/**
	 * 将对象转换成JSON字符串，并响应回前台
	 * 
	 * @param object
	 * @throws IOException
	 */
	public void writeJson(Object object) {
		try {
			String json = JSON.toJSONStringWithDateFormat(object, "yyyy-MM-dd HH:mm:ss");
			ServletActionContext.getResponse().setContentType("text/html;charset=utf-8");
			ServletActionContext.getResponse().getWriter().write(json);
			ServletActionContext.getResponse().getWriter().flush();
			ServletActionContext.getResponse().getWriter().close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	@Override
	public void setServletRequest(HttpServletRequest httpServletRequest) {
		this.request = httpServletRequest;
	}

	@Override
	public void setServletResponse(HttpServletResponse httpServletResponse) {
		this.response = httpServletResponse;
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	/**
	 * 记录日志信息
	 * 
	 * @param action 操作
	 * @param type   位置
	 * @param details操作内容
	 */
	public void logMsg(String action, String type,String details) {

		if(session.get("user") != null){
			User user=(User)session.get("user");
			SystemLog syslog = new SystemLog();
			syslog.setUserCount(user.getAccount());
			syslog.setUserName(user.getName());
			syslog.setDatetime(new Date());
			syslog.setType(type);
			syslog.setIp((String)session.get("ipadd"));
			syslog.setAction(action);
			syslog.setDetails(details);
			try {
				systemLogService.saveSystemLog(syslog);
			} catch (Exception e) {
				System.out.println("记录日志失败，日志内容:" + e.getMessage());
			}
		}

	}
}
