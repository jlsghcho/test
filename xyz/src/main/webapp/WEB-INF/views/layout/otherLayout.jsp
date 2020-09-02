<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
response.setDateHeader("Expires", -1);
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=1100, user-scalable=yes">

<c:if test="${notice eq null}">
<meta property="og:type" content="website"/>
<meta property="og:title" content="<tiles:getAsString name="title" />"/>    
<meta property="og:description" content="초등수학, 중등수학, 고등수학, 수학 전문학원, 교과수학, 사고력, 정상어학원, 대치, 목동, 분당" />
<meta property="og:url" content="<spring:eval expression="@globalContext['HOST_URL']" />" />
<meta property="og:image" content="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/mh_logo.svg" />
</c:if>
<c:if test="${notice ne null}">
<meta property="og:type" content="website"/>
<meta property="og:title" content="<tiles:getAsString name="title" />"/>    
<meta property="og:description" content="${notice.title}" />
<meta property="og:url" content="<spring:eval expression="@globalContext['HOST_URL']" />/academy/intro/newsview?param_seq=${notice.noticeNo}" />
<meta property="og:image" content="${notice.imageUrl}" />
</c:if>
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">

<META NAME=”ROBOTS” CONTENT=”NOINDEX, NOFOLLOW”>
<title><tiles:getAsString name="title" /></title>
<link rel="shortcut icon" type="image/x-icon" href="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/favicon_jls.ico" />
<!-- BootStrap -->
<link rel="stylesheet" type="text/css" href="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/bootstrap-3.3.7/css/bootstrap.css">

<!-- SweetAlert -->
<link rel="stylesheet" type="text/css" href="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/sweetAlert/sweetalert.css" />
<!-- 20190313 모바일 최적화 수정  -->
<link rel="stylesheet" type="text/css" href="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/swiper-4.5.0/css/swiper.min.css">
<c:if test="${fn:length(fn:split(recentUrl,'/')) < 3}">
	<link rel="stylesheet" type="text/css" href="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/css/gojls_main.css" />
</c:if>
<c:if test="${fn:length(fn:split(recentUrl,'/')) >= 3}">
	<link rel="stylesheet" type="text/css" href="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/css/math_sub.css" />
</c:if>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/js/jquery-ui-1.12.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/js/jquery.uniform.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/js/jquery.slimscroll.min.js"></script>

<!-- 20190313 모바일 최적화 수정  -->
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/swiper-4.5.0/js/swiper.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/js/device.js"></script>
<!-- 20190313 모바일 최적화 수정     -->

<script> 
	if(device.mobile()||device.tablet()){ 
		document.write('<link rel="apple-touch-icon" sizes="120x120" href="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/touchicon_jls_120.png" />');
		document.write('<link rel="apple-touch-icon" sizes="152x152" href="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/touchicon_jls_152.png" />');
		document.write('<link rel="apple-touch-icon" sizes="167x167" href="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/touchicon_jls_167.png" />');
		document.write('<link rel="apple-touch-icon" sizes="180x180" href="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/touchicon_jls_180.png" />');
		document.write('<link rel="icon" sizes="192x192" href="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/touchicon_jls_192.png" />');
		document.write('<link rel="icon" sizes="512x512" href="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/touchicon_jls_512.png" />'); 		
	} 
</script>

<script type="text/javascript"> $.ajaxSetup({cache:false}); </script>

<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/bootstrap-3.3.7/js/bootstrap.js"></script>

<!-- SweetAlert -->
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/sweetAlert/sweetalert.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/sweetAlert/core.js"></script>

<!-- ClipBoard Copy -->
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/clipboard/clipboard.min.js"></script>

<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/js/common-1.0.0.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/js/json2.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/mediaElementJs/OSinfo.js"></script>

<!-- Image Map Size -->
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_SERVER']" />/common/js/jquery.rwdImageMaps.min.js"></script>

<script type="text/javascript">
//var root_url = "<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />";
//var academy_url = "<spring:eval expression="@globalContext['SITE_ROOT_ACADEMY']" />";
//var branch_url = "<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />";
var site_gojls_url = "<spring:eval expression="@globalContext['SITE_GOJLS_URL']" />";
var site_math_url = "<spring:eval expression="@globalContext['SITE_MATH_URL']" />";
var site_academy_path = "<spring:eval expression="@globalContext['SITE_ROOT_ACADEMY']" />";
var site_branch_path = "<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />";
var site_math_path = "<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />";
var root_url = site_math_path;

var homestudyDomain = "<spring:eval expression="@globalContext['HOMEWORK_URL']" />";
var chessDomain = "<spring:eval expression="@globalContext['CHESS_URL']" />";
var userpaid = "${cookieUserPaid}";

$(document).ready(function() {
	// myinfo click event 
	$('body #nav .myinfo .user').on('click', function(e){
		e.stopPropagation();
		$('#nav .myinfo ol').toggleClass('fold');
		$('#uh .branch_list .set_layer').addClass('fold');
	});
	
	// Image Map Size
	$('img[usemap]').rwdImageMaps();
	
	if(userpaid != ""){ common_gojls.minap(userpaid, "${serverDate}"); uniform(); } // 미납관련해서 팝업 보여주세요.
});

function uniform(){ $uniformed = $('body').find('input[type=checkbox], input[type=radio]').not('.sort input[type=checkbox], .sort input[type=radio]'); $uniformed.uniform(); }

$.fn.center = function () {
	this.css("margin-top", "-" + $(this).outerHeight()/2 + "px");
	this.css("margin-left", "-" + $(this).outerWidth()/2 + "px");
	return this;
}
</script>

<!-- 구글  -->
<script language="Javascript">
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
          
	ga('create', 'UA-12602897-3', 'auto');
	ga('require', 'linkid', 'linkid.js');
	ga('send', 'pageview');
</script>         

</head>
<body>
<div id="wrap" class="math">
<tiles:insertAttribute name="header" />
<tiles:insertAttribute name="content" />
<tiles:insertAttribute name="footer" />
</div>
<div class="black_bg"></div>
<div id="reserve" class="pop"></div>
<jsp:include page="unpaid.jsp" flush="true" />

<!-- 네이버 연관채널 -->
<span itemscope="" itemtype="http://schema.org/Organization">
  <link itemprop="url" href="http://gojls.com">
  <a itemprop="sameAs" href="https://www.facebook.com/%EC%A0%95%EC%83%81%EC%96%B4%ED%95%99%EC%9B%90-1759007647685006/"></a>
  <a itemprop="sameAs" href="http://blog.naver.com/gojlsblog"></a>
  <a itemprop="sameAs" href="http://m.post.naver.com/my.nhn?memberNo=34337196"></a>
</span>

<!-- 네이버  -->
<script type="text/javascript" src="http://wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
	if(!wcs_add) var wcs_add = {};
	wcs_add["wa"] = "1249db06e5ca44";
	wcs_do();
</script>
</body>
</html>