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
				<div class="subtit wide">
					<h4>
						<b>코딩교육</b>
					</h4>
				</div>
				<ol class="menu">
					<li <c:if test="${fn:indexOf(recentUrl,'process') eq -1 }">class="selected"</c:if> ><a href="">코딩 소개</a></li>
					<li <c:if test="${fn:indexOf(recentUrl,'process') > -1 }">class="selected"</c:if> ><a href="">프로그램 특징</a></li>
				</ol>
			</div>
			<div class="section">
				<div class="subtit wide">
					<h4>코딩 소개</h4>
					<div class="copy">
						<h5><b>공교육코딩, 영재원, 정보올림피아드까지<br> 실력과 성과를 보장합니다.</b></h5>
					</div>
				</div>
			</div>

			<div class="section">
			     <div class="subtit">
					<h4 class="small">프로그램 소개</h4>
				</div>
			   <img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/graphic_algorithmedu_feature_01_3.jpg" class="wide" />
			</div>
			
			<div class="section">
			    <div class="subtit">
					<h4 class="small">실적</h4>
					<h6>알고리즘에듀의 교육 목표는 <b class="red">우리 아이들의 미래 경쟁력 확보</b>입니다.<br> 
알고리즘에듀의 학습 커리큘럼만 잘 따라와도, SW영재원 입학, 정보올림피아드 수상,<br>  
SW 특기자 전형 등을 <b class="red">한번에 준비</b>할 수 있습니다. <b class="red">알고리즘 능력이 곧 결과로 나타나기 때문</b>입니다. <br> 
알고리즘 에듀 수강생은 별도의 준비 없이도 <b class="red">최고의 결과</b>를 내고 있습니다.</h6>
				</div>
			    <div class="coding_curriculum">
                        <table>
							<colgroup>
								<col width="50%" />
								<col width="50%" />
							</colgroup>
							<tbody>
								<tr>
									<th><b>정보 올림피아드</b></th>
									<th><b>영재원 등 기타</b></th>
								</tr>
								<tr>
									<td valign="top">
										<ol class="result">
											<li><b>2019</b> 정보올림피아드 중등부 금상 1명</li>
											<li><b>2019</b> 정보올림피아드 중등부 은상 1명</li>
											<li><b>2019</b> 정보올림피아드 중등부 동상 1명</li>
											<li><b>2018</b> 정보올림피아드 초등부 은상 1명</li>
											<li><b>2018</b> 정보올림피아드 초등부 동상 1명</li>
											<li><b>2018</b> 정보올림피아드 초등부 장려상 1명</li>
											<li><b>2018</b> 정보올림피아드 중등부 은상 1명</li>
											<li><b>2018</b> 정보올림피아드 중등부 동상 1명</li>
											<li><b>2018</b> 정보올림피아드 중등부 장려상 2명 </li>
											<li><b>2017</b> 국제올림피아드(ioi) 국가대표 후보생</li>
											<li><b>2017</b> 한국정보올림피아드(koi) 중등부 은상 (10위)</li>
											<li><b>2017</b> 한국정보올림피아드(koi) 초등부 은상 (33위)</li>
											<li><b>2017</b> 한국정보올림피아드(koi) 초등부 장려상</li>
											<li><b>2017</b> 서울시 정보올림피아드 중등부 금상 (3위)</li>
											<li><b>2017</b> 서울시 정보올림피아드 초등부 금상 (2위)</li>
											<li><b>2017</b> 서울시 정보올림피아드 초등부 은상</li>
											<li><b>2017</b> 서울시 정보올림피아드 초등부 동상</li>
										</ol>
									</td>
									<td valign="top">
										<ol class="result">
											<li><b>2018-2019</b> 한양대학교 SW영재원 최종합격 9명</li>
											<li><b>2019</b> 선린인터넷고 SW영재원 최종합격 2명 </li>
											<li><b>2018</b> 서울대학교 정보 영재원 최종합격 2명 </li>
											<li><b>2018</b> 서울교육대학교 정보 영재원 최종합격 2명 </li>
											<li><b>2017</b> 한양대학교 SW영재원 최종합격 3명 </li>
											<li><b>2017</b> 선린인터넷고등학교 SW영재원 최종합격 3명 </li>
											<li><b>2017</b> 인천시 정보올림피아드 초등부 장려상 </li>
											<li><b>2017</b> SW 사고력 올림피아드 초등부 금상 </li>
											<li><b>2017</b> ICT Award 경진대회 고등부 장려상</li>
										</ol>
									</td>
								</tr>
							</tbody>
						</table>
                 </div>
             </div>
		
		<div class="section">
				<div class="subtit"> 
					<h5>2018-2019 상반기 정보올림피아드 실적</h5>
					<ul class="olympiad">
					<li>
					   <dl>
						<h4><span><b>94.8</b>점</span></h4>
						<h3><span>2018 초등부<br>정보올림피아드<br>서울 본선</span></h3>
					   </dl>
					</li>
					<li>
					   <dl>
						<h4><span><b>400</b>점</span></h4>
						<h3><span>2019 중등부<br>정보올림피아드<br><b>서울 본선 수석 배출</b></span></h3>
					   </dl>
					</li>
					<li>
					   <dl>
						<h4><span><b>11</b>명</span></h4>
						<h3><span>초/중등부<br>정보올림피아드<br><b>전국 본선 진출</b></span></h3>
					   </dl>
					</li>
				    </ul>
				</div>
		</div>
		
		<div class="section">
				<div class="subtit"> 
					<h5>2018-2019 영재원 실적</h5>
					<ul class="gifted">
					<li>
					   <dl>
						<h4><span><b>2</b>명</span></h4>
						<h3><span><b>서울대학교<br>정보수리과 영재원</b></span></h3>
					   </dl>
					</li>
					<li>
					   <dl>
						<h4><span><b>3</b>명</span></h4>
						<h3><span><b>서울교육대학교<br>정보영재원</b></span></h3>
					   </dl>
					</li>
					<li>
					   <dl>
						<h4><span><b>9</b>명</span></h4>
						<h3><span><b>한양대학교<br>SW영재원</b></span></h3>
					   </dl>
					</li>
					<li>
					   <dl>
						<h4><span><b>2</b>명</span></h4>
						<h3><span><b>선린인터넷고<br>SW영재원</b></span></h3>
					   </dl>
					</li>
				    </ul>
				</div>
		</div>
			
	</div>
