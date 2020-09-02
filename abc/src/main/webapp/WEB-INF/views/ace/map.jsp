<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=1202, user-scalable=yes">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>정상어학원</title>

<%-- Hannibal: 추적코드 적용 (2018.05.10) --%>
<jsp:include page="../common/statistics.jsp"/>

<link href="http://image.gojls.com/newjls/img/jls.ico" rel="shortcut icon" type="image/x-icon" />
 
<link type="text/css" rel="stylesheet" media="all" href="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/css/event/20171120_main.css" />
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_SSL']" />/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/js/mobi_event.js"></script>

<script type="text/javascript" src="/resources/js/iframe_api.js"></script>

<script type="text/javascript">
var tag = document.createElement('script');
//tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var player;
 
function onYouTubeIframeAPIReady() {//youtubePlayerDraw

	  player = new YT.Player('player', {
		    height: '541',
		    width: '1000',
		    videoId: 'FXwexMCb528',
		    playerVars:{
		    	autoplay:0,
		    	wmode:'transparent',
		    	showinfo:0,
		    	rel:0,
		    	frameborder:0
		    },
		    events: {
		      'onStateChange': onPlayerStateChange
		    }
		  });
}

/*function onPlayerStateChange(event) {
    if(event.data == YT.PlayerState.ENDED) {
        console.log('onPlayerStateChange 실행: ' + '종료');
    }
}*/
function onPlayerStateChange(){
	if(player.getPlayerState() == 1){ //재생시
		
		 startInterval();
	}else{
		 stopInterval();
	}
}

var checkPalyer;
var playtime = 0;
var enterMission2Flag = false;

function startInterval() {
	checkPalyer = setInterval(function() {
		playtime++;

	    if(playtime > 60){

	    	enterMission2Flag = true;    	
	    }
	     
	}, 1000)
}

function stopInterval() {
 		
	    clearInterval(checkPalyer); 
}

var answer = "";
var eventMapSeq = "";
var eventMapSeqCheck = "";
function setMissionMap(mapCd, mapSeq){

	$.ajax({
        type : "POST",
        url : "/ace/map/mission1Info",
        data:"mapCd="+mapCd+"&eventMapSeq="+mapSeq,
        dataType : "json",
        success : function(data){
            if(data.RESULT == "SUCCESS"){

            	if(data.missionInfo != null){

            		$(".quest").attr("style", "display:none");
            		$(".question").attr("style", "display:");
            		
            		$("#title1").html(data.missionInfo.title1);
            		$("#question1").html(data.missionInfo.question1);
            		$("#title2").html(data.missionInfo.title2);
            		$("#question2").html(data.missionInfo.question2);
            		$("#title3").html(data.missionInfo.title3);
            		$("#question3").html(data.missionInfo.question3);
            		$("#title4").html(data.missionInfo.title4);
            		$("#question4").html(data.missionInfo.question4);
            		 
            		answer = data.missionInfo.answer;
            		eventMapSeq = data.missionInfo.eventMapSeq;
            		if(data.missionInfo.pdfFilePath!=null && data.missionInfo.pdfFilePath!=""){
                		$(".pdf").attr("style", "display:");
                		$(".pdf").val(data.missionInfo.pdfFilePath);
            		}else{
                		$(".pdf").attr("style", "display:none");
                		$(".pdf").val("");
            		}
            		
        			$("#mapcodeText").val("");
            		$("#mapcodeText").attr("readonly", false);
					
            		$("#btnAnswer").attr("disabled", false); 
					$("#btnAnswer").attr("class", "orange"); 
					$("#spanAnswer").text("Send");
					
					answerCnt = 0;
           		    
            	}else{
            		answer = "";
            		eventMapSeq = "";
            		eventMapSeqCheck = "";
            		alert("미션정보 로딩 시 오류가 발생하였습니다.");
            	}
            }else{
            	alert(data.MSG);
            }
        },
        error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
    });
}

function delSpace(input){

	input.value = input.value.replace(/ /gi, ""); 
}

function endAlert(){
	alert("미션응모기간 : 12월 18일~ 1월 7일\n미션응모 기간이 종료 되었습니다.");
}


var answerCnt = 0;
var enterMission1Flag = false;
function sendAnswerCheck(){
 
	$("#mapcodeText").val($("#mapcodeText").val().replace(/ /gi, ""));
	
	if('${isCookies}' == '0'){
		alert('본 미션은 로그인 후 참여 가능합니다.');
		
		setCookie("mapSeq",  eventMapSeq);
		setCookie("misisonNum",  "1"); 
		
		window.location.href = "<spring:eval expression="@globalContext['GOJLS_URL']" />/login?from=FLLI&preURL=<spring:eval expression="@globalContext['SITE_URL']" />/ace/map";	
		
	}else{ 
 
		if($("#mapcodeText").val() == null || $("#mapcodeText").val() == ""){
			alert('MAP code를 입력하세요.');
		}else{

			$.ajax({
		        type : "POST",
		        url : "/ace/map/missionCnt",
		        data:"missionFg=1",
		        dataType : "json",
		        success : function(data){
		            if(data.RESULT == "SUCCESS"){
		            	console.log("mission1Cnt::"+data.cnt);
		                if(data.cnt >= 3){
		                	alert('최대 3번까지 참여가 가능한 MISSION입니다.');	 
		                }else{
		                	sendAnswer();
		                }
		            }else{
		            	alert(data.MSG);
		            }
		        },
		        error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
		    });		
		} 
	}	 
}

function sendAnswer(){
	
	if(answer != $("#mapcodeText").val()){
		
		answerCnt++;
		if(answerCnt < 5){
			alert("5번의 입력기회중 "+answerCnt+"회 실패하셨습니다!\n주어진 단서를 다시 확인하여\n정확한 MAP code를 입력해 주세요!");	
			$("#mapcodeText").focus();
		}else{
			alert("5번의 입력기회를 모두 사용하셨습니다.\n교재를 다시 선택하고 새로운 Mission을 받으세요!");

			$("#mapcodeText").val("");
			$("#mapcodeText").attr("readonly", true);	
			$("#btnAnswer").attr("disabled", true); 
			$("#btnAnswer").attr("class", "purple"); 
			$("#spanAnswer").text("Fail");
		}
	}else{
		alert("축하합니다! 당신은 MAP code 풀기를 성공하였습니다.\n이제 Step2로 가서 원하는 선물을 응모해주세요!!");

		$("#mapcodeText").attr("readonly", true);	
		$("#btnAnswer").attr("disabled", true); 
		$("#btnAnswer").attr("class", "pink"); 
		$("#spanAnswer").text("Success");
		
		enterMission1Flag = true;
		eventMapSeqCheck = eventMapSeq;

	}
	
}
 

function enterMission1Check(){

	if(enterMission1Flag == false){
		
		alert("Step1의 MAP code를 풀어야 선물응모가 가능합니다.");
		
	}else if($("input[type=radio][name=rd_mission1]:checked").val() == undefined || $("input[type=radio][name=rd_mission1]:checked").val() == ""){
		
		alert("받고 싶은 선울을 응모해 주세요.");
		
	}else{

		$.ajax({
	        type : "POST",
	        url : "/ace/map/missionCnt",
	        data:"missionFg=1",
	        dataType : "json",
	        success : function(data){
	            if(data.RESULT == "SUCCESS"){
	            	console.log("mission1Cnt::"+data.cnt);
	                if(data.cnt >= 3){
	                	alert('최대 3번까지 참여가 가능한 MISSION입니다.');	 
	                }else{
	                	enterMission1();
	                }
	            }else{
	            	alert(data.MSG);
	            }
	        },
	        error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
	    });		
	}
}

function enterMission1(){  

	var goodsFg = $("input[type=radio][name=rd_mission1]:checked").val();
	var deptSeq = '${mapUserInfo.deptSeq}';
	var clsSeq = '${mapUserInfo.clsSeq}';
	
		$.ajax({
	        type : "POST",
	        url : "/ace/map/mission",
            data:"missionFg=1&deptSeq="+ deptSeq+"&clsSeq="+clsSeq+"&eventMapSeq="+eventMapSeq+"&goodsFg="+goodsFg+"&answer=",
	        dataType : "json",
	        success : function(data){
	            if(data.RESULT == "SUCCESS"){
                    if(data.cnt == 1){
                    	enterMission1Flag = false;
						alert("응모되었습니다.");
						refreshInfo();
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
        url : "/ace/map/missionCntInfo",
        dataType : "json",
        success : function(data){
            if(data.RESULT == "SUCCESS"){
 
				$("#viewCnt").html(data.viewCnt+"건");
				$("#mission1Cnt").html(data.mission1Cnt+"건");
				$("#mission2Cnt").html("카카오톡 이모티콘 <b>"+data.mission2Cnt+"명 응모 중</b>");
				$("#goods1Cnt").html("ABC마트 상품권 5만원 <b>"+data.goods1Cnt+"명 응모 중</b>");
				$("#goods2Cnt").html("영화 2인티켓 <b>"+data.goods2Cnt+"명 응모 중</b>");
				$("#goods3Cnt").html("베스킨라빈스 파인트 <b>"+data.goods3Cnt+"명 응모 중</b>");
				$("#goods4Cnt").html("카카오프렌즈 인덱스노트 <b>"+data.goods4Cnt+"명 응모 중</b>");
				
				var stamp1 = "";
				if(data.mapUserInfo.selBookNm1 != '-' && data.mapUserInfo.selBookNm1 != null){
					stamp1 += "<div class='clear'>";
					stamp1 += "<h4><img src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/clear.png' /></h4>";
					stamp1 += "</div>";
				}

				stamp1 += "<h1>첫번째 도전 MAP Code</h1>";
				stamp1 += "<h2>"+data.mapUserInfo.selBookNm1+"</h2>";
				stamp1 += "<p><img src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/"+data.mapUserInfo.selGoodsFg1+".png'></p>";
				stamp1 += "<h3>응모한 선물</h3>";
				$("#stamp1").html(stamp1); 

				var stamp2 = "";
				if(data.mapUserInfo.selBookNm2 != '-' && data.mapUserInfo.selBookNm2 != null){
					stamp2 += "<div class='clear'>";
					stamp2 += "<h4><img src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/clear.png' /></h4>";
					stamp2 += "</div>";
				}

				stamp2 += "<h1>두번째 도전 MAP Code</h1>";
				stamp2 += "<h2>"+data.mapUserInfo.selBookNm2+"</h2>";
				stamp2 += "<p><img src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/"+data.mapUserInfo.selGoodsFg2+".png'></p>";
				stamp2 += "<h3>응모한 선물</h3>";
				$("#stamp2").html(stamp2); 
				
				var stamp3 = "";
				if(data.mapUserInfo.selBookNm3 != '-' && data.mapUserInfo.selBookNm3 != null){
					stamp3 += "<div class='clear'>";
					stamp3 += "<h4><img src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/clear.png' /></h4>";
					stamp3 += "</div>";
				}

				stamp3 += "<h1>두번째 도전 MAP Code</h1>";
				stamp3 += "<h2>"+data.mapUserInfo.selBookNm3+"</h2>";
				stamp3 += "<p><img src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/"+data.mapUserInfo.selGoodsFg3+".png'></p>";
				stamp3 += "<h3>응모한 선물</h3>";
				$("#stamp3").html(stamp3); 
            	 
            	
            }else{
            	alert(data.MSG);
            }
        },
        error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
    });		
}

function enterMission2Check(){
	
    if('${isCookies}' == '0'){
		
		alert('본 미션은 로그인 후 참여 가능합니다.');

		setCookie("enterMission2Flag",  enterMission2Flag);
		setCookie("misisonNum",  "2");
		
		
		window.location.href = "<spring:eval expression="@globalContext['GOJLS_URL']" />/login?from=FLLI&preURL=<spring:eval expression="@globalContext['SITE_URL']" />/ace/map";
		
		
	}else if(enterMission2Flag != true && enterMission2Flag != 'true'){
		
		alert("영상 재생 1분 이후 응모가 가능합니다.");
		
	}else if($("input[type=radio][name=rd_mission2]:checked").val() == undefined || $("input[type=radio][name=rd_mission2]:checked").val() == ""){
		
		alert("영상을 보고 Hidden Message를 선택해 주세요.");
		
	}else{

		$.ajax({
	        type : "POST",
	        url : "/ace/map/missionCnt",
	        data:"missionFg=2",
	        dataType : "json",
	        success : function(data){
	            if(data.RESULT == "SUCCESS"){
	            	console.log("mission2Cnt::"+data.cnt);
	                if(data.cnt >= 1){
	                	alert('1일 1회 참여 가능합니다.');	 
	                }else{
	                	enterMission2();
	                }
	            }else{
	            	alert(data.MSG);
	            }
	        },
	        error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
	    });		
	}
}

function enterMission2(){  

	var answerMission2 = $("input[type=radio][name=rd_mission2]:checked").val();
	var deptSeq = '${mapUserInfo.deptSeq}';
	var clsSeq = '${mapUserInfo.clsSeq}';
	
		$.ajax({
	        type : "POST",
	        url : "/ace/map/mission",
            data:"missionFg=2&deptSeq="+ deptSeq+"&clsSeq="+clsSeq+"&eventMapSeq=&goodsFg=&answer="+answerMission2,
	        dataType : "json",
	        success : function(data){
	            if(data.RESULT == "SUCCESS"){
                    if(data.cnt == 1){
                    	enterMission1Flag = false;
						alert("감사합니다. 응모가 완료 되었습니다.");
		            }
	            }else{
	            	alert(data.MSG);
	            }
	        },
        error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
   		});
}

function pdfDownload(){  

    var fileUrl="<spring:eval expression="@globalContext['SERVER_PATH']" />/resources/pdf/"+$(".pdf").val();
    var fileNm= $(".pdf").val();
	
	location.href="/ace/download?fileUrl=" + encodeURIComponent(fileUrl) + "&fileNm=" + encodeURIComponent(fileNm);
}
  
function setCookie( name, value ){ 
	var todayDate = new Date(); 
	todayDate.setDate( todayDate.getDate() + 1 ); 
	document.cookie = name + "=" + escape( value ) + ";"; 
}

function getCookie(sName) {
    var aCookie = document.cookie.split("; ");

    for (var i=0; i < aCookie.length; i++) {
        var aCrumb = aCookie[i].split("=");

        if (sName == aCrumb[0]){
            return unescape(aCrumb[1]);
        }
    }
    return null;
}

function goLogin(){

	window.location.href = "<spring:eval expression="@globalContext['GOJLS_URL']" />/login?from=FLLI&preURL=<spring:eval expression="@globalContext['SITE_URL']" />/ace/map";
}
function goLogout(){

	window.location.href = "<spring:eval expression="@globalContext['GOJLS_URL']" />/logout?preURL=<spring:eval expression="@globalContext['SITE_URL']" />/ace/map";
}

$(document).ready(function(){ 
	 
	if(getCookie("misisonNum") == "1"){
		if(getCookie("mapSeq") != null && getCookie("mapSeq") != ''){
	 
			setMissionMap('', getCookie("mapSeq"));	
			setCookie("mapSeq",  "");
			setCookie("misisonNum",  "");
			setCookie("enterMission2Flag",  false); 
		}	
		window.location.href = "#s3"; 
	}else if(getCookie("misisonNum") == "2"){

		enterMission2Flag = getCookie("enterMission2Flag");
		setCookie("mapSeq",  "");
		setCookie("misisonNum",  "");
		setCookie("enterMission2Flag",  false); 
		window.location.href = "#s7"; 
		
	}

	if('${mapUserInfo.mission2Cnt}' > 0 ){ //한번 응모이력이 있으면 영상 다시 안봐도 됨
		enterMission2Flag = true;	
	}
	
});

// 퀵메뉴  
function moveQuick() {
	$(".btn_quick").click(function(){
		var position = $(".s3").offset(); alert(1);
		$('html,body').animate({ scrollTop: position.top }, 100);
	})
	$(".btn_quick01").click(function(){
		var position01 = $(".s7").offset();
		$('html,body').animate({ scrollTop: position01.top }, 100);
	})
	
}; 
 
 
//레이어 
function layerPop() {
	$("html").css("overflow-y","auto");

	$(".layer_cont .btn_confirm").click(function(){
		$(".layer").fadeOut("fast");
		$("body").unbind('touchmove');
		$("html").css("overflow-y","auto");
	})

};

 
 
</script>
</head>
<body>

<iframe id="fileDownIE" style='visibility:hidden' src="" width="1" height="1"></iframe>
<a style="display:none;" id="fileDown" href="#" download="#"></a>

<div id="container"> 
     <div class="quick_wrap">
        <ul>
            <li><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/sky_01.png"/></li>
            <li><a href="#s3" class="btn_quick"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/sky_02.png" /></a></li>
            <li><a href="#s7" class="btn_quick01"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/sky_03.png" /></a></li>
            <li><a href="#s1" class="btn_quick02"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/sky_04.png" /></a></li>
        </ul>
    </div>
  
    <div id="flash1_1" style="display:;">
        <div id="sr_wrap">
            <div id="s1">
                <div class="begibox">
                    <div class="cont1">
                        <div class="check1">
                            <b class="tit">관심지수</b>
                            <b class="number" id="viewCnt">${viewCnt}건</b>
                        </div>
                    </div>
                    <div class="cont2">
                        <div class="check2">
                            <b class="tit">MAP암호풀기 성공</b>
                            <b class="number" id="mission1Cnt">${mission1Cnt}건</b>
                        </div>
                    </div>
                </div> 
                <div class="date">
                  대상 : 정상어학원 회원 전체 대상  /  미션기간 : 12월 18일(월) ~ 1월 7일(일)
                </div>  
            </div>
            
            <div id="s2">
                <p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/top_bg_01.jpg" /></p>
            </div>   
            
            <div id="s3" class="section">
                <div class="content">
                    <p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/event_01.jpg" /></p>
                    <div class="mapcode_table">
                        <div class="pset">
                            <li>
                                <span id="goods1Cnt">ABC마트 상품권 5만원<b>${goods1Cnt}명 응모 중</b></span>
                                <span id="goods2Cnt">영화 2인티켓 <b>${goods2Cnt}명 응모 중</b></span>
                                <span id="goods3Cnt">베스킨라빈스 파인트 <b>${goods3Cnt}명 응모 중</b></span>
                                <span id="goods4Cnt">카카오프렌즈 인덱스노트 <b>${goods4Cnt}명 응모 중</b></span>
                            </li>
                        </div>   
                        <div class="name">
                          <h1><c:if test="${mapUserInfo.deptNm==null}">-</c:if>${mapUserInfo.deptNm}</h1>
                          <h2>${mapUserInfo.userNm}</h2>
                          
						 <c:if test="${isCookies==1}">
                             <button type="button" class="gray" onclick="javascript:goLogout();"><span>로그아웃</span></button>
						 </c:if> 
						 <c:if test="${isCookies==0}">
                             <button type="button" class="yellow" onclick="javascript:goLogin();"><span>로그인</span></button>
						 </c:if>
                        </div>
                             
                        <div class="stamp" id="stamp1">
                            <c:if test="${mapUserInfo.selBookNm1 !='-' && mapUserInfo.selBookNm1 != null}">
	                            <div class="clear">
	                                <h4><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/clear.png" /></h4>
	                            </div>  
                            </c:if>
                            <h1>첫번째 도전 MAP Code</h1>
                            <h2>${mapUserInfo.selBookNm1}</h2>
                            <c:if test="${mapUserInfo.selBookNm1 !='-' && mapUserInfo.selBookNm1 != null}">
                            <p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/${mapUserInfo.selGoodsFg1}.png"></p> <!--   ice  mega abc note question -->
                            </c:if>
                            <c:if test="${mapUserInfo.selBookNm1 =='-' || mapUserInfo.selBookNm1 == null}">
                            <p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/question.png"></p> <!--   ice  mega abc note question -->
                            </c:if>
                            <h3>응모한 선물</h3>
                        </div>  
                              
                        <div class="stamp" id="stamp2">
                            <c:if test="${mapUserInfo.selBookNm2 !='-' && mapUserInfo.selBookNm2 != null}">
	                            <div class="clear">
	                                <h4><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/clear.png" /></h4>
	                            </div>  
                            </c:if>
                            <h1>두번째 도전 MAP Code</h1>
                            <h2>${mapUserInfo.selBookNm2}</h2>
                            <c:if test="${mapUserInfo.selBookNm2 !='-' && mapUserInfo.selBookNm2 != null}">
                            <p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/${mapUserInfo.selGoodsFg2}.png"></p> <!--   ice  mega abc note question -->
                            </c:if>
                            <c:if test="${mapUserInfo.selBookNm2 =='-' || mapUserInfo.selBookNm2 == null}">
                            <p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/question.png"></p> <!--   ice  mega abc note question -->
                            </c:if>
                            <h3>응모한 선물</h3>
                        </div> 
                        
                        <div class="stamp" id="stamp3">
                            <c:if test="${mapUserInfo.selBookNm3 !='-' && mapUserInfo.selBookNm3 != null}">
	                            <div class="clear">
	                                <h4><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/clear.png" /></h4>
	                            </div>  
                            </c:if>
                            <h1>세번째 도전 MAP Code</h1>
                            <h2>${mapUserInfo.selBookNm3}</h2>
                            <c:if test="${mapUserInfo.selBookNm3 !='-' && mapUserInfo.selBookNm3 != null}">
                            <p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/${mapUserInfo.selGoodsFg3}.png"></p> <!--   ice  mega abc note question -->
                            </c:if>
                            <c:if test="${mapUserInfo.selBookNm3 =='-' || mapUserInfo.selBookNm3 == null}">
                            <p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/question.png"></p> <!--   ice  mega abc note question -->
                            </c:if>
                            <h3>응모한 선물</h3>
                        </div> 
                    </div>
                </div>
            </div>   
            
            <div id="s4" class="section">
                <div class="content">
                    <div class="mapcode_mission">
                        <div class="history">
                            내가 공부해온 모든 것이….<br>
                            꼭 짜여진 계획처럼 반복해서… 나타난다…<br>
                            헉… 모든 게 연결되어 있었다.. <br>
                            그 비밀을 풀 수 있는 사람은 오직 나… <br>
                            어느 날 문득 펼친 MAP Series 책에서  MAP Code가 보이기 시작하는데…
                        </div>
                        <div class="bt">
                            <h1>절대秀능MAP</h1>
                            <h2>독해 ∙ VOCA</h2>
                            <span><a href="javascript:setMissionMap('1', '');"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_01.png"
                                onmouseover="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_01_o.png'" 
                                onmouseout="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_01.png'"></a></span>
                            <span><a href="javascript:setMissionMap('2', '');"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_02.png"
                                onmouseover="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_02_o.png'" 
                                onmouseout="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_02.png'"></a></span>
                            <h3>난이도 <img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/star_1.png"></h3>
                            <h4>추천레벨 : MA1,MA3,A3,V-S,V-H</h4>
                        </div> 
                        <div class="bt">
                            <h1>ACE MAP Series</h1>
                            <h2>Reading∙Listening∙VOCA</h2>
                            <span><a href="javascript:setMissionMap('3', '');"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_03.png"
                                onmouseover="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_03_o.png'" 
                                onmouseout="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_03.png'"></a></span>
                            <span><a href="javascript:setMissionMap('4', '');"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_04.png"
                                onmouseover="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_04_o.png'" 
                                onmouseout="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_04.png'"></a></span>
                            <h3>난이도 <img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/star_2.png"></h3>
                            <h4>추천레벨 : MA0,A0,A1PA1,PA3</h4>
                        </div> 
                        <div class="bt">
                            <h1>Total English MAP</h1>
                            <h5>-</h5>
                            <span><a href="javascript:setMissionMap('5', '');"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_03.png"
                                onmouseover="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_03_o.png'" 
                                onmouseout="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_03.png'"></a></span>
                            <span><a href="javascript:setMissionMap('6', '');"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_05.png"
                                onmouseover="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_05_o.png'" 
                                onmouseout="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_05.png'"></a></span>
                            <span><a href="javascript:setMissionMap('7', '');"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_06.png"
                                onmouseover="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_06_o.png'" 
                                onmouseout="this.src='<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/bt_06.png'"></a></span>
                            <h3>난이도 <img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/star_3.png"></h3>
                            <h4>추천레벨 : B0,B1,B3(CHESS 학생 및 전체 GOJLS회원)</h4>
                        </div> 
                    </div>
                </div>
            </div>
            
            <div id="s12" class="section">
                <div class="content">
                    <div class="quest" style="display:">
                        <img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/black.gif">
                    </div>
                  
                    <div class="question" style="display:none" >
                        <div class="subtit wide">
                            <h4>1번단서<p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/arrow.png"></p></h4>
                            <div class="copy">
                                <h5 id="title1"></h5>
                                <h6 id="question1"></h6>
                            </div>
                        </div>
                     
                        <div class="subtit wide">
                            <h4>2번단서<p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/arrow.png"></p></h4>
                            <div class="copy">
                                <h5 id="title2"></h5>
                                <h6 id="question2"></h6>
                            </div>
                        </div>
                     
                        <div class="subtit wide">
                            <h4>3번단서<p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/arrow.png"></p></h4>
                            <div class="copy">
                                <h5 id="title3"></h5>
                                <h6 id="question3"></h6>
                            </div>
                        </div>
                     
                        <div class="subtit wide">
                            <h4>4번단서<p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/arrow.png"></p></h4>
                            <div class="copy">
                                <h5 id="title4"></h5>
                                <h6 id="question4"></h6>
                            </div>
                        </div>
                    </div>
                    <div class="pdf" style="display:none">
                        <button type="button" class="yellow" onclick="pdfDownload();"><span>PDF</span></button>
                    </div>
                </div>
            </div>
            

            <div id="s11" class="section">
                <div class="content">
                   <div class="mapcode">
                      <input type="text" id="mapcodeText" style="ime-mode:disabled;text-transform:lowercase" onkeydown="delSpace(this);" readonly  />
                      <button type="button" id="btnAnswer" class="orange" onclick="endAlert()"><span id="spanAnswer">Send</span></button>
                   </div> 
                </div>
            </div>
           
            <div id="s5" class="section">
                <div class="content">
                    <div class="history">
                       <div class="enter_bt">
                            <a href="javascript:endAlert();"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/enter_bt.png" /></a>
                       </div> 
                       <div class="bt">
                            <span><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/gift_01.jpg"></span>
                            <div class="radio_box">
                                <input type="radio" name="rd_mission1" value="1" style="width:25px; height:25px;">
                            </div> 
                        </div> 
                        <div class="bt">
                            <span><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/gift_02.jpg"></span>
                            <div class="radio_box">
                                <input type="radio" name="rd_mission1" value="2" style="width:25px; height:25px;">
                            </div> 
                        </div> 
                        <div class="bt">
                            <span><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/gift_03.jpg"></span>
                            <div class="radio_box">
                                <input type="radio" name="rd_mission1" value="3" style="width:25px; height:25px;">
                            </div> 
                        </div> 
                        <div class="bt">
                            <span><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/gift_04.jpg"></span>
                            <div class="radio_box">
                                <input type="radio" name="rd_mission1" value="4" style="width:25px; height:25px;">
                            </div> 
                        </div> 
                    </div>
                </div>
            </div>
            
            <div id="s6">
                <p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/top_bg_03.gif" /></p>
            </div>   
            
            <div id="s7" class="section">
               <div class="content">
                    <p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/event_04.gif" /></p>
                    <div class="video">
                        <div id="player"> </div>
                        <!--  iframe src="http://www.youtube.com/embed/sXfWTyXHVQE?autoplay=0&amp;showinfo=0&amp;autohide=2&amp;rel=0&wmode=transparent" scrolling="no" frameborder="0" marginwidth="0" marginheight="0" width="1000" height="550"></iframe -->
                    </div>
                    <div class="radio_box">
                        <input type="radio"  name="rd_mission2" value="1" style="width:30px; height:30px;" ><label class="answer"> 슈퍼 그뤠잇!</label>
                        <input type="radio"  name="rd_mission2" value="2" style="width:30px; height:30px;" ><label class="answer"> 해피 뉴이어 그뤠잇!</label>
                    </div>
                    <div class="enter_bt">
                        <a href="javascript:endAlert();"><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/enter_bt.png" /></a>
                    </div>
                    <div class="cacaogift">
                        <span id="mission2Cnt">카카오톡 이모티콘 <b>${mission2Cnt}명 응모 중</b></span>
                        <img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/event_07.gif" />
                    </div>  
                </div>
            </div>
            
            <div id="s8">
                <p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/top_bg_02.gif" /></p>
            </div>
            
            <div id="s9" class="section">
                <div class="content">
                   <p><img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/event_05.gif" /></p>
                </div>
            </div>
            
            <div id="s10" class="">
                <div class="content">
                   <img src="<spring:eval expression="@globalContext['IMG_ROOT_SSL']" />/img/event/20171120_event/event_06.gif" />
                </div>
            </div>
            
        </div>
    </div>
</div>  














</body>
</html>