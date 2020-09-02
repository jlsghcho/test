<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=1024, user-scalable=yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="theme-color" content="#1278bc">
<title> 정상어학원 </title>

<%-- Hannibal: 추적코드 적용 (2018.05.10) --%>
<jsp:include page="../common/statistics.jsp"/>

<link rel="stylesheet" href="<spring:eval expression="@globalContext['IMG_ROOT']" />/css/event/20170512_event.css" type="text/css">
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON']" />/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
<!--
	$.ajaxSetup({cache:false});
	
	$(document).ready(function(){
		self.focus();
		
		<c:choose>
		<c:when test="${nowDate < 20170608}">
			$("#term").val("1");
		</c:when>
		<c:when test="${nowDate >= 20170608}">
			$("#term").val("2");
		</c:when>	
		</c:choose>
		
		selectUserTimeInfo();

		$("input:radio[name='childs']").change(function() {
			changeUserInfo($(this).val(), $(this).parent().text());
		});
	});

	function changeUserInfo(seq, nm){	
		$("#userSeq").val(seq);
		$("#userNm").val(nm);

		selectUserTimeInfo();
	}	

	function selectUserTimeInfo(){
		var selseq = $('#h1kEventSeq').val(); 
		var selterm = $('#term').val();	
		var selUserSeq = $('#userSeq').val(); 
		var stampCnt = 0;
		var termStr = "";
		var stampStr = "";
		$.ajax({
			type:"GET",
			dataType:"json",
			url:"/h1k/api/"+selUserSeq+"/"+selseq+"/"+selterm+"/info",
			success:function(data){
				if (data.result == "success"){
					if(data.timeInfo != null){		
						$(".cont1 .number b").html(data.timeInfo["totalTime"]);
						$(".cont2 .number b").html(data.timeInfo["term"+selterm]);
					}else{		
						$(".cont1 .number b").html(0);
						$(".cont2 .number b").html(0);						
					}
					switch(Number(selterm)) {
					    case 1:
					    	termStr = "기간 : 2017.03 ~ 2017.05";
					        break;
					    case 2:
					    	termStr = "기간 : 2017.06 ~ 2017.08";
					        break;
					    case 3:
					    	termStr = "기간 : 2017.09 ~ 2017.11";
					        break;
					    case 4:
					    	termStr = "기간 : 2017.12 ~ 2018.02";
					        break;
					    default:
					    	termStr = "기간 : ";
					}
					
					$(".cont2 p").html(termStr);
					
					if(data.stampList != null){
						for(var i=0; i<data.stampList.length; i++){	

							switch(i) {
							    case 1:
							    	stampStr = "0607_";
							        break;
							    case 2:
							    	stampStr = "0901_";
							        break;
							    case 3:
							    	stampStr = "1201_";
							        break;
							    default:
							    	stampStr = "";
							}
							
							if(data.stampList[i]["STATE"] == "1"){
								stampCnt = stampCnt + 1;
								$("#sdd"+(i+1)).attr("style","display:block");
								$("#s"+(i+1)+" img").attr("src","<spring:eval expression="@globalContext['IMG_ROOT']" />/img/event/20170512_event/"+stampStr+"stamp_on.png");
							}else{
								$("#sdd"+(i+1)).attr("style","display:none");
								$("#s"+(i+1)+" img").attr("src","<spring:eval expression="@globalContext['IMG_ROOT']" />/img/event/20170512_event/stamp_off.png");								
							}			
						}
						$("#s0 b").html("- "+stampCnt+"개의 스탬프를 받았습니다.");
												
					}
				} else {
					alert(data.msg);
				}
			},error:function(xhr, ajaxOpts, thrownErr) {
				alert("영어노출정보 가져오기에 실패하였습니다. [" + xhr.status + " " + thrownErr + "]");
			}
		});
	}
	
	function openCertificatePop(term){
		var selUserNm = $("#userNm").val();
		var stampStr = "";

		switch(Number(term)) {
		    case 2:
		    	stampStr = "0607_";
		        break;
		    case 3:
		    	stampStr = "0901_";
		        break;
		    case 4:
		    	stampStr = "1201_";
		        break;
		    default:
		    	stampStr = "";
		}
		var url = "/h1k/certificate?userNm="+encodeURIComponent(selUserNm)+"&term="+term+"&stampStr="+stampStr;
		window.open(url, 'receipt', 'resizable=no scroll=no width=697, height=980');
		
	}
	
	function openRecord(){
		$("#h1kform").attr("action","/h1k/record");
		$("#h1kform").submit();
	}
//-->
</script>
</head>
<body>

<!-- POPUP SIZE : 850 * x -->
<form name="h1kform" id="h1kform">
	<input type="hidden" name="h1kEventSeq" id="h1kEventSeq" value="1"/>
	<input type="hidden" name="surveySysCode" id="surveySysCode" value="M06M08"/>
	<input type="hidden" name="term" id="term" value="2"/>
	<input type="hidden" name="userSeq" id="userSeq" value="${userInfo.userSeq}"/>
	<input type="hidden" name="userNm" id="userNm" value="${userInfo.userNm}"/>
</form>
<div id="pop_confirm">
	
	<!-- popTitle -->
	<div class="poptitle">
		<h1>1000시간 영어노출 캠페인</h1>
        <h2><a href="http://www.gojls.com/etc/pop_event_1000.do" target="_blank"><img src="<spring:eval expression="@globalContext['IMG_ROOT']" />/img/event/20170512_event/banner.png"></a></h2>
	</div>

	
	<!-- popCont -->
	<div class="popcont">
		  <div class="beginner">
            <ol class="tnav">
				<li class="selected"><a>영어노출 누적시간 현황</a></li>
				<li><a href="javascript:openRecord()">가정에서의 영어노출시간 입력</a></li>
			</ol>
            <div class="pset">
			<c:if test="${cookieProp.GT_USER_TYPE == 'US6002'}">
			<c:forEach var="list" items="${childList}"  varStatus="i">
			<label><input type="radio" name="childs" value="${list.userSeq}" <c:if test="${list.userSeq == userInfo.userSeq}">checked</c:if>> <span>${list.userNm}</span></label>
			</c:forEach>
             </c:if>
			<c:if test="${cookieProp.GT_USER_TYPE == 'US6001'}">
            <p class="time"><b>${userInfo.userNm}</b> 학생의 영어노출 누적 시간</p>
             </c:if>
		 	 </div>

			 <div class="begibox">
				 <!-- image size : 398*298 -->
			 	<div class="cont1">
				    <div class="check1">
						<b class="tit">연간 누적 시간</b>
						<p>기간 : 2017.03 ~ 2018.02</p>
                        <b class="number"><b id="t1">0</b></b>
					</div>
			    </div>
				<div class="cont2">
				    <div class="check2">
						<b class="tit">기간별 누적 시간</b>
						<p>기간 : </p>
                        <b class="number"><b id="t2">0</b></b>
					</div>
			 	</div>
			 </div>
            
            
            <div class="pset">
				<p class="time" id="s0">기간별 목표 달성 스탬프 -<b> 0개의 스탬프를 받았습니다.</b></p>
		    </div>

	   		<div class="stamp" id="s1">
                <b class="tit">250hours</b>
				<p><img src="<spring:eval expression="@globalContext['IMG_ROOT']" />/img/event/20170512_event/stamp_off.png"></p>
                <dd id="sdd1">
                <button type="button" class="yellow" onclick="openCertificatePop(1)">
                <span>인증서보기</span>
                </dd>
            </div> 
            <div class="stamp" id="s2">
                <b class="tit">500hours</b>
		 		<p><img src="<spring:eval expression="@globalContext['IMG_ROOT']" />/img/event/20170512_event/stamp_off.png"></p>
                <dd id="sdd2" style="display:none">
                <button type="button" class="yellow" onclick="openCertificatePop(2)">
                <span>인증서보기</span>
                </dd>
            </div> 
            <div class="stamp" id="s3">
                <b class="tit">750hours</b>
				<p><img src="<spring:eval expression="@globalContext['IMG_ROOT']" />/img/event/20170512_event/stamp_off.png"></p>
                <dd id="sdd3" style="display:none">
                <button type="button" class="yellow" onclick="openCertificatePop(3)">
                <span>인증서보기</span>
                </dd>
            </div> 
            <div class="stamp" id="s4">
                <b class="tit">1000hours</b>
				<p><img src="<spring:eval expression="@globalContext['IMG_ROOT']" />/img/event/20170512_event/stamp_off.png"></p>
                <dd id="sdd4" style="display:none">
                <button type="button" class="yellow" onclick="openCertificatePop(4)">
                <span>인증서보기</span>
                </dd>
            </div> 
      </div>
      </div>
</div>			
</body>
</html>