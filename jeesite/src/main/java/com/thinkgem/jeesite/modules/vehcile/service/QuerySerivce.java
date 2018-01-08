package com.thinkgem.jeesite.modules.vehcile.service;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.modules.vehcile.entity.FrmCode;
import com.thinkgem.jeesite.modules.vehcile.entity.Hpzl;
import com.thinkgem.jeesite.modules.vehcile.entity.Machine;
import com.thinkgem.jeesite.modules.vehcile.entity.QueryLog;
import com.thinkgem.jeesite.modules.vehcile.entity.Vehicle;


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

	String getPostCodeByHphm(String hphm);

	Page<Vehicle> findPage(Page<Vehicle> page, Vehicle veh);

	List<FrmCode> getFrmCodeListByWhere(FrmCode frmCode);

	void deleteVehicle(Vehicle veh);

	List<Vehicle> getVehList(Vehicle veh);

	void deleteByIds(String ids);
}
