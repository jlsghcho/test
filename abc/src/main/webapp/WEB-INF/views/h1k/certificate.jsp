<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=700, user-scalable=yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="theme-color" content="#1278bc">
<title> 정상어학원 </title>

<%-- Hannibal: 추적코드 적용 (2018.05.10) --%>
<jsp:include page="../common/statistics.jsp"/>

<link rel="stylesheet" href="<spring:eval expression="@globalContext['IMG_ROOT']" />/css/event/20170512_event.css" type="text/css">
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON']" />/js/jquery-1.9.1.min.js"></script>
<style type="text/css" media="print"> 
@media print {
	@page {
		size:auto;
		margin-top:2.5cm;
		margin-right:2cm;
		margin-bottom:1.5cm;
		margin-left:2cm;
	}
	html, body { border:0; margin:0; padding:0; }
	#printable { display:block; }
	#non-printable { display:none; }
}
</style>
<script language="Javascript">
function goPrint(){
	$(".footer").attr("style","display:none");
	window.print();
	$(".footer").attr("style","display:block");	
}
</script>
</head>
<body>
<!-- popcont -->
<div class="popcont">
	<div class="beginner">
		<div class="begibox">
			<div class="print">
                <img src="<spring:eval expression="@globalContext['IMG_ROOT']" />/img/event/thousand/${param.stampStr}/<c:choose><c:when test="${param.term==1}">03_</c:when><c:when test="${param.term==2}">06_</c:when><c:when test="${param.term==3}">09_</c:when><c:when test="${param.term==4}">12_</c:when><c:otherwise></c:otherwise></c:choose>certificate_top.jpg" width="100%">
				<b class="tit"><b>${param.userNm}</b>학생 <c:choose><c:when test="${param.term==1}">250</c:when><c:when test="${param.term==2}">500</c:when><c:when test="${param.term==3}">750</c:when><c:when test="${param.term==4}">1000</c:when><c:otherwise> </c:otherwise></c:choose>시간 영어노출 달성</b>
				<p>위 학생은 정상어학원에서 함께하는 1000시간 영어노출 캠페인에 참여하여<br>
				정상어학원의 다양한 영어노출 프로그램으로 밀도 높은 영어노출활동에 참여하였으며<br>
				가정에서 함께 영어노출환경을 실현하여 총 <c:choose><c:when test="${param.term==1}">250</c:when><c:when test="${param.term==2}">500</c:when><c:when test="${param.term==3}">750</c:when><c:when test="${param.term==4}">1000</c:when><c:otherwise> </c:otherwise></c:choose>시간 영어노출을 완성하였습니다.<br>
				이에, 이 인증서를 발급 합니다.</p>
				<div class="text">
					<dd>자유로운 영어구사 능력을 향상시키는 영어노출 시간 극대화</dd>
					<dd><b>1000시간 영어노출 캠페인 & 정상어학원</b></dd>
				</div>
			</div>
		</div>	
	</div>		
	<div class="footer">
		<button type="button" class="yellow" onclick="goPrint();"><span>인쇄</span></button>
		<button type="button" class="cancel" onclick="window.close();"><span>닫기</span></button>
	</div>	
</div>	
</body>
</html>