package com.zyytkj.system.interceptor;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import com.zyytkj.system.util.RequestUtil;
/**
 * 权限拦截器
 * 
 * @author 冯京京
 * @company 北京众谊越泰
 * @Date 2015年3月13日
 */
public class AuthorityInterceptor extends MethodFilterInterceptor {
	private static final Logger logger = Logger.getLogger(AuthorityInterceptor.class);
	protected String doIntercept(ActionInvocation actionInvocation) throws Exception {
		String userAccount =(String)ServletActionContext.getRequest().getSession().getAttribute("globle_user");
		String requestPath = RequestUtil.getRequestPath(ServletActionContext.getRequest());
		if(userAccount==null || userAccount.equals("")){
			if(!"/json/loginAction!login.action".equals(requestPath)&&!"/json/loginAction!getPubKey.action".equals(requestPath)){
				    String[] path=requestPath.split("!");
					if(!"/app/webAppCommunication".equals(path[0])){
						ServletActionContext.getRequest().setAttribute("user", "noSession");
						return "noSession";
					}
				
			}
		}

		return actionInvocation.invoke();
	}
}
