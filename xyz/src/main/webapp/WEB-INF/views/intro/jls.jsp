<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
	<script type="text/javascript">
	$(document).ready(function(){
		
	});
	
	function location_href(){
		location.href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/intro/search";
	}
	</script>
	<div id="container">
		<jsp:include page="menu.jsp" flush="true" />
		<div class="contents">
			<div class="head">
				<div class="subimg"></div>
				<h3>학원소개</h3>
			</div>
			<div class="section full s01">
				<div class="top_area">
					<div class="bg">
						<div class="m g01"></div>
						<div class="m g02"></div>
						<div class="m g03"></div>
					</div>
					<div class="copy">
						<h4>코스닥대표 교육기업 정상제이엘에스의</h5>
						<h3>수학전문브랜드 정상수학학원_</h4>
						<h5>정상수학학원은 초등전문 매씽크부터 중고등전문 매셀프까지 연계된 통합 커리큘럼으로 구성 <br>매씽크를 마치면 그 누적된 학습성과를 토대로 학생 개별 맞춤으로 최적의 중등학습계획을 수립</h5>
					</div>
				</div>
			</div>
			<div class="section full s02">
				<div class="subtit">
					<h4><b>정상수학학원 정규 교육과정</b></h4>
				</div>
				<ul class="curriculum">
					<li class="mathink">
						<div class="level">
							<div class="ts">
								<dl>
									<dd><h6>T/S(E,F)</h6></dd>
									<dd><h6>T/S(C,D)</h6></dd>
									<dd><h6>T/S(A,B)</h6></dd>
								</dl>
								<h4>
									<b>초4~초6</b>
								</h4>
							</div>
							<div class="tm">
								<dl>
									<dd><h6>T/M(E,F)</h6></dd>
									<dd><h6>T/M(C,D)</h6></dd>
									<dd><h6>T/M(A,B)</h6></dd>
                                    <dd class="empty"><h6></h6></dd>
								</dl>
								<h4>
									<b>중1~중2</b>
								</h4>
							</div>
						</div>
						<h5>중.고등 수학과 연계되는<br>초등수학 핵심 개념 완성</h5>
						<button type="button" class="medium orange" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathink';"><span>자세히 보기</span></button>
					</li>
					<li class="mathself">
						<div class="level">
							<div class="middle">
								<dl>
									<dd><h6>M-C</h6></dd>
									<dd><h6>M-B</h6></dd>
									<dd><h6>M-A</h6></dd>
									<dd class="empty"><h6></h6></dd>
									<dd class="empty"><h6></h6></dd>
								</dl>
								<h4>
									<b>중1~중3</b>
								</h4>
							</div>
							<div class="high">
								<dl>
									<dd><h6>고3 <span>(수능,논술)</span></h6></dd>
									<dd><h6>고2 <span>(확률,미적,기하와 벡터)</span></h6></dd>
									<dd><h6>고1 <span>(수1,2)</span></h6></dd>
									<dd class="empty"><h6></h6></dd>
									<dd class="empty"><h6></h6></dd>
									<dd class="empty"><h6></h6></dd>
								</dl>
								<h4>
									<b>고1~고3</b>
								</h4>
							</div>
						</div>
						<h5>개별 맞춤 관리를 통한<br>내신&수능 1등급 완성</h5>
						<button type="button" class="medium blue" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathself';"><span>자세히 보기</span></button>
					</li>
				</ul>
			</div>
			
			<div class="section full">
				<div class="subtit"><h4><b>정상수학학원 코딩(소프트웨어) 교육과정</b></h4></div>
				<ul class="different">
					<li class="mathink">
                 		<img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_math_intro_05.png" class="d01" />
					</li>
				</ul>
            </div>
			
			<div class="section full s03">
				<div class="subtit">
					<h4><b>정상수학만의 차별화된 교육시스템</b></h4>
				</div>
				<ul class="different">
					<li class="mathink">
						<img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_math_intro_03.png" class="d01" />
						<h5>개념드림트리! 말로 설명할 수 있는 것이 진짜 아는 것이다!</h5>
						<p>초등수학 45가지 핵심 개념을 학습하고 스스로 예제를 들어 말로 설명이 가능할 정도로 <br>
						초등 기본 원리 수학 개념을 내재화하고 문제해결 능력을 키워주는 차별화된  교수법으로, <br>
						말로 설명 가능한 지식이 진짜 지식이라는 메타인지 학습법을 기반으로 한 개념드림트리를 <br>
						통해 핵심개념을 완성합니다.</p>
					</li>
					<li class="mathself">
						<img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_math_intro_04.png" class="d02" />
						<h5>1:1 개별 맞춤!  내신 & 수능 1등급이 보인다!</h5>
						<p>매셀프는 1:1 개인별 정확한 학습 진단을 통해 개별 맞춤 진도와 개별 맞춤 교재를 선정 <br>
						1:1 개인별 목표 진도에 맞춘 적극적 학습 유도 및 철저한 학습이력을 관리 <br>
						자기주도학습관을 통해 예복습 선순환 관리 및 개별 취약 부분 클리닉으로 <br>
						학생들의 수학 실력 향상을 이끌어내 내신과 수능 대비 완성을 가능케 합니다.</p>
					</li>
				</ul>
			</div>
			<div class="section full s04">
				<div class="subtit">
					<h4>가까운 정상수학학원 <b>위치확인하기</b></h4>
					<button type="button" class="trans large" onclick="location_href();"><span>정상수학학원 분원찾기</span></button>
				</div>
				<div class="branch_info">
					<ul>
						<li>
							<div class="name">대치분원</div>
							<div class="tel">
								<a href="tel:025645600">02)564-5600</a>
							</div>
						</li>
						<li>
							<div class="name">목동분원</div>
							<div class="tel">
								<a href="tel:025645600">02)2650-8340</a>
							</div>
						</li>
						<li>
							<div class="name">분당분원</div>
							<div class="tel">
								<a href="tel:025645600">031)715-3315</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
			
		</div>
	</div>
