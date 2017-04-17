package com.zyytkj.system.action;

import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.zyytkj.manger.service.GetMoneyLogServiceI;
import com.zyytkj.system.Constant;
import com.zyytkj.system.action.base.BaseAction;
import com.zyytkj.system.model.SystemLog;
import com.zyytkj.system.model.User;
import com.zyytkj.system.pageModel.UserPageModel;
import com.zyytkj.system.service.LicenseServiceI;
import com.zyytkj.system.service.RepairServiceI;
import com.zyytkj.system.service.SystemLogServiceI;
import com.zyytkj.system.service.UserServiceI;
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
@Action(value = "userAction", results = { @Result(name = "success", type = "json", params = { "root", "dataMap" }),
		@Result(name = "noSession", location = "/login.jsp"),
		@Result(name = "index", location = "/pages/common/index.jsp"), @Result(name = "show", location = "/index.jsp"),
		@Result(name = "showCCB", location = "/index_CCB.jsp"),
		@Result(name = "firstIndex", location = "/pages/common/index.jsp"),
		@Result(name = "firstIndexCCB", location = "/index_CCB.jsp"),
		@Result(name = "register", location = "/pages/error/register.jsp"),
		@Result(name = "userJsp", location = "/pages/system/user.jsp") })
public class UserAction extends BaseAction {

	private static boolean active = false;

	private static final long serialVersionUID = 1L;

	@Autowired
	UserServiceI userService;
	@Autowired
	private RepairServiceI repairService;

	@Autowired
	private LicenseServiceI licenseService;

	@Autowired
	private SystemLogServiceI systemlogService;

	@Autowired
	private GetMoneyLogServiceI getMoneyLogService;

	private User user;
	// json返回集合
	private Map<String, Object> dataMap;

	public UserServiceI getUserService() {
		return userService;
	}

	public void setUserService(UserServiceI userService) {
		this.userService = userService;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}

	/**
	 * 修改密码
	 */
	public String updatePwd() {
		dataMap = new HashMap<String, Object>();
		if (request.getParameter("oldPassword") != null && !"".equals(request.getParameter("oldPassword"))
				&& request.getParameter("newPassword") != null && !"".equals(request.getParameter("newPassword"))) {
			String oldPwd = request.getParameter("oldPassword");
			String newPwd = request.getParameter("newPassword");
			User userObj = (User) session.get("user");

			// -------------------RSA解密----------------------------
			// 加载Session中密钥
			String module = request.getParameter("module");
			RSAPrivateKey privateKey = RSAUtils.getPrivateKey(module);
			StringBuffer opwd;
			StringBuffer npwd;
			try {
				opwd = new StringBuffer(RSAUtils.decryptByPrivateKey(oldPwd, privateKey));
				npwd = new StringBuffer(RSAUtils.decryptByPrivateKey(newPwd, privateKey));
				opwd.reverse();
				npwd.reverse();
				oldPwd = opwd.toString();
				newPwd = npwd.toString();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			// --------------------------------------------------------

			// BASE64进行解包
			try {
				String[] res = userService.updateUser(userObj, oldPwd, newPwd);
				if (res[0].equals("true")) {
					this.logMsg("修改用户密码", "人员管理", userObj.getAccount() + "成功！");
					dataMap.put("msg", res[1]);
					dataMap.put("success", true);
				} else if (res[0].equals("false")) {
					this.logMsg("修改用户密码", "人员管理", userObj.getAccount() + "失败！");
					dataMap.put("msg", res[1]);
					dataMap.put("success", false);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			dataMap.put("msg", "修改失败！");
			dataMap.put("success", false);
		}

		return "success";
	}

	/**
	 * 分页查询
	 * 
	 * @return
	 */
	public String findUsersByPage() {
		dataMap = new HashMap<String, Object>();
		if (request.getParameter("rowCount") != null && !"".equals(request.getParameter("rowCount"))
				&& request.getParameter("current") != null && !"".equals(request.getParameter("current"))) {
			Integer pageSize = Integer.parseInt(request.getParameter("rowCount"));
			Integer pageNumber = Integer.parseInt(request.getParameter("current"));
			String name = request.getParameter("searchPhrase");
			List<UserPageModel> userList = userService.findUsersByPage(pageSize, pageNumber, name);
			Long total = userService.countUsers(name);

			dataMap.put("rows", userList);
			dataMap.put("total", total);
			dataMap.put("current", pageNumber);
			dataMap.put("rowCount", pageSize);

		} else {
			dataMap.put("msg", "查询失败！");
			dataMap.put("success", false);
		}

		return "success";

	}

	/**
	 * 查询所有的用户
	 */
	public String findAllUser() {
		dataMap = new HashMap<String, Object>();
		List<User> users = userService.findAllUsers();
		dataMap.put("users", users);
		return "success";
	}

	/**
	 * 保存/更新用户
	 * 
	 * @return
	 */
	public String saveOrupdate() {
		dataMap = new HashMap<String, Object>();

		String userType = request.getParameter("usertype");

		if (user.getId() == null || user.getId().equals("")) {
			// RAS
			try {
				String module = request.getParameter("module");
				RSAPrivateKey privateKey = RSAUtils.getPrivateKey(module);
				StringBuffer pwd = new StringBuffer(RSAUtils.decryptByPrivateKey(user.getPassword(), privateKey));
				pwd.reverse();
				user.setPassword(pwd.toString());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		String[] flag = userService.saveOrupdate(user, userType);
		if (flag[0].equals("false")) {
			dataMap.put("msg", flag[1]);
			dataMap.put("success", false);
		} else {
			dataMap.put("msg", flag[1]);
			dataMap.put("success", true);
		}

		return "success";
	}

	/**
	 * 删除用户
	 * 
	 * @return
	 */
	public String deleteUser() {
		dataMap = new HashMap<String, Object>();
		try {
			if (request.getParameter("ids") != null && !"".equals(request.getParameter("ids"))) {
				String ids = request.getParameter("ids");
				String str = (String) session.get("ipadd");
				User user1 = (User) session.get("user");
				userService.deleteUser(ids);
				dataMap.put("msg", "删除成功！");
				dataMap.put("success", true);

				SystemLog sys = new SystemLog();
				sys.setId(UUID.randomUUID().toString().replaceAll("-", ""));
				sys.setUserCount(user1.getAccount());
				sys.setUserName(user1.getName());
				sys.setDatetime(new Date());
				sys.setType("人员管理");
				sys.setIp(str);
				sys.setAction("执行删除用户");
				systemlogService.saveSystemLog(sys);
			} else {
				dataMap.put("msg", "删除失败！");
				dataMap.put("success", false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			dataMap.put("msg", "删除失败！");
			dataMap.put("success", false);
		}
		return "success";
	}

	/**
	 * 用户信息
	 * 
	 * @return
	 */
	public String getUserInfo() {
		dataMap = new HashMap<String, Object>();
		if (request.getParameter("id") != null && !"".equals(request.getParameter("id"))) {
			String id = request.getParameter("id");
			User user = userService.getUserById(id);
			dataMap.put("user", user);
			dataMap.put("success", true);
		} else {
			dataMap.put("msg", "查询失败！");
			dataMap.put("success", false);
		}

		return "success";
	}

	/**
	 * 异步校验添加时候名称校验
	 * 
	 * @return
	 */
	public String checkNameExist() {
		dataMap = new HashMap<String, Object>();
		if (request.getParameter("name") != null && !"".equals(request.getParameter("name"))) {
			String name = request.getParameter("name");
			User user = userService.findByName(name);
			if (null != user) {
				dataMap.put("success", true);
				dataMap.put("msg", "账号已存在");
			} else {
				dataMap.put("success", false);
			}
		} else {
			dataMap.put("msg", "校验失败！");
			dataMap.put("success", false);
		}

		return "success";
	}

	/**
	 * 保存某个角色所对应的部门
	 * 
	 * @authorfjj
	 */
	public String saveDepartByRoleId() {
		dataMap = new HashMap<String, Object>();
		String id = request.getParameter("id");
		String idDep = request.getParameter("idDep");
		if (request.getParameter("id") != null && !"".equals(request.getParameter("id"))
				&& request.getParameter("idDep") != null && !"".equals(request.getParameter("idDep"))) {

		}
		// TODO add code
		return "success";
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

	/**
	 * 超级管理员重置
	 */
	public String resetPassword() {
		dataMap = new HashMap<String, Object>();
		User user = (User) this.session.get("user");
		String userid = this.request.getParameter("userId");
		String password = this.request.getParameter("newPassword");

		// RAS
		try {
			String module = request.getParameter("module");
			RSAPrivateKey privateKey = RSAUtils.getPrivateKey(module);
			StringBuffer pwd = new StringBuffer(RSAUtils.decryptByPrivateKey(password, privateKey));
			pwd.reverse();
			password = pwd.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			String msg = this.userService.adminResetPassword(userid, user, password);
			dataMap.put("success", true);
			dataMap.put("msg", "密码重置成功");
		} catch (Exception e) {
			e.printStackTrace();
			dataMap.put("success", false);
			dataMap.put("msg", "密码重置失败");
		}
		return SUCCESS;
	}

	/**
	 * 回显金钱设置
	 * 
	 * @return
	 */
	public String getUserMoney() {
		dataMap = new HashMap<>();

		String id = request.getParameter("id");

		User user = this.userService.getUserById(id);
		if (user != null) {
			dataMap.put("admin", user.isAdmin());
			dataMap.put("money_id", user.getId());
			dataMap.put("money_1", user.getMoney_one());
			dataMap.put("money_2", user.getMoney_two());
			dataMap.put("money_get", user.getCanGetMoney());
		}

		return SUCCESS;
	}

	/**
	 * 设置资金
	 * 
	 * @return
	 */
	public String setUserMoney() {
		dataMap = new HashMap<>();

		String id = request.getParameter("id");
		String money_1_str = request.getParameter("money_1");
		String money_2_str = request.getParameter("money_2");
		String money_get_str = request.getParameter("money_get");

		User user = this.userService.getUserById(id);
		if (user != null) {
			user.setMoney_one(Double.parseDouble(money_1_str));
			user.setMoney_two(Double.parseDouble(money_2_str));
			user.setCanGetMoney(Double.parseDouble(money_get_str));
			this.userService.updateU(user);
			dataMap.put("msg", "设置成功");
			dataMap.put("success", true);
		} else {
			dataMap.put("msg", "设置失败");
			dataMap.put("success", false);
		}

		return SUCCESS;
	}

	public String setInfo() {
		dataMap = new HashMap<>();

		String bankcard = request.getParameter("bankcard");
		String bankaddr = request.getParameter("bankaddr");
		String phone = request.getParameter("phone");

		User user = (User) this.session.get("user");
		if (user != null) {
			user.setPhone(phone);
			user.setBankCard(bankcard);
			user.setBankAddr(bankaddr);
			this.userService.updateU(user);
			this.session.put("user", user);
			dataMap.put("msg", "设置成功");
			dataMap.put("success", true);
		} else {
			dataMap.put("msg", "设置失败");
			dataMap.put("success", false);
		}

		return SUCCESS;
	}

	public String getMoney() {
		dataMap = new HashMap<>();

		String money_val = request.getParameter("money_val");
		User user = (User) this.session.get("user");
		if (user != null) {

			User users = getMoneyLogService.askMoney(user.getId(), Double.parseDouble(money_val));
			if (users != null) {
				this.session.put("user", users);
				dataMap.put("money_now", users.getCanGetMoney());
			}
			dataMap.put("msg", users != null ? "申请成功" : "申请失败");
			dataMap.put("success", users != null);
		} else {
			dataMap.put("msg", "申请失败");
			dataMap.put("success", false);
		}

		return SUCCESS;
	}

	public String checkMoney() {
		dataMap = new HashMap<>();
		User user = (User) this.session.get("user");
		String value = this.request.getParameter("money_value");
		double val = Double.parseDouble(value);
		User reUser = this.userService.getUserById(user.getId());
		dataMap.put("success", val <= reUser.getCanGetMoney());
		return SUCCESS;
	}

	public String changeState() {
		dataMap = new HashMap<>();
		String ac = request.getParameter("ac");
		if (ac.equals("1")) {
			active = true;
		} else {
			active = false;
		}
		dataMap.put("success", true);
		dataMap.put("msg", "设置成功");
		return SUCCESS;
	}

	public String checkState() {
		dataMap = new HashMap<>();
		dataMap.put("success", active);
		return SUCCESS;
	}

	public String userAction() {
		request.setAttribute("loginVersion", Constant.LOGIN_VERSION);
		return "userJsp";
	}

	public String indexAction() {
		return "index";
	}

}
