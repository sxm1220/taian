function getCruDateStr(){
	var oDate = new Date(); //实例一个时间对象；
	var year = oDate.getFullYear();   //获取系统的年；
	var month = oDate.getMonth()+1;   //获取系统月份，由于月份是从0开始计算，所以要加1
	var day = oDate.getDate(); // 获取系统日，
	return year+"年"+month+"月"+day+"日";
}