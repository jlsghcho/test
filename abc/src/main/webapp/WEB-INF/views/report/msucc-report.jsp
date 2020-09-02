<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=1202, user-scalable=yes">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Pragma" content="no-cache">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<title>DLIVE EVENT</title>

<link href="http://devimg.gojls.com/EVENT/img/jls.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="<spring:eval expression="@globalContext['REPORT_COOMN_ROOT']" />/css/report.css">

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.5/jszip.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_ANY_PROTOCOL']" />/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_ANY_PROTOCOL']" />/js/jquery-ui-1.12.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_ANY_PROTOCOL']" />/jquery.tablesorter-2.31.1/js/jquery.tablesorter.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_ANY_PROTOCOL']" />/js/jquery.slimscroll.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_ANY_PROTOCOL']" />/jQuery-ExcelGen/js/FileSaver.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_ANY_PROTOCOL']" />/jQuery-ExcelGen/js/excel-gen.js"></script>
</head>


<script type="text/javascript">
	var download_url = "<spring:eval expression="@globalContext['ROOT_DIRECTORY_TO_DOWNLOAD']" />";
	var userRole = "${userRole}";
	var userType = "${userType}";

	$(document).ready(function() {
		
		/* slide box */ 
		//$("#howtobox, #container").toggleClass("fold", 500);
		
		$("#container .contents, #howtobox .howtobox_body").slimScroll({
			height: "100%",
			size: "5px",
			allowPageScroll: false,
			disableFadeOut: true
		});
		
		$(document).on("click", "#howtobox .arrow", function() {
			$("#howtobox, #container").toggleClass("fold", 500);
		});
		
		
		/* select box setting */
		if($('#eventList option').length > 0)
    	{	
    		$('#eventList').attr('disabled',false);
    		$("#eventList option:last").attr('selected','selected');
    	}
		else
		{	$('#eventList').attr('disabled',true);	}
		
		if($('#deptList option').length > 0)
    	{	
    		$('#deptList').attr('disabled',false);
    		$("#deptList option:first").attr('selected','selected');
    	}
		else
		{	$('#deptList').attr('disabled',true);	}
		
		$('#eventList').change(function () {
			updateDeptRankList();
		});
				
		updateEntrantList();
		updateRankList();
		
		
		// excel button
		$("#excelBtn_entrant").click(function () {
			excel = new ExcelGen({
		        "src_id": "entranttable",
		        "show_header": true
			});
		     excel.generate();
		});
		
		$("#excelBtn_rank").click(function () {
			excel = new ExcelGen({
		        "src_id": "ranktable",
		        "show_header": true
			});
		     excel.generate();
		});
	
	});
	
</script>	


<body>
<div id="wrap">
	<div id="header">
			<div class="mh">
				<h1><img src="<spring:eval expression="@globalContext['IMG_ROOT_ANY_PROTOCOL_HMS']" />/img/mh_logo.svg" alt="JLS" /></h1>
				<span>Event Admin</span>
			</div>
			<div class="nav"></div>
			<div class="user">
				
					<span>환영합니다. ${userNm}님</span>
					<c:if test="${userRole == '01'}">
					<span>
						<select onchange="if (this.value) { window.location=this.value; }" style="height: 20px;">							
							<option value="/report/dlive-report">시크릿 이벤트</option>
							<option value="/report/roulette-reprot">250달성 이벤트</option>
							<option value="/report/msucc-report" selected>CHESS MSUCC 이벤트</option>
						</select>
					</span>
					</c:if>
					<button type="button" class="member" title="Sign Out" onclick="location.href='/report/signOut'"><span>Sign Out</span></button>
			</div>
	</div>	
	
	<div id="info">
		<form id="dliveSearchForm">
		<div class="tit_area">
			<h3>MSUCC-Live Event</h3>
			<select id="eventList" name="eventList">
				<c:forEach items="${eventList}" var="item">
					<option value="${item.eventSeq}">${item.eventTitle}</option>
				</c:forEach>
			</select>
			<select id="deptList" name="deptList" onChange="changeDept(this.value)">
				<c:if test="${userRole == '01'}">
					<option value="ALL">전체 분원</option>
				</c:if>
				<c:forEach items="${deptList}" var="item">
					<option value="${item.deptSeq}">${item.deptNm}</option>
				</c:forEach>
			</select>
			<button type="button" id="searchBtn" class="black" onClick="updateEntrantList();"><span>Search</span></button>
			<button type="button" id="excelBtn_entrant" class="black" title="Download from Excel"><span>Excel Download</span></button>
		</div>
		</form>
	</div>
	
	<div id="howtobox">
		<div class="arrow"></div>
		<div class="howtobox_body">
			<h3>투표 현황</h3>
						
				<div class="report_table">
					<table>
						<thead>
							<tr>
								<th>총투표 </th>
								<th>중복제거</th>
								<th>중복제거</th>
							</tr>
						</thead>
						<tbody id="rank_tbody">
						</tbody>
					</table>
				</div>
			
		</div>
	</div>
	<div id="container">
		<div id="entrantList"></div>
	</div>
		
</div>
</body>
</html>



<script type="text/javascript">

function updateEntrantList() {

	if($('#eventList option').length == 0){ alert("이벤트 회차 정보가 없습니다"); return;}
	if($('#deptList option').length == 0){ alert("분원 정보가 없습니다"); return;}
	if($('#eventList option').length > 0 ){eventSeq = $("#eventList").val();}
	if($('#deptList option').length > 0 ){deptSeq = $("#deptList").val();}
	
	var param = "eventSeq="+eventSeq+"&deptSeq="+deptSeq;
	
	$("#entrantList").load("/report/msucc-report-list", param, function(){
		/* tablesorter */
		$("#entranttable").tablesorter(); 	
		$("#delete_record").hide();
		eventList
	});	
}


function updateRankList() {
		
	if($('#eventList option').length == 0){ alert("이벤트 회차 정보가 없습니다"); return;}
	
	
	$.ajax({
        type : "GET",
        url : "/report/msucc-report-dlist/"+$("#eventList").val(),
        dataType : "json",
        success : function(data){
        	
            if(data.result == "success"){
            	
            	var htmlStr = "";
        		
            	for(var i=0; i<data.dliveRankList.length; i++){
            		htmlStr += '<td>'+data.rankList[i].deptNm+'</td>';
            		htmlStr += '<td>'+data.rankList[i].cnt+'</td>';	            
            		htmlStr += '<td>'+data.rankList[i].cnt+'</td>';
            		htmlStr += '<td>'+data.rankList[i].cnt+'</td>';
				    $('#rank_tbody').html(htmlStr);
            	}
            	
            }else{
            	alert(data.message);
            }
        },
        error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }  
    });
	
}

</script>
