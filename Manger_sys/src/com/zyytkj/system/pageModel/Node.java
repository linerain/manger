package com.zyytkj.system.pageModel;

import java.util.List;
import java.util.Map;

/** 
 * @author 白云
 * @company 北京众谊越泰科技
 * @Date 2015年3月13日
 * 
 */

public class Node {
	
	private String id; //节点ID
	private String name;//节点文本
	private String state; //节点状态
	private String iconCls;//节点icon
	private Boolean checked;//是否选中
	
	private String pid; //父几点ID
	private String ptext; //父节点文本
	
	private List<Node> children; //子节点列表  children
	
	private Map<String, Object> attributes; //自定义属性
	
	private String address;//地址
	private String describe;//描述
	private String coding;//编码
	private String type;//类型
	private Integer seq;//序列号
	private Boolean isTerritory;//是否为地域
	private Boolean isRoom;//是否是机房
	private Boolean isOther;//是否是其他
	private Boolean isDevice;//是否为机柜
	private Boolean isBranch;//是否是营业网点
	private String icon;//图标存放地址
	
	
	
	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}
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
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getIconCls() {
		return iconCls;
	}
	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getPtext() {
		return ptext;
	}
	public void setPtext(String ptext) {
		this.ptext = ptext;
	}
	public Map<String, Object> getAttributes() {
		return attributes;
	}
	public void setAttributes(Map<String, Object> attributes) {
		this.attributes = attributes;
	}
	public List<Node> getChildren() {
		return children;
	}
	public void setChildren(List<Node> children) {
		this.children = children;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public Boolean getChecked() {
		return checked;
	}
	public void setChecked(Boolean checked) {
		this.checked = checked;
	}
	public String getCoding() {
		return coding;
	}
	public void setCoding(String coding) {
		this.coding = coding;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public Boolean getIsRoom() {
		return isRoom;
	}
	public void setIsRoom(Boolean isRoom) {
		this.isRoom = isRoom;
	}
	
	public Boolean getIsOther() {
		return isOther;
	}
	public void setIsOther(Boolean isOther) {
		this.isOther = isOther;
	}
	public Boolean getIsDevice() {
		return isDevice;
	}
	public void setIsDevice(Boolean isDevice) {
		this.isDevice = isDevice;
	}
	public Boolean getIsTerritory() {
		return isTerritory;
	}
	public void setIsTerritory(Boolean isTerritory) {
		this.isTerritory = isTerritory;
	}
	public Boolean getIsBranch() {
		return isBranch;
	}
	public void setIsBranch(Boolean isBranch) {
		this.isBranch = isBranch;
	}
	
	
	
}
