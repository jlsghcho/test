<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="Ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=1202, user-scalable=yes">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title> 정상어학원 </title>

<%-- Hannibal: 추적코드 적용 (2018.05.10) --%>
<jsp:include page="../common/statistics.jsp"/>

<link href="http://image.gojls.com/newjls/img/jls.ico" rel="shortcut icon" type="image/x-icon" />

<link type="text/css" rel="stylesheet" media="all" href="<spring:eval expression="@globalContext['IMG_ROOT']" />/css/event/20180222_main.css" />
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON']" />/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT']" />/js/mobi_event.js"></script>

<script type="text/javascript" src="/resources/js/iframe_api.js"></script>

<script type="text/javascript">
var tag = document.createElement('script');
//tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var player;
var eventUccSeq = 0;

function onYouTubeIframeAPIReady() {//youtubePlayerDraw

	  player = new YT.Player('player', {
		    height: '100%',
		    width: '100%',
		    videoId: '',
		    playerVars:{
		    	autoplay:1,
		    	wmode:'transparent',
		    	showinfo:0,
		    	rel:0,
		    	frameborder:0
		    },
		    events: {
	          'onReady': onPlayerReady,
		      'onStateChange': onPlayerStateChange
		    }
		  });
}
function onPlayerReady(){
	playVideo('${defaultUccSeq}', true);
	
}

function onPlayerStateChange(){
	if(player.getPlayerState() == 1){ //재생시
		
		 startInterval();
	}else{
		 stopInterval();
	}
}

var checkPalyer;
var playtime = 0;

function startInterval() {
	checkPalyer = setInterval(function() {
		playtime++;

	    if(playtime == 30){
	    	var rdb = document.getElementById('recom_'+eventUccSeq);
			rdb.disabled = false;
			$('#recom_'+eventUccSeq).next().removeAttr('title');
			if('${isCookies}' == '1' && rdb.value.split('|')[2] != 1){ // 라디어버튼 값 :  uccSeq|recomYn|viewYn
				 
				$.ajax({
			        type : "POST",
			        url : "/chess/msucc/view",
		            data:"eventUccSeq="+rdb.value.split('|')[0],
			        dataType : "json",
			        success : function(data){
			            if(data.RESULT == "SUCCESS"){
		                    if(data.cnt == 1){ 
		                    	
				            }
			            }else{
			            	alert(data.MSG);
			            }
			        },
		        error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
		   		});
				
			}
	    } 
	     
	}, 1000)
}

function stopInterval() {
		
	    clearInterval(checkPalyer); 
}

function playVideo(uccSeq, loadFg){ 
	
	eventUccSeq = uccSeq;
	playtime = 0;
	  
	$("li").removeClass("selected");  //전체 리스트 선택 제거 
	$("li").addClass("play");  //전체 리스트 play추가 
	$("#li_"+eventUccSeq).removeClass("play"); //해당 ucc만 play 제거
	$("#li_"+eventUccSeq).addClass("selected"); //해당 ucc만 선택 표시
		
	$.ajax({
      type : "POST",
      url : "/chess/msucc/info",
      data:"eventUccSeq="+uccSeq,
      dataType : "json",
      success : function(data){
          if(data.RESULT == "SUCCESS"){

          	if(data.msUcc != null){
          		player.loadVideoById(data.msUcc.videoId);
          		$('#dept_nm').html(data.msUcc.deptNm);
          		$('#user_nm').html(data.msUcc.userNm);
          		$('#ucc_title').html(data.msUcc.uccTitle);
          		$('#ucc_comment').html(data.msUcc.uccComment);	
          		if(loadFg){
          			player.stopVideo();	
          		}
          	}else{
          		alert("UCC정보 로딩 시 오류가 발생하였습니다.");
          	}
          	
          	
          	
          }else{
          	alert(data.MSG);
          }
      },
      error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
  });
	
	

}

function recomUcc(radioBtn){
	var _date = new Date();
	var y = _date.getFullYear();
	var m = _date.getMonth() + 1;
	var d = _date.getDate();
	//alert(y+"/"+m+"/"+d);
	if(y<=2018 && m<=3 && d<=18){
		//alert(radioBtn);
		if('${isCookies}' == '0'){
			
			//alert('로그인 후 참여 가능합니다.');
			if(confirm('로그인 후 참여하실 수 있습니다.\n지금 로그인하시겠습니까?')){
				window.location.href = "<spring:eval expression="@globalContext['GOJLS_URL']" />/login?from=FLLI&preURL=<spring:eval expression="@globalContext['SITE_URL']" />/chess/msucc";
			}
			
			
		}else{ 
			
			var arrVal = radioBtn.value.split('|'); 

			if(arrVal[1] == 1){//기존 추천된 UCC면 
				//alert('이미 투표한 UCC입니다.');
			}else{
				getRecomCnt(radioBtn);
			}
		}
		
	}else{
		alert("3/5-3/18 투표기간이 종료되었습니다.");
	}
}

function getRecomCnt(radioBtn){
	$.ajax({
      type : "POST",
      url : "/chess/msucc/recomCnt",
      dataType : "json",
      success : function(data){
          if(data.RESULT == "SUCCESS"){
          	console.log("recomCnt::"+data.cnt);
              if(data.cnt >= 3){
              	alert('하루에 3개의 UCC에만 투표 가능합니다. 내일 또 참여해 주세요.');                	
              	radioBtn.checked = false;	 
              }else{
              	updateRecom(radioBtn);
              }
          }else{
          	alert(data.MSG);
          }
      },
      error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
  });
}

function updateRecom(radioBtn){  

		$.ajax({
	        type : "POST",
	        url : "/chess/msucc/recom",
          data:"eventUccSeq="+radioBtn.value.split('|')[0],
	        dataType : "json",
	        success : function(data){
	            if(data.RESULT == "SUCCESS"){
                  if(data.cnt == 1){
						radioBtn.value = radioBtn.value.split('|')[0]+"|1|1";
						alert("투표해주셔서 감사합니다.\n다른 UCC들도 즐겁게 감상해보세요.");
			    		$('input:radio[name="'+radioBtn.id+'"]').removeAttr('checked');
			    		$('input:radio[name="'+radioBtn.id+'"]').attr('checked',true);
						$('input:radio[name="'+radioBtn.id+'"]').blur();						
		            }
	            }else{
	            	alert(data.MSG);
	            }
	        },
      error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
 		});
}



$(document).ready(function(){
	$('a[href^="#"]').on('click',function (e) { 
	 
	    e.preventDefault();

	    var target = this.hash.split('|')[0];
	    var $target = $(target);
	    
	    $('html, body').stop().animate({
	        'scrollTop': $target.offset().top
	    }, 900, 'swing', function () {
	        window.location.hash = target;
	    });
	    
	    if(this.hash.split('|')[1] > 0){
	        playVideo(this.hash.split('|')[1], false);
	    }
	});
	var top = $('#ucc').offset().top;
	var bottom = $('.info').offset().top-430;
	
	$(document).scroll(function (event) {
		// what the y position of the scroll is
		var y1 = $(this).scrollTop();

		if (y1 >= top) {
			if (y1 >= bottom) {
				$('#ucc').removeClass('fixed');
			} else{
				$('#ucc').addClass('fixed');
			}
		} else {
			$('#ucc').removeClass('fixed');
		}
	});
});
</script>

<body>

<div id="wrap">
<a href="http://www.gojls.com/academy/" target="_blank"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20180222_event/logo.png" class="logo" /></a>
	<div class="toparea">
		<a href="#vote" class="btn_vote"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20180222_event/btn_vote.png" onmouseover="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20180222_event/btn_vote_on.png'" 
                       onmouseout="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20180222_event/btn_vote.png'"></a>
	</div>
	<div class="information">
		<img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20180222_event/information.jpg">
		
	</div>
	<div id="vote">
		<div class="ranking">
			<div class="count"><b>${totCnt}</b><span>건</span></div>
			<ul class="top3">
				<c:forEach items="${msUccTop3}" var="top3" varStatus="status"> 
				<li>
					<div class="thumb"><img src="${top3.imageFilePath}"></div>
					<div class="num">${top3.rnum}</div>
					<div class="text">
						<h5>${top3.uccTitle}</h5>
						<p>${top3.userNm}</p>
					</div>
				</li>
				</c:forEach>
			</ul>
		</div>
		<div id="ucc">
			<div class="stage" id="view_mov">
				<div class="movie">
					<div class="video-wrapper">
						<div id="player"> </div>
						<!-- iframe src="http://www.youtube.com/embed/9iq4B44Xc9U?autoplay=0&amp;showinfo=0&amp;autohide=2&amp;rel=0&amp;wmode=transparent" scrolling="no" frameborder="0" width="100%" height="100%" allowfullscreen=""></iframe -->
						<div class="frame_line"><span></span></div>
					</div>
				</div>
				<div class="con_info">
					<div class="item_info">
						<h5><label>영역</label> <span id="ucc_title"></span></h5>
						<h5><label>분원/레벨</label> <span id="dept_nm"></span></h5>
						<h5><label>참여학생</label> <span id="user_nm"></span></h5>
					</div>
					<div class="description">
						<!-- h4>Denmark during WWII</h4 -->
						<p id="ucc_comment"></p>
					</div>
				</div>
				<div class="info_desk">
					<p>마이 넘버원 투표절차 : <b>로그인 → UCC감상(30초 이상) → 투표하기 엄지 꾹!</b></p>
					<c:if test="${isCookies==1}">
						<a href="<spring:eval expression="@globalContext['GOJLS_URL']" />/logout?&preURL=<spring:eval expression="@globalContext['SITE_URL']"/>/chess/msucc" class="btn"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20180222_event/btn_logout.png"></a>
					</c:if> 
					<c:if test="${isCookies==0}">
						<a href="<spring:eval expression="@globalContext['GOJLS_URL']" />/login?from=FLLI&preURL=<spring:eval expression="@globalContext['SITE_URL']"/>/chess/msucc" class="btn"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20180222_event/btn_login.png"></a>
					</c:if>
				</div>
				<div class="shadow"></div>
			</div>
			<div class="list">
				<ul>
					<c:forEach items="${msUccList}" var="item">	
					<li id="li_${item.eventUccSeq}" class="<c:if test="${item.recomYn!=1}">play</c:if><c:if test="${item.recomYn==1}">selected</c:if>">
						<div class="thumb">
							<a href="#view_mov|${item.eventUccSeq}"><img src="${item.imageFilePath}"></a>
						</div>
						<div class="text">
							<h5>${item.uccTitle}</h5>
							<p>${item.userNm}</p>
						</div>
						<div class="check_vote">
							<input type="radio" id="recom_${item.eventUccSeq}" onclick="recomUcc(this);" name="recom_${item.eventUccSeq}" value="${item.eventUccSeq}|${item.recomYn}|${item.viewYn}"  <c:if test="${item.recomYn==1}">checked</c:if> <c:if test="${item.recomYn != 1 && item.viewYn != 1}">disabled</c:if> />
							<span <c:if test="${item.recomYn != 1 && item.viewYn != 1}">title="UCC 영상을 시청하시면 투표가 가능합니다."</c:if>></span>
						</div>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="info">
			<p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20180222_event/vote_info_text.png"></p>
			<a href="http://chess.gojls.com/ucc/msucc/best?viewType=&realType=1&sBestTerm=201801"class="btn_more"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20180222_event/btn_more.png" onmouseover="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20180222_event/btn_more_on.png'" 
                       onmouseout="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20180222_event/btn_more.png'"></a>
		</div>
	</div>
</div>
</body>
</html>