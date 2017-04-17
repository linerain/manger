package com.zyytkj.system.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

/**
 * 修改配置文件工具类
 * @author byyang
 *
 */
public class RepairUtil {
	private static String filePath = System.getProperty("user.dir")+File.separator+"public.properties";

	static{
		File file = new File(filePath);
		//如果文件不存在的话，创建文件，并赋给初始值
		if(!file.exists()){
			try {
				file.createNewFile();
				Properties prop = new Properties();//属性集合对象  
				FileInputStream fis = null;
				//文件输出流
				FileOutputStream fos = null;
				try {
					fis = new FileInputStream(filePath);					
					//属性文件流  
					prop.load(fis);//将属性文件流装载到Properties对象中  
					//修改baseFilePath的属性值
					prop.setProperty("is_repair_data", "true");
					//文件输出流
					fos = new FileOutputStream(filePath);
					//将Properties集合保存到流中
					prop.store(fos, "");
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				}finally{
						if(fis !=null){
							fis.close();
						}
						if(fos !=null ){
							fos.close();
						}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 修改或增加属性
	 * @param key
	 * @param value
	 */
	public static void changePublicValue(String key,String value){
		
		File file = new File(filePath);
		Properties prop = new Properties();//属性集合对象  
		FileInputStream fis = null;
		//文件输出流
		FileOutputStream fos = null;
		try {
			fis = new FileInputStream(filePath);					
			//属性文件流  
			prop.load(fis);//将属性文件流装载到Properties对象中  
			
			//修改baseFilePath的属性值
			prop.setProperty(key, value);
			//文件输出流
			fos = new FileOutputStream(filePath);
			//将Properties集合保存到流中
			prop.store(fos, "");
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				if(fis !=null){
					fis.close();
				}
				if(fos !=null ){
						fos.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**获取属性值
	 * @param key
	 * @return
	 */
	public static String getPublicValue(String key){
		Properties prop = new Properties();//属性集合对象  
		FileInputStream fis = null;
		//文件输出流
		try {
			fis = new FileInputStream(filePath);					
			//属性文件流  
			prop.load(fis);//将属性文件流装载到Properties对象中  
			Object obj = prop.get(key);
			if(obj != null){
				return (String)obj;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				if(fis !=null){
					fis.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return "";
	}
	
}
