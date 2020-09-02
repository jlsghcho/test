<%--suppress RequiredAttributes --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML>
<html lang="ko" xml:lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta name="viewport" content="width=1081, user-scalable=yes">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="keywords" content=""/>

	<title> 정상어학원 이벤트</title>

	<%-- Hannibal: 추적코드 적용 (2018.05.10) --%>
	<jsp:include page="common/statistics.jsp"/>

	<link type="text/css" rel="stylesheet" media="all" href="//image.gojls.com/gojls/inc/css/event/20170327_main.css"/>
	<%--suppress CssOptimizeSimilarProperties --%>
	<style>
		iframe {
			display: none;
		}

		.invisible {
			display: none;
		}

		#blog ul li .description {
			background: url(//image.gojls.com/gojls/img_ad/event/170327/black_opacity60.png);
		}

		#blog ul li:hover .description {
			background: url(//image.gojls.com/gojls/img_ad/event/170327/black_opacity60.png);
		}

		#blog ul li .description_text {
			background: url(//image.gojls.com/gojls/img_ad/event/170327/black_opacity60.png);
		}

		#blog ul li:hover .description h5 {
			white-space: pre-line;
		}

		#blog ul li .description_text h5 {
			width: 154px;
			height: 158px;
			white-space: pre-line;
		}
	</style>

	<script src="resources/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="//image.gojls.com/common/js/jquery.carousel.6.2.1.js"></script>
	<script type="text/javascript" src="resources/js/jquery.cookie.js"></script>
	<%--<script src="resources/js/load-image.js"></script>--%>
	<script type="text/javascript" src="resources/js/secret.js"></script>

	<script>
		var jlsuser = $.cookie("jlsuser");
		if(jlsuser) {
			var jlsUserCookies = jlsuser.split("&");
			if(jlsUserCookies.length > 0) {
				for(var i = 0; i < jlsUserCookies.length; i++) {
					var splitee = jlsUserCookies[i].split("=");
					var name = splitee[0];
					var value = splitee[1];
					if(name === "USER_SEQ") {
						encryptedUserSequence = value;
					} else if(name === "USER_NM") {
						userName = value;
					} else if(name === "GT_USER_TYPE") {
						signedInAsStudent = (value === "US6001");
					}
				}
			}
		}

		isItEventPeriod = ${isItEventPeriod};
	</script>
</head>
<body>
<div class="visang_wrap">
	<div class="header">
		<h1 class="logo"><a href="http://gojls.com/index.do" target="_blank"><img src="//image.gojls.com/gojls/img_ad/event/170327/logo.png" alt="정상어학원로고"/></a></h1>
		<ul class="right">
			<li>
				<a href="http://gojls.com/about/notice_view.do?from=FTL&seq=104443" target="_blank">
					<img src="//image.gojls.com/gojls/img_ad/event/170327/right_02.png"/>
				</a>
			</li>
			<li class="arrow">
				<a href="http://www.gojls.com/etc/pop_event_1000.do" target="_blank">
					<img src="//image.gojls.com/gojls/img_ad/event/170327/right_01.png"/>
				</a>
			</li>
			<li class="arrow">
				<a href="http://gojls.com/about/notice_view.do?&seq=104734" target="_blank">
					<img src="/resources/images/right_03.png"/>
				</a>
			</li>
		</ul>
	</div>
	<div class="content_wrap">
		<ul class="ad_list">
			<li style="background:#4c6fd3">
				<a href="javascript:">
					<span class="tit">시크릿<br>영어노출<br>프로젝트 Mission</span>
					<img src="//image.gojls.com/gojls/img_ad/event/170327/nav_01.png"/>
				</a>
			</li>
			<li style="background:#86b952">
				<a href="javascript:">
					<span class="tit">영어노출 순간의 감동을<br>스케치 해 주세요</span>
					<img src="//image.gojls.com/gojls/img_ad/event/170327/nav_02.png"/>
				</a>
			</li>
			<li style="background:#d05754">
				<a href="javascript:">
					<span class="tit">반 친구들과 함께<br>Pre-Mission을<br>완성하라!</span>
					<img src="//image.gojls.com/gojls/img_ad/event/170327/nav_03.png"/>
				</a>
			</li>
			<li style="background:url(//image.gojls.com/gojls/img_ad/event/170327/bg.gif)repeat center top;">
				<a href="javascript:">
					<span class="tit">DreamTree Live<br>인증사진으로<br>100%선물 받는 방법</span>
					<img src="//image.gojls.com/gojls/img_ad/event/170327/nav_04.png"/>
				</a>
			</li>
		</ul>

		<div class="banner_zone">
			<div class="banner_area" style="background:#4c6fd3">
				<div class="event1">
					<span class="balloon1"><img src="//image.gojls.com/gojls/img_ad/event/170327/balloon_1.png"></span>
					<span class="balloon2"><img src="//image.gojls.com/gojls/img_ad/event/170327/balloon_2.png"></span>
					<p><img src="//image.gojls.com/gojls/img_ad/event/170327/event_1_1.png"></p>

					<p class="subbanner"><img src="//image.gojls.com/gojls/img_ad/event/170327/event_1_2.png"></p>
					<p class="subbanner"><img src="//image.gojls.com/gojls/img_ad/event/170327/event_1_3.png"></p>
					<span class="certi_bt">
						<a href="javascript:$($('.ad_list li')[1]).removeClass('off').addClass('on').click(); window.scrollTo(0, 0);">
							<img src="//image.gojls.com/gojls/img_ad/event/170327/certi_bt.png">
						</a>
					</span>
					<span class="certi_bt" style="margin-top: 797px;">
						<a href="http://chess.gojls.com/ucc/msucc/main">
							<img src="//image.gojls.com/gojls/img_ad/event/170327/certi_bt.png">
						</a>
					</span>
					<p class="subbanner"><a href="#event2"><img src="//image.gojls.com/gojls/img_ad/event/170327/event_1_4.png"></a></p>
					<p class="subbanner"><img src="//image.gojls.com/gojls/img_ad/event/170327/event_1_5.png"></p>
				</div>
			</div>

			<div class="banner_area" style="background:#86b952">
				<div class="event2">
					<p><img src="//image.gojls.com/gojls/img_ad/event/170327/event_2_6.png"/></p>
					<a id="abroad_prev" class="invisible" href="javascript:"><img src="//image.gojls.com/gojls/img_ad/event/170327/btn_pre.png" alt=""/></a>
					<a id="abroad_next" class="invisible" href="javascript:"><img src="//image.gojls.com/gojls/img_ad/event/170327/btn_next.png" alt=""/></a>

					<c:if test="${!isItEventPeriod}">
						<div class="eventfinish"></div>
						<h1>이벤트 종료</h1>
					</c:if>

					<div id="blog">
						<ul>
							<li id="list-item1">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							</li>
							<li id="list-item2">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							</li>
							<li id="list-item3">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							</li>
							<li id="list-item4">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							<li id="list-item5">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							</li>
							<li id="list-item6">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							</li>
							<li id="list-item7">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							</li>
							<li id="list-item8">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							</li>
							<li id="list-item9">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							</li>
							<li id="list-item10">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							</li>
							<li id="list-item11">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							</li>
							<li id="list-item12">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							</li>
							<li id="list-item13">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							</li>
							<li id="list-item14">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							</li>
							<li id="list-item15">
								<img src="resources/images/null%20photo.gif"/>
								<div class="description">
									<h5></h5>
								</div>
							</li>
						</ul>
					</div>
					<%--<p id="uploadCount" style="position: absolute; font-size: 15px; font-weight: bold; color: white; border: black; left: 860px;top: 750px;"></p>--%>
					<span><img src="//image.gojls.com/gojls/img_ad/event/170327/event_2_5.png"></span>
					<form id="imageUploadingForm" class="banner1" action="/home/upload-image" method="post" enctype="multipart/form-data" target="dummy">
						<div class="table_wrap">
							<table class="form">
								<colgroup>
									<col width="88%">
									<col width="12%">
								</colgroup>
								<tbody>
								<tr>
									<td>
										<div class="upload">
											<input id="fileName" type="text" class="file_input_text" readonly>
											<div class="file_input" style="cursor: auto;">
												<input id="inputForImage" name="file" type="file" class="file_input_hidden" style="display: none;" accept="image/*" onchange="onFileChange(this, event);">
												<button id="buttonBrowseForImage" type="button" class="orange" style="cursor: pointer;"><span>사진찾기</span></button>
											</div>
											<p>(첨부파일 10MB 이하)</p>
										</div>
									</td>
									<th rowspan="2"><img id="imageToUpload" src="//image.gojls.com/gojls/img_ad/event/170327/photo.gif" style="width:120px; height:120px;"></th>
								</tr>
								<tr class="attach">
									<td>
										<div class="memo" style="height: 50px;">
											<div class="input_word">
												<textarea id="imageDescription" placeholder="시크릿 영어노출 프로젝트 Mission을 수행하면서 느낀 점을 후기로 적어주세요!" maxlength="80" style="height: 50px;"></textarea>
											</div>
										</div>
										<p id="imageDescriptionState" style="position: absolute; right: 20px; top: 255px; font-size: 13px; color: #e82e51;"></p>
									</td>
								</tr>
								</tbody>
							</table>
						</div>
						<%--<span class="check_bt01"><a href="javascript:onClickUploadImage();"><img src="//image.gojls.com/gojls/img_ad/event/170327/photo_bt.png"></a></span>--%>
						<input type="button" class="check_bt01" value="" style="width:283px; height:72px; cursor: pointer; background: transparent url('//image.gojls.com/gojls/img_ad/event/170327/photo_bt.png');" onclick="onClickUploadImage();">
						<textarea id="inputImageDescription" name="imageDescription" style="display: none; white-space: pre-line;"></textarea>
						<input id="encryptedUserSequence" name="encryptedUserSequence" style="display: none;">
						<input id="userName" name="userName" style="display: none;">

						<div class="eventfinish2">
							<div class="end_info">
								<h3>인증 기간이 만료 되었습니다.<br> 그 동안 참여해 주셔서 감사합니다.</h3>
							</div>
						</div>
						<div class="btn" style="position: absolute; margin-top: -80px; margin-left: 290px;">
							<h4><a href="http://blog.naver.com/gojlsblog/221008818448"><img src="http://image.gojls.com/gojls/img_ad/event/check_bt.png"/></a></h4>
						</div>
					</form>

					<iframe id="dummy" name="dummy" onload="onDummyLoad(this);"></iframe>

					<div class="banner2">
						<div class="table_wrap">
							<table class="form">
								<tbody>
								<tr class="attach">
									<td>
										<div class="memo2">
											<div class="input_word">
												<textarea id="text" placeholder="시크릿 영어노출 프로젝트 Mission을 수행하면서 느낀 점을 후기로 적어주세요!" maxlength="80"></textarea>
											</div>
											<p id="textState" style="left: auto; right: 20px;"></p>
										</div>
									</td>
								</tr>
								</tbody>
							</table>
						</div>
						<span class="check_bt02"><a href="javascript: onClickUploadText();"><img src="//image.gojls.com/gojls/img_ad/event/170327/text_bt.png"></a></span>
						<div class="eventfinish2">
							<div class="end_info">
								<h3>인증 기간이 만료 되었습니다.<br> 그 동안 참여해 주셔서 감사합니다.</h3>
							</div>
						</div>
						<div class="btn" style="position: absolute; margin-top: -70px; margin-left: 290px;">
							<h4><a href="http://blog.naver.com/gojlsblog/221008818448"><img src="http://image.gojls.com/gojls/img_ad/event/check_bt.png"/></a></h4>
						</div>
					</div>
					<span class="check_bt"><a href="http://chess.gojls.com/ucc/msucc/main" target="_blank"><img src="//image.gojls.com/gojls/img_ad/event/170327/ucc_bt.png"></a></span>
					<span class="banner3"></span>
				</div>
			</div>

			<div class="banner_area" style="background:#d05754">
				<div class="event3">
					<p><img src="//image.gojls.com/gojls/img_ad/event/170327/event_4_1.png"/></p>
					<p><img src="//image.gojls.com/gojls/img_ad/event/170327/event_4_2.png"/></p>
					<p><img src="//image.gojls.com/gojls/img_ad/event/170327/event_4_3.png"/></p>
				</div>
			</div>

			<div class="banner_area" style="background:url(//image.gojls.com/gojls/img_ad/event/170327/bg.gif)repeat center top;">
				<div class="event4">
					<p><img src="//image.gojls.com/gojls/img_ad/event/170327/event_4_4.png"/></p>
					<span class="check_bt"><a href="http://blog.naver.com/gojlsblog?from=FW2" target="_blank"><img src="//image.gojls.com/gojls/img_ad/event/170327/check_bt.png"></a></span>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
