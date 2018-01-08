package com.thinkgem.jeesite.modules.vehcile.dao;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.vehcile.entity.QueryLog;

@MyBatisDao
public interface QueryLogMapper {
    int deleteByPrimaryKey(Integer logId);

    int insert(QueryLog record);

    int insertSelective(QueryLog record);

    QueryLog selectByPrimaryKey(Integer logId);

    int updateByPrimaryKeySelective(QueryLog record);

    int updateByPrimaryKey(QueryLog record);

	QueryLog getQueryLogByCondation(QueryLog queryLog);

	int updateBySelective(QueryLog queryLog);
}