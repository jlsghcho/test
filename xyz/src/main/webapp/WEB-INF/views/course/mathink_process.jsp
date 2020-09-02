<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type='text/javascript'>
var course_num = "${course_num}";

$(document).ready(function(){
	$("#tab_2,#tab_3,#tab_4").hide();
	$(".contents .menu li:eq(0) a").prop("href", root_url +"/course/mathink");
	$(".contents .menu li:eq(1) a").prop("href", root_url +"/course/mathink/process");
	
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
						<b>초등교육</b>
					</h4>
				</div>
				<ol class="menu">
					<li <c:if test="${fn:indexOf(recentUrl,'process') eq -1 }">class="selected"</c:if> ><a href="">매씽크 소개</a></li>
					<li <c:if test="${fn:indexOf(recentUrl,'process') > -1 }">class="selected"</c:if> ><a href="">프로그램 특징</a></li>
				</ol>
			</div>
			<div id="tmenu" class="section">
				<div class="subtit hide">
					<h4>프로그램 특징</h4>
				</div>
				<ul class="study_course">
					<li class="fea1 selected" onclick="course(1);top_move();">
						<div class="bg"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/mathink_course_bg_1.jpg" /></div>
						<div class="tit">
							<h5>사고력이 다르다</h5>
						</div>
						<div class="discription">
							<p>교과 완성으로부터 출발하는 <br>사고력 확장</p>
						</div>
					</li>
					<li class="fea2" onclick="course(2);top_move();">
						<div class="bg"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/mathink_course_bg_2.jpg" /></div>
						<div class="tit">
							<h5>컨텐츠가 다르다</h5>
						</div>
						<div class="discription">
							<p>재미, 개념, 사고력을 늘리는 <br>종합적인 수학 컨텐츠</p>
						</div>
					</li>
					<li class="fea3" onclick="course(3);top_move();">
						<div class="bg"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/mathink_course_bg_3.jpg" /></div>
						<div class="tit">
							<h5>개념이 다르다</h5>
						</div>
						<div class="discription">
							<p>초등수학 45가지 핵심 개념이면,<br>수학개념 완성</p>
						</div>
					</li>
                    <li class="fea4" onclick="course(4);top_move();">
						<div class="bg"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/mathink_course_bg_4.jpg" /></div>
						<div class="tit">
							<h5>OUTPUT이 다르다</h5>
						</div>
						<div class="discription">
							<p>개념완성 Output의 결정체,<br>개념드림트리</p>
						</div>
					</li>
				</ul>
			</div>
			<div class="section" id="tab_1">
				<div class="subtit">
					<h4 class="fake">사고력이 다르다.</h4>
					<div class="copy">
						<h4>교과 완성으로부터 출발하는 <br><b>'사고력 확장'</b></h4>
						<br><br>
						<h5>공교육 수학개념 로드맵을 따라 <b>‘수학적 사고력’</b>을 이끌어 낸다!</h5>
						<br>
						<h6>매씽크는 초∙중∙고의 수학적 위계성과 함께 학습자의 수준까지 고려하여 연계 개념들을 함께 분석할 수 있게 함으로써,<br> 나무가 아닌 수학개념의 숲을 볼 수 있도록 교육합니다.<br><br> 또한 매씽크는 기본적인 수학 실력에 요구되는 수렴적 사고력는 물론이고, 창의적인 생각과 문제해결력을 키우는 발산적 사고력도 키울 수 있도록<br> 역사, 과학, 실생활 연계 등 흥미롭고 친숙한 소재들과 토론, 발표 등 다양한 활동들로 채워져 있습니다.</h6>
					</div>
				</div>
                <hr><br>
				<div class="graph bg"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathink_feature_01.svg" class="mathink_feature_01" /></div>
                <div class="subtit">
					<h5 class="emphasis"><span>- 교과 + 사고력 학습 예시 -</span></h5>
				</div>
			</div>
			<div class="section" id="tab_2">
				<!--  
				<div class="subtit hide">
					<h4 class="fake">컨텐츠가 다르다.</h4>
					<div class="copy">
						<h4><b>재미, 개념, 사고력</b>을 늘리는<br> 종합적인 수학 컨텐츠</h4>
                        <br>
						<h5>교과사고력 교재, 개념동영상, 연산프로그램, 두뇌활성화, 코딩, 수학창의 보드</h6>
					</div>
				</div>
				-->
				<div class="graph"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/process_02.png" class="wide" /></div>
			</div>
			<div class="section" id="tab_3">
				<div class="graph"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/process_03.jpg" class="wide" /></div>
                <!--
				<div class="subtit hide">
					<h4 class="fake">개념이 다르다.</h4>
					<div class="copy">
						<h4>정상이 가장 잘하는 수업<br> <b>'학생중심 참여수업'</b></h4>
                        <br>
						<h5>정상의 교육철학을 공유한 국내 최고 선생님들이 함께하는 학생중심의 참여 수업</h5>
					</div>
				</div>
                <hr>
				<div class="subtit">
					<div class="copy">
						<h6>매씽크 수업은 듣고 보는 학습부터 토의하고 체험하고 직접 말로 표현하는 단계까지 유기적으로 연계된 프로그램으로, <br>체계적인 선생님의 발문과 다양하고 재미있는 Math Fun Activities를 통해 자연스럽게 학생들의 능동적인 참여를 이끌어 냅니다.</h6>
					</div>
				</div>
				<div class="graph"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathink_feature_02_1.svg" /></div>
				<hr>
				<div class="subtit">
					<div class="copy">
					    <h5><b>개념 완성 OUTPUT의 결정체 개념드림트리</b></h5>
                        <br>
						<h6>수학의 기본원리를 이해하는 시기에 개념을 정확하게 이해하고 올바르게 문제를 접근하여 풀어나가는 과정을  몸에 습관처럼 베이도록 체득화 하는 것이 매우 중요합니다. 매씽크의 개념드림트리는 수학개념을 내재화하고 문제해결 과정을 체득화 시키는 개념정복 OUTPUT 활동입니다.</h6>
					</div>
				</div>
				<div class="graph"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathink_feature_02_2.svg" /></div>
                <div class="subtit">
					<h5 class><span>- 수업 프로세스 -</span></h5>
				</div>
				<ul class="list">
					<li>
						<h4>몰입</h4>
						<h5>수업 초반, 연산 및 두뇌활성화프로그램을 통해 학생들의 흥미와 몰입을 이끌어내고, 수학 두뇌를 말랑말랑하게 해서 즐거운 수학 수업을 위한 최적의 환경을 만듭니다.</h5>
					</li>
					<li>
						<h4>교과개념이해</h4>
						<h5>학생이 직접 참여하는 Math Fun Activities를 통해 사전학습으로 시청한 개념동영상에 대한 이해 정도를 먼저 파악하게 되고,<br>  선생님의 단계적 발문을 따라 개념을 스스로 설명하는 단계까지 이르게 됩니다.<br> 정확한 개념 이해를 바탕으로 유형과 서술형 익히기까지 확장합니다.</h5>
					</li>
					<li>
						<h4>개념드림트리</h4>
						<h5>개념설명 - 이해한 개념을 본인의 언어로 예제를 들어 설명 합니다.<br>문제해결방법설명 - 문제를 읽고 주어진 조건과 구하고자 하는 것을 찾아 문제해결에  
                               필요한 수학개념을 설명하고 풀이과정을 설명합니다.</h5>
					</li>
				</ul>
				-->
			</div>			
			<div class="section" id="tab_4">
				<div class="graph"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/process_04.png" class="wide" /></div>
			    <!--  
				<div class="subtit hide">
					<h4 class="fake">OUTPUT이 다르다.</h4>
					<div class="copy">
						<h4>혁신적인 완전학습 시스템</h4>
                        <br>
						<h5>최고의 학습효율과 완전학습을 창출하는 러닝시스템</h5>
                     </div>
				</div>
                <hr>
				<div class="section wp50">
					<div class="subtit">
						<div class="copy">
							<h6>플립러닝(Flipped Learning)과 어댑티브러닝(Adaptive Learning)의 학습효과를 극대화하고,<br> 교실(Smart Class)과 가정학습(Self Learning)을 하나로 담아내어 학습효율을 배가시키는 매씽크만의 혁신적인 러닝시스템입니다.</h6>
						</div>
					</div>
					<div class="graph">
						<img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathink_feature_04_1.svg" class="mathink_feature_04" />
					</div>
				</div>
				<div class="section wp50">
					<ul class="list">
						<li>
							<h4>플립러닝(Flipped Learning) </h4>
							<ol>
								<li>Premium 개념동영상 등을 맞춤 제공하고 사전학습 관리</li>
								<li>교실수업에서는 학생간의 상호작용과 심화된 학습활동에 집중 가능</li>
							</ol>
						</li>
						<li>
							<h4>스마트클래스(Smart Class)</h4>
							<ol>
								<li>다양한 멀티미디어 자료를 제공 받아 면대면 수업을 보다 입체적으로 운영</li>
								<li>학생들은 교재와 함께 연계된 스마트러닝을 통해 학습 효율을 높이고  밀도 높은 수업 진행</li>
							</ol>
						</li>
						<li>
							<h4>어댑티브러닝(Adaptive Learning)</h4>
							<ol>
								<li>수업 중 분석된 학생 개인의 수준과 성향에 맞춰 클리닉 과제 자동 제시</li>
								<li>개인별 맞춤학습 실현 및 빅데이터 활용을 위해 학습 이력 자동 저장</li>
							</ol>
						</li>
						<li>
							<h4>자기주도학습(Self Learning)</h4>
							<ol>
								<li>제시된 클리닉 과제를 수행하면서 개인별 수학 약점 보완</li>
								<li>개인학습의 어려움은 자기주도학습관 코칭 선생님의 도움으로 완전학습 실현</li>
							</ol>
						</li>
					</ul>
				</div>
				-->
				<hr class="w" />
				<div class="section">
					<div class="graph"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_mathink_feature_04_2.png" /></div>
				</div>
			</div>
			
		</div>
	</div>
