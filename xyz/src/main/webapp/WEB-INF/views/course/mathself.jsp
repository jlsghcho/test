<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<script type="text/javascript">
	$(document).ready(function(){
		$(".contents .menu li:eq(0) a").prop("href", root_url +"/course/mathself");
		$(".contents .menu li:eq(1) a").prop("href", root_url +"/course/mathself/process");
	});
	</script>

	<div id="container">
		<div class="contents">
			<jsp:include page="menu.jsp" flush="true" />

			<div class="section nav">
				<div class="subtit">
					<h4>
						<b>중.고등교육</b>
					</h4>
				</div>
				<ol class="menu">
					<li <c:if test="${fn:indexOf(recentUrl,'process') eq -1 }">class="selected"</c:if> ><a href="">매셀프 소개</a></li>
					<li <c:if test="${fn:indexOf(recentUrl,'process') > -1 }">class="selected"</c:if> ><a href="">프로그램 특징</a></li>
				</ol>
			</div>
			<div class="section">
				<div class="subtit wide">
					<h4>매셀프 소개</h4>
					<div class="copy">
						<h5><b>1:1 맞춤 수학</b> - 개념과 내신에 강한 중.고등 수학!</h5>
						<h6><label>교육대상</label> 중학교 1학년 ~ 고등학교 3학년</h6>
						<h6><label>수업구성</label> 개념중심학습프로세스, 4단계 내신성공전략, 1:1개별맞춤 시스템</h6>
					</div>
				</div>
			</div>
            <div class="section">
				<div class="graph">
					<img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_intro.png" class="mathself_info">
                    <img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_intro_text.png" class="mathself_info">
				</div>
			</div>
		</div>
	</div>
