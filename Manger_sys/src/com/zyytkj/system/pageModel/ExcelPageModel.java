package com.zyytkj.system.pageModel;

import java.util.Date;

import com.zyytkj.manger.model.GetMoneyLog;

public class ExcelPageModel {
	String name;
	String idCard;
	String phone;
	Double money;
	String cardNum;
	String cardAddr;
	Date logTime;
	String state;// 0ask ,1yes ,2No

	public ExcelPageModel(GetMoneyLog log) {
		super();
		money = log.getMoney();
		switch (log.getState()) {
		case 0:
			state = "待审核";
			break;
		case 1:
			state = "通过";

			break;
		case 2:
			state = "拒绝";

			break;

		default:
			state = "未知";
			break;
		}
		cardNum = log.getCardNum();
		cardAddr = log.getCardAddr();
		logTime = log.getLogTime();

		name = log.getName();
		idCard = log.getIdCard();
		phone = log.getPhone();

	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCardNum() {
		return cardNum;
	}

	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}

	public String getCardAddr() {
		return cardAddr;
	}

	public void setCardAddr(String cardAddr) {
		this.cardAddr = cardAddr;
	}

	public Date getLogTime() {
		return logTime;
	}

	public void setLogTime(Date logTime) {
		this.logTime = logTime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	

}
