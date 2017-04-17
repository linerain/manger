package com.zyytkj.system.util;

import java.net.NetworkInterface;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

/**
 * Mac地址工具类
 * 
 * @author 孙宇
 * 
 */
public class MacAddressUtil {

	/**
	 * 获取本机全部MAC地址
	 * @return
	 */
	public List<String> getLocalMacAddress(){
		List<String> macAddressList=new ArrayList<String>();

		
		
		Enumeration allNetInterfaces = null;  
        try {  
            allNetInterfaces = NetworkInterface.getNetworkInterfaces();  
            while (allNetInterfaces.hasMoreElements()){
            	NetworkInterface netInterface = (NetworkInterface) allNetInterfaces  
                        .nextElement();  

				byte[] mac=netInterface.getHardwareAddress();
				if(mac!=null && mac.length==6){
				StringBuffer sb = new StringBuffer("");

				for(int i=0; i<mac.length; i++) {

					if(i!=0) {

						sb.append("-");

					}

					//字节转换为整数

					int temp = mac[i]&0xff;

					String str = Integer.toHexString(temp);


					if(str.length()==1) {

						sb.append("0"+str);

					}else {

						sb.append(str);

					}

				}
				macAddressList.add(sb.toString().toUpperCase());
				}
			
            }
            
        } catch (java.net.SocketException e) {  
            e.printStackTrace();  
        }  

		


	
		
		return macAddressList;
		
	}
	
}
