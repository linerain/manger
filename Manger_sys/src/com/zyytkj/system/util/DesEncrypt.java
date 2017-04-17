package com.zyytkj.system.util;

import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
/**
 * DES
 * @author 谭锦华
 * @company 北京众谊越泰科技
 * @Date 2015年3月17日
 */
public class DesEncrypt {

	private static String str="((((((((";
	/**
	 * 加密
	 * @param password  密码
	 * @param str  加密需要的8的倍数的字符串
	 * @return
	 */
	public static byte[] desCrypto(byte[] password) {
		try {
			SecureRandom random = new SecureRandom();
			DESKeySpec desKey = new DESKeySpec(str.getBytes());
			// 创建一个密匙工厂，然后用它把DESKeySpec转换成
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
			SecretKey securekey = keyFactory.generateSecret(desKey);
			// Cipher对象实际完成加密操作
			Cipher cipher = Cipher.getInstance("DES");
			// 用密匙初始化Cipher对象
			cipher.init(Cipher.ENCRYPT_MODE, securekey, random);
			// 现在，获取数据并加密
			// 正式执行加密操作
			return cipher.doFinal(password);
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 解密
	 * @param password
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public static byte[] decrypt(byte[] password) throws Exception {
		// DES算法要求有一个可信任的随机数源
		SecureRandom random = new SecureRandom();
		// 创建一个DESKeySpec对象
		DESKeySpec desKey = new DESKeySpec(str.getBytes());
		// 创建一个密匙工厂
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		// 将DESKeySpec对象转换成SecretKey对象
		SecretKey securekey = keyFactory.generateSecret(desKey);
		// Cipher对象实际完成解密操作
		Cipher cipher = Cipher.getInstance("DES");
		// 用密匙初始化Cipher对象
		cipher.init(Cipher.DECRYPT_MODE, securekey, random);
		// 真正开始解密操作
		return cipher.doFinal(password);
	}
	
	public static void main(String[] args) {
	    //待加密内容  
	    String str = "admin";
	    //长度要是8的倍数  
	    SecureRandom random = new SecureRandom();
	    System.out.println(random.toString());
	    SecureRandom randoms = new SecureRandom();
	    System.out.println(randoms.equals(random));
	   
	    try {
	    	
	    	 //DES加密。
	    	 byte[] result =desCrypto(str.getBytes());  
	    	 for(byte b:result){
	    		 System.out.print(b+" ");
	    	 }
	    	 //用BASE64进行包装
			 String baseResult= Base64Encrypt.encryptBASE64(result);
			 System.out.println("加密后内容为："+baseResult);  
			 
			   //用BASE进行解包
			   byte[] bytes=Base64Encrypt.decryptBASE64(baseResult);
			   for(byte b:bytes){
		    		 System.out.print(b+" ");
		    	 }
			   //用DES进行解密
			   String strs =new String(decrypt(bytes));
			    System.out.println("解密后内容为："+strs);  
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
