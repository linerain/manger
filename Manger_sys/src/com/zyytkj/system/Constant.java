package com.zyytkj.system;

import java.util.Locale;
import java.util.ResourceBundle;

public class Constant {

	public static final String SYSTEM_ANTM="1";
	public static final String SYSTEM_VMS="2";
	public static final String SYSTEM_CMS="3";
	public static final String SYSTEM_WZX="4";
	
	private static ResourceBundle resource = ResourceBundle.getBundle("config",
			Locale.getDefault());

	/**
	 * 构造私有化，此类不需要被实例化
	 */
	private Constant() {
	}
	
	public final static int LOGIN_VERSION=Integer
			.parseInt(resource.getString("login_version"));
	public final static int LABLE_VERSION=Integer
			.parseInt(resource.getString("LABLE_VERSION"));
	
	
}
