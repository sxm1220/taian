package com.thinkgem.jeesite.modules.vehcile.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.vehcile.entity.Vehicle;

@MyBatisDao
public interface VehicleMapper {
    int deleteByPrimaryKey(Integer vheId);

    int insert(Vehicle record);

    int insertSelective(Vehicle record);

    Vehicle selectByPrimaryKey(Integer vheId);

    int updateByPrimaryKeySelective(Vehicle record);

    int updateByPrimaryKey(Vehicle record);

	Vehicle getVehByWhere(Vehicle veh);

	Vehicle getVehByWhere1(Vehicle veh);

	int updateVehByWhere(Vehicle veh);

	String getYzbm(@Param("glbm")String glbm);

	String getPostCodeByHphm(@Param("hphm")String hphm);

	List<Vehicle> findList(Vehicle veh);

	int deleteByIds(@Param("ids")String ids);
}