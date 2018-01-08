package com.thinkgem.jeesite.modules.vehcile.util;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println( strToDate(strToDate("2015-11-01")));
	}
	
	/**
	   * 将短时间格式字符串转换为时间 yyyy-MM-dd 
	   * 
	   * @param strDate
	   * @return
	   */
	public static Date strToDate(String strDate) {
	   SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	   ParsePosition pos = new ParsePosition(0);
	   Date strtodate = formatter.parse(strDate, pos);
	   return strtodate;
	}
	
	public static String strToDate(Date date) {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy年MM月dd日");
		   String dateString = formatter.format(date);
		   return dateString;
		}
		
}
