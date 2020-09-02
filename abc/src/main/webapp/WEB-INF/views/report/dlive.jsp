<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=1202, user-scalable=yes">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv="Pragma" content="no-cache">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="mobile-web-app-capable" content="yes">
	<title>DLIVE EVENT</title>

	<%-- Hannibal: 추적코드 적용 (2018.05.10) --%>
	<jsp:include page="../common/statistics.jsp"/>

	<script type="text/javascript" src="https://ehr.gojls.com/resources/datatables/jquery/jquery-2.2.4.min.js"></script>
	<script type="text/javascript" src="https://ehr.gojls.com/resources/datatables/jqueryui/jquery-ui.min.js"></script>
	<script type="text/javascript" src="https://event.gojls.com/resources/js/dlivereport.js"></script>	
	<link rel="stylesheet" type="text/css" href="//image.gojls.com/hr/css/reset.css">
	<style type="text/css">
		body{-webkit-text-size-adjust:none; overflow:hidden;}
		#wrap{min-width:1250px;}
		#info{position:absolute; z-index:2; top:0px; left:0; right:0; background:#fbfbfb; border-bottom:1px solid #ddd;}
		#container{position:absolute; z-index:1; top:59px; bottom:30px; left:0; right:0; width:auto; min-width:700px; overflow-x:auto; overflow-y:auto;}
		#footer{position:fixed; z-index:3; left:0; right:0; bottom:0; height:30px;}

		/* info - title area */
		#info .tit_area{padding:10px 5px; height:40px; background-color:#fff;}
		#info .tit_area>h3{position:relative; display:inline-block; margin-right:30px; font-family:"NanumSquare"; font-weight:400; font-size:24px; vertical-align:middle; letter-spacing:-1px;}
		#info .tit_area>h3:before{content:''; position:absolute; right:-21px; top:3px; border:10px solid transparent; border-right:0; border-left:8px solid #bbb;}
		#info .tit_area>h3:after{content:''; position:absolute; right:-20px; top:3px; border:10px solid transparent; border-right:0; border-left:8px solid #fff;}
		#evaluationGroupName{border:1px solid #1278bc; color:#1278bc; font-family:"NanumSquare"; font-weight:500; font-size:18px;}

		/* container */
		#container{background-color:#fffbf2;}
		#container .contents{padding:30px;}

		.container_box{color:#333;}
		.contents table{width:100%;}
		.contents table th{padding:8px 5px; background-color:#f1f1f1; border:1px solid #bbb; color:#555; font-size:12px; text-align:center; white-space:nowrap;}
		.contents table td{position:relative; padding:5px;; border:1px solid #bbb; text-align:center;}
		.contents table tr{background-color:#fff}
		.contents table tr.selected td{height:35px;background-color:#fffbc6;}
		.contents table td img{vertical-align:middle;}
		.contents table td label.info{display:inline-block; margin-right:5px; padding:2px; width:65px; border:1px solid #888; border-radius:2px; background-color:#999; color:#fff; font-size:11px;}
		.contents table td label.info.completed{border:1px solid #77ac44; background-color:#8ac452;}
		.contents table td label.info.delay{border:1px solid #fb9503; background-color:#fbb103;}
	</style>
</head>

<body>
<div id="wrap">
	<div id="info">
		<div class="tit_area">
			<h3>이벤트</h3>
			 <select id="eventListCombo" name="eventList">
				<c:forEach items="${eventList}" var="item">
					<option value="${item.eventSeq}">${item.eventTitle}</option>
				</c:forEach>
			</select>
			
			<h3>분원이름</h3>
			<select id="deptListCombo" name="deptList">
				<option value="ALL">ALL</option>
				<c:forEach items="${deptList}" var="item">
					<option value="${item.sequence}">${item.deptName}</option>
				</c:forEach>
			</select>
		</div>
	</div>

	<div id="container">
		<div id="contents">
		<table >
			<thead><tr>
				<th width="80px" >순번</th>
	   			<th width="200px">분원</th>
	   			<th width="120px">학생 SID</th>
				<th width="120px">학생 ID</th>
				<th width="100px">학생이름</th>
				<th width="70px">타입</th>
				<th width="120px">이미지</th>
				<th width="300px">Comment</th>
				<th width="120px">제출일</th></tr>
			</thead>
			<c:forEach begin="1" end="30" var="i">
				<tr id="report${i}">  
					<th class="no"></th>
					<th class="dept"></th>
					<th class="user_seq"></th>
					<th class="user_id"></th>
					<th class="user_name"></th>
					<th class="type"></th>
					<th class="image"><img src="//image.gojls.com/newjls/img/event/20170907_event/photo.gif" width="120px" height="120px" /></th>
					<th class="comment"></th>
					<th class="date"></th>
				</tr>
			</c:forEach>
		</table>
		</div>
	</div>
	<div id="footer">
		<div class="menu" id="pagemenu"></div>
	</div>
</div>
</body>
</html>