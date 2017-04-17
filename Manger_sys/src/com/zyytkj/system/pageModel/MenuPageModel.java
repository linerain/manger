package com.zyytkj.system.pageModel;

public class MenuPageModel {
	
	private String id;
	private String name;
	private String address;//地址
	private Integer seq;// 序号
	private String type;// 类型 菜单or页面
	private String describe; // 描述
	private String childName;//第一个子页面名称
	private String childAdd;//第一个子页面地址
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public String getChildName() {
		return childName;
	}
	public void setChildName(String childName) {
		this.childName = childName;
	}
	public String getChildAdd() {
		return childAdd;
	}
	public void setChildAdd(String childAdd) {
		this.childAdd = childAdd;
	}
	
	
	
	

}
