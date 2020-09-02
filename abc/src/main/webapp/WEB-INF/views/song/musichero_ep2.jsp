﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="Ko">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=1024">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="theme-color" content="#1278bc">
<meta property="og:image" content="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/musichero2_20191218/heroimg_bg.jpg" />
<meta property="og:title" content="Music Hero Episode2. 얼음행성의 습격">
<meta property="og:description" content="불꽃을 모아 얼어붙은 뮤직히어로를 구하라!">
<title>Music Hero Episode2.</title>

<link rel="shortcut icon" type="image/x-icon" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/favicon_jls.ico?27814882" />
<link rel="apple-touch-icon" sizes="120x120" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_120.png?27814882" />
<link rel="apple-touch-icon" sizes="152x152" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_152.png?27814882" />
<link rel="apple-touch-icon" sizes="167x167" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_167.png?27814882" />
<link rel="apple-touch-icon" sizes="180x180" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_180.png?27814882" />
<link rel="icon" sizes="192x192" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_192.png?27814882" />
<link rel="icon" sizes="512x512" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_512.png?27814882" />
<link rel="stylesheet" type="text/css" href="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/swiper-4.5.0/css/swiper.min.css" />
<link type="text/css" rel="stylesheet" media="all" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/css/learningkids/musichero2_20191218.css?27814882" />
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/js/device.js"></script><!-- for mobile -->
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/js/jquery-ui-1.12.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/swiper-4.5.0/js/swiper.min.js"></script>
<script type='text/javascript' src="https://www.youtube.com/iframe_api"></script>
  
<script type="text/javascript" src="http://image.gojls.com/common/mediaElementJs/OSinfo.js"></script>
<script type="text/javascript" src="http://image.gojls.com/common/mediaElementJs/mediaelement_play.js"></script>
<script type="text/javascript" src="http://image.gojls.com/common/mediaElementJs/mediaelement-and-player.js"></script>
<script src="/resources/js/player_api.js"></script>
<link rel="stylesheet" type="text/css" href="http://image.gojls.com/common/mediaElementJs/mediaelementplayer.css" />

</head>

<jsp:include page="../common/statistics.jsp"/>
<body>

<div id="wrap">
	<div id="header">
		<div class="gnb">
			<h2>오늘도 CHESS친구들이 Music Hero를 구출하고 있습니다.</h2>
			<div class="status">
				<div class="tit">전체 Song & Chant Play 수</div>
				<div class="qty">${totCnt}<span>회</span></div>
			</div>
		</div>
	</div>
	<div id="container">
		<div class="heroimg">
			<div class="logo"></div>
			<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/musichero2_20191218/heroimg_bg.jpg" />
		</div>
		<div class="event_info">
			<div class="section">
				<h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/musichero2_20191218/event_info_title.png" /></h3>
				<div class="summary">
					<dl>
						<dt>미션 기간</dt>
						<dd>2019년 12월 18일(수) ~ 2020년 1월 7일(화) 3주간</dd>
					</dl>
					<dl>
						<dt>참여 대상</dt>
						<dd>CHESS 전체 재원생 (IS레벨 ~ MS레벨)</dd>
					</dl>
					<dl>
						<dt>결과 발표</dt>
						<dd>2020년 1월 13일(월)</dd>
					</dl>
				</div>
				<ul class="step">
					<li><p><b>Song & Chant</b>를<br>듣고 불꽃을 수집한다.</p></li>
					<li><p><b>50</b>곡+<b>150</b>회 이상<br> <b>Song & Chant</b>를<br> 듣고 <b>Music Hero</b>를<br> 모두 구출한다.</p></li>
					<li><p>히든 뮤직 비디오<br>3곡을 즐긴다.</p></li>
					<li><p>결과를 확인하고<br> 선물을 받는다.</p></li>
				</ul>
			</div>
			<div class="section">
				<h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/musichero2_20191218/gift_info_title.png" /></h3>
				<div class="gift_info">
					<div><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/musichero2_20191218/event_gift01.png" /></div>
					<div><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/musichero2_20191218/event_gift02.png" /></div>
					<div><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/musichero2_20191218/event_gift03.png" /></div>
					<div><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/musichero2_20191218/event_gift04.png" /></div>
					<div><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/musichero2_20191218/event_gift05.png" /></div>
					<ol>
						<li>Song은 누구나 Play 할 수 있지만, 미션참여는 CHESS 재원생만 가능합니다.</li>
						<li>대상 학생은 중복으로 응모되며, 선물은 추첨을 통해 1개 수령합니다.</li>
					</ol>
				</div>
			</div>
		</div>
		<div class="mission">
			<div class="section">
			
			 
				        <h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/musichero2_20191218/mission_title.png" /></h3>
	        			<c:if test="${isChess == 1}">
	        				<h2>나의 Play 곡수 <b id="myCardCnt"></b> / 나의 Play 횟수 <b id="myPlayCnt"></b></h2>
	        				<h2>나의 Play 영어노출시간 <b id="myStudyTime"></b><span>/3000분</span></h2>
	        				<h4>영어노출시간은 미션 종료 후, 일괄 적립됩니다.(최대 50시간 적립)</h4>
	        			</c:if>
	        			<c:if test="${isChess != 1}">
	        				<c:if test="${isCookies==1}"><h4>미션참여 대상이 아닙니다. <br>CHESS Song을 즐겨주세요.<br></h4></c:if>
	        				<c:if test="${isCookies!=1}"><h4>미션참여 대상이 아닙니다. <br>CHESS Song을 즐겨주세요. CHESS 학생이라면<br> <button type="button" class="red" onclick="javascript:redirectToGojls(1)"><span>로그인하러가기 ＞</span></button></h4></c:if>
	        			</c:if>	 
	        		  
				<div class="mission_board">
					<div id="badge1"></div>
					<div id="badge2"></div>
					<div id="badge3"></div>
					<div id="badge4"></div>
				</div>
				<div class="mission_map" id="musicCards">
				</div>
			</div>
		</div>
		<div class="music_video">
			<div class="section">
				<h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/musichero2_20191218/music_video_title.png" /></h3>
				<ul>
					<li id="hidden_1">
						<h4>오픈조건 : <b>미션2 달성</b></h4>
						<div class="thumb"></div>
					</li>
					<li id="hidden_2">
						<h4>오픈조건 : <b>미션3 달성</b></h4>
						<div class="thumb"></div>
					</li>
					<li id="hidden_3">
						<h4>오픈조건 : <b>미션4 달성</b></h4>
						<div class="thumb"></div>
					</li>
				</ul>
				<div class="copyright"><span>제작사 ㈜정상제이엘에스</span> <span>/ PD 이윤정, 정지영</span> <span>/ Music Educator 허정원</span> <span>/ Education Marketing 정영선</span> <span>/ Design 임영미, 심현식</span> <span>/ Illustrator 정민수</span><br> <span>/ Programming 장혜윤</span> <span>/ Assistants 김승균</span> <span>/ VFX 최문기, 윤수영, 이누리</span></div>
			</div>
		</div>
	</div>
</div> 

<div class="black_bg">

<script type="text/javascript">
/* close popup layer */
$(document).on('click','.close',function() {
	
    if (oAudio.src !='' && !oAudio.paused) {    	
        oAudio.pause();
    }    
    
    oAudio.src = '';
    playbar.style.width = 0;
    reload_SongData();
    
	$('body').removeAttr('style');
	$('.black_bg, .music_song, #play_mov').fadeOut();
	$('.guide').addClass('hide').removeAttr('style');
	
	//var vid = document.getElementById("myaudio");
	//vid.pause(); 
	//$('#myaudio source').attr('src', '');
	//$('.music_song h5>img').attr('src', '');
});
/* close card layer */
$(document).on('click','.hero_card',function() {
	$(this).closest('.find_card').fadeOut();
	$('.blue_bg').fadeOut();
});

/* close video layer */
$(document).on('click','#play_mov .close',function() {

	$('body').removeClass('noscroll');
	clearInterval(timerId);
	timerId == null;
	player.destroy();
	$(this).closest('.paper').find('.guide').addClass('hide');
});

function show_mov() {
	$('body').css('overflow','hidden');
	$('#play_mov, .black_bg').fadeIn();
	studyVideo.play();
}
</script>

	<div class="music_song">
		<div class="close">close</div>
		<div class="player">
			<audio id="myaudio"></audio>

			<ul id="controls">
			    <li class="control_item" style="width:auto;"><div id="play"><img src="" /></div></li>
			    <li class="control_item" style="width:60%;">
			    	<div class="progresscontainer" id="progressback" >
			    		<div class="bar" id="playbar"></div>
			    	</div>
			    </li>			    
			    <li class="control_item" style="width:auto;"><div id="mute"><img src="" /></div></li>
			    <li class="control_item" style="width:10%;">
			    	<div id="volume">
			     		<input id="volumethumb" type="range" min="0" max="100" value="50"/>
			    	</div>
			    </li>
			</ul>
		</div>
		<div class="score">
			<div class="end_info">
				<h5 id="liric_info"></h5>
			</div>
			<div class="guide hide">
				<div class="action">
					<div class="count"></div>
					<div class="replay"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/musichero2_20191218/btn_replay.png" /></div>
				</div>
			</div>
		</div>
	</div>


	<div id="play_mov" class="pop">	</div>
</div>

<div class="blue_bg">
	<div class="find_card">
		<div class="hero_card">
		</div>
	</div>
</div>
	
<form name="eventForm" id="eventForm">
<input type="hidden" name="isCookies" value="${isCookies}" />
<input type="hidden" name="isChess" value="${isChess}" />
<input type="hidden" name="userSeq" value="${userSeq}" />
<input type="hidden" name="emsEventSeq" value="${eventInfo.emsEventSeq}" />
<input type="hidden" name="title" value="${eventInfo.title}" />	
<input type="hidden" name="eventState" value="${eventInfo.eventState}" />
<input type="hidden" name="openState" value="${eventInfo.openState}" />
<input type="hidden" name="activityCnt" value="${eventInfo.activityCnt}" />
<input type="hidden" name="eventOpenDt" value="${eventInfo.eventOpenDt}" />
<input type="hidden" name="eventCloseDt" value="${eventInfo.eventCloseDt}" />
<input type="hidden" name="activityStartDt" value="${eventInfo.activityStartDt}" />
<input type="hidden" name="activityEndDt" value="${eventInfo.activityEndDt}" />
<input type="hidden" name="winnerAnnounceDt" value="${eventInfo.winnerAnnounceDt}" />
<input type="hidden" name="winnerAnnounceUrl" value="${eventInfo.winnerAnnounceUrl}" />
<input type="hidden" name="eventSongSeq" value="" />
<input type="hidden" name="orderNum" value="" />
<input type="hidden" name="myLevel"  value="" />
</form>

</body>
</html>



<script type="text/javascript">

var param_hmsroot = "<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />" ;
var param_imgroot = "<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/musichero2_20191218/";
var param_songroot = "<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/CONTENTS/event/TMP001/";
var URL_TO_GOJLS_HOME = "<spring:eval expression="@globalContext['GOJLS_URL']" />";
var URL_TO_GOJLS_SIGN_IN = URL_TO_GOJLS_HOME.replace('http://','https://')+"/login?preURL=<spring:eval expression="@globalContext['SITE_URL']" />/musichero/ep2";

$(document).ready(function(){

	// F12 버튼 방지	
	$(document).bind('keydown',function(e){
		if ( e.keyCode == 123) {
			e.preventDefault();
			e.returnValue = false;
		}
	});
	
	reload_SongData();
});


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


// 곡 정보 & 플레이 정보 얻기 
function reload_SongData()
{	
	var isCookies = $("#eventForm input[name='isCookies']").val();
	var isChess = $("#eventForm input[name='isChess']").val();
	var emsEventSeq = $("#eventForm input[name='emsEventSeq']").val();
	
	if(emsEventSeq != "" && emsEventSeq.length > 0){
		$.ajax({
			type : "POST",
		    url : "/song/loadSongList/" + emsEventSeq,
		    dataType : "json",		
		    data:null,
			success: function(data) {
				if(data.result=="SUCCESS"){
					
					if(isCookies == 1 && isChess ==1){
						$('#myCardCnt').html(data.songData.cardCnt + "곡");
						$('#myPlayCnt').html(data.songData.playCntAll + "회");
						$('#myStudyTime').html(data.songData.playCntAll *10 + "분");
					}	
					//$('.qty').html(data.songData.totCnt + "<span>회</span>");
					
					display_myBedge(data.myLevel, data.hiddenList);
					display_musicCard(data.songList);
					
		         }else{
		         	alert(data.msg);
		         }
			},
	    error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }			
		});
	}	
}


// 배지 디스플레이
function display_myBedge(myLevel, hiddenList){
		
	var openState = $("#eventForm input[name='openState']").val();
	var isCookies = $("#eventForm input[name='isCookies']").val();
	var emsEventSeq = $("#eventForm input[name='emsEventSeq']").val();
	$("#eventForm input[name='myLevel']").val(myLevel);

	// 매니아 카드
	for(var i = 1 ; i < 5 ; i++)
	{
		var badgeStr;
		badgeStr = '<img src="' + param_imgroot + 'mission_step' + i;
		badgeStr += (myLevel < i)?'':'_completed';
		badgeStr += '.png">';
		$('#badge' + i).html(badgeStr);
	}
	var hidden1 = "";
	var hidden2 = "";
	var hidden3 = "";
	// 히든 카드
	for(var i = 0 ; i < hiddenList.length ; i++)
	{
		var j = i+1;
		//if(myLevel > j){
			$('#hidden_' + j).addClass('active');
			$('#hidden_' + j + ' .thumb').html("<img src=\""+  param_imgroot + "music_video"+j+".jpg\"/>");
			
			if(i == 0){
				var hiddenValue0 = hiddenList[0];
				$('#hidden_' + j).click(function(){
					songPopup(hiddenValue0.orderNum, hiddenValue0.eventSongSeq, hiddenValue0.fileName, 1, hiddenValue0.title);
				})
			}else if(i == 1){
				var hiddenValue1 = hiddenList[1];
				$('#hidden_' + j).click(function(){
					songPopup(hiddenValue1.orderNum, hiddenValue1.eventSongSeq, hiddenValue1.fileName, 1, hiddenValue1.title);
				})
			}else if(i == 2){
				var hiddenValue2 = hiddenList[2];
				$('#hidden_' + j).click(function(){
					songPopup(hiddenValue2.orderNum, hiddenValue2.eventSongSeq, hiddenValue2.fileName, 1, hiddenValue2.title);
				})
			}
		//}		
	}
}

// 뮤직 카드 디스플레이
function display_musicCard(songList){
	
	var liStr = "";
	for(var i=0; i< songList.length; i++){
	
	    if(songList[i].firstFg == '1'){
	    	liStr += "<ul class='"+songList[i].groupFg+"'>";
	    }
	
	    var activeClassSong = "";
	    var activeClassFire1 = "";
	    var activeClassFire2 = "";
	    var activeClassFire3 = "";
	    var clickEvent = " onclick=\"javascript:songPopup("+ songList[i].orderNum + ", " + songList[i].eventSongSeq + ", '" + songList[i].fileName +"' );\"";
	    var imageFile = "";
	    
	    if(songList[i].playCnt > 0){
	    	activeClassSong = "class=\"active\""; 
	    	activeClassFire1 = "class=\"active\""; 
	    	imageFile = "<img src='"+param_imgroot+"song/"+songList[i].fileName+"_songbook.jpg' /></div>";
	    }
	    if(songList[i].playCnt > 1) activeClassFire2 = "class=\"active\"";
	    if(songList[i].playCnt > 2) activeClassFire3 = "class=\"active\"";

	    liStr += "<li "+activeClassSong+ clickEvent + ">";
	    liStr += "	<div class='play'>"+imageFile;
        liStr += "	<ol>";
	    liStr += "		<li "+activeClassFire1+"'></li>";
	    liStr += "		<li "+activeClassFire2+"'></li>";
	    liStr += "		<li "+activeClassFire3+"'></li>";
	    liStr += "	</ol>";
	    liStr += "</li>";	

	    if(songList[i].lastFg == '1'){
	    	liStr += "</ul>";
	    }
	}
	
	$('#musicCards').html(liStr);
	
}


// 곡 선택 시 가사 창 팝업
function songPopup(orderNum, eventSongSeq, fileName, movieFg, title){
	
	var emsEventSeq = $("#eventForm input[name='emsEventSeq']").val();  // 이벤트 차수
	var eventState = $("#eventForm input[name='eventState']").val();  ///이벤트 상태
	var isCookies = $("#eventForm input[name='isCookies']").val();
	var isChess = $("#eventForm input[name='isChess']").val();
	$("#eventForm input[name='eventSongSeq']").val(eventSongSeq);
	$("#eventForm input[name='orderNum']").val(orderNum);
	
	
	//if(eventState == 1)
	//{
		if(isCookies != 1) {
			alert("로그인 후 미션에 참여 해 주세요.\r\n\r\n Song은 누구나 Play 할 수 있지만\r\n미션 참여는 CHESS 재원생만 가능합니다.");	
			redirectToGojls(1);
			return;
		}
				
		if(movieFg == 1){
			moviePop(eventSongSeq, title, fileName);
		}else{
			// 현재 음원 재생 중이라면 플레이 안되도록 막는다.
		    if (!oAudio.paused) {
		        return;
		    }	    
		    
			$("#liric_info").html('<img src="' + param_imgroot + 'song/' + fileName + '_song.jpg" />');
			$('body').css('overflow','hidden');
			$('.music_song, .black_bg').fadeIn();
			
			mappingSong(eventSongSeq, fileName);
			playSong();			
		}		
	//}
	//else
	//{
	//	alert("이벤트 참여 기간이 아닙니다.");
	//}
}

// 오디오 플레이어에 곡 정보 입력
function mappingSong(eventSongSeq, fileName)
{
	var emsEventSeq = $("#eventForm input[name='emsEventSeq']").val();  // 이벤트 차수
	var eventState = $("#eventForm input[name='eventState']").val();  ///이벤트 상태
	oAudio.src = param_imgroot + 'song_mp3/' + fileName + '.mp3'; 
}

// 곡 재생 : 가사 창 팝업 후, replay 버튼 클릭 후 
function playSong() 
{	
	if (oAudio.paused) {
        oAudio.play();
    }
}

// 곡 재생 후 DB 플레이정보 업데이트
function addPlayCount()
{	
	var isCookies = $("#eventForm input[name='addPlayCount']").val();
	var isChess = $("#eventForm input[name='isChess']").val();
	var eventSongSeq = $("#eventForm input[name='eventSongSeq']").val();
	var emsEventSeq = $("#eventForm input[name='emsEventSeq']").val();
	
	if(eventSongSeq != "" && eventSongSeq.length > 0 && isChess == 1){
		
		$.ajax({
			type : "POST",
		    url : "/song/addPlayCount/" + emsEventSeq + "/" +eventSongSeq,
		    dataType : "json",		
		    data: null,
			success: function(data) {
				if(data.result=="SUCCESS"){
					
					var myLevel = $("#eventForm input[name='myLevel']").val();
					var songPlayCnt = data.songPlayCnt;
					var starHtml = '';					
					var orderNum = $("#eventForm input[name='orderNum']").val();
					
					// 케이스별 보석 이미지 & 문구 
					if(orderNum < 151)
					{
				   		var classFire1 = "";
				   		var classFire2 = "";
				   		var classFire3 = "";
				   		if(songPlayCnt > 0) classFire1 = " class='active'";
				   		if(songPlayCnt > 1) classFire2 = " class='active'";
				   		if(songPlayCnt > 2) classFire3 = " class='active'";
				   		
				   		starHtml = "<span"+ classFire1 + "></span>";
				   		starHtml += "<span"+ classFire2 + "></span>";
				   		starHtml += "<span"+ classFire3 + "></span>";

				   		if(songPlayCnt < 3){ starHtml += "<p>'다시듣기'하고 에너지 불꽃을 더 모아보세요!</p>";}				   		
				   		else if(songPlayCnt > 2 && data.myLevel < 4){starHtml += "<p>불꽃을 모아 뮤직히어로들을 구하는 그날까지 도전!</p>";}
				   		else if(data.myLevel == 4){starHtml += "<p>Good Job 내가 바로 뮤직히어로</p>";}
				   		
				   		$('.guide .action .count').html(starHtml);
				   		$('.guide .action .count').show();
					}
					else
					{
						if(songPlayCnt == 1){							
							starHtml = "<p>히든 카드 한개를 획득하셨습니다.</p>";
						}
						else{
							
						}						
					}		   		
			   		
			   		// 레벨 업 시 얻은 뮤직 카드 보여 주기
					if(data.myLevel > myLevel)
					{	
						 $("#eventForm input[name='myLevel']").val(data.myLevel);
						 
						var findCardHtml;
				   		findCardHtml = '<img id="find_card" src="' + param_imgroot + 'pop_'+ data.myLevel +'.png">';
				   		$('.blue_bg .find_card .hero_card').html(findCardHtml);
				   		$('.blue_bg').fadeIn();
						$('.find_card').fadeIn();
				   		
				   		$(document).on('click','.hero_card',function() {
				   			$(this).closest('.find_card').fadeOut();
				   			$('.blue_bg').fadeOut();
				   		});
				   		
					}
			   		
		         }else{
					$('.guide .action .count').html("");
					$('.guide .action .count').hide();
		         	alert(data.message);
		         }
			},
	    error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
		});
	}
	else{
		var strHtml = '<p>CHESS 학생으로 로그인 시 미션 참여가 가능합니다.</p>';
		$('.guide .action .count').html(strHtml);
	}
}


//오디오 플레이어 
function initAudioEvents() {
	
	var emsEventSeq = $("#eventForm input[name='emsEventSeq']").val();	
	
	var play = document.getElementById('play');	
	var mute = document.getElementById('mute');
	var playbar = document.getElementById('playbar');
	var playprogress = document.getElementById('progressback');
	var volumethumb = document.getElementById('volumethumb');
	
	// mute 표시
	function checkMute(){
		if(oAudio.muted){$('#controls>li #mute').html('<img src="' + param_imgroot + 'icons8-no-audio-26.png" >');}
		else{$('#controls>li #mute').html('<img src="' + param_imgroot + 'icons8-speaker-26.png" >');}
		
		oAudio.volume = 0.5;
	}
	// mute 버튼 클릭
	mute.addEventListener('click', function() {
		oAudio.muted = !oAudio.muted;
		checkMute();
	});
	checkMute();
	
	// range 컨트롤 이벤트 받아 볼륨에 적용
	volumethumb.addEventListener('change', function() {
		  oAudio.volume = (volumethumb.value/100);		  
		  if(oAudio.volume == 0.0) {
			  $('#controls>li #mute').html('<img src="' + param_imgroot + 'icons8-no-audio-26.png" >');
			  oAudio.muted = true;
		  }
		  else{
			  $('#controls>li #mute').html('<img src="' + param_imgroot + 'icons8-speaker-26.png" >');
			  oAudio.muted = false;
		  }
	});
	
		
	// 재생 중 이벤트	
	oAudio.addEventListener("playing", function() {
		$('.guide').addClass('hide').removeAttr('style');
		$('#controls>li #play').html('<img src="' + param_imgroot + 'icons8-pause-26.png" >');
	});
	// 일시 중지 이벤트
	oAudio.addEventListener("pause", function() {
		$('#controls>li #play').html('<img src="' + param_imgroot + 'icons8-play-26.png" >');
	});
	// 재성 버튼 클릭
	play.addEventListener('click', function() {
	 	if(oAudio.paused){oAudio.play();}
	 	else{oAudio.pause();}
	});
	
	// 사운드 진행바
	oAudio.addEventListener("timeupdate", function() {
			
		var curPos = parseInt(((oAudio.currentTime / oAudio.duration) * 100), 10);
		if(curPos > 100){ curPos = 100;}
		playbar.style.width = curPos + "%";
		
		// 사운드 슿라이드 조작 가능
		$(document).on('click', '#controls>li #progressback',function(e) {
			 if (!e) {
                 e = window.event;
             } 
             try {
            	 oAudio.currentTime = oAudio.duration * (e.offsetX / playprogress.clientWidth);
             }
             catch (err) {
                 if (window.console && console.error("Error:" + err));
             }
 		});
	});
	
	// 오디오 재생이 끝났을 때 이벤트
	oAudio.addEventListener("ended", function() {
	
		$('.guide').fadeIn();
		var eventState = $("#eventForm input[name='eventState']").val();  ///이벤트 상태
		
		if(eventState  == 1)
		{
			addPlayCount();  
		}
		else if(eventState  > 1)
		{
			var starHtml = "<p>미션기간이 종료 되었습니다. </p><p>다함께 Song & Chant를 즐겨보아요.</p>";
			$('.guide .action .count').html(starHtml);
			$('.guide .action .count').show();
		}
		
		$(document).on('click','.replay',function() {
 			
			$('.guide').addClass('hide').removeAttr('style');
			oAudio.currentTime = 0;
			playbar.style.width = 0;
			if (oAudio.paused) {
		        oAudio.play();
		    }
			
 		});
	});
}

var oAudio = document.getElementById('myaudio');
window.addEventListener("DOMContentLoaded", initAudioEvents, false);

//동영상 팝업
var timerId = null;	
var player;
   
var done = false;	
var playerState;
function moviePop(eventSongSeq, title, fileName){
 
		$("#play_mov").html('');
		var param = "eventSongSeq="+eventSongSeq+"&title="+title;
		$("#play_mov").load("/song/movie", param, function(response, status, xhr) {
			var movieId = fileName;
		    player = new YT.Player('studyVideo', {
				videoId: movieId, 
				host: 'https://www.youtube.com',
				playerVars: {   
					'autoplay': 0, //자동재생 X
					'controls': 0, 		// 컨트롤바 안보임 - 대신 아래 타이머 이용 프로그래스바 만듬 안되면 시간이라도 노출
					'rel':'0', 			// 종료 시 다른 동영상 정보 안 보임
					'disablekb':1, 		// 플레이어 컨트롤 사용 중지 - 좌우 화살표 방향키(몇초 앞 뒤 이동) 
					'showinfo':0,    	// 동영상 재생 시 아래 다른 곡 정보 안 보임
					'modestbranding':1,
					'fs':1			// 전체 화면 설정 버튼
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
					//console.log('#### event.data :: ' + event.data);
					if (event.data == YT.PlayerState.ENDED || event.data == YT.PlayerState.PAUSED) {
						endTimer();
						$("#playBtn").show();
						$("#pauseBtn").hide();
						if (event.data == YT.PlayerState.ENDED){

							$('.guide').fadeIn();
							var eventState = $("#eventForm input[name='eventState']").val();  ///이벤트 상태
							
							if(eventState  == 1)
							{
								addPlayCount();  
							}
							else if(eventState  > 1)
							{
								var starHtml = "<p>미션기간이 종료 되었습니다. </p><p>다함께 Song & Chant를 즐겨보아요.</p>";
								$('.guide .action .count').html(starHtml);
								$('.guide .action .count').show();
							}
							
							$(document).on('click','.replay',function() {
					 			
								$('.guide').addClass('hide').removeAttr('style');

								playYoutube();
								
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
	return this;
}

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


