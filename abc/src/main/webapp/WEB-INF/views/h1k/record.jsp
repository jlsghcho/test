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
<%-- Hannibal: 추적코드 적용 (2018.05.10) --%><script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
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
	
	$(document).ready(function(){
		if("${param.surveySysCode}" != ""){
			$("#surveySysCode").val("${param.surveySysCode}");
			if("${param.surveySysCode}" == "M03M05"){
				$("#term").val("1");				
			}else if("${param.surveySysCode}" == "M06M08"){
				$("#term").val("2");
			}else if("${param.surveySysCode}" == "M09M11"){	
				$("#term").val("3");	
			}else if("${param.surveySysCode}" == "M12M02"){	
				$("#term").val("4");			
			}
		}else{
			$("#surveySysCode").val("M06M08");
			$("#term").val("2");
		}
			
		self.focus();
		selectUserSurveyInfo();

		<c:if test="${cookieProp.GT_USER_TYPE == 'US6002'}">
		$("input:radio[name='childs']").change(function() {
			changeUserInfo($(this).val(), $(this).parent().text());
		});
		</c:if>
	});
	
	$(function(){		
		$("#surveySysCode").on("change", function(){
			if($("#surveySysCode option:selected").val() == "M03M05"){
				$("#term").val("1");			
			}else if($("#surveySysCode option:selected").val() == "M06M08"){
				$("#term").val("2");		
			}else if($("#surveySysCode option:selected").val() == "M09M11"){	
				$("#term").val("3");	
			}else if($("#surveySysCode option:selected").val() == "M12M02"){	
				$("#term").val("4");						
			}
			selectUserSurveyInfo();		
		});
	});
	
	function addTermStr(){
		var selterm = $("#term").val(); 
		switch(Number(selterm)) {
		    case 1:
		    	termStr = "2020년 3월~5월";
		        break;
		    case 2:
		    	termStr = "2020년 6월~8월";
		        break;
		    case 3:
		    	termStr = "2020년 9월~11월";
		        break;
		    case 4:
		    	termStr = "2020년 12월~2021년 2월";
		        break;
		    default:
		    	termStr = "";
		}
		
		$(".check #termstr").html(termStr);
		$(".finish #termstr").html(termStr);
	}
	

	function changeUserInfo(seq, nm){		
		$("#userSeq").val(seq);
		$("#userNm").val(nm);

		selectUserSurveyInfo();
	}	

	function selectUserSurveyInfo(){
		var selseq = $("#h1kEventSeq").val(); 
		var selterm = $("#term").val(); 
		var selsyscode = $("#surveySysCode option:selected").val();
		var selUserSeq = $("#userSeq").val(); 
		var selNm = $('#userNm').val(); 
		var termStr = "";
		addTermStr();		
		/* 이전 텀일경우 selseq 이전 코드로 변경 */
		//if(selterm > 1){
		//	selseq = 3;	
		//
		//}
		$.ajax({
			type:"GET",
			dataType:"json",
			url:"/h1k/api/"+selUserSeq+"/"+selseq+"/"+selsyscode+"/survey",
			success:function(data){
				if (data.result == "success"){
					if(data.surveyInfo != null){
						if(data.surveyInfo.surveyFinishYn == "Y"){
							$(".finish .tit span").html(data.surveyInfo.regTs);
							$(".finish #time").html(data.surveyInfo.addTime+"시간");
							$(".finish .number_copy span").html(selNm);
														
							$(".check").attr("style","display:none");
							$(".copy").attr("style","display:none");	
							$(".finish").attr("style","display:block");
							//$(".footer").attr("style","display:block");									
						}
					}else{
						$(".check").attr("style","display:block");
						$(".copy").attr("style","display:block");	
						$(".finish").attr("style","display:none");
						//$(".footer").attr("style","display:none");						
					}
				} else {
					alert(data.msg);
				}
			},error:function(xhr, ajaxOpts, thrownErr) {
				alert("영어노출정보 가져오기에 실패하였습니다. [" + xhr.status + " " + thrownErr + "]");
			}
		});
	}
	
	function openMain(){
		$("#h1kform").attr("action","/h1k/main");
		$("#h1kform").submit();
	}
	
	function openSurvey(){
		<c:choose>
		<c:when test="${nowDate < 20200901 and nowDate >= 20200818}">
			var selsyscode = $("#surveySysCode option:selected").val();
			if(selsyscode == "M06M08"){
				$("#h1kform").attr("action","/h1k/survey");
				$("#h1kform").submit();				
			}else{
				alert("가정에서의 영어노출 입력 접수 기간이 아닙니다.");				
			}
		</c:when>
		<c:when test="${nowDate >= 20200901 or nowDate < 20200818}">
			alert("가정에서의 영어노출 입력 접수 기간이 아닙니다.");
		</c:when>	
		</c:choose>
	}
</script>
</head>
<body>

<!-- POPUP SIZE : 850 * x -->
<form name="h1kform" id="h1kform">
	<input type="hidden" name="h1kEventSeq" id="h1kEventSeq" value="4"/>
	<input type="hidden" name="term" id="term" value="${param.term}"/>
	<input type="hidden" name="userSeq" id="userSeq" value="${userInfo.userSeq}"/>
	<input type="hidden" name="userNm" id="userNm" value="${userInfo.userNm}"/>
</form>
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
            <div class="pset">
			<c:if test="${cookieProp.GT_USER_TYPE == 'US6002'}">
			<c:forEach var="list" items="${childList}"  varStatus="i">
			<label><input type="radio" name="childs" value="${list.userSeq}" <c:if test="${list.userSeq == userInfo.userSeq}">checked</c:if>> <span>${list.userNm}</span></label>
			</c:forEach>
            </c:if>
			<select class="bank" id="surveySysCode" title="기간">
               <option value="M03M05">2020년 3월~5월 입력</option>
               <option value="M06M08">2020년 6월~8월 입력</option>
               <option value="M09M11">2020년 9월~11월 입력</option>
               <option value="M12M02">2020년 12월~2021년2월 입력</option>
			</select>
			<c:if test="${cookieProp.GT_USER_TYPE == 'US6001'}">
            <p class="time"><b>${userInfo.userNm}</b> 학생의 가정에서의 영어노출시간 입력</p>
            </c:if>
            </div>
            
			<div class="begibox">
				 <!-- image size : 398*298 -->
			 	<div class="cont">
			       <div class="check" style="display:none">
                        <b class="number">가정에서 이루어진 영어노출 시간을 입력하고</b>
                        <p class="number_copy">1000시간 영어노출 완성을 함께 만들어 주세요</p>
                        <p class="copy_date"><b><span id="termstr">2020년 6월 ~ 2020년 8월 입력</span>까지</b>  가정에서 이루어진 영어노출 시간을</p>
                    	<p class="copy_sub">1분이면 완성하는 간단한 설문으로 계산할 수 있습니다.</p>
                        <div class="button">
                        	<a href="javascript:openSurvey()"><button type="button" class="yellow"><span>가정에서 이루어진 영어노출 시간 입력하기 </span></button></a>
                        	<!--<button type="button" class="yellow"><span>설문 입력 기간이 아닙니다.</span></button>-->
                        </div>
                    </div>
			        <div class="finish" style="display:none">
						<b class="tit">가정에서 이루어진 영어노출 시간 설문이 <span></span>에 <b>완료</b>되었습니다.</b>
                        <b class="number"><span id="termstr">2020년 6월 ~ 2020년 8월 입력</span> 기간</b>
                        <b class="number_copy"><span>${userInfo.userNm}</span> 학생의<br>가정에서의 영어노출시간은 <b id="time">0시간</b> 입니다. </b>
                    	<p class="copy_sub">(완료된 가정에서의 영어노출 시간은 1일 후에 학생의 1000시간 영어노출 누적시간에 적용됩니다.)</p>
                        <div class="button">
                        	<a href="javascript:openSurvey()"><button type="button" class="yellow"><span>다시 설문하기 </span></button></a>
                        	<!--<button type="button" class="yellow"><span>설문 입력 기간이 아닙니다.</span></button>  -->
                        </div>
                    </div>  
                </div>	
            </div>
		 </div>
         <div class="copy" style="display:none">
			<h5 class="small">안내사항</h5>
			<dl class="wrap">
				<dd>입력 완료된 가정에서의 영어노출 시간은 학생의 1000시간 영어노출 누적시간에 포함 됩니다.</dd>
				<dd>입력된 내용은 다시 설문하기를 통해 수정이 가능합니다. </dd>
				<dd>입력완료 및 수정된 가정에서의 영어노출 시간은 입력일 기준 +1일 후에 학생의 1000시간 영어노출 누적시간에 적용됩니다. </dd>
			</dl>
		 </div>
	</div>	
</div>	
<div class="footer">
	<button type="button" class="cancel" onclick="self.close();"><span>닫기</span></button>
</div>
</body>
</html>