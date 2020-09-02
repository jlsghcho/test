<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=1081, user-scalable=yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="theme-color" content="#1278bc">
<title> 정상어학원 </title>

<%-- Hannibal: 추적코드 적용 (2018.05.10) --%>
<jsp:include page="../common/statistics.jsp"/>

<link type="text/css" rel="stylesheet" media="all" href="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/inc/css/event/20170216_main.css" />
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON']" />/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON']" />/js/jquery.scrollTo-min.js"></script>
<script>
/* scroll */
$(function () {
	var myHeight = window.innerHeight;
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
});

function scrollEvent() {		
	locate = $(window).scrollTop();	
	//$(".pos_txt").text(locate);
	if( locate == 0) {
		sr_nav(0,"scroll");
	//}else if( locate > $("#s1").offset().top && locate < $("#s2").offset().top) {		
	//	sr_nav(1,"scroll");
	}else if( locate > $("#s2").offset().top && locate < $("#s4").offset().top) {
		sr_nav(2,"scroll");
	//}else if( locate > $("#s3").offset().top && locate < $("#s4").offset().top) {
	//	sr_nav(3,"scroll");
	}else if( locate > $("#s4").offset().top && locate < $("#s5").offset().top) {
		sr_nav(4,"scroll");
	//}else if( locate > $("#s5").offset().top && locate < $("#s6").offset().top) {
	//	sr_nav(5,"scroll");
	}
}

$(document).ready(function(){
	
	var code = $("#Code").val();	
	if(code != ""){
		sr_nav(code);
		selMenu(code-1);
	}

	$(window).scroll(function() {		
		scrollEvent();
	});
	$(window).resize(function() {		
		scrollEvent();
	});	
});


/* global navigation */
function sr_nav(n,scroll){	
	if (!scroll)
	{
		$(window).scrollTo( $("#s"+n).offset().top, { duration:500, axis:'y', onAfter:function(){			
			$("#sr_nav .nav").attr("class","nav s_"+n);
			try {
				setVideoScrollControll(n);				
			} catch(err){}

		}});
	}else{
		$("#sr_nav .nav").attr("class","nav s_"+n);
		try {
			setVideoScrollControll(n);				
		} catch(err){}
	}

	nowMenuNum = n;
}

function selMenu(no){
	if(no == 1){
		MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/menuswap.png',1);
		MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/event/170216/nav_03.png',1); 
		MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/nav_04.png',1)
	}

}



/* Main Movie - Slideshow 
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
});*/

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

</script>

</head>

<body>
<form name="pop_form">
<input type="hidden" id="Code" name="Code" value="${param.code}" />
</form>
<div id="wrap">
    <a href="<spring:eval expression="@globalContext['SITE_URL']" />/1000hours/intro/2018" target="_self">
        <img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20180212_event/season2go_bt.png" class="eventgo" />
    </a>
    <div id="slides">
		<div class="spot01">
          <div class="mainnumber">
          <h1><b>625,935</b>명이 캠페인을 응원 하였습니다.<br>집계 기간 : 2월 22일~3월 17일까지</h1>
          </div>
       </div>
    </div>        
	<div id="sr_nav">
		<div class="nav_con">
			<div class="highlight"></div>
              <ul class="nav">
                <li class=""><span><img src="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/nav.png" /></span></li>
                
                <li class="m1"><span><a href="javascript:sr_nav(2);"><img src="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/nav_01.png" id="Image1" onClick="MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/menuswap.png',1); MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/nav_02.png',1); MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/nav_03.png',1); MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/nav_04.png',1)"/></a></span></li>
                
                <li class="m3"><span><a href="javascript:sr_nav(4);"><img src="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/nav_03.png" id="Image3" onClick="MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/menuswap3.png',1); MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/nav_01.png',1); MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/nav_02.png',1); MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/nav_04.png',1)"/></a></span></li>
                
                <li class="m4"><span><a href="javascript:sr_nav(5);"><img src="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/nav_04.png" id="Image4" onClick="MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/menuswap4.png',1); MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/nav_01.png',1); MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/nav_02.png',1); MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/nav_03.png',1)"/></a></span></li>
                
                <li class="m5"><span><a href="https://event.gojls.com" target="_blank"><img src="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170320/nav_05.png" border="0"/></a></span></li>                
		    </ul>
		</div>
	</div>
	<div id="sr_wrap">
		<div id="s2" class="section" id="ev1">
			<div class="content">
			  <img src="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/event_02_t.png" />
			  <img src="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/event_02.png" />
              <img src="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/event_02_1.png" />
              <img src="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/event_02_2.png" />
			</div>
		</div>      
        <div id="s4" class="section" id="ev2">
		    <div class="content">
				<img src="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/event_04_t.png" />
             	<a href="http://blog.naver.com/gojlsblog/221030792361" target="_blank"><img src="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/win_bt.png" /></a>
			    <img src="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/event_04.png" alt="이벤트" border="0">
			</div>
		</div>
		<div id="s5" class="section" id="ev3">
		   <div class="content">
			  <img src="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/event_05_t.png" />
			  <img src="<spring:eval expression="@globalContext['IMG_ROOT_GOJLS']" />/img_ad/event/170216/event_05.png" />
		   </div>
		</div>
 	</div>
</div>     
</body>
</html>