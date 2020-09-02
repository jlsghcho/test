<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// 캐쉬 지우기
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
	String millis = String.valueOf(System.currentTimeMillis());
	request.setAttribute("millis", millis);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=1100">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="theme-color" content="#1278bc">
<meta property="og:image" content="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/heroimg_bg.jpg" />
<meta property="og:title" content="Story Knight. 비밀의 성" />
<meta property="og:description" content="비밀의 성 각 장소에 깃든 봉인을 해제하고 Story Knight 작위를 획득하라" />
<title>Story Knight</title>
<link rel="shortcut icon" type="image/x-icon" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/favicon_jls.ico?${millis}" />
<link rel="apple-touch-icon" sizes="120x120" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_120.png?${millis}" />
<link rel="apple-touch-icon" sizes="152x152" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_152.png?${millis}" />
<link rel="apple-touch-icon" sizes="167x167" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_167.png?${millis}" />
<link rel="apple-touch-icon" sizes="180x180" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_180.png?${millis}" />
<link rel="icon" sizes="192x192" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_192.png?${millis}" />
<link rel="stylesheet" type="text/css" href="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/swiper-4.5.0/css/swiper.min.css" />
<link type="text/css" rel="stylesheet" media="all" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/css/learningkids/storyknight_20200226.css?${millis}" />
<link rel="stylesheet" type="text/css" href="http://image.gojls.com/common/mediaElementJs/mediaelementplayer.css" />
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/js/device.js"></script><!-- for mobile -->
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/js/jquery-ui-1.12.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/swiper-4.5.0/js/swiper.min.js"></script>
<script type="text/javascript" src="http://image.gojls.com/common/mediaElementJs/OSinfo.js"></script>
<script type="text/javascript" src="http://image.gojls.com/common/mediaElementJs/mediaelement_play.js"></script>
<script type="text/javascript" src="http://image.gojls.com/common/mediaElementJs/mediaelement-and-player.js"></script>
<!-- script src="https://www.youtube.com/player_api"></script -->
<script src="/resources/js/player_api.js"></script>
<script type="text/javascript">
var mobile_chk = OSInfoMobileYn();
$(document).ready(function() {
	// F12 버튼 방지	
	$(document).bind('keydown',function(e){
		if ( e.keyCode == 123) {
			e.preventDefault();
			e.returnValue = false;
		}
	});
		
	var rankingSwiper = new Swiper('.ranking-wrap', {
		slidesPerView: 'auto',
		slidesPerGroup: 5,
		breakpoints: {
			// when window width is <= 414px
			414: {
				slidesPerGroup: 2
			},
			// when window width is <= 568px
			568: {
				slidesPerGroup: 3
			},
			// when window width is <= 800px
			800: {
				slidesPerGroup: 4
			}
		},
		navigation: {
			nextEl: '.swiper-next',
			prevEl: '.swiper-prev',
		},
		autoplay: {
			delay: 4000,
			disableOnInteraction: true
		},
		//loop: true,
		speed: 1000
	});
	
});
/* expand */
$(document).on('click','ul.tab>li',function() {
	$(this).closest('ul.tab').find('li').removeClass('selected');
	$(this).addClass('selected');
	$('.quest>.info').addClass('hide');
	if($(this).hasClass('grammar')){
		$('.quest>.info.grammar').removeClass('hide');
	} else if($(this).hasClass('attendance')){
		$('.quest>.info.attendance').removeClass('hide');
	}
});

var vid;
</script>
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-109167413-2"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-109167413-2');
</script>
</head>

<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">

<div id="wrap">
	<div id="header">
		<div class="gnb">
			<h1>JLS</h1>
			<h2>지금도 Knight들의 모험이 계속되고 있습니다.</h2>
			<div class="status">
				<div class="tit">전체 Story 모험 시간</div>
				<div class="mins"><fmt:formatNumber value="${totalMovieCntInfo.viewCnt * 30 }" pattern="#,###.##"/><span>분</span></div>
			</div>
		</div>
	</div>
	<div id="container">
		<div class="heroimg">
			<div class="logo"></div>
		</div>
		<div class="event_info">
			<div class="section">
				<h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/event_info_title.png" /></h3>
				<div class="summary">
					<dl>
						<dt>미션 기간</dt>
						<dd>2020년 3월 3일(화) ~ 3월 23일(월) 3주간</dd>
					</dl>
					<dl>
						<dt>참여 대상</dt>
						<dd>CHESS/ACE 재원생이면 누구나</dd>
					</dl>
					<dl>
						<dt>결과 발표</dt>
						<dd>2020년 3월 30일(월)</dd>
					</dl>
				</div>
				<ul class="step">
					<li>
						<h4>미션 1</h4>
						<p>비밀의 성문<br> 두드리기</p>
					</li>
					<li>
						<h4>미션 2</h4>
						<p>1층 홀<br> 봉인해제하기</p>
					</li>
					<li>
						<h4>미션 3</h4>
						<p>2층 서재<br> 봉인해제하기</p>
					</li>
					<li>
						<h4>미션 4</h4>
						<p>야외정원<br> 봉인해제하기</p>
					</li>
				</ul>
				<div class="gift_info">
					<div class="mission_gift">
						<h4><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/event_gift_mission_title.png" /></h4>
						<div class="info">
							<div class="text">
								<h5>
									<b>참여자 전원 영어노출시간 부여</b>
									<span class="benefit">1번 플레이 할 때마다 노출시간 30분 적용</span>
                                </h5>
								<br>
								<h5>
									<b>1000시간 온라인배지 부여</b>
									<div class="product"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/event_gift_completed3.png" /></div>
                                </h5>
								<ol>
									<li>상기 혜택은 MyJLS>1000시간 현황에서 확인 할 수 있습니다.<br>(3월 30일 일괄 적용)</li>
									<li>영어노출시간은 최대 3,000분까지만 적용됩니다.</li>
								</ol>
							</div>
						</div>
					</div>
					<div class="completed_gift">
						<h4><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/event_gift_completed_title.png" /></h4>
						<div class="info">
							<div class="product"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/event_gift_completed1.png" /></div>
							<div class="text">
								<h5>
									<span>미션 4단계 달성자 중 <b>2000명</b></span>
									<b>아이스크림 롤 증정</b>
								</h5>
							</div>
						</div>
						<div class="info">
							<div class="product"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/event_gift_completed2.png" /></div>
							<div class="text">
								<h5>
									<span>클리어 달성자 중 <b>20명</b></span>
									<b>문화상품권 5천원권 증정</b>
								</h5>
								<ol>
									<li>스토리 영상 21개 보고,<br> 플레이 63회 이상 달성한 친구들</li>
								</ol>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="mission">
			<div class="section">
				<h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/mission_title.png" /></h3>
				<div class="character_info">
					<div class="status">
						<c:set var="nickNm" value="" />
						<c:set var="eventLevelSeq" value="0" />
						<c:set var="levelNm" value="" />
						<c:set var="nextLevelNm" value="" />
						<c:set var="movieCnt" value="0" />
						<c:set var="viewCnt" value="0" />
						<c:set var="levelMovieCnt" value="0" />
						<c:set var="levelViewCnt" value="0" />
						<c:set var="stageNo" value="0" />
						<c:if test="${isCookies == 0}">
							<c:set var="nickNm" value='로그인해주세요. <button type="button" class="xsmall red" onclick="redirectToGojls(1)"><span>로그인</span></button>' />
						</c:if>
						<c:if test="${isUserCheck == 0}">
							<c:set var="nickNm" value="미션참여 대상이 아닙니다." />
						</c:if>
						<c:if test="${isUserCheck == 1 && eventUser != null}">
							<c:set var="nickNm" value='<b>${userNm }</b> 기사님 환영합니다.' />
							<c:set var="eventLevelSeq" value="${eventUser.eventLevelSeq }" />
							<c:set var="levelNm" value="${eventUser.levelNm }" />
							<c:set var="nextLevelNm" value="${eventUser.nextLevelNm }" />
							<c:set var="movieCnt" value="${eventUser.movieCnt }" />
							<c:set var="viewCnt" value="${eventUser.viewCnt }" />
							<c:set var="levelMovieCnt" value="${eventUser.levelMovieCnt }" />
							<c:set var="levelViewCnt" value="${eventUser.levelViewCnt }" />
							<c:set var="stageNo" value="${eventUser.stageNo+1 }" />
						</c:if>
						<h4><span>${nickNm }</span></h4>
						<div class="info">
							<div class="character">
							<c:choose>
							<c:when test="${isUserCheck == 1 }">
								<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/character_level${stageNo-1 }.png" />
							</c:when>
							<c:otherwise>
								<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/character_level0.png" />
								<p>CHESS/ACE 재원생만<br> 참여가 가능합니다.</p>
							</c:otherwise>
							</c:choose>
							</div>
							<div class="detail">
								<h5>
									<c:if test="${isUserCheck == 1 && eventUser.stageNo > -1 && eventUser.stageNo < 4}">
										<span><b id="mNm">${nextLevelNm }</b></span>
									</c:if>
									<c:if test="${isUserCheck == 1 && eventUser.stageNo >= 4}">
										<span><b id="mNm">${levelNm }</b></span>
									</c:if>
									<label>
										<c:if test="${eventUser.stageNo > -1 && eventUser.stageNo < 4}">완수 조건</c:if>
										<c:if test="${eventUser.stageNo >= 4 && viewCnt < 63}">달성</c:if>
										<c:if test="${eventUser.stageNo >= 4 && viewCnt >= 63}">클리어달성</c:if>
									</label>
								</h5>
								<ol>
									<li class="grammar"><b>${movieCnt }</b><c:if test="${eventUser.stageNo < 4}">/${levelMovieCnt }</c:if></li>
									<li class="movie"><b>${viewCnt }</b><c:if test="${eventUser.stageNo < 4}">/${levelViewCnt }</c:if></li>
								</ol>
								
								<br clear="all">
								<div class="ep1_mov"><h2><b><fmt:formatNumber type="number" maxFractionDigits="3" value="${viewCnt * 30 }" />분</b> /3,000분</h2></div>
							</div>
						</div>
					</div>
					<div class="quest">
						<ul class="tab">
							<li class="grammar selected">캐릭터수집 퀘스트</li>
							<li class="attendance">출석퀘스트</li>
						</ul>
						<div class="info grammar">
							<p>스토리 영상을 보고 성의 주민을 찾아보세요.</p>
							<ol>
							<c:forEach var="list" items="${eventMovieList}" varStatus="i">
								<c:choose>
								<c:when test="${list.viewCnt > 0 }"><li></li></c:when>
								<c:otherwise><li class="lock"></li></c:otherwise>
								</c:choose>
							</c:forEach>
							</ol>
						</div>
						<div class="info attendance hide">
							<p>매일 1개이상의 영상을 보고 출석을 완료하세요.</p>
							<ol>
							<c:choose>
							<c:when test="${fn:length(eventAttendanceList) > 0 }">
								<c:set var="maxCnt" value="${fn:length(eventAttendanceList) }" />
								<c:if test="${fn:length(eventAttendanceList) > 15 }"><c:set var="maxCnt" value="15" /></c:if>
								
								<c:forEach begin="1" end="${maxCnt}">
								<li class="check"></li>
								</c:forEach>
								<c:forEach begin="1" end="${15 - maxCnt}">
								<li></li>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<c:forEach begin="1" end="15">
								<li></li>
								</c:forEach>
							</c:otherwise>
							</c:choose>
							</ol>
						</div>
					</div>
				</div>
				<div><h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/missionmap_title.png" /></h3></div>
				<div class="mission_map">
				<c:set var="group_tmp" value="" />
				<c:forEach var="list" items="${eventMovieList}" varStatus="i">
					<c:if test="${group_tmp == '' || list.groupSeq != group_tmp }">
						<c:if test="${i.index > 0 }"></ul></c:if>
						<c:set var="active" value="" />
						<c:if test="${list.groupSeq == 1 || eventUser.stageNo >= list.groupSeq }"><c:set var="active" value="active" /></c:if>
						<ul class="card${list.groupSeq } ${active}">
					</c:if>
						<c:set var="storybookClass" value="" />
						<li <c:if test="${list.viewCnt > 0 }"><c:set var="storybookClass" value="storybook${i.index + 1 }" /></c:if>
						<c:if test="${list.groupSeq == 1  || eventUser.stageNo >= list.groupSeq }">  class="${storybookClass }" onClick="moviePop(${list.eventMovieSeq}, '${list.movieUrl}')"</c:if>>
						<c:if test="${list.viewCnt > 0 }">
							<c:set var="maxCnt" value="${list.viewCnt }" />
							<c:if test="${list.viewCnt > 3 }"><c:set var="maxCnt" value="3" /></c:if>
							<ol>
							<c:forEach var="j" begin="1" end="${maxCnt }">
								<li></li>
							</c:forEach>
							</ol>
						</c:if>
							<div class="play_icon"></div>
						</li>
					<c:set var="group_tmp" value="${list.groupSeq }" />
				</c:forEach>
					</ul>
				</div>
				<div class="copyright"><span>제작사 ㈜정상제이엘에스</span> <span>/ PD 이윤정, 정지영</span> <span>/ Story Educator 허정원</span> <span>/ Education Marketing 정영선</span><br> <span>/ Design 임영미</span> <span>/ Mobile Creator 심현식</span> <span>/ Programming 이소이</span> <span>/ Assistants 허영준, 김승균</span> <span>/ Animation Making 이충익, 최문기, 이누리</span></div>
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="nickNmFl" value="N" />
<c:choose>
<c:when test="${isUserCheck == 1 && movieCnt >= levelMovieCnt && viewCnt >= levelViewCnt && eventUser.stageNo > 0 && eventUser.stageNo < 4 }">
<input type="hidden" id="elevateFl" value="Y" />
</c:when>
<c:otherwise>
<input type="hidden" id="elevateFl" value="" />
</c:otherwise>
</c:choose>

<input type="hidden" id="cAccessCnt" value="0" />
<input type="hidden" id="cViewCnt" value="0" />
<input type="hidden" id="cMovieSeq" value="" />
<input type="hidden" id="cNextLevelSeq" value="" />
<input type="hidden" id="cNextLevelNm" value="" />
<input type="hidden" id="cNextLevelStage" value="" />

<div class="black_bg">	
	<div id="play_mov" class="pop"></div>
</div>

<div class="blue_bg">
	
	<div id="afterQuestion" class="qlayer"></div>

	<div id="levelupInfo" class="qlayer">
		<div class="scroll_left"></div>
		<div class="scroll_right"></div>
		<div class="qwrap">
			<div class="header">
				<h1>미션진급정보</h1>
			</div>
			<div class="contents">
				<div class="levelup_info">
					<div class="text">
						<h4>축하합니다.<br> <b>미션1</b>로 레벨업되었습니다.</h4>
						<h5>(동영상 1회, 플레이 1회)</h5>
					</div>
					<div class="character"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/character_level2.png" /></div>
				</div>
				<div class="btn_bottom">
					<button type="button" class="confirm"><span>확인</span></button>
				</div>
			</div>
		</div>
	</div>

	<div id="getItem" class="infolayer">
		<div class="close">Close</div>
		<div class="item"></div>
		<div class="info">
			<h4>축하합니다.<br> 스토리북에 숨어있던 성의 주민을 찾았습니다.</h4>
		</div>
	</div>

	<div id="checkAttendance" class="infolayer">
		<div class="close">Close</div>
		<div class="item"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/attendance_item.png" /></div>
		<div class="info">
			<h4>오늘 출석 퀘스트를<br> 완료했어요.</h4>
		</div>
	</div>
</div>


<script type="text/javascript">
var URL_TO_GOJLS_HOME = "<spring:eval expression="@globalContext['GOJLS_URL']" />";
var URL_TO_GOJLS_SIGN_IN = URL_TO_GOJLS_HOME.replace('http://','https://')+"/login?preURL=<spring:eval expression="@globalContext['SITE_URL']" />/storyknight/ep1";

//로그인 안 되었으면 로그인 URL 이동
function redirectToGojls(type) {
	var urlStr;
	if(type == 1){ urlStr = URL_TO_GOJLS_SIGN_IN;}
	else{urlStr = URL_TO_GOJLS_HOME;}
	
	if(opener) {
		opener.location.href = urlStr;
		self.close();
	} else {
		window.location.href = urlStr;
	}
}

/* layer popup center */
$.fn.center = function () {
	var ww = $(window).width()
	var wh = $(window).height()
	var bw = ww - $(this).outerWidth()
	var bh = wh - $(this).outerHeight()
	
	if (bh/2 < 20){
		$(this).css({top: '20px', marginTop: '0'});
	} else {
		$(this).css({top: bh/2 + 'px', marginTop: '0'});
	}
	//this.css("margin-top", "-" + $(this).outerHeight()/2 + "px");
	//this.css("margin-left", "-" + $(this).outerWidth()/2 + "px");
	return this;
}

$.fn.toppos = function () {
	$(this).css({top: '50px', marginTop: '0'});
	return this;
}

/* close popup layer */
$(document).on('click','.black_bg .close',function() {
	$(this).closest('.pop').fadeOut( function() {
		$('body').removeClass('noscroll');
		$(this).closest('.qlayer').removeAttr('style');
	});
	$('.black_bg').fadeOut();
});
$(document).on('click','.blue_bg .close',function() {
	$(this).closest('.qlayer').fadeOut( function() {
		$('body').removeClass('noscroll');
		$(this).closest('.qlayer').removeAttr('style');
	});
	$(this).closest('.infolayer').fadeOut( function() {
		if($('.black_bg').css('display') != 'block') $('body').removeClass('noscroll');
		$(this).closest('.qlayer').removeAttr('style');
		if($(this).attr('id') == 'checkAttendance') get_wizardItem();
		if($(this).attr('id') == 'getItem'){ testChallenge(); }
	});
	$('.blue_bg').fadeOut();
});

//동영상 팝업
var timerId = null;	
var player;
   
var done = false;	
var playerState;
function moviePop(eventMovieSeq, movieId){
	if('${eventInfo.eventState}' == '1' || '${isTest}' == 'Y'){
		if('${isCookies}' != '1') {
			alert("로그인 후 미션에 참여 해 주세요.\r\n\r\n스토리 영상강의는 누구나 Play 할 수 있지만\r\n미션 참여는 CHESS,ACE 재원생만 가능합니다.");	
			redirectToGojls(1);
			return;
		}
		$("#play_mov").html('');
		var param = "eventMovieSeq="+eventMovieSeq;
		$("#play_mov").load("/storyknight/${episodeSeq}/${eventInfo.eventSeq}/movie", param, function(response, status, xhr) {
		    
		    player = new YT.Player('studyVideo', {
				videoId: movieId, 
				host: 'https://www.youtube.com',
				playerVars: {   
					'controls': 0, 		// 컨트롤바 안보임 - 대신 아래 타이머 이용 프로그래스바 만듬 안되면 시간이라도 노출
					'rel':'0', 			// 종료 시 다른 동영상 정보 안 보임
					'disablekb':1, 		// 플레이어 컨트롤 사용 중지 - 좌우 화살표 방향키(몇초 앞 뒤 이동) 
					'showinfo':0,    	// 동영상 재생 시 아래 다른 곡 정보 안 보임
					'modestbranding':1,
					'fs':1,			// 전체 화면 설정 버튼
					'playsinline': 1	//ios에서 자동 풀스크린 막기
			},
			events: {
				'onReady': function(event) {// 플레이어 로드가 완료되고 API 호출을 받을 준비가 될 때마다 실행
					clearInterval(timerId);
					timerId = null;
					
					
					$("#playBtn").show();
					$("#pauseBtn").hide();
					
					playYoutube();
					
				},
				'onStateChange': function(event) {// 플레이어의 상태가 변경될 때마다 실행
					if (event.data == YT.PlayerState.ENDED || event.data == YT.PlayerState.PAUSED) {
						endTimer();
						$("#playBtn").show();
						$("#pauseBtn").hide();
						if (event.data == YT.PlayerState.ENDED){
							//문제 띄우기
							$("#afterQuestion").html('');
							var param = "eventMovieSeq="+eventMovieSeq;
							$("#afterQuestion").load("/storyknight/${episodeSeq}/${eventInfo.eventSeq}/afterQuestion/"+eventHistorySeq, param, function(response, status, xhr) {
								processFl = "";
								
								$('#afterQuestion, .blue_bg').fadeIn();
								$('#afterQuestion').center();
								$('.guide').removeClass('hide');
							});
						}
				  	}
				 	if (event.data == YT.PlayerState.PLAYING) {
				 		clearInterval(timerId);
						timerId = null;
						timerId = setInterval(printTimer, 500);  // 타이머 - 프로그래스 설정 0.5초 마다
						$("#playBtn").hide();
						$("#pauseBtn").show();
				  	}
				 	if (event.data == YT.PlayerState.CUED) {
						$("#playBtn").show();
						$("#pauseBtn").hide();
				  	}
				}
			}
		});
			
			$('body').addClass('noscroll');
			$('#play_mov, .black_bg').fadeIn();
			$('#play_mov').center();
		});
	}else{
		alert("미션 기간이 종료되었습니다.");
	}
}

/* close video layer */
$(document).on('click','#play_mov .close',function() {
	//studyVideo.pause();
	
	//endTimer();
	clearInterval(timerId);
	timerId == null;
	player.destroy();
	$(this).closest('.paper').find('.guide').addClass('hide');
});

//동영상 후 퀴즈 저장
var processFl = "";
function afterQuestionSave(eventSeq, eventHistorySeq, eventMovieSeq, answer){
	if(processFl == "Y"){
		alert('처리되었습니다. 버튼은 한번만 눌러주세요.');
		return;
	}
	var radioVal = $("#afterQuestion input[name='answer_num']:checked").val();
	if(radioVal == null || radioVal == undefined || radioVal == ''){
		alert('정답을 선택해 주세요.');
	}else{
		var wNum = Math.floor(Math.random() * 2)+1;
		//console.log("##### random : " + wNum);
		<c:choose>
		<c:when test="${isUserCheck == 0}">
			//정답여부
			var answerFl = 'N';
			if(answer == radioVal) answerFl = 'Y';
			if(answerFl == 'N'){	
				$('#afterQuestion .result').find('div').removeClass('correct_1');
				$('#afterQuestion .result').find('div').removeClass('correct_2');
				$('#afterQuestion .result').find('div').addClass('wrong_'+wNum);
				$("#afterQuestion input[name='answer_num']:eq("+(radioVal-1)+")").addClass("wrong");
			}else{
				$('#afterQuestion .result').find('div').removeClass('wrong_1');
				$('#afterQuestion .result').find('div').removeClass('wrong_2');
				$('#afterQuestion .result').find('div').addClass('correct_'+wNum);
				$("#afterQuestion input[name='answer_num']:eq("+(radioVal-1)+")").addClass("correct");
			}
			
			$('#afterQuestion input[name="answer_num"]').attr('disabled', true);
			$('#afterQuestion .result').removeClass('hide');
			$('#afterQuestion .submit_answer').addClass('hide');
			$('#afterQuestion .submit_answer').closest('.btn_bottom').find('.confirm').removeClass('hide');
			
		</c:when>
		<c:otherwise>
			processFl = "Y";
			$.ajax({
				type : "POST",
			    url : "/storyknight/"+eventSeq+"/updateEventHistory",
			    dataType : "json",		
			    data:"eventHistorySeq="+eventHistorySeq+"&eventMovieSeq="+eventMovieSeq,
				success: function(data) {
					if(data.RESULT=="SUCCESS"){
						
						var accessCnt = data.accessCnt; //오늘 접근 수
						var viewCnt = data.viewCnt;	//이 문법 뷰 수
						var elevateFl = data.elevateFl;	//승급여부
						var nextLevelInfo = data.nextLevelInfo;	//다음레벨정보					
						
						$('#cAccessCnt').val(accessCnt);
						$('#cViewCnt').val(viewCnt);
						$('#cMovieSeq').val(eventMovieSeq);
						$('#elevateFl').val(elevateFl);
						$('#cNextLevelSeq').val(nextLevelInfo.eventLevelSeq);
						$('#cNextLevelNm').val(nextLevelInfo.levelNm);
						$('#cNextLevelStage').val(nextLevelInfo.stageNo);
						
						//alert('수정되었습니다.');
						
						//동영상 횟수 추가
						var eventMovieSortSeq = eventMovieSeq - 36;
						$('.count').find('li').each(function(index, value){
							if(!$(this).hasClass('completed')){
								if(eventMovieSortSeq < 10) eventMovieSortSeq = '0'+eventMovieSortSeq;
								$(this).addClass('completed');
								$(this).html('<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/wizard_item'+eventMovieSortSeq+'.png" />');
								return false;
							}
						})
						
						//정답여부
						var answerFl = 'N';
						if(answer == radioVal) answerFl = 'Y';
						if(answerFl == 'N'){	
							$('#afterQuestion .result').find('div').removeClass('correct_1');
							$('#afterQuestion .result').find('div').removeClass('correct_2');
							$('#afterQuestion .result').find('div').addClass('wrong_'+wNum);
							$("#afterQuestion input[name='answer_num']:eq("+(radioVal-1)+")").addClass("wrong");
						}else{
							$('#afterQuestion .result').find('div').removeClass('wrong_1');
							$('#afterQuestion .result').find('div').removeClass('wrong_2');
							$('#afterQuestion .result').find('div').addClass('correct_'+wNum);
							$("#afterQuestion input[name='answer_num']:eq("+(radioVal-1)+")").addClass("correct");
						}
						
						$('#afterQuestion input[name="answer_num"]').attr('disabled', true);
						$('#afterQuestion .result').removeClass('hide');
						$('#afterQuestion .submit_answer').addClass('hide');
						$('#afterQuestion .submit_answer').closest('.btn_bottom').find('.confirm').removeClass('hide');
						
						processFl = "";
						//데이터 다시 가져와서 수정
						getData();
			         }else{
			        	processFl = "";
			         	alert(data.MSG);
						processFl = "";
			         	
			         	$('#afterQuestion button.confirm').closest('.qlayer').fadeOut( function() {
			        		$('#afterQuestion button.confirm').closest('.qlayer').removeAttr('style');
			        		$('#afterQuestion button.confirm').closest('.qlayer').find('.result').addClass('hide');
			        		$('#afterQuestion button.confirm').closest('.qlayer').find('button.confirm_result').addClass('hide');
			        		$('#afterQuestion button.confirm').closest('.qlayer').find('button.submit_answer').removeClass('hide');
			        		$('#afterQuestion button.confirm').closest('.qlayer').find('button.confirm').addClass('hide');
			        	});
			        	$('.blue_bg').fadeOut();
			         }
				},
		    	error:function(xhr, ajaxOpts, thrownErr){ 
		    		processFl = "";
		    		alert(xhr +'/'+ thrownErr ); 
		    	}			
			});
		</c:otherwise>
		</c:choose>
	}
	
}

/* hide question layer*/
$(document).on('click','#afterQuestion button.confirm',function() {

	$(this).closest('.qlayer').fadeOut( function() {
		$(this).closest('.qlayer').removeAttr('style');
		$(this).closest('.qlayer').find('.result').addClass('hide');
		$(this).closest('.qlayer').find('button.confirm_result').addClass('hide');
		$(this).closest('.qlayer').find('button.submit_answer').removeClass('hide');
		$(this).closest('.qlayer').find('button.confirm').addClass('hide');
	});
	$('.blue_bg').fadeOut();

	var accessCnt = $('#cAccessCnt').val(); //오늘 접근 수
	var viewCnt = $('#cViewCnt').val();	//이 문법 뷰 수
	var elevateFl = $('#elevateFl').val();	//승급여부
	
	if(accessCnt == 1){
		//alert("오늘 출석 완료");
		checkAttendance();
	}else if(viewCnt == 1){
		//alert("오늘 문법 완료");
		get_wizardItem();
	}else if(elevateFl == 'Y'){
		testChallenge();
	}
});

//승급팝업 확인
/* show levelup layer */
$(document).on('click','#levelupInfo button.confirm',function() {
	$(this).closest('.qlayer').fadeOut( function() {
		$(this).closest('.qlayer').removeAttr('style');
	});
	$('.blue_bg').fadeOut();
});

//출석 카드 호출
function checkAttendance() {
	if($('#cAccessCnt').val() == 1){
		$('#cAccessCnt').val('0');
		$('body').addClass('noscroll');
		$('#checkAttendance, .blue_bg').fadeIn();
		$('#checkAttendance').center();
	}else{
		get_wizardItem();
	}
}

//문법 카드 호출
function get_wizardItem() {
	if($('#cViewCnt').val() == 1){
		var cMovieSeq = $('#cMovieSeq').val();
		var movieSortSeq = cMovieSeq - 36;
		if(movieSortSeq < 10) movieSortSeq = '0'+movieSortSeq;
		$('#getItem .item').html('<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/wizard_item'+movieSortSeq+'.png" />');
		$('#cViewCnt').val('0');
		$('#cMovieSeq').val('');
		
		$('body').addClass('noscroll');
		$('#getItem, .blue_bg').fadeIn();
		$('#getItem').center();
	}else{
		testChallenge();
	}
}

//승급 카드 호출
function testChallenge() {
	var elevateFl = $('#elevateFl').val();	//승급여부
	var nextLevelSeq = $('#cNextLevelSeq').val();	//다음레벨정보
	var nextLevelNm = $('#cNextLevelNm').val();	//다음레벨정보
	var nextLevelStage = $('#cNextLevelStage').val();	//다음레벨정보
	
	if(elevateFl == 'Y'){

		//alert("축하합니다. "+nextLevelNm+'로 레벨업되었습니다.');
		var levelup_info = '';
		levelup_info += '<div class="text">';
		if(nextLevelStage == 1){	//미션1
			levelup_info += '	<h4>축하합니다.<br> 비밀의 성에 들어왔습니다.</h4>';
			levelup_info += '	<h5>(동영상 1회, 플레이 1회)</h5>';
		}else if(nextLevelStage == 2){
			levelup_info += '	<h4>축하합니다.<br> 1층 홀이 봉인해제 되었습니다.</h4>';
			levelup_info += '	<h5>(동영상 7회, 플레이 14회)</h5>';
		}else if(nextLevelStage == 3){
			levelup_info += '	<h4>축하합니다.<br> 2층 서재가 봉인해제 되었습니다.</h4>';
			levelup_info += '	<h5>(동영상 14회, 플레이 30회)</h5>';
		}else if(nextLevelStage == 4){
			levelup_info += '	<h4>축하합니다.<br> 야외정원이 봉인해제되어<br>Story Knight 작위를 획득했습니다.</h4>';
			levelup_info += '	<h5>(동영상 21회, 플레이 50회)</h5>';
		}
		levelup_info += '</div>';
		levelup_info += '<div class="character"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/character_level'+(nextLevelStage)+'.png" /></div>';
		$('.levelup_info').html(levelup_info);
	
		$('body').addClass('noscroll');
		$('#levelupInfo, .blue_bg').fadeIn( function() {
			$('#levelupInfo').toppos();
		});
		
		$('#cNextLevelSeq').val('');
		$('#cNextLevelNm').val('');
		$('#cNextLevelStage').val('');
	}
}

/* challenge yes or no */
$(document).on('click','button.challenge_now',function() {
	//카드 닫기
	$(this).closest('.infolayer').fadeOut();
	
	//뒤에 동영상 닫기
	$(this).closest('.pop').fadeOut( function() {
		$('body').removeClass('noscroll');
		$(this).closest('.qlayer').removeAttr('style');
	});
	$('.black_bg').fadeOut();
});

$(document).on('click','button.challenge_later',function() {
	$(this).closest('.infolayer').fadeOut();
	$('.blue_bg').fadeOut();
});

function getData(){
	$.ajax({
		type : "POST",
	    url : "/storyknight/${episodeSeq}",
	    dataType : "json",		
	    data:null,
		success: function(data) {
			if(data.RESULT=="SUCCESS"){
				var totalMovieCntInfo = data.totalMovieCntInfo;
				var eventUser = data.eventUser;
				var eventMovieList = data.eventMovieList;
				var eventAttendanceList = data.eventAttendanceList;
				
				//상단 미션도전 시간
				$('.mins').html((totalMovieCntInfo.viewCnt*30).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'<span>분</span>');
				
				//사용자정보 변경
				var stageNo = eventUser.stageNo;
				var character_html = '<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/character_level'+(stageNo)+'.png" />';
				$('.character_info .character').html(character_html);

				var levelSeq = eventUser.eventLevelSeq;
				var levelNm = eventUser.levelNm;
				var nextLevelNm = eventUser.nextLevelNm;
				var movieCnt = eventUser.movieCnt;
				var levelMovieCnt = eventUser.levelMovieCnt;
				var viewCnt = eventUser.viewCnt;
				var levelViewCnt = eventUser.levelViewCnt;
								
				if(stageNo >= 4){//레벨4
					$('.info .grammar').html('<b>'+movieCnt+'</b>');
					$('.info .movie').html('<b>'+viewCnt+'</b>');
					if(viewCnt < 63){
						$('.info label').html('달성');
					}else{
						$('.info label').html('클리어달성');
					}
				}else{
					$('.info .detail h5 #mNm').html(nextLevelNm);
					$('.info .grammar').html('<b>'+movieCnt+'</b>/'+levelMovieCnt);
					$('.info .movie').html('<b>'+viewCnt+'</b>/'+levelViewCnt);
				}
				
				//영어노출시간
				$('.ep1_mov h2 b').html((viewCnt*30).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'분');
				
				//퀘스트 변경
				var movieQuestHtml = "";
				for(var i=0; i<data.eventMovieList.length; i++){
					if(data.eventMovieList[i].viewCnt > 0){
						movieQuestHtml += '<li></li>';
					}else{
						movieQuestHtml += '<li class="lock"></li>';
					}
				}
				$('.quest > .info.grammar ol').html(movieQuestHtml);
				
				var attendanceQuestHtml = "";
				var attendanceMaxCnt = (data.eventAttendanceList.length > 15)?15:data.eventAttendanceList.length;
				for(var i=0; i<attendanceMaxCnt; i++){
					attendanceQuestHtml += '<li class="check"></li>';
				}
				for(var i=0; i<(15-attendanceMaxCnt); i++){
					attendanceQuestHtml += '<li></li>';
				}
				$('.quest > .info.attendance ol').html(attendanceQuestHtml);
								
				//문법 리스트
				var movieListHtml = '';
				var eventMovieList = data.eventMovieList;
				var group_tmp = '';
				for(var i=0; i< eventMovieList.length; i++){
					if(grou_tmp = '' || eventMovieList[i].groupSeq != group_tmp){
						if(i > 0) movieListHtml += '</ul>';
						movieListHtml += '<ul class="card'+eventMovieList[i].groupSeq;
						if(eventMovieList[i].groupSeq == 1 || stageNo >= eventMovieList[i].groupSeq) movieListHtml += ' active';
						movieListHtml += '">';
					}
					movieListHtml += '<li ';
					if(eventMovieList[i].groupSeq == 1 || stageNo >= eventMovieList[i].groupSeq){
						if(eventMovieList[i].viewCnt > 0) movieListHtml += ' class="storybook'+(i+1)+'"';
						movieListHtml += ' onClick="moviePop('+eventMovieList[i].eventMovieSeq+', \''+eventMovieList[i].movieUrl+'\')"';
					}
					movieListHtml += '>';
					if(eventMovieList[i].viewCnt > 0){
						var maxCnt = (eventMovieList[i].viewCnt > 3)?3:eventMovieList[i].viewCnt;
						movieListHtml += '<ol>';
						for(var j=0;j<maxCnt;j++){
							movieListHtml += '<li></li>';
						}
						movieListHtml += '</ol>';
					}
					movieListHtml += '	<div class="play_icon"></div>';
					movieListHtml += '</li>';
					group_tmp = eventMovieList[i].groupSeq;
				}
				$('.mission_map').html(movieListHtml);
	         }else{
	         	alert(data.MSG);
	         }
		},
    error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }			
	});
}
</script>
<script>

$(document).ready(function(){
	$("#playBtn").hide();
	$("#pauseBtn").hide();
});

// 이미 로드된 노래 재 시작
function playYoutube() {
	player.playVideo();
}

function pauseYoutube() {
	player.pauseVideo();
}

// 타이머 프로그래스바 구현 - 전체 플레이 시간은 디비에 넣고 player.getCurrentTime(); 로 현재 재생 시간 알아서 % 로 구현 함
function printTimer(){
	if(player){
		var total = player.getDuration().toFixed(0);
		var time = player.getCurrentTime().toFixed(0);
		//console.log('#### time :: '+time);
		$('#current_time').html(transTime(time) + '/' + transTime(total) );
	}
}

function endTimer(){
	if(timerId != null) {
		clearInterval(timerId);
		timerId == null;
	}
}
    
function transTime(time){
	var min = addZero(parseInt(time/60), 2); 
	var sec = addZero(parseInt(time%60), 2);
	var timeStr = min + ":"+ sec;
	return timeStr;
}

function addZero(n, width) {
	n = n + '';
	return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}

</script>
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "49388429f1245c";
wcs_do();
</script>

</body>
</html>