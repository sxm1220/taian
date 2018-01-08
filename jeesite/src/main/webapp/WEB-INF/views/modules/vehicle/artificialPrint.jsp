<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>牌证申请表打印</title>
<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/report/CreateControl.js" type="text/javascript"></script>
<script src="${ctxStatic}/layer/layer.js" type="text/javascript"></script>
<script src="${ctxStatic}/date.js" type="text/javascript"></script>
<script type="text/javascript">
	Install_InsertReport();
	Install_Detect();
	CreateReport("Report");
</script>
<script type="text/javascript">
Install_InsertReport();
Install_Detect();
CreateReport("ReportWJ");
</script>
<script type="text/javascript">
function query(status){
	var hpzl = $("#hpzl").val();
	var hphm = $("#hphm").val();
	var hphm_input =  $("#hphm_input").val();
	var hpzlmc =$("#hpzl").find("option:selected").text();
	
	var brstatus = $("#brstatus").val();
	
	var cjh =  $("#cjh").val();
	if(hphm_input.length<4||hphm_input.length>6){
		$('#rec').html("请输入正确的号牌号码！");
		return;
	}
	if(status!==1){
		if(cjh.length!=4){
			$('#rec').html("请输入正确车架号后四位！");
			return;
		}
	}
	var fData = {
			hpzl:hpzl,
			hphm:hphm,
			hphm_input:hphm_input,
			cjh:cjh,
			type:brstatus
	};
	$('#rec').html("");
	var i ;  
	$.ajax({
		url: '${ctx}/vehicle/qeuryVechile',
	 	datatype: "json",
      	type: 'post',
      	async:true,
      	data:fData,
      	beforeSend: function () {  
            i =  layer.load('正在加载中，请耐心等待...', 3); 
        },
      	success: function (result) {
      		if(result.code==1){
      				//官网欢迎页
      			  layer.close(i);  
      			  if(status==1){
      				  $("#p_phone").val(result.lxdh);
      			  }else{
      				  $("#p_xm").val(result.syr);
      				  $("#p_phone").val(result.lxdh);
        			  $("#p_yb").val(result.ybhm);
        			  $("#p_dz").val(result.lxdz);
        			  $("#p_dlrxm").val(result.dlr);
        			  $("#p_cllx").val(result.cllxmc);
        			  $("#p_syxz").val(result.syxzmc);
        			  $("#p_fzrq").val(result.ccrq);
        			  $("#p_zcrq").val(result.ccdjrq);
  				      $("#h_clsbdh").val(result.clsbdh); 
  				      $("#cjh").val(result.clsbdh.substr(result.clsbdh.length-4)); 
      			  }
      		  }else{
      			layer.close(i);  
      			$('#rec').html(result.message);
      		} 
      	},
      	error: function () {
      		layer.close(i); 
            layer.alert('部分数据加载失败，可能会导致页面显示异常，请刷新后重试', {
                skin: 'layui-layer-molv'
               , closeBtn: 0
               , shift: 4 //动画类型
            });
        }
        
	});
} 
var falg = true;
function printPzsq(status){
	if(falg==false){
		return;
	}
	falg = false;
	/* var phoneReg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
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
	}*/
	var hphm = $("#hphm").val()+$("#hphm_input").val();
	hphm = hphm.toUpperCase();
	var fData = {
			hpzl:$('#hpzl').val(),
			hphm:hphm,
			clsbdh:$('#h_clsbdh').val(),
			lxdh:$('#p_phone').val(),
			lxdz:$('#p_dz').val(),
			yzbm:$('#p_yb').val(),
			dlr:$('#p_dlrxm').val(),
			ccrq:$('#p_fzrq').val(),
			ccdjrq:$('#p_zcrq').val(),
			syxz:$('#p_syxz').val(),
			cllx:$('#p_cllx').val(),
			syr:$('#p_xm').val()
	};
	$.ajax({
		url: '${ctx}/vehicle/insertVeh',
	 	datatype: "json",
      	type: 'post',
      	async:false,
      	data:fData,
      	success: function (result) {
      		
      	}        
	});
	var hpzlmc =$("#hpzl").find("option:selected").text();
	if(status==0||status==1){
		var fontSize = "${office.fontSize}";
		var url = "${ctxStatic}/report/pzsqb.grf";
		if(fontSize!=""){
			url = "${ctxStatic}/report/pzsqb_"+fontSize+".grf";
		}
		Report.LoadFromURL(url);
		Report.ParameterByName("XM").AsString= $('#p_xm').val();
		Report.ParameterByName("PHONE").AsString= $('#p_phone').val();
		Report.ParameterByName("DZ").AsString= $('#p_dz').val();
		Report.ParameterByName("YB").AsString= $('#p_yb').val();
		Report.ParameterByName("HPZL").AsString= hpzlmc+"号牌";
		Report.ParameterByName("HPHM").AsString= hphm;
		Report.ParameterByName("CruDate").AsString= getCruDateStr();
		var hp = "${office.hp}";
		if(hphm.substr(0,2)==hp){
			Report.ParameterByName("bssl").AsString= 1;
			Report.ParameterByName("wdsl").AsString= 0;
		}else{
			Report.ParameterByName("bssl").AsString= 0;
			Report.ParameterByName("wdsl").AsString= 1;
		}
		/* var brstatus = $("#brstatus").val(); */
		var brstatus = $('#brstatus').is(':checked');
		if(brstatus==true){
			Report.ParameterByName("dlrxm").AsString=$('#p_dlrxm').val(); 
			Report.ParameterByName("dlrphone").AsString=$('#p_phone').val(); 
		}
		//Report.Printer.PrinterName="sqbdy";
		Report.Print(true);
	}
	if(status==0||status==2){
		ReportWJ.LoadFromURL("${ctxStatic}/report/wj.grf?v=20170827");
		ReportWJ.ParameterByName("HPHM").AsString= hphm;
		ReportWJ.ParameterByName("CLLX").AsString= $("#p_cllx").val();
		ReportWJ.ParameterByName("SYXZ").AsString= $("#p_syxz").val();
		ReportWJ.ParameterByName("CCRQ").AsString= $("#p_fzrq").val();
		ReportWJ.ParameterByName("CCDJRQ").AsString= $("#p_zcrq").val();
		ReportWJ.ParameterByName("LCB").AsString= $("#p_lcb").val();
		ReportWJ.ParameterByName("XM").AsString= $('#p_xm').val();
		ReportWJ.ParameterByName("PHONE").AsString= $('#p_phone').val();
		ReportWJ.ParameterByName("CruDate").AsString= getCruDateStr();
		ReportWJ.ParameterByName("jyjgdz").AsString="${fns:getOfficeList()[0].address}";
		ReportWJ.ParameterByName("jyjglxdh").AsString="${fns:getOfficeList()[0].phone}";
		ReportWJ.ParameterByName("jyjgyb").AsString="${fns:getOfficeList()[0].zipCode}";
		//ReportWJ.Printer.PrinterName="sqbdy";
		ReportWJ.Print(true);
	}
	$('#rec').html("打印完成！");
    //setTimeout( webpageRefresh,3000);
    $("#p_xm").val("");
 	$("#p_phone").val("");
  	$("#p_yb").val("${office.zipCode}");
  	$("#p_dz").val("");
  	$("#p_dlrxm").val("");
  	$("#p_cllx").val("");
  	$("#p_syxz").val("");
  	$("#p_fzrq").val("");
  	$("#p_zcrq").val("");
	$("#h_clsbdh").val(""); 
	$("#cjh").val(""); 
	var hp = "${office.hp}";
	$("#hphm").val(hp.substring(0,1));
	$("#hphm_input").val(hp.substring(1)); 
	$("#hpzl").val("02");
	$("#p_lcb").val("");
    falg = true;
}
function webpageRefresh(){
	window.location.reload();
}
</script>

<!-- 读取行驶证 -->
<script type="text/javascript">
function LoadRecogKenal()
{
    //document.IDScanRecog.result.innerText = "";
    if(!objIDCard.IsLoaded())
    {
       var strDllPath = "";
       var nRet = objIDCard.InitIDCard("65905289240624839571",1);

       if(nRet==0)
       { 
       }
       else
       {
       }
    }
    else
    {
    }
 
}
//Release engine
function FreeRecogKenal()
{
    objIDCard.FreeIdcard();
    document.IDScanRecog.result.innerText = "";
}
//recognition
function RecognizeImg()
{
    if(objIDCard.IsLoaded())
    {
    
	 
		//alert("SetIDCardType 1");
     	objIDCard.SetIDCardType("6",0);
        //alert("SetIDCardType 2");
      	nResult = objIDCard.ClassifyIDCard(); 
		//alert("CardType:"+nResult);
		var nCardType = nResult;
		
		var nImg = checkDg("image");
		var nImg = checkDg("image");
		var nViz = checkVIZ();
		 
		if( nCardType == 1)
		{
			nResult = objIDCard.RecogChipCard(nDG,nViz,nImg);
		}
		  
		if( nCardType == 2)
		{
			nResult = objIDCard.RecogGeneralMRZCard(nViz,nImg);
		}
		  
		if( nCardType == 3)
		{
			nResult = objIDCard.RecogCommonCard(nImg);
		}
		
		if(nResult <= 0)
        {
          
           var strError = "recognition failure\r\nReturn value：";
           strError += nResult;
          // document.IDScanRecog.result.innerText = strError;
           return;
        } 
	  
        //display the recognition results
        DisplayResult();
        //save images
		//objIDCard.SaveImageEx(document.IDScanRecog.ImgPath.value,nImg);  
    }
    else
    {
       // document.IDScanRecog.result.innerText = "Please successful loading recognition engine.";
    }
   
}
function DisplayResult()
{	
    // document.IDScanRecog.result.innerText = "";   
     var strResult = "recognition successful\r\n";   
    
	
    var nFieldNum = objIDCard.GetRecogFieldNum();
     
    if(nFieldNum>0)
    {  
        for(var i=1;i<=nFieldNum;++i) 
        {
			strResult += objIDCard.GetFieldName(i);
			
			if(objIDCard.GetFieldName(i)=="住址"){
				$("#p_dz").val(objIDCard.GetRecogResult(i))
			}
			if(objIDCard.GetFieldName(i)=="所有人"){
				$("#p_xm").val(objIDCard.GetRecogResult(i))
			}
			if(objIDCard.GetFieldName(i)=="号牌号码"){
				var hphm = objIDCard.GetRecogResult(i);
				var head = hphm.substr(0,1);
				var head1 = hphm.substr(0,2);
				var end = hphm.substring(1);
				$("#hphm").val(head);
				$("#hphm_input").val(end);
				var hp = "${office.hp}";
				if(head1!=hp){
					//get postcode
					$.ajax({
						url: '${ctx}/vehicle/getPostCodeByHphm',
					 	datatype: "json",
				      	type: 'post',
				      	async:true,
				      	data:{hphm:head1},
				      	success: function (result) {
				      		$("#p_yb").val(result);
				      	}  
					});
				}
			}
			if(objIDCard.GetFieldName(i)=="车辆类型"){
				var hpzl = objIDCard.GetRecogResult(i);
				$("#p_cllx").val(hpzl);
				var status = false;
				if(hpzl.indexOf("小型")>=0||hpzl.indexOf("微型")>=0||hpzl.indexOf("轻型")>=0||hpzl.indexOf("轿车")>=0){
					$("#hpzl").val("02");
					status = true;
				}
				if(hpzl.indexOf("大型")>=0||hpzl.indexOf("中型")>=0||hpzl.indexOf("重型")>=0||hpzl.indexOf("专项")>=0){
					$("#hpzl").val("01");
					status = true;
				}
				if(hpzl.indexOf("摩托")>=0){
					$("#hpzl").val("07");
					status = true;
				}
				if(hpzl.indexOf("三轮")>=0||hpzl.indexOf("低速")>=0){
					$("#hpzl").val("13");
					status = true;
				}
				if(hpzl.indexOf("挂车")>=0){
					$("#hpzl").val("15");
					status = true;
				}
				if(hpzl.indexOf("学")>=0){
					$("#hpzl").val("16");
					status = true;
				}
				if(hpzl.indexOf("警")>=0){
					$("#hpzl").val("23");
					status = true;
				}
				if(status==false){
					$("#hpzl").val("01");
				}
			}
			if(objIDCard.GetFieldName(i)=="车辆识别代号"){
				var clsbdh = objIDCard.GetRecogResult(i);
				$("#cjh").val(clsbdh.substr(clsbdh.length-4));
				$("#h_clsbdh").val(clsbdh);
			}
			if(objIDCard.GetFieldName(i)=="使用性质"){
				var syxz = objIDCard.GetRecogResult(i);
				$("#p_syxz").val(syxz);
			}
			if(objIDCard.GetFieldName(i)=="注册日期"){
				var zcrq = objIDCard.GetRecogResult(i);
				$("#p_zcrq").val(zcrq);
			}
			if(objIDCard.GetFieldName(i)=="发证日期"){
				var fzrq = objIDCard.GetRecogResult(i);
				$("#p_fzrq").val(fzrq);
			}
			//alert(objIDCard.GetFieldName(i))
            strResult += ":";
            strResult += objIDCard.GetRecogResult(i);
			//alert(objIDCard.GetRecogResult(i));
			strResult += "\r\n";
        }
        query("1");
        $("#p_phone").focus(); 
    }
}
function checkDg(name)
{
	var x = document.getElementsByName(name); 
	var num = 0;
	for(var i = 0;i < x.length;i++)
	{ 
		if(x[i].checked == true)
		{ 
			num |= (1 << (x[i].value - 1));
		} 
	} 
	//alert("num: " +num);
	return num;
}
function checkVIZ()
{
	var x = document.getElementsByName("seeRead");
	for( var i = 0; i < x.length; i++)
	{
		if( x[i].checked == true)
			return x[i].value;
	}
	return 0;
}
function AutoClassifyCard()
{
	if( objIDCard.IsLoaded())
	{
		var nRet = objIDCard.GetGrabSignalType();
		if( nRet == 1)
		{          
          objIDCard.SetIDCardType(2,0);
          objIDCard.AddIDCardType(3,0);
          objIDCard.AddIDCardType(4,0);
          objIDCard.AddIDCardType(5,0);
          objIDCard.AddIDCardType(5,0);
          objIDCard.AddIDCardType(6,0);
          objIDCard.AddIDCardType(7,0);
          objIDCard.AddIDCardType(9,0);
          objIDCard.AddIDCardType(10,0);
          objIDCard.AddIDCardType(11,0);
          objIDCard.AddIDCardType(12,0);
          objIDCard.AddIDCardType(13,0);
          objIDCard.AddIDCardType(14,0);
          objIDCard.AddIDCardType(15,0);
		  objIDCard.AddIDCardType(16,0);
          objIDCard.AddIDCardType(22,0);
          objIDCard.AddIDCardType(25,0);
          objIDCard.AddIDCardType(26,0);
		  
		  //
		  var nResult = objIDCard.ClassifyIDCard();
		  if( nResult < 0)
		  {
			 var strError = "classify failed\r\nReturn Value：";
              strError += nResult;
              //document.IDScanRecog.result.innerText = strError;
              return;
		  }

		  var nCardType = nResult;
		  var nMainType = 0;//nResult >> 4; 
		  
		  //alert("nCardType: "+nCardType + "mainID: "+nMainType);
		  
		  var nDG = checkDg("DG");		//识别参数
		  var nImg = checkDg("image");
		  var nViz = checkVIZ();
		  
		  
		  if( nCardType == 1)
		  {
			nResult = objIDCard.RecogChipCard(nDG,nViz,nImg);
		  }
		  
		  if( nCardType == 2)
		  {
			nResult = objIDCard.RecogGeneralMRZCard(nViz,nImg);
		  }
		  
		  if( nCardType == 3)
		  {
			nResult = objIDCard.RecogCommonCard(nImg);
		  }
		  
		  if(nResult < 0)
		  { 
			var strError = "recognition failure\r\nReturn value：";
			strError += nResult;
			//document.IDScanRecog.result.innerText = strError;
			return;
		   } 
			

		  var arr = GetDGArr();
		  DisplayDG(arr,nCardType);

		  //display
          DisplayResult();
          //Save images
          //objIDCard.SaveImageEx(document.IDScanRecog.ImgPath.value,nImg); 
		}
	}
	else
	{
		//document.IDScanRecog.result.innerText="Please successful loading recognition engine.";
	}
}
function GetDGArr()
{
	var x = document.getElementsByName("DG"); 
	
	var arr = new Array();
	for(var i = 0;i < x.length;i++)
	{ 
		if(x[i].checked == true)
		{ 
			arr.push(x[i].value);
		} 
	} 
	return arr;
}
function DisplayDG(arr,nType)
{	
	//alert(arr);
	if( nType == 1)
	{
		var strResult = "DG information\r\n"
		for( var i = 0; i < arr.length; i++)
		{
			strResult += "DG" + arr[i];
			strResult += ": ";
			strResult += objIDCard.GetDataGroupContent(arr[i],1);
			strResult += "\r\n";
		}
		//document.IDScanRecog.DGinfo.innerText = strResult;
		alert(strResult)
	}
	else
	{
		var strResult = "not any DG info!"
		//document.IDScanRecog.DGinfo.innerText = strResult;
	}
}
setInterval("AutoClassifyCard()", 100);
</script>
<!-- 读取身份证 -->
<script for=idcard event="Readed()">
      getinfo_onclick();
</script>
<script>
function getinfo_onclick(){
	var  r1,r2;
	$('#p_dlrxm').val(rdcard.NameL);
	//$('#p_dz').val(rdcard.Address);
	$("#brstatus").attr("checked", true);
	$('#rec').html("身份读取成功！");
	layer.close(la);
	
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
			$('#rec').html("");
	        }
	        else
	        {	
	            //document.getElementsByName("tResult")[0].value="ReadCard2失败: "+pp;
	            $('#rec').html("身份读取失败！"+pp);
	        }
		}
	$(function(){
		//beginread_onclick();
		$("#p_phone").keydown(function(event){
		    event=document.all?window.event:event;
		    if((event.keyCode || event.which)==13){
		    	$("#print_sqb").focus();
		    	return false;
		    }
		   }); 
		LoadRecogKenal();
		var hp = "${office.hp}";
		$("#hphm").val(hp.substring(0,1));
		$("#hphm_input").val(hp.substring(1));
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
</OBJECT>
<OBJECT style="float:right" classid="clsid:10EC554B-357B-4188-9E5E-AC5039454D8B" id="objIDCard" width="300" height="200"></OBJECT>
</div>
	<input type="hidden" id="h_cllx" />
	<input type="hidden" id="h_syxz" />
	<input type="hidden" id="h_ccrq" />
	<input type="hidden" id="h_ccdjrq" />
	<input type="hidden" id="h_clsbdh" />
	
	
<div class="search" align="center" >
  <table width="80%" class="table table-bordered" >
    <tr>
      <td align="right">号牌种类：
      </td>
      <td align="left">
      <select name="" id="hpzl" class="selectpicker" style="width: 60%;" >
            <option value="01">大型汽车</option>
            <option value="02" selected="selected">小型汽车</option>
            <option value="03">使馆汽车</option>
            <option value="07">普通摩托车</option>
            <option value="08">轻便摩托车</option>
            <option value="13">低速车</option>
            <option value="14">拖拉机</option>
            <option value="15">挂车</option>
            <option value="16">教练汽车</option>
            <option value="23">警用汽车</option>
          </select>
      </td>
      <td align="right">号牌号码：
      </td>
      <td align="left">
          <select id="hphm" class="selectpicker"  style="width: 20%;" >
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
            <option value="鲁">鲁</option>
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
        <input name="" type="text" value="" class="required" id="hphm_input"  style="width: 40%;" />
        <input name="" type="text"  id="cjh" class="required" maxlength="4"  style="width: 20%;" placeholder="后四位" />
        </td>
      <td rowspan="8" > 
      	<input name="" type="button"  class="btn btn-primary" <c:if test='${user.queryStatus==0}'>disabled="disabled"</c:if>  value="调取联系方式" onclick="query(1);" />
      	<br>
      	<br>
      	<input name="" type="button" class="btn btn-primary"  <c:if test='${user.queryStatus==0}'>disabled="disabled"</c:if>  value="调取全部信息" onclick="query(0);" />
      	<br>
      	<br> 
      	<input name="" type="button"  class="btn btn-primary"   value="读身份证信息" onclick=" beginread_onclick();" />
      	<br>
      	<br>
      	<input name="" type="button"  class="btn btn-primary"   value="读行驶证信息" onclick=" RecognizeImg();" />
       </td>
    </tr>
     <tr>
      <td align="right">姓名/名称：</td>
      <td align="left" colspan="3" ><input id="p_xm" type="text" style="width:91%;" placeholder="输入车主姓名" value="" /></td>
       <!-- <td > 
      	<input name="" type="button" class="btn btn-primary"    value="调取全部信息" onclick="query(0);" />
       </td> -->
     </tr>
     <tr>
     <td align="right">邮寄地址：</td>
      <td align="left" colspan="3" ><input  id="p_dz" type="text" style="width:91%;" placeholder="输入联系地址" value=""  /></td>
      <!-- <td > 
        <input name="" type="button"  class="btn btn-primary"   value="读身份证信息" onclick=" beginread_onclick();" />
       </td> -->
       </tr>
     <tr>
      <td align="right">邮编号码：</td>
      <td align="left"><input class="sr-1" id="p_yb" type="text" style="width:90%;" placeholder="输入邮编" value="${office.zipCode}" /></td>
      <td align="right">联系电话：</td>
      <td align="left"><input class="sr-1" id="p_phone" type="text" style="width:84%;" placeholder="输入联系电话" value=""  /></td>
     </tr>
     <tr>
      <td align="right">使用性质：</td>
      <td align="left"><input class="sr-1" id="p_syxz" type="text" style="width:90%;" placeholder="" value="" /></td>
      <td align="right">车辆类型：</td>
      <td align="left"><input class="sr-1" id="p_cllx" type="text" style="width:84%;" placeholder="" value=""  /></td>
      <!-- <td > 
        <input name="" type="button"  class="btn btn-primary"   value="读行驶证信息" onclick=" RecognizeImg();" />
       </td> -->
     </tr>
     <tr>
      <td align="right">登记日期：</td>
      <td align="left"><input class="sr-1" id="p_zcrq" type="text" style="width:90%;" placeholder="" value="" /></td>
      <td align="right">出厂日期：</td>
      <td align="left"><input class="sr-1" id="p_fzrq" type="text" style="width:84%;" placeholder="" value=""  /></td>
     </tr>
      <tr>
      <td align="right">里程表读数：</td>
      <td align="left"><input class="sr-1" id="p_lcb" type="text" style="width:90%;" placeholder="输入里程表" value="" /></td>
      <td align="right">代理人：</td>
      <td align="left">
      <input type="checkbox" id="brstatus" style=" width:20px;height:20px;"  />
      <input class="sr-1" id="p_dlrxm" style="width:77%;" type="text" placeholder="输入代理人姓名" value="" /></td>
     </tr>
     <tr>
      <td colspan="3" > 
      <input name="" type="button"  class="btn btn-primary" id="print_sqb" style="height: 40px;width: 100px;" value="打印申请表" onclick="printPzsq(1);" /> 
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="" type="button"  class="btn btn-primary" style="height: 40px;width: 100px;" value="打印外检表" onclick="printPzsq(2);" />
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input name="" type="button"  class="btn btn-primary" style="height: 40px;width: 100px;" value="全部&nbsp;打印" onclick="printPzsq(0);" /> 
      </td>
      <td id="rec" style="font-size: 25px;" ></td>
     </tr> 
  </table>
  </div>
</body>
</html>
