<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<link href="${ctxStatic}/css/login.css" rel="stylesheet">
	<title>${fns:getConfig('productName')} 登录</title>
	<meta name="decorator" content="blank"/>
	<style type="text/css">
      html,body,table{background-color:#f5f5f5;width:100%;text-align:center;background-image: /static/background.jpg;}.form-signin-heading{font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;font-size:36px;color:#0663a2;}
     
      .form-signin .checkbox{margin-bottom:10px;color:#0663a2;} .form-signin .input-label{font-size:16px;line-height:23px;color:#999;}
      .form-signin .input-block-level{font-size:16px;height:auto;margin-bottom:15px;padding:7px;*width:283px;*padding-bottom:0;_padding:7px 7px 9px 7px;}
      .form-signin .btn.btn-large{font-size:16px;} .form-signin #themeSwitch{position:absolute;right:15px;bottom:10px;}
      .form-signin div.validateCode {padding-bottom:15px;} .mid{vertical-align:middle;}
      .header{height:60px;} .alert{position:relative;width:300px;margin:0 auto;*padding-bottom:0px;}
      label.error{background:none;width:270px;font-weight:normal;color:inherit;margin:0;}
    </style>
    <style type="text/css">.com-zoom-flash{position:absolute;bottom:0;right:0;height:10px;width:10px;}.com-zoom-tips-hack{height:2em;display:none;}.com-zoom-warn{display:none;position:fixed;top:0;left:0;width:100%;line-height:2em;text-align:center;background-color:#ffffcc;font-size:1.2em;color:#8e0000;z-index:9999;}.com-zoom-close{float:right;width:2em;height:1.7em;line-height:1.7em;font-weight:bold;font-family:"Tahoma";color:#8e0000;text-decoration:none;}.com-zoom-close:hover{color:#d8ab57;}.com-zoom-notip{color:#3e3e3e;text-decoration:underline;}.com-zoom-notip:hover{text-decoration:none;}.com-zoom-text{margin:0;}</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
	</script>
</head>
<body onload="load()" style="background-image: ${ctxStatic}/background.jpg" >
<script src="${ctxStatic}/softdog/Syunew3.js"></script><!--定要包含有我们的UK单元包-->
<SCRIPT LANGUAGE=javascript>

var bConnect=0;
 
function load()
{
	//如果是IE10及以下浏览器，则跳过不处理
    if(navigator.userAgent.indexOf("MSIE")>0 && !navigator.userAgent.indexOf("opera") > -1) return;
    try
    {
        var s_pnp=new SoftKey3W();
         s_pnp.Socket_UK.onopen = function() 
        {
               bConnect=1;//代表已经连接，用于判断是否安装了客户端服务
        } 
        
        //在使用事件插拨时，注意，一定不要关掉Sockey，否则无法监测事件插拨
        s_pnp.Socket_UK.onmessage =function got_packet(Msg) 
        {
            var PnpData = JSON.parse(Msg.data);
            if(PnpData.type=="PnpEvent")//如果是插拨事件处理消息
            {
                if(PnpData.IsIn) 
                {
                        alert("UKEY已被插入，被插入的锁的路径是："+PnpData.DevicePath);
                }
                else
                {
                        alert("UKEY已被拨出，被拨出的锁的路径是："+PnpData.DevicePath);
                }
            }
        } 
        
        s_pnp.Socket_UK.onclose = function()
        {
            
        }
   }
   catch(e)  
   {  
        alert(e.name + ": " + e.message);
        return false;
    }  
}

 var digitArray = new Array('0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f');

function toHex( n ) {

        var result = ''
        var start = true;

        for ( var i=32; i>0; ) {
                i -= 4;
                var digit = ( n >> i ) & 0xf;

                if (!start || digit != 0) {
                        start = false;
                        result += digitArray[digit];
                }
        }

        return ( result == '' ? '0' : result );
}

function login_onclick() 
{
	//如果是IE10及以下浏览器，则使用AVCTIVEX控件的方式
	if(navigator.userAgent.indexOf("MSIE")>0 && !navigator.userAgent.indexOf("opera") > -1) return Handle_IE10();
	
   //判断是否安装了服务程序，如果没有安装提示用户安装
    if(bConnect==0)
    {
        window.alert ( "未能连接服务程序，请确定服务程序是否安装。");return false;
        return false;
    }
    
   	var DevicePath,ret,n,mylen,ID_1,ID_2,addr;
	try
	{
			
		 //由于是使用事件消息的方式与服务程序进行通讯，
		    //好处是不用安装插件，不分系统及版本，控件也不会被拦截，同时安装服务程序后，可以立即使用，不用重启浏览器
		    //不好的地方，就是但写代码会复杂一些
			var s_simnew1=new SoftKey3W(); //创建UK类
			
		    s_simnew1.Socket_UK.onopen = function() {
		   	   s_simnew1.ResetOrder();//这里调用ResetOrder将计数清零，这样，消息处理处就会收到0序号的消息，通过计数及序号的方式，从而生产流程
		    } 

           
		 //写代码时一定要注意，每调用我们的一个UKEY函数，就会生产一个计数，即增加一个序号，较好的逻辑是一个序号的消息处理中，只调用我们一个UKEY的函数
	    s_simnew1.Socket_UK.onmessage =function got_packet(Msg) 
	    {
	        var UK_Data = JSON.parse(Msg.data);
	        // alert(Msg.data);
	        if(UK_Data.type!="Process")return ;//如果不是流程处理消息，则跳过
	        switch(UK_Data.order) 
	        {
	            case 0:
	                {
	                    s_simnew1.FindPort(0);//发送命令取UK的路径
	                }
	                break;//!!!!!重要提示，如果在调试中，发现代码不对，一定要注意，是不是少了break,这个少了是很常见的错误
	            case 1:
	                {
	                    if( UK_Data.LastError!=0){
	                    	window.alert ( "未发现加密锁，请插入加密锁");
	                    	s_simnew1.Socket_UK.close();
	                    	return false;
	                    	} 
	                    DevicePath=UK_Data.return_value;//获得返回的UK的路径
	                    s_simnew1.GetID_1(DevicePath); //发送命令取ID_1
	                }
	                break;
	            case 2:
	                {
	                    if( UK_Data.LastError!=0){ window.alert("返回ID号错误，错误码为："+UK_Data.LastError.toString());s_simnew1.Socket_UK.close();return false;} 
	                    ID_1=UK_Data.return_value;//获得返回的UK的ID_1
	                    s_simnew1.GetID_2(DevicePath); //发送命令取ID_2
	                }
	                break;
	             case 3:
	                {
	                    if( UK_Data.LastError!=0){ window.alert("取得ID错误，错误码为："+UK_Data.LastError.toString());s_simnew1.Socket_UK.close();return false;} 
	                     ID_2=UK_Data.return_value;//获得返回的UK的ID_2
	                     
	                     frmlogin.KeyID.value=toHex(ID_1)+toHex(ID_2);
	                     
	                     s_simnew1.ContinueOrder();//为了方便阅读，这里调用了一句继续下一行的计算的命令，因为在这个消息中没有调用我们的函数，所以要调用这个
	                }
	                break;
	             case 4:
	                {
	                    //获取设置在锁中的用户名
			            //先从地址0读取字符串的长度,使用默认的读密码"FFFFFFFF","FFFFFFFF"
			            addr=0;
			            s_simnew1.YReadEx(addr,1,"ffffffff","ffffffff",DevicePath);//发送命令取UK地址0的数据
	                }
	                break;
	            case 5:
	                {
	                    if( UK_Data.LastError!=0){ window.alert("读数据时错误，错误码为："+UK_Data.LastError.toString());s_simnew1.Socket_UK.close();return false;} 
	                    s_simnew1.GetBuf(0);//发送命令从数据缓冲区中数据
	                }
	                break;
	            case 6:
	                {
	                    if( UK_Data.LastError!=0){ window.alert("调用GetBuf时错误，错误码为："+UK_Data.LastError.toString());s_simnew1.Socket_UK.close();return false;} 
	                    mylen=UK_Data.return_value;//获得返回的数据缓冲区中数据
	                    
	                    //再从地址1读取相应的长度的字符串，,使用默认的读密码"FFFFFFFF","FFFFFFFF"
	                    addr=1;
	                    s_simnew1.YReadString(addr,mylen, "ffffffff", "ffffffff", DevicePath);//发送命令从UK地址1中取字符串
	                }
	                break;
	            case 7:
	                {
	                    if( UK_Data.LastError!=0){ window.alert("读取字符串时错误，错误码为："+UK_Data.LastError.toString());s_simnew1.Socket_UK.close();return false;} 
	                    frmlogin.UserName.value=UK_Data.return_value;//获得返回的UK地址1的字符串
	                    
	                    //获到设置在锁中的用户密码,
			            //先从地址20读取字符串的长度,使用默认的读密码"FFFFFFFF","FFFFFFFF"
			            addr=20;
			            s_simnew1.YReadEx(addr,1,"ffffffff","ffffffff",DevicePath);//发送命令取UK地址20的数据
	                }
	                break;
	            case 8:
	                {
	                    if( UK_Data.LastError!=0){ window.alert("读数据时错误，错误码为："+UK_Data.LastError.toString());s_simnew1.Socket_UK.close();return false;} 
	                    s_simnew1.GetBuf(0);//发送命令从数据缓冲区中数据
	                }
	                break;
	            case 9:
	                {
	                    if( UK_Data.LastError!=0){ window.alert("调用GetBuf时错误，错误码为："+UK_Data.LastError.toString());s_simnew1.Socket_UK.close();return false;} 
	                    mylen=UK_Data.return_value;//获得返回的数据缓冲区中数据
	                    
	                    //再从地址21读取相应的长度的字符串，,使用默认的读密码"FFFFFFFF","FFFFFFFF"
	                    addr=21;
	                    s_simnew1.YReadString(addr,mylen,"ffffffff", "ffffffff", DevicePath);//发送命令从UK地址21中取字符串
	                }
	                break;
	             case 10:
	                {
	                    if( UK_Data.LastError!=0){ window.alert("读取字符串时错误，错误码为："+UK_Data.LastError.toString());s_simnew1.Socket_UK.close();return false;} 
	                    frmlogin.Password.value=UK_Data.return_value;//获得返回的UK中地址21的字符串
	                    
	                    //这里返回对随机数的HASH结果
	                    s_simnew1.EncString(frmlogin.rnd.value,DevicePath);//发送命令让UK进行加密操作
	                    
	                }
	                break;
	             case 11:
	                {
	                    if( UK_Data.LastError!=0){ window.alert("进行加密运行算时错误，错误码为："+UK_Data.LastError.toString());s_simnew1.Socket_UK.close();return false;} 
	                    frmlogin.return_EncData.value=UK_Data.return_value;//获得返回的加密后的字符串
	                     
	                     //!!!!!注意，这里一定要主动提交，
                        frmlogin.submit (); 
 
	                     //所有工作处理完成后，关掉Socket
	                     s_simnew1.Socket_UK.close();
	                }
	                break;
            }
	    } 
	    s_simnew1.Socket_UK.onclose = function(){

	    }
		return true;
	}
	catch (e) 
	{
		alert(e.name + ": " + e.message);
	}

}

function Handle_IE10() 
{
	var DevicePath,ret,n,mylen;
	try
	{
	
		//建立操作我们的锁的控件对象，用于操作我们的锁
        var s_simnew1;
	    //创建控件

		s_simnew1=new ActiveXObject("Syunew3A.s_simnew3");

        
		var username = $("#username").val();
		 if(username!="thinkgem"){
	        //查找是否存在锁,这里使用了FindPort函数
			DevicePath = s_simnew1.FindPort(0);
			if( s_simnew1.LastError!= 0 )
			{
				/* window.alert ( "未发现加密锁，请插入加密锁。");
				return false; */
			}
			 //'读取锁的ID
			 
			var keyID = toHex(s_simnew1.GetID_1(DevicePath))+toHex(s_simnew1.GetID_2(DevicePath));
	        if( s_simnew1.LastError!= 0 )
			{
	            /* window.alert( "返回ID号错误，错误码为："+s_simnew1.LastError.toString());
		        return false; */
			}
	        if(keyID==null||keyID==""){
	        	/* window.alert( "返回ID号错误");
		        return false; */
	        }
	        $("#softdog").val(keyID);
         }
       
		/* //获取设置在锁中的用户名
		//先从地址0读取字符串的长度,使用默认的读密码"FFFFFFFF","FFFFFFFF"
		ret=s_simnew1.YReadEx(0,1,"ffffffff","ffffffff",DevicePath);
		mylen =s_simnew1.GetBuf(0);
		//再从地址1读取相应的长度的字符串，,使用默认的读密码"FFFFFFFF","FFFFFFFF"
		frmlogin.UserName.value=s_simnew1.YReadString(1,mylen, "ffffffff", "ffffffff", DevicePath);
		if( s_simnew1.LastError!= 0 )
		{
			window.alert(  "读取用户名时错误，错误码为："+s_simnew1.LastError.toString());
			return false;
		}

		//获到设置在锁中的用户密码,
		//先从地址20读取字符串的长度,使用默认的读密码"FFFFFFFF","FFFFFFFF"
		ret=s_simnew1.YReadEx(20,1,"ffffffff","ffffffff",DevicePath);
		mylen =s_simnew1.GetBuf(0);
		//再从地址21读取相应的长度的字符串，,使用默认的读密码"FFFFFFFF","FFFFFFFF"
		frmlogin.Password.value=s_simnew1.YReadString(21,mylen,"ffffffff", "ffffffff", DevicePath);
		if( s_simnew1.LastError!= 0 )
		{
			window.alert( "读取用户密码时错误，错误码为："+s_simnew1.LastError.toString());
			return false;
		}

		//这里返回对随机数的HASH结果
		frmlogin.return_EncData.value=s_simnew1.EncString(frmlogin.rnd.value,DevicePath);
		if( s_simnew1.LastError!= 0 )
		{
				window.alert( "进行加密运行算时错误，错误码为："+s_simnew1.LastError.toString());
				return false;
		}
		frmlogin.submit();	
		
		return ; */

	}
	catch (e) 
	{
		alert(e.name + ": " + e.message+"。可能是没有安装相应的控件或插件");
	}
}

</SCRIPT>
 


	<!--[if lte IE 6]><br/><div class='alert alert-block' style="text-align:left;padding-bottom:10px;"><a class="close" data-dismiss="alert">x</a><h4>温馨提示：</h4><p>你使用的浏览器版本过低。为了获得更好的浏览体验，我们强烈建议您 <a href="http://browsehappy.com" target="_blank">升级</a> 到最新版本的IE浏览器，或者使用较新版本的 Chrome、Firefox、Safari 等。</p></div><![endif]-->
	<div class="header">
		<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
			<label id="loginError" class="error">${message}</label>
		</div>
	</div>
	<h1 class="form-signin-heading"><img src="${ctxStatic}/images/login/lg-logo.png" width="662" height="100"></h1>
	<form id="loginForm" class="form-signin" action="${ctx}/login" method="post">
	 <div class="login-text">
	 	<p  style="margin-top:30px; font-size:20px; padding-top:50px;">用户登录</p>
		<label class="input-label" for="username"></label>
		<input type="text" id="username" name="username" class="input-block-level required" value="${username}">
		<label class="input-label" for="password"></label>
		<input type="password" id="password" name="password" class="input-block-level required">
		<input type="hidden" id="softdog" name="softdog" class="input-block-level required">
		<c:if test="${isValidateCodeLogin}"><div class="validateCode">
			<label class="input-label mid" for="validateCode"></label>
			<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
		</div></c:if>
		<!-- <div align="center" > <input class="btn btn-large btn-primary" type="submit"  value="登 录"/>&nbsp;&nbsp; </div> -->
		<div align="center" > <input class="btn btn-large btn-primary" type="submit" onclick="return login_onclick();"  value="登 录"/>&nbsp;&nbsp; </div>
		<div id="themeSwitch" class="dropdown">
		</div>
		</div>
	</form>
	<div class="footer">
		Copyright &copy; ${fns:getConfig('copyrightYear')} <a href="javacript:void();">${fns:getConfig('productName')}</a> - Powered By <a href="javacript:void();" >山东乐行网络科技有限公司</a> ${fns:getConfig('version')} 
	</div>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
</body>
</html>