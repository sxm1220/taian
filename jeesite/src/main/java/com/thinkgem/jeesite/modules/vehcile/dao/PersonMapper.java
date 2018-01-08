package com.thinkgem.jeesite.modules.vehcile.dao;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.vehcile.entity.Person;

@MyBatisDao
public interface PersonMapper {
    int insert(Person record);

    int insertSelective(Person record);
}