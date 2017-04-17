package com.zyytkj.system.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zyytkj.system.cache.LicenceCache;
import com.zyytkj.system.dao.UserDaoI;
import com.zyytkj.system.model.User;
import com.zyytkj.system.pageModel.UserPageModel;
import com.zyytkj.system.service.LicenseServiceI;
import com.zyytkj.system.service.UserServiceI;
import com.zyytkj.system.util.Base64Encrypt;
import com.zyytkj.system.util.DesEncrypt;
import com.zyytkj.system.util.MD5keyBean;

@Service("userService")
public class UserServiceImpl implements UserServiceI {
	@Autowired
	private UserDaoI userDao;

	public UserDaoI getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDaoI userDao) {
		this.userDao = userDao;
	}

	@Override
	public String login(String account, String password) {
	// 验证空
		
		if(this.findAllUsers().size()==0){
			return "initialize";
		}
		
		if (account != null && !account.equals("") && password != null && !password.equals("")) {
			User user = this.getUserByAccount(account);
			// 验证账号存在
			if (user != null) {
				// 查询全局变量是否为空
//				if (LicenceCache.getLicenceCache().size() == 0) {
//					return "noLicence";
//				} else {
//					if (!licenseService.verifyDate(LicenceCache.getLicenceCache())) {
//						return "noLicence";
//					}
//				}
				// 验证是否可用

				// DES加密。
				String pw = account + password;
				byte[] result = DesEncrypt.desCrypto(pw.getBytes());
				// 用BASE64进行包装
				MD5keyBean md5 = new MD5keyBean();
				String DBpwd = "";
				try {
					DBpwd = md5.getkeyBeanofStr(Base64Encrypt.encryptBASE64(result));
					// 验证密码
					if (user.getPassword().equals(DBpwd)) {
						return "firstIndex";
					} else {
						return "pwdfault";
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {

				return "pwdfault";
			}
		} else {
			return "noSession";
		}
		return null;
	}

	@Override
	public User register(User user, boolean isAdmin) {
		try {
			String pwd = user.getAccount() + user.getPassword();
			// DES加密。
			byte[] result = DesEncrypt.desCrypto(pwd.getBytes());
			// 用BASE64进行包装
			String password = Base64Encrypt.encryptBASE64(result);
			MD5keyBean md5 = new MD5keyBean();
			user.setAdmin(isAdmin);
			user.setPassword(md5.getkeyBeanofStr(password));
			user.setLogTime(new Date());
			this.userDao.save(user);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	@Override
	public void deleteUser(String ids) {
		String[] idArr = ids.split(",");
		for (String id : idArr) {
			User user = this.getUserById(id);
			this.userDao.delete(user);
		}
	}

	@Override
	public User getUserByAccount(String account) {
		String hql = "from User where account = '" + account + "' ";
		List<User> users = this.userDao.find(hql);
		if (users.size() > 0) {
			return users.get(0);
		}
		System.out.println(users.size());
		return null;
	}

	@Override
	public User getUserById(String id) {
		User u = this.userDao.get(User.class, id);
		return u;
	}

	@Override
	public List<User> findAllUsers() {
		String hql = " from User ";
		return this.userDao.find(hql);
	}

	@Override
	public List<UserPageModel> findUsersByPage(Integer pageSize, Integer pageNumber, String name) {
		String hql = "from User where 1=1 and account<>'admin'";
		List<Object> param = new ArrayList<Object>();
		if (null != name && !"".equals(name)) {
			hql += " and account like ?";
			param.add("%" + name.trim() + "%");
		}
		List<User> userList = userDao.find(hql, param, pageNumber, pageSize);
		List<UserPageModel> userPageList = entryToPage(userList);
		return userPageList;
	}

	private List<UserPageModel> entryToPage(List<User> userList) {
		List<UserPageModel> userPageList = new ArrayList<>();
		for (User user : userList) {
			UserPageModel userPageModel = new UserPageModel();
			userPageModel.setId(user.getId());
			userPageModel.setAccount(user.getAccount());
			userPageModel.setName(user.getName());
			userPageModel.setPhone(user.getPhone());
			userPageModel.setPassword(user.getPassword());
			userPageModel.setAdmin(user.isAdmin()?"管理员":"客户");
			userPageModel.setCanGetMoney(user.getCanGetMoney()+"");

			userPageList.add(userPageModel);
		}
		return userPageList;
	}

	@Override
	public String[] updateUser(User userObj, String oldPwd, String newPwd) {
		String[] res = new String[2];
		if (oldPwd != null && !oldPwd.equals("") && newPwd != null && !newPwd.equals("")) {
			try {

				// DES加密。
				String pw = userObj.getAccount() + newPwd;
				String oldpw = userObj.getAccount() + oldPwd;
				byte[] result = DesEncrypt.desCrypto(pw.getBytes());
				byte[] oldresult = DesEncrypt.desCrypto(oldpw.getBytes());
				MD5keyBean md5 = new MD5keyBean();
				String DBpwd = md5.getkeyBeanofStr(Base64Encrypt.encryptBASE64(result));
				String md5oldpwd = md5.getkeyBeanofStr(Base64Encrypt.encryptBASE64(oldresult));
				if (!userObj.getPassword().equals(md5oldpwd)) {
					res[0] = "false";
					res[1] = "原始密码不正确,请重新输入！";
				} else {
					if (md5oldpwd.equals(DBpwd)) {
						res[0] = "false";
						res[1] = "密码不能与上次重复！";
					} else {
						res[0] = "true";
						res[1] = "密码修改成功！";
						userObj.setPassword(DBpwd);
						userDao.update(userObj);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			res[0] = "false";
			res[1] = "密码修改失败！";
		}
		return res;
	}

	@Override
	public long countUsers(String name) {
		String hql = "select count(*) from User t where 1=1 and account<>'admin' ";
		List<Object> param = new ArrayList<Object>();
		if (null != name && !"".equals(name)) {
			hql += " and account like ?";
			param.add("%" + name.trim() + "%");
		}
		return userDao.count(hql, param);
	}

	@Override
	public List<User> findUserByName(String name) {
		List<Object> values = new ArrayList<Object>();
		String hql = " from User where account like ? and account<>'admin'";
		values.add("%" + name.trim() + "%");
		return userDao.find(hql, values);
	}

	@Override
	public User findByName(String name) {
		String hql = " from User where 1=1 and  account =? ";
		Object[] param = { name };
		return userDao.get(hql, param);
	}

	@Override
	public String[] saveOrupdate(User user, String userType) {
		String[] result = new String[2];

		if (user.getId() == null || user.getId().equals("")) {
			user.setMoney_one(0.0);
			user.setMoney_two(0.0);
			user.setCanGetMoney(0.0);
			this.register(user, userType.equals("manger"));
			result[0] = "true";
			result[1] = "新增用户:" + user.getAccount() + "成功";
		} else {
			User nuser = this.getUserById(user.getId());
			if (!nuser.getName().equals(user.getName())) {
				result[0] = "false";
				result[1] = "用户名不可修改";

				return result;
			} else {
				nuser.setAccount(user.getAccount());
				nuser.setName(user.getName());
				nuser.setPhone(user.getPhone());
				this.updateUser(nuser, null, null);
				result[0] = "true";
				result[1] = "更新用户:" + user.getAccount() + "成功";
			}
		}

		return result;
	}

	@Override
	public User getByAccountAndPwd(String account, String password) {
		if (account != null && !account.equals("") && password != null && !password.equals("")) {
			User user = this.getUserByAccount(account);
			// 验证账号存在
			if (user != null) {
				// DES加密。
				String pw = account + password;
				byte[] result = DesEncrypt.desCrypto(pw.getBytes());
				// 用BASE64进行包装
				MD5keyBean md5 = new MD5keyBean();
				String DBpwd = "";
				try {
					DBpwd = md5.getkeyBeanofStr(Base64Encrypt.encryptBASE64(result));
					// 验证密码
					if (user.getPassword().equals(DBpwd)) {
						return user;
					}
				} catch (Exception e) {

				}
			}
		}
		return null;
	}

	@Override
	public String adminResetPassword(String userid, User user, String password) {

		if (user.isAdmin()) {
			User use = this.getUserById(userid);
			try {
				// DES加密。
				String pw = use.getAccount() + password;
				String oldpw = use.getAccount() + use.getPassword();
				byte[] result = DesEncrypt.desCrypto(pw.getBytes());
				byte[] oldresult = DesEncrypt.desCrypto(oldpw.getBytes());
				MD5keyBean md5 = new MD5keyBean();
				String DBpwd = md5.getkeyBeanofStr(Base64Encrypt.encryptBASE64(result));
				String md5oldpwd = md5.getkeyBeanofStr(Base64Encrypt.encryptBASE64(oldresult));
				if (md5oldpwd.equals(DBpwd)) {
					return "密码不能与上次重复！";
				} else {
					use.setPassword(DBpwd);
					userDao.update(use);
					return "密码修改成功！";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else {
			return "您不是超级管理员 重置失败";
		}
		return null;
	}

	@Override
	public void updateU(User user) {
		this.userDao.update(user);
	}

	@Override
	public byte[] checkOpenDoor(String account, String password, String rand) {
		// 验证非空
		if (account != null && !account.equals("") && password != null && !password.equals("")) {
			List<Object> param = new ArrayList<>();
			param.add(account);
			String hql = "from User where account = ? ";
			User user = this.userDao.get(hql, param);
			// 验证账号存在
			if (user != null) {
				// 验证是否可用
				// DES加密。
				String pw = account + password;
				byte[] result = DesEncrypt.desCrypto(pw.getBytes());
				// 用BASE64进行包装
				MD5keyBean md5 = new MD5keyBean();
				String DBpwd = "";
				try {
					DBpwd = md5.getkeyBeanofStr(Base64Encrypt.encryptBASE64(result));
					if (user.getPassword().equals(DBpwd)) {
						return ArrayUtils.addAll(new byte[] { 0x00, 0x05 }, rand.getBytes());
					} else {
						return ArrayUtils.addAll(new byte[] { 0x04, 0x05 }, rand.getBytes());
					}
				} catch (Exception e) {
					e.printStackTrace();
				}

			} else {
				return ArrayUtils.addAll(new byte[] { 0x03, 0x00 }, rand.getBytes());// 用户不存在
			}
		}
		return new byte[] { 0x03, 0x00 };// 空值
	}

	@Override
	public boolean checkUserPassword(String account, String password) {
		User user = this.getUserByAccount(account);
		if (user == null) {
			return false;
		}
		// DES加密。
		String pw = account + password;
		byte[] result = DesEncrypt.desCrypto(pw.getBytes());
		// 用BASE64进行包装
		MD5keyBean md5 = new MD5keyBean();
		String DBpwd = "";
		try {
			DBpwd = md5.getkeyBeanofStr(Base64Encrypt.encryptBASE64(result));
			// 验证密码
			if (user.getPassword().equals(DBpwd)) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
		// try {
		// // BASE64进行解包
		// byte[] bytes = Base64Encrypt.decryptBASE64(user.getPassword());
		// // 用DES进行解密
		// System.out.println("1111111111"+bytes);
		// String DESPassword = new String(DesEncrypt.decrypt(bytes));
		// if (password.equals(DESPassword)) {
		// return true;
		// }
		// } catch (Exception e) {
		// e.printStackTrace();
		// return false;
		// }
		//
		// return false;
	}
	/*
	 * private static byte itob(int i){ byte b; switch(i){ case 0: b=(byte)0x00;
	 * break; case 1: b=(byte)0x01; break; case 2: b=(byte)0x02; break; case 3:
	 * b=(byte)0x03; break; case 4: b=(byte)0x04; break; default: b=(byte)0x05;
	 * break; } return b; }
	 */
}
