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
<title>检验结果自助查询结果</title>
<link href="${ctx}/resources/taian/css/result.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/resources/jquery-easyui-1.5/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
var t=200;//设定跳转的时间 
setInterval("refer()",1000); //启动1秒定时 
function refer(){  
    if(t==0){ 
        location="${ctx}/index.jsp"; //#设定跳转的链接地址 
    } 
    document.getElementById('timeBox').innerHTML=""+t+"秒后跳转到首页"; // 显示倒计时 
    t--; // 计数器递减 
    //本文转自： 
} 

function keyboardClik(key){
	var hphm_input = $('#hphm_input').val();
	if(key=="Delete"){
		$('#hphm_input').val(hphm_input.substr(0, hphm_input.length - 1));
	}else{
		if(hphm_input.length>=6){
			return;
		}else{
			$('#hphm_input').val(hphm_input+key);
		}
	}
	
}
function reload(){
	location.reload() ;
}

function query(){
	var hpzl = $("#hpzl").val();
	var hphm = $("#hphm").val();
	var hphm_input =  $("#hphm_input").val();
	if(hphm_input.length<4||hphm_input.length>6){
		$('#rec').html("请输入正确的号牌号码！");
		return;
	}
	var fData = {
			hpzl:hpzl,
			hphm:hphm,
			hphm_input:hphm_input
	};
	$('#rec').html("");
	$.ajax({
		url: '${ctx}/query/qeuryCheckResult',
	 	datatype: "json",
      	type: 'post',
      	async:false,
      	data:fData,
      	success: function (result) {
      		$('#rec').html(result.message + result.shbtgyy);
      	}
	});
}

</script>
</head>
<body>

<div class="djs"><a href="${ctx}/index.jsp"><img src="${ctx}/resources/taian/images/icon06.png" width="80" height="76" style="border: 0px;"/></a> <span id="timeBox" class="djs-time"></span> </div>
<div class="header"><img src="${ctx}/resources/taian/images/logo.png" /></div>
<div class="search">
  <table width="100%" border="0" >
    <tr>
      <td>号牌种类：</td>
      <td><div class="selectbox">
          <select name="" class="select-1" id="hpzl">
            <option value="01">大型汽车</option>
            <option value="02" selected="selected">小型汽车</option>
            <option value="03">使馆汽车</option>
            <option value="07">普通摩托车</option>
            <option value="08">轻便摩托车</option>
            <option value="13">低速车</option>
            <option value="14">拖拉机</option>
            <option value="15">挂车</option>
            <option value="16">教练汽车</option>
          </select>
        </div></td>
      <td>号牌号码：</td>
      <td width="500"><div class="selectbox-2">
          <select name="" class="select-2" id="hphm">
            <option value="京">京</option>
            <option value="津">津</option>
            <option value="冀">冀</option>
            <option value="晋">晋</option>
            <option value="蒙">蒙</option>
            <option value="辽">辽</option>
            <option value="吉">吉</option>
            <option value="黑">黑</option>
            <option value="沪">沪</option>
            <option value="苏">苏</option>
            <option value="浙">浙</option>
            <option value="皖">皖</option>
            <option value="闽">闽</option>
            <option value="赣">赣</option>
            <option value="鲁" selected="selected">鲁</option>
            <option value="豫">豫</option>
            <option value="鄂">鄂</option>
            <option value="湘">湘</option>
            <option value="粤">粤</option>
            <option value="桂">桂</option>
            <option value="琼">琼</option>
            <option value="渝">渝</option>
            <option value="川">川</option>
            <option value="陕">陕</option>
            <option value="甘">甘</option>
            <option value="青">青</option>
            <option value="宁">宁</option>
            <option value="新">新</option>
            <option value="使">使</option>
          </select>
          
        </div> <input name="" type="text" value="J" id="hphm_input"  class="sr-1"/></td>
      <td> <input name="" type="button"  class="btn-1" value="查&nbsp;询" onclick="query();" /> <input name="" type="button"  class="btn-2" value="刷&nbsp;新" onclick="reload();" /> </td>
    </tr>
  </table>
</div>
<div class="jieguo" id="rec"> </div>
<div class="jianpan">
  <div  class="jianpan-1"><div style="float:left;"><a href="#" onclick="keyboardClik('1')">1</a><a href="#" onclick="keyboardClik('2')">2</a><a href="#" onclick="keyboardClik('3')">3</a><a href="#" onclick="keyboardClik('4')">4</a><a href="#" onclick="keyboardClik('5')">5</a>
  <a href="#" onclick="keyboardClik('6')">6</a><a href="#" onclick="keyboardClik('7')">7</a><a href="#" onclick="keyboardClik('8')">8</a><a href="#" onclick="keyboardClik('9')">9</a><a href="#" onclick="keyboardClik('0')">0</a></div><div class="ts"><a href="#" onclick="keyboardClik('Delete')" >Delete</a></div></div>
   <div  class="jianpan-2"><a href="#" onclick="keyboardClik('Q')">Q</a><a href="#" onclick="keyboardClik('W')">W</a><a href="#" onclick="keyboardClik('E')">E</a><a href="#" onclick="keyboardClik('R')">R</a><a href="#" onclick="keyboardClik('T')">T</a><a href="#" onclick="keyboardClik('Y')">Y</a><a href="#" onclick="keyboardClik('U')">U</a><a href="#" onclick="keyboardClik('I')">I</a><a href="#" onclick="keyboardClik('O')">O</a><a href="#" onclick="keyboardClik('P')">P</a></div>
   <div  class="jianpan-3"><a href="#" onclick="keyboardClik('A')">A</a><a href="#" onclick="keyboardClik('S')">S</a><a href="#" onclick="keyboardClik('D')">D</a><a href="#" onclick="keyboardClik('F')">F</a><a href="#" onclick="keyboardClik('G')">G</a><a href="#" onclick="keyboardClik('H')">H</a><a href="#" onclick="keyboardClik('J')">J</a><a href="#" onclick="keyboardClik('K')">K</a><a href="#" onclick="keyboardClik('L')">L</a></div>
   <div  class="jianpan-4"><a href="#" onclick="keyboardClik('Z')">Z</a><a href="#" onclick="keyboardClik('X')">X</a><a href="#" onclick="keyboardClik('C')">C</a><a href="#" onclick="keyboardClik('V')">V</a><a href="#" onclick="keyboardClik('B')">B</a><a href="#" onclick="keyboardClik('N')">N</a><a href="#" onclick="keyboardClik('M')">M</a></div>
</div>
</body>
</html>