<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
	$(document).ready(function(){
		$("#memberJoin").click(function(){ location.href = "<spring:eval expression="@globalContext['MEMBERS_SSL_URL']" />/join/jointype";});
		$("#reservation").click(function(){	location.href= root_url +"/admission/online"; });
		$("#searchBranch").click(function(){ location.href= root_url +"/intro/search"; });
	});
</script>

	<div id="container">
		<jsp:include page="menu.jsp" flush="true" />
		<div class="contents">
			<div class="head">
				<div class="subimg"></div>
				<h3>입학안내</h3>
			</div>
			<div class="section">
				<div class="subtit wide">
					<h4><b>알고리즘에듀 모집안내</b></h4>
					<div class="copy">
						<h5>미래를 위한 교육과정​<br> <b> 알고리즘에듀</b> 신입생을 모집합니다.</h5>
						<h6><label>대상학년</label> 초등학교 4학년 ~ 중학교 3학년</h6>
						<h6><label>모집시기</label> <b class="red">현재 상시 모집 중</b><br>
						<label class="empty"></label>(시험 일정 등 자세한 내용은 입학하실 분원에 문의해주세요.)</h6>
					</div>
				</div>
			</div>
			<div class="section">
				<div class="subtit">
					<h4 class="small">입학절차</h4>
				</div>
				<ul class="process algorithmedu">
					<li>
						<h5>정상수학학원 온라인<br> 회원가입</h5>
						<button type="button" class="line small" id="memberJoin"><span>회원가입</span></button>
					</li>
					<li>
						<h5>분원에 입학 예약<br> (유선 또는 온라인)</h5>
						<button type="button" class="line small" id="searchBranch"><span>분원찾기</span></button>
						<button type="button" class="line small" id="reservation"><span>온라인 예약</span></button>
					</li>
					<li>
						<h5>분원방문 입학시험<br>(오프라인)</h5>
					</li>
					<li>
						<h5>반 배정 및 결과 상담<br> (1 Stop 안내)​</h5>
					</li>
				</ul>
			</div>
		</div>
	</div>
