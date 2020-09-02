<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<script type="text/javascript">
	$(document).ready(function(){
		$(".contents .menu li:eq(0) a").prop("href", root_url +"/course/coding");
		$(".contents .menu li:eq(1) a").prop("href", root_url +"/course/coding/process");
	});
	</script>

	<div id="container">
		<div class="contents">
			<jsp:include page="menu.jsp" flush="true" />
            <div class="section nav">
				<div class="subtit">
					<h4>
						<b>코딩교육</b>
					</h4>
				</div>
				<ol class="menu">
					<li <c:if test="${fn:indexOf(recentUrl,'process') eq -1 }">class="selected"</c:if> ><a href="">코딩 소개</a></li>
					<li <c:if test="${fn:indexOf(recentUrl,'process') > -1 }">class="selected"</c:if> ><a href="">프로그램 특징</a></li>
                </ol>
			</div>
			<div id="p0" class="section">
				<div class="subtit hide">
					<h4>프로그램 특징</h4>
				</div>
			</div>
			
			<div class="section">
                <div class="subtit">
					<h4 class="small">커리큘럼 상세 소개</h4>
					<h6>실력 향상 및 목표에 맞게 각 과정별로 100%연계되어 있어 교차수강이 가능한 체계적인 종합 코딩 프로그램입니다.</h6>
				</div>
                <div class="coding_curriculum block_table">
				<table class="schedule">
							<colgroup>
								<col width="7%" />
								<col width="10%" />
								<col width="7%" />
								<col width="7%" />
								<col width="20%" />
								<col width="20%" />
								<col width="20%" />
								<col width="7%" />
							</colgroup>
							<thead>
								<tr>
								  <th colspan="3">과정</th>
								  <th>표준 학습기간</th>
								  <th>학습 내용</th>
								  <th>학습교재 및 시스템</th>
								  <th>학습목표</th>
								  <th>대상</th>
								</tr>
							</thead>
							<tbody>
								<tr>
								  <th rowspan="4">정규</th>
								  <td rowspan="4" class="skyblue">알고리즘 정규과정</td>
								  <td class="skyblue_li">입문반</td>
								  <td>4개월</td>
								  <td rowspan="4">
								        <dl class="slist">
											<dd>C언어 문법</dd>
											<dd>알고리즘에듀의 24Lv을 학생의 학습 속도에 맞추어 이수하는 정규반</dd>
										</dl>
								  </td>
								  <td rowspan="4">
								        <dl class="slist">
											<dd>알고리즘랩스 LMS시스템</dd>
										</dl>
								  </td>
								  <td rowspan="4">
								        <dl class="slist">
											<dd>각종 SW대회 출전 및 입상 목표</dd>
										</dl>
								  </td>
								  <td rowspan="4">초등4~고등2</td>
							  </tr>
								<tr>
								  <td class="skyblue_li">중급반</td>
								  <td>4개월</td>
							  </tr>
								<tr>
								  <td class="skyblue_li">고급반</td>
								  <td>4개월</td>
							  </tr>
								<tr>
								  <td class="skyblue_li">심화반</td>
								  <td>4개월</td>
							  </tr>
								<tr>
								  <th rowspan="6">특강</th>
								  <td rowspan="3" class="green">영재원 특강과정</td>
								  <td class="green_li">입문반</td>
								  <td>4개월</td>
								  <td>
								        <dl class="slist">
											<dd>수학접목 알고리즘 과정</dd>
											<dd>블록코딩 알고리즘, 알고리즘 놀이교육</dd>
										</dl>
								  </td>
								  <td>
								        <dl class="slist">
											<dd>알고리즘매스교재</dd>
											<dd>두뇌회전 프로그램</dd>
											<dd>놀이교육 관련 교재</dd>
										</dl>
								  </td>
								  <td>
								        <dl class="slist">
											<dd>각종 SW공모전 출전 및 입상 목표</dd>
											<dd>공교육 SW교육 대비</dd>
										</dl>
								  </td>
								  <td>초등4~초등6</td>
							  </tr>
								<tr>
								  <td class="green_li">중급반</td>
								  <td>6개월</td>
								  <td>
								        <dl class="slist">
											<dd>컴퓨팅 사고력 문제풀이</dd>
											<dd>알고리즘 이론 수업</dd>
										</dl>
								  </td>
								  <td>
								        <dl class="slist">
											<dd>알고리즘매스교재</dd>
											<dd>두뇌회전 프로그램</dd>
											<dd>알고리즘이론 및 컴퓨팅 사고력 교재</dd>
										</dl>
								  </td>
								  <td>
								        <dl class="slist">
											<dd>사고력 올림피아드 및 각종 영재원 입학 목표</dd>
										</dl>
								  </td>
								  <td>초5~중2</td>
							  </tr>
								<tr>
								  <td class="green_li">고급반</td>
								  <td>4개월</td>
								  <td>
								        <dl class="slist">
											<dd>알고리즘 이론 및 실전 수업</dd>
											<dd>컴퓨팅 사고력 문제 풀이</dd>
										</dl>
								  </td>
								  <td>
								        <dl class="slist">
											<dd>알고리즘랩스 LMS 시스템</dd>
											<dd>두뇌회전 프로그램</dd>
											<dd>알고리즘이론 및 컴퓨팅 사고력 교재</dd>
										</dl>
								  </td>
								  <td>
								        <dl class="slist">
											<dd>영재원 특기자 전형 및 고등입시 목표</dd>
										</dl>
								  </td>
								  <td>초6~중2</td>
							  </tr>
								<tr>
								  <td rowspan="3" class="violet">국가대표 양성과정</td>
								  <td class="violet_li">입문반</td>
								  <td rowspan="3">개인별 진도</td>
								  <td rowspan="3">
								        <dl class="slist">
											<dd>정보올림피아드 준비과정</dd>
										</dl>
								  </td>
								  <td rowspan="3">
								        <dl class="slist">
											<dd>정보올림피아드 eLeaning 기출문제 및 유사유형 문제 각종 풀이 영상</dd>
										</dl>
								  </td>
								  <td rowspan="3">
								        <dl class="slist">
											<dd>정보올림피아드 수상</dd>
											<dd>국가대표 발탁 및 대학 입시 목표</dd>
										</dl>
								  </td>
								  <td rowspan="3">-</td>
							  </tr>
								<tr>
								  <td class="violet_li">중급반</td>
							  </tr>
								<tr>
								  <td class="violet_li">고급반</td>
							    </tr>
							</tbody>
				</table>
				</div>
			</div>
			
			<div class="section">
                <div class="subtit">
					<h4 class="small">알고리즘매스 교재 특징</h4>
					<h6>1. 초.중등 수학교과과정을 알고리즘을 학습하는 순서로 재구성</h6>
                    <h6>2. 블록코딩으로 언어의 장벽을 낮춰 알고리즘 학습에 집중</h6>
                    <h6>3. Level로 학년별 수학과정을 구분하여 수학 예습 및 복습 병행</h6>
                    <h6>4. 동영상 강의와 교재로 자기주도학습 가능</h6>
				</div>
				<div class="graph">
					<img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_algorithmedu_feature_01_4.jpg" />
				</div>
				<div class="subtit">
					<h6>알고리즘매스 교재 – 100% 자체 개발</h6>
				</div>
			</div>

			<div class="section">
                <div class="subtit">
					<h4 class="small">알고리즘 LMS시스템</h4>
					<h6>실력 향상 및 목표에 맞게 각 과정별로 100%연계되어 있어 교차수강이 가능한 체계적인 종합 코딩 프로그램입니다.</h6>
				</div>
				<div class="graph">
					<img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_algorithmedu_feature_01_5.jpg" />
				</div>
			</div>
		</div>
	</div>
