package com.thinkgem.jeesite.modules.vehcile.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.vehcile.entity.Hpzl;

@MyBatisDao
public interface HpzlMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Hpzl record);

    int insertSelective(Hpzl record);

    Hpzl selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Hpzl record);

    int updateByPrimaryKey(Hpzl record);

	List<Hpzl> getHpzlList();
}