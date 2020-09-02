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
<meta name="viewport" content="width=1024">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="theme-color" content="#1278bc">
<meta property="og:image" content="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/heroimg_bg.jpg" />
<meta property="og:title" content="Grammar Wizard">
<meta property="og:description" content="Episode2. 전쟁의 서막, 천사의 날개">
<title>Grammar Wizard</title>
<link rel="shortcut icon" type="image/x-icon" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/favicon_jls.ico?${millis}" />
<link rel="apple-touch-icon" sizes="120x120" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_120.png?${millis}" />
<link rel="apple-touch-icon" sizes="152x152" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_152.png?${millis}" />
<link rel="apple-touch-icon" sizes="167x167" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_167.png?${millis}" />
<link rel="apple-touch-icon" sizes="180x180" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_180.png?${millis}" />
<link rel="icon" sizes="192x192" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_192.png?${millis}" />
<link rel="icon" sizes="512x512" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_512.png?${millis}" />
<link rel="stylesheet" type="text/css" href="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/swiper-4.5.0/css/swiper.min.css" />
<link type="text/css" rel="stylesheet" media="all" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/css/learningkids/grammarwizard2_20200116.css?${millis}" />
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
			<h2>지금도 마법사들의 모험은 계속되고 있습니다.</h2>
			<div class="status">
				<div class="tit">전체 Grammar 미션 도전</div>
				<div class="mins"><fmt:formatNumber value="${totalMovieCntInfo.viewCnt * 10 }" pattern="#,###.##"/><span>분</span></div>
			</div>
		</div>
		<div class="board">
		<c:if test="${fn:length(eventNoticeList) > 0 }">
			<div class="text">
			<c:if test="${fn:length(eventNoticeList) > 0 }">
				${eventNoticeList[0].content}
			</c:if>
			</div>
		</c:if>
		</div>
	</div>
	<div id="container">
		<div class="heroimg">
			<div class="logo"></div>
			<div class="intro_mov">
				<button type="button" class="intro_mov" onclick="show_prologue();"><span>프롤로그 영상 보기</span></button>
			</div>
		</div>
		<div class="event_info">
			<div class="section">
				<h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/event_info_title.png" /></h3>
				<div class="summary">
					<dl>
						<dt>미션 기간</dt>
						<dd>2020년 1월 21일(화) ~ 2월 10일(월) 3주간</dd>
					</dl>
					<dl>
						<dt>참여 대상</dt>
						<dd>CHESS, ACE 재원생이면 누구나 (집중대상: 초5~중2)</dd>
					</dl>
					<dl>
						<dt>결과 발표</dt>
						<dd>2020년 2월 17일(월)</dd>
					</dl>
				</div>
				<ul class="step">
					<li>
						<h4>Pre-미션</h4>
						<p>위대한 마법사들이여<br> 자격을 증명하라</p>
					</li>
					<li>
						<h4>미션 1</h4>
						<p>날개를 잃어버린<br> 천사를 만나라</p>
					</li>
					<li>
						<h4>미션 2</h4>
						<p>1개의<br> 깃털을 찾아라</p>
					</li>
					<li>
						<h4>미션 3</h4>
						<p>깃털을 더 모아<br> 날개 반쪽을 완성시켜라</p>
					</li>
					<li>
						<h4>미션 4</h4>
						<p>전체 날개를 완성하여<br> 천사에게 돌려주어라</p>
					</li>
				</ul>
				<div class="gift_info">
					<div class="completed_gift">
						<h4><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/event_gift_completed_title.png" /></h4>
						<div class="info">
							<div class="product"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/event_gift_completed1.png" /></div>
							<div class="text">
								<h5>
									<span>미션 4단계 달성자 중 30명</span>
									<b>블루투스 이어폰 증정</b>
								</h5>
							</div>
						</div>
						<div class="info">
							<div class="product"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/event_gift_completed2.png" /></div>
							<div class="text">
								<h5>
									<span>미션 4단계 달성자 중 600명</span>
									<b>문화상품권 5천원권 증정</b>
								</h5>
							</div>
						</div>
					</div>
					<div class="mission_gift">
						<h4><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/event_gift_mission_title.png" /></h4>
						<div class="info">
							<div class="product"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/event_gift_mission.png" /></div>
							<div class="text">
								<h5>
									<span>퀘스트 달성자 중 1000명</span>
									<b>던킨도너츠 핫초코 증정</b>
								</h5>
								<ol>
									<li>출석퀘스트 달성자 중 500명 추첨</li>
									<li>아이템수집 퀘스트 달성자 중 500명 추첨</li>
								</ol>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="mission">
			<div class="section">
				<h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/mission_title.png" /></h3>
				<div class="ranking">
					<div class="ranking-wrap">
						<ul class="swiper-wrapper">
							<c:forEach var="list" items="${eventTopUserList}" varStatus="i">
							<li class="swiper-slide <c:if test="${list.eventUserSeq == eventUser.eventUserSeq }">me</c:if>">
								<h4>${list.nickNm }</h4>
								<ol>
									<li>아이템수집 : <b>${list.movieCnt }개</b></li>
									<li>영상재생 : <b>${list.viewCnt }회</b></li>
								</ol>
								<p>도전 : <b>${list.levelNm }</b></p>
							</li>
							</c:forEach>
						</ul>
					</div>
					<div class="swiper-next"></div>
					<div class="swiper-prev"></div>
				</div>
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
							<c:choose>
							<c:when  test="${eventUser.stageNo == -1}">
							<c:set var="nickNm" value='<b class="red">위대한 마법사</b> 인증이 필요합니다. <button type="button" class="xsmall red" onclick="certification()"><span>자격증명하기</span></button>' />
							</c:when>
							<c:when  test="${eventUser.nickNm == null || eventUser.nickNm == ''}">
							<c:set var="nickNm" value='마법사 이름을 설정하세요. <button type="button" class="xsmall red" onclick="set_name()"><span>설정</span></button>' />
							</c:when>
							<c:otherwise>
							<c:set var="nickNm" value='${eventUser.nickNm }' />
							</c:otherwise>
							</c:choose>
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
								<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/character_level${stageNo }.png" />
							</c:when>
							<c:otherwise>
								<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/character_level0.png" />
								<p>CHESS, ACE 재원생만<br> 참여가 가능합니다.</p>
							</c:otherwise>
							</c:choose>
								<button type="button" class="cookie" onclick="show_cookie();" style="display:<c:if test="${isUserCheck != 1 || eventUser == null || eventUser.stageNo < 4 }">none</c:if>;"><span>쿠키코믹스</span></button>
							</div>
							<div class="detail">
								<h5>
									<c:if test="${isUserCheck == 1 && eventUser.stageNo > -1 && eventUser.stageNo < 4}"><span>${nextLevelNm }</b></span></c:if>
									<label><c:if test="${eventUser.stageNo > -1 && eventUser.stageNo < 4}">완수 조건</c:if></label>
								</h5>
								<ol>
									<li class="grammar"><b>${movieCnt }</b><c:if test="${eventUser.stageNo < 4}">/${levelMovieCnt }</c:if></li>
									<li class="movie"><b>${viewCnt }</b><c:if test="${eventUser.stageNo < 4}">/${levelViewCnt }</c:if></li>
								</ol>
								
								<c:choose>
								<c:when test="${eventUser.stageNo >= 4 }">
									<button type="button" class="test completed" disabled><span>미션완수</span></button>
								</c:when>
								<c:otherwise>
									<button type="button" class="test" onclick="levelupChallenge();" <c:if test="${isUserCheck != 1 || eventUser.stageNo < 1 || movieCnt < levelMovieCnt || viewCnt < levelViewCnt}">disabled</c:if>><span>Level 진급 테스트</span></button>
								</c:otherwise>
								</c:choose>
								
								<br clear="all">
								<button type="button" class="ep1_mov" onclick="show_ep1list();"><span>EP1.문법강의보기</span></button>
							</div>
						</div>
					</div>
					<div class="quest">
						<ul class="tab">
							<li class="grammar selected">아이템수집 퀘스트</li>
							<li class="attendance">출석퀘스트</li>
						</ul>
						<div class="info grammar">
							<p>다양한 문법영상을 보고 생존아이템을 수집하세요.</p>
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
				<div class="mission_map">
				<c:set var="group_tmp" value="" />
				<c:forEach var="list" items="${eventMovieList}" varStatus="i">
					<c:if test="${group_tmp == '' || list.groupSeq != group_tmp }">
						<c:if test="${i.index > 0 }"></ul></c:if>
						<c:set var="active" value="" />
						<c:if test="${eventUser.stageNo > -1 && (list.groupSeq == 1 || list.isOpen == 1) }"><c:set var="active" value="active" /></c:if>
						<ul class="card${list.groupSeq } ${active}">
					</c:if>
						<li <c:if test="${eventUser.stageNo > -1 && (list.groupSeq == 1 || list.isOpen == 1) }">onClick="moviePop(${list.eventMovieSeq}, '${list.movieUrl}')"</c:if>>
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
							<c:if test="${list.viewCnt > 0 }"><div class="name_tag"><span>${list.movieNm }</span></div></c:if>
						</li>
					<c:set var="group_tmp" value="${list.groupSeq }" />
				</c:forEach>
					</ul>
				</div>
				<div class="copyright"><span>제작사 ㈜정상제이엘에스</span> <span>/ PD 이윤정, 정지영</span> <span>/ Grammar Educator 백은희, 홍주영, 홍제기</span> <span>/ Education Marketing 정영선</span> <span>/ Design 임영미, 심현식</span><br> <span>/ Programming 이소이</span> <span>/ Assistants 허영준, 김승균</span> <span>/ VFX 최문기, 이누리</span></div>
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

<div class="black_bg">
	<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/js/sheetrock-master/sheetrock.min.js"></script>
	<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/js/sheetrock-master/handlebars.min.js"></script>
	<script type="text/javascript">
	/* close popup layer */
	
	$(document).ready(function() {
		/* google sheetrock : el6 winter */
		var EP1Card1 = 'https://docs.google.com/spreadsheets/d/1e_jE62GcUlN7QSJ0ZYXhNsO1aZTNOFiPRE6o4vpcyi4/edit#gid=629605667';
		var EP1Card1Template = Handlebars.compile($('#ep1-card1-template').html());
		$('#ep1-card1').sheetrock({
			url: EP1Card1,
			query: "select F,H",
			fetchSize: 5,
			rowTemplate: EP1Card1Template
		});
		/* google sheetrock : TMAPS */
		var EP1Card2 = 'https://docs.google.com/spreadsheets/d/1E73f7ouEksTAXvYziUR3xELN8wWc-e48FnXHBDTSOsM/edit#gid=696627163';
		var EP1Card2Template = Handlebars.compile($('#ep1-card2-template').html());
		$('#ep1-card2').sheetrock({
			url: EP1Card2,
			query: "select C,J limit 5",
			rowTemplate: EP1Card2Template
		});
		/* google sheetrock : TMAPS */
		var EP1Card3 = 'https://docs.google.com/spreadsheets/d/1E73f7ouEksTAXvYziUR3xELN8wWc-e48FnXHBDTSOsM/edit#gid=696627163';
		var EP1Card3Template = Handlebars.compile($('#ep1-card3-template').html());
		$('#ep1-card3').sheetrock({
			url: EP1Card3,
			query: "select C,J limit 5 offset 5",
			rowTemplate: EP1Card3Template
		});
		
	});
	$(document).on('click','#play_ep1mov .close',function() {
		$(this).closest('.pop').fadeOut();
		$('.blue_bg').fadeOut();
		$('#play_ep1mov .video-wrapper').html('');
	});

	function show_ep1mov(fileName) {
		$('#play_ep1mov, .blue_bg').fadeIn();
		$('#play_ep1mov').center();
		$('#play_ep1mov .video-wrapper').append('<div class="plyr__video-embed" id="player"><iframe src="https://www.youtube.com/embed/' + fileName + '?origin=https://plyr.io&amp;iv_load_policy=3&amp;modestbranding=1&amp;playsinline=1&amp;showinfo=0&amp;rel=0&amp;enablejsapi=1" allowfullscreen allowtransparency allow="autoplay"></iframe></div>');
		
	}
	</script>
	<div id="ep1_list" class="pop">
		<div class="close">close</div>
		<div class="mission_map_ep1">
			<ul id="ep1-card1" class="card1 active">
				<script id="ep1-card1-template" type="text/x-handlebars-template">
				<li onclick="show_ep1mov('{{cells.Code}}');">
					<div class="play_icon"></div>
					<div class="name_tag"><span>{{cells.Title}}</span></div>
				</li>
				</script>
			</ul>
			<ul id="ep1-card2" class="card2 active">
				<script id="ep1-card2-template" type="text/x-handlebars-template">
				<li onclick="show_ep1mov('{{cells.Code}}');">
					<div class="play_icon"></div>
					<div class="name_tag"><span>{{cells.Subject}}</span></div>
				</li>
				</script>
			</ul>
			<ul id="ep1-card3" class="card3 active">
				<script id="ep1-card3-template" type="text/x-handlebars-template">
				<li onclick="show_ep1mov('{{cells.Code}}');">
					<div class="play_icon"></div>
					<div class="name_tag"><span>{{cells.Subject}}</span></div>
				</li>
				</script>
			</ul>
		</div>
	</div>
	
	<div id="play_prologue" class="pop">
		<div class="paper">
			<div class="close">close</div>
			<div class="video-wrapper">
				<video id="prologue" controls controlsList=”nodownload”>
					<source src="http://tube.gojls.com/cdn/hms/gw_ep2_intro.mp4" type="video/mp4">
				</video>
			</div>
		</div>
	</div>
	
	<div id="play_mov" class="pop"></div>
	<div id="set_name" class="set_layer">
		<div class="set_wrap">
			<div class="header">
				<h1>마법사 이름은 한번 설정하면 변경할 수 없어요.<br> 멋지고 예쁜 이름을 입력하세요.</h1>
			</div>
			<div class="contents">
				<div class="row_group" id="authMobi_set">
					<div class="input_row">
						<div class="input_cell">
							<input type="text" id="nickNm" class="wizard_name" placeholder="한글 이름을 입력하세요.(8자 이하)" maxlength="8" />
							<button type="button" class="check_name gray medium" disabled><span>Check</span></button>
						</div>
						<p class="error_txt" style="display:none;"></p>
					</div>
				</div>
			</div>
			<div class="btn_bottom">
				<button type="button" class="cancel"><span>취소</span></button>
				<button type="button" class="save" onclick="change_nickNm()"><span>저장하기</span></button>
				<p>(부적절한 이름을 입력한 경우 삭제될 수 있습니다.)</p>
			</div>
		</div>
		<div class="close">Close</div>
	</div>
	<div id="cookie_comics" class="pop">
		<div class="close">close</div>
		<div class="comics_img"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/character_detail_credit_cookie.jpg" /></div>
	</div>

</div>

<div class="blue_bg">
	<div id="play_ep1mov" class="pop">
		<div class="paper">
			<div class="close">close</div>
			<div class="video-wrapper"></div>
		</div>
	</div>
	
	<div id="afterQuestion" class="qlayer"></div>
	<div id="levelupChallenge" class="qlayer"></div>

	<div id="levelupInfo" class="qlayer">
		<div class="scroll_left"></div>
		<div class="scroll_right"></div>
		<div class="qwrap">
			<div class="header">
				<h1>승급정보</h1>
			</div>
			<div class="contents">
				<div class="levelup_info">
					<div class="text">
						<h4>축하합니다.<br> <b>미션1</b>로 레벨업되었습니다.</h4>
						<h5>(동영상 1회, 플레이 1회)</h5>
					</div>
					<div class="character"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/character_level2.png" /></div>
				</div>
				<div class="btn_bottom">
					<button type="button" class="confirm"><span>확인</span></button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="testChallenge" class="infolayer">
		<div class="close">Close</div>
		<div class="item"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/levelup_item.png" /></div>
		<div class="info">
			<h4>미션 완수 테스트가 열렸어요.</h4>
			<h5>지금 도전하고<br> 다음 미션으로 레벨업하세요.</h5>
		</div>
		<div class="btn_bottom">
			<button type="button" class="challenge_now"><span>네. 지금 도전하겠습니다.</span></button>
			<button type="button" class="challenge_later"><span>아니오. 나중에 보겠습니다.</span></button>
		</div>
	</div>

	<div id="getItem" class="infolayer">
		<div class="close">Close</div>
		<div class="item"></div>
		<div class="info">
			<h4>축하합니다.<br> 생존 아이템을 획득했습니다.</h4>
		</div>
	</div>

	<div id="checkAttendance" class="infolayer">
		<div class="close">Close</div>
		<div class="item"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/attendance_item.png" /></div>
		<div class="info">
			<h4>오늘 출석 퀘스트를<br> 완료했어요.</h4>
		</div>
	</div>
</div>


<script type="text/javascript">
var URL_TO_GOJLS_HOME = "<spring:eval expression="@globalContext['GOJLS_URL']" />";
var URL_TO_GOJLS_SIGN_IN = URL_TO_GOJLS_HOME.replace('http://','https://')+"/login?preURL=<spring:eval expression="@globalContext['SITE_URL']" />/grammar/ep2";

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
		if($(this).attr('id') == 'play_cookie'){
			cookieVideo.pause();
			cookieVideo.currentTime = 0;
			//$('#cookieVideo').html('');
		}
		if($(this).attr('id') == 'play_intro'){
			cookieVideo_i.pause();
			cookieVideo_i.currentTime = 0;
			//$('#cookieVideo').html('');
		}
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

/* play video layer */
$(document).on('click','#play_prologue .close',function() {
	prologue.currentTime = 0;
	prologue.pause();
});
function show_prologue() {
	$('body').addClass('noscroll');
	$('#play_prologue, .black_bg').fadeIn();
	$('#play_prologue').center();
	prologue.play();
}

//닉네임
function set_name() {
	$('.set_layer .wizard_name').val('');
	$('.set_layer button.check_name').closest('.input_row').addClass('error').find('.error_txt').removeClass('ok').text('').hide();
	$('.set_layer .wizard_name').next('button').prop('disabled', true).switchClass('red', 'gray', 0);
	
	$('body').addClass('noscroll');
	$('#set_name, .black_bg').fadeIn();
	$('#set_name').center();
}

//ep1 목록
function show_ep1list() {
	if('${eventInfo.eventState}' == '1' || '${isTest}' == 'Y'){
		if('${isCookies}' != '1') {
			alert("로그인 후 미션에 참여 해 주세요.\r\n\r\n문법 강의는 누구나 Play 할 수 있지만\r\n미션 참여는 CHESS,ACE 재원생만 가능합니다.");	
			redirectToGojls(1);
			return;
		}
		$('body').addClass('noscroll');
		$('#ep1_list, .black_bg').fadeIn();
		//$('#play_cookie').center();
	}else{
		alert('미션 기간이 종료되었습니다.');
	}
}

//ep1 자격증명
function certification(){
	levelupChallengeFl = '';
	quiz_num = 0;
	correct_quiz_cnt = 0;
	
	if('${eventInfo.eventState}' == '1' || '${isTest}' == 'Y'){
		if('${eventUser.stageNo}' == '-1'){
			$("#levelupChallenge").html('');
			var param = "";
			$("#levelupChallenge").load("/grammar/${eventInfo.eventSeq}/certification?eventPrevSeq=2", param, function(response, status, xhr) {
				$('body').addClass('noscroll');
				$('#levelupChallenge, .blue_bg').fadeIn( function() {
					$('#levelupChallenge').center();
				});
			});
		}else{
			alert("위대한 마법사 인증을 이미 하셨습니다.");
		}
	}else{
		alert("미션 기간이 종료되었습니다.");
	}
}

function show_cookie() {
	$('body').addClass('noscroll');
	$('#cookie_comics, .black_bg').fadeIn();
	//$('#play_cookie').center();
}

/* close set layer */
$(document).on('click','.set_layer .close, .set_layer button.cancel',function() {
	$('.black_bg, .set_layer').fadeOut( function() {
		$('body').removeClass('noscroll');
	});
});

/* check keyup name */
$(document).on('keyup','.set_layer .wizard_name',function(event) {
	var name_num = $(this).val().length;
	if (name_num == 0) {
		$(this).next('button').prop('disabled', true).switchClass('red', 'gray', 0);
		$('.set_layer button.check_name').closest('.input_row').addClass('error').find('.error_txt').removeClass('ok').text('').hide();
	} else {
		$(this).next('button').prop('disabled', false).switchClass('gray', 'red', 0);
	}
	
	if (event.keyCode == 13) { // 엔터키면 
        $('.set_layer button.check_name').click(); // check click 
        return;
    }
});

/* get name */
$(document).on('click','.set_layer button.check_name',function() {
	if('${eventInfo.eventState}' == '1' || '${isTest}' == 'Y'){
		var nick_name = $(this).prev('.wizard_name').val();//.replace(/\s/gi,'');
		if(nick_name == ''){
			$(this).prev('.wizard_name').val('');
			alert('마법사의 이름을 넣어주세요.');
		}else{

			var regexp =  /([^가-힣ㄱ-ㅎㅏ-ㅣ0-9])/i;
			if(regexp.test(nick_name)) {
				//alert('한글만 입력가능 합니다.');
				//$(this).val(v.replace(regexp, ''));
				$('.set_layer button.check_name').closest('.input_row').addClass('error').find('.error_txt').removeClass('ok').text('마법사 이름은 한글, 숫자만 입력할 수 있습니다.').show();
				return;
			}
			
			$.ajax({
				type : "POST",
			    url : "/grammar/${eventInfo.eventSeq}/nickNmCheck",
			    dataType : "json",		
			    data:"nickNm="+nick_name,
				success: function(data) {
					if(data.RESULT=="SUCCESS"){
						$('.set_layer button.check_name').closest('.input_row').addClass('error').find('.error_txt').addClass('ok').text('사용 가능한 마법사 이름입니다.').show();
						$('#nickNmFl').val('Y');
			         }else{
			         	//alert(data.MSG);
			         	$('#nickNmFl').val('N');
			         	if(data.RESULT == "FAIL2"){
			         		var nickNm = $('.set_layer button.check_name').prev('.wizard_name').val();
			         		var swearWord = data.swear;
			         		var starWord = '';
			         		for(var i=0; i<swearWord.length; i++){
			         			starWord += '*';
			         		}
			         		$('.set_layer button.check_name').prev('.wizard_name').val(nickNm.replace(swearWord,starWord));
			         	}
						$('.set_layer button.check_name').closest('.input_row').addClass('error').find('.error_txt').removeClass('ok').text(data.MSG+' 다시 입력해주세요.').show();
			         }
				},
		    error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }			
			});
		}
	}else{
		alert('미션 기간이 종료되었습니다.');
	}
});

function change_nickNm(){
	var nickNm = $('#nickNm').val();
	var nickNmFl = $('#nickNmFl').val();
	if(nickNmFl != 'Y'){
		alert('마법사의 이름을 확인해주세요.');
	}else{
		$.ajax({
			type : "POST",
		    url : "/grammar/${eventInfo.eventSeq}/changeNickNm",
		    dataType : "json",		
		    data:"nickNm="+nickNm,
			success: function(data) {
				if(data.RESULT=="SUCCESS"){
					//alert('수정되었습니다.');
					$('.character_info').find('h4').find('span').html(nickNm);
					$('.black_bg, .set_layer').fadeOut( function() {
						$('body').removeClass('noscroll');
					});
		         }else{
		         	alert(data.MSG);
		         }
			},
	    error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }			
		});
	}
}

//승급테스트보러가기
var levelupChallengeFl = '';
var quiz_num = 0;
var correct_quiz_cnt = 0;

function levelupChallenge(){
	levelupChallengeFl = '';
	quiz_num = 0;
	correct_quiz_cnt = 0;
	
	if('${eventInfo.eventState}' == '1' || '${isTest}' == 'Y'){
		if($('#elevateFl').val() == 'Y'){
			$("#levelupChallenge").html('');
			var param = "";
			$("#levelupChallenge").load("/grammar/${eventInfo.eventSeq}/levelup", param, function(response, status, xhr) {
				$('body').addClass('noscroll');
				$('#levelupChallenge, .blue_bg').fadeIn( function() {
					$('#levelupChallenge').center();
				});
			});
		}else{
			alert("완수조건이 안됩니다.");
		}
	}else{
		alert("미션 기간이 종료되었습니다.");
	}
}

/* submit challenge : levelup test */
$(document).on('click','#levelupChallenge button.submit_challenge',function() {
	$(this).closest('.contents').addClass('hide').next('.contents').removeClass('hide');
});

/* submit answer : levelup test */
$(document).on('click','#levelupChallenge button.submit_answer',function() {
	var radioVal = $(this).closest('.contents').find("input[name='answer_num']:checked").val();
	if(radioVal == null || radioVal == undefined || radioVal == ''){
		alert('정답을 선택해 주세요.');
	}else{
		var answerFl = 'N';
		var answer = $(this).closest('.contents').find('#ans').val();
		
		if(answer == radioVal){
			correct_quiz_cnt += 1;
			answerFl = 'Y';
		}
		if(answerFl == 'N'){	
			$(this).closest('.contents').find('.result').find('div').removeClass('correct');
			$(this).closest('.contents').find('.result').find('div').addClass('wrong');
			$(this).closest('.contents').find("input[name='answer_num']:eq("+(answer-1)+")").addClass("correct");
		}else{
			$(this).closest('.contents').find('.result').find('div').addClass('correct');
			$(this).closest('.contents').find('.result').find('div').removeClass('wrong');
			$(this).closest('.contents').find("input[name='answer_num']").removeClass("correct");
		}
		
		$(this).closest('.contents').find("input[name='answer_num']").attr('disabled', true);
		$(this).addClass('hide');
		$(this).closest('.contents').find('.result').removeClass('hide');
		$(this).closest('.contents').find('button.next, button.confirm_result').removeClass('hide');
	}
});

/* submit answer : levelup next test */
$(document).on('click','#levelupChallenge button.next, #levelupChallenge button.confirm_result',function() {
	var radioVal = $("#levelupChallenge input[name='answer_num']:checked").val();
	if(radioVal == null || radioVal == undefined || radioVal == ''){
		alert('정답을 선택해 주세요.');
	}else{
		quiz_num += 1;
		$(this).closest('.contents').addClass('hide').next('.contents').removeClass('hide');
	}
});

/* submit answer : levelup confirm test */
function levelupResult(eventSeq, eventElevateSeq, stageNo, levelQuizCnt, levelPassCnt, type){
	if(levelupChallengeFl == 'Y'){
		alert('처리되었습니다. 버튼은 한번만 눌러주세요.');
		return;
	}
	
	if(correct_quiz_cnt >= levelPassCnt){
		levelupChallengeFl = 'Y';
		//승급처리
		$.ajax({
			type : "POST",
		    url : "/grammar/"+eventSeq+"/updateEventElevate",
		    dataType : "json",		
		    data:"eventElvateSeq="+eventElevateSeq+"&answerCnt="+correct_quiz_cnt,
			success: function(data) {
				if(data.RESULT=="SUCCESS"){
					//데이터 다시 가져와서 수정
					getData();
					levelupChallengeFl = '';
					$('.elevateFl').val('');
					$('.info .test').attr('disabled', true);
					
					var eventUserInfo = data.eventUserInfo;
					
					if(eventUserInfo.nextStageNo >= 4){
						$('.info .test').html("미션완수");
						$('.info .test').addClass("completed");
					}
									
					var levelup_info = '';
					levelup_info += '<div class="text">';
					//alert(eventUserInfo.nextStageNo);
					if(type == 'certification'){
						levelup_info += '	<h4><b>위대한 마법사님</b> 환영합니다.<br> 이제 모험을 시작하세요.</h4>';
					}else{
						levelup_info += '	<h4>축하합니다.<br> <b>'+eventUserInfo.nextLevelNm+'</b>로 레벨업되었습니다.</h4>';
					}
					levelup_info += '	<h5>총 '+levelQuizCnt+'문제 중, '+correct_quiz_cnt+'문제 정답</h5>';
					levelup_info += '</div>';
					levelup_info += '<div class="character">';
					levelup_info += '	<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/character_level'+(eventUserInfo.nextStageNo+1)+'.png" />';
					levelup_info += '</div>';
					$('.levelup_info').html(levelup_info);
					
		         }else if(data.RESULT=="FAIL1"){	//완수조건에 걸린 경우
					getData();
					levelupChallengeFl = '';
					$('.elevateFl').val('');
					$('.info .test').attr('disabled', true);
		         	alert(data.MSG);
		         	
		         	$(this).closest('.qlayer').fadeOut( function() {
		        		$('body').removeClass('noscroll');
		        		$(this).closest('.qlayer').removeAttr('style');
		        	});
		        	$('.qlayer, .blue_bg').fadeOut();
		         }else{
					levelupChallengeFl = '';
		         	alert(data.MSG);
		         }
			},
	    	error:function(xhr, ajaxOpts, thrownErr){ 
				levelupChallengeFl = '';
				alert(xhr +'/'+ thrownErr ); 
			}			
		});
	}else{
		var levelup_info = '';
		levelup_info += '<div class="text">';
		if(type == 'certification'){
			levelup_info += '	<h4>아직 위대한 마법사가 아니시네요.<br> Episode1. 문법강의로 좀 더<br> 훈련하고 재도전해주세요.</h4>';
			levelup_info += '	<h5>총 '+levelQuizCnt+'문제 중, '+correct_quiz_cnt+'문제 정답<br>(통과 조건 : '+levelPassCnt+'문제 이상 정답)</h5>';
			levelup_info += '</div>';
			levelup_info += '<div class="character"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/character_level0.png" /></div>';
		}else{
			levelup_info += '	<h4>아쉽습니다.<br> 좀 더 모험한 후, 재도전 해주세요.</h4>';
			levelup_info += '	<h5>총 '+levelQuizCnt+'문제 중, '+correct_quiz_cnt+'문제 정답<br>(통과 조건 : '+levelPassCnt+'문제 이상 정답)</h5>';
			levelup_info += '</div>';
			levelup_info += '<div class="character"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/character_level'+(Number(stageNo)+1)+'.png" /></div>';
		}	
		
		$('.levelup_info').html(levelup_info);
	}

}

/* hide question layer : levelup test */
$(document).on('click','#levelupChallenge .confirm',function() {
	$(this).closest('.qlayer').fadeOut( function() {
		$('body').removeClass('noscroll');
		$(this).closest('.qlayer').removeAttr('style');
	});
	$('.qlayer, .blue_bg').fadeOut();
});


//동영상 팝업
var timerId = null;	
var player;
   
var done = false;	
var playerState;
function moviePop(eventMovieSeq, movieId){
	if('${eventInfo.eventState}' == '1' || '${isTest}' == 'Y'){
		if('${isCookies}' != '1') {
			alert("로그인 후 미션에 참여 해 주세요.\r\n\r\n문법 강의는 누구나 Play 할 수 있지만\r\n미션 참여는 CHESS,ACE 재원생만 가능합니다.");	
			redirectToGojls(1);
			return;
		}
		$("#play_mov").html('');
		var param = "eventMovieSeq="+eventMovieSeq;
		$("#play_mov").load("/grammar/${eventInfo.eventSeq}/movie", param, function(response, status, xhr) {
		    
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
							$("#afterQuestion").load("/grammar/${eventInfo.eventSeq}/afterQuestion/"+eventHistorySeq, param, function(response, status, xhr) {
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
		<c:choose>
		<c:when test="${isUserCheck == 0}">

			//정답여부
			var answerFl = 'N';
			if(answer == radioVal) answerFl = 'Y';
			if(answerFl == 'N'){	
				$('#afterQuestion .result').find('div').removeClass('correct');
				$('#afterQuestion .result').find('div').addClass('wrong');
				$("input[name='answer_num']:eq("+(answer-1)+")").addClass("correct");
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
			    url : "/grammar/"+eventSeq+"/updateEventHistory",
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
						
						//alert('수정되었습니다.');
						
						//동영상 횟수 추가
						var eventMovieSortSeq = eventMovieSeq - 15;
						$('.count').find('li').each(function(index, value){
							if(!$(this).hasClass('completed')){
								if(eventMovieSortSeq < 10) eventMovieSortSeq = '0'+eventMovieSortSeq;
								$(this).addClass('completed');
								if(index == 0){
									$(this).html('<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/wizard_item'+eventMovieSortSeq+'.png" />');
								}else{
									$(this).html('<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/wizard_feather_on.png" />');
								}
								return false;
							}
						})
						
						//정답여부
						var answerFl = 'N';
						if(answer == radioVal) answerFl = 'Y';
						if(answerFl == 'N'){	
							$('#afterQuestion .result').find('div').removeClass('correct');
							$('#afterQuestion .result').find('div').addClass('wrong');
							$("input[name='answer_num']:eq("+(answer-1)+")").addClass("correct");
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
		var movieSortSeq = cMovieSeq - 15;
		if(movieSortSeq < 10) movieSortSeq = '0'+movieSortSeq;
		$('#getItem .item').html('<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/wizard_item'+movieSortSeq+'.png" />');
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
	
	if(elevateFl == 'Y'){
		if(nextLevelSeq == 8){	//미션1
			//alert("축하합니다. "+nextLevelNm+'로 레벨업되었습니다.');
			var levelup_info = '';
			levelup_info += '<div class="text">';
			levelup_info += '	<h4>축하합니다.<br> <b>미션1</b>로 레벨업되었습니다.</h4>';
			levelup_info += '	<h5>(동영상 1회, 플레이 1회)</h5>';
			levelup_info += '</div>';
			levelup_info += '<div class="character"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/character_level2.png" /></div>';
			$('.levelup_info').html(levelup_info);
		
			$('body').addClass('noscroll');
			$('#levelupInfo, .blue_bg').fadeIn( function() {
				$('#levelupInfo').toppos();
			});
		}else{
			//alert("완수조건 달성"+nextLevelInfo.levelNm+'/'+nextLevelInfo.passCnt);
			$('#testChallenge h5').html('지금 도전하고<br> 다음 미션으로 레벨업하세요.');
			$('body').addClass('noscroll');
			$('#testChallenge, .blue_bg').fadeIn();
			$('#testChallenge').center();
		}
		$('#cNextLevelSeq').val('');
		$('#cNextLevelNm').val('');
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
	
	//승급 테스트 호출
	levelupChallenge();
});

$(document).on('click','button.challenge_later',function() {
	$(this).closest('.infolayer').fadeOut();
	$('.blue_bg').fadeOut();
});

function getData(){
	$.ajax({
		type : "POST",
	    url : "/grammar/${episodeSeq}",
	    dataType : "json",		
	    data:null,
		success: function(data) {
			if(data.RESULT=="SUCCESS"){
				var totalMovieCntInfo = data.totalMovieCntInfo;
				var eventUser = data.eventUser;
				var eventTopUserList = data.eventTopUserList;
				var eventMovieList = data.eventMovieList;
				var eventAttendanceList = data.eventAttendanceList;
				
				//상단 미션도전 시간
				$('.mins').html((totalMovieCntInfo.viewCnt*10).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'<span>분</span>');
				
				//사용자정보 변경
				var stageNo = eventUser.stageNo;
				var character_html = '<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/grammarwizard2_20200116/character_level'+(stageNo+1)+'.png" />';
				character_html += '<button type="button" class="cookie" onclick="show_cookie();" style="display:none;"><span>쿠키코믹스</span></button>';
				$('.character_info .character').html(character_html);

				var nickNm = eventUser.nickNm;
				var levelSeq = eventUser.eventLevelSeq;
				var levelNm = eventUser.levelNm;
				var nextLevelNm = eventUser.nextLevelNm;
				var movieCnt = eventUser.movieCnt;
				var levelMovieCnt = eventUser.levelMovieCnt;
				var viewCnt = eventUser.viewCnt;
				var levelViewCnt = eventUser.levelViewCnt;
				
				if(stageNo == -1){
					$('.character_info').find('h4').find('span').html('<b class="red">위대한 마법사</b> 인증이 필요합니다. <button type="button" class="xsmall red" onclick="certification()"><span>자격증명하기</span></button>');
				}else if(nickNm == ''){
					$('.character_info').find('h4').find('span').html('마법사 이름을 설정하세요. <button type="button" class="xsmall red" onclick="set_name()"><span>설정</span></button>');
				}else{
					$('.character_info').find('h4').find('span').html(nickNm);
				}
				
				if(stageNo >= 4){//레벨4
					$('.info .grammar').html('<b>'+movieCnt+'</b>');
					$('.info .movie').html('<b>'+viewCnt+'</b>');
					$('.info label').html('');
					$('.cookie').show();	//쿠키영상볼 수 있음.
					$('.info .test').attr('disabled', true);
					$('.info .test').html("미션완수");
					$('.info .test').addClass("completed");
				}else{
					$('.info .detail h5 span').html(nextLevelNm);
					$('.info .grammar').html('<b>'+movieCnt+'</b>/'+levelMovieCnt);
					$('.info .movie').html('<b>'+viewCnt+'</b>/'+levelViewCnt);
					if(stageNo > 0 && movieCnt >= levelMovieCnt && viewCnt >= levelViewCnt){
						$('.info .test').removeAttr('disabled');
					}else{
						$('.info .test').attr('disabled', true);
					}
				}
				
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
				
				//top 리스트
				var topUserHtml = '';
				var eventTopUserList = data.eventTopUserList;
				for(var i=0; i< eventTopUserList.length; i++){
					var isMe = "";
					if(eventTopUserList[i].eventUserSeq == '${eventUser.eventUserSeq}') isMe = "me";
					topUserHtml += '<li class="swiper-slide '+isMe+'">';
					topUserHtml += '	<h4>'+eventTopUserList[i].nickNm+'</h4>';
					topUserHtml += '	<ol>';
					topUserHtml += '		<li>아이템수집 : <b>'+eventTopUserList[i].movieCnt+'개</b></li>';
					topUserHtml += '		<li>영상재생 : <b>'+eventTopUserList[i].viewCnt+'회</b></li>';
					topUserHtml += '	</ol>';
					topUserHtml += '	<p>도전 : <b>'+eventTopUserList[i].levelNm+'</b></p>';
					topUserHtml += '</li>';
				}
				$('.swiper-wrapper').html(topUserHtml);
				
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
				
				//문법 리스트
				var movieListHtml = '';
				var eventMovieList = data.eventMovieList;
				var group_tmp = '';
				for(var i=0; i< eventMovieList.length; i++){
					if(grou_tmp = '' || eventMovieList[i].groupSeq != group_tmp){
						if(i > 0) movieListHtml += '</ul>';
						movieListHtml += '<ul class="card'+eventMovieList[i].groupSeq;
						if(stageNo > -1 && (eventMovieList[i].groupSeq == 1 || eventMovieList[i].isOpen == 1)) movieListHtml += ' active';
						movieListHtml += '">';
					}
					movieListHtml += '<li ';
					if(stageNo > -1 && (eventMovieList[i].groupSeq == 1 || eventMovieList[i].isOpen == 1)) movieListHtml += 'onClick="moviePop('+eventMovieList[i].eventMovieSeq+', \''+eventMovieList[i].movieUrl+'\')"';
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
					if(eventMovieList[i].viewCnt > 0){
						movieListHtml += '	<div class="name_tag"><span>'+eventMovieList[i].movieNm+'</span></div>';
					}
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