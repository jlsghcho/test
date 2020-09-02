<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="Ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=1202, user-scalable=yes">
	<meta http-equiv="Pragma" content="no-cache">
	
	<title> 정상어학원 </title>
	<title> 250 시간 영어 미션 달성 </title>

	<%-- Hannibal: 추적코드 적용 (2018.05.10) --%>
	<!-- jsp:include page="../common/statistics.jsp" / -->

	<link type="text/css" rel="stylesheet" media="all" href="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/css/event/20200825_main.css?7104128"/>
	<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_ANY_PROTOCOL']" />/js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_ANY_PROTOCOL']" />/js/jquery-ui-1.12.1.min.js"></script>
	<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/js/mobi_event.js"></script>
		
	<script language="JavaScript">
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////	

		var hasReward = ${not empty reward};
				function openH1k() { window.open("http://www.gojls.com/branch/myjls/thousand"); }

		function showGift() {
			var messageToAlert = "${messageToAlert}";
			var messageToConsole = "${messageToConsole}";
			console.log(messageToConsole);

			var redirectTo = "${redirectTo}";
			if(redirectTo.length > 0) {
				alert(messageToAlert);
				location.href = redirectTo;
				return;
			}
			
			if(hasReward) {
				$.ajax({
					type : "POST",
					url: "/roulette/confirmReward",	
					data:"sequence="+"${event.sequence}",
			        dataType : "json",
					success : function(data){
		            
						if(data.success == true){
							$('#giftbox').addClass('shake', callback);
		            	}
		            
		            	if(data.hasOwnProperty("messageToAlert")) {
							var postmessageToAlert = data.messageToAlert;
							if(postmessageToAlert && postmessageToAlert.length > 0) { alert(postmessageToAlert); }
						} else {
							if(messageToAlert && messageToAlert.length > 0) { alert(messageToAlert); }
						}

						if(data.hasOwnProperty("messageToConsole")) {
							var messageToConsole = data.messageToConsole;
							console.log(messageToConsole);
						}
					},
		        	error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }
				});  
		  	}
		  	else {
				if(messageToAlert && messageToAlert.length > 0) { alert(messageToAlert); }
		  	}
		
		}	
		/* shake animation */
		function callback() {
			setTimeout(function() {
				$('#box').hide();
				$('.result').fadeIn();
			}, 2000 );
		};

		function onShakeFinished(delay) {
			setTimeout(function() {
				$('#box').hide();
				$('.result').fadeIn();
			}, (delay === undefined? 1500: delay));
		}
		
		function finishEventWithNothing() {
			$(".gift_box").hide();
			$("#box")
				.empty()
				.append('<div class="btn_more"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20200825_event/finish.png"></div>');
		}
	</script>
</head>
<body>
	<div id="wrap">
		<a href="<spring:eval expression="@globalContext['GOJLS_URL']" />/academy/" target="_blank"><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20200825_event/logo.png" class="logo" /></a>
		<div class="toparea"></div>
		<div class="information">
			<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20200825_event/20200825_01.jpg">
		</div>
		<div id="gift">
			<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20200825_event/title.jpg">
			<p>
				${fn:escapeXml(resultMessage)}
				<button type="button" class="yellow" onclick="openH1k();"><span>나의 1000시간 달성 내역 확인하기 </span></button>
			</p>
			<div class="info">
				<c:if test="${not empty reward}">
					<div class="result hide">
						<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />${fn:escapeXml(reward.imageUrl)}" class="gift_img">
					</div>
				</c:if>
				<div id="box" class="box">
					<img id="giftbox" src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20200825_event/gift_img.png" class="gift_box">
					<div id="getGift" class="btn_more">
						<c:choose>
							<c:when test="${empty event or !event.hasStarted()}">
								<%-- 이벤트가 없거나(!?) 시작 전인 경우 --%>
								<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20200825_event/reddy.png">
							</c:when>
							<c:when test="${event.duringPeriod}">
								<%-- 이벤트 기간 중 --%>
								<c:choose>
									<c:when test="${not empty reward and not empty reward.confirmationDateTime}">
										<%-- 이미 선물을 확인한 경우; 선물 받기 버튼 없이 결과만 노출 --%>
										<script>onShakeFinished(0);</script>
									</c:when>
									<c:otherwise>
										<%-- 선물이 있거나 아직 확인하지 않은 경우 --%>
											<script>
												$("#getGift").click(function() { showGift(); });
											</script>
										
										<c:if test="${not empty reward}">	
											<div class="result hide">
												<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />${fn:escapeXml(reward.imageUrl)}" class="gift_img">
											</div>
										</c:if>
										<img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20200825_event/gift_bt_on.png"
											onmouseover="this.src = '<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20200825_event/gift_bt_off.png'"
											onmouseout="this.src = '<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/event/20200825_event/gift_bt_on.png'">
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<%-- 이벤트가 종료된 경우 --%>
								<c:choose>
									<c:when test="${empty reward or empty reward.confirmationDateTime}">
										<script>finishEventWithNothing();</script>
									</c:when>
									<c:otherwise>
										<script>onShakeFinished(0);</script>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>