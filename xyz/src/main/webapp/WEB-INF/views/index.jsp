<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div id="container">
	<div class="top_area">
		<div class="lside">
			<!-- 760 * 400 -->
			<div class="slides_wrap">
				<ul id="slides"></ul>
				<div id="slides_dot"></div>
				<div id="slides_prev"></div>
				<div id="slides_next"></div>
			</div>
		</div>
		<div class="rside">
			<div class="quick expand">
				<div class="close_tab"><span>QUICK MENU</span></div>
				<c:if test="${not cookieYN}">
				<ul>
					<li><a href="/login?from=FLLI" class="login"><h4><span>로그인</span></h4></a></li>
					<li><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/intro/search?from=FLSB" class="branch"><h4><span>분원찾기</span></h4></a></li>
					<li><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/admission/mathink?from=FLAG" class="entrance"><h4><span>입학안내</span></h4></a></li>
					<li><a href="<spring:eval expression="@globalContext['MALL_URL']" />?from=FLJM" target="_blank" class="mall"><h4><span>정상몰</span></h4></a></li>
					<li><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/intro/news?from=FLJN" class="news"><h4><span>JLS소식</span></h4></a></li>
					<li><a href="<spring:eval expression="@globalContext['SITE_GOJLS_URL']" /><spring:eval expression="@globalContext['SITE_ROOT_ACADEMY']" />/support/faq?from=FHN4" class="customer"><h4><span>학습지원센터</span></h4></a></li>
				</ul>
				</c:if>
				
				<c:if test="${cookieYN}">
				<ul>
					<c:if test="${cookieUserCourse !=''}">
					<c:set var="counter" value="1" />
						<li class="myinfo"><a href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls" class="my"><div class="my"><div class="info"><h5>MY JLS</h5></div></div></a></li>
						<c:if test="${cookieUserType =='US6001' }">
							<c:if test="${fn:contains(cookieUserCourse,'1') || fn:contains(cookieUserCourse,'2') || fn:contains(cookieUserCourse,'3') || fn:contains(cookieUserCourse,'4') || fn:contains(cookieUserCourse,'5')}">
								<c:if test="${counter < 6}"><li><a href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls/homework" class="task"><h4><span>과제</span></h4></a></li></c:if>
								<c:set var="counter" value="${counter+1}" />
							</c:if>
							<c:if test="${fn:contains(cookieUserCourse,'3') || fn:contains(cookieUserCourse,'4')}">
								<c:if test="${counter < 6}"><li><a href="<spring:eval expression="@globalContext['ELEARNING_URL']" />" target="_blank" class="elearning"><h4><span>이러닝</span></h4></a></li></c:if>
								<c:set var="counter" value="${counter+1}" />
							</c:if>
							<c:if test="${fn:contains(cookieUserCourse,'3') }">
								<c:if test="${counter < 6}"><li><a href="<spring:eval expression="@globalContext['CMAP_URL']" />/auth/extra/sign?userSeq=${cookieUserSeq}" target="_blank" class="mathmap"><h4><span>수학개념 Map</span></h4></a></li></c:if>
								<c:set var="counter" value="${counter+1}" />
							</c:if>
							<c:if test="${fn:contains(cookieUserCourse,'1')}">
								<c:if test="${counter < 6}"><li><a href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls/thousand" class="thousand"><h4><span>1000시간현황</span></h4></a></li></c:if>
								<c:set var="counter" value="${counter+1}" />
							</c:if>
							<c:if test="${fn:contains(cookieUserCourse,'2')}">
								<c:if test="${counter < 6}"><li><a href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls/acewriting" class="assessment"><h4><span>ACE Writing</span></h4></a></li></c:if>
								<c:set var="counter" value="${counter+1}" />
							</c:if>
							<c:if test="${fn:contains(cookieUserCourse,'1') || fn:contains(cookieUserCourse,'2') || fn:contains(cookieUserCourse,'3') || fn:contains(cookieUserCourse,'4') || fn:contains(cookieUserCourse,'5')}">
								<c:if test="${counter < 6}"><li><a href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls/advice" class="advice"><h4><span>선생님1:1상담</span></h4></a></li></c:if>
								<c:set var="counter" value="${counter+1}" />
							</c:if>
							<c:if test="${fn:contains(cookieUserCourse,'1') || fn:contains(cookieUserCourse,'2') || fn:contains(cookieUserCourse,'5')}">
								<c:if test="${counter < 6}"><li><a href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls/attendance" class="attendance"><h4><span>출석</span></h4></a></li></c:if>
								<c:set var="counter" value="${counter+1}" />
							</c:if>
							<c:if test="${fn:contains(cookieUserCourse,'4') || fn:contains(cookieUserCourse,'5')}">
								<c:if test="${counter < 6}"><li><a href="<spring:eval expression="@globalContext['MEMBERS_SSL_URL']" />/myinfo/editform" class="login"><h4><span>내정보</span></h4></a></li></c:if>
								<c:set var="counter" value="${counter+1}" />
							</c:if>
							<c:if test="${fn:contains(cookieUserCourse,'1') || fn:contains(cookieUserCourse,'2') || fn:contains(cookieUserCourse,'3') || fn:contains(cookieUserCourse,'4') || fn:contains(cookieUserCourse,'5')}">
								<c:if test="${counter < 6}"><li><a href="<spring:eval expression="@globalContext['MALL_URL']" />/jlsf/front/product/jlsbooks/main.do" target="_blank" class="book"><h4><span>반교재</span></h4></a></li></c:if>
								<c:set var="counter" value="${counter+1}" />
							</c:if>
						</c:if>	
					</c:if>
					<c:if test="${cookieUserCourse ==''}">
						<c:if test="${cookieUserType =='US6002'}">
							<li class="myinfo"><a href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls" class="my"><div class="my"><div class="info"><h5>MY JLS</h5></div></div></a></li>
							<li><a href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls/payment" class="payment"><h4><span>교육비결제</span></h4></a></li>
							<li><a href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls/homework" class="task"><h4><span>과제</span></h4></a></li>
							<li><a href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls/advice" class="advice"><h4><span>선생님1:1상담</span></h4></a></li>
							<li><a href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls/attendance" class="attendance"><h4><span>출석</span></h4></a></li>
							<li><a href="<spring:eval expression="@globalContext['MALL_URL']" />/jlsf/front/product/jlsbooks/main.do" target="_blank" class="book"><h4><span>반교재</span></h4></a></li>
						</c:if>
						<c:if test="${cookieUserType =='US6001'}">
							<li class="myinfo"><a href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls" class="my"><div class="my"><div class="info"><h5>MY JLS</h5></div></div></a></li>
							<li><a href="<spring:eval expression="@globalContext['MEMBERS_SSL_URL']" />/myinfo/editform" class="login"><h4><span>내정보</span></h4></a></li>
							<li><a href="<spring:eval expression="@globalContext['SITE_ROOT_ACADEMY']" />/intro/search" class="branch"><h4><span>분원찾기</span></h4></a></li>
							<li><a href="<spring:eval expression="@globalContext['SITE_ROOT_ACADEMY']" />/admission/chess" class="entrance"><h4><span>입학안내</span></h4></a></li>
							<li><a href="<spring:eval expression="@globalContext['SITE_ROOT_ACADEMY']" />/admission/chess?param_link=1" class="pretest"><h4><span>Online Pre-Test</span></h4></a></li>
							<li><a href="<spring:eval expression="@globalContext['MALL_URL']" />/jlsf/front/product/jlsbooks/main.do" target="_blank" class="book"><h4><span>반교재</span></h4></a></li>
						</c:if>
					</c:if>
				</ul>
				<c:if test="${cookieUserType =='US6002'}">
				<div id="unpaid_module">
					<div class="area">
						<div class="info">
							<p>현재 학부모님께서 납부하셔야 할 <br> 자녀교육비 내역이 있습니다.</p>
							<button type="button" class="red" onclick='location.href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls/payment"'><span>교육비 납부하러 가기</span></button>
						 </div>
					</div>
					<div class="close_ani"></div>
				</div>
				</c:if>
				</c:if>
				<div class="top_btn"><a href="#"><span>TOP</span></a></div>
			</div>
		</div>
	</div>
	<div class="curriculum">
		<div class="tit">
			<h3>정상수학학원 <strong>프로그램</strong></h3>
			<p>초등수학 매씽크 / 중등수학 매셀프</p>
		</div>
		<div class="mathink">
			<div class="top_info">
				<h3><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/logo_mathink.svg" /></h3>
				<h4>초등수학 45가지 <br>핵심개념 <br>완성</h4>
			</div>
			<div class="bottom_info">
				<ul>
					<li class="p1" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathink/process?course_num=1';">
						<h5><b>사고력</b><span>이</span><br> 다르다.</h5>
					</li>
					<li class="p2" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathink/process?course_num=2';">
						<h5><b>컨텐츠</b><span>가</span><br> 다르다.</h5>
					</li>
					<li class="p3" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathink/process?course_num=3';">
						<h5><b>개념</b><span>이</span><br> 다르다.</h5>
					</li>
					<li class="p4" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathink/process?course_num=4';">
						<h5><b>OUTPUT</b><span>이</span><br> 다르다.</h5>
					</li>
				</ul>
				<div class="tit" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathink';">
					<h3>개념드림트리로 완성하는 초등수학</h3>
					<p>수학개념을 말로설명하고 문제해결에 적용하는<br>매씽크만의 교수법으로 초등개념 완전정복!<br></p>
				</div>
			</div>
		</div>
		<div class="mathself">
			<div class="top_info">
				<h3><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/logo_mathself.svg" /></h3>
				<h4>1:1 맞춤수학</h4>
			</div>
			<div class="bottom_info">
				<ul>
					<li class="p1" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathself/process?course_num=1';">
						<h5><b>개념</b><span>에</span><br> 강하다.</h5>
					</li>
					<li class="p2" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathself/process?course_num=2';">
						<h5><b>내신</b><span>에</span><br> 강하다.</h5>
					</li>
					<li class="p3" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathself/process?course_num=3';">
						<h5><b>맞춤</b><span>에</span><br> 강하다.</h5>
					</li>
				</ul>
				<div class="tit" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathself';">
					<h3>수학의 핵심은 개념!</h3>
					<p>개별진도에 맞춘 교재와 자기주도수업, <br>담임선생님의 1:1코칭을 통한 수학실력완성</p>
				</div>
			</div>
		</div>
		<div class="algorithm">
			<div class="top_info">
				<h3><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/logo_algorithm.png" /></h3>
				<h4>실력과 성과를 위한<br> 코딩</h4>
			</div>
			<div class="bottom_info">
				<ul>
					<li class="p1" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/coding/process';">
						<h5><b>알고리즘<br>정규과정</b></h5>
					</li>
					<li class="p2" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/coding/process';">
						<h5><b>영재원<br>특강과정</b></h5>
					</li>
					<li class="p3" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/coding/process';">
						<h5><b>국가대표양성<br>특강과정</b></h5>
					</li>
				</ul>
				<div class="tit" onclick="location.href='<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/coding';">
					<h3>알고리즘을 통한 소프트웨어 교육</h3>
					<p>미래를 위한 교육과정, <br>개인별 진도관리로 최적화된 효율 학습</p>
				</div>
			</div>
		</div>
	</div>
	<div class="branch_info module_wrap">
		<div class="frame">
			<div class="tit">
				<h3>정상수학학원 분원찾기</h3>
			</div>
			<ul>
				<li>
					<div class="name"><span>대치분원</span></div>
					<div class="tel">
						<a href="tel:025645600"><span>02)564-5600</span></a>
					</div>
				</li>
				<li>
					<div class="name"><span>목동분원</span></div>
					<div class="tel">
						<a href="tel:025645600"><span>02)2650-8340</span></a>
					</div>
				</li>
				<li>
					<div class="name"><span>분당분원</span></div>
					<div class="tel">
						<a href="tel:025645600"><span>031)715-3315</span></a>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<div class="community module_wrap">
		<div class="tit">
			<h3>정상수학학원 <strong>소식</strong></h3>
			<p>우리가 만들어가는 정상수학학원 커뮤니티</p>
		</div>
		<ul class="module" id="direct"></ul>
		<div id="slides_dot2"></div>
		<div class="news_list">
			<div class="grid"></div>
			<div class="more_btn">
				<a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/intro/news">
					<div class="plus_icon"><span></span></div>
					<span>소식 더보기</span>
				</a>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	$.when(fnCacheBanner()).done(function(){ fnSlide() });
	$('body .quick .close_tab').on('click', function() { $('body .quick').toggleClass('expand'); }); //퀵메뉴옆에 화살표 클릭시 이벤트 
	fnNoticeGet(); // Notice Setting
});

/* Floating menu - PC */
var menuPosition = $('body .top_area .rside').css;

function floatmenu(){
	var animationSpeed=1000;
	var animationEasing='easeOutQuint';
	var scrollAmount=$(document).scrollTop();
	var newPosition=menuPosition+scrollAmount;
	if($(window).height()<$('.rside').height()){
		$('body .top_area .rside').css('top',menuPosition);
	} else {
		$('body .top_area .rside').stop().animate({top: newPosition}, animationSpeed, animationEasing);
	}
}

$(window).on('scroll', function () { 
	if($("#wrap").attr('class').indexOf("math") > -1){
		floatmenu();
	}
});

function return_index() { var r_index = Math.floor( Math.random() * ($('#slides>li').length)); return parseInt(r_index); }

function fnSlide(){

	/* Main Slide & for mobile */
	$('#slides').addClass('swiper-wrapper');
	$('#slides>li').addClass('swiper-slide');
	
	if($('#slides>li').length == 1){
		$('.swiper-wrapper').addClass('disabled');
		$('#slides_dot').addClass('disabled');
	}
	
	var topSwiper = new Swiper('.slides_wrap', {
		slidesPerView: 1,
		pagination: {
			el: '#slides_dot',
			clickable: true
		},
		autoplay: {
			delay: 4000,
			disableOnInteraction: true
		},
		loop: true,
		initialSlide : return_index()
	});
	
	
	/* JLS Community */
	$('html.mobile .community ul.module').wrapAll('<div class="community_wrap"></div>');
	$('html.mobile .community ul.module').addClass('swiper-wrapper');
	$('html.mobile .community ul.module>li').addClass('swiper-slide');
	
	var communitySwiper = new Swiper('html.mobile .community_wrap', {
		slidesPerView: 1,
		pagination: '#slides_dot2',
		autoplay: {
			delay: 4000,
			disableOnInteraction: true
		},
		loop: true
	});
	
}

function fnCacheBanner(){
	var result = JSON.parse(common_ajax.inter(site_gojls_url +"/cache/cacheBanner", "json", false, "GET", ""));
	if(result.header.isSuccessful == true){
		var obj_data = JSON.parse(result.data);
		var top_left_data = "";
		var top_right_data = "";
		var bottom_left_data = "";
		var banner_dept_seq = "130"; //20180509 Add
		var bottom_mid_data = "";
		var bottom_mid_data_color = ['red', 'green', 'blue', 'yellow'];
		var bottom_mid_color_num = 0;
		
		
		if(obj_data.length > 0){
			for(var i=0; i < obj_data.length; i++){
				if(obj_data[i]["deptSeq"] == banner_dept_seq){ //20180509 Add 
					var target = ( obj_data[i]["linkFl"] == "0") ? "_self" : "_blank";
					var http_code = (obj_data[i]["linkUrl"].substring(0,4) == "http") ? "" : "http://"; 
					var alink = (obj_data[i]["linkUrl"] == "" ) ? "" : 	"<a href='"+ http_code + obj_data[i]["linkUrl"] +"' target='"+ target +"'>" ;
					if(obj_data[i]["gtBannerLoc"] == "BN1001"){
						top_left_data += "<li>"+ alink +"<img src='"+ obj_data[i]["bannerImgPath"]+"'/></a></li>"; 
					}else if(obj_data[i]["gtBannerLoc"] == "BN1005"){
						var title = obj_data[i]["title"].split("#");
						bottom_mid_data += "<li class='"+ bottom_mid_data_color[bottom_mid_color_num] +"'><div class='thumb'><img src='"+ obj_data[i]["bannerImgPath"]+"' /></div>";
						bottom_mid_data += "<div class='info'><div class='text'><h5>"+ title[0] +"</h5>	<h4>"+ title[1] +"</h4></div></div>";
						bottom_mid_data += "<div class='btn'>"+ alink +"<span>자세히 보기</span></a></div></li>";
						bottom_mid_color_num++;
					}
				}
			}
		}
		if(top_left_data == ""){ top_left_data += "<li><img src='<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/ad_main_01.png' /></a></li>"; }

		$("#container #slides").empty().append(top_left_data);
		$("#container .community #direct").empty().append(bottom_mid_data); // 기획자랑 합의 완료 : 데이터가 없으면 안보여줘도 된다.
	}
}

function fnNoticeGet(){
	var result = JSON.parse(common_ajax.inter(site_gojls_url +"/cache/cacheNotice", "json", false, "GET", ""));
	if(result.header.isSuccessful == true){
		var obj_data = JSON.parse(result.data);
		var input_data = "";
		var param_dept_seq = 130;
		var max_length = 2;
		var nothumb = "";
		for(var i=0; i < obj_data.length; i++){
			if((obj_data[i]["deptSeq"] == param_dept_seq || obj_data[i]["deptSeq"] == 1) && max_length > 0){
				if(obj_data[i]["imageUrl"] == ""){ nothumb = "nothumb"; }else{ nothumb = ""; }
				input_data += "<div class='grid-item "+ nothumb +"'>";
				input_data += "<a href='"+ root_url +"/intro/newsview?param_seq="+ obj_data[i]["noticeNo"] +"'>";
				if(obj_data[i]["imageUrl"] != ""){ input_data += "<img src='"+ obj_data[i]["imageUrl"] +"' />"; }
				input_data += "<h3>"+ obj_data[i]["title"] +"</h3>";
				input_data += "<p>"+ obj_data[i]["summary"].replace(/\n/gi, "<br>")  +"</p>";
				//input_data += "<p>"+ obj_data[i]["contents"].replace(/<\/p>/gi, "\n").replace(/(<([^>]+)>)/gi, "").replace(/\n/gi, "<br>").substring(0,320) +"</p>";
				input_data += "<div class='info'><span class='category'>";
				if(obj_data[i]["deptSeq"] == "1"){ input_data += "JLS 소식"; }else{ input_data += "분원 소식"; }
				input_data += "</span><span class='date'>"+ common_date.convertType(obj_data[i]["registerDate"].replace(/\./gi,""),1)  +"</span></div></a></div>";
				
				max_length--;
			}
		}
		input_data += "<div class='grid-sizer'></div><div class='gutter-sizer'></div>";
		$(".community .news_list .grid").empty().append(input_data);
	}
}
 
/* close popup layer */
$(document).on('click','#unpaid_module .close_ani',function() { $('#unpaid_module').fadeOut(); });

$(window).on('load', function () { 
	if(!param_mobile_yn){
		if($('body .top_area .rside').length == 0){
			menuPosition=0;
		}else{
			menuPosition=$('body .top_area .rside').position().top;
		}
		//$('body #slides').parent().height($('body #slides').children().first().height());
	}
});

</script>