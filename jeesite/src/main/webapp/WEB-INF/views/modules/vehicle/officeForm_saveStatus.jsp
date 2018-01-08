<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			var updateStatus = "${updateStatus}";
			if(updateStatus==1){
				alert("保存成功");
			}
		});
	</script>
</head>
<body>
	<form:form id="inputForm" modelAttribute="office" action="${ctx}/vehicle/updateOffice" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
				<label class="control-label">部门名称:</label>
				<div class="controls">
					<label class="lbl">${office.name}</label>
				</div>
			</div>
		<div class="control-group">
			<label class="control-label">是否保存车辆信息:</label>
			<div class="controls">
				<form:select path="saveStatus">
					<form:option value="" label="请选择"/>
					<form:options items="${fns:getDictList('softdog_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
		<label class="control-label">操作:</label>
			<div class="controls">
			 <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
			</div>
		</div>
	</form:form>
</body>
</html>