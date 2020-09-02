<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
					
					
<div class="count">
	<h3>${eventMovieInfo.movieNm }</h3>
	<ul>
	<c:set var="maxCnt" value="${eventMovieInfo.viewCnt}" />
	<c:if test="${eventMovieInfo.viewCnt > 3 }"><c:set var="maxCnt" value="3" /></c:if>
	
	<c:set var="eventMovieSortSeq" value="${eventMovieInfo.sortSeq}" />
	<c:if test="${eventMovieSortSeq < 10 }"><c:set var="eventMovieSortSeq" value="0${eventMovieSortSeq}" /></c:if>
		
	<c:forEach begin="1" end="${maxCnt}" varStatus="i"> 
		<li class="completed"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/wizard_item${eventMovieSortSeq}.png" /></li>
	</c:forEach>
	<c:forEach begin="1" end="${3 - maxCnt}" varStatus="i">
		<li><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/storyknight_20200226/wizard_item${eventMovieSortSeq}_off.png" /></li>
	</c:forEach>
	</ul>
</div>
<div class="paper">
	<div class="close">close</div>
	<div class="video-wrapper">
		<div id="studyVideo"></div>
		<div class="player_controls">
			<div id="playBtn" onclick="playYoutube();">Play</div>
	    	<div id="pauseBtn" onclick="pauseYoutube();">Pause</div>
	    	<div id="current_time"></div>
	    </div>
		<div class="frame_line"><span></span></div>
		<div class="guide hide">
			<div class="text">
				<h5>스토리 영상을 다시 보고 성의 주민을 더 찾아보세요!</h5>
			</div>
			<div class="action">
				<!--<p>Auto playing in <span id="timer"></span>s</p>-->
				<button type="button" onclick="countdown_clear();"><span>다시 찾아보기</span></button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
var eventHistorySeq = '${eventHistorySeq}';
//vid.removeAttribute('controls');			

function countdown_clear() {
	//
	/*vid.pause();
	vid.currentTime = 0;*/
	
	//pauseYoutube();
	$.ajax({
		type : "POST",
	    url : "/grammar/${eventSeq}/movie",
	    dataType : "json",		
	    data:"eventMovieSeq=${eventMovieInfo.eventMovieSeq}",
		success: function(data) {
			if(data.RESULT=="SUCCESS"){
				eventHistorySeq = data.eventHistorySeq;
				
				/*vid.currentTime = 0;
				vid.play();*/

				clearInterval(timerId);
				timerId = null;
			    // Skip video to new time.
			    player.seekTo(0);
				//printTimer();
				playYoutube();
				//timerId = setInterval(printTimer, 500);
				$("#playBtn").hide();
				$("#pauseBtn").show();
				
	    }else{
	    	alert(data.MSG);
	    }
		},
    error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }			
	});
	
	$('.guide').addClass('hide');
}

</script>
