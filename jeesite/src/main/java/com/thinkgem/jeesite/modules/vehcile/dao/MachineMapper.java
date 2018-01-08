package com.thinkgem.jeesite.modules.vehcile.dao;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.vehcile.entity.Machine;

@MyBatisDao
public interface MachineMapper {
    int deleteByPrimaryKey(Integer mId);

    int insert(Machine record);

    int insertSelective(Machine record);

    Machine selectByPrimaryKey(Integer mId);

    int updateByPrimaryKeySelective(Machine record);

    int updateByPrimaryKey(Machine record);

	Machine selectByCondation(Machine machine);
}