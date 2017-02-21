<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>车主自助服务系统</title>
<link href="${ctx}/resources/taian/css/shouye.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/resources/jquery-easyui-1.5/jquery.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/layer/layer.js" type="text/javascript"></script>
<script type="text/javascript">
function showPwdpage(){
	$('#pwd').val("");
	layer.open({
		  type: 1,
		  time:30000,
		  title: '输入关闭密码',
		  skin: 'layui-layer-rim', //加上边框
		  area: ['600px', '300px'], //宽高
		  content: $("#box1")
		});
}

function closeWindow(){
      if ($('#pwd').val()=='6784321') {
      	window.close();
      }
}
function keyboardClik(key){
	var temp = $('#pwd').val();
	$('#pwd').val(temp+''+key);
}
function clearPwd(){
	$('#pwd').val("");
}
</script>
</head>
<body style="overflow: hidden;" >
<div class="header"><img src="${ctx}/resources/taian/images/logo2.png" /></div>
<div class="reback"><a href="#" onclick="showPwdpage();"><img src="${ctx}/resources/taian/images/icon05.png" width="80" height="76" style="border: 0px;" /></a></div>
<div class="search"> 
</div>
<div class="mokuai">
   <div class="mokuai-01"><a href="${ctx}/pzPrint.jsp"><img src="${ctx}/resources/taian/images/icon01.png" width="282" height="184" style="border: 0px;" /></a></div>
   <div class="mokuai-02"><a href="${ctx}/result.jsp"><img src="${ctx}/resources/taian/images/icon02.png" width="282" height="214" style="border: 0px;" /></a></div>
   <div class="mokuai-03"><a href="${ctx}/sclc.jsp"><img src="${ctx}/resources/taian/images/icon03.png" width="282" height="183" style="border: 0px;"/></a></div>
   <div class="mokuai-04"><a href="#"><img src="${ctx}/resources/taian/images/icon04.png" width="282" height="171" style="border: 0px;" /></a></div>
</div>
<div class="bottom">开发单位：泰安乐行科技 &nbsp;&nbsp; 联系电话：13563826575</div>
<div id="box1" style="display: none;text-align: center;">
       	<div style="font-size: 30px;">  
       	密码：<input type="password" id="pwd" style="width: 260px;height: 30px;" />
       	<input type="button" value="确定" style="width: 65px;height: 45px;font-size:25px;" onclick="closeWindow()" />
       	<input type="button" value="清空" style="width: 65px;height: 45px;font-size:25px;" onclick="clearPwd()" />
       	</div>
       	<div style="margin-top: 20px;">
       		<input type="button" value="1" style="width: 50px;height: 50px;font-size:30px;" onclick="keyboardClik(1)" />
       		<input type="button" value="2" style="width: 50px;height: 50px;font-size:30px;" onclick="keyboardClik(2)" />
       		<input type="button" value="3" style="width: 50px;height: 50px;font-size:30px;" onclick="keyboardClik(3)"/>
       		<input type="button" value="4" style="width: 50px;height: 50px;font-size:30px;" onclick="keyboardClik(4)"/>
       		<input type="button" value="5" style="width: 50px;height: 50px;font-size:30px;" onclick="keyboardClik(5)"/>
       		<input type="button" value="6" style="width: 50px;height: 50px;font-size:30px;" onclick="keyboardClik(6)"/>
       		<input type="button" value="7" style="width: 50px;height: 50px;font-size:30px;" onclick="keyboardClik(7)"/>
       		<input type="button" value="8" style="width: 50px;height: 50px;font-size:30px;" onclick="keyboardClik(8)"/>
       		<input type="button" value="9" style="width: 50px;height: 50px;font-size:30px;" onclick="keyboardClik(9)"/>
       		<input type="button" value="0" style="width: 50px;height: 50px;font-size:30px;" onclick="keyboardClik(0)"/>
       	</div>
 </div>
</body>
</html>
