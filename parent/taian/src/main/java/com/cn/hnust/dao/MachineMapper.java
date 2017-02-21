package com.cn.hnust.dao;

import org.springframework.stereotype.Repository;

import com.cn.hnust.model.Machine;
@Repository
public interface MachineMapper {
    int deleteByPrimaryKey(Integer mId);

    int insert(Machine record);

    int insertSelective(Machine record);

    Machine selectByPrimaryKey(Integer mId);

    int updateByPrimaryKeySelective(Machine record);

    int updateByPrimaryKey(Machine record);

	Machine selectByCondation(Machine machine);
}