package com.zyytkj.system.util;




public class Tooles {

	
	public String toAsc(String inString){
		StringBuffer sb=new StringBuffer();
		for(int i=0;i<inString.length();i++){
			int ch = (int)inString.charAt(i); 
			if(Integer.toHexString(ch).toString().equals("a")){
				sb.append("0").append(Integer.toHexString(ch).toString());	
			}else{
			sb.append(Integer.toHexString(ch).toString());
			}
		}
		return sb.toString();
	}

	
	public static String getTable(String dev_id,String table){
		int value;
		if(Math.abs(dev_id.hashCode() %100)==0){
			value=100;
		}else{
			value=Math.abs(dev_id.hashCode() %100);
		}
		return table+"_"+value;
	}
	
	public static void main(String[] args) {
		
		System.out.println(getTable("402881a3516b1a6801516b1d7d040001","antm_devListData"));
		
	}
	
}
