package com.zyytkj.system.service;

import java.util.List;

/**
 * License服务层
 * 
 * @author Alich
 */
public interface LicenseServiceI {

	public String loadLicense(String savePath);

	public void saveLicense(String license,String savePath);

	public boolean verifyMAC(List<String> licenseList);

	public boolean verifyDate(List<String> licenseList);

	public String  updateLicense(String licensePath,String savePath);
}
