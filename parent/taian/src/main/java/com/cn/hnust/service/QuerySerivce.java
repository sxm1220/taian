package com.cn.hnust.service;

import java.util.List;

import com.cn.hnust.model.FrmCode;
import com.cn.hnust.model.Hpzl;
import com.cn.hnust.model.Machine;
import com.cn.hnust.model.QueryLog;
import com.cn.hnust.model.Vehicle;

public interface QuerySerivce {

	List<Hpzl> getHpzlList();

	Machine querySeKey(Machine machine);

	QueryLog getQueryLog(QueryLog queryLog);

	int updateQueryLog(QueryLog queryLog);

	int insertQueryLog(QueryLog queryLog);

	Vehicle getVehByWhere(Vehicle veh);

	int insertVeh(Vehicle recVeh);

	Vehicle getVehByWhere1(Vehicle veh);

	int updateVehByWhere(Vehicle veh);

	String getYzbmByXzqh(String glbm);
	FrmCode getFrmCodeByWhere(FrmCode frmCode);
}
