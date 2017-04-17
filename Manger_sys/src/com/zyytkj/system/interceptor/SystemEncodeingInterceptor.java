package com.zyytkj.system.interceptor;

import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.StrutsStatics;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

@SuppressWarnings("all")
public class SystemEncodeingInterceptor  extends MethodFilterInterceptor {
	private static final long serialVersionUID = 1L;

	protected String doIntercept(ActionInvocation arg0) throws Exception {

		ActionContext actionContext = arg0.getInvocationContext();
		HttpServletRequest httpServletRequest = (HttpServletRequest) actionContext
				.get(StrutsStatics.HTTP_REQUEST);
		// 获得Request数据  
        Map<String, Object> request = actionContext.getParameters(); 
		
		
		/**
		 * 此方法体对GET 和 POST方法均可
		 * 
		 */

	        // 遍历  
	        for (String key : request.keySet()) {  
	            String[] values = (String[]) request.get(key);  
	            // 遍历所有值  
	            for (int i = 0; i < values.length; i++) {  
	                values[i] = convert(httpServletRequest,values[i]);  
	            }  
	            request.put(key, values);  
	        }  
	        actionContext.setParameters(request);

		    return arg0.invoke();
	}
    private String convert(HttpServletRequest httpServletRequest,String value){
    	String returnString="";
    	try{
    	 if (httpServletRequest.getHeader("User-Agent").toLowerCase()  
	                .indexOf("firefox") > 0) {  
    		 returnString = new String(value.getBytes("ISO-8859-1"),"utf-8"); // firefox浏览器  
	        } else if (httpServletRequest.getHeader("User-Agent").toUpperCase()  
	                .indexOf("MSIE") > 0) {  
	        	returnString = new String(value.getBytes("ISO-8859-1"),"GBK");// IE8浏览器 
	        }else if (httpServletRequest.getHeader("User-Agent").toUpperCase()  
	                .indexOf("CHROME") > 0) {  
	        	returnString = new String(value.getBytes("ISO-8859-1"),"utf-8");// 谷歌  
	        }else{
	        	returnString=new String(value.getBytes("ISO-8859-1"),"GBK");
	        }
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	 return returnString;
    }
}
