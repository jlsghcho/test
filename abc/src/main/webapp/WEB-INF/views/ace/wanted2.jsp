<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta name="viewport" content="width=1081, user-scalable=yes">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv="Pragma" content="no-cache">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="mobile-web-app-capable" content="yes">
	<meta name="keywords" content=""/>
	
	<title>ACE 내신  이벤트</title>

	<%-- Hannibal: 추적코드 적용 (2018.05.10) --%>
	<jsp:include page="../common/statistics.jsp"/>

	<script type="text/javascript" src="//image.gojls.com/common/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="//image.gojls.com/common/js/jquery.scrollTo-min.js"></script>
	<script type="text/javascript" src="resources/js/jquery.cookie.js"></script>
	<script type="text/javascript" src="/resources/js/wanted2.js"></script>
	
	<link type="text/css" rel="stylesheet" media="all" href="//image.gojls.com/newjls/css/event/20170825_main.css"/>
	
	<style>
		button { cursor: pointer; }

		div.col th {
			position: relative;	
		}
		div.col th:hover div.description {
			height: 100%;
			white-space: pre-line;
			display: block;
		}
		div.col th div.description {
			position: absolute;
			bottom: 0;
			height: 25px;
			max-height: 100%;
			overflow: hidden;
			text-overflow: ellipsis;
			background: url(//image.gojls.com/gojls/img_ad/event/170327/black_opacity60.png);
			white-space: nowrap;
			width: 215px;
			padding: 5px;
			color: #fffcd9;
			font-size: 12px;
			-webkit-box-sizing: border-box; 
			-moz-box-sizing: border-box; 
			box-sizing: border-box; 
		}
		div.col th .delete {
			position: absolute;
			top: -1px;
			right: 5px;
			width: 20px;
			height: 20px;
			line-height: 19px;
			font-weight: bold;
			text-align: center;
			border-radius: 0 0 3px 3px;
			border: 1px solid #1a1a1a;
			background: #2a2a2a;
			box-shadow: 0 5px 5px rgba(255, 255, 255, 0.1) inset;
			cursor: pointer;
			color: white;
		}

		table .course .view { position: absolute; z-index: 2; width: 400px; height: 223px; left: 15px; top: px; border-radius: 3px; border: 2px solid #222; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5); background: #fff; }
		table .course .view .close { position: absolute; top: -1px; right: 5px; width: 20px; height: 20px; line-height: 19px; font-weight: bold; text-align: center; border-radius: 0 0 3px 3px; border: 1px solid #1a1a1a; background: #2a2a2a; box-shadow: 0 5px 5px rgba(255, 255, 255, 0.1) inset; cursor: pointer; }
		table .course .view .close:hover { border: 1px solid #111; background: #222; }
		table .course .view .close:active { box-shadow: 0 5px 5px rgba(0, 0, 0, 0.1) inset; }
		table .course .view h1 { position: absolute; padding: 5px 5px; width: 390px; height: 60px; top: 125px; font-size: 12px; line-height: 16px; font-weight: bold; text-align: left; background: #2a2a2a; }
		
	</style>

	<script>

		areFormsEnabled = true;
		cEventSeq = ${currentSeq};				// 현재 이벤트 차수
		cProcessState = ${currentProcessState};	// 이벤트 상태   0: 시작전 , 1: 인증중, 2: 인증 만료 , 3: 당첨자 발표 
		cAnnounceDate = ${announceWinnerDate};	// 발표일
		cStartDate = ${startDate};				// 시작일
		cCloseDate = ${closeDate};				// 인증 만료일
		isCookies = ${isCookies};					// 로그인 상태
		signedInAsStudent = ${signedInAsStudent};   // 수업 중인 ACE 학생인 경우만
		loadOwnCount = 0;
		loadPageCount = 0;
		totalUploadCount = 0;
		
	</script>
</head>
<body>

<c:if test="${signedInAsStudent==0}">
	<input type="hidden" id="selUserSeq" value=""/>
</c:if>
<c:if test="${signedInAsStudent==1}">
	<input type="hidden" id="selUserSeq" value="${user.userSequence}"/>
</c:if>

<div id="content">

       <div id="s1">
           <h1>
                <img src="//image.gojls.com/newjls/img/event/20170825_event/s1_img1.gif" />
                <img src="//image.gojls.com/newjls/img/event/20170825_event/s1_img2.gif" />
           </h1>
           <h2>
                <a href="//event.gojls.com/"><img src="//image.gojls.com/newjls/img/event/20170825_event/look_bt.gif" /></a>
           </h2>
           <p>
             <textarea id="text">중2 / 부안중학교 / 정**
쌤이 주신 자료랑 시험이랑 정말 똑같이 나왔어요 ㅋㅋ 감사합니다

중2 / 성심여자중학교 / 이**
선생님~~ 시험기간 많은 응원과 격려 해 주셔서 감사합니다. 선생님과 함께 공부해서 시험 보기 직전까지 긴장 되지 않았어요! 감사합니다^^

중3 / 용인대지중학교 / 이**
선생님이 꼭 나올거라고 찍어주신 문제예요! 학교시험에서 똑같이 나왔어요~감사합니다.

중1 / 중앙대학교부속중학교 / 강**
이것도문제 보다가 핵소름 돋아서 선생님이 가르쳐주신대로 해봤는데 맞았어욬ㅋㅋ

중2 / 판교중학교 / 차**
쌤! 내신특강때 잘 가르쳐주셔서 감사했습니다! 선생님이 따로 정리해주신 단어장 덕분에 어휘 문제 헷갈리지 않고 잘 풀수 잇엇어용! 

중1 / 노원중학교 / 박**
보기만 조금씩 다른 유사문제들이 정말 많이 보였던 것 같아요! 정상어학원에서 시험 전에 여러가지 문제를 풀어본 것이 많은 도움이 되었어요^^

중3 / 구성중학교 / 이**
이 문제는 선생님께서 꼼꼼히 잘 챙겨주신 덕분에 객관식과 서술형 모두 잡을 수 있었습니다. 감사합니다^^!

중2 / 불곡중학교 / 윤**
선생님 수고하셨고 너무 문제가 똑같아서 소름돋앗어요♡♡

중3 / 구성중학교 / 이**
완전히 똑같은 문제가 나왔습니다!! 그것도 서술형으로요~! 놀랍지 않나요? 시험문제 보는 순간 소름 돋았습니다.

중2 / 대청중학교 / 김**
당연히 나올거라고 박신택선생님께서 말씀하셔서 열심히 외웠는데 나와서 놀랐고 선생님께 감사드린다

중2 / 성심여자중학교 / 이** 
늘 부족한 저에게 항상 따뜻한 말씀 많이 해 주셔서 감사해요! 선생님과 함께 공부하면서 시험에 대한 불안감도 없어졌어요!! 항상 감사드려요~

중3 / 용인신촌중학교 / 정**
선생님 덕분에 외부지문도 꼼꼼하게 잘 준비해서 이 문제 잘 맞을 수 있었습니다. 진심으로 감사합니다.

중2 / 판교중학교 / 차**
이것도 풀다가 완전 똑같아서 깜짝 놀랐어요.. 근데 한부분 감점이어서..ㅠㅠ 그래도 정말 잘 찝어주셔서 깜짝놀랐어요.. 감사합니다♡

중2 / 양화중학교 / 임**
특히 문법에 관한 문제들이 내가 학원에서 푼 문제랑 거의 유사해서 도움을 많이 받았다.

중3 / 과천문원중학교 / 전**
이희정쌤!! 쌤이 복사해주신거 토씨하나 안틀리고 나왔어용 쌤 사랑해요!! 2학기때도 잘볼께요!!^^

중2 / 도곡중학교 / 박**
김현리 쌤 내신 준비 기간에 주신 프린트 중에 race나 face 처럼 쓰이는 다어들을 많이 알게되었어요.감사합니당 ㅎㅎ

중3 / 구성중학교 / 이**
교과서, 문법, 외부지문까지 꼼꼼하게 잘 챙겨주셔서 감사합니다. 시험에 나올 법한 부분만 콕콕 잘 집어주셔서 감사드려요! 덕분에 좋은 결과 나왔

중2 / 세곡중학교 / 이**
선생님이 자료를 완전 열심히 알려주신덕에 시험점수짱 많이 올랐어요!! 쌤 사랑해요♡♡

중3 / 하탑중학교 / 남**
윤석진 선생님 감사합니다!!

중1 / 노원중학교 / 박**
가끔씩 단어 뜻풀이 문제도 제대로 못 읽고 틀릴 때가 있었는데 전에 풀어본 유사문제가 나와서 고민하지 않고 풀 수 있었어요^^

중2 / 화곡중학교 / 김**
그대로 나와버림

중1 / 노원중학교 / 박**
비슷한 유형의 명령문들을 정상어학원 쌤들이 주신 문제들로 연습해볼수 있었어요! 감사합니다^^

중3 / 용인대지중학교 / 이**
똑같은 지문에 표기된 곳도 비슷! 이렇게 비슷할수가~ 놀라운 정상!

중1 / 개원중학교 / 남**
김경민쌤 사랑해요 알러뷰 뿅뿅 또 내신기간때 만나요

중3 / 흥덕중학교 / 라**
지문은 시험지와 같고 빈칸만 단어와 문장 정도의 차이입니다

중3 / 용인신촌중학교 / 정**
외부지문이 굉장히 어려웠는데 선생님께서 정말 잘가르쳐주시고 선생님의 정성과 열정덕분에 문제를 맞히고 시험을 잘보게되었습니다.
 
중3 / 용인신촌중학교 / 이**
문제를 보자마자 난 생각했다 '어? 내가 전에 보았던건데?' 자신감을 얻었다. 세상이 달라보였다. 그렇다.내콘을 푼건 신의 한수 였던것이다

중2/판교중학교/차**
와.. 진짜 소름돋았어요.. 쌤이 저거 연습해보라고 숙제로 내주셨는데 완전 똑같이 내왔네욬ㅋㅋ 감사합니당^!^

중1 / 배재중학교 / 양**
시험 100점 맞게 열심히 도와주셔서 감사합니다
             </textarea>
           </p>
     </div>
	
	 <div id="sr_wrap">
	   
			<div id="s5" class="section">
				<div class="content">
					<img src="//image.gojls.com/newjls/img/event/20170825_event/board_top.gif" />
					<ul class="brand">
						<li>
						<div class="user-report-count">
                       		<h1>내신 유사문제 신고 현황</h1>
                       		<p>현재 <strong id="reportCount" class="total-re-count">0,000</strong>건 신고 중</p>
                       	</div>
						
						<div class="col">
								<table>
									<colgroup>
										<col width="50%">
										<col width="50%">
									</colgroup>
									
									<thead>
										<tr rowspan="5" id="report_abroad">
											<th>
										    <a  id="abroad_prev"  href="javascript:prevReports();">
										    	<img src="//image.gojls.com/newjls/img/event/20170825_event/btn_pre.png" alt="" />
										    </a>
										     <a id="abroad_next"   href="javascript:nextReports();" >
										     	<img src="//image.gojls.com/newjls/img/event/20170825_event/btn_next.png" alt="" /></a>
										     </th>	
										</tr>
										
									
									</thead>
									
									<tbody>
											<tr id="report1">  
												<th class="course left">
													<div class="description" onclick="$(this).next().get(0).click();"></div>
													<a href="javascript:" target="_blank">
														<img src="//image.gojls.com/newjls/img/event/20170825_event/pic01.gif" alt="" width="215px" height="120px"/>
													</a>
												</th>
												<th class="course right">
													<div class="description" onclick="$(this).next().get(0).click();"></div>
													<a href="javascript:" target="_blank">
														<img src="//image.gojls.com/newjls/img/event/20170825_event/pic01.gif" alt="" width="215px" height="120px" />
													</a>
												</th>
											</tr>
											
									 		<c:forEach begin="2" end="5" var="i">
								   		 	<tr id="report${i}">  
												<th class="course left">
													<div class="description" onclick="$(this).next().get(0).click();"></div>
													<a href="javascript:" target="_blank">
														<img src="//image.gojls.com/newjls/img/event/20170825_event/pic01.gif" alt="" width="215px" height="120px"/>
													</a>
												</th>
												<th class="course right">
													<div class="description" onclick="$(this).next().get(0).click();"></div>
													<a href="javascript:" target="_blank">
														<img src="//image.gojls.com/newjls/img/event/20170825_event/pic01.gif" alt="" width="215px" height="120px"/>
													</a>
												</th>
											</tr>
					  						</c:forEach>
									</tbody>
								</table>
						</div>
						
						<h5 id="myReportCountArea">나의 신고 건수 <b id="myReportCount">00건</b>(10건)</h5>
							
						</li>

						<li>
							<div class="user-report-count">
                       			<h1>내신 난이도 상 문제 검거 현황</h1>
                      			 <p>현재 <strong id="arrestCount" class="total-re-count">0,000</strong>건 검거 중</p>
                     		</div>
                     			
							<div class="col">
								<table>
									<colgroup>
										<col width="50%">
										<col width="50%">
									</colgroup>
									<thead>
									<tr rowspan="5" id="arrest_abroad">
										<th >
											<a id="abroad_prev"  href="javascript:prevArrests();" >
												<img src="//image.gojls.com/newjls/img/event/20170825_event/btn_pre.png" alt="" />
											</a>
											<a id="abroad_next" href="javascript:nextArrests();" >
												<img src="//image.gojls.com/newjls/img/event/20170825_event/btn_next.png" alt="" />
											</a>
										
										</th>
									</tr>
									</thead>
									
									<tbody>
										<tr id="arrest1">
											<th class="course left">
												<div class="description" onclick="$(this).next().get(0).click();"></div>
												<a href="javascript:" target="_blank">
													<img src="//image.gojls.com/newjls/img/event/20170825_event/pic02.gif" alt="" width="215px" height="120px"/>
												</a>
											</th>
											<th class="course right">
												<div class="description" onclick="$(this).next().get(0).click();"></div>
												<a href="javascript:" target="_blank">
													<img src="//image.gojls.com/newjls/img/event/20170825_event/pic02.gif" alt="" width="215px" height="120px"/>
												</a>
											</th>
										</tr>
									 <c:forEach begin="2" end="5" var="i">
									    <tr id="arrest${i}">
											<th class="course left">
												<div class="description" onclick="$(this).next().get(0).click();"></div>
												<a href="javascript:" target="_blank">
													<img src="//image.gojls.com/newjls/img/event/20170825_event/pic02.gif" alt="" width="215px" height="120px"/>
												</a>
											</th>
											<th class="course right">
												<div class="description" onclick="$(this).next().get(0).click();"></div>
												<a href="javascript:" target="_blank">
													<img src="//image.gojls.com/newjls/img/event/20170825_event/pic02.gif" alt="" width="215px" height="120px"/>
												</a>
											</th>
										</tr>
											
									</c:forEach>
									</tbody>
								</table>
							</div>
							<h5 id="myArrestCountArea">나의 검거 건수 <b id="myArrestCount">00건</b>(10건)</h5>
						</li>
					</ul>
				</div>
			</div>
			
			<!--섹션3-->   
		    <div id="s3" class="section">
            	<div class="content">
             		<img src="//image.gojls.com/newjls/img/event/20170825_event/event_02.gif" />
              		<img src="//image.gojls.com/newjls/img/event/20170825_event/event_03.gif" />

          
     				<div class="con">
     					<h2 class="superman"><img src="//image.gojls.com/newjls/img/event/20170825_event/superman.png" /></h2>
     					
	      				<!-- left board01 -->  		
						<div class="noteright">
							<div class="notice">
	                			<div class="gift"><img src="//image.gojls.com/newjls/img/event/20170825_event/gift_01.png" alt="start button"></div>
	                				<div class="date">
	                					<ul>
	                					    <li>1차 : 9월 20일 ~ 10월 9일 까지 <a href="#"><img src="//image.gojls.com/newjls/img/event/20170825_event/result_bt.png" /></a></li>
               								 <li>2차 : 10월 10일 ~ 10월 15일 까지 <a href="#"><img src="//image.gojls.com/newjls/img/event/20170825_event/result_bt.png" /></a></li>
                							<li>3차 : 10월 16일 ~ 10월 22일 까지 <a href="#"><img src="//image.gojls.com/newjls/img/event/20170825_event/result_bt.png" /></a></li>
	                					</ul>
	                					<br>기간 별 선정 / 중복 제외
	                				</div>
	              			</div>
	          			</div>

  
	  					<div class="bottomboard">
							<div class="area">
	            				<p class="t_ranking"><b>내신 HERO</b></p>
	            				<p>1차 : 9월 20일 ~ 10월 9일 까지</p>
	               
	     						<div class="cancle_list j_scroll">
	     						
	     							 <c:forEach begin="1" end="11" var="i">  
	     							              
	     							    <div id="tranking${i}" class="ranking_you" >
	     							    
	         						 	<c:if test="${i%2==1}"><ul class="list_portfolio friday"></c:if>	         						 	
	         						 	<c:if test="${i%2==0}"><ul class="list_portfolio"></c:if>
	         						 	    
	         						 	    <li>
	                							<c:if test="${i==1}"><div class="medalgold"></div></c:if>
	                							<c:if test="${i==2}"><div class="medalsilver"></div></c:if>
	                							<c:if test="${i==3}"><div class="medalbronze"></div></c:if>
	                							<c:if test="${i>3}"><div class="medalred"></div></c:if>
	                    						<div class="medalnumber">${i}</div>
												<div class="info">
													<p><span id="td${i}" style="font-size:8pt;" ></span></p>
	                        						<p><span id="tu${i}" class="yellowscore" ></span></p>
												</div>
											</li>
	                					</ul>
	              						</div>
	              						
	              					</c:forEach>
	              					
	              				</div>
	           				</div>
	 				</div>
				</div>
				
					<img src="//image.gojls.com/newjls/img/event/20170825_event/event_04.gif" />
				
					<div class="con">
						<h2 class="superstudent"><img src="//image.gojls.com/newjls/img/event/20170825_event/superstudent.png" /></h2>
					
      					<!-- left board02 -->  		
						<div class="noteright">
							<div class="notice">
	                			<div class="gift"><img src="//image.gojls.com/newjls/img/event/20170825_event/gift_02.png" alt="start button"></div>
	             			</div>
          				</div>

  
       					<div class="bottomboard">
				  			<div class="area">
	                			<p class="s_ranking"><b>내신 청출어람</b></p>
	
	               				<div class="cancle_list j_scroll">   
	               				
	               					<c:forEach begin="1" end="101" var="i">  
	               					              
	          						<div class="ranking_you" id="uranking${i}">
	     							    
	          							<c:if test="${i%2==1}"><ul class="list_portfolio friday"></c:if>
	         						 	<c:if test="${i%2==0}"><ul class="list_portfolio"></c:if>
	                						<li>
	                							<c:if test="${i==1}"><div class="medalgold"></div></c:if>
	                							<c:if test="${i==2}"><div class="medalsilver"></div></c:if>
	                							<c:if test="${i==3}"><div class="medalbronze"></div></c:if>
	                							<c:if test="${i>3}"><div class="medalred"></div></c:if>
		                    					
		                    					<div class="medalnumber">${i}</div>
												<div class="info" >
													<p><span id="ud${i}" style="font-size:8pt;" ></span></p>
	                        						<p><span id="uu${i}" class="yellowscore"></span></p>
												</div>	                        					
			                        					
											</li>
		                				</ul>
	              					</div>
	              					
	              					</c:forEach>				 	
	                			</div>
	           				</div>      
							<!-- right board02 // -->   
    					</div>
 					</div>         
 				
				</div>
			</div>	
			
			<div id="s4" class="section">
				<!--내신 기출 유사문제 신고 센터-->
				<div class="content">
				 
					<form id="reportingForm" class="edit" action="/ace/report2" method="post" enctype="multipart/form-data" target="reportingIframe" onsubmit="validateReport(this, event);">
						<input name="userSeq" type="text" value="${user.userSequence}" style="display: none;"/>
						<input name="eventSeq" type="text"  value="${currentSeq}" style="display: none;"/>
						
						<img src="//image.gojls.com/newjls/img/event/20170825_event/state01_title.gif" />
						<ul class="entertop">
							<li>
								<span>학년</span><input type="text" title="학년" value="${user.grade}" disabled />
								<span>학교</span><input type="text" title="학교"  value="${user.schoolName}" disabled />
								<span>신고자 ID</span><input type="text" title="신고자ID" value="${user.userId}" disabled />
								
								
								<c:if test="${signedInAsStudent==0}">
									<select id="teachersCombo1" name="teacher" title="선생님">
										<option value="no">선생님</option>
									</select>
								</c:if>
								<c:if test="${signedInAsStudent==1}">
									<select id="teachersCombo1" name="teacher" title="선생님">
									<c:forEach items="${teachers}" var="item">
										<option value="${item.sequence}" >${item.teacherName}</option>
									</c:forEach>
								</select>
								</c:if>					
								
							</li>
						</ul>
						<ul class="enter">
							<div class="eventfinish2" style="display: none;">
								<div class="end_info">
									<h5>신고 기간이 만료 되었습니다.<br> 그 동안 참여해 주셔서 감사합니다.<br> 추첨선물 당첨자 발표 : 10월 26일(목) </h5>
									<h4><a href="" style="display: none;">
									<img src="//image.gojls.com/gojls/img_ad/event/check_bt.png"/></a></h4>
								</div>
							</div>
						
							<li>
								<span><img src="//image.gojls.com/gojls/img_ad/event/170427/number.png"></span>
								<select name="questionType" title="문항 유형">
									<option>객관식</option>
									<option>주관식</option>
								</select>
								<select name="questionNumber" title="1">
									<c:forEach begin="1" end="35" var="i">   
										<option>${i}</option>
									</c:forEach>
								</select>
								기출시험지 문항번호를 선택해주세요
							</li>
							<li>
								<div class="upload_img">
									<div class="file_input01">
										<input id="file1" name="file1" type="file" style="display: none;" accept="image/*" onchange="onFileChange(this, 'preview1')">
										<img src="//image.gojls.com/newjls/img/event/20170825_event/step1_que_tit.png">
										<button type="button" class="orange" onclick="onClickBrowse($('#file1'))"><span>사진찾기</span></button>
										<p><img id="preview1" class="preview" src="//image.gojls.com/newjls/img/event/20170825_event/step1_01.jpg" width="400px" height="223px"></p>
									</div>

									<div class="file_input02">
										<input id="file2" name="file2" type="file" style="display: none;" accept="image/*" onchange="onFileChange(this, 'preview2')">
										<img src="//image.gojls.com/newjls/img/event/20170825_event/step2_que_tit.png">
										<button type="button" class="orange" onclick="onClickBrowse($('#file2'))"><span>사진찾기</span></button>
										<p><img id="preview2" class="preview" src="//image.gojls.com/newjls/img/event/20170825_event/step1_02.jpg" width="400" height="223"></p>
									</div>
								</div>
							</li>
							<li>
								<textarea id="memo" name="comment" placeholder="유사문제 혹은 기출시험에 도움된 내신학습자료를 주신 선생님께 메시지를 남겨주세요." maxlength="80"></textarea>
								<p id="memoState"></p>
							</li>
						</ul>
						<h1 class="">
							<button type="submit">
								<img src="//image.gojls.com/newjls/img/event/20170825_event/anmelden_bt.png">
							</button>
						</h1>
						<h1><img src="//image.gojls.com/newjls/img/event/20170825_event/listen_01.gif"></h1>
					</form>
					<iframe id="reportingIframe" name="reportingIframe" style="display: none;"></iframe>
				</div>
				<br><br><br>
				<!--내신 고난도 문제 검거 센터-->
				<div class="content">
					
					<form id="arrestingForm" class="edit" action="/ace/arrest2" method="post" enctype="multipart/form-data" target="arrestingIframe" onsubmit="validateArrest(this, event);">
						<input name="userSeq" id="userSeq"  type="text" value="${user.userSequence}" style="display: none;"/>
						<input name="eventSeq" type="text"  value="${currentSeq}" style="display: none;"/>
						
						
						<img src="//image.gojls.com/newjls/img/event/20170825_event/state02_title.gif"/>
						
						<ul class="entertop">
							<li>
								<span>학년</span><input type="text" title="학년" value="${user.grade}" disabled />
								<span>학교</span><input type="text" title="학교" value="${user.schoolName}" disabled />
								<span>신고자 ID</span><input type="text" title="신고자ID" value="${user.userId}" disabled />
								
								
								<c:if test="${signedInAsStudent==0}">
									<select id="teachersCombo2" name="teacher" title="선생님">
										<option value="no">선생님</option>
									</select>
								</c:if>
								<c:if test="${signedInAsStudent==1}">
									<select id="teachersCombo2" name="teacher" title="선생님">
									<c:forEach items="${teachers}" var="item">
										<option value="${item.sequence}" >${item.teacherName}</option>
									</c:forEach>
								</select>
								</c:if>		
						
							</li>
						</ul>
						<ul class="enter">
							<div class="eventfinish3"  style="display: none;">
								<div class="end_info">
									<h5>검거 기간이 만료 되었습니다.<br> 그 동안 참여해 주셔서 감사합니다.<br> 추첨선물 당첨자 발표 : 10월 26일(목) </h5>
									<h4><a href="" style="display: none;">
									<img src="//image.gojls.com/gojls/img_ad/event/check_bt.png"/></a></h4>
								</div>
							</div>
							<li>
								<span><img src="//image.gojls.com/newjls/img/event/20170825_event/number.png"></span>
								<select name="questionType" title="문항 유형">
									<option>객관식</option>
									<option>주관식</option>
								</select>
								<select name="questionNumber" title="1">
									<c:forEach begin="1" end="35" var="i">   
										<option>${i}</option>
									</c:forEach>
								</select>
								기출시험지 문항번호를 선택해주세요
							</li>
							
							<li>								
								<div class="upload_img">
									<div class="file_input01">
										<input id="file3" name="file3" type="file" style="display: none;" accept="image/*" onchange="onFileChange(this, 'preview3');">
										<img src="//image.gojls.com/newjls/img/event/20170825_event/step1_que_tit.png">
										<button type="button" class="orange" onclick="onClickBrowse($('#file3'))"><span>사진찾기</span></button>
										<p><img id="preview3" class="preview" src="//image.gojls.com/newjls/img/event/20170825_event/step2_01.jpg" width="400" height="223"></p>
									</div>
									<div class="file_input02">
										<input id="file4" name="file4" type="file" style="display: none;" accept="image/*" onchange="onFileChange(this, 'preview4');">
										<img src="//image.gojls.com/newjls/img/event/20170825_event/step3_que_tit.png">
										<button type="button" class="orange" onclick="onClickBrowse($('#file4'))"><span>사진찾기</span></button>
										<p><img id="preview4" class="preview" src="//image.gojls.com/newjls/img/event/20170825_event/step2_02.jpg" width="400" height="223"></p>
									</div>
								</div>
							</li>
						</ul>
						<h1>
							<button type="submit">
								<img src="//image.gojls.com/newjls/img/event/20170825_event/completion_bt.png">
							</button>
						</h1>
						<h1><img src="//image.gojls.com/newjls/img/event/20170825_event/listen_02.gif"></h1>
					</form>
					<iframe id="arrestingIframe" name="arrestingIframe" style="display: none;"></iframe>
					<br></br>
					<h1>ⓒ JLS CO., LTD. All Rights Reserved.</h1>
				</div>
		 </div>
	   </div>
	
</div>

</body>
</html>
