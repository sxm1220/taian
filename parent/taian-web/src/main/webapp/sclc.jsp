<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
	//request.setAttribute("ctx", path);
	request.setAttribute("ctx", basePath);
	request.setAttribute("ctxStatic", path+"/static");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>牌证申请表打印</title>
<link href="${ctx}/resources/taian/css/result.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/resources/jquery-easyui-1.5/jquery.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/layer/layer.js" type="text/javascript"></script>
<script src="${ctx}/resources/report/CreateControl.js" type="text/javascript"></script>
<script type="text/javascript">
var t=300;//设定跳转的时间 
setInterval("refer()",1000); //启动1秒定时 
function refer(){  
    if(t==0){ 
        location="${ctx}/index.jsp"; //#设定跳转的链接地址 
    } 
    document.getElementById('timeBox').innerHTML=""+t+"秒后跳转到首页"; // 显示倒计时 
    t--; // 计数器递减 
    //本文转自： 
}

</script>
</head>
<body>
<div class="djs"><a href="${ctx}/index.jsp"><img src="${ctx}/resources/taian/images/icon06.png" width="80" height="76" style="border: 0px;" /></a> <span id="timeBox" class="djs-time"></span> </div>
<div class="header"><img src="${ctx}/resources/taian/images/logo4.png" /></div>
<div style=" width:95%; margin-left:auto; margin-right:auto; margin-top:70px; background-color:#FFF;"><img src="${ctx}/resources/taian/images/lct.png" width="100%"  /></div>

</body>
</html>
