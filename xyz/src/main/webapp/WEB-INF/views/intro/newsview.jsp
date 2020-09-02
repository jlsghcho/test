<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
	<!-- 이 소스는 똑같이 복사해서 분원홈쪽에서도 쓰임 대표/분원 구분은 소스안에서 알아서 함.  -->
	<script type="text/javascript">
	var param_news_dept = [];
	$(document).ready(function(){
		if(typeof param_dept_obj !== "undefined"){
			for(var i=0; i < param_dept_obj.length; i++){ param_news_dept.push(param_dept_obj[i]["deptSeq"]); }
		}
		
		/* clipboard */
		$(".copy_url").attr('data-clipboard-text', $(location).attr('href'));
		var clipboard = new Clipboard('.copy_url');
		clipboard.on('success', function(event){ common_alert.big('success', 'URL 복사가 완료되었습니다.'); });
		clipboard.on('error', function(event){ common_alert.big('warning', '실패했습니다. 다시 시도해주세요.'); });
		
		//$.when(fnNoticeView()).done(function(){ gridmasonry() });
		
		$(".sns a").click(function(){
			if($(this).attr("class") == "facebook"){ common_sns.facebook($(location).attr('href')); }
			else if($(this).attr("class") == "twitter"){ common_sns.twitter($(location).attr('href'), $(".news_view h4").text()); }
			else if($(this).attr("class") == "kakaostory"){ common_sns.kakaostory($(location).attr('href'), $(".news_view h4").text()); }
			else if($(this).attr("class") == "band"){
				var m = $(location).attr('href').match(/^http:\/\/[^/]+/);
				common_sns.band(m, $(".news_view h4").text() +"\n"+ $(location).attr('href').replace('#','')); 
			}
			else if($(this).attr("class") == "naverblog"){ common_sns.blog($(location).attr('href'), $(".news_view h4").text()); }
		});

		if(device.mobile()||device.tablet()){
			$(".news_view .page").find("video").css("width","100%").css("height","100%");
		}
	});
	
	function fnNoticeList(){ location.href= root_url +"/intro/news"; }
	/*
	function gridmasonry(){
		var $grid = $('.grid').masonry({ itemSelector: '.grid-item', columnWidth: '.grid-sizer', gutter: '.gutter-sizer', percentPosition: true });
		$grid.imagesLoaded().progress( function() { $grid.masonry('layout'); });
	}
	
	var fnNoticeView = function (){
		$('.grid').empty().append("<div class='grid-sizer'></div><div class='gutter-sizer'></div>");
		var item_class = "";
		var result = JSON.parse(common_ajax.inter("/cache/cacheNotice", "json", false, "GET", ""));
		if(result.header.isSuccessful == true){
			var obj = eval(result.data);
			var n_news_cnt = 4;
			var input_div = "";
			for(var i=0; i < obj.length; i++){
				open_yn = false;
				if(param_news_dept.length > 0){
					$.each(param_news_dept, function(index, value){	if(obj[i]["deptSeq"] == value || obj[i]["deptSeq"] == "1"){ open_yn = true; } });
				}else{
					if(obj[i]["deptSeq"] == "1"){ open_yn = true; }
				}
				item_class = (obj[i]["imageUrl"] == "") ? "nothumb" : "";
				if(n_news_cnt > 0 && open_yn == true){
					input_div += "<div class='grid-item "+ item_class +"'><a href='"+ root_url +"/intro/newsview?param_seq="+ obj[i]["noticeNo"] +"'>";
					if(obj[i]["imageUrl"] != ''){ input_div += "<img src='"+ obj[i]["imageUrl"] +"' />"; }
					input_div += "<h3>"+ obj[i]["title"] +"</h3><div class='info'><span class='category'>";
					if(obj[i]["deptSeq"] == "1"){ input_div += "JLS 소식"; }else{ input_div += "분원 소식"; }
					input_div += "</span><span class='date'>"+ obj[i]["registerDate"] +"</span></div></a></div>";
					n_news_cnt--;
				}
			}
			$(".grid").append(input_div);
		}
	}
	*/
	
	/*
	function fnKakaoTalk(){
		//카카오톡 관련 
		Kakao.init('4442e9b3fec27e0ff6825628f44519ba');
	    Kakao.Link.createTalkLinkButton({
	        container: '#kakao-link-btn',
	        label: '카카오링크 샘플에 오신 것을 환영합니다.',
	        image: {
	          src: 'http://dn.api1.kage.kakao.co.kr/14/dn/btqaWmFftyx/tBbQPH764Maw2R6IBhXd6K/o.jpg',
	          width: '300',
	          height: '200'
	        },
	        webButton: {
	          text: '카카오 디벨로퍼스',
	          url: 'https://dev.kakao.com/docs/js' // 앱 설정의 웹 플랫폼에 등록한 도메인의 URL이어야 합니다.
	        }
	      });		

		// 스크립트 호출 = developers.kakao.com/sdk/js/kakao.min.js
	    Kakao.Link.createTalkLinkButton({
	    	container: '#kakao-link-btn',
	    	label: $(".news_view h4").text(),
	    	image : { src : $("#imageCrop img").attr('src') , width : 300 , height: 200 },
	    	webButton : { text : '정상제이엘에스 바로가기', url: $(location).attr('href').replace('#','') }
		});

	    var values = 0;
		$("#imageCrop").imagesLoaded().progress(function(instance, image){
			var i_width = image.img.width;
			var i_height = image.img.height;
			values = parseInt((i_height * 250 ) / i_width);
			console.log(i_height +"/"+ i_width +"/"+ values);
		}).done(function(instance){
		});
	}
	*/
	</script>
	<div id="container">
		<jsp:include page="menu.jsp" flush="true" />
		<div class="contents">
			<div class="head">
				<div class="subimg"></div>
				<h3>학원소개</h3>
			</div>
			<div class="section">
				<div class="subtit"><h4 class="fake"><b></b></h4></div>
				<div class="news_view">
					<h6>
						<c:choose>
							<c:when test="${notice.deptSeq eq '1'}">JLS소식</c:when>
							<c:when test="${notice.deptSeq eq '120'}">JLS소식</c:when>
							<c:when test="${notice.deptSeq eq '130'}">JLS소식</c:when>
							<c:otherwise>분원소식</c:otherwise>
						</c:choose>
					</h6>
					<h4>${notice.title}</h4>
					<div class="area">
						<div class="info">
							<div class="date">${notice.registerDate}</div>
							<div class="sns">		
								<!-- <a class="facebook" href="#" title="페이스북에 공유하기">facebook</a>
								<a class="twitter" href="#" title="트위터에 공유하기">twitter</a>
								<a id="kakao-link-btn" class="kakaotalk" href="#" title="카카오톡에 공유하기">kakaotalk</a> 
								<a class="kakaostory" href="#" title="카카오스토리에 공유하기">kakaostory</a>
								<a class="naverblog" href="#" title="네이버블로그에 공유하기">naverblog</a> 
								<a class="band" href="#" title="밴드에 공유하기">band</a>-->
								<a class="copy_url" href="#" title="URL 복사하기">URL 복사</a>
							</div>
						</div>
						<div class="page">${notice.contents}</div>
					</div>
					<div id="imageCrop" style="display:none;"></div>
					<div class="latest">
						<!-- <h5>최근 분원소식</h5> -->
						<div class="animore"><a href="#" onclick="fnNoticeList()">전체목록 보기</a></div>
					</div>
				</div>
				<!-- 
				<div class="news">
					<div class="grid">
					</div>
				</div>
				 -->
			</div>
		</div>
	</div>