package com.thinkgem.jeesite.modules.vehcile.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.modules.vehcile.dao.FrmCodeMapper;
import com.thinkgem.jeesite.modules.vehcile.dao.HpzlMapper;
import com.thinkgem.jeesite.modules.vehcile.dao.MachineMapper;
import com.thinkgem.jeesite.modules.vehcile.dao.QueryLogMapper;
import com.thinkgem.jeesite.modules.vehcile.dao.VehicleMapper;
import com.thinkgem.jeesite.modules.vehcile.entity.FrmCode;
import com.thinkgem.jeesite.modules.vehcile.entity.Hpzl;
import com.thinkgem.jeesite.modules.vehcile.entity.Machine;
import com.thinkgem.jeesite.modules.vehcile.entity.QueryLog;
import com.thinkgem.jeesite.modules.vehcile.entity.Vehicle;

@Service("querySerivce")
public class QueryServiceImpl implements QuerySerivce {

	@Resource
	private HpzlMapper hpzlMapper;
	@Resource
	private MachineMapper machineMapper;
	@Resource
	QueryLogMapper queryLogMapper;
	@Resource
	VehicleMapper vehicleMapper;
	@Resource
	FrmCodeMapper frmCodeMapper;
	
	@Override
	public List<Hpzl> getHpzlList() {
		// TODO Auto-generated method stub
		return hpzlMapper.getHpzlList();
	}

	@Override
	public Machine querySeKey(Machine machine) {
		// TODO Auto-generated method stub
		return machineMapper.selectByCondation(machine);
	}

	@Override
	public QueryLog getQueryLog(QueryLog queryLog) {
		// TODO Auto-generated method stub
		return queryLogMapper.getQueryLogByCondation(queryLog);
	}

	@Override
	public int updateQueryLog(QueryLog queryLog) {
		// TODO Auto-generated method stub
		return queryLogMapper.updateBySelective(queryLog);
	}

	@Override
	public int insertQueryLog(QueryLog queryLog) {
		// TODO Auto-generated method stub
		return queryLogMapper.insertSelective(queryLog);
	}

	@Override
	public Vehicle getVehByWhere(Vehicle veh) {
		// TODO Auto-generated method stub
		return vehicleMapper.getVehByWhere(veh);
	}

	@Override
	public int insertVeh(Vehicle recVeh) {
		// TODO Auto-generated method stub
		recVeh.setPrintDate(new Date());
		return vehicleMapper.insertSelective(recVeh);
	}

	@Override
	public Vehicle getVehByWhere1(Vehicle veh) {
		// TODO Auto-generated method stub
		return vehicleMapper.getVehByWhere1(veh);
	}

	@Override
	public int updateVehByWhere(Vehicle veh) {
		// TODO Auto-generated method stub
		veh.setPrintDate(new Date());
		return vehicleMapper.updateVehByWhere(veh);
	}

	@Override
	public String getYzbmByXzqh(String glbm) {
		// TODO Auto-generated method stub
		return vehicleMapper.getYzbm(glbm);
	}

	@Override
	public FrmCode getFrmCodeByWhere(FrmCode frmCode) {
		// TODO Auto-generated method stub
		return frmCodeMapper.getFrmCodeByWhere(frmCode);
	}

	@Override
	public String getPostCodeByHphm(String hphm) {
		// TODO Auto-generated method stub
		return vehicleMapper.getPostCodeByHphm(hphm);
	}

	@Override
	public Page<Vehicle> findPage(Page<Vehicle> page, Vehicle veh) {
		// TODO Auto-generated method stub
		veh.setPage(page);
		page.setList(vehicleMapper.findList(veh));
		return page;
	}

	@Override
	public List<FrmCode> getFrmCodeListByWhere(FrmCode frmCode) {
		// TODO Auto-generated method stub
		return frmCodeMapper.getFrmCodeListByWhere(frmCode);
	}

	@Override
	public void deleteVehicle(Vehicle veh) {
		// TODO Auto-generated method stub
		vehicleMapper.deleteByPrimaryKey(veh.getVheId());
	}

	@Override
	public List<Vehicle> getVehList(Vehicle veh) {
		// TODO Auto-generated method stub
		return vehicleMapper.findList(veh);
	}

	@Override
	public void deleteByIds(String ids) {
		// TODO Auto-generated method stub
		if (ids!=null&&!"".equals(ids)) {
			ids = ids.substring(0,ids.length() - 1);
		}
		vehicleMapper.deleteByIds(ids);
	}

}
