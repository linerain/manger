package com.zyytkj.system.util;

import java.io.*;
import java.util.zip.*;
/**
 * 程序实现了ZIP压缩。共分为2部分 ：
 * 压缩（compression）与解压（decompression）
 * <p>
 * 大致功能包括用了多态，递归等JAVA核心技术，可以对单个文件和任意级联文件夹进行压缩和解压。
 * 需在代码中自定义源输入路径和目标输出路径。
 * <p>
 * 在本段代码中，实现的是解压部分；压缩部分见本包中compression部分。
 * @author HAN
 *
 */
public class Zip {
	
//	public static void main(String[] args) {
//	
//           extractZip("D:\\updateClient.zip","D:\\updateClient");
//			
//		
//	}
	
	public static boolean extractZip(String zipPath,String extractPath){
        boolean flag=false;
		try {
			ZipInputStream Zin=new ZipInputStream(new FileInputStream(zipPath));//输入源zip路径
			BufferedInputStream Bin=new BufferedInputStream(Zin);
			
			File Fout=null;
			ZipEntry entry;
			try {
				while((entry = Zin.getNextEntry())!=null && !entry.isDirectory()){
					Fout=new File(extractPath,entry.getName());
					if(!Fout.exists()){
						(new File(Fout.getParent())).mkdirs();
					}
					FileOutputStream out=new FileOutputStream(Fout);
					BufferedOutputStream Bout=new BufferedOutputStream(out);
					int b;
					while((b=Bin.read())!=-1){
						Bout.write(b);
					}
					Bout.close();
					out.close();
					flag=true;
				}
				Bin.close();
				Zin.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	return flag;
		
	}

}

