package com.zyytkj.system.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 用户
 * 
 * @author 黄超
 * @company 北京众谊越泰科技
 * @Date 2015年3月11日
 */
@Entity
@Table(name = "sys_user")
public class User {

	@Id
	@Column(name = "ID", length = 32)
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	private String id;
	@Column(length = 200)
	private String account;// 账号
	@Column(length = 200)
	private String name; // 用户名
	@Column(length = 200)
	private String password;// 密码
	@Column(length = 32)
	private String phone;// 手机号
	@Column
	private boolean admin;
	// ————————————————————————————————————
	@Column(length = 200)
	private String idCard;
	@Column(length = 200)
	private String bankCard;
	@Column(length = 2048)
	private String bankAddr;
	@Column
	private Date logTime;

	@Column
	private double money_one;
	@Column
	private double money_two;
	@Column
	private double canGetMoney;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public String getAccount() {
		return account;
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getBankCard() {
		return bankCard;
	}

	public void setBankCard(String bankCard) {
		this.bankCard = bankCard;
	}

	public String getBankAddr() {
		return bankAddr;
	}

	public void setBankAddr(String bankAddr) {
		this.bankAddr = bankAddr;
	}

	public Date getLogTime() {
		return logTime;
	}

	public void setLogTime(Date logTime) {
		this.logTime = logTime;
	}

	public double getMoney_one() {
		return money_one;
	}

	public void setMoney_one(double money_one) {
		this.money_one = money_one;
	}

	public double getMoney_two() {
		return money_two;
	}

	public void setMoney_two(double money_two) {
		this.money_two = money_two;
	}

	public double getCanGetMoney() {
		return canGetMoney;
	}

	public void setCanGetMoney(double canGetMoney) {
		this.canGetMoney = canGetMoney;
	}

}
