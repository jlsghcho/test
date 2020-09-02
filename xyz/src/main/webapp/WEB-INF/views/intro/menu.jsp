<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">
	$(document).ready(function(){
		//var param_url = $(location).attr('pathname').split("/")[1];
		$(".snav li:eq(0) a").prop("href", root_url +"/intro/jls");
		$(".snav li:eq(1) a").prop("href", root_url +"/intro/search");
		$(".snav li:eq(2) a").prop("href", root_url +"/intro/news");
	});
</script>
			<div class="snav">
				<ul>
					<li <c:if test="${fn:indexOf(recentUrl,'/jls') > -1 }">class="selected"</c:if> ><a href="">정상수학학원 소개</a></li>
					<li <c:if test="${fn:indexOf(recentUrl,'/search') > -1 }">class="selected"</c:if> ><a href="">분원 찾기</a></li>
					<li <c:if test="${fn:indexOf(recentUrl,'/news') > -1 }">class="selected"</c:if> ><a href="">JLS 소식</a></li>
				</ul>
			</div>

