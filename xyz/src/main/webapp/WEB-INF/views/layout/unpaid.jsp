<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- <link rel="stylesheet" type="text/css" href="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/css/unpaid_layer.css" /> -->
<script type="text/javascript">
$(document).ready(function(){
	$("#unpaid_layer .footer #unpaid_check").change(function(){
		if($(this).is(":checked")){
			common_cookie.set("unpaid_view", "1", 1); // 쿠키세팅 
			$("#unpaid_layer .header .close").trigger('click');
		}
	});
	$(document).on('click','.close, button.cancel',function() { $('.black_bg, .pop').fadeOut('fast', function() { $('body').removeClass('noscroll'); }); });
});

</script>
<div id="unpaid_layer" class="pop">
	<div class="header">
		<h1>교육비 납부 안내</h1>
		<div class="close">Close</div>
	</div>
	<div class="content">
		<div class="text_info"></div>
		<c:if test="${cookieUserType eq 'US6001'}">
		<button type="button" class="blue medium" onclick="common_alert.comfirm_move('Warning', '학부모로 로그인 하셔야 합니다.', 'warning', '/logout?preURL=/login' , '');"><span>교육비 납부하러가기</span></button>
		</c:if>
		<c:if test="${cookieUserType eq 'US6002'}">
		<button type="button" class="blue medium" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls/payment';"><span>교육비 납부하러가기</span></button>
		</c:if>
		<div class="login_info">(교육비 납부는 학부모님 계정으로 로그인시 이용 가능합니다.)</div>
	</div>
	<div class="footer">
		<p>교육비를 납부하셨음에도, 본 메시지가 나오거나 문의사항이 있으시면<br> 소속분원으로 연락해주시기 바랍니다.</p>
		<label class="check"><input id='unpaid_check' type="checkbox" /> 오늘 다시 보지 않기</label>
	</div>
</div>
