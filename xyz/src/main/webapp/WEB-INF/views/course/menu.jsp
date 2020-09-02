<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">
	$(document).ready(function(){
		
		$(".tnav li:eq(0) a").prop("href", root_url +"/course/mathink");
		$(".tnav li:eq(1) a").prop("href", root_url +"/course/mathself");
		$(".tnav li:eq(2) a").prop("href", root_url +"/course/coding");
		
		var req_param_url = $(location).attr('pathname').split("/")[3];
		var img_path = (req_param_url == "mathink") ? "<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/subtop_01.jpg" : (req_param_url == "coding") ? "<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/subtop_03.jpg" : "<spring:eval expression="@globalContext['IMG_SERVER']" />/hms/img/math/subtop_02.jpg" ;
		$(".head .subimg img").attr("src", img_path);
	});
</script>
<div class="head">
	<div class="subimg"><img src="" /></div>
	<h3 class="white">교육과정</h3>
</div>
<ol class="tnav">
	<li <c:if test="${fn:indexOf(recentUrl,'mathink') > -1 }">class="selected"</c:if> ><a href="">초등교육</a></li>
	<li <c:if test="${fn:indexOf(recentUrl,'mathself') > -1 }">class="selected"</c:if> ><a href="">중.고등교육</a></li>
	<li <c:if test="${fn:indexOf(recentUrl,'coding') > -1 }">class="selected"</c:if> ><a href="">코딩교육</a></li>
</ol>

