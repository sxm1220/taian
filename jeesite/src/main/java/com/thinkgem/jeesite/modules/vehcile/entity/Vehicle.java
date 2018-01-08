package com.thinkgem.jeesite.modules.vehcile.entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.Dict;

public class Vehicle extends DataEntity<Vehicle>{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer vheId;

    private String hpzl;
    
    private String hpzlmc;

    private String hphm;

    private String clsbdh;

    private String yxqz;

    private String fzjg;

    private String cllx;

    private String syxz;

    private String clyt;

    private String ytxz;

    private String type;

    private String syr;

    private String yzbm;

    private String lxdh;

    private String lxdz;

    private String dlr;

    private String code ;
    
    private String message;
    
    private String glbm;
    
    private String zzxzqh;
    
    private String ccrq;
    
    private String ccdjrq;
    
    private String jyjgbh;
    
    private Date printDate;
    
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date beginPrintDate;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date endPrintDate;
    private String officeId;
    private String officeName;
    
    
    
    
    

	public String getOfficeId() {
		return officeId;
	}

	public void setOfficeId(String officeId) {
		this.officeId = officeId;
	}

	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}

	public Date getBeginPrintDate() {
		return beginPrintDate;
	}

	public void setBeginPrintDate(Date beginPrintDate) {
		this.beginPrintDate = beginPrintDate;
	}

	public Date getEndPrintDate() {
		return endPrintDate;
	}

	public void setEndPrintDate(Date endPrintDate) {
		this.endPrintDate = endPrintDate;
	}

	public Date getPrintDate() {
		return printDate;
	}

	public void setPrintDate(Date printDate) {
		this.printDate = printDate;
	}

	public String getJyjgbh() {
		return jyjgbh;
	}

	public void setJyjgbh(String jyjgbh) {
		this.jyjgbh = jyjgbh;
	}

	public String getHpzlmc() {
		return hpzlmc;
	}

	public void setHpzlmc(String hpzlmc) {
		this.hpzlmc = hpzlmc;
	}

	public String getZzxzqh() {
		return zzxzqh;
	}

	public void setZzxzqh(String zzxzqh) {
		this.zzxzqh = zzxzqh;
	}

	public String getGlbm() {
		return glbm;
	}

	public void setGlbm(String glbm) {
		this.glbm = glbm;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Integer getVheId() {
        return vheId;
    }

    public void setVheId(Integer vheId) {
        this.vheId = vheId;
    }
    @ExcelField(title="号牌种类", align=2, sort=20)
    public String getHpzl() {
        return hpzl;
    }

    public void setHpzl(String hpzl) {
        this.hpzl = hpzl == null ? null : hpzl.trim();
    }
    @ExcelField(title="号牌号码", align=2, sort=25)
    public String getHphm() {
        return hphm;
    }

    public void setHphm(String hphm) {
        this.hphm = hphm == null ? null : hphm.trim();
    }

    public String getClsbdh() {
        return clsbdh;
    }

    public void setClsbdh(String clsbdh) {
        this.clsbdh = clsbdh == null ? null : clsbdh.trim();
    }

    public String getYxqz() {
        return yxqz;
    }

    public void setYxqz(String yxqz) {
        this.yxqz = yxqz == null ? null : yxqz.trim();
    }

    public String getFzjg() {
        return fzjg;
    }

    public void setFzjg(String fzjg) {
        this.fzjg = fzjg == null ? null : fzjg.trim();
    }

    public String getCllx() {
        return cllx;
    }

    public void setCllx(String cllx) {
        this.cllx = cllx == null ? null : cllx.trim();
    }

    public String getSyxz() {
        return syxz;
    }

    public void setSyxz(String syxz) {
        this.syxz = syxz == null ? null : syxz.trim();
    }

    public String getClyt() {
        return clyt;
    }

    public void setClyt(String clyt) {
        this.clyt = clyt == null ? null : clyt.trim();
    }

    public String getYtxz() {
        return ytxz;
    }

    public void setYtxz(String ytxz) {
        this.ytxz = ytxz == null ? null : ytxz.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }
    @ExcelField(title="所有人", align=2, sort=30)
    public String getSyr() {
        return syr;
    }

    public void setSyr(String syr) {
        this.syr = syr == null ? null : syr.trim();
    }

    public String getYzbm() {
        return yzbm;
    }

    public void setYzbm(String yzbm) {
        this.yzbm = yzbm == null ? null : yzbm.trim();
    }
    @ExcelField(title="联系电话", align=2, sort=35)
    public String getLxdh() {
        return lxdh;
    }

    public void setLxdh(String lxdh) {
        this.lxdh = lxdh == null ? null : lxdh.trim();
    }

    public String getLxdz() {
        return lxdz;
    }

    public void setLxdz(String lxdz) {
        this.lxdz = lxdz == null ? null : lxdz.trim();
    }

    public String getDlr() {
        return dlr;
    }

    public void setDlr(String dlr) {
        this.dlr = dlr == null ? null : dlr.trim();
    }

	public String getCcrq() {
		return ccrq;
	}

	public void setCcrq(String ccrq) {
		this.ccrq = ccrq;
	}

	public String getCcdjrq() {
		return ccdjrq;
	}

	public void setCcdjrq(String ccdjrq) {
		this.ccdjrq = ccdjrq;
	}
    
    
}