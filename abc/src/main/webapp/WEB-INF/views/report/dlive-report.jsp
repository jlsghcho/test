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
<title>Event Admin</title>
<link href="<spring:eval expression="@globalContext['REPORT_COOMN_ROOT']" />/img/jls.ico" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="<spring:eval expression="@globalContext['REPORT_COOMN_ROOT']" />/css/report.css">

<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_ANY_PROTOCOL']" />/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_ANY_PROTOCOL']" />/js/jquery-ui-1.12.1.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_ANY_PROTOCOL']" />/jquery.tablesorter-2.31.1/js/jquery.tablesorter.min.js"></script>
<script type="text/javascript" src="<spring:eval expression="@globalContext['IMG_ROOT_COMMON_ANY_PROTOCOL']" />/js/jquery.slimscroll.min.js"></script>

// CSV Conveter
<script src="<spring:eval expression="@globalContext['SITE_URL']" />/resources/js/underscore-min.js"></script>
<script src="<spring:eval expression="@globalContext['SITE_URL']" />/resources/js/blob.js"></script>
<script src="<spring:eval expression="@globalContext['SITE_URL']" />/resources/js/filesaver.js"></script>
<script src="<spring:eval expression="@globalContext['SITE_URL']" />/resources/js/json2.js"></script>
<script src="<spring:eval expression="@globalContext['SITE_URL']" />/resources/js/strsup.js?v=7"></script>
<script src="<spring:eval expression="@globalContext['SITE_URL']" />/resources/js/localread.js?v=7"></script>
<script src="<spring:eval expression="@globalContext['SITE_URL']" />/resources/js/csvparse.js?v=7"></script>
<script src="<spring:eval expression="@globalContext['SITE_URL']" />/resources/js/csvsup.js?v=25x"></script>
<script src="https://cdn.jsdelivr.net/alasql/0.3.8/alasql.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.11.5/xlsx.full.min.js"></script>

</head>

<script type="text/javascript">
	
	var userRole = "${userRole}";
	var userType = "${userType}";

	$(document).ready(function() {
				
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
    		changeDept($('#deptList option').val());
    	}
		else
		{	$('#deptList').attr('disabled',true);	}
		
		$('#eventList').change(function () {
			updateRankList();
		});
		
		updateRankList();
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
							<option value="/report/dlive-report" selected>시크릿 이벤트</option>
							<option value="/report/roulette-reprot">250달성 이벤트</option>
							<option value="/report/msucc-report">CHESS MSUCC 이벤트</option>
						</select>
					</span>
					</c:if>
					<button type="button" class="member" title="Sign Out" onclick="location.href='/admin/signOut'"><span>Sign Out</span></button>
			</div>
	</div>	
	

	<div id="info">
		<form id="dliveSearchForm">
		<div class="tit_area">
			<h3>D-Live Event</h3>
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
			<select id="teacherList" name="teacherList" >
			</select>
			<!-- <select id="classList" name="classList">
			</select> -->
			<button type="button" id="searchBtn" class="black" onClick="updateDliveList();"><span>Search</span></button>
			<button type="button" id="excelBtn" class="black" title="Save Excel" onClick="fnCSVReport();"><span>CSV Download</span></button>
		</form>
		</div>
			<div title="Data Download" id="preparing-file-modal" style="display: none;"> 
				<div id="progressbar" style="width: 100%; height: 22px; margin-top: 20px;"></div> 
			</div>
			<div title="Error" id="error-modal" style="display: none;"> <p>생성실패.</p> 
		</div>
	</div>
	
	<div id="howtobox">
		<div class="arrow"></div>
		<div class="howtobox_body">
			<h3>분원별 현황</h3>
			
				<div class="report_table">
					<table>
						<thead>
							<tr>
								<th>분원 이름</th>
								<th>참여인증수</th>
							</tr>
						</thead>
						<tbody id="rank_tbody">
						</tbody>
					</table>
				</div>
			
		</div>
	</div>
	<div id="container">
		<div id="dliveList"></div>
	</div>
		
</div>

</body>
</html>
<iframe id="txtArea1" style="display:none"></iframe>
<input type="text" size="15" id="fn" value="dliveReport" class="form-control" style="display:none">

<script type="text/javascript">

function changeDept(value){
	
	$('#teacherList').find('option').remove();
	
	if(value != "ALL"){
       	
		$.ajax({
	        type : "GET",
	        url : "/report/dlive-report/"+value,
	        dataType : "json",
	        success : function(data){
	        	
	            if(data.result == "success"){
	            	
	            	var teacherHtmlStr = "";
	            	
	            	if(userType == "02" || userType == "03"){
	            		teacherHtmlStr += '<option value="ALL">전체 선생님</option>';
	            		$('#teacherList').html(teacherHtmlStr);
	            		for(var i=0; i<data.teacherList.length; i++){
		            		teacherHtmlStr += '<option value="'+data.teacherList[i].empSeq+'">'+data.teacherList[i].empNm+'</option>';
		            		$('#teacherList').html(teacherHtmlStr);
		            	}
	            	}
	            	else
	            	{
	            		teacherHtmlStr += '<option value="'+data.teacherList.empSeq+'">'+data.teacherList.empNm+'</option>';
	            		$('#teacherList').html(teacherHtmlStr);
	            	}
	            }else{
	            	alert(data.message);
	            }
	        },
	        error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }  
	    });
	}
	else
	{
		$('#teacherList').find('option').remove();
		var teacherHtmlStr = '<option value="ALL">전체 선생님</option>';
   		$('#teacherList').html(teacherHtmlStr);
	}
	
	if($('#teacherList option').length > 0)
	{	
		$('#teacherList').attr('disabled',false);
		$("#teacherList option:first").attr('selected','selected');
	}
	else
	{
		$('#teacherList').attr('disabled',false);
	}
}

function updateDliveList() {

	var eventSeq;
	var deptSeq;
	var empSeq;
	
	if($('#eventList option').length > 0 ){eventSeq = $("#eventList").val();}
	if($('#deptList option').length > 0 ){deptSeq = $("#deptList").val();}
	if($('#teacherList option').length > 0 ){empSeq = $("#teacherList").val();}
	
	if($('#eventList option').length == 0){alert("이벤트 회차 정보가 없습니다"); return;}
	if($('#deptList option').length == 0){alert("분원 정보가 없습니다"); return;}	
	if($('#teacherList option').length == 0){alert("선생님 정보가 없습니다"); return;}
		
	if(deptSeq == "ALL"){empSeq ="ALL";}
	
	var param = "eventSeq="+eventSeq+"&deptSeq="+deptSeq+"&empSeq="+ empSeq+"&clsSeq=ALL";	
	$("#dliveList").load("/report/dlive-report-list", param, function(){
		$("#dlivetable").tablesorter(); 	
		$("#delete_record").hide();
	});	
}


function updateRankList() {
		
	if($('#eventList option').length == 0){ alert("이벤트 회차 정보가 없습니다"); return;}
	$.ajax({
        type : "GET",
        url : "/report/dlive-report-dlist/"+$("#eventList").val(),
        dataType : "json",
        success : function(data){
        	
            if(data.result == "success"){
            	
            	var htmlStr = "";
        		
            	for(var i=0; i<data.dliveRankList.length; i++){
            		htmlStr += '<tr><td>'+data.dliveRankList[i].deptNm+'</td>';
            		htmlStr += '<td>'+data.dliveRankList[i].cnt+'</td></tr>';	            
				    $('#rank_tbody').html(htmlStr);
            	}
            	
            }else{
            	alert(data.message);
            }
        },
        error:function(xhr, ajaxOpts, thrownErr){ alert(xhr +'/'+ thrownErr ); }  
    });
	
}

// 파일 형식 오류 & 대용량 저장 실패로 사용 안함
function fnExcelReport()
{	
    var tab_text="<table border='2px'><tr bgcolor='#87AFC6'>";
    var textRange; var j=0;
    tab = document.getElementById('dlivetable'); // id of table

    for(j = 0 ; j < tab.rows.length ; j++) 
    {     
    	{tab_text=tab_text+tab.rows[j].innerHTML+"</tr>";}
    }

    tab_text=tab_text+"</table>";
    tab_text= tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
    tab_text= tab_text.replace(/<img[^>]*>/gi,""); // remove if u want images in your table
    tab_text= tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params
    
    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE "); 

    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
    {
        txtArea1.document.open("txt/html","replace");
        txtArea1.document.write(tab_text);
        txtArea1.document.close();
        txtArea1.focus(); 
        sa=txtArea1.document.execCommand("SaveAs",true,"dlive_event.xls");
    }  
    else                 //other browser not tested on IE 11
        sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));  

    return (sa);        
}


function fnCSVReport() {
	
    var s="";
    var cells;
    var value;
    var delimiter = ",";
    var html=document.getElementById('report_table');
    var tbl = html.getElementsByTagName('table');
    var re = new RegExp("<\/?\\w+((\\s+\\w+(\\s*=\\s*(?:\".*?\"|'.*?'|[^'\">\\s]+))?)+\\s*|\\s*)\/?>",'igm');

    for(var j=0;j<tbl.length;j++) {
        rows=tbl[j].getElementsByTagName('tr');
        for(var k=0;k<rows.length;k++) {
            if ('querySelectorAll' in document) {
               cells=rows[k].querySelectorAll('td,th');
            } else {
               cells=rows[k].getElementsByTagName('td');
               if(!cells || cells.length==0) {
                  cells=rows[k].getElementsByTagName('th');
               }
            }

            for(var n=0;n<cells.length;n++) {
               value=cells[n].innerHTML;
               if(value==null)value="";else value+="";
               value = value.replace(/\r\n|\r|\n/gmi,' ');
               value = value.replace(/\n|<br>|<br\/>|<br \/>/gmi,' ');  // no MultiLines 
               /*value = value.replace(/<br>|<br\/>|<br \/>/gmi,'\n');
               value = value.replace(/(<li>|(<li (?:"[^"]*"['"]*|'[^']*'['"]*|[^'">])+>))/gmi,'\n');*/ // MultiLines 
               value=value.replace(re,'');	// removeTags 
               value=_.unescape(value);
               value=value.replace(/&nbsp;/gmi," ");
               value=value.replace(/ {2,}/g, ' '); // crunch
               value=value.trim();
               s += '"' + value.replace(/"/gmi, '""') + '"' + delimiter; // bQuotes true
               //s+=value.toCsv(delimiter,'"') + delimiter; // bQuotes false
           }
           s=s.slice(0, delimiter.length*-1); // remove last delimiter
           s += "\n"; 
        } 
    }
    
    document.getElementById('txtArea1').value = s; 
    saveExcel('txtArea1',false);
}


</script>