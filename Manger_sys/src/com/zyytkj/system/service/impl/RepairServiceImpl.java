package com.zyytkj.system.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.zyytkj.system.dao.impl.BaseDaoImpl;
import com.zyytkj.system.model.User;
import com.zyytkj.system.service.RepairServiceI;
import com.zyytkj.system.util.Base64Encrypt;
import com.zyytkj.system.util.DesEncrypt;
import com.zyytkj.system.util.MD5keyBean;

@Service("repairService")
public class RepairServiceImpl extends BaseDaoImpl<Object> implements RepairServiceI {

	@Override
	public void initDataBase() {
		initUser();// 初始化用户
	}

	private User user = new User();

	// 初始化用户
	private void initUser() {
		List<Object> userlist = this.find(" from User");
		if (userlist == null || userlist.size() == 0) {
			/**
			 * 初始化admin用户
			 */
			user.setAccount("admin");
			user.setName("admin");
			user.setAdmin(true);
			// DES加密。
			String pw = "adminadmin";
			byte[] result = DesEncrypt.desCrypto(pw.getBytes());
			// 用BASE64进行包装
			MD5keyBean md5 = new MD5keyBean();
			String DBpwd = "";
			try {
				DBpwd = md5.getkeyBeanofStr(Base64Encrypt.encryptBASE64(result));
			} catch (Exception e) {
				e.printStackTrace();
			}
			user.setPassword(DBpwd);
			this.save(user);
		}
	}
}
