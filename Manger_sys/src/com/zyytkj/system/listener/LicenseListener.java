package com.zyytkj.system.listener;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServlet;

import com.zyytkj.system.Constant;
import com.zyytkj.system.cache.LicenceCache;
import com.zyytkj.system.service.LicenseServiceI;
import com.zyytkj.system.service.impl.LicenseServiceImpl;
import com.zyytkj.system.util.Base64EncryptLicense;
import com.zyytkj.system.util.DesEncryptLicense;
public class LicenseListener extends HttpServlet implements ServletContextListener  {
	private static final long serialVersionUID = 1L;
	//protected  Map<String, Object> application;

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {

	}
	//服务器启动时执行
	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		try{
		LicenseServiceI licenseService = new LicenseServiceImpl();
		String license = licenseService.loadLicense(arg0.getServletContext().getRealPath("/license/zyytkj.license"));		
		List<String> licenseList = new ArrayList<String>();
		if(license != null){
			byte[] base64 = Base64EncryptLicense.decryptBASE64(license);
			byte[] base64license = new byte[base64.length];
			for (int i = 0; i < base64.length; i++) {
				base64license[i] = (byte) (base64[i] - 1);
			}
			String licenseDecrypt = new String(DesEncryptLicense.decrypt(base64license,
					"zyytkjgs"));			
			
			for (int i = 0; i < licenseDecrypt.split(";").length; i++) {
				licenseList.add(licenseDecrypt.split(";")[i]);
			}
            if(licenseService.verifyDate(licenseList) 
    				&& licenseService.verifyMAC(licenseList)&&licenseList.get(0).toString().equals(Constant.SYSTEM_VMS)){
            	LicenceCache.setLicenceCache(licenseList);
            	
            }
		
		}

		}catch(Exception e){
			
		}
	}
	
}
