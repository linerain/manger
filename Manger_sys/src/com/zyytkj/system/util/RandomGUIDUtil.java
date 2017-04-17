/*
 * Created on 2007-1-11
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.zyytkj.system.util;

/**
 * 产生唯一的随机字符串
 * 
 * @author liushy
 * 
 * 
 * Copy right by MOCHASOFT
 * 
 */
public class RandomGUIDUtil {
	/**
	 * 产生唯一的随机字符串
	 * 
	 * @return
	 */
	public static String generateKey() {
		return new RandomGUID(true).toString().replaceAll("-", "");
	}
	
	public static void main(String[] args) {
		System.out.println(RandomGUIDUtil.generateKey());
	}
}