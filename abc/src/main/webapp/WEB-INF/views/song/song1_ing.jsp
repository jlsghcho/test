﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="Ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1209, user-scalable=yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="theme-color" content="#1278bc">
<title> 정상어학원 : MUSIC HERO EVEVT </title>
<link rel="shortcut icon" type="image/x-icon" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/favicon_jls.ico?68061465" />
<link rel="apple-touch-icon" sizes="120x120" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_120.png?68061465" />
<link rel="apple-touch-icon" sizes="152x152" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_152.png?68061465" />
<link rel="apple-touch-icon" sizes="167x167" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_167.png?68061465" />
<link rel="apple-touch-icon" sizes="180x180" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_180.png?68061465" />
<link rel="icon" sizes="192x192" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_192.png?68061465" />
<link rel="icon" sizes="512x512" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/touchicon_jls_512.png?68061465" />
<link type="text/css" rel="stylesheet" media="all" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/css/event/20190326_main.css?68061465" />
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/js/device_event.js"></script><!-- for mobile -->
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/js/jquery-ui-1.12.1.min.js"></script>

<style>
#controls{width:100%;border-radius:2em;top:10px;margin-bottom:10px;}
</style>

</head>
<%-- Hannibal: 추적코드 적용 (2018.05.10) --%>
<jsp:include page="../common/statistics.jsp"/>

<body class="event">
<div id="content">
	<div id="head_gnb">
            <ul class="remote">
               	<li>
					<h3>오늘도 CHESS 친구들이 Music Hero에 도전하고 있습니다. <b> 전체 Song & Chant Play 수</b> <b class="number">${totCnt}회</b></h3>
				</li>
			</ul>
	</div>
	<div id="s1"></div>
	<a href="http://www.gojls.com/academy/" target="_blank"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/TMP001/${eventInfo.emsEventSeq}/logo.png" class="logo" /></a>
    
	<div id="sr_wrap">
  			<!--섹션2-->    
			<div id="s2" class="section">			
			<div class="content">
              	<img src ='<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/TMP001/${eventInfo.emsEventSeq}/board_top.jpg' />
		   		<img src ='<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/TMP001/${eventInfo.emsEventSeq}/board_top_2.jpg' />
            </div>
            </div>
         	
         	 
			<!--섹션3-->             
        	<div id="s3" class="section">
        	
          		<div class="content">
		    		<div class="copy">
	               			<h1>CHESS Song을 들으면서 따라 불러보자.<br><b>1번 플레이할 때마다 영어노출시간 10분이 부여된다는 사실!</b></h1>
					</div> 
	        		<div class="me">
	        			<c:if test="${isChess == 1}">
	        				<h2>나의 Play 곡수 <b id="myCardCnt"></b> / 나의 Play 횟수 <b id="myPlayCnt"></b></h2>
	        				<h2>나의 Play 영어노출시간 <b id="myStudyTime"></b><span>/1800분</span></h2>
	        				<h4>영어노출시간은 미션 종료 후, 일괄 적립됩니다.(최대 30시간 적립)</h4>
	        			</c:if>
	        			<c:if test="${isChess != 1}">
	        				<c:if test="${isCookies==1}"><h4>미션참여 대상이 아닙니다. CHESS Song을 즐겨주세요. <a href="javascript:redirectToGojls(2)">CHESS 학생이라면 로그인하러가기</a></h4></c:if>
	        				<c:if test="${isCookies!=1}"><h4>미션참여 대상이 아닙니다. CHESS Song을 즐겨주세요. <a href="javascript:redirectToGojls(1)">CHESS 학생이라면 로그인하러가기</a></h4></c:if>
	        			</c:if>	
	        		</div>
					<div class="badge">
					 	<ul>
							<li id="badge1"></li>
						   	<li><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/TMP001/${eventInfo.emsEventSeq}/arrow.png"></li>
					       	<li id="badge2"></li>
						   	<li><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/TMP001/${eventInfo.emsEventSeq}/arrow.png"></li>
						   	<li id="badge3"></li>
						   	<li><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/TMP001/${eventInfo.emsEventSeq}/arrow.png"></li>
						   	<li id="badge4"></li>
		     			</ul>
					</div>
					<div class="ranking"></div>	
					<div id="nav" >						
						<div class="sub" id="musicCards"></div>
					</div>
					<div class="info"></div>

					<!-- Hidden Song -->    
	 			 	<div class="con">
						<div class="copy">
			                <h1>Hidden Song</h1>
							<h2>주차별 숨겨진 카드가 공개됩니다.</h2>
						</div> 
				       	<div class="bottomboard">				       		
							<div class="area">
								<p class="date_month"><b>1주차 (오픈일:${eventInfo.openDt1})</b></p>
				            	<p class="mania">오픈조건 : Mania 이상</p>
			            		<dl><dd><div id="hidden_1"></div></dd></dl>
			            	</div>	
			            </div>	
			            <div class="bottomboard">
			            	<div class="area">
			            		<p class="date_month"><b>2주차 (오픈일:${eventInfo.openDt2})</b></p>
				            	<p class="master">오픈조건 : Master 이상</p>
			            		<dl><dd><div id="hidden_2"></div></dd></dl>
			            	</div>	
			            </div>	
			            <div class="bottomboard">	
			            	<div class="area">
			            		<p class="date_month"><b>3주차 (오픈일:${eventInfo.openDt3})</b></p>
				            	<p class="hero">오픈조건 : Music Hero</p>
			            		<dl><dd><div id="hidden_3"></div></dd></dl>
			            	</div>    
				  		</div>
	     			</div>
	     			<div class="footer">
					<h4>제작사 ㈜정상제이엘에스 / Education Marketer 정영선 / Music Educator 허정원 / Planners 정지영,이윤정 / Programmer 김유아 / Designers 임영미,심현식 / Illustrator 정민수 / Assistants 김승균,허원준</h4>
					</div>		
				</div> <!--content-->
			</div> <!--section-->
	</div> <!--wrap-->
</div>


<div class="black_bg">
	<div class="music_song">
		<div class="close" onclick="javascript:closeSongPopup();">close</div>
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
					<div class="replay"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/TMP001/${eventInfo.emsEventSeq}/btn_replay.png" /></div>
				</div>
			</div>
		</div>
	</div>
	
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
var param_imgroot = "<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/TMP001/";
var param_songroot = "<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/CONTENTS/event/TMP001/";
var URL_TO_GOJLS_SIGN_IN = "https://www.gojls.com/login?preURL=http://event.gojls.com/song/1";
var URL_TO_GOJLS_HOME = "https://www.gojls.com";


$(document).ready(function(){
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
						$('#myPlayCnt').html(data.songData.playCnt + "회");
						$('#myStudyTime').html(data.songData.playCnt *10 + "분");
					}	
					
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
		badgeStr = '<img src="' + param_imgroot + emsEventSeq +'/card/level_' + i +'_';
		badgeStr += (myLevel < i)?'off':'on';
		badgeStr += '.png">';
		
		$('#badge' + i).html(badgeStr);
	}
	
	// 히든 카드
	for(var i = 1 ; i < 4 ; i++)
	{
		var hiddenStr;
		if(openState >= i && myLevel >= (i+1)){
			$('#hidden_' + i).removeClass('comingsoon');
			$('#hidden_' + i).addClass('thumb');			
			hiddenStr = '<a href="javascript:songPopup('+hiddenList[i-1].orderNum+','+ hiddenList[i-1].eventSongSeq +');">';
			
			if(hiddenList[i-1].playYn == 1)	{hiddenStr += '	<img src="' + param_imgroot + emsEventSeq +'/card/hidden_' + i + '.png">';}
			else{hiddenStr += '	<img src="' + param_imgroot + emsEventSeq +'/card/hidden_card_off.png">';}
			hiddenStr += '</a>';
		}
		else{
			
			$('#hidden_' + i).removeClass('thumb');
			$('#hidden_' + i).addClass('comingsoon');
			hiddenStr = '<img src="' + param_imgroot + emsEventSeq +'/card/hidden_card_off.png">';
		}
		
		$('#hidden_' + i).html(hiddenStr);
		
	}
}


// 뮤직 카드 디스플레이
function display_musicCard(songList){
	
	var totMusicCard = songList.length;
	var cardLineCount = 7;				// 카드 열(7종류)
	var cardLineMax = [3,4,6,7,6,3,5];  // 열마다 카드 개수
	
	var musicCard = new Array();
	for(var i=0; i<totMusicCard; i++){
		musicCard[i] = songList[i].playCnt;
	}
	
	var emsEventSeq = $("#eventForm input[name='emsEventSeq']").val();
	var cardIndex = 0;
	var liStr = "<ol>";
	for(var i=0; i< cardLineCount; i++){	
		
		liStr += '<li><dl>'; 
		for(var j=0; j< cardLineMax[i] ; j++){
		
			liStr += '<dd>';
			var cardName = 'card_' + (cardIndex+1);	// 카드 이름	  : card_1, card_2 ...
			var cardPlayNum = musicCard[cardIndex];	// 카드 번호에 해당하는 play 완료 수 : 
				
			if(cardPlayNum> 0){ 			
 				var cardDivHtml;
 				cardDivHtml = '<div class="thumb">';
 				cardDivHtml += '<a href="javascript:songPopup('+ songList[cardIndex].orderNum + ',' + songList[cardIndex].eventSongSeq+ ');">';
 				cardDivHtml += '	<img src="'+ param_imgroot + emsEventSeq +'/card/card_' + (cardIndex+1) +'.png" >';
 				cardDivHtml += '</a></div>';
 				liStr += cardDivHtml;
 			}
			else{ 				
 				var cardDivHtml;
 				cardDivHtml = '<div>';
 				cardDivHtml += '<a href="javascript:songPopup('+ songList[cardIndex].orderNum + ',' + songList[cardIndex].eventSongSeq+ ');">';
 				cardDivHtml += '	<img src="' + param_imgroot + emsEventSeq + '/card/card_off.png" >';
 				cardDivHtml += '</a></div>';
 				liStr += cardDivHtml;
			}
			
			for(var k = 1 ; k < 4 ; k++)
			{
				var cardStarHtml;
				cardStarHtml = '<span><img src="' + param_imgroot + emsEventSeq +'/card/';
				if(cardPlayNum < k){cardStarHtml += 'star_0';} 
				else{cardStarHtml += 'star_' + k;}  
				cardStarHtml +='.png"></span>';
				liStr += cardStarHtml;
			}	
 			
 			liStr += '</dd>';
 			cardIndex++;
 		}
 		liStr += '</dl></li>';
   	}   
	
	liStr += '</ol>';
	$('#musicCards').html(liStr);
	
}


// 곡 선택 시 가사 창 팝업
function songPopup(orderNum, eventSongSeq){
	
	var emsEventSeq = $("#eventForm input[name='emsEventSeq']").val();  // 이벤트 차수
	var eventState = $("#eventForm input[name='eventState']").val();  ///이벤트 상태
	var isCookies = $("#eventForm input[name='isCookies']").val();
	var isChess = $("#eventForm input[name='isChess']").val();
	$("#eventForm input[name='eventSongSeq']").val(eventSongSeq);
	$("#eventForm input[name='orderNum']").val(orderNum);
	
	
	if(eventState == 1)
	{
		if(isCookies != 1) {
			alert("로그인 후 미션에 참여 해 주세요.\r\n\r\n Song은 누구나 Play 할 수 있지만\r\n미션 참여는 CHESS 재원생만 가능합니다.");	
			redirectToGojls(1);
			return;
		}
		
		// 현재 음원 재생 중이라면 플레이 안되도록 막는다.
	    if (!oAudio.paused) {
	        return;
	    }	    
	    
		$("#liric_info").html('<img src="' + param_imgroot+ emsEventSeq + '/lyric/lyric_' + orderNum + '.jpg" />');
		$('body').css('overflow','hidden');
		$('.music_song, .black_bg').fadeIn();
		
		mappingSong(orderNum, eventSongSeq);
		playSong();
		
	}
	else
	{
		alert("이벤트 참여 기간이 아닙니다.");
	}
}

// 가사 창 닫기 
function closeSongPopup()
{		
    if (oAudio.src !='' && !oAudio.paused) {    	
        oAudio.pause();
    }    
    
    oAudio.src = '';
    playbar.style.width = 0;
    reload_SongData();
    
	$('.music_song').fadeOut();
	$('body').removeAttr('style');
	$('.black_bg').fadeOut();
	$('.blue_bg').fadeOut();
	
	$(this).closest('.find_card').fadeOut();
	$('.guide').addClass('hide').removeAttr('style');	
}

// 오디오 플레이어에 곡 정보 입력
function mappingSong(orderNum, eventSongSeq)
{
	var emsEventSeq = $("#eventForm input[name='emsEventSeq']").val();  // 이벤트 차수
	var eventState = $("#eventForm input[name='eventState']").val();  ///이벤트 상태
	oAudio.src = param_songroot + emsEventSeq + '/' + orderNum + '.mp3'; 
}

// 곡 재생 : 가사 창 팝업 후, replay 버튼 클릭 후 
function playSong(orderNum, eventSongSeq) 
{	
	if (oAudio.paused) {
        oAudio.play();
    }
}

var playCntMsg1 = ['시작이 반이다! 에너지 보석이 다 채워질 때까지 Go Go Go~', '보석 한 개 획득! 힘내라 힘!'];
var playCntMsg2 = ['한번 더 듣고 보석 3개  채워보자구용~', '멋짐 폭발! 보석 두 개 획득!'];
var playCntMsg3 = ['그레잇! 보석이 다 채워졌네요. 다른 곡들도 들어봐요~', '꿈★은 이뤄진다. 뮤직 히어로까지 가즈아~', '정상어학원 친구들의 뮤직 히어로 도전을 응원합니다!', '뮤직 히어로가 되는 그 날까지 힘내라 힘!']; 
var heromsg = ['그레잇! 히어로인 당신, 정말 노래를 좋아하시는군요.', '당신의 열정을 응원합니다.'];


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
					if(orderNum < 35)
					{
						for(var k = 1 ; k < 4 ; k++)
						{
							var cardStarHtml;
							cardStarHtml = '<span><img src="' + param_imgroot + emsEventSeq +'/card/';
							if(songPlayCnt < k){cardStarHtml += 'gem_0';} 
							else{cardStarHtml += 'gem_' + k;}  
							cardStarHtml +='.png"></span>';
							starHtml += cardStarHtml;
						}
				   		
				   		var i = Math.ceil( Math.random()*100 ) % 2;	
				   		var j = Math.ceil( Math.random()*100 ) % 4;					
				   		if(songPlayCnt < 3){starHtml += "<p>노래를 더 듣고 보석을 채워보아요.</p>";}				   		
				   		else if(songPlayCnt > 2 && data.myLevel < 4){starHtml += "<p>뮤직 히어로가 되는 그 날 까지 도전!</p>";}
				   		else if(data.myLevel == 4){starHtml += "<p>그레잇! 내가 바로 뮤직 히어로</p>";}
				   		$('.guide .action .count').html(starHtml);
				   		$('.guide .action .count').show();
					}
					else
					{
						if(songPlayCnt == 1){							
							starHtml = "<p>히든 카드 한개를 획득하셨습니다.</p>";
							$('.guide .action .count').html(starHtml);
							$('.guide .action .count').show();
						}
						else{
							
							$('.guide .action .count').html("");
							$('.guide .action .count').hide();
						}						
					}		   		
			   		
			   		
			   		// 레벨 업 시 얻은 뮤직 카드 보여 주기
					if(data.myLevel > myLevel)
					{	
						 $("#eventForm input[name='myLevel']").val(data.myLevel);
						 
						var findCardHtml;
				   		findCardHtml = '<img id="find_card" src="' + param_imgroot + emsEventSeq +'/card/find_level_'+ data.myLevel +'.png">';
				   		$('.blue_bg .find_card .hero_card').html(findCardHtml);
				   		$('.blue_bg').fadeIn();
						$('.find_card').fadeIn();
				   		
				   		$(document).on('click','.hero_card',function() {
				   			$(this).closest('.find_card').fadeOut();
				   			$('.blue_bg').fadeOut();
				   		});
				   		
					}
			   		
		         }else{
		         	alert(data.msg);
		         }
			},
	    error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
		});
	}
	else{
		var strHtml = '<p>CHESS 학생으로 로그인 시 이벤트 참여가 가능합니다.</p>';
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
		if(oAudio.muted){$('#controls>li #mute').html('<img src="' + param_imgroot + emsEventSeq +'/icons8-no-audio-26.png" >');}
		else{$('#controls>li #mute').html('<img src="' + param_imgroot + emsEventSeq +'/icons8-speaker-26.png" >');}
		
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
			  $('#controls>li #mute').html('<img src="' + param_imgroot + emsEventSeq +'/icons8-no-audio-26.png" >');
			  oAudio.muted = true;
		  }
		  else{
			  $('#controls>li #mute').html('<img src="' + param_imgroot + emsEventSeq +'/icons8-speaker-26.png" >');
			  oAudio.muted = false;
		  }
	});
	
		
	// 재생 중 이벤트	
	oAudio.addEventListener("playing", function() {
		$('.guide').addClass('hide').removeAttr('style');
		$('#controls>li #play').html('<img src="' + param_imgroot + emsEventSeq +'/icons8-pause-26.png" >');
	});
	// 일시 중지 이벤트
	oAudio.addEventListener("pause", function() {
		$('#controls>li #play').html('<img src="' + param_imgroot + emsEventSeq +'/icons8-play-26.png" >');
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


</script>





