package com.cn.hnust.controller;


/**
 * 查验监管webservice接口
 * @author Administrator
 *
 */
public interface CopyOfCyjgWebservice {
	/*查询类接口*/
	public String queryObjectOut(String xtlb , String jkxlh ,String jkid ,String queryXml);
	/*写入类类接口*/
	public String writeObjectOut(String xtlb , String jkxlh ,String jkid ,String queryXml);
}
