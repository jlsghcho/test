<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
	$(document).ready(function(){
		var param_url = $(location).attr('pathname').split("/");
		if(param_url[2] != "undefined" && param_url[2] != ""){
			$("#nav ul li.selected").removeClass("selected");
			$("#nav ul li#"+ param_url[2]).addClass("selected");
			if(param_url[2] == "admission"){
				$('#container').addClass("entrance");
			}else{
				var bg_text = (param_url[3] == "jls")? " bg" : "";
				$('#container').addClass(param_url[2] + bg_text);
			}
		}
		
		// 대표분원설정 및 세팅 2차수정 (추가>> 대표홈쪽에도 세팅해줘야 함)
		//var deptNm = (param_dept_obj == null) ? "" : param_dept_obj[0]["dltDeptNm"] ;
		//$("#header .mh h3").html("<a href='"+ root_url +"'>"+ deptNm +"</a>");
		var dept_data = "";
		var input_count = 0;
		if("${cookieUserSeq}" != ""){
			var dept_data_plus = "<ul class='branch_list'><li class='set'><b>소속분원</b></li>";
			var dept_data_set = "<div class='branch_set'><h4>대표분원설정</h4>";

			var result = JSON.parse(common_ajax.inter("/getDept/${cookieUserSeq}/${cookieUserType}", "json", false, "GET", ""));
			if(result.header.isSuccessful == true){
				var obj_data = JSON.parse(result.data);
				var radioCheck = "";
				var liselect = "";
				var redirect_url = "";
				for(var i=0; i < obj_data.length; i++){
					liselect = (obj_data[i]["delDeptSeq"] == obj_data[i]["loginDeptSeq"]) ? "selected" : "" ;

					// 추가 분원으로 이동시 도메인 변경후 이동 
					//console.log(">>>>>"+ obj_data[i]["dltParentSeq"]);
					if(obj_data[i]["dltParentSeq"] == "130"){
						redirect_url = site_math_url + site_branch_path;
					}else{
						redirect_url = site_gojls_url + site_branch_path;
					}
					console.log(">>>>>>"+ redirect_url);
					dept_data_plus += "<li id='dept_code_"+ obj_data[i]["delDeptSeq"] +"' class='"+ liselect +"'><a href='"+ redirect_url +"?"+ obj_data[i]["delDeptSeq"] +"'>"+ obj_data[i]["delDeptNm"] +"</a>";
					if(liselect != ""){ dept_data_plus += "<button type='button' class='xsmall'><span>설정</span></button>"; }
					dept_data_plus += "</li>";
					input_count++;
					
					radioCheck = (obj_data[i]["delDeptSeq"] == obj_data[i]["loginDeptSeq"]) ? "checked" : "";
					dept_data_set +="<label><input type='radio' name='select_major' value='"+ obj_data[i]["delDeptSeq"] +"' "+ radioCheck +"> "+ obj_data[i]["delDeptNm"] +"</label>";
				}
			}
			//dept_data_plus += "<li class='set'>대표분원설정</li></ol>";
			dept_data_set += "<div class='btn'><button type='button' class='xsmall' id='cancelbtn'><span>취소</span></button> <button type='button' id='savebtn' class='xsmall blue'><span>확인</span></button></div></div> "
			if(input_count > 0){ 
				dept_data += dept_data_plus + "</ul>"+ dept_data_set; 
			}
		}
		$("#nav .myinfo .mylayer .branch_list").remove();
		$("#nav .myinfo .mylayer").append(dept_data);
		uniform();
		
		// myinfo click event 
		$('body #nav .myinfo .user').on('click', function(e){	e.stopPropagation(); $('#nav .myinfo ol').toggleClass('fold'); 	$('#uh .branch_list .set_layer').addClass('fold'); 	});
		
		/* user info */
		$('body #nav .myinfo .user').on('click', function(e){
			e.stopPropagation();
			$('#nav .mylayer').toggleClass('fold');
			$("#nav .mylayer .branch_list").removeClass('hide');
			$("#nav .mylayer .branch_set").removeClass('setup');
			//$('#uh .branch_list .set_layer').addClass('fold');
		});
		$("body #nav .mylayer").on('click',function(e){ e.stopPropagation(); });
		
		/* branch info - past */
		$('#uh .branch_list .more').on('click', function(e){
			e.stopPropagation();
			$('#uh .branch_list .set_layer').toggleClass('fold').removeClass('setup');
			$('body #nav .myinfo ol').addClass('fold');
		});
		$("#uh .branch_list .set_layer").on('click',function(e){ e.stopPropagation(); });
		$('#uh .branch_list .set').on('click', function(e){ e.stopPropagation(); $('#uh .branch_list .set_layer').addClass('setup'); });
		/* branch info */
		$('#nav .mylayer .branch_list li button').on('click', function(e){
			e.stopPropagation();
			$('#nav .mylayer .branch_list').addClass('hide');
			$('#nav .mylayer .branch_set').addClass('setup');
		});
		
		/* branch setting */
		$("#uh .branch_set #cancelbtn").on('click', function(e){ e.stopPropagation(); $('#nav .branch_list').removeClass('hide'); $('#nav .branch_set').removeClass('setup'); 	});
		$("#uh .branch_set #savebtn").on('click', function(e){
			e.stopPropagation();
			var param_dept_seq = $("#uh .branch_set input[name='select_major']:checked").val();
			var result = JSON.parse(common_ajax.inter("/setDept/${cookieUserSeq}/"+ param_dept_seq, "json", false, "GET", ""));
			if(result.header.isSuccessful == true){
				$('#nav .branch_list').removeClass('hide');
				$('#nav .branch_set').removeClass('setup');
				// 대표 selected 코드 옴겨줌 
				$('#uh .branch_list li').removeClass('selected');
				$('#uh .branch_list #dept_code_'+ param_dept_seq).addClass('selected');
			}else{
				common_alert.big('warning', result.header.resultMessage);
			}
		});

		$(document).on("click", function() {
			$("body #nav .mylayer .branch_list").removeClass('hide');
			$("body #nav .mylayer .branch_set").removeClass('setup');
			$("#nav .mylayer").addClass("fold");
		});
		
		fnCacheHeadBanner(); // 헤더 탑배너 
	});
	
	//var param_mobile_yn = OSInfoMobileYn(); //현재페이지가 모바일인지 아닌지 확인
	var param_mobile_yn = device.mobile(); //현재페이지가 모바일인지 아닌지 확인(PC+타블렛이 아닌지)
	
	function fnCacheHeadBanner(){
		var banner_dept_seq = "130"; //20180509 Add
	
		var result = JSON.parse(common_ajax.inter(site_gojls_url +"/cache/cacheBanner", "json", false, "GET", ""));
		if(result.header.isSuccessful == true){
			var obj_data = JSON.parse(result.data);
			var top_data = "";
			if(obj_data.length > 0){
				for(var i=0; i < obj_data.length; i++){
					if(obj_data[i]["deptSeq"] == banner_dept_seq){ //20180509 Add 
						if(obj_data[i]["gtBannerLoc"] == "BN1004"){
							var target = ( obj_data[i]["linkFl"] == "0") ? "_self" : "_blank";
							var http_code = (obj_data[i]["linkUrl"].substring(0,4) == "http") ? "" : "http://"; 
							var alink = (obj_data[i]["linkUrl"] == "" ) ? "" : 	"<a href='"+ http_code + obj_data[i]["linkUrl"] +"' target='"+ target +"'>" ;
							if(param_mobile_yn){
								if(obj_data[i]["gtBannerTyp"] == "BN2042"){
									top_data = alink +"<img src="+ obj_data[i]["bannerImgPath"]+" /></a>";								
								}else if(obj_data[i]["gtBannerTyp"] == "BN2041"){
									if(obj_data[i]["mobiBannerImgPath"] != ""){
										top_data = alink +"<img src="+ obj_data[i]["mobiBannerImgPath"]+" /></a>";									
									} 
								} 							 
							}else{
								if(obj_data[i]["gtBannerTyp"] == "BN2041"){ top_data = alink +"<img src="+ obj_data[i]["bannerImgPath"]+" /></a>"; } 
							}
						}
					}
				}
			}
			
			if(top_data == ""){
				$("#wrap").removeClass("topad");
				$("#header #topbanner").hide().empty();
			}else{
				$("#wrap").addClass("topad");
				$("#header #topbanner").show().empty().append(top_data);
			}
		}
	}
	
</script>

<div id="header">
	<div id="topbanner"></div>
	<div id="uh" class="mini">
		<div class="m_bg"></div>
		<div id="m_icon"><div></div></div>
		<div class="mh">
			<a href="<spring:eval expression="@globalContext['SITE_MATH_URL']" /><spring:eval expression="@globalContext['SITE_ROOT_MATH']" />?from=FHBI">
				<img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/mh_math_logo.svg" class="logo" />
			</a>
		</div>
		<div id="nav">
			<div class="minijls">
				<div class="link">
					<ol>
						<li class="eng"><a href="<spring:eval expression="@globalContext['SITE_GOJLS_URL']" />?from=FHBI" data-name="정상어학원">정상어학원</a></li>
						<li class="math selected"><a href="<spring:eval expression="@globalContext['SITE_MATH_URL']" />?from=FHBI" data-name="정상수학학원">정상수학학원</a></li>
					</ol>
					<ul>
						<c:if test="${not cookieYN}">
						<li><a href="/login?from=FHLI" data-name="로그인">로그인</a></li>
						<li><a href="<spring:eval expression="@globalContext['MEMBERS_SSL_URL']" />/join/jointype?from=FHSO" data-name="회원가입">회원가입</a></li>
						</c:if>
						<c:if test="${cookieYN}">
						<li class="myinfo">
							<a href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls" class="my">MY</a>
							<span class="user">${cookieUserNm}</span>
							<div class="mylayer fold">
								<ol>
									<li><a href="<spring:eval expression="@globalContext['MEMBERS_SSL_URL']" />/myinfo/editform">내정보</a></li>
									<li><a href="/logout?preURL=/">로그아웃</a></li>
								</ol>
							</div>
						</li>
						</c:if>
						<li><a href="<spring:eval expression="@globalContext['SITE_GOJLS_URL']" /><spring:eval expression="@globalContext['SITE_ROOT_ACADEMY']" />/support/faq?from=FHN4&param_branch_type=10" data-name="학습지원센터">학습지원센터</a></li>
					</ul>
				</div>
			</div>
			<dl>
				<dd class="link"></dd>
				<dd class="sns">
					<a class="facebook" href="//www.facebook.com/정상어학원-1759007647685006/" target="_blank"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/gojls/sns_facebook.png"></a>
					<a class="blog" href="//blog.naver.com/gojlsblog" target="_blank"><img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/gojls/sns_blog.png"></a>
				</dd>
			</dl>
		
			<ul>
				<li id="intro">
					<a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/intro/jls?from=FHN1">학원소개</a>
					<div class="sub">
						<div class="sec">
							<div class="info">
								<img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/gojls/subnav_thumb_01.jpg">
								<p>세계속의 0.1% Global Leader로 키워나가는 JLS</p>
							</div>
							<div class="menu"><h4><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/intro/jls?from=FHN11">정상수학학원 소개</a></h4></div>
							<div class="menu"><h4><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/intro/search?from=FHN12">분원 찾기</a></h4></div>
							<div class="menu"><h4><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/intro/news?from=FHN13">JLS 소식</a></h4></div>
						</div>
					</div>
				</li>
				<li id="course">
					<a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathink?from=FHN2">교육과정</a>
					<div class="sub">
						<div class="sec">
							<div class="info">
								<img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/gojls/subnav_thumb_02.jpg">
								<p>세계속의 0.1% Global Leader로 키워나가는 JLS</p>
							</div>
							<div class="menu">
								<h4><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathink">초등교육</a></h4>
								<ol>
									<li><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathink">매씽크 소개</a></li>
									<li><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathink/process">프로그램 특징</a></li>
								</ol>
							</div>
							<div class="menu">
								<h4><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathself">중등교육</a></h4>
								<ol>
									<li><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathself">매셀프 소개</a></li>
									<li><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/course/mathself/process">프로그램 특징</a></li>
								</ol>
							</div>
						</div>
					</div>
				</li>
				<li id="admission">
					<a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/admission/mathink?from=FHN3">입학안내</a>
					<div class="sub">
						<div class="sec">
							<div class="info">
								<img src="<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/gojls/subnav_thumb_03.jpg">
								<p>세계속의 0.1% Global Leader로 키워나가는 JLS</p>
							</div>
							<div class="menu"><h4><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/admission/mathink?from=FHN31">초등 매씽크 입학</a></h4></div>
							<div class="menu"><h4><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/admission/mathself?from=FHN32">중등 메셀프 입학</a></h4></div>
							<div class="menu"><h4><a href="<spring:eval expression="@globalContext['SITE_ROOT_MATH']" />/admission/online?from=FHN33">온라인 예약</a></h4></div>
						</div>
					</div>
				</li>
				<c:if test="${cookieYN && cookieUserType =='US6001'}">
				<li class="elearning"><a href="<spring:eval expression="@globalContext['ELEARNING_URL']" />" target="_blank">이러닝</a></li>
				</c:if>
				<!-- 
				<li class="myjls">
					<c:if test="${not cookieYN}"><a href="/login?preURL=<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls&from=FHLI">MY JLS</a></c:if>
					<c:if test="${cookieYN}"><a href="<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />/myjls">MY JLS</a></c:if>
				</li>
				 -->
			</ul>
		</div>
	</div>
</div>
