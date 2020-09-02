<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=1202, user-scalable=yes">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Pragma" content="no-cache">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">

<title> 정상어학원 이벤트</title>

<%-- Hannibal: 추적코드 적용 (2018.05.10) --%>
<jsp:include page="../../common/statistics.jsp"/>

<link type="text/css" rel="stylesheet" media="all" href="//image.gojls.com/newjls/css/event/20170907_main.css" />

<style>
		iframe {
			display: none;
		}
		.invisible {
			display: none;
		}
		#userName{
			font-size: 25px;
			font-family: 'NanumSquare';
			text-align: center;
		}
		
		#userTime{
			font-size: 43px;
			font-family: 'NanumSquare';
			text-align: center;
		}
	
		#totalCurrentEvnetUploadCount{
			font-size:38px;
			font-family: 'NanumSquare';
			text-align: center;
		}
		
		#totalSelectEventUploadCount{
			font-size:40px;
			color:#ff4e0e;
			font-family: "나눔 고딕","Nanum Gothic","맑은 고딕",Malgun Gothic,"돋움",Dotum,arial,sans-serif;
		}
		
		#eventPeriod{
			font-size: 18px;
			font-weight:bold;
			text-align:center;
			line-height:1.3;		
			font-family: "나눔 고딕","Nanum Gothic","맑은 고딕",Malgun Gothic,"돋움",Dotum,arial,sans-serif;
			text-align: center;
		}
		
</style>
	
<script type="text/javascript" src="//image.gojls.com/common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="//image.gojls.com/common/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="//image.gojls.com/common/js/jquery.scrollTo-min.js"></script>
<script type="text/javascript" src="resources/js/dlive201709.js"></script>

<script>
cEventSeq = ${currentSeq};
cProcessState = ${currentProcessState};
cAnnounceDate = ${announceWinnerDate};
cStartDate = ${startDate};
cCloseDate = ${closeDate};

userCount = ${studentCount};
isCookies = ${isCookies};
isTap = ${tap};

selEventSeq = ${currentSeq};
loadOwnCount = 0;
loadPageCount = 0;
totalUploadCount = 0;
</script>



<script>
//  퀵메뉴 
$(function(){
	var $body = $('body');
	
	var wsTop;
	var aSide;
	var aSideOffSet;
	
	aSide = $('#quick_rg'),
	aSideOffSet = aSide.offset();
	
	if (aSide.length != 0) {
		$(window).off('scroll').on('scroll',function(){
			wsTop  = $(this).scrollTop() + 150;
			if (aSideOffSet.top < wsTop) {
				aSide.addClass('fixed')
			} else {
				aSide.removeClass('fixed')
			}
		});
	};
	
});


/* scroll */

/* scroll */
function scrollEvent() {		
	locate = $(window).scrollTop();
	if( locate == 0) {
		sr_nav(0,"scroll");
	}else if( locate > $("#s1").offset().top && locate < $("#s2").offset().top) {		
		sr_nav(1,"scroll");
	}else if( locate > $("#s2").offset().top && locate < $("#s3").offset().top) {
		sr_nav(2,"scroll");
	}
}


/* global navigation */
function sr_nav(n,scroll){	
	if (!scroll)
	{
		$(window).scrollTo( $("#s"+n).offset().top, { duration:500, axis:'y', onAfter:function(){			
			$("#sr_nav .nav").attr("class","nav s_"+n);
			try {
				setVideoScrollControll(n);				
			} catch(err){}

		}});
	}else{
		$("#sr_nav .nav").attr("class","nav s_"+n);
		try {
			setVideoScrollControll(n);				
		} catch(err){}
	}

	nowMenuNum = n;
}

			//<![CDATA[
			//<![CDATA[
			function _flash1(id) {
				var max = 2;		//맥스숫자
					for (var i = 1; i <= max; i++) {
						var obj = document.getElementById("flash1_" + i);
						var img = document.getElementById("flash" + i);
							if (i == id) {
								obj.style.display = "";
								img.src = "//image.gojls.com/newjls/img/event/20170907_event/tab_study_flash" + i + "_over.png";	//원본
							} else {
								obj.style.display = "none";
								img.src = "//image.gojls.com/newjls/img/event/20170907_event/tab_study_flash" + i + ".png";	//변할꺼
							}
					}
			}
			//]]>

</script>

	
</head>
<body>

<c:if test="${studentCount==0}">
	<input type="hidden" id="selUserName" value="000"/>
	<input type="hidden" id="selUserSeq" value=""/>
</c:if>
<c:if test="${studentCount>0}">
	<input type="hidden" id="selUserName" value="${studentList.get(0).userNM}"/>
	<input type="hidden" id="selUserSeq" value="${studentList.get(0).userSeq}"/>
</c:if>
							
	
<div id="content">
		
		<!-- 하단 이벤트 상황판-->
		<div id="head_gnb">
      		<ul class="remote">
					<li>
						<!-- 현재일-->
						<h5>현재일 : ${todayDateStr}</h5>
						<!-- 사용자 이름-->
						<h5><b><label id="userName">
							<c:if test="${studentCount==0}">000학생</c:if>
							<c:if test="${studentCount>0}">${studentList.get(0).userNM}학생</c:if>
						</label></b> 영어노출 누적 시간</h5>
						
					</li>	
					<li>
						<!-- 사용자 누적 시간-->
						<h2><b><label id="userTime">
							<c:if test="${studentCount==0}">0,000</c:if>
							<c:if test="${studentCount>0}">${studentList.get(0).userTime}</c:if>
						</label></b>시간</h2>
						<!-- 사용자 없을 경우-->
						<c:if test="${studentCount==0}"><h3>*CHESS학생/학부모 로그인 시, 영어노출시간 확인 가능</h3></c:if>                        
                       	<!-- 사용자 선택 콤보-->                        	
                       	<c:if test="${studentCount>1}"><h4>
                       		<c:forEach items="${studentList}" var="item" varStatus="status">
						 			<input type="radio" name="userSelect" value="${item.userSeq}">
						 			<label>${item.userNM}</label>
							</c:forEach>
						</h4></c:if>
			  		</li>
					<li class="mission1">
						<!-- 현재 이벤트 업로드 숫자-->
						<h6><b id="totalCurrentEvnetUploadCount">0</b>건</h6>
                        <h4><b>DreamTree Live 인증 건수</b></h4>
					</li>
                    <li class="mission2">
                    	<!-- 현재 이벤트 페이지 방문 현황-->
						<h6><b>${currentVisitCount}</b>회</h6>
                        <h4><b>조회수</b></h4>
					</li>
			</ul>
		</div>
      
       <!-- 이벤트 알림 이미지 -->
       <div id="s1"></div>
       
       	<!-- 텝버튼 -->
        <div class="nav_con">
             <ul class="nav">
				<a href="javascript:_flash1(1); sr_nav(1);" onFocus="blur()">
               		<img id="flash1" name="flash1"  src="//image.gojls.com/newjls/img/event/20170907_event/tab_study_flash1_over.png" > 
               	</a>
               <a href="javascript:_flash1(2); sr_nav(5); changeEventList(0);" onFocus="blur()">
               		<img id="flash2" name="flash2" src="//image.gojls.com/newjls/img/event/20170907_event/tab_study_flash2.png">
               </a>
             </ul> 
           </div>
           
           
		<!-- 텝 1 -->
	  	<div id="flash1_1" >
			<div id="sr_wrap">
            	<div id="s2" class="section">
			   		<div class="content">
			    		<p><img src="//image.gojls.com/newjls/img/event/20170907_event/event_01_1.gif" /></p>
                		<p><img src="//image.gojls.com/newjls/img/event/20170907_event/event_01_2.gif" /></P>
                		<p><img src="//image.gojls.com/newjls/img/event/20170907_event/event_01_3.gif" /></p>
			  		</div>
			  	</div>	
            	<div id="s3" class="section">
					<div class="content">
			    		<p><img src="//image.gojls.com/newjls/img/event/20170907_event/event_02.gif" /></p>
                 	</div>
		    	</div>
         	</div>
		</div>
						
	   <!-- 텝 2 -->
	   	<div id="flash1_2" style="display:none;">
	    <div id="sr_wrap">
			<div id="s5" class="section">
			  	<div class="content">
			  	
			     <!-- 이벤트 제목 -->
                <p><img src="//image.gojls.com/newjls/img/event/20170907_event/event_03.gif" /></p>
                <h1>영어노출의 감동의 순간 <label id="totalSelectEventUploadCount"><b>${currentUploadCount}</b></label> 건 인증 완료!</h1>
                
               <!-- 이벤트 제목 -->
            	<div class="event2">
            		<!-- 인증 게시판 -->   
			        <div id="blog">
			              <ul>
			                 <c:forEach begin="1" end="15" var="i">
				              		<li id="list-item${i}">
				              			<img src="//image.gojls.com/newjls/img/event/20170907_event/photo.gif" />
				              			 <div class="description">
			                    			<h5></h5>
		                      			 </div>
				              		</li>
							</c:forEach>
		                  </ul>
	               </div>
               
               		 <!-- 인증 게시판 앞 뒤 버튼-->
              		 <a id="abroad_prev" class="invisible" href="javascript:"><img src="//image.gojls.com/newjls/img/event/20170907_event/btn_pre.png" alt=""/></a> 
              		 <a id="abroad_next" class="invisible" href="javascript:"><img src="//image.gojls.com/newjls/img/event/20170907_event/btn_next.png" alt=""/></a>
              		 
              		 <!-- 인증 게시판 페이지 버튼-->
		          	<div id="pagenation">
		            	<div class="menu" id="pagemenu">
		               	</div>
		               	<ul class="entertop" id="entertop">
					  	<!-- 지난 이벤트 차수 센택 -->
		               	 <span>지난 영어노출 스토리 보기</span>
		                 <select id="eventListCombo" name="eventList">
							<c:forEach items="${eventList}" var="item">
								<option value="${item.eventSeq}" >${item.eventTitle}</option>
							</c:forEach>
						</select>
		                </ul>
                  </div>
				</div></div>
			   
			   
			    <div id="s6" class="section">
				
					<div class="content">
		            <p><img src="//image.gojls.com/newjls/img/event/20170907_event/event_04.gif" /></p>
		            <span class="date" id="eventPeriod"></span>
		            <div class="event2">
		            	
		            	<!-- 개인 인증 게시판 -->
		                <div id="blog" style="margin-left:180px;">
				              <ul>
				              	<c:forEach begin="1" end="3" var="i">
				              		<li id="mylist-item${i}">
				              		
				              			<c:if test="${cEventSeq==selEventSeq}">
				              				<c:if test="${cProcessState==1}">
				              					<h4 class="delete" onclick="deleteContent(${i});" style="display:none;">X</h4>
				              				</c:if>	
				              			</c:if>
				              			
				              			<input id="dliveseq${i}" type="hidden">
						                 <img src="//image.gojls.com/newjls/img/event/20170907_event/photo.gif" />
						                 
						                <div class="description"><h5></h5></div>
					                     
				              		</li>
								</c:forEach>
		                        </ul>
		                 </div>
					</div>
					</div>
				</div>
				
			
				
				<!-- 인증 완료 레이어  -->
				
				<div class="eventfinish3" id="eventfinish3" style="display: none;" >
					<div class="end_info">
						<h3></h3>
                 		<h4><a id="wAnnUrl" href="">
                 			<img src="//image.gojls.com/gojls/img_ad/event/check_bt.png" /></a>
                 		</h4>
					</div>
	    		</div> 
	    		
	    		<!-- 인증하기  -->
				<div id="s7" class="section">
				<div class="content">
				
			    	<p><img src="//image.gojls.com/newjls/img/event/20170907_event/event_05.gif" /></p>
			    	
			    	<!-- 사진 , 텍스트 인증  선택 -->
			    	<div class="pset">	
						<label><input type="radio" name="selectUploadType" value="photo"><span>사진인증</span></label>
						<label><input type="radio" name="selectUploadType" value="txt"><span>글쓰기인증</span></label>
			    	</div>
			    	
			    	<!--인증 폼 -->		
					<form id="imageUploadingForm" class="banner1" action="/dlive/upload-image" method="post" enctype="multipart/form-data" target="dummy">
					 	<div class="table_wrap">
							<table class="form">
					        	<colgroup>
									<col width="88%">
									<col width="12%">
								</colgroup>
					            <tbody>
									<tr height="70px">
						                <td  >
						                	<div class="upload" id="fileImageInputBox" >
						                  		<input id="fileName" type="text" class="file_input_text" readonly>
						                  		<div class="file_input" style="cursor: auto;">
						                  			<input id="inputForImage" name="file" type="file" class="file_input_hidden" style="display: none;" accept="image/*" onChange="onFileChange(this, event);">
						                    		<button id="buttonBrowseForImage" type="button" class="orange" style="cursor: pointer;"><span>사진찾기</span></button>
							                 	</div>
						                  		<p>(첨부파일 10MB 이하)</p>
						                  	</div></td>
						                <th rowspan="2"><img id="imageToUpload" src="//image.gojls.com/newjls/img/event/20170907_event/photo.gif" style="width:120px; height:120px;"></th>
									</tr>
									<tr class="attach" height="80px">
										<td>
											<div class="memo">
												<div class="input_word" >
						                        	<textarea id="imageDescription" placeholder="시크릿 영어노출 프로젝트 Mission을 수행하면서 느낀 점을 후기로 적어주세요!" maxlength="80" style="height: 40px;"></textarea>
												</div>
					                       	</div>
					                       	<p id="imageDescriptionState" style="font-size: 13px; color: #e82e51;"></p>					                       	
										</td>
									</tr>
								</tbody>
							</table>
						</div>
				    	
				    	<span class="check_bt01"><a href="javascript:onClickUpload();"><img src="//image.gojls.com/newjls/img/event/20170907_event/photo_bt.png"></a></span> 
                    	
				    	
				    	
				    	<textarea id="inputImageDescription" name="inputImageDescription" style="display: none; white-space: pre-line;"></textarea>
						<input id="inputUserSequence" name="inputUserSequence" style="display: none;">
						<input id="inputUserName" name="inputUserName" style="display: none;">
						<input id="inputEventSeq" name="inputEventSeq" style="display: none;">
							
						
					</form>
					
					<iframe id="dummy" name="dummy" onload="onDummyLoad(this);"></iframe>
					<p><img src="//image.gojls.com/newjls/img/event/20170907_event/event_06.gif"></p>
				</div>
			</div>          
   		  
   			</div>
    	</div>
		</div>
</div>    
</body>
</html>