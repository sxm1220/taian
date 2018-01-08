package com.thinkgem.jeesite.modules.vehcile.util;


/**
 * 查验监管webservice接口
 * @author Administrator
 *
 */
public interface CyjgWebservice {
	/*查询类接口*/
	public String queryObjectOut(String xtlb , String jkxlh ,String jkid ,String queryXml);
	/*写入类类接口*/
	public String writeObjectOut(String xtlb , String jkxlh ,String jkid ,String queryXml);
}
