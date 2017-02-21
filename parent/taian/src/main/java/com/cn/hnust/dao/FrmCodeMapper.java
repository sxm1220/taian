package com.cn.hnust.dao;

import org.springframework.stereotype.Repository;

import com.cn.hnust.model.FrmCode;
@Repository
public interface FrmCodeMapper {
    int insert(FrmCode record);

    int insertSelective(FrmCode record);
    
    FrmCode getFrmCodeByWhere(FrmCode frmCode);
}