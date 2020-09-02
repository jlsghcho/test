<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="Ko">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache">
<meta name="viewport" content="width=1202, user-scalable=yes">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />

<title> JLS정상어학원 </title>
<title> 1000시간 영어노출 미션 </title>

<jsp:include page="../common/statistics.jsp"/>
<link type="text/css" rel="stylesheet" media="all" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/css/learningkids/2020_1000time?26185244" />
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/js/jquery-ui-1.12.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/js/jquery.scrollTo-min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
<script src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON']" />/js/TweenMax.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://csshake.surge.sh/csshake.min.css">

<script type="text/javascript">   

var J$ = jQuery.noConflict();

// text animation 
setTimeout(function(){ J$(".s1_tit1").css('opacity', '1').addClass('flip-in-y') },400);

// tab
$(document).ready (function () {
	
	
	$("#s4").hide();
	$("#black_bg").hide();
	
	$(window).scroll(function() {		
		scrollEvent();
	});
	$(window).resize(function() {		
		scrollEvent();
	});	
	
	// text animation motion   
	var ta = new TimelineMax({ delay:0, repeat:0  })
	ta.to('.s1_txt2' , 0.5, {delay:0, opacity:1, top:"530px" })

	(function(a){
		a.fn.tabonoff_auto=function(p){
			function begin(){
				dom.click(function(){current = dom.index(J$(this)); play(); stop()});
				dom.parent().parent().hover(function(){stop();},function(){timer = setTimeout(play,s_t_i);});
			}
		}
	})(jQuery);
	
});


/* scroll */ 
$(function () {
	var msie6 = $.browser == 'msie' && $.browser.version < 7;
	var myHeight = window.innerHeight;

	if (!msie6) {
		var top = $('#sr_nav').offset().top - parseFloat( $('#sr_nav').css('margin-top').replace(/auto/, 0) );
		
		$(window).scroll(function (event) {
			// what the y position of the scroll is
			var y = $(this).scrollTop();

			if (y >= top) {
			$('#sr_nav').addClass('fixed');
			$('#sr_wrap').addClass('relative');
			} else {
			$('#sr_nav').removeClass('fixed');
			$('#sr_wrap').removeClass('relative');
			}
		});
	}
});


function scrollEvent() {		
	locate = $(window).scrollTop();	
	//$(".pos_txt").text(locate);
	if( locate == 0 || locate < $("#s1").offset().top -85) {
		sr_nav(0,"scroll");
	}else if( locate > $("#s1").offset().top && locate < $("#s2").offset().top - 85) {		
		sr_nav(1,"scroll");
	}else if( locate > $("#s2").offset().top && locate < $("#s3").offset().top - 85) {
		sr_nav(2,"scroll");
	}else if( locate > $("#s3").offset().top && locate < $("#s4").offset().top - 85) {
		sr_nav(3,"scroll");
	}
}


/* global navigation*/
function sr_nav(n,scroll){	
	if (!scroll)
	{
		 var i = 0;
		 if($("#sr_nav").attr("class") != "fixed") i = 85;
		$(window).scrollTo( $("#s"+n).offset().top - i , { duration:500, axis:'y', onAfter:function(){			
				$("#sr_nav .nav").attr("class","nav s_"+n);
		}});
		$('html, body').animate({
			scrollTop: $("#s"+n).offset().top -i
		},1000);

	}else{
		
		$("#sr_nav .nav").attr("class","nav s_"+n);
	}

	nowMenuNum = n;
}

/* Main Movie - Slideshow */
$(function() {
	$('#slides').slidesjs({
		width: 1081,
		height: 528,
		play: {
			active: true,
			auto: true,
			interval: 4000,
			swap: true,
			pauseOnHover: true,
			restartDelay: 2500,
			effect: "fade"
		},
		navigation: {
			effect: "fade"
		},
		pagination: {
			effect: "fade"
		}
	});
});

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}


///////////////////////////////////////////////////////////////////////////////////////////////////////



var missionQ = new Array();
missionQ[0] = false;
missionQ[1] = false;
missionQ[2] = false;
missionQ[3] = false;
missionQ[4] = false;
missionQ[5] = false;
missionQ[6] = false;
missionQ[7] = false;
missionQ[8] = false;

function endAlert(){
	alert("이벤트 기간이 종료 되었습니다.");
}

function waitResult()
{
	alert("3월 16일에 당첨자를 확인하세요");
}

//Setting Display
function refreshInfo(){

	$.ajax({
     type : "POST",
     url : "/event/h1k/missionCnt",
     data:"eventSeq=${eventSeq}&missionSeq=3",
     dataType : "json",
     success : function(data){
         if(data.RESULT == "SUCCESS"){
				$("#viewCnt").html(data.viewCnt);
				$("#mission3Cnt").html(data.viewCnt);	
         }else{
         	alert(data.MSG);
         }
     },
     error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
 });		
}

function clickPuzzle(fg){
	
	//endAlert();
	//return;
	missionQ[fg-1] = true;
	$("#puzzle_"+fg).attr('src', '<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_' + fg +'.png');
	$("#puzzle_s"+fg).hide();
	
	var bClear = true;
	for (var i = 1; i < missionQ.length; i++) 
	{
		if(missionQ[i] == false)
		{ 
			bClear = false; 
			break;
		}
	}
	
	if(bClear)
	{
		
		missionChk(2,9);
	}
}

function overPuzzle(fg)
{
	if(missionQ[fg-1] == true){$("#puzzle_"+fg).attr('src', '<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_' + fg +'_off.png');}
}

function outPuzzle(fg)
{
	if(missionQ[fg-1] == true){$("#puzzle_"+fg).attr('src', '<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_' + fg +'.png');}
}

function  closePopup()
{	$("#black_bg").hide();}


function missionChk(missionSeq, code){
  
	//endAlert();
	//return;
	
	if('${isCookies}' == '0'){
		var result = confirm("로그인 후 응모하실 수 있습니다.\n지금 로그인하시겠습니까?");
		if(result){
			window.location.href = "<spring:eval expression="@globalContext['GOJLS_URL']" />/login?from=FLLI&preURL=<spring:eval expression="@globalContext['SITE_URL']" />/1000hours/intro/2020?code="+code;
		}
	}else{ 
		if(missionSeq == '2'){
			missionCntChk(missionSeq, '');
		}else{
			missionSave(missionSeq, '');
		}
	}	 
}

function missionCntChk(missionSeq, answer){	 
	
	$.ajax({
        type : "POST",
        url : "/event/h1k/missionCnt",
        data:"eventSeq=${eventSeq}&missionSeq="+missionSeq,
        dataType : "json",
        success : function(data){
            if(data.RESULT == "SUCCESS"){
            	//console.log("missionCnt::"+data.cnt);
                if(data.cnt >= 1){
                	$('#black_bg .finish').css('background-image','url(<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/complete_bt.png)');
                	//$("#black_bg .finish".css({"background":"url(../../img/learningkids/2020_1000time/complete_bt.png)"}));
                	$("#black_bg").show();
                	
                	
                	
                }else{

                	$('#black_bg .finish').css('background-image', 'url(<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/finish_bt.png)');
                	//$("#black_bg .finish".css({"background":"url(../../img/learningkids/2020_1000time/finish_bt.png)"}));
                	$("#black_bg").show();
                	

                	missionSave(missionSeq, answer);
                }
            }else{
            	alert(data.MSG);
            }
        },
        error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
    });		
}

var msg = new Array();
msg[0] = "야호! 응원해주셔서 감사합니다.";
msg[1] = "응원 그뤠잇! 여러분의 응원에 힘이 납니다.";
msg[2] = "1000시간 영어노출 달성을 위해, 힘내라 힘!";
msg[3] = "정상어학원 친구들! 1000시간 가즈아~";
msg[4] = "짝짝짝! 응원합니다.";
msg[5] = "응원해주신 분들 멋짐 폭발!";
msg[6] = "정상어학원 친구들의 도전을 응원합니다.";

function missionSave(missionSeq, answer){
	$.ajax({
        type : "POST",
        url : "/event/h1k/mission",
        data:"eventSeq=${eventSeq}&missionSeq="+missionSeq+"&answer="+answer,
        dataType : "json",
        success : function(data){
            if(data.RESULT == "SUCCESS"){
                if(data.cnt == 1){
					if(missionSeq == "3"){
						$('#btn3').blur();
						var i = Math.ceil( Math.random()*10 ) % 7;
						alert(msg[i]);
					    refreshInfo();
                    }else{
						//alert("이벤트 응모가 완료되었습니다.\n당첨을 기대해주세요.");
						$("#mission2_popup").hide();
                    }
	            }
            }else{
            	alert(data.MSG);
            }
        },
    error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
		});
}
</script>
</head>
<body>


<input type="hidden" id="code" name="code" value="${code}" />  

<div id="wrap">
     <div class="quick_wrap">
		<ul>
			<li><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/sky_01.png"/></li>
			<li><a href="http://event.gojls.com/1000hours/intro/2017" class="btn_quick"target="_blank"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/sky_02.png" /></a></li>
			<li><a href="http://event.gojls.com/1000hours/intro/2018" class="btn_quick01"target="_blank"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/sky_03.png" /></a></li>
			<li><a href="http://event.gojls.com/1000hours/intro/2019" class="btn_quick02"target="_blank"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/sky_04.png" /></a></li>
            <li><a href="#slides" class="btn_quick03"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/sky_05.png" /></a></li>
		</ul>
	</div>
     <div id="slides">
          <div class="mainnum">
          <h1>${mission2Cnt}</h1>
       </div>
    </div> 
	<a href="http://www.gojls.com/academy/" target="_blank"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/jls_logo.png" class="logo" /></a>
	<div class="toparea">
	   <span class="s1_tit1 "><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/s1_tit1.png" alt="1000시간" ></span>
	   <span class="s1_txt2 "><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/s1_tit2.png" alt="영어노출미션" ></span>
	</div>
	
	<div id="sr_nav">
		<div class="nav_con">
              <ul class="nav">
                 <li class="m1"><span><a href="javascript:sr_nav(1);"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_01_on.gif" id="Image1" onClick="MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_01_on.gif',1); MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_02.gif',1); MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_03.gif',1); MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_04.gif',1)"/></a></span></li>
                 <li class="m2"><span><a href="javascript:sr_nav(2);"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_02_on.gif" id="Image2" onClick="MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_02_on.gif',1); MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_01.gif',1); MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_03.gif',1); MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_04.gif',1)"/></a></span></li>
                 <li class="m3"><span><a href="javascript:sr_nav(3);"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_03_on.gif" id="Image3" onClick="MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_03_on.gif',1); MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_01.gif',1); MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_02.gif',1); MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_04.gif',1)"/></a></span></li>
				 <li class="m4"><span><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_04_on.gif" id="Image4" onClick="MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_04_on.gif',1); MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_01.gif',1); MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_02.gif',1); MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/bar_03.gif',1)"/></span></li>
		    </ul>
		</div>
	</div>
   <div id="container">
      <div class="event_info">
        <div id="s1" class="section">
			<h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/event_01.png" /></h3>
				<div class="summary">
					<dl>
						<dt>기간</dt>
						<dd>2020년 3월 ~ 2021년 2월까지 (1년간)</dd>
					</dl>
					<dl>
						<dt>대상</dt>
						<dd>정상어학원 CHESS재원생</dd>
					</dl>
					<dl>
						<dt>목표</dt>
						<dd>국내에서도 CHESS PROGRAM과 함께 1년 동안 1000시간 영어노출하자</dd>
					</dl>
				</div>
		</div>

        <div id="s2" class="section">
			 <h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/event_02.png" /></h3>
        </div>
  

        <div id="s3" class="section">
			  <h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/event_03.png" /></h3>
			  <h1>퍼즐판의 미션 내용을 확인하고 해당되는 퍼즐을 클릭하여<br>나의 1000시간 영어노출 미션퍼즐을 완성하세요.</h1> 
			  <h2>나의 1000시간 영어노출 미션퍼즐을 완성하면 선물 추첨 응모가 완료됩니다.</h2> 
		<div class="puzzle">
		 	<div>
		       <img src="http://devimg.gojls.com/hms/img/learningkids/2020_1000time/overlab.png" class="overlab_1" alt="정규수업" style="z-index:90;" 
		            onMouseOver='javascript:overPuzzle(1);' onMouseOut='javascript:outPuzzle(1);'>
			   <img src="http://devimg.gojls.com/hms/img/learningkids/2020_1000time/overlab.png" class="overlab_2" alt="방학특강" style="z-index:91;" 
			   		onMouseOver='javascript:overPuzzle(2);' onMouseOut='javascript:outPuzzle(2);'>
			   <img src="http://devimg.gojls.com/hms/img/learningkids/2020_1000time/overlab.png" class="overlab_3" alt="영어노출프로젝트" style="z-index:92;" 
			   		onMouseOver='javascript:overPuzzle(3);' onMouseOut='javascript:outPuzzle(3);'>
			   <img src="http://devimg.gojls.com/hms/img/learningkids/2020_1000time/overlab.png" class="overlab_4" alt="숙제" style="z-index:93;" 
			   		onMouseOver='javascript:overPuzzle(4);' onMouseOut='javascript:outPuzzle(4);'>
			   <img src="http://devimg.gojls.com/hms/img/learningkids/2020_1000time/overlab.png" class="overlab_5" alt="드림트리" style="z-index:94;" 
			   		onMouseOver='javascript:overPuzzle(5);' onMouseOut='javascript:outPuzzle(5);'>
			   <img src="http://devimg.gojls.com/hms/img/learningkids/2020_1000time/overlab.png" class="overlab_6" alt="온라인러닝키즈" style="z-index:95;" 
			   		onMouseOver='javascript:overPuzzle(6);' onMouseOut='javascript:outPuzzle(6);'>
			   <img src="http://devimg.gojls.com/hms/img/learningkids/2020_1000time/overlab.png" class="overlab_7" alt="가정에서의영어노출" style="z-index:96;" 
			   		onMouseOver='javascript:overPuzzle(7);' onMouseOut='javascript:outPuzzle(7);'>
			   <img src="http://devimg.gojls.com/hms/img/learningkids/2020_1000time/overlab.png" class="overlab_8" alt="온라인학습" style="z-index:97;" 
			   		onMouseOver='javascript:overPuzzle(8);' onMouseOut='javascript:outPuzzle(8);'>
			   <img src="http://devimg.gojls.com/hms/img/learningkids/2020_1000time/overlab.png" class="overlab_9" alt="welcometime" style="z-index:98;" 
			   		onMouseOver='javascript:overPuzzle(9);' onMouseOut='javascript:outPuzzle(9);'>
			</div>
			
		    <div>
		       <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_1_off.png" class="puzzle_1_on" id="puzzle_1" alt="정규수업" >
			   <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_2_off.png" class="puzzle_2_on" id="puzzle_2" alt="방학특강" >
			   <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_3_off.png" class="puzzle_3_on" id="puzzle_3" alt="영어노출프로젝트">
			   <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_4_off.png" class="puzzle_4_on" id="puzzle_4" alt="숙제" >
			   <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_5_off.png" class="puzzle_5_on" id="puzzle_5" alt="드림트리" >
			   <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_6_off.png" class="puzzle_6_on" id="puzzle_6" alt="온라인러닝키즈" >
			   <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_7_off.png" class="puzzle_7_on" id="puzzle_7" alt="가정에서의영어노출" >
			   <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_8_off.png" class="puzzle_8_on" id="puzzle_8" alt="온라인학습" >
			   <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_9_off.png" class="puzzle_9_on" id="puzzle_9" alt="welcometime" >
			</div>
			<div>               
		       <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_1_s.png" class="puzzle_s1 shake-slow" id="puzzle_s1"  alt="방학특강" 
		       			onClick='javascript:clickPuzzle(1);'>
		       <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_2_s.png" class="puzzle_s2 shake-slow" id="puzzle_s2" alt="방학특강" 
		       			onClick="javascript:clickPuzzle(2);">
		       <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_3_s.png" class="puzzle_s3 shake-slow" id="puzzle_s3" alt="영어노출프로젝트" 
		       			onClick="javascript:clickPuzzle(3);">
		       <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_4_s.png" class="puzzle_s4 shake-slow" id="puzzle_s4" alt="숙제" 
		       			onClick="javascript:clickPuzzle(4);">
		       <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_5_s.png" class="puzzle_s5 shake-slow" id="puzzle_s5" alt="드림트리" 
		       			onClick="javascript:clickPuzzle(5);">
		       <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_6_s.png" class="puzzle_s6 shake-slow" id="puzzle_s6" alt="온라인러닝키즈" 
		       			onClick="javascript:clickPuzzle(6);">
		       <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_7_s.png" class="puzzle_s7 shake-slow" id="puzzle_s7" alt="가정에서의영어노출" 
		       			onClick="javascript:clickPuzzle(7);">
		       <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_8_s.png" class="puzzle_s8 shake-slow" id="puzzle_s8" alt="온라인학습" 
		       			onClick="javascript:clickPuzzle(8);">
		       <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/card_9_s.png" class="puzzle_s9 shake-slow" id="puzzle_s9" alt="welcometime" 
		       			onClick="javascript:clickPuzzle(9);">
	        </div>
	      
		</div>
			  <h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/event_gift.png" /></h3>
        </div>
		
        <div id="s4" class="section">
		   <div class="content">
			  <h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/s4_title1.png" /></h3>
			  <br><br><br>
			  <h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/s4_title2.png" /></h3>
             <div class="pagevent">
                <div> 
				<a href="#"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/s4_bt.png" ></a>
                </div>
             </div>
			 <h3><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/learningkids/2020_1000time/s4_title3.png" /></h3>
	 	   </div>
        </div>
      </div>    
	</div>     
</div>


   <div class="black_bg" id="black_bg">	
	<div class="finish">
		<div class="close" onClick="javascript:closePopup();">Close</div>
	</div>
   </div>	
	
</body>
</html>


