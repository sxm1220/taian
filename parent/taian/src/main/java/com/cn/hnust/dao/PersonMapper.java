package com.cn.hnust.dao;

import com.cn.hnust.model.Person;

public interface PersonMapper {
    int insert(Person record);

    int insertSelective(Person record);
}