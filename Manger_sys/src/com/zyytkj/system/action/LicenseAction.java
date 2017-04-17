package com.zyytkj.system.action;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.dispatcher.multipart.MultiPartRequestWrapper;
import org.springframework.beans.factory.annotation.Autowired;

import com.zyytkj.system.Constant;
import com.zyytkj.system.action.base.BaseAction;
import com.zyytkj.system.cache.LicenceCache;
import com.zyytkj.system.pageModel.Json;
import com.zyytkj.system.service.LicenseServiceI;
import com.zyytkj.system.util.Base64EncryptLicense;
import com.zyytkj.system.util.DesEncryptLicense;

/**
 * license操作类
 * 
 * @author byyang
 *
 */
@SuppressWarnings("all")
@Namespace("/json")
@Action(value = "licenseAction", results = {
		@Result(name = "success", type = "json", params = { "root", "dataMap" }),
		@Result(name = "licenseJsp", location = "/pages/system/license.jsp") })
public class LicenseAction extends BaseAction {

	@Autowired
	private LicenseServiceI licenseService;
	private Map<String, Object> dataMap;
	private File file; // 上传的文件

	private String hostId;

	public String getHostId() {
		return hostId;
	}

	public void setHostId(String hostId) {
		this.hostId = hostId;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}

	public String saveLicense() {
		dataMap = new HashMap<String, Object>();
		StringBuffer licensebuffer = new StringBuffer("");
		String license = null;
		List<String> licenseList = new ArrayList<String>();
		String savePath = servletContext.getRealPath("/license");
		String licenseFilePath = servletContext
				.getRealPath("/license/zyytkj.license");
		File savePathFile = new File(savePath);
		FileReader fr = null;
		// 读取上传文件
		MultiPartRequestWrapper mpRequest = (MultiPartRequestWrapper) request;
		File[] files = mpRequest.getFiles("file"); // 文件现在还在临时目录中
		String[] filename = mpRequest.getFileNames("file");
		if (files == null) {
			dataMap.put("success", false);
			dataMap.put("msg", "上传文件不能为空");
		} else {
			try {
				// 获取后缀名
				String licensename = filename[0].substring(filename[0]
						.lastIndexOf(".") + 1);
				if (!"license".equals(licensename)) {
					dataMap.put("success", false);
					dataMap.put("msg", "文件格式不正确");
				}

				InputStream is = new FileInputStream(files[0]);

				BufferedReader br = new BufferedReader(
						new InputStreamReader(is));

				String str = new String("");
				while ((str = br.readLine()) != null) {
					licensebuffer.append(str);
				}
				byte[] base64 = Base64EncryptLicense
						.decryptBASE64(licensebuffer.toString());
				byte[] base64license = new byte[base64.length];
				for (int i = 0; i < base64.length; i++) {
					base64license[i] = (byte) (base64[i] - 1);
				}
				license = new String(DesEncryptLicense.decrypt(base64license,
						"zyytkjgs"));
				String[] licenseS = license.split(";");
				for (int i = 0; i < licenseS.length; i++) {
					licenseList.add(licenseS[i]);
				}
				if (licenseService.verifyMAC(licenseList)
						&& licenseService.verifyDate(licenseList)
						&& licenseList.get(0).toString()
								.equals(Constant.SYSTEM_CMS)) {
					if (!savePathFile.exists() && !savePathFile.isDirectory()) {
						// 创建目录
						savePathFile.mkdir();
						File licenseFile = new File(licenseFilePath);
						if (licenseFile.exists()) { // 存在就删除
							licenseFile.delete();
						}
						if (!licenseFile.exists()) {// 再创建文件
							try {
								licenseFile.createNewFile();
							} catch (IOException e) {
								e.printStackTrace();
							}
						}
					}
					BufferedWriter bw = new BufferedWriter(new FileWriter(
							licenseFilePath));
					bw.write(licensebuffer.toString());
					LicenceCache.setLicenceCache(licenseList);
					if (bw != null) {
						bw.close();
					}
					if (br != null) {
						br.close();
					}
					if (is != null) {
						is.close();
					}
					dataMap.put("success", true);

					return "success";
				} else {
					dataMap.put("success", false);
					dataMap.put("msg", "license验证不通过，请核对license主机和日期信息");
				}

			} catch (Exception e1) {
				e1.printStackTrace();
				dataMap.put("success", false);
				dataMap.put("msg", "license文件不符合格式，请核对后上传");
			}

		}
		return "success";
	}

	/**
	 * 上传新的授权文件并替换旧授权文件
	 * @return
	 */
	public String  updateLicense() {
		dataMap = new HashMap<String, Object>();
		String savePath = servletContext.getRealPath("/license");
		String licenseFilePath = servletContext.getRealPath("/license/zyytkj.license");
		String msg=licenseService.updateLicense(licenseFilePath, savePath);
		if(msg.equals("success")){
			dataMap.put(msg, true);
			List<String> info = new ArrayList<String>();
			info.add(LicenceCache.getLicenceCache().get(1).equals("NoLimit") ? "无限制" : LicenceCache.getLicenceCache().get(1));
			info.add(LicenceCache.getLicenceCache().get(2).equals("NoLimit") ? "无限制" : LicenceCache.getLicenceCache().get(2));
			info.add(LicenceCache.getLicenceCache().get(3));
			info.add(LicenceCache.getLicenceCache().get(4));
			dataMap.put("info", info);
		}
		else{
			dataMap.put("success", false);
			dataMap.put("msg", msg);
		}
		return "success";
	}
	
	public String licenseAction(){
		return "licenseJsp";
	}
}
