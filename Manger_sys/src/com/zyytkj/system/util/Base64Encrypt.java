package com.zyytkj.system.util;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;


/**
 * Base64对数据的加密解密。  通用的于email之类的通讯
 * @author 谭锦华
 * @company 北京众谊越泰科技
 * @Date 2015年3月17日
 */
public class Base64Encrypt {
	
	/** 
	 * BASE64解密 
	 *  
	 * @param key 
	 * @return 
	 * @throws Exception 
	 */  
	public static byte[] decryptBASE64(String key) throws Exception {  
	    return (new BASE64Decoder()).decodeBuffer(key);  
	}  
	
	
	/**
	 * 加密算法
	 * @param key
	 * @return
	 * @throws Exception
	 */
	 
	public static String encryptBASE64(byte[] key) throws Exception {  
	    return (new BASE64Encoder()).encodeBuffer(key);  
	} 
	
	
	
	
}
