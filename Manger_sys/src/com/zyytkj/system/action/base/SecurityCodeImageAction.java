package com.zyytkj.system.action.base;

import java.io.ByteArrayInputStream;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.interceptor.SessionAware;


import com.zyytkj.system.util.SecurityImage;



/**
 * 生成验证码类
 * 
 * @author 冯京京
 * @company 北京众谊越泰
 * @Date 2015年3月11日
 */
@Namespace("/")
@Action(value="securityCodeImageAction",results={@Result(name="success",type="stream",
		params={"contentType","image/jpeg","inputName","imageStream","bufferSize","2048"})})
public class SecurityCodeImageAction  extends BaseAction implements SessionAware {
	
	private static final long serialVersionUID = 1L;
	// 图片流
	private ByteArrayInputStream imageStream;
	// session域
	private Map<String, Object> session;
	
	public ByteArrayInputStream getImageStream() {
	return imageStream;
	}
	
	public void setImageStream(ByteArrayInputStream imageStream) {
	this.imageStream = imageStream;
	}
	
	public void setSession(Map<String, Object> session) {
	this.session = session;
	}
	
	public String execute() throws Exception {
		String securityCode = SecurityImage.getSecurityCode();
		imageStream = SecurityImage.getImageAsInputStream(securityCode);
		// 放入session中
		session.put("CHECK_NUMBER_KEY", securityCode);
		return "success";
		
	}
	
	

}
