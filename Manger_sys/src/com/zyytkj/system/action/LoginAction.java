package com.zyytkj.system.action;

import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.zyytkj.system.Constant;
import com.zyytkj.system.action.base.BaseAction;
import com.zyytkj.system.model.User;
import com.zyytkj.system.service.LicenseServiceI;
import com.zyytkj.system.service.RepairServiceI;
import com.zyytkj.system.service.UserServiceI;
import com.zyytkj.system.util.IpUtil;
import com.zyytkj.system.util.RSAUtils;

/**
 * 登录
 * 
 * @author 黄超
 * @company 北京众谊越泰科技
 * @Date 2015年3月12日
 */
@SuppressWarnings("all")
@Namespace("/json")
@Action(value = "loginAction", results = { @Result(name = "success", type = "json", params = { "root", "dataMap" }),
		@Result(name = "noSession", location = "/login.jsp"),
		@Result(name = "index", location = "/pages/common/index.jsp"),
		@Result(name = "system", location = "/pages/common/manger.jsp"),
		@Result(name = "register", location = "/pages/error/register.jsp"), })
public class LoginAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	@Autowired
	UserServiceI userService;
	@Autowired
	private RepairServiceI repairService;
	@Autowired
	private LicenseServiceI licenseService;
	private Map<String, Object> dataMap;

	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}

	public UserServiceI getUserService() {
		return userService;
	}

	public void setUserService(UserServiceI userService) {
		this.userService = userService;
	}

	private User user;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	/***
	 * 用户登录
	 */
	public String login() {
		dataMap = new HashMap<String, Object>();

		User userObj = (User) session.get("user");
		if (userObj != null) {
			// 销毁session中的用户信息
			session.clear();
		}
		if (request.getParameter("account") != null && !request.getParameter("account").equals("")
				&& request.getParameter("password") != null && !request.getParameter("password").equals("")) {
			try {
				String account = request.getParameter("account");
				String password = request.getParameter("password");

				// -------------------RSA解密----------------------------
				// 加载Session中密钥
				// RSAPrivateKey privateKey = (RSAPrivateKey)
				// session.get("privateKey");
				String module = request.getParameter("module");
				RSAPrivateKey privateKey = RSAUtils.getPrivateKey(module);
				if (privateKey == null) {
					request.setAttribute("msg", "请稍后再试，正在加密传输");
					return "noSession";
				}
				StringBuffer pwd = new StringBuffer(RSAUtils.decryptByPrivateKey(password, privateKey));
				pwd.reverse();
				password = pwd.toString();
				// --------------------------------------------------------

				String result = userService.login(account, password);
				if (result.equals("initialize")) { // 初始化数据
					repairService.initDataBase();
					request.setAttribute("msg", "正在初始化数据，请重新登陆");
					return "noSession";
				} else if (result.equals("noLicence")) {
					return "register";
				} else if (result.equals("pwdfault")) {
					return "noSession";
				} else if (result.equals("noSession")) {
					return "noSession";
				} else if (result.equals("firstIndex")) {
					User users = userService.findByName(account);
					// 将用户数据存入session中
					request.getSession().setAttribute("globle_user", account);
					// 判断用户是否是管理员
					session.put("isAdmin", users.isAdmin());
					this.logMsg("用户登录", "人员管理", users.getAccount());
					session.put("user", users);
					session.put("ipadd", IpUtil.getIpAddr(ServletActionContext.getRequest()));
					request.setAttribute("falg", true);
					request.setAttribute("loginVersion", Constant.LOGIN_VERSION);
					if (users.isAdmin()) {
						return "system";
					} else {
						return "index";
					}
				}

				return "";

			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("msg", "您还没有登录或登录已超时，请刷新重新登录");
				return "noSession";
			}
		} else {
			request.setAttribute("msg", "您还没有登录或登录已超时，请刷新重新登录");
			return "noSession";
		}

	}

	/**
	 * 退出登录
	 */
	public String logout() {
		session.clear();
		ServletActionContext.getRequest().getSession().invalidate();
		return "noSession";
	}

	/**
	 * 去登录页面
	 * 
	 * @return
	 */
	public String loging() {
		return "noSession";
	}

	public String indexAction() {
		request.setAttribute("loginVersion", Constant.LOGIN_VERSION);
		return "system";
	}

	/**
	 * 获取RSA公共密钥
	 * 
	 * @return
	 */
	public String getPubKey() {

		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			map = RSAUtils.getKeys();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		// 生成公钥和私钥
		RSAPublicKey publicKey = (RSAPublicKey) map.get("public");
		RSAPrivateKey privateKey = (RSAPrivateKey) map.get("private");
		// 模
		String module = publicKey.getModulus().toString(16);
		// 公钥指数
		String empoent = publicKey.getPublicExponent().toString(16);

		RSAUtils.savePrivateKey(module, privateKey);

		dataMap = new HashMap<String, Object>();
		dataMap.put("success", true);
		dataMap.put("module", module);
		dataMap.put("empoent", empoent);
		return SUCCESS;
	}

}
