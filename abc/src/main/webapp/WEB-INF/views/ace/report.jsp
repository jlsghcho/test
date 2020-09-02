<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
	<title>제출 현황</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=1024, user-scalable=yes">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">

	<%-- Hannibal: 추적코드 적용 (2018.05.10) --%>
	<jsp:include page="../common/statistics.jsp"/>

	<link href="//image.gojls.com/hr/img/jls.ico" rel="shortcut icon" type="image/x-icon"/>

	<script type="text/javascript" src="resources/datatables/jquery/jquery-2.2.4.min.js"></script>
	<script type="text/javascript" src="resources/datatables/jqueryui/jquery-ui.min.js"></script>
	<script type="text/javascript" src="resources/datatables/datatables/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="resources/datatables/datatables/js/dataTables.jqueryui.min.js"></script>
	<script type="text/javascript" src="resources/datatables/jszip/jszip.min.js"></script>
	<script type="text/javascript" src="resources/datatables/buttons/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" src="resources/datatables/buttons/js/buttons.jqueryui.min.js"></script>
	<script type="text/javascript" src="resources/datatables/buttons/js/buttons.colVis.min.js"></script>
	<script type="text/javascript" src="resources/datatables/buttons/js/buttons.html5.min.js"></script>

	<link rel="stylesheet" type="text/css" href="//image.gojls.com/hr/css/evaluation.css">
	<link rel="stylesheet" type="text/css" href="resources/datatables/buttons/css/buttons.dataTables.min.css"/>
	<style>	#container { bottom: 0; }</style>
	<style>
		ul li.floatLeft { float: left; }
		#container { bottom: 0; }
	</style>

	<script src="resources/js/admin-submitted-report.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var evaluationGroupName = $("#evaluationPeriodName");
			evaluationGroupName.change(updateFields);
			evaluationGroupName.ready(updateFields);
		});
	</script>
	
</head>
<body>
<div id="wrap">

	<div id="info">
		<div class="tit_area">
			<h3>제출현황</h3>
			<select id="departmentName">
				<c:forEach items="${departmentList}" var="department">
					<option value="${department.sequence}">${department.name}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	
	<div id="container" class="fold">
		<div class="contents">
			<div class="container_box">
				<div class="box-body">
					<table id="table" class="display"></table>
				</div>
			</div>
		</div>
	</div>
	
</div>
</body>
</html>
