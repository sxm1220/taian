package com.cn.hnust.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.cn.hnust.model.Vehicle;
@Repository
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
}