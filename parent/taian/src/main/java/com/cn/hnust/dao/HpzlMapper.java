package com.cn.hnust.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.cn.hnust.model.Hpzl;
@Repository
public interface HpzlMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Hpzl record);

    int insertSelective(Hpzl record);

    Hpzl selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Hpzl record);

    int updateByPrimaryKey(Hpzl record);

	List<Hpzl> getHpzlList();
}