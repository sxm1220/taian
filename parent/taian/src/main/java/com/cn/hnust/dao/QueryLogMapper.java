package com.cn.hnust.dao;

import com.cn.hnust.model.QueryLog;

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