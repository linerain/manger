package com.zyytkj.system.util;

import java.io.*;
import java.lang.reflect.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.text.SimpleDateFormat;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;

/**
 * 
 * @author byyang
 * @version v1.0
 * @param <T>
 *            应用泛型，代表任意一个符合javabean风格的类
 *            注意这里为了简单起见，boolean型的属性xxx的get器方式为getXxx(),而不是isXxx()
 *            byte[]表jpg格式的图片数据
 */
public class ExportExcel<T> {

	public void exportExcel(String title,Collection<T> dataset, String filePath) {
		exportExcel(title, null, dataset, filePath, "yyyy-MM-dd HH:mm:ss");
	}

	public void exportExcel(String title,String[] headers, Collection<T> dataset,
			String filePath) {
		exportExcel(title, headers, dataset, filePath, "yyyy-MM-dd HH:mm:ss");
	}

	/**
	 * 这是一个通用的方法，利用了JAVA的反射机制，可以将放置在JAVA集合中并且符合一定条件的数据以EXCEL 的形式输出到指定IO设备上
	 * 
	 * @param title
	 *            表格标题名
	 * @param headers
	 *            表格属性列名数组
	 * @param dataset
	 *            需要显示的数据集合,集合中一定要放置符合javabean风格的类的对象。此方法支持的
	 *            javabean属性的数据类型有基本数据类型及String,Date,byte[](图片数据)
	 * @param filePath
	 *            根据给定的路径，创建输出设备关联的流对象，可以将EXCEL文档导出到本地文件或者网络中
	 * @param pattern
	 *            如果有时间数据，设定输出格式。默认为"yyyy-MM-dd HH:mm:ss"
	 * @return file 返回生成的文件
	 */
	@SuppressWarnings("unchecked")
	public File exportExcel(String title, String[] headers,
			Collection<T> dataset, String filePath, String pattern) {
		//定义时间格式化对象
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		// 声明一个工作薄
		HSSFWorkbook workbook = new HSSFWorkbook();
		// 生成一个表格
		HSSFSheet sheet = workbook.createSheet(title);
		// 设置表格默认列宽度为15个字节
		sheet.setDefaultColumnWidth((short) 15);
		// 生成一个样式
		HSSFCellStyle style = workbook.createCellStyle();
		// 设置这些样式
		style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		// 生成一个字体
		HSSFFont font = workbook.createFont();
		font.setColor(HSSFColor.VIOLET.index);
		font.setFontHeightInPoints((short) 12);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		// 把字体应用到当前的样式
		style.setFont(font);
		// 生成并设置另一个样式
		HSSFCellStyle style2 = workbook.createCellStyle();
		style2.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
		style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		// 生成另一个字体
		HSSFFont font2 = workbook.createFont();
		font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
		// 把字体应用到当前的样式
		style2.setFont(font2);

		// 声明一个画图的顶级管理器
		HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
		// 定义注释的大小和位置,详见文档
		HSSFComment comment = patriarch.createComment(new HSSFClientAnchor(0,
				0, 0, 0, (short) 4, 2, (short) 6, 5));
		// 设置注释内容
		comment.setString(new HSSFRichTextString("可以在POI中添加注释！"));
		// 设置注释作者，当鼠标移动到单元格上是可以在状态栏中看到该内容.
		comment.setAuthor("leno");

		// 产生表格标题行
		HSSFRow row = sheet.createRow(0);
		for (short i = 0; i < headers.length; i++) {
			HSSFCell cell = row.createCell(i);
			cell.setCellStyle(style);
			HSSFRichTextString text = new HSSFRichTextString(headers[i]);
			cell.setCellValue(text);
		}
		// 遍历集合数据，产生数据行
		Iterator<T> it = dataset.iterator();
		int index = 0;
		while (it.hasNext()) {
			index++;
			row = sheet.createRow(index);
			T t = (T) it.next();
			// 利用反射，根据javabean属性的先后顺序，动态调用getXxx()方法得到属性值
			Field[] fields = t.getClass().getDeclaredFields();
			for (short i = 0; i < fields.length; i++) {
				HSSFCell cell = row.createCell(i);
				cell.setCellStyle(style2);
				Field field = fields[i];
				String fieldName = field.getName();
				String getMethodName = "get"
						+ fieldName.substring(0, 1).toUpperCase()
						+ fieldName.substring(1);
				try {
					Class tCls = t.getClass();
					Method getMethod = tCls.getMethod(getMethodName,new Class[] {});
					Object value = getMethod.invoke(t, new Object[] {});
					if(value != null){
						// 判断值的类型后进行强制类型转换
						String textValue = null;
						if (value instanceof Date) {
							Date date = (Date) value;
							textValue = sdf.format(date);
						} else if (value instanceof byte[]) {
							// 有图片时，设置行高为60px;
							row.setHeightInPoints(60);
							// 设置图片所在列宽度为80px,注意这里单位的一个换算
							sheet.setColumnWidth(i, (short) (35.7 * 80));
							// sheet.autoSizeColumn(i);
							byte[] bsValue = (byte[]) value;
							HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0,
									1023, 255, (short) 6, index, (short) 6, index);
							anchor.setAnchorType(2);
							patriarch.createPicture(anchor, workbook.addPicture(
									bsValue, HSSFWorkbook.PICTURE_TYPE_JPEG));
						} else {
							// 其它数据类型都当作字符串简单处理
							textValue = value.toString();
						}
						// 如果不是图片数据，就利用正则表达式判断textValue是否全部由数字组成
						if (textValue != null) {
							Pattern p = Pattern.compile("^//d+(//.//d+)?$");
							Matcher matcher = p.matcher(textValue);
							if (matcher.matches()) {
								// 是数字当作double处理
								cell.setCellValue(Double.parseDouble(textValue));
							} else {
								HSSFRichTextString richString = new HSSFRichTextString(
										textValue);
								HSSFFont font3 = workbook.createFont();
								font3.setColor(HSSFColor.BLUE.index);
								richString.applyFont(font3);
								cell.setCellValue(richString);
							}
						}
					}
				} catch (SecurityException e) {
					e.printStackTrace();
				} catch (NoSuchMethodException e) {
					e.printStackTrace();
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				} finally {
					// 清理资源
				}
			}
		}
		//使用文件输出流将数据写入excel文件中
		OutputStream out = null;
		try {
			if (filePath != null && !"".equals(filePath)) {
				out = new FileOutputStream(filePath);
				workbook.write(out);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null) {
					out.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return new File(filePath);
	}
	
	/**
	 * 大数据时，生成多个excel，最后生成压缩文件
	 * @param title
	 * @param headers
	 * @param dataset
	 * @param filePath
	 * @param pattern
	 * @param pageNum 每页的数量
	 */
	public List<File> batchExportFile(String title, String[] headers,
			List<T> dataset, String fileDir,String fileName, String pattern,int pageNum){
		List<File> fileList = new ArrayList<File>();
		if(dataset != null && dataset.size() > 0){
			int total = dataset.size();
			int page = 0; //一共有多少页
			if((total % pageNum) > 0){
				 page = (total / pageNum) + 1;
			}else{
				page = (total / pageNum);
			}
			//将数据分页导出成文件，返回文件集合
			String filePath = "";
			for(int curPage = 0; curPage < page; curPage++){
				List<T> partList = null;
				if(curPage < (page - 1)){
					partList = dataset.subList(pageNum*curPage, (curPage + 1)*pageNum);
				}else if(curPage == (page -1)){
					partList = dataset.subList(pageNum*curPage, dataset.size());
				}
				filePath = fileDir + File.separator + (curPage+1)+"_"+fileName;
				fileList.add(exportExcel(title, headers, partList, filePath, pattern));
			}
		}
		return fileList;
	}
	

	/**
	 * 根据图片路径将图片信息转换成byte信息
	 * 
	 * @param filePath
	 * @return
	 */
	public byte[] picToByte(String filePath) {
		BufferedInputStream bis = null;
		byte[] buf = null;
		try {
			bis = new BufferedInputStream(new FileInputStream(filePath));
			buf = new byte[bis.available()];
			// 往字节数组中写入图片信息
			while ((bis.read(buf)) != -1) {
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return buf;
	}
	
	public static void main(String[] args) {
		List<String> varList = new ArrayList<String>();
		varList.add("1");
		varList.add("2");
		varList.add("3");
		varList.add("4");
		varList.add("5");
		varList.add("6");
		
		int total = varList.size();
		int pageNum = 2;
		int page = 0;
		if((total % pageNum) > 0){
			 page = (total / pageNum) + 1;
		}else{
			page = (total / pageNum);
		}
		System.out.println("page:"+page);
		for(int curPage = 0; curPage < page; curPage++){
			List<String> partList = null;
			if(curPage < (page - 1)){
				partList = varList.subList(pageNum*curPage, (curPage + 1)*pageNum);
			}else if(curPage == (page -1)){
				partList = varList.subList(pageNum*curPage, varList.size());
			}
			for(String var : partList){
				System.out.println(var);
			}
			System.out.println("------------------------------------------");
		}
		
	}
	
}