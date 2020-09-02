<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<script type="text/javascript">
	$(document).ready(function(){
		$(".contents .menu li:eq(0) a").prop("href", root_url +"/course/mathink");
		$(".contents .menu li:eq(1) a").prop("href", root_url +"/course/mathink/process");
	});
	</script>

	<div id="container">
		<div class="contents">
			<jsp:include page="menu.jsp" flush="true" />

			<div class="section nav">
				<div class="subtit">
					<h4>
						<b>초등교육</b>
					</h4>
				</div>
				<ol class="menu">
					<li <c:if test="${fn:indexOf(recentUrl,'process') eq -1 }">class="selected"</c:if> ><a href="">매씽크 소개</a></li>
					<li <c:if test="${fn:indexOf(recentUrl,'process') > -1 }">class="selected"</c:if> ><a href="">프로그램 특징</a></li>
				</ol>
			</div>
			<div class="section">
				<div class="subtit wide">
					<h4>매씽크 소개</h4>
					<div class="copy">
						<h5>매씽크, 초등수학의 <b>45가지 핵심개념</b>을 확실하게 정복합니다.</h5>
						<h6><label>교육대상</label> 초등학교 4 ~ 6학년</h6>
						<h6 class="multi">중.고등까지 연계되는 초등수학 핵심 개념 45가지를 학습하고, 메타인지를 기반으로 주어진 문제에 필요한 개념을
확실히 이해하고, 말로 설명할 수 있는 최고의 Output활동인 개념드림트리로 완성하는 초등 전문 수학 프로그램입니다.</h6>
					</div>
				</div>
			</div>
			<div class="section">
				<div class="video-wrapper">
					<iframe width="853" height="480" src="https://www.youtube.com/embed/8WBxGewAZv0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
				</div>
			</div>
			<!--
			<div class="section">
				<div class="subtit"> 
					<h5>매씽크는 중.고등수학과 연계하여 깊이 있게 학습해야 할 초등수학개념을<br> <strong>45가지 핵심개념</strong>으로 세분화 하여 구성하고 확실하게 학습하여 초등교과를 완성합니다.</h5>
				</div>
			</div>
			-->
			<div class="section">
				<div class="graph">
					<img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathink_intro.jpg" class="mathink_info" />
				</div>
			</div>
		</div>
	</div>
