package com.zyytkj.system.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 常量类
 * 
 * @author 谭锦华
 * @company 北京众谊越泰科技
 * @Date 2015年5月16日
 */
public final class ConstantUtil {

	public static Boolean VMS_ACCESS;
	public static String LABLE_VERSION;
	// public static int EXPIRATION_TIME;

	static {
		Properties prop = new Properties();
		try {
			ConstantUtil con = new ConstantUtil();

			InputStream in = new BufferedInputStream(new FileInputStream(con.getClass().getClassLoader().getResource("/").getPath() + "config.properties"));
			prop.load(in);
			VMS_ACCESS = prop.getProperty("VMS_ACCESS").trim().endsWith("1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	static {
		Properties prop = new Properties();
		try {
			ConstantUtil con = new ConstantUtil();

			InputStream in = new BufferedInputStream(new FileInputStream(con.getClass().getClassLoader().getResource("/").getPath() + "config.properties"));
			prop.load(in);
			LABLE_VERSION = prop.getProperty("LABLE_VERSION");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// static {
	// Properties prop = new Properties();
	// try {
	// ConstantUtil con = new ConstantUtil();
	//
	// InputStream in = new BufferedInputStream (new
	// FileInputStream(con.getClass().getClassLoader().getResource("/").getPath()+"config.properties"));
	// prop.load(in);
	// EXPIRATION_TIME = Integer.parseInt(prop.getProperty("EXPIRATION_TIME"));
	// } catch (IOException e) {
	// e.printStackTrace();
	// }
	// }

	public static void main(String[] args) {
		System.out.println(ConstantUtil.LABLE_VERSION);
	}

}
