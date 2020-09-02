<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="Ko" lang="Ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta name="viewport" content="width=1081, user-scalable=yes">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="keywords" content=""/>
	<title></title>

	<%-- Hannibal: 추적코드 적용 (2018.05.10) --%>
	<jsp:include page="../common/statistics.jsp"/>

	<link type="text/css" rel="stylesheet" media="all" href="//image.gojls.com/gojls/inc/css/event/20170427_main.css"/>
	<script type="text/javascript" src="//image.gojls.com/common/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="//image.gojls.com/common/js/jquery.scrollTo-min.js"></script>
	<script type="text/javascript" src="/resources/js/wanted.js"></script>

	<script>
		//  퀵메뉴
		$(function() {
			var $body = $("body");

			var wsTop;
			var aSide;
			var aSideOffSet;

			aSide = $("#quick_rg");
			aSideOffSet = aSide.offset();

			if(aSide.length !== 0) {
				$(window).off("scroll").on("scroll", function() {
					wsTop = $(this).scrollTop() + 150;
					if(aSideOffSet.top < wsTop) {
						aSide.addClass("fixed")
					} else {
						aSide.removeClass("fixed")
					}
				});
			}
		});

		/* scroll */
		function scrollEvent() {
			var location = $(window).scrollTop();
			//$(".pos_txt").text(locate);
			if(location == 0) {
				sr_nav(0, "scroll");
			} else if(location > $("#s1").offset().top && location < $("#s2").offset().top) {
				sr_nav(1, "scroll");
			} else if(location > $("#s2").offset().top && location < $("#s3").offset().top) {
				sr_nav(2, "scroll");
			} else if(location > $("#s3").offset().top && location < $("#s4").offset().top) {
				sr_nav(3, "scroll");
			}
		}
		$(document).ready(function() {
			$(window).scroll(function() { scrollEvent(); });
			$(window).resize(function() { scrollEvent(); });
		});

		/* global navigation */
		function sr_nav(n, scroll) {
			if(!scroll) {
				$(window).scrollTo($("#s" + n).offset().top, {
					duration: 500, axis: 'y', onAfter: function() {
						$("#sr_nav").find(".nav").attr("class", "nav s_" + n);
						try {
							setVideoScrollControll(n);
						} catch(err) {}

					}
				});
			} else {
				$("#sr_nav").find(".nav").attr("class", "nav s_" + n);
				try {
					setVideoScrollControll(n);
				} catch(err) {}
			}
		}

		function _flash1(id) {
			var max = 2;		//맥스숫자
			for(var i = 1; i <= max; i++) {
				var obj = document.getElementById("flash1_" + i);
				var img = document.getElementById("flash" + i);
				if(i === id) {
					obj.style.display = "";
					img.src = "//image.gojls.com/gojls/img_ad/event/170427/tab_study_flash" + i + "_over.gif";	//원본
				} else {
					obj.style.display = "none";
					img.src = "//image.gojls.com/gojls/img_ad/event/170427/tab_study_flash" + i + ".gif";	//변할꺼
				}
			}
		}
	</script>
</head>
<body>
<span class="file_input02"><img src="//image.gojls.com/gojls/img_ad/event/170427/step3_que_tit.png"></span>
<div id="content">
	<div id="quick_rg">
		<li><img src="//image.gojls.com/gojls/img_ad/event/170427/sky_01.png"/></li>
		<li><a href="javascript: _flash1(1); sr_nav(1);"><img src="//image.gojls.com/gojls/img_ad/event/170427/sky_02.png"/></a></li>
		<li><a href="javascript: _flash1(2); sr_nav(5);"><img src="//image.gojls.com/gojls/img_ad/event/170427/sky_03.png"/></a></li>
		<li><a href="javascript: sr_nav(1);"><img src="//image.gojls.com/gojls/img_ad/event/170427/sky_04.png"/></a></li>
	</div>
	<div id="s1"></div>
	<!-- 텝버튼 -->
	<div class="nav_con">
		<ul class="nav">
			<li class=""><span><a href="http://gojls.com/index.do" target="_blank"><img src="//image.gojls.com/gojls/img_ad/event/170427/nav_logo.gif"/></a></span></li>
			<a href="javascript: _flash1(1); sr_nav(5);" onFocus="blur()">
				<img id="flash1" src="//image.gojls.com/gojls/img_ad/event/170427/tab_study_flash1_over.gif" name="flash1"> </a>
			<a href="javascript: _flash1(2); sr_nav(5);" onFocus="blur()">
				<img id="flash2" src="//image.gojls.com/gojls/img_ad/event/170427/tab_study_flash2.gif" name="flash2"></a>
		</ul>
	</div>
	<!-- 텝 1 -->
	<div id="flash1_1" style="display:;">
		<div id="sr_wrap">
			<div id="s2" class="section">
				<div class="content">
					<p><img src="//image.gojls.com/gojls/img_ad/event/170427/event_01.jpg"/></p>
				</div>
			</div>
			<div id="s3" class="section">
				<div class="content">
					<p><img src="//image.gojls.com/gojls/img_ad/event/170427/event_02.png"/></p>
					<h1 class="report_bt"><a href="javascript: _flash1(2);"><img src="//image.gojls.com/gojls/img_ad/event/170427/report_bt.png"></a></h1>
				</div>
			</div>
			<div id="s4" class="section">
				<div class="content">
					<h1 class="arrest_bt"><a href="javascript: _flash1(2);"><img src="//image.gojls.com/gojls/img_ad/event/170427/arrest_bt.png"></a></h1>
					<p><img src="//image.gojls.com/gojls/img_ad/event/170427/event_04.png"/></p>
				</div>
				<h1>ⓒ JLS CO., LTD. All Rights Reserved.</h1>
			</div>
		</div>
	</div>
	<!-- 텝 2 -->
	<div id="flash1_2" style="display: none;">
		<div id="sr_wrap">
			<div id="s5" class="section">
				<div class="content">
					<p><img src="//image.gojls.com/gojls/img_ad/event/170427/board_top.gif"/></p>
					<ul class="brand">
						<li>
							<h3><img src="//image.gojls.com/gojls/img_ad/event/170427/state01.png"/></h3>
							<h4></h4>
							<div class="col">
								<table>
									<colgroup>
										<col width="50%">
										<col width="50%">
									</colgroup>
									<thead>
									<tr rowspan="5"><a href="#" id="abroad_prev"><img src="//image.gojls.com/gojls/img_ad/event/170427/btn_pre.png" alt=""/></a>
										<a href="#" id="abroad_next"><img src="//image.gojls.com/gojls/img_ad/event/170427/btn_next.png" alt=""/></a></tr>
									</thead>
									<tbody>
									<tr>
										<th id="course"><a href="#"><img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif"/></a></th>
										<th><img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif" border="0"/></th>
									</tr>
									<tr>
										<th><a href="#"><img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif"/></a></th>
										<th><a href="#"><img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif"/></a></th>
									</tr>
									<tr>
										<th><a href="#"><img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif"/></a></th>
										<th><a href="#"><img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif"/></a></th>
									</tr>
									<tr>
										<th><a href="#"><img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif"/></a></th>
										<th><a href="#"><img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif"/></a></th>
									</tr>
									<tr>
										<th><a href="#"><img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif"/></a></th>
										<th><a href="#"><img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif"/></a></th>
									</tr>
									</tbody>
								</table>
							</div>
							<h5></h5>
							<p><img src="//image.gojls.com/gojls/img_ad/event/170427/state01_top3.png"/></p>
							<h6><b>1위</b> 5월18일 오픈</h6>
							<h6><b>2위</b> 5월18일 오픈</h6>
							<h6><b>3위</b> 5월18일 오픈</h6>
						</li>

						<li>
							<h3><img src="//image.gojls.com/gojls/img_ad/event/170427/state02.png"/></h3>
							<h4></h4>
							<div class="col">
								<table>
									<colgroup>
										<col width="50%">
										<col width="50%">
									</colgroup>
									<thead>
									<tr rowspan="5"><a href="#" id="abroad_prev"><img src="//image.gojls.com/gojls/img_ad/event/170427/btn_pre.png" alt=""/></a>
										<a href="#" id="abroad_next"><img src="//image.gojls.com/gojls/img_ad/event/170427/btn_next.png" alt=""/></a></tr>
									</thead>
									<tbody>
									<tr>
										<th id="course"><a href="#"><img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif"/></a></th>
										<th><img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif"/></th>
									</tr>
									<tr>
										<th><img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif"/></th>
										<th><img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif"/></th>
									</tr>
									<tr>
										<th><img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif"/></th>
										<th><img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif"/></th>
									</tr>
									<tr>
										<th><img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif"/></th>
										<th><img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif"/></th>
									</tr>
									<tr>
										<th><img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif"/></th>
										<th><img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif"/></th>
									</tr>
									</tbody>
								</table>
							</div>
							<h5></h5>
							<p><img src="//image.gojls.com/gojls/img_ad/event/170427/state02_top3.png"/></p>
							<h6><b>1위</b> 5월18일 오픈</h6>
							<h6><b>2위</b> 5월18일 오픈</h6>
							<h6><b>3위</b> 5월18일 오픈</h6>
						</li>
					</ul>
				</div>
			</div>
			<div id="s6" class="section">
				<!--내신 기출 유사문제 신고 센터-->
				<div class="content">
					<div class="edit">
						<h3><img src="//image.gojls.com/gojls/img_ad/event/170427/state01_title.png"/></h3>
						<h3>신고 접수 기간 : 5월 18일~ 5월 31일 </h3>
						<ul class="entertop">
							<li>
								<span>학년</span><input type="text" title="학년" value="" readonly/>
								<span>학교</span><input type="text" title="학교" value="" readonly/>
								<span>신고자 ID</span><input type="text" title="신고자 ID" value="" readonly/>
								<select id="bank" title="접수지역">
									<option value="">접수지역</option>
									<option value="">서울</option>
									<option value="">경기</option>
									<option value="">인천/강원</option>
									<option value="">부산/경남</option>
									<option value="">대구/경북</option>
									<option value="">광주/전라</option>
									<option value="">대전/충청</option>
								</select>
							</li>
						</ul>
						<ul class="enter">
							<li>
								<span><img src="//image.gojls.com/gojls/img_ad/event/170427/number.png"></span>
								<select title="객관식">
									<option value="">객관식</option>
									<option value="">주관식</option>
								</select>
								<select title="1">
									<option value="">1</option>
									<option value="">2</option>
									<option value="">3</option>
									<option value="">4</option>
									<option value="">5</option>
									<option value="">6</option>
									<option value="">7</option>
									<option value="">8</option>
									<option value="">9</option>
									<option value="">10</option>
									<option value="">11</option>
									<option value="">12</option>
									<option value="">13</option>
									<option value="">14</option>
									<option value="">15</option>
									<option value="">16</option>
									<option value="">17</option>
									<option value="">18</option>
									<option value="">19</option>
									<option value="">20</option>
									<option value="">21</option>
									<option value="">22</option>
									<option value="">23</option>
									<option value="">24</option>
									<option value="">25</option>
									<option value="">26</option>
									<option value="">27</option>
									<option value="">28</option>
									<option value="">29</option>
									<option value="">30</option>
									<option value="">31</option>
									<option value="">32</option>
									<option value="">33</option>
									<option value="">34</option>
									<option value="">35</option>
								</select>
								기출시험지 문항번호를 선택해주세요
							</li>
							<li>
								<div class="upload_img">
									<div class="file_input01">
										<img src="//image.gojls.com/gojls/img_ad/event/170427/step1_que_tit.png">
										<button type="button" class="orange" onclick="alert('현재 접수 기간이 아닙니다.\n접수 기간 : 5월18일~ 5월31일');"><span>사진찾기</span></button>
										<p><img src="//image.gojls.com/gojls/img_ad/event/170427/step1_01.jpg"></p>
									</div>

									<div class="file_input02">
										<img src="//image.gojls.com/gojls/img_ad/event/170427/step2_que_tit.png">
										<button type="button" class="orange" onclick="alert('현재 접수 기간이 아닙니다.\n접수 기간 : 5월18일~ 5월31일');"><span>사진찾기</span></button>
										<p><img src="//image.gojls.com/gojls/img_ad/event/170427/step1_02.jpg"></p>
									</div>
								</div>
							</li>
							<li>
								<textarea id="memo" placeholder="유사문제 혹은 기출시험에 도움된 내신학습자료를 주신 선생님께 메시지를 남겨주세요."></textarea>
								<p><b>00자</b>/80자</p>
							</li>
						</ul>
						<h1 class=""><a href="javascript: alert('현재 접수 기간이 아닙니다.\n접수 기간 : 5월18일~ 5월31일');"><img src="//image.gojls.com/gojls/img_ad/event/170427/anmelden_bt.png"></a></h1>
						<h1><img src="//image.gojls.com/gojls/img_ad/event/170427/listen_01.gif"></h1>
					</div>
				</div>
				<br><br><br>
				<!--내신 고난도 문제 검거 센터-->
				<div class="content">
					<div class="edit">
						<h3><img src="//image.gojls.com/gojls/img_ad/event/170427/state02_title.png"/></h3>
						<h3>검거 접수 기간 : 5월 18일~ 5월 31일 </h3>
						<ul class="entertop">
							<li>
								<span>학년</span><input type="text" title="학년" value="" readonly/>
								<span>학교</span><input type="text" title="학교" value="" readonly/>
								<span>신고자 ID</span><input type="text" title="신고자 ID" value="" readonly/>
								<select title="접수지역">
									<option value="">접수지역</option>
									<option value="">서울</option>
									<option value="">경기</option>
									<option value="">인천/강원</option>
									<option value="">부산/경남</option>
									<option value="">대구/경북</option>
									<option value="">광주/전라</option>
									<option value="">대전/충청</option>
								</select>
							</li>
						</ul>
						<ul class="enter">
							<li>
								<span><img src="//image.gojls.com/gojls/img_ad/event/170427/number.png"></span>
								<select title="객관식">
									<option value="">객관식</option>
									<option value="">주관식</option>
								</select>
								<select title="1">
									<option value="">1</option>
									<option value="">2</option>
									<option value="">3</option>
									<option value="">4</option>
									<option value="">5</option>
									<option value="">6</option>
									<option value="">7</option>
									<option value="">8</option>
									<option value="">9</option>
									<option value="">10</option>
									<option value="">11</option>
									<option value="">12</option>
									<option value="">13</option>
									<option value="">14</option>
									<option value="">15</option>
									<option value="">16</option>
									<option value="">17</option>
									<option value="">18</option>
									<option value="">19</option>
									<option value="">20</option>
									<option value="">21</option>
									<option value="">22</option>
									<option value="">23</option>
									<option value="">24</option>
									<option value="">25</option>
									<option value="">26</option>
									<option value="">27</option>
									<option value="">28</option>
									<option value="">29</option>
									<option value="">30</option>
									<option value="">31</option>
									<option value="">32</option>
									<option value="">33</option>
									<option value="">34</option>
									<option value="">35</option>
								</select>
								기출시험지 문항번호를 선택해주세요
							</li>
							<li>
								<div class="upload_img">
									<div class="file_input01">
										<img src="//image.gojls.com/gojls/img_ad/event/170427/step1_que_tit.png">
										<button type="button" class="orange" onclick="alert('현재 접수 기간이 아닙니다.\n접수 기간 : 5월18일~ 5월31일');"><span>사진찾기</span></button>
										<p><img src="//image.gojls.com/gojls/img_ad/event/170427/step2_01.jpg"></p>
									</div>
									<div class="file_input02">
										<img src="//image.gojls.com/gojls/img_ad/event/170427/step3_que_tit.png">
										<button type="button" class="orange" onclick="alert('현재 접수 기간이 아닙니다.\n접수 기간 : 5월18일~ 5월31일');"><span>사진찾기</span></button>
										<p><img src="//image.gojls.com/gojls/img_ad/event/170427/step2_02.jpg"></p>
									</div>
								</div>
							</li>
						</ul>
						<h1 class=""><a href="javascript: alert('현재 접수 기간이 아닙니다.\n접수 기간 : 5월18일~ 5월31일');"><img src="//image.gojls.com/gojls/img_ad/event/170427/completion_bt.png"></a></h1>
						<h1><img src="//image.gojls.com/gojls/img_ad/event/170427/listen_02.gif"></h1>
					</div>
					<h1>ⓒ JLS CO., LTD. All Rights Reserved.</h1>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
