<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<link rel="stylesheet" type="text/css" href="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/css/footer.css?20190402" />
<script type="text/javascript">
$(document).ready(function(){
	$('#footer .site b').click(function(){ $('#footer .site').toggleClass('fold'); });
});

function fnFcPopup(){
	window.open('<spring:eval expression="@globalContext['CHESS_URL']" />/fcconsult/FCConsult.do?from=FPFC&cmd=FCConsultMain', 'fcconsult', 'width=900,height=650,scrollbars=no,scrolling=no,location=no,toolbar=no');
}
</script>
<div id="footer">
	<div class="sec">
		<div class="customer">
			<p>온라인 학습지원센터 <b>1644-0500</b></p>
			<div class="site fold">
				<b>Family Site</b>
				<ul>
					<li><a href="<spring:eval expression="@globalContext['SITE_GOJLS_URL']" />" target="_blank">정상어학원</a></li>
					<li><a href="<spring:eval expression="@globalContext['SITE_MATH_URL']" />" target="_blank">정상수학학원</a></li>
					<li><a href="<spring:eval expression="@globalContext['JLSACADEMY_URL']" />" target="_blank">정상어학원 유학센터</a></li>
					<li><a href="<spring:eval expression="@globalContext['KIDS_URL']" />" target="_blank">유아활동영어 Kids English</a></li>
					<li><a href="http://chesscool.gojls.com" target="_blank">방과후학교 CHESSCool</a></li>
					<li><a href="<spring:eval expression="@globalContext['MALL_URL']" />" target="_blank">정상몰</a></li>
					<li><a href="<spring:eval expression="@globalContext['CHESS_URL']" />" target="_blank">CHESS Online</a></li>
					<li><a href="<spring:eval expression="@globalContext['ACE_URL']" />" target="_blank">ACE Online</a></li>
					<li><a href="<spring:eval expression="@globalContext['KAKAOKIDS_URL']" />" target="_blank">유아홈스쿨 카카오키즈 잉글리시</a></li>
					<li><a href="<spring:eval expression="@globalContext['BLOG_URL']" />" target="_blank">정상어학원 공식블로그</a></li>
					<li><a href="<spring:eval expression="@globalContext['RECRUIT_URL']" />" target="_blank">Become a JLS Teacher</a></li>
					<li><a href="javascript:fnFcPopup();">JLS 가맹사업</a></li>
					<li><a href="<spring:eval expression="@globalContext['CARAMELTREE_URL']" />" target="_blank">Carameltree</a></li>
				</ul>
			</div>
		</div>
		<div class="terms">
			<a href="<spring:eval expression="@globalContext['MEMBER_URL']" />/about/vision.do?from=FFCI">회사소개</a>
			<!-- <a href="<spring:eval expression="@globalContext['RECRUIT_URL']" />/?from=FFBT" target="_blank">Become a JLS Teacher</a> -->
			<a href="<spring:eval expression="@globalContext['MEMBERS_URL']" />/policy/service">이용약관</a>
			<a href="<spring:eval expression="@globalContext['MEMBERS_URL']" />/policy/privacy"><b>개인정보취급방침</b></a>
			<a href="<spring:eval expression="@globalContext['SITE_GOJLS_URL']" /><spring:eval expression="@globalContext['SITE_ROOT_ACADEMY']" />/support/faq?from=FFCC">학습지원센터</a>
		</div>
		<dl class="info">
			<dt>(주)정상제이엘에스 <span>사업자정보</span></dt>
			<dd class="address"><b>주소</b> <span>서울특별시 강남구 영동대로 227 (대치동) <br> 정상어학원 4층</span></dd>
			<dd class="tel"><b>전화</b> <span>1644-0500</span></dd>
			<dd class="fax"><b>팩스</b> <span>02-563-1757</span></dd>
			<dd class="license"><b>사업자등록번호</b> <span>130-81-42974 (박정흠)</span></dd>
			<dd class="mail_order"><b>통신판매신고번호</b> <span>제2009-서울강남-02863호</span></dd>
			<dd class="cpo"><b>개인정보관리책임자(CPO)</b> <span>박정흠 cpo@gojls.com</span></dd>
			<!-- <dd class="btn"><a href="#">사업자등록정보 확인</a></dd> -->
		</dl>
		<p class="copyright">ⓒ JLS CO., LTD. All Rights Reserved.</p>
	</div>
</div>
