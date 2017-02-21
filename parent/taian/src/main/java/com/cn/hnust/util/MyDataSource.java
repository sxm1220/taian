package com.cn.hnust.util;

import java.sql.SQLException;
import java.sql.SQLFeatureNotSupportedException;
import java.util.logging.Logger;

import org.apache.commons.dbcp.BasicDataSource;

public class MyDataSource extends BasicDataSource {

	
	@Override
	public synchronized void setPassword(String password) {
		// TODO Auto-generated method stub
		System.out.println(password);
		super.setPassword(password);
	}
}
