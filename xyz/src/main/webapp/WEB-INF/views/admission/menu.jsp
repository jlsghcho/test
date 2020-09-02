<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">
	$(document).ready(function(){
		$(".snav li:eq(0) a").prop("href", root_url +"/admission/mathink");
		$(".snav li:eq(1) a").prop("href", root_url +"/admission/mathself");
		$(".snav li:eq(2) a").prop("href", root_url +"/admission/coding");
		$(".snav li:eq(3) a").prop("href", root_url +"/admission/online");
	});
</script>
			<div class="snav">
				<ul>
					<li <c:if test="${fn:indexOf(recentUrl,'mathink') > -1 }">class="selected"</c:if> ><a href="">초등 매씽크 입학</a></li>
					<li <c:if test="${fn:indexOf(recentUrl,'mathself') > -1 }">class="selected"</c:if> ><a href="">중.고등 매셀프 입학</a></li>
					<li <c:if test="${fn:indexOf(recentUrl,'coding') > -1 }">class="selected"</c:if> ><a href="">알고리즘에듀 입학</a></li>
					<li <c:if test="${fn:indexOf(recentUrl,'online') > -1 }">class="selected"</c:if> ><a href="">온라인 예약</a></li>
				</ul>
			</div>

