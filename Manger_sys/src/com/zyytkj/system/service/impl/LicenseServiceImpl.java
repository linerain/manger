package com.zyytkj.system.service.impl;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.text.ParseException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zyytkj.system.Constant;
import com.zyytkj.system.cache.LicenceCache;
import com.zyytkj.system.service.LicenseServiceI;
import com.zyytkj.system.util.Base64EncryptLicense;
import com.zyytkj.system.util.DesEncryptLicense;
import com.zyytkj.system.util.MacAddressUtil;

/**
 * 设备业务服务实现类
 * 
 * @author byyang
 * 
 */
@Service("licenseService")
@Transactional
public class LicenseServiceImpl implements LicenseServiceI {
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	@Override
	public String loadLicense(String savePath) {
		File file = new File(savePath);
		if (!file.exists()) {
			return null;
		}
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new FileReader(file));
			return reader.readLine();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				reader.close();
			} catch (IOException e) {
			}
		}
		return null;
	}

	@Override
	public void saveLicense(String license,String savePath) {
		FileWriter writer = null;
		try {
			writer = new FileWriter(new File(savePath));
			writer.write(license);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				writer.close();
			} catch (IOException e) {
			}
		}
	}
	
	@SuppressWarnings("unused")
	@Override
	/**
	 * 上传新的授权文件并替换旧授权文件，并刷新缓存
	 */
	public String   updateLicense(String licensePath/*新上传授权文件路径*/,
			String savePath/*旧授权文件路径以及新上传文件位置*/){
		
		StringBuffer licensebuffer = new StringBuffer("");
		List <String> licenseList=new ArrayList<String>();
		String license=null;
		
		//校验新上传文件
		File upFile=new File(licensePath);
		if(upFile==null){
			return "文件不能为空！";
		}
		else{
			String fileName=upFile.getName();
			fileName=fileName.substring(fileName.lastIndexOf('.'));
			if(!"license".equals(fileName)){
				return "文件格式不正确！";
			}
		}
		
		//上传授权文件
		try {
			InputStream is = new FileInputStream(upFile);
			BufferedReader br = new BufferedReader(new InputStreamReader(is));
			
			String str = new String("");
			while ((str = br.readLine()) != null) {
				licensebuffer.append(str);
			}
			byte[] base64 = Base64EncryptLicense.decryptBASE64(licensebuffer.toString());
			byte[] base64license = new byte[base64.length];
			for (int i = 0; i < base64.length; i++) {
				base64license[i] = (byte) (base64[i] - 1);
			}
			license = new String(DesEncryptLicense.decrypt(base64license, "zyytkjgs"));
			licenseList.add(license);
			
			//验证Mac地址、是否过期
			if (verifyMAC(licenseList) && verifyDate(licenseList)
					&& licenseList.get(0).toString().equals(Constant.SYSTEM_CMS)){
				
				//文件路径是否正确
				File filePath=new File(savePath);
				if(!filePath.exists() || !filePath.isDirectory()){
					return "原授权文件路径错误！";
				}
				else{
					File fileLicensePath=new File(savePath+"/"+upFile.getName());
					//存在即删除
					if(fileLicensePath.exists()){
						fileLicensePath.delete();
					}
					//创建新文件
					if(!fileLicensePath.exists()){
						fileLicensePath.createNewFile();
					}
					//写入
					BufferedWriter bw = new BufferedWriter(new FileWriter(fileLicensePath));
					bw.write(licensebuffer.toString());
					//刷新缓存
					LicenceCache.setLicenceCache(licenseList);
					if (bw != null) {
						bw.close();
					}
				}
			}
			if (br != null) {
				br.close();
			}
			if (is != null) {
				is.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	/**
	 * 验证主机是否匹配(本机MAC地址)
	 * 
	 * @param entity
	 * @return
	 */
	public boolean verifyMAC(List<String> licenseList) {
			MacAddressUtil MAC=new MacAddressUtil();
			List<String> macList=MAC.getLocalMacAddress();
			String mac=licenseList.get(3);
			for(String str:macList){
				if(str.toUpperCase().equals(mac.toUpperCase())){
					return true;
				}
			}
		return false;
	}

	/**
	 * 验证是否在有效期
	 * 
	 * @param entity
	 * @return
	 */
	public boolean verifyDate(List<String> licenseList) {
		String date=licenseList.get(1);
		if(!date.equals("NoLimit")){
			try {
				if(sdf.parse(date).getTime() > System.currentTimeMillis()){
					return true;
				}
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		else{
			return true;
		}
		return false;
	}

}
