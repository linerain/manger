package com.zyytkj.manger.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "manger_log")
public class GetMoneyLog {
	@Id
	@Column(name = "ID", length = 32)
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	String id;
	@Column(length = 32)
	String userId;
	@Column
	Double money;
	@Column
	Integer state;// 0ask ,1yes ,2No
	@Column(length = 200)
	String cardNum;
	@Column(length = 200)
	String cardAddr;
	@Column(length = 2000)
	String remark;
	@Column
	Date logTime;
	
	@Column(length = 200)
	String name;
	@Column(length = 200)
	String idCard;
	@Column(length = 200)
	String phone;
	

	public GetMoneyLog() {
		super();
	}


	





	public GetMoneyLog(String userId, Double money, Integer state, String cardNum, String cardAddr, Date logTime,String name,String idCard,String phone) {
		super();
		this.userId = userId;
		this.money = money;
		this.state = state;
		this.cardNum = cardNum;
		this.cardAddr = cardAddr;
		this.logTime = logTime;
		this.name = name;
		this.idCard = idCard;
		this.phone = phone;
	}








	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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








	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getId() {
		return id;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Date getLogTime() {
		return logTime;
	}

	public void setLogTime(Date logTime) {
		this.logTime = logTime;
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

}
