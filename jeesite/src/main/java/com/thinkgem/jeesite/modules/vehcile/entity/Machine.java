package com.thinkgem.jeesite.modules.vehcile.entity;

public class Machine {
    private Integer mId;

    private String ip;

    private String jyjgbh;

    private String keycode;

    public Integer getmId() {
        return mId;
    }

    public void setmId(Integer mId) {
        this.mId = mId;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip == null ? null : ip.trim();
    }

    public String getJyjgbh() {
        return jyjgbh;
    }

    public void setJyjgbh(String jyjgbh) {
        this.jyjgbh = jyjgbh == null ? null : jyjgbh.trim();
    }

    public String getKeycode() {
        return keycode;
    }

    public void setKeycode(String keycode) {
        this.keycode = keycode == null ? null : keycode.trim();
    }
}