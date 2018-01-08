<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>车辆管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
			
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出车辆数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/vehicle/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			
			$("#btnDelte").click(function(){
				var ids = "";
				$('input:checkbox[name=vheId]:checked').each(function(i){
					ids = ids + $(this).val()+",";
				});
				if(ids==""){
					$.jBox.info("请选择要删除的数据！");
					return;
				}
				top.$.jBox.confirm("确认要删除车辆数据吗？","系统提示",function(v,h,f){
						if(v=="ok"){
							$.ajax({
								url:"${ctx}/vehicle/deleteByIds",
								datatype: "json",
						      	type: 'post',
						      	async:false,
						      	data:{vehIds:ids},
						      	success: function (result) {
						      		if(result=="1"){
						      			$.jBox.info("删除数据成功！");
						      			$("#btnSubmit").click();
						      		}else{
						      			$.jBox.info("删除数据失败！错误信息："+result);
						      		}
						      	}        
							});
						}
					}
				);
			});
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
		function selectAll(){  
		    if ($("#checkAll").attr("checked")) {  
		        $(":checkbox").attr("checked", true);  
		    } else {  
		        $(":checkbox").attr("checked", false);  
		    }  
		} 
		function takePicture(){
			window.open ( "${ctxStatic}/index2.htm"+"?"+Math.random()) ;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/dict/">车辆列表</a></li>
		<%-- <shiro:hasPermission name="sys:dict:edit"><li><a href="${ctx}/vehicle/form?sort=10">车辆添加</a></li></shiro:hasPermission> --%>
		<%-- <li><a href="${ctx}/vehicle/form?sort=10">车辆添加</a></li> --%>
	</ul>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/vehicle/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctxStatic}/template/vehicle_model.xls">下载模板</a>
		</form>
	</div>
	
	<form:form id="searchForm" modelAttribute="vehicle" action="${ctx}/vehicle/vehList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>号牌种类：</label><form:select id="type" path="hpzl" class="input-medium"><form:option value="" label=""/><form:options items="${frmCodeList}" itemLabel="dmsm1" itemValue="dmz"/></form:select> 
		<label>号牌号码  ：</label><form:input path="hphm" htmlEscape="false" maxlength="50" class="input-medium"/>
		<label>开始时间 ：</label><input type="text" name="beginPrintDate" value="<fmt:formatDate value="${vehicle.beginPrintDate}" pattern="yyyy-MM-dd"/>"  class="input-mini Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
		<label>结束时间 ：</label><input type="text" name="endPrintDate" value="<fmt:formatDate value="${vehicle.endPrintDate}" pattern="yyyy-MM-dd"/>"   class="input-mini Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
		<c:if test="${isAdmin==1 }"> 
		<br><br>
			<label class="control-label">归属部门：</label>
                <sys:treeselect id="office" name="officeId" value="${vehicle.officeId}" labelName="officeName" labelValue="${vehicle.officeName}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" notAllowSelectParent="true"/>
		</c:if>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
		<input id="btnImport" class="btn btn-primary" type="button" value="导入"/>
		<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
		
		<input id="btnDelte" class="btn btn-primary" type="button" value="删除"/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th><input id="checkAll" onclick="selectAll()" type="checkbox" ></th><th>号牌种类</th><th>号牌号码</th><th>所有人</th><th>联系方式</th><th>操作日期</th><th>操作</th></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="veh">
			<tr>
				<td><input type="checkbox" name="vheId" value="${veh.vheId}" > </td>
				<td>${veh.hpzlmc}</td>
				<td>${veh.hphm}</td>
				<td>${veh.syr}</td>
				<td>${veh.lxdh}</td>
				<td><fmt:formatDate value="${veh.printDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>
					<a href="${ctx}/vehicle/delete?vheId=${veh.vheId}" onclick="return confirmx('确认要删除该车辆信息吗？', this.href)">删除</a>
					
					<a href="${ctxStatic}/index.htm?hphm=${veh.hphm}" target='_blank'>拍照</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>