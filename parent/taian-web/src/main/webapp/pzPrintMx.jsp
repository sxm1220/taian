<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script src="${ctx}/resources/date.js" type="text/javascript"></script>
<script type="text/javascript">
Install_InsertReport();
Install_Detect();
CreateReport("Report");
function runFun() {
	//Report.PrintPreview(true);
	Report.Print(false);
}
</script>
<script type="text/javascript">
Install_InsertReport();
Install_Detect();
CreateReport("ReportWJ");
function runFunWJ() {
	//ReportWJ.PrintPreview(true);
	Report.Print(false);
}
</script>
<script type="text/javascript">
/* $(function(){
	var $contactForm = $('#queryForm');
	$contactForm.on('submit', function(ev){
	    ev.preventDefault();
	});
	
}); */

function query(){
	if(!$("form")[0].checkValidity()){
		return;
	} 
	
} 
function getOsk(){
	$.ajax({
		url: '${ctx}/query/showOsk',
	 	datatype: "json",
      	type: 'post',
      	async:false,
      	success: function (result) {
      		//$('#rec').html(result.message + result.shbtgyy);
      	}
	});
}


//处方报表



var falg = true;
function printPzsq(){
	/* if(!$("form")[0].checkValidity()){
		return;
	}  */
	if(falg==false){
		return;
	}
	falg = false;
	var phoneReg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
	if(!phoneReg.test($('#p_phone').val())) 
	{ 
		$('#rec').html("请输入有效的手机号码！");
		falg = true;
	    return false; 
	} 
	var ybReg= /^[1-9][0-9]{5}$/;
	if(!ybReg.test($('#p_yb').val())) 
	{ 
		$('#rec').html("请输入有效的邮政编码！");
		falg = true;
	    return false; 
	} 
	if($('#p_dz').val()==""){
		$('#rec').html("地址不能为空！");
		falg = true;
	    return false; 
	}
	var pzsq_check_id = $('#pzsq_check_id').is(':checked');
	var wj_check_id = $('#wj_check_id').is(':checked');
	if(pzsq_check_id==false&&wj_check_id==false){
		$('#rec').html("请先选中要打印的表格！");
		falg = true;
		return false; 
	}
	var fData = {
			hpzl:$('#hpzl').val(),
			hphm:$('#hphm').val(),
			clsbdh:$('#clsbdh').val(),
			lxdh:$('#p_phone').val(),
			lxdz:$('#p_dz').val(),
			lxdz:$('#p_dz').val(),
			yzbm:$('#p_yb').val()
	};
	$.ajax({
		url: '${ctx}/query/insertVeh',
	 	datatype: "json",
      	type: 'post',
      	async:true,
      	data:fData,
      	success: function (result) {
      		
      	}        
	});
	if(pzsq_check_id==true){
		Report.LoadFromURL("${ctx}/resources/report/pzsqb.grf");
		Report.ParameterByName("XM").AsString= $('#p_xm').val();
		Report.ParameterByName("PHONE").AsString= $('#p_phone').val();
		Report.ParameterByName("DZ").AsString= $('#p_dz').val();
		Report.ParameterByName("YB").AsString= $('#p_yb').val();
		Report.ParameterByName("HPZL").AsString= "${hpzlmc}";
		Report.ParameterByName("HPHM").AsString= "${hphm}";
		Report.ParameterByName("CruDate").AsString= getCruDateStr();
		var hphm = "${hphm}";
		if(hphm.substr(0,"鲁J".length)=="鲁J"){
			Report.ParameterByName("bssl").AsString= 1;
			Report.ParameterByName("wdsl").AsString= 0;
		}else{
			Report.ParameterByName("bssl").AsString= 0;
			Report.ParameterByName("wdsl").AsString= 1;
		}
		//Report.ParameterByName("dlrxm").AsString=$('#p_dlrxm').val(); ; 
		var dataStr=""; 
		AjaxReportRun(Report,"${ctx}/query/getHpzlList.do",runFun,dataStr);	
	}
	if(wj_check_id==true){
		ReportWJ.LoadFromURL("${ctx}/resources/report/wj.grf");
		ReportWJ.ParameterByName("HPHM").AsString= "${hphm}";
		ReportWJ.ParameterByName("CLLX").AsString= "${cllx}";
		ReportWJ.ParameterByName("SYXZ").AsString= "${syxz}";
		ReportWJ.ParameterByName("CCRQ").AsString= "${ccrq}";
		ReportWJ.ParameterByName("CCDJRQ").AsString= "${ccdjrq}";
		ReportWJ.ParameterByName("CruDate").AsString= getCruDateStr();
		var dataStr=""; 
		AjaxReportRun(ReportWJ,"${ctx}/query/getHpzlList.do",runFunWJ,dataStr);	
	}
	$('#rec').html("打印完成，即将关闭该页面！");
	setTimeout( webpageClose,3000);
    falg = true;
}
function webpageClose(){
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	parent.layer.close(index);
}

</script>

<script for=idcard event="Readed()">
      getinfo_onclick();
</script>
<script>
function getinfo_onclick(){
	var  r1,r2;
	//$('#p_xm').val(rdcard.NameL);
	$('#p_dz').val(rdcard.Address);
	$('#rec').html("身份读取成功！");
	parent.window.location.reload();
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    parent.layer.close(index);
     }
     
	function handread_onclick(){ 
		var  pp
		pp=rdcard.readcard();
		if(pp==0)
	        {
		    //document.getElementsByName("tResult")[0].value="readcard成功";
	            //showjpg_onclick();
			$('#rec').html("身份读取成功！");
	        }
	        else
	        {	
	            //document.getElementsByName("tResult")[0].value="readcard失败: "+pp;
	            $('#rec').html("身份读取失败！"+pp);
	        }
	}
	var la;
	function beginread_onclick(){
		
		var  pp
		pp=rdcard.ReadCard2();
		if(pp==0)
	        {
		    	//document.getElementsByName("tResult")[0].value="ReadCard2成功";
				//$('#rec').html("请把身份证放到读卡器上！");
				
				/* la = layer.msg('请把身份证放到读卡器上！', {icon: 16,time: 10000});  
				layer.style(la, {
					fontsize:'12px'
					});   */
				//la = layer.load(1,{content:测试123});
				la =layer.open({
	          	  type: 1,
	          	  title: false,
	          	  closeBtn: 0,
	          	  area: '380px',
	          	  skin: 'layui-layer-nobg', //没有背景色
	          	  shadeClose: true,
	          	  content: $('#tong')
	          	});
	        }
	        else
	        {	
	            //document.getElementsByName("tResult")[0].value="ReadCard2失败: "+pp;
	            $('#rec').html("身份读取失败！"+pp);
	        }
		}
	$(function(){
		beginread_onclick();
	});
</script>
</head>

<body>
<div style="display: none">
<OBJECT
	  classid="clsid:F1317711-6BDE-4658-ABAA-39E31D3704D3"                  
	  codebase="SDRdCard.cab#version=1,3,6,4"
	  width=330
	  height=210
	  align=center
	  hspace=0
	  vspace=0
	  id=idcard
	  name=rdcard	
>
</OBJECT></div>
<div class="search">
	<form id="queryForm"  >
  <table width="100%" border="0" style="border-collapse:separate; border-spacing:0px 30px;" >
   <tr>
   	<td align="right">号牌种类：</td>
   	<td align="left">${hpzlmc}</td>
   	<td align="right">号牌号码：</td>
   	<td align="left">${hphm} <input type="hidden" id="hpzl" value="${hpzl}" />   
   	
   	<input type="hidden"  id="hphm" value="${hphm}" /> 
   	<input type="hidden"  id="clsbdh" value="${clsbdh}" />
   	</td>
   </tr>
   <tr>
      <td align="right">车主姓名：</td>
      <td align="left"><input class="sr-1" id="p_xm" required="required" placeholder="输入车主姓名" value="${xm}" /></td>
      <td align="right">联系电话：</td>
      <td align="left"><input class="sr-1" id="p_phone" required="required" placeholder="输入联系电话" value="${lxdh}"  /></td>
      <td >  
      	<input name="" type="button"  class="btn-keybord_1" value="键&nbsp;盘" onclick=" getOsk();" />
        <input name="" type="button"  class="btn-keybord_1" value="读&nbsp;卡" onclick=" beginread_onclick();" />
       </td>
     </tr>
     <tr>
      <td align="right">邮编号码：</td>
      <td align="left"><input class="sr-1" id="p_yb" required="required" placeholder="输入邮编" value="${ybhm}" /></td>
      <td align="right">联系地址：</td>
      <td align="left"><input class="sr-1" id="p_dz" required="required" placeholder="输入联系地址" value="${lxdz}"  /></td>
     <!--  <td >  <input name="" type="button"  class="btn-print" value="打&nbsp;印" onclick="printPzsq();" /> </td> -->
     </tr>
     
     <tr>
      <td align="right"><input type="checkbox" id="pzsq_check_id" style=" width:40px;height:40px;" checked="checked" /></td>
      <td align="left"><span style="color: red;">牌证申请表</span></td>
      <td align="right"><input  type="checkbox" id="wj_check_id" style=" width:40px;height:40px;" checked="checked" /></td>
      <td align="left"><span style="color: red;">外检表</span></td>
      <td>  <input name="" type="button"  class="btn-print" value="打&nbsp;印" onclick="printPzsq();" /> </td>
     </tr> 
     <!-- <tr>
      <td align="right">代理人姓名：</td>
      <td align="left"><input class="sr-1" id="p_dlrxm"required="required" placeholder="输入代理人姓名" value="" /></td>
     </tr> -->
  </table>
  </form>
</div>
<div class="jieguo" id="rec"> </div>

<div id="tong" class="hide layui-layer-wrap" style="display: none;overflow: hidden;">
	<img src="${ctx}/resources/taian/images/readCard.gif">
</div> 
</body>
</html>
