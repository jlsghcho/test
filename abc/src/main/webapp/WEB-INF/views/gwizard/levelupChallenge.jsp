<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="scroll_left"></div>
<div class="scroll_right"></div>
<div class="qwrap">
	<div class="header">
		<h1>미션완수테스트</h1>
	</div>
	<div class="contents">
		<div class="test_info">
			<p>통과 보상 : <b>${eventUserInfo.nextLevelNm }</b> 레벨업​</p>
			<p>통과 조건 : ${eventUserInfo.levelQuizCnt }문제 중, ${eventUserInfo.levelPassCnt }문제 이상 정답</p>
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
				<button type="button" class="confirm_result hide" onclick="levelupResult('${eventSeq}', '${eventElevateSeq}', '${eventUserInfo.stageNo }', '${eventUserInfo.levelQuizCnt }','${eventUserInfo.levelPassCnt}','levelup')"><span>결과확인</span></button>
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