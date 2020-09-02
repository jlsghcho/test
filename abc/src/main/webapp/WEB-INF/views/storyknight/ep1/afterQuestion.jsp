<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="scroll_left"></div>
<div class="scroll_right"></div>
<div class="qwrap">
	<div class="header">
		<h1>Quiz</h1>
	</div>
	<div class="contents">
		<div class="question">
			<p>
			${eventQuiz.question }
			<c:if test="${isChessQuizKrCheck != null && isChessQuizKrCheck == 1 && eventQuiz.questionKr != null }"><br>(${eventQuiz.questionKr })</c:if>
			</p>
		</div>
		<div class="answer">
		<c:set var="example_arr" value="${fn:split(eventQuiz.example,',')}" />
		<c:forEach items="${example_arr}" var="x"  varStatus="s">
			<label class="cf"><input type="radio" name="answer_num" id="n1" value="${s.index+1 }" /><span>${x}</span></label>
		</c:forEach>
		</div>
		<div class="result hide">
			<div class="">
				<p>${eventQuiz.explanation }</p>
			</div>
		</div>
	</div>
	<div class="btn_bottom">
		<button type="button" class="submit_answer" onclick="afterQuestionSave('${eventSeq }','${eventHistorySeq}','${param.eventMovieSeq}','${eventQuiz.answer}')"><span>정답제출</span></button>
		<button type="button" class="confirm hide"><span>확인</span></button>
	</div>
</div>