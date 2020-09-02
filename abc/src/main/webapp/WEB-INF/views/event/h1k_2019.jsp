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

<title>1000시간 영어노출 캠페인 시즌3</title>

<%-- Hannibal: 추적코드 적용 (2018.05.10) --%>
<jsp:include page="../common/statistics.jsp"/>

<link href="http://image.gojls.com/newjls/img/jls.ico" rel="shortcut icon" type="image/x-icon" />
<link type="text/css" rel="stylesheet" media="all" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/css/event/20190131_main.css" />
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/js/jquery.scrollTo-min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT']" />/js/mobi_event.js"></script>

<link rel="stylesheet" type="text/css" href="https://csshake.surge.sh/csshake.min.css">

<script type="text/javascript">   
function endAlert(){
	alert("이벤트 기간이 종료 되었습니다.");
}

function waitResult()
{
	alert("3월 22일에 당첨자를 확인하세요");
}

var mission2Q = new Array();
mission2Q[0] = false;
mission2Q[1] = false;
mission2Q[2] = false;
mission2Q[3] = false;
mission2Q[4] = false;
mission2Q[5] = false;
mission2Q[6] = false;
mission2Q[7] = false;
mission2Q[8] = false;

function mission2Click(fg){
	
	endAlert();
	return;
	/*mission2Q[fg] = true;
	$("#card"+fg).removeClass("shake-slow");
	
	var bClear = true;
	for (var i = 1; i < mission2Q.length; i++) 
	{
		if(mission2Q[i] == false)
		{ 
			bClear = false; 
			break;
		}
	}
	
	if(bClear){$("#mission2_popup").show();}*/
}
 

function missionChk(missionSeq, code){
  

	endAlert();
	return;
	
	/*if('${isCookies}' == '0'){
		var result = confirm("로그인 후 응모하실 수 있습니다.\n지금 로그인하시겠습니까?");
		if(result){
			window.location.href = "<spring:eval expression="@globalContext['GOJLS_URL']" />/login?from=FLLI&preURL=<spring:eval expression="@globalContext['SITE_URL']" />/1000hours/intro/2019?code="+code;
		}
	}else{ 
		if(missionSeq == '2'){
			missionCntChk(missionSeq, '');
		}else{
			missionSave(missionSeq, '');
		}
	}*/	 
}

function missionCntChk(missionSeq, answer){
	 
	$.ajax({
        type : "POST",
        url : "/event/h1k/missionCnt",
        data:"eventSeq=${eventSeq}&missionSeq="+missionSeq,
        dataType : "json",
        success : function(data){
            if(data.RESULT == "SUCCESS"){
            	console.log("missionCnt::"+data.cnt);
                if(data.cnt >= 1){
                	alert('오늘은 이미 참여하셨습니다.\n내일 다시 응모해주세요.');
                	$("#mission2_popup").hide();
                	
                }else{
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
						alert("이벤트 응모가 완료되었습니다.\n당첨을 기대해주세요.");
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
		MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_01_on.gif',1); 
		MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_02_on.gif',1); 
		MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_03_on.gif',1);
		MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_04_on.gif',1);
	}else if( locate >= $("#s1").offset().top -85 && locate < $("#s3").offset().top -85) {		
		sr_nav(1,"scroll");
		MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_01_on.gif',1); 
		MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_02.gif',1); 
		MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_03.gif',1);
		MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_04.gif',1);
	}else if( locate >= $("#s3").offset().top -85 && locate < $("#s6").offset().top -85) {
		sr_nav(3,"scroll");
		MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_02_on.gif',1); 
		MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_01.gif',1);
		MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_03.gif',1);
		MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_04.gif',1);
	}else if( locate > $("#s6").offset().top -85 && locate < $("#s7").offset().top -85) {
		sr_nav(6,"scroll");
		MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_03_on.gif',1); 
		MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_01.gif',1); 
		MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_02.gif',1);
		MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_04.gif',1);
	}else if( locate > $("#s7").offset().top -85 ) {
		sr_nav(7,"scroll");
		MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_04_on.gif',1);		 
		MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_01.gif',1); 
		MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_02.gif',1);
		MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_03.gif',1);
	}

}

$(document).ready(function(){
	
	$("#mission2_popup").hide();
	
	var code = $("#code").val();	
	if(code != ""){
		sr_nav(code);
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
	    var i = 0;
	    if($("#sr_nav").attr("class") != "fixed") i = 85;
	    
		$(window).scrollTo( $("#s"+n).offset().top - i , { duration:500, axis:'y', onAfter:function(){			
			$("#sr_nav .nav").attr("class","nav s_"+n);
		}});
		$('html, body').animate({
			scrollTop: $("#s"+n).offset().top
			},1000);
	}else{
		$("#sr_nav .nav").attr("class","nav s_"+n);
	}
	nowMenuNum = n;
}

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
<input type="hidden" id="code" name="code" value="${code}" />  


  <div id="wrap"> 
    <a href="<spring:eval expression="@globalContext['SITE_URL']" />/1000hours/intro/2017" target="_blank"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/event1.png" class="event1" /></a>
	<a href="<spring:eval expression="@globalContext['SITE_URL']" />/1000hours/intro/2018" target="_blank"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/event2.png" class="event2" /></a>
	
     <div id="slides">
		<div class="spot">
          <div class="mainnum">
          <h1 id="viewCnt">${mission3Cnt}</h1>
          </div>
       </div>
    </div> 
        
	<div id="sr_nav">
		<div class="nav_con">
              <ul class="nav">
                <li class="m1"><span><a href="javascript:sr_nav(1);"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_01_on.gif" id="Image1" onClick="MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_01_on.gif',1); MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_02.gif',1); MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_03.gif',1); MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_04.gif',1)"/></a></span></li>
                <li class="m2"><span><a href="javascript:sr_nav(3);"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_02_on.gif" id="Image2" onClick="MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_02_on.gif',1); MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_01.gif',1); MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_03.gif',1); MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_04.gif',1)"/></a></span></li>
                <li class="m3"><span><a href="javascript:sr_nav(6);"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_03_on.gif" id="Image3" onClick="MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_03_on.gif',1); MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_01.gif',1); MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_02.gif',1); MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_04.gif',1)"/></a></span></li>
                <li class="m4"><span><a href="javascript:sr_nav(7);"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_04_on.gif" id="Image4" onClick="MM_swapImage('Image4','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_04_on.gif',1); MM_swapImage('Image1','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_01.gif',1); MM_swapImage('Image2','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_02.gif',1); MM_swapImage('Image3','','<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/bar_03.gif',1)"/></a></span></li>
            </ul>
		</div>
	</div>

	<div id="sr_wrap">
    
		<div id="s1" class="section">
			<div class="content">
			  <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/event_01_1.gif" />
              <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/event_01_2.gif" />
			</div>
		</div>

        <div id="s3" class="section">
		    <div class="content">
			    <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/s2_title.png" />
                <div class="pagevent">
                	 <div class="count">
                   		<h1 id="mission3Cnt">${mission3Cnt}</h1>
                	</div>
                	 <h1>실시간 응원 현황</h1>
                	
                	<div class="cheer_bt"> 
					<a href="javascript:missionChk('3', '3');" id="btn3"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/entry_bt.png" onmouseover="this.src='<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/entry_bt_on.png'" 
                       onmouseout="this.src='<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/entry_bt.png'"></a>
                	</div>
                </div>
		    </div>
        </div>  
        
        <div id="s4" class="section">
		   <div class="content">
			  <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/event_03_title.gif" />
           </div>
	    </div>
        
         <div id="s5" class="section">
		    <div class="content">
			    <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/event_04_title.gif" />
                <div class="question" style="margin-left:55px;">
		              <ul>
		                  <li>
                         <p><img id="card1" src='<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/check_bt.png'  border="0" class="shake-slow" 
                                onclick='$(this).attr("src", "<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/q1.png");javascript:mission2Click(1);' /></p>
                          </li>
						 <li>
                         <p><img id="card2" src='<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/check_bt.png'  border="0" class="shake-slow"
                         	    onclick='$(this).attr("src", "<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/q2.png");javascript:mission2Click(2);' /></p>
                        </li>
                        <li>
                        <p><img id="card3" src='<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/check_bt.png'  border="0" class="shake-slow"
                        		onclick='$(this).attr("src", "<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/q3.png");javascript:mission2Click(3);' /></p>
                        </li>
						<li>
                        <p><img id="card4" src='<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/check_bt.png'  border="0"  class="shake-slow"
                        		onclick='$(this).attr("src", "<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/q4.png");javascript:mission2Click(4);' /></p>
                        </li>
                       </ul>
					   <ul>
		               <li>
                        <p><img id="card5" src='<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/check_bt.png'  border="0" class="shake-slow"
                        		onclick='$(this).attr("src", "<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/q5.png");javascript:mission2Click(5);' /></p>
                       </li>
		               <li>
                         <p><img id="card6" src='<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/check_bt.png'  border="0" class="shake-slow"
                         		onclick='$(this).attr("src", "<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/q6.png");javascript:mission2Click(6);' /></p>
                          </li>
                       <li>
                        <p><img id="card7" src='<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/check_bt.png'  border="0" class="shake-slow"
                        		onclick='$(this).attr("src", "<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/q7.png");javascript:mission2Click(7);' /></p>
                       </li>
					   <li>
                        <p><img id="card8" src='<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/check_bt.png'  border="0" class="shake-slow"
                        	onclick='$(this).attr("src", "<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/q8.png");javascript:mission2Click(8);' /></p>
                       </li>
                       </ul>
                </div>
                <div class="box" id="mission2_popup" >
				    <a href="javascript:missionChk('2', '5');"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/master.png" class="gift_box"></a>
			    </div>
				<div class="copy">
					  <p><img src='<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/quest.png'  border="0" 
					  		onclick='$(this).attr("src", "<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/quest.png");' /></p>
                </div>
                 
                <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/event_01_3.gif" />
             </div>
		</div>
	    
       <div id="s6" class="section">
		   <div class="content">
			 <div class="gift"> 
                   <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/event_02.jpg" />
             </div>
		   </div>
      </div>  
       <div id="s7" class="section">
		   <div class="content">
			  <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/s7_title.png" />
			  <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/s7_title2.png" />
             <div class="pagevent">
                <div class="cheer_bt"> 
				<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/s7_bt.png" onclick="waitResult();" onmouseover="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/s7_bt_on.png'" 
                       onmouseout="this.src='<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/s7_bt.png'">
                </div>
             </div>
			 <img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20190131_event/s7_title3.png" />
	 	   </div>
        </div>
	 </div>
	
</div>   


</body>
</html>