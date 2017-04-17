package com.zyytkj.system.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 系统日志
 * 
 * @author 黄超
 * @company 北京众谊越泰科技
 * @Date 2015年3月11日
 */
@Entity
@Table(name = "sys_log")
public class SystemLog {
	@Id
	@Column(name = "ID", length = 32)
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	private String id;
	@Column
	private String userName;// 用户名称
	@Column
	private String userCount;// 用户账号
	@Column(length = 1024)
	private String action;// 操作行为
	@Column(name = "date_time")
	private Date datetime;// 时间
	@Column(length = 16)
	private String ip;// 登陆IP
	@Column(length = 32)
	private String type;// 对应模块
	@Column(length = 2048,name = "details_content")
	private String details;// 操作类型

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public Date getDatetime() {
		return datetime;
	}

	public void setDatetime(Date datetime) {
		this.datetime = datetime;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserCount() {
		return userCount;
	}

	public void setUserCount(String userCount) {
		this.userCount = userCount;
	}

}
