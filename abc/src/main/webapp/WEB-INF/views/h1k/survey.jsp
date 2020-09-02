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
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
	if(!wcs_add) var wcs_add = {};
	wcs_add["wa"] = "49388429f1245c";
	wcs_do();
</script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="//www.googletagmanager.com/gtag/js?id=UA-109167413-2"></script>
<script>
	window.dataLayer = window.dataLayer || [];

	function gtag() { dataLayer.push(arguments); }

	gtag('js', new Date());

	gtag('config', 'UA-109167413-2');
</script>
<link rel="stylesheet" href="<spring:eval expression="@globalContext['IMG_ROOT']" />/css/event/20170512_event.css" type="text/css">
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON']" />/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
	$.ajaxSetup({cache:false});
	
	var sendYn = "Y";
	
	function calAddTime(){
		<c:choose>
		<c:when test="${nowDate < 20200901 and nowDate >= 20200818}">		
			if(!$('input:radio[name=q1]').is(':checked')||!$('input:radio[name=q2]').is(':checked')||!$('input:radio[name=q3]').is(':checked')){
				alert("문항을 모두 선택해주세요.");
			}else{
				var selseq = $('#h1kEventSeq').val(); 
				var selUserSeq = $('#userSeq').val();  

				var qno1 = Number($("input:radio[name='q1']:checked").val());
				var qno2 = Number($("input:radio[name='q2']:checked").val());
				var qno3 = Number($("input:radio[name='q3']:checked").val());
				var dap = (qno1 + qno2 + qno3) * 60;
				$("#addTime").val(dap);
				
				if(dap > 0){
					if(sendYn == "Y"){			
						sendYn = "N";
						
						$.ajax({
							type:"post",
							dataType:"json",
							url:"/h1k/api/"+selUserSeq+"/"+selseq+"/survey/save",
							data:$("#h1kform").serialize(),
							success:function(data){
								if (data.result == "success"){
									if(data.surveyInfo != null){
										if(data.surveyInfo.surveyFinishYn == "Y"){
											$(".check").attr("style","display:none");
											$(".copy").attr("style","display:none");	
											$(".finish").attr("style","display:block");
											$(".footer").attr("style","display:block");									
										}
									}else{
										$(".check").attr("style","display:block");
										$(".copy").attr("style","display:block");	
										$(".finish").attr("style","display:none");
										$(".footer").attr("style","display:none");						
									}
									goFinish();
								} else {		
									sendYn = "Y";
									alert(data.msg);
									goFinish();
								}
							},error:function(xhr, ajaxOpts, thrownErr) {
								sendYn = "Y";
								alert("영어노출정보 등록중 문제가 발생했습니다.[" + xhr.status + " " + thrownErr + "]");
							}
						});	
					}else{
						alert("저장중입니다.");
					}					
				}else{
					alert("추가될 시간이 0입니다. 다시 선택해 주세요.");					
				}		
			}
		</c:when>
		<c:when test="${nowDate >= 20200901 or nowDate < 20200818}">
			alert("가정에서의 영어노출 입력 접수 기간이 아닙니다.");
		</c:when>	
		</c:choose> 
	}
	
	function calPreView(){
		if(!$('input:radio[name=q1]').is(':checked')||!$('input:radio[name=q2]').is(':checked')||!$('input:radio[name=q3]').is(':checked')){
			alert("문항을 모두 선택해주세요.");
		}else{
			var qno1 = Number($("input:radio[name='q1']:checked").val());
			var qno2 = Number($("input:radio[name='q2']:checked").val());
			var qno3 = Number($("input:radio[name='q3']:checked").val());
			var dap = (qno1 + qno2 + qno3) * 60;
			//alert(qno1+"|"+qno2+"|"+qno3+"|"+dap);
			var hdap = Math.floor(dap/60);
			
			$("#time").html(hdap+"시간");
			$(".check .copy_survey").attr("style","display:block");
		}
	}
	
	function openMain(){
		$("#h1kform").attr("action","/h1k/main");
		$("#h1kform").submit();
	}
	
	function goFinish(){
		$("#h1kform").attr("action","/h1k/record");
		$("#h1kform").submit();		
	}
</script>
</head>
<body>

<!-- POPUP SIZE : 850 * x -->
<form name="h1kform" id="h1kform">
	<input type="hidden" name="h1kEventSeq" id="h1kEventSeq" value="4"/>
	<input type="hidden" name="surveySysCode" id="surveySysCode" value="M06M08"/>
	<input type="hidden" name="term" id="term" value="${param.term}"/>
	<input type="hidden" name="userSeq" id="userSeq" value="${userInfo.userSeq}"/>
	<input type="hidden" name="addTime" id="addTime" value=""/>
<div id="pop_confirm">
	
	<!-- popTitle -->
	<div class="poptitle">
		<h1>1000시간 영어노출 캠페인</h1>
        <h2><a href="/1000hours/intro" target="_blank"><img src="<spring:eval expression="@globalContext['IMG_ROOT']" />/img/event/20170512_event/banner.png"></a></h2>
	</div>
	<!-- popCont -->
	<div class="popcont">
         <div class="beginner">
            <ol class="tnav">
				<!-- <li><a href="javascript:openMain()">영어노출 누적시간 현황</a></li> -->
				<li class="selected"><a>가정에서의 영어노출시간 입력</a></li>
			</ol>
            
			<div class="begibox">
				 <!-- image size : 398*298 -->
			 	<div class="cont">
				    <div class="check">					
						<dl class="wrap">
							<dd>본 설문은 가정에서 이루어진 영어노출 시간을 자동계산 하기 위해 이루어지는 설문입니다.</dd>
							<dd>본 설문결과로 <c:choose><c:when test="${param.term==1}">2020년 3월부터 5월</c:when><c:when test="${param.term==2}">2020년 6월부터 8월</c:when><c:when test="${param.term==3}">2020년 9월부터 11월</c:when><c:when test="${param.term==4}">2020년 12월부터 2021년 2월</c:when><c:otherwise> </c:otherwise></c:choose>까지 가정에서 이루어진 영어노출 시간을 산출하여 학생의 1000시간 영어노출 누적시간에 반영합니다.</dd>
							<dd>정상어학원의 숙제 및 온라인학습 외 가정에서 추가로 이루어진 영어노출활동에 대해 선택해 주세요.</dd>
						</dl>		
	                    <dl class="survey">
							<dt>1. <c:choose><c:when test="${param.term==1}">2020년 3월~2020년 5월</c:when><c:when test="${param.term==2}">2020년 6월~2020년 8월</c:when><c:when test="${param.term==3}">2020년 9월~2020년 11월</c:when><c:when test="${param.term==4}">2020년 12월~2021년 2월</c:when><c:otherwise> </c:otherwise></c:choose> 기간, 영화(영어)/애니메이션(영어) 등을 몇 회 관람 하셨나요?</dt>
							<dd><input type="radio" name="q1" value="0"/> 없음</dd>
	                        <dd><input type="radio" name="q1" value="2"/> 1회 관람</dd>
	                        <dd><input type="radio" name="q1" value="4"/> 2회 이상 관람</dd>
						</dl>  
	                    <dl class="survey">
							<dt>2. <c:choose><c:when test="${param.term==1}">2020년 3월~2020년 5월</c:when><c:when test="${param.term==2}">2020년 6월~2020년 8월</c:when><c:when test="${param.term==3}">2020년 9월~2020년 11월</c:when><c:when test="${param.term==4}">2020년 12월~2021년 2월</c:when><c:otherwise> </c:otherwise></c:choose> 기간, 가정에서 추가적인 영어CD / 영어음악 청취 등의 노력으로 영어노출시간을 확대한 적이 있나요? </dt>
							<dd><input type="radio" name="q2" value="0"/> 없음</dd>
	                        <dd><input type="radio" name="q2" value="2"/> 1회 영어노출시간 확대</dd>
	                        <dd><input type="radio" name="q2" value="4"/> 2회이상의 영어노출 확대</dd>
	                        </dd>
						</dl> 
	                    <dl class="survey">
							<dt>3. 위 1~2번 설문 외 전화영어/ 온라인 복습/ 영어 책 읽기 등.. 기타 활동으로 추가한 영어노출 시간이 있나요?</dt>
							<dd><input type="radio" name="q3" value="0"/> 없음</dd>
	                        <dd><input type="radio" name="q3" value="2"/> 2시간 영어노출 시간 추가</dd>
	                        <dd><input type="radio" name="q3" value="4"/> 4시간 영어노출 시간 추가</dd>
						</dl> 
	                    <div class="button">
	                      <button type="button" class="yellow" onclick="calPreView()"><span>설문결과 미리 보기</span></button>
	                    </div>
	                    <p class="copy_survey" style="display:none">설문에 의해 계산된 <c:choose><c:when test="${param.term==1}">2020년 3월 ~ 5월</c:when><c:when test="${param.term==2}">2020년 6월 ~ 8월</c:when><c:when test="${param.term==3}">2020년 9월 ~ 11월</c:when><c:when test="${param.term==4}">2020년 12월~2021년 2월</c:when><c:otherwise> </c:otherwise></c:choose> 기간<br> <b>${userInfo.userNm}</b> 학생의 가정에서 추가된 영어노출 시간은 <b id="time">0시간</b> 입니다.</p>
                    </div>
                </div>
            </div>
		 </div>
	</div>	
</div>	
		

<div class="footer">
	<button type="button" class="finish" onclick="calAddTime()"><span>설문완료</span></button>
    <button type="button" class="finish" onclick="goFinish()"><span>설문취소</span></button>
</div>

</form>
</body>
</html>