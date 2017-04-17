package com.zyytkj.system.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;


/**
 * 上传、下载文件工具类
 * 
 * @author 白云
 * 
 */
public class UploadOrDownLoad {

	/**
	 * 	上传文件
	 * 
	 * @methodName:saveUpload
	 * 
	 * @param image
	 * 			页面上的上传框
	 * @param imageFileName 
	 * 					上传的文件名
	 * @param imageContentType
	 * 					上传文件类型
	 * @author 
	 * 			白云
	 * @return
	 * 		文件地址：上传成功，null：上传失败。
	 */
	public static String saveUpload(File[] upload,String[] uploadFileName,String[] uploadContentType) {
		String address = "";
		try {
			//得到上传文件的保存目录
			String realpath = ServletActionContext.getServletContext().getRealPath("/upload");
			if (upload != null) {
				if(uploadFileName!=null){
					  for(int i = 0; i < uploadFileName.length; i++){
			            	//防止文件名重复，uuid
			            	String fileName = UUID.randomUUID().toString() + "__" + uploadFileName[i];
			            	// 得到文件的保存目录
							String realSavePath = makePath(fileName, realpath);
							//创建一个文件地址
				            File savedir=new File(realSavePath);
				            if(!savedir.getParentFile().exists())
				                savedir.getParentFile().mkdirs();
			            	//创建文件上传地址+文件名
			            	File savefile = new File(savedir, fileName);
			            	//复制文件到上传地址中
			            	FileUtils.copyFile(upload[i], savefile);
			            	//数据库存储文件路径
			            	if(i == uploadFileName.length - 1){
			            		address += savedir+"\\"+fileName;
			            	}else{
			            		address += savedir+"\\"+fileName+",";
			            	}
			            }
				}
	        }
		} catch (UnsupportedEncodingException e) {
			System.out.println("上传文件异常"+e.getMessage());
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
        return address;
    }

	/**
	 * 下载文件
	 * 
	 * @param fileName
	 * 			文件名
	 * @param response
	 * 			相应
	 * @author 
	 * 			白云
	 * @return
	 * 		是否成功
	 */
	public static String downLoad(String filePath, HttpServletResponse response){
		String msg = "";
    	try {
    		// 得到要下载的文件名，解决乱码
    		//filePath = "E:\\1001__aa.txt";
    		filePath = java.net.URLDecoder.decode(filePath,"UTF-8"); 
        	// 得到要下载的文件
        	// 处理文件名
        	String realname = filePath.substring(filePath.lastIndexOf("__") + 2);
        	// 设置响应头，控制浏览器下载该文件
        	response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(realname, "UTF-8"));
        	// 读取要下载的文件，保存到文件输入流
        	FileInputStream in = new FileInputStream(filePath);
        	
        	// 创建输出流
        	OutputStream out = response.getOutputStream();
        	// 创建缓冲区
        	byte buffer[] = new byte[1024];
        	int len = 0;
        	// 循环将输入流中的内容读取到缓冲区当中
        	while ((len = in.read(buffer)) > 0) {
        		// 输出缓冲区的内容到浏览器，实现文件下载
        		out.write(buffer, 0, len);
        	}
        	// 关闭文件输入流
        	in.close();
        	// 关闭输出流
        	out.close();
		} catch (Exception e) {
			 e.getMessage();
		}
		return msg;
	}
	/**
	 * 删除文件
	 * @param 
	 * 		fileName
	 * @return 
	 * 		是否成功
	 */
	 public static boolean deleteFile(String filePath){
		 boolean flag = true;
		 //filePath = "E:\\1001__aa.txt";
 			try {
				filePath = java.net.URLDecoder.decode(filePath,"UTF-8");
				File file=new File(filePath);  
		        if(file.exists()){  
		            file.delete();
		        } 
			} catch (UnsupportedEncodingException e) {
				flag = false;
				e.printStackTrace();
			} 
	         
	        return flag;  
	    }  
	
	/**
	 * 为防止一个目录下面出现太多文件，要使用hash算法打散存储
	 * 
	 * @Anthor:白云
	 * 
	 * @param filename
	 *            文件名，要根据文件名生成存储目录
	 * @param savePath
	 *            文件存储路径
	 * @return 新的存储目录
	 */
	public static String makePath(String filename, String savePath) {
		// 得到文件名的hashCode的值，得到的就是filename这个字符串对象在内存中的地址
		int hashcode = filename.hashCode();
		int dir1 = hashcode & 0xf; // 0--15
		int dir2 = (hashcode & 0xf0) >> 4; // 0-15
		// 构造新的保存目录
		String dir = savePath + "\\" + dir1 + "\\" + dir2; // upload\2\3
															// upload\3\5
		// File既可以代表文件也可以代表目录
		File file = new File(dir);
		// 如果目录不存在
		if (!file.exists()) {
			// 创建目录
			file.mkdirs();
		}
		return dir;
	}

	
}
