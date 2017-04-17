package com.zyytkj.system.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;

public class FileUtil {
	
	private static final int BUFFER_SIZE = 16 * 1024;
	
	/**
	 * 下载文件
	 * @param request
	 * @param response
	 * @param filePath 文件路径
	 * @param fileName 文件名
	 * @throws Exception
	 */
	public static void download(HttpServletRequest request, HttpServletResponse response,String filePath,String fileName)throws Exception{
	    // path是指欲下载的文件的路径。  
        File file = new File(filePath);  
        if(!file.exists()){
        	throw new Exception("fileNotFindDownloadException");
        }
        // 取得文件的后缀名。  
        String ext = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();  
        
        InputStream fis = null;
        OutputStream os = null;
        try{
        	if("xls".equals(ext)){
        		//设置response的编码方式
    	        response.setContentType("application/msexcel");
        	}else{
        		//纯下载方式
        		response.setContentType("application/x-msdownload");
        	}
	        // 设置response的Header  
		    setFileDownloadHeader(request, response, fileName);
		    response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");   
		    response.setHeader("Pragma", "public"); 
		    response.setBufferSize( 2 * (1024 * 1024));
		    
        	// 以流的形式下载文件。  
	        fis = new BufferedInputStream(new FileInputStream(filePath));  
	        //设置缓存
	        byte[] buffer = new byte[fis.available()];  
	        
	        os = new BufferedOutputStream(response.getOutputStream());
	        long k = 0;
	        while( k < file.length()){
	            int j=fis.read(buffer,0,1024);
	            k+=j;
	            //将b中的数据写到客户端的内存
	            os.write(buffer,0,j);
	        }
	    } catch (IOException ex) {  
//	    	Constant.blog.error("下载文件出错:", ex);
	    }finally{
	       	if(fis !=null){fis.close();}  
	       	if(os !=null){
	       		os.flush();  
	       		os.close();
	       		deleteFile(filePath);
	       	} 
        }
	}
	
	/**
	 * 下载压缩文件
	 * @param request
	 * @param response
	 * @param filePath
	 * @param fileName
	 * @throws Exception
	 */
	public static void downloadZip(HttpServletRequest request, HttpServletResponse response,String filePath,String fileName,List<File> srcfile)throws Exception{
		if(srcfile.size() < 1){
			throw new Exception("zipfile not be finded DownloadException");
		}

		//纯下载方式
		response.setContentType("application/x-msdownload");
	    // 设置response的Header  
	    setFileDownloadHeader(request, response, fileName);
	    response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");   
	    response.setHeader("Pragma", "public"); 
	    response.setBufferSize( 2 * (1024 * 1024));
		
		byte[] buf = new byte[1024];   
		 ZipOutputStream out = null;
        try {   
            // Create the ZIP file   
//            out = new ZipOutputStream(new FileOutputStream(zipfile));
            out = new ZipOutputStream(response.getOutputStream());  
            // Compress the files   
            for (int i = 0; i < srcfile.size(); i++) {   
                File file = srcfile.get(i);   
                FileInputStream in = new FileInputStream(file);   
                // Add ZIP entry to output stream.   
                out.putNextEntry(new ZipEntry(file.getName()));   
                // Transfer bytes from the file to the ZIP file   
                int len;   
                while ((len = in.read(buf)) > 0) {   
                    out.write(buf, 0, len);   
                }   
                out.setEncoding("GB2312");
                out.closeEntry();   
                in.close();   
            }   
        } catch (IOException e) {   
//        	Constant.blog.error("下载文件出错:", e);
        }finally{
        	if(out != null){
        		out.flush();
            	out.close();
            	//删除文件列表
            	deleteFiles(srcfile);
            	//删除zip文件
            	deleteFile(filePath+File.separator+fileName);
        	}
        }
	}
	
	/**
	 * 删除临时文件，只删除文件
	 * @param filePath
	 */
	public static void deleteFile(String filePath){
		if(StringUtils.isNotEmpty(filePath)){
			File file = new File(filePath);
			//如果文件存在，则删除
			if(file.getName().indexOf(".") > 0){
				if(file.exists()){
					file.delete();
				}
			}
		}
	}
	
	/**
	 * 删除文件列表
	 * @param fileList
	 */
	public static void deleteFiles(List<File> fileList){
		if(fileList != null && fileList.size() > 0){
			for(File file : fileList){
				if(file.exists()){
					file.delete();
				}
			}
		}
	}
	
	 /**
	  * 设置下载头
	 * @param request
	 * @param response
	 * @param fileName
	 */
	public static void setFileDownloadHeader(HttpServletRequest request, HttpServletResponse response, String fileName) {
	        final String userAgent = request.getHeader("USER-AGENT");
	        try {
	            String finalFileName = null;
	            if(StringUtils.contains(userAgent, "MSIE")){//IE浏览器
	                finalFileName = URLEncoder.encode(fileName,"UTF8");
	            }else if(StringUtils.contains(userAgent, "Mozilla")){//google,火狐浏览器
	                finalFileName = new String(fileName.getBytes(), "ISO8859-1");
	            }else{
	                finalFileName = URLEncoder.encode(fileName,"UTF8");//其他浏览器
	            }
	            response.setHeader("Content-Disposition", "attachment; filename=\"" + finalFileName + "\"");//这里设置一下让浏览器弹出下载提示框，而不是直接在浏览器中打开
	        } catch (UnsupportedEncodingException e) {
//	        	Constant.blog.error("不支持的字符编码",e);
	        }
	    }
	
	
	 //自己封装的一个把源文件对象复制成目标文件对象
    public static void copy(File src, File dst) {
        InputStream in = null;
        OutputStream out = null;
        try {
            in = new BufferedInputStream(new FileInputStream(src), BUFFER_SIZE);
            out = new BufferedOutputStream(new FileOutputStream(dst),BUFFER_SIZE);
            byte[] buffer = new byte[BUFFER_SIZE];
            int len = 0;
            while ((len = in.read(buffer)) > 0) {
                out.write(buffer, 0, len);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (null != in) {
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (null != out) {
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    /**
     * 获取web工程路径
     * @param request
     * @return
     */
    public static String getAppPath(HttpServletRequest request){
    	return request.getSession().getServletContext().getRealPath(File.separator);
    }

}
