package com.zyytkj.system.pageModel;


public class UserPageModel {
	private String id;
	private String account;
	private String name;
	private String phone;// 手机号
	private String password;
	private String admin;
	private String canGetMoney;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAccount() {
		return account;
	}
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	public String getCanGetMoney() {
		return canGetMoney;
	}
	public void setCanGetMoney(String canGetMoney) {
		this.canGetMoney = canGetMoney;
	}
	
	

}
