package com.cn.hnust.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cn.hnust.dao.FrmCodeMapper;
import com.cn.hnust.dao.HpzlMapper;
import com.cn.hnust.dao.MachineMapper;
import com.cn.hnust.dao.QueryLogMapper;
import com.cn.hnust.dao.VehicleMapper;
import com.cn.hnust.model.FrmCode;
import com.cn.hnust.model.Hpzl;
import com.cn.hnust.model.Machine;
import com.cn.hnust.model.QueryLog;
import com.cn.hnust.model.Vehicle;
import com.cn.hnust.service.QuerySerivce;
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

}
