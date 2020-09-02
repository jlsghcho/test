<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="scroll_left"></div>
<div class="scroll_right"></div>
<div class="qwrap">
	<div class="header">
		<h1>자격증명</h1>
	</div>
	<div class="contents certification">
		<div class="test_info">
			<p>통과 보상 : <b>위대한 마법사</b> 인증</p>
			<p>통과 조건 : ${eventUserInfo.levelQuizCnt }문제 중, ${eventUserInfo.levelPassCnt }문제 이상 정답</p>
		</div>
		<div class="qna">
			<p>이번 모험에 참여하기 위해서는 이전 <b>‘Episode1. 위대한 마법사의 탄생’</b>에서 훈련했던 기본 문법에 대한 이해가 필요합니다.</p>
			<h5 class="q">혹시, <b>‘Episode1. 위대한 마법사의 탄생’</b> 에서 위대한 마법사 타이틀을 획득하셨나요?</h5>
			<h5 class="a"><b>네. 저는 위대한 마법사가 맞습니다.</b> <br>지금 당장 아래 <span class="challenge_btn">[도전하기]</span>를 눌러 문제를 풀고 자격을 증명하세요.</h5>
			<h5 class="a"><b>저는 위대한 마법사가 아닙니다.</b> <br>Episode1 문법영상을 보고 훈련 후, 자신이 생겼을 때 자격증명에 도전하세요.</h5>
		</div>
		<div class="btn_bottom">
			<button type="button" class="close"><span>닫기</span></button>
			<button type="button" class="submit_challenge"><span>도전하기</span></button>
		</div>
	</div>
	<c:forEach var="list" items="${eventQuizList}" varStatus="i">
	<div class="contents hide">
		<div class="page">${i.index+1 }/${eventUserInfo.levelQuizCnt}</div>
		<div class="question">
			<p>${list.question }</p>
		</div>
		<div class="answer">
		<c:set var="example_arr" value="${fn:split(list.example,',')}" />
		<c:forEach items="${example_arr}" var="x"  varStatus="s">
			<label class="cf"><input type="radio" name="answer_num" id="n1" value="${s.index+1 }" /><span>${x}</span></label>
		</c:forEach>
		</div>
		<div class="result hide">
			<div class="correct">
				<p>${list.explanation }</p>
			</div>
		</div>
		<div class="btn_bottom">
			<input type="hidden" id="ans" value="${list.answer }" />
			<button type="button" class="submit_answer"><span>정답제출</span></button>
			<c:choose>
			<c:when test="${eventUserInfo.levelQuizCnt - (i.index+1) > 0 }">
				<button type="button" class="next hide"><span>다음문제</span></button>
			</c:when>
			<c:otherwise>
				<button type="button" class="confirm_result hide" onclick="levelupResult('${eventSeq}', '${eventElevateSeq}', '${eventUserInfo.stageNo }', '${eventUserInfo.levelQuizCnt }','${eventUserInfo.levelPassCnt}','certification')"><span>결과확인</span></button>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
	</c:forEach>
	<div class="contents hide">
		<div class="levelup_info">
			
		</div>
		<div class="btn_bottom">
			<button type="button" class="confirm"><span>확인</span></button>
		</div>
	</div>
</div>