<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<script type="text/javascript">
	var course_num = "${course_num}";
	
	$(document).ready(function(){
		$("#tab_2,#tab_3,#tab_4").hide();
		$(".contents .menu li:eq(0) a").prop("href", root_url +"/course/mathself");
		$(".contents .menu li:eq(1) a").prop("href", root_url +"/course/mathself/process");
		
		if(course_num != ""){ course(course_num); }
	});

	function course(m){
		var tab_num = "tab_"+ m;
		$("#tab_1,#tab_2,#tab_3,#tab_4").hide();
		$("#"+ tab_num).show();
		$(".contents .section .study_course li").removeClass("selected");
		$(".contents .section .study_course li").eq(m-1).addClass("selected");
	}

	function top_move(){ $('html, body').animate({scrollTop:$('#tmenu').offset().top-60}, 500); }
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
			<div id="tmenu" class="section">
				<div class="subtit hide">
					<h4>프로그램 특징</h4>
				</div>
				<ul class="study_course">
					<li class="fea1 selected" onclick="course(1);top_move();">
						<div class="bg"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/mathself_course_bg_1.jpg" /></div>
						<div class="tit">
							<h5>개념에 강하다</h5>
						</div>
						<div class="discription">
							<p>수학의 핵심은 개념! <br>개념을 잡으면 수학이 보인다!</p>
						</div>
					</li>
					<li class="fea2" onclick="course(2);top_move();">
						<div class="bg"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/mathself_course_bg_2.jpg" /></div>
						<div class="tit">
							<h5>내신에 강하다</h5>
						</div>
						<div class="discription">
							<p>매셀프만의 4단계 내신 성공 전략 <br>내신 만점이 보인다!</p>
						</div>
					</li>
					<li class="fea3" onclick="course(3);top_move();">
						<div class="bg"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/mathself_course_bg_3.jpg" /></div>
						<div class="tit">
							<h5>맞춤에 강하다</h5>
						</div>
						<div class="discription">
							<p>1:1 개별 맞춤! <br>수학실력 향상이 보인다!</p>
						</div>
					</li>
				</ul>
			</div>
			<div class="section" id="tab_1">
				<ul class="list illust">
					<li>
						<h4><b>Premium 개념동영상</b> - 정상수학에서만 들을 수 있는 원리를 꿰뚫는 '핵심개념 강의'</h4>
						<dl class="slist">
							<dd>쉽고 체계적인 개념 설명으로 수학 자신감 획득</dd>
							<dd>핵심 개념 잡고, 유형별 문제 풀고 고난도 문제까지 도전</dd>
						</dl>
                        <div class="point"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_feature_01_1.png" /></div>
					</li>
					<li>
						<h4><b>한눈에 보는 개념 Map</b> - 수학 계통도에 따라 현행 개념의 이해를 돕는 편리한 전후 개념 지도</h4>
						<dl class="slist">
							<dd>현행 개념 이해를 위해 미리 알고 있어야 하는 하위 필수 개념을 편리하게 확인하여 학습</dd>
							<dd>개인별 취약 개념을 손쉽게 찾아서 반복 학습할 수 있는 '나의 수학약점 극복 시스템'</dd>
							<dd>개념 심화 위한 상위 수학 개념을 체계적으로 찾아서 학습</dd>
						</dl>
						<div class="point"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_feature_01_2.png" /></div>
					</li>
					<li>
						<h4><b>문제 속 연결 개념</b> - 문제 속 개념을 이해하고 문제에 적용하는 방법 습득</h4>
						<dl class="slist">
							<dd>교재 속 문제들마다 그 연결개념을 확인할 수 있어, 단순 문제풀이를 넘어 그 문제의 개념을 더욱 탄탄히 학습할 수 있도록 구성</dd>
						</dl>
						<div class="point"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_feature_01_3.png" /></div>
					</li>
					<li>
						<h4><b>개념중심 학습프로세스</b> - 개념노트, 개념테스트, 개념마인드맵 등 최적의 개념 다지기 학습 진행</h4>
						<div class="point"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_feature_01_4.png" /></div>
					</li>
				</ul>
			</div>
			<div class="section" id="tab_2">
				<ul class="list illust step">
					<li>
						<h4><span>1단계 :</span> <b>개별맞춤 내신계획수립</b> - 나의 실력과 목표에 따라 ‘나만의 내신대비 전략’ 수립!</h4>
						<dl class="slist">
							<dd>‘내신 Perfect Study Planner’ 활용을 통해 체계적으로 내신대비</dd>
							<dd>선생님과 함께 나만의 목표점수와 맞춤형 학습 계획 수립</dd>
						</dl>
                        <div class="point"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_feature_02_1.png" /></div>
					</li>
					<li>
						<h4><span>2단계 :</span> <b>교과서 및 기본서 복습</b> - 개념 잡고, 교과서 정복하고, 나만의 약점 복습!</h4>
						<dl class="slist">
							<dd>개념과 주요 학습 내용 복습을 통해 기초를 강화하고 개인별 취약 영역 보완</dd>
							<dd>눈으로 읽는 수학개념, 교과서별 문제 모음, 학교별 프린트, 수업교재 및 오답노트</dd>
						</dl>
                        <div class="point"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_feature_02_2.png" /></div>
					</li>
					<li>
						<h4><span>3단계 :</span> <b>최신기출 및 서술형 완성</b> - 최신기출과 서술형 마스터로 고득점 실현</h4>
						<dl class="slist">
							<dd><b>내신퍼펙트 교재</b> :  취약영역 찾아 오답노트 자동 작성, 유사유형문제로 클리닉</dd>
							<dd><b>적중서술형문제지</b> : 선별된 서술형 문제를 통해 1:1 첨삭관리</dd>
						</dl>
                        <div class="point"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_feature_02_3.png" /></div>
					</li>
					<li>
						<h4><span>4단계 :</span> <b>실전 모의고사</b> - 실전 배양 및 적중률 높은 문제로 내신 만점 도전</h4>
						<dl class="slist">
							<dd><b>정상퍼펙트모의고사</b> : 실전형으로 정확한 취약 문제 분석을 통해 마무리 학습 방향을 제시</dd>
							<dd><b>적중 100% Final Test</b> : 수준별로 제공되는 마지막 점검 테스트</dd>
							<dd><b>학교별 기출문제지</b> : 1:1 맞춤 모의고사로 추가 학습</dd>
						</dl>
						<div class="point"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_feature_02_4.png" /></div>
					</li>
				</ul>

			</div>
			<div class="section" id="tab_3">
				<ul class="list illust">
					<li>
						<h4><b>1:1 맞춤학습</b></h4>
						<div class="group">
							<div class="float_l wp40">
								<dl class="slist">
									<dd>개별진도에 맞춘 차별화된 자체 교재(단원별 수준별)</dd>
									<dd>온라인 학습과 100% 연계되어 오답노트 자동 작성 등 학습 효율 증대</dd>
								</dl>
								<div class="point"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_feature_03_1.png" /></div>
							</div>
							<div class="float_r wp60">
								<dl class="slist">
									<dd>심화 단계를 위한 차별화된 맞춤 시스템</dd>
									<dd>학생 개인별 수준과 유형 강약점을 자동 분석하여 총 3단계에 걸쳐 개별 맞춤으로 완전학습 실현</dd>
								</dl>
								<div class="point"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_feature_03_2.png" /></div>
							</div>
						</div>
						<div class="point"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_feature_04_2.png" /></div>
						<dl class="slist">
							<dd><b>1:1 맞춤 Cmart Class</b> :  선생님의 1:1 코칭 타임을 자동으로 알려주는 스마트한 수업 환경</dd>
							<dd><b>1:1 맞춤 자동 난이도 조절 시스템</b> : 학생 개인별 학습수준과 적절한 학습량에 맞춰 제공되는 유사유형문제의 난이도와 문항 개수 조절</dd>
						</dl>
					</li>
					<li>
						<h4><b>1:1 맞춤관리</b></h4>
						<div class="point"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_feature_03_3.png" /></div>
						<div class="point"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathself_feature_03_4.png" /></div>
					</li>
				</ul>
			</div>
		</div>
	</div>
