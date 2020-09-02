<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1202, user-scalable=yes">
<meta name="keywords" content=""/>
<title>Event Admin</title>
<jsp:include page="../common/statistics.jsp" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="<spring:eval expression="@globalContext['REPORT_COOMN_ROOT']" />/css/report.css">

<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_ANY_PROTOCOL']" />/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_ANY_PROTOCOL']" />/js/jquery-ui-1.12.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/js/mobi_event.js"></script>

</head>

<body class="gray-bg">

    <div class="middle-box text-center loginscreen animated fadeInDown">
        <div>
            <div>
                <h1 class="logo-name">adm</h1>
            </div>
            <h3>이벤트 운영툴에 오신것을 환영합니다. </h3>             
            </p>
            <p>로그인을 위해서는 LP 계정 정보를 입력 하십시오.</p>
            <form id="signInForm" name="signInForm"  method="post">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="아이디" id="empId" name="empId" required="required">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="비밀번호" id="empPw" name="empPw"  required="required">
                </div>
                <button type="button" class="btn btn-primary block full-width m-b" onclick="goLogin();">로그인</button>
            </form>
        </div>
    </div>
</body>

<script type="text/javascript">

$(document).ready(function() {
	//Search Input Enter Key Down  
	$(document).on('keydown', '#empPw',function() {
		if(event.keyCode==13){ goLogin();	return false; }
	});
});

function goLogin() {
	var url = "";
	if($("#empId").val().length < 1){
		common_alert.small("아이디를 입력해주세요.");
		return;	    		
	}
	if($("#empPw").val().length < 1){
		common_alert.small("비밀번호를 입력해주세요.");
		return;	    		
	}
	
	$.ajax({
		type:"POST",
		dataType:"json",
		url:"/admin/signIn",
		data:$("#signInForm").serialize(),
		success:function(data) {
			if (data.result == "success") {
				document.location = data.redirectUrl;
			} else {
				alert(data.message);
				$("#empPw").val("");
				$("#empPw").focus();
			}
		},
		error:function(xhr, ajaxOpts, thrownErr) {
		common_alert.big_func('warning', "아이디 또는 비밀번호를 잘못 입력하셨습니다.\n다시 확인해주세요." ,fnResult);
		}
	});
	
}

</script>
</html>
