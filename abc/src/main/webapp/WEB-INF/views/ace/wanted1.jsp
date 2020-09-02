<%--suppress RequiredAttributes --%>
<%--suppress JspAbsolutePathInspection --%>
<%--suppress JSUnresolvedLibraryURL --%>
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

	<script type="text/javascript" src="resources/js/jquery.cookie.js"></script>
	<script type="text/javascript" src="/resources/js/wanted.js"></script>

	<style>
		button { cursor: pointer; }

		div.col th {
			position: relative;
		}

		div.col th:hover div.description {
			height: 100%;
			white-space: pre-line;
			display: block;
		}

		div.col th div.description {
			position: absolute;
			bottom: 0;
			height: 25px;
			max-height: 100%;
			overflow: hidden;
			text-overflow: ellipsis;
			background: url(//image.gojls.com/gojls/img_ad/event/170327/black_opacity60.png);
			white-space: nowrap;
			width: 215px;
			padding: 5px;
			color: #fffcd9;
			font-size: 12px;
			-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
			-moz-box-sizing: border-box; /* Firefox, other Gecko */
			box-sizing: border-box; /* Opera/IE 8+ */
		}

		div.col th .delete {
			position: absolute;
			top: -1px;
			right: 5px;
			width: 20px;
			height: 20px;
			line-height: 19px;
			font-weight: bold;
			text-align: center;
			border-radius: 0 0 3px 3px;
			border: 1px solid #1a1a1a;
			background: #2a2a2a;
			box-shadow: 0 5px 5px rgba(255, 255, 255, 0.1) inset;
			cursor: pointer;
			color: white;
		}

		table .course .view { position: absolute; z-index: 2; width: 400px; height: 223px; left: 15px; top: px; border-radius: 3px; border: 2px solid #222; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5); background: #fff; }

		table .course .view .close { position: absolute; top: -1px; right: 5px; width: 20px; height: 20px; line-height: 19px; font-weight: bold; text-align: center; border-radius: 0 0 3px 3px; border: 1px solid #1a1a1a; background: #2a2a2a; box-shadow: 0 5px 5px rgba(255, 255, 255, 0.1) inset; cursor: pointer; }

		table .course .view .close:hover { border: 1px solid #111; background: #222; }

		table .course .view .close:active { box-shadow: 0 5px 5px rgba(0, 0, 0, 0.1) inset; }

		table .course .view h1 { position: absolute; padding: 5px 5px; width: 390px; height: 60px; top: 125px; font-size: 12px; line-height: 16px; font-weight: bold; text-align: left; background: #2a2a2a; }
	</style>
	<script>
		areFormsEnabled = true;

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
	</script>
</head>
<body>
<span class="file_input02"><img src="//image.gojls.com/gojls/img_ad/event/170427/step3_que_tit.png"></span>
<div id="content">
	<div id="quick_rg" class="fixed">
		<li><img src="//image.gojls.com/gojls/img_ad/event/170427/sky_01.png"/></li>
		<li><a href="javascript: _flash1(1); sr_nav(1);"><img src="//image.gojls.com/gojls/img_ad/event/170427/sky_02.png"/></a></li>
		<li><a href="javascript: _flash1(2); sr_nav(5);"><img src="//image.gojls.com/gojls/img_ad/event/170427/sky_03.png"/></a></li>
		<li><a href="javascript: sr_nav(1);"><img src="//image.gojls.com/gojls/img_ad/event/170427/sky_04.png"/></a></li>
	</div>
	<div id="s1"></div>
	<!-- 텝버튼 -->
	<div class="nav_con">
		<ul class="nav">
			<li class=""><span>
			<a href="http://gojls.com/index.do" target="_blank">
			<img src="//image.gojls.com/gojls/img_ad/event/170427/nav_logo.gif"/></a></span></li>
			
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
							<h4 id="reportCountArea" style="visibility: hidden;">현재 <b id="reportCount"></b>건 신고 중</h4>
							<div class="col">
								<table>
									<colgroup>
										<col width="50%">
										<col width="50%">
									</colgroup>
									<thead>
									<tr rowspan="5">
										<a href="javascript:" id="previousReports">
											<img src="//image.gojls.com/gojls/img_ad/event/170427/btn_pre.png" alt="" style="position: absolute; top: 300px; left: -10px;"/>
										</a>
										<a href="javascript:" id="nextReports">
											<img src="//image.gojls.com/gojls/img_ad/event/170427/btn_next.png" alt="" style="position: absolute; top: 300px; left: 465px;"/>
										</a>
									</tr>
									</thead>
									<tbody>
									<tr id="report1">
										<th class="course left">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
										<th class="course right">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
									</tr>
									<tr id="report2">
										<th class="left">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
										<th class="right">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
									</tr>
									<tr id="report3">
										<th class="left">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
										<th class="right">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
									</tr>
									<tr id="report4">
										<th class="left">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
										<th class="right">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
									</tr>
									<tr id="report5">
										<th class="left">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
										<th class="right">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic01.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
									</tr>
									</tbody>
								</table>
							</div>
							<h5 id="myReportCountArea">나의 신고 건수 <b id="myReportCount">0</b>건</h5>
							<p><img src="//image.gojls.com/gojls/img_ad/event/170427/state01_top3.png" alt=""/></p>
							<h6 id="reportingRegion1"></h6>
							<h6 id="reportingRegion2"></h6>
							<h6 id="reportingRegion3"></h6>
						</li>

						<li>
							<h3><img src="//image.gojls.com/gojls/img_ad/event/170427/state02.png" alt=""/></h3>
							<h4 id="arrestCountArea" style="visibility: hidden;">현재 <b id="arrestCount"></b>건 검거 중</h4>
							<div class="col">
								<table>
									<colgroup>
										<col width="50%">
										<col width="50%">
									</colgroup>
									<thead>
									<tr rowspan="5">
										<a href="javascript:" id="previousArrests">
											<img src="//image.gojls.com/gojls/img_ad/event/170427/btn_pre.png" alt="" style="position: absolute; top: 300px; left: -10px;"/>
										</a>
										<a href="javascript:" id="nextArrests">
											<img src="//image.gojls.com/gojls/img_ad/event/170427/btn_next.png" alt="" style="position: absolute; top: 300px; left: 465px;"/>
										</a>
									</tr>
									</thead>
									<tbody>
									<tr id="arrest1">
										<th class="course left">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
										<th class="course right">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
									</tr>
									<tr id="arrest2">
										<th class="left">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
										<th class="right">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
									</tr>
									<tr id="arrest3">
										<th class="left">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
										<th class="right">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
									</tr>
									<tr id="arrest4">
										<th class="left">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
										<th class="right">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
									</tr>
									<tr id="arrest5">
										<th class="left">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
										<th class="right">
											<div class="description" onclick="$(this).next().get(0).click();"></div>
											<a href="javascript:" target="_blank">
												<img src="//image.gojls.com/gojls/img_ad/event/170427/pic02.gif" alt="" width="215px" height="120px"/>
											</a>
										</th>
									</tr>
									</tbody>
								</table>
							</div>
							<h5 id="myArrestCountArea">나의 검거 건수 <b id="myArrestCount">0</b>건</h5>
							<p><img src="//image.gojls.com/gojls/img_ad/event/170427/state02_top3.png" alt=""/></p>
							<h6 id="arrestingRegion1"></h6>
							<h6 id="arrestingRegion2"></h6>
							<h6 id="arrestingRegion3"></h6>
						</li>
					</ul>
				</div>
			</div>
			<div id="s6" class="section">
				<!--내신 기출 유사문제 신고 센터-->
				<div class="content">
					<form id="reportingForm" class="edit" action="/ace/report" method="post" enctype="multipart/form-data" target="reportingIframe" onsubmit="validateReport(this, event);">
						<input name="encryptedUserSequence" type="text" class="userSequenceContainer" style="display: none;">
						<h3><img src="//image.gojls.com/gojls/img_ad/event/170427/state01_title.png" alt=""/></h3>
						<h3>신고 접수 기간 : 5월 18일~ 5월 31일 </h3>
						<ul class="entertop">
							<li>
								<span>학년</span><input type="text" title="학년" disabled/>
								<span>학교</span><input type="text" title="학교" disabled/>
								<span>신고자 ID</span><input type="text" title="신고자ID" disabled/>
								<select name="region" title="접수지역">
									<option>접수지역</option>
									<option>서울</option>
									<option>경기</option>
									<option>인천/강원</option>
									<option>부산/경남</option>
									<option>대구/경북</option>
									<option>광주/전라</option>
									<option>대전/충청</option>
								</select>
							</li>
						</ul>
						<ul class="enter">
							<li>
								<span><img src="//image.gojls.com/gojls/img_ad/event/170427/number.png"></span>
								<select name="questionType" title="문항 유형">
									<option>객관식</option>
									<option>주관식</option>
									<option>서술형</option>
								</select>
								<select name="questionNumber" title="1">
									<option>1</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
									<option>5</option>
									<option>6</option>
									<option>7</option>
									<option>8</option>
									<option>9</option>
									<option>10</option>
									<option>11</option>
									<option>12</option>
									<option>13</option>
									<option>14</option>
									<option>15</option>
									<option>16</option>
									<option>17</option>
									<option>18</option>
									<option>19</option>
									<option>20</option>
									<option>21</option>
									<option>22</option>
									<option>23</option>
									<option>24</option>
									<option>25</option>
									<option>26</option>
									<option>27</option>
									<option>28</option>
									<option>29</option>
									<option>30</option>
									<option>31</option>
									<option>32</option>
									<option>33</option>
									<option>34</option>
									<option>35</option>
								</select>
								기출시험지 문항번호를 선택해주세요
							</li>
							<li>
								<div class="upload_img">
									<div class="file_input01">
										<input id="file1" name="file1" type="file" style="display: none;" accept="image/*" onchange="onFileChange(this, 'preview1')">
										<img src="//image.gojls.com/gojls/img_ad/event/170427/step1_que_tit.png">
										<button type="button" class="orange" onclick="onClickBrowse($('#file1'))"><span>사진찾기</span></button>
										<p><img id="preview1" class="preview" src="//image.gojls.com/gojls/img_ad/event/170427/step1_01.jpg" width="400" height="223"></p>
									</div>

									<div class="file_input02">
										<input id="file2" name="file2" type="file" style="display: none;" accept="image/*" onchange="onFileChange(this, 'preview2')">
										<img src="//image.gojls.com/gojls/img_ad/event/170427/step2_que_tit.png">
										<button type="button" class="orange" onclick="onClickBrowse($('#file2'))"><span>사진찾기</span></button>
										<p><img id="preview2" class="preview" src="//image.gojls.com/gojls/img_ad/event/170427/step1_02.jpg" width="400" height="223"></p>
									</div>
								</div>
							</li>
							<li>
								<textarea id="memo" name="comment" placeholder="유사문제 혹은 기출시험에 도움된 내신학습자료를 주신 선생님께 메시지를 남겨주세요." maxlength="80"></textarea>
								<p id="memoState"></p>
							</li>
						</ul>
						<h1 class="">
							<button type="submit">
								<img src="//image.gojls.com/gojls/img_ad/event/170427/anmelden_bt.png">
							</button>
						</h1>
						<h1><img src="//image.gojls.com/gojls/img_ad/event/170427/listen_01.gif"></h1>
					</form>
					<iframe id="reportingIframe" name="reportingIframe" style="display: none;"></iframe>
				</div>
				<br><br><br>
				<!--내신 고난도 문제 검거 센터-->
				<div class="content">
					<form id="arrestingForm" class="edit" action="/ace/arrest" method="post" enctype="multipart/form-data" target="arrestingIframe" onsubmit="validateArrest(this, event);">
						<input name="encryptedUserSequence" type="text" class="userSequenceContainer" style="display: none;">
						<h3><img src="//image.gojls.com/gojls/img_ad/event/170427/state02_title.png"/></h3>
						<h3>검거 접수 기간 : 5월 18일~ 5월 31일 </h3>
						<ul class="entertop">
							<li>
								<span>학년</span><input type="text" title="학년" disabled/>
								<span>학교</span><input type="text" title="학교" disabled/>
								<span>신고자 ID</span><input type="text" title="신고자ID" disabled/>
								<select name="region" title="접수지역">
									<option>검거지역</option>
									<option>서울</option>
									<option>경기</option>
									<option>인천/강원</option>
									<option>부산/경남</option>
									<option>대구/경북</option>
									<option>광주/전라</option>
									<option>대전/충청</option>
								</select>
							</li>
						</ul>
						<ul class="enter">
							<li>
								<span><img src="//image.gojls.com/gojls/img_ad/event/170427/number.png"></span>
								<select name="questionType" title="문항 유형">
									<option>객관식</option>
									<option>주관식</option>
									<option>서술형</option>
								</select>
								<select name="questionNumber" title="1">
									<option>1</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
									<option>5</option>
									<option>6</option>
									<option>7</option>
									<option>8</option>
									<option>9</option>
									<option>10</option>
									<option>11</option>
									<option>12</option>
									<option>13</option>
									<option>14</option>
									<option>15</option>
									<option>16</option>
									<option>17</option>
									<option>18</option>
									<option>19</option>
									<option>20</option>
									<option>21</option>
									<option>22</option>
									<option>23</option>
									<option>24</option>
									<option>25</option>
									<option>26</option>
									<option>27</option>
									<option>28</option>
									<option>29</option>
									<option>30</option>
									<option>31</option>
									<option>32</option>
									<option>33</option>
									<option>34</option>
									<option>35</option>
								</select>
								기출시험지 문항번호를 선택해주세요
							</li>
							<li>
								<div class="upload_img">
									<div class="file_input01">
										<input id="file3" name="file3" type="file" style="display: none;" accept="image/*" onchange="onFileChange(this, 'preview3');">
										<img src="//image.gojls.com/gojls/img_ad/event/170427/step1_que_tit.png">
										<button type="button" class="orange" onclick="onClickBrowse($('#file3'))"><span>사진찾기</span></button>
										<p><img id="preview3" class="preview" src="//image.gojls.com/gojls/img_ad/event/170427/step2_01.jpg" width="400" height="223"></p>
									</div>
									<div class="file_input02">
										<input id="file4" name="file4" type="file" style="display: none;" accept="image/*" onchange="onFileChange(this, 'preview4');">
										<img src="//image.gojls.com/gojls/img_ad/event/170427/step3_que_tit.png">
										<button type="button" class="orange" onclick="onClickBrowse($('#file4'))"><span>사진찾기</span></button>
										<p><img id="preview4" class="preview" src="//image.gojls.com/gojls/img_ad/event/170427/step2_02.jpg" width="400" height="223"></p>
									</div>
								</div>
							</li>
						</ul>
						<h1>
							<button type="submit">
								<img src="//image.gojls.com/gojls/img_ad/event/170427/completion_bt.png">
							</button>
						</h1>
						<h1><img src="//image.gojls.com/gojls/img_ad/event/170427/listen_02.gif"></h1>
					</form>
					<iframe id="arrestingIframe" name="arrestingIframe" style="display: none;"></iframe>
					<h1>ⓒ JLS CO., LTD. All Rights Reserved.</h1>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
