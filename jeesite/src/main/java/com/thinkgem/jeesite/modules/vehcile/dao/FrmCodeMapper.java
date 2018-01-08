package com.thinkgem.jeesite.modules.vehcile.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.vehcile.entity.FrmCode;

@MyBatisDao
public interface FrmCodeMapper {
    int insert(FrmCode record);

    int insertSelective(FrmCode record);
    
    FrmCode getFrmCodeByWhere(FrmCode frmCode);

	List<FrmCode> getFrmCodeListByWhere(FrmCode frmCode);
}