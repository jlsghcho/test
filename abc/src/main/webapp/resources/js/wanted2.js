var REPEATABLE_CHARACTERS = [" ", "\r", "\n", "\t", ".", ","];
var IMAGE_SIZE_LIMIT = 10 * 1024 * 1024;
var URL_TO_GOJLS_SIGN_IN = "https://www.gojls.com/login?preURL=https://event.gojls.com/ace/wanted2";
var URL_TO_DUMMY_IMAGE = "resources/images/null%20photo.gif";
var NUMBER_OF_CONTENTS_PER_PAGE = 5;

var listenerForIframsAdded;

var areFormsEnabled = false;
var cEventSeq;	// 진행 중인 이벤트 번호
var cProcessState;	// 이벤트 상태
var cAnnounceDate;	// 상품 발표일
var cStartDate; // 이벤트 시작일 
var cCloseDate;	// 인증 마감일  
var signedInAsStudent;	// 수강 중인 학생인지
var isCookies;	// 로그인 사용자인지
var currentReportPage = 1;
var currentArrestPage = 1;
var userSequence;


var ieVersion = (function() {
	var undef;
	var version = 3;
	var div = document.createElement("div");
	var all = div.getElementsByTagName("i");

	while(div.innerHTML = "<!--[if gt IE " + (++version) + "]><i></i><![endif]-->", all[0]) { }
	return version > 4? version: undef;
}());


/* scroll */
function scrollEvent() {
	var location = $(window).scrollTop();
	
	if(location == 0) {
		sr_nav(0, "scroll");
	} else if(location > $("#s5").offset().top && location < $("#s3").offset().top) {
		sr_nav(5, "scroll");
	} else if(location > $("#s3").offset().top && location < $("#s4").offset().top) {
		sr_nav(3, "scroll");
	}
}


/* global navigation */
function sr_nav(n, scroll) {
	
	if(!scroll) {
		$(window).scrollTo($("#s" + n).offset().top, {
			duration: 500, axis: 'y', onAfter: function() {
				$("#sr_nav").find(".nav").attr("class", "nav s_" + n);
			}
		});
	} else {
		$("#sr_nav").find(".nav").attr("class", "nav s_" + n);
	}
}


$(document).ready(function() {
	$(window).scroll(function() { scrollEvent(); });
	$(window).resize(function() { scrollEvent(); });

	//$("button#buttonBrowseForImage").click(function(event) { $("input#inputForImage").click(); });
	if(areFormsEnabled) {
		$("#memo").focus(
			function() {
				
				if(!isCookies) {
					this.blur();
					alert("로그인 후 이용 가능합니다.");
					redirectToGojls();
					return;
				}
				if(!signedInAsStudent) {
					this.blur();
					alert("이벤트 대상이 아닙니다. 중학교 1학년 이상 재원생만 이용 가능합니다.");
					return;
				}

				showTextLengthIndicator(this, $("#memoState"));
			}
		).keydown(
			function() {
				
				if(!isCookies) {
					alert("로그인 후 이용 가능합니다.");
					redirectToGojls();
					return;
				}
				if(!signedInAsStudent) {
					alert("이벤트 대상이 아닙니다. 중학교 1학년 이상 재원생만 이용 가능합니다.");
					return;
				}

				showTextLengthIndicator(this, $("#memoState"));
			}
		).keyup(
			function() {
				
				if(cProcessState != 1) {					
					alert("현재 이벤트 기간이 아닙니다.\n이벤트 기간:  " + getUploadPeriodStr());
					return;
				}
				
				if(!isCookies) {
					alert("로그인 후 이용 가능합니다.");
					redirectToGojls();
					return;
				}
				if(!signedInAsStudent) {
					alert("이벤트 대상이 아닙니다. 중학교 1학년 이상 재원생만 이용 가능합니다.");
					return;
				}

				showTextLengthIndicator(this, $("#memoState"));
			}
		).on("paste", function() {
		
			if(!isCookies) {
				alert("로그인 후 이용 가능합니다.");
				redirectToGojls();
				return;
			}
			if(!signedInAsStudent) {
				alert("이벤트 대상이 아닙니다. 중학교 1학년 이상 재원생만 이용 가능합니다.");
				return;
			}

			showTextLengthIndicator(this, $("#memoState"));
		});
	} else {
		$("#reportingForm").find("*").prop("disabled", true);
		$("#arrestingForm").find("*").prop("disabled", true);
	}

	///$("input.userSequenceContainer").val(encryptedUserSequence);

	loadContents();
	loadRanking();
	
	if(cProcessState > 1 )
	{
		$(".eventfinish3").show();
		$(".eventfinish2").show();
		if( cProcessState  == 2)
		{
			var wd = cAnnounceDate.toString();
			var year = wd.substring(0,4);
			var month = wd.substring(4,6);
			var day = wd.substring(6, 8);
			$(".eventfinish3").find("h3").html("이벤트  기간이 만료 되었습니다.<br> 그동안 참여해 주셔서 감사합니다.<br> 당첨자발표 : " + year + "-" + month + "-" + day);
			$(".eventfinish2").find("h3").html("이벤트  기간이 만료 되었습니다.<br> 그동안 참여해 주셔서 감사합니다.<br> 당첨자발표 : " + year + "-" + month + "-" + day);
		}
		
		if( cProcessState  == 3)
		{
			$(".eventfinish3").find("h3").html("이벤트 기간이  만료 되었습니다.<br> 그동안 참여해 주셔서 감사합니다.<br>");
			$(".eventfinish3").find("h4").show();
			
			$(".eventfinish2").find("h3").html("이벤트 기간이  만료 되었습니다.<br> 그동안 참여해 주셔서 감사합니다.<br>");
			$(".eventfinish2").find("h4").show();
		}	

	}
	else
	{
		$(".eventfinish3").hide();
		$(".eventfinish2").hide();
	}
	
});

function getUploadPeriodStr()
{
	var s = cStartDate.toString();
	var c = cCloseDate.toString();

	var ss = s.substring(4, 6)+"/"+s.substring(6, 8)+"/"+s.substring(0, 4);
	var cc = c.substring(4, 6)+"/"+c.substring(6, 8)+"/"+c.substring(0, 4);
	
	var sD = new Date(ss);
	var cD = new Date(cc);
	
	var week = new Array('일', '월', '화', '수', '목', '금', '토' );
	var period = (sD.getMonth()+1) + "월 " + sD.getDate() + "일 (" + week[sD.getDay()] + ") ~ " + (cD.getMonth()+1) + "월 " + cD.getDate() + "일 (" + week[cD.getDay()] + ")";
	return period;
		
}

function prevReports() {
	currentReportPage--;
	if(currentReportPage <= 0) { currentReportPage = 1; }
	loadContents();
}

function prevArrests() {
	currentArrestPage--;
	if(currentArrestPage <= 0) { currentArrestPage = 1; }
	loadContents();
}

function nextReports() {
	currentReportPage++;
	loadContents();
}

function nextArrests() {
	currentArrestPage++;
	loadContents();
}

function loadContents() {
	
	if(!listenerForIframsAdded) {
		$("iframe").load(function() { onUploadResult(this); });
		listenerForIframsAdded = true;
	}

	var dataToServer = {};	
	
	if(signedInAsStudent == 1)
		dataToServer["userSequence"] = $("#selUserSeq").val();
		
	dataToServer["eventSequence"] = cEventSeq;	
	dataToServer["reportPage"] = currentReportPage;
	dataToServer["arrestPage"] = currentArrestPage;

	$.ajax({
		url: "/ace/load-contents-new",
		method: "POST",
		data: dataToServer,
		success: [function(dataFromServer) {
			try {
				if(dataFromServer.user) {
					//isAttending = dataFromServer.user.isAttending;

					$("input[title=학년]").val(dataFromServer.user.grade);
					$("input[title=학교]").val(dataFromServer.user.schoolName);
					$("input[title=신고자ID]").val(dataFromServer.user.userId);
				}

				if(dataFromServer.reportCount && dataFromServer.reportCount >= 50) {
					$("#reportCountArea").css("visibility", "visible");
				}
				$("#reportCount").text(dataFromServer.reportCount);
				if(dataFromServer.arrestCount && dataFromServer.arrestCount >= 50) {
					$("#arrestCountArea").css("visibility", "visible");
				}
				$("#arrestCount").text(dataFromServer.arrestCount);

				if(signedInAsStudent) {
					$("#myReportCountArea").css("visibility", "visible");
					$("#myArrestCountArea").css("visibility", "visible");
					$("#myReportCount").text(dataFromServer.myReportCount);
					$("#myArrestCount").text(dataFromServer.myArrestCount);
				} else {
					$("#myReportCountArea").css("visibility", "hidden");
					$("#myArrestCountArea").css("visibility", "hidden");
				}

				renderReports(dataFromServer.reports, dataFromServer.reportCount);
				renderArrests(dataFromServer.arrests, dataFromServer.arrestCount);
				//showOrHidePageButtons();
				alertMessages(dataFromServer.messages);
				
			} catch(error) {
				console.error(error);

				alert("에러가 발생하여 컨텐츠를 불러오지 못했습니다.");
			}
		}],
		error: function(xhr, ajaxOptions, thrownError) {
			console.error("xhr: " + xhr);
			console.error("ajaxOptions: " + ajaxOptions);
			console.error("thrownError: " + thrownError);

			alert("에러가 발생하여 컨텐츠를 불러오지 못했습니다.");
		}
	});

	resetInputs();
}


function loadRanking()
{
	var dataToServer = {};
	
	dataToServer["eventSequence"] = cEventSeq;	
	
	

	$.ajax({
		url: "/ace/load-ranking",
		method: "POST",
		data: dataToServer,
		success: [function(dataFromServer) {
			try {
				
				renderTeacherRanking(dataFromServer.teacherRanking);
				renderUserRanking(dataFromServer.userRanking);

				alertMessages(dataFromServer.messages);
				
			} catch(error) {
				console.error(error);
				alert("에러가 발생하여 컨텐츠를 불러오지 못했습니다.");
			}
		}],
		error: function(xhr, ajaxOptions, thrownError) {
			console.error("xhr: " + xhr);
			console.error("ajaxOptions: " + ajaxOptions);
			console.error("thrownError: " + thrownError);
			alert("에러가 발생하여 컨텐츠를 불러오지 못했습니다.");
		}
	});

	
	
}


function deleteContent(content) {
	
	
	if(confirm("컨텐츠를 삭제하시겠습니까?")) {
		var dataToServer = {};
		if(signedInAsStudent == 1)
			dataToServer["userSequence"] = $("#selUserSeq").val();
			
		dataToServer["eventSequence"] = cEventSeq;
		dataToServer["sequence"] = content.sequence;

		$.ajax({
			url: "/ace/delete2",
			method: "POST",
			data: dataToServer,
			success: [function(dataFromServer) {
				try {
					loadContents();
					loadRanking();
					

					if(dataFromServer.messages && dataFromServer.messages.length > 0) { alertMessages(dataFromServer.messages); }
				} catch(error) {
					console.error(error);

					alert("에러가 발생하여 컨텐츠를 삭제하지 못했습니다.");
				}
			}],
			error: function(xhr, ajaxOptions, thrownError) {
				console.error("xhr: " + xhr);
				console.error("ajaxOptions: " + ajaxOptions);
				console.error("thrownError: " + thrownError);

				alert("에러가 발생하여 컨텐츠를 삭제하지 못했습니다.");
			}
		});
	}
}

function validateReport(form, event) {
	var selector = $(form);
	var file1 = $("#file1").get(0);
	var file2 = $("#file2").get(0);
	var commentSelector = selector.find("textarea");
	
	if(cProcessState != 1) {					
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert("현재 이벤트 기간이 아닙니다.\n이벤트 기간:  " + getUploadPeriodStr());
		return;
	}
	
	if(!isCookies) {
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert("로그인 후 이용 가능합니다.");
		redirectToGojls();
		return false;
	}
	if(!signedInAsStudent) {
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert("이벤트 대상이 아닙니다. 중학교 1학년 이상 재원생만 이용 가능합니다.");
		return false;
	}
	
	var teacher = $("#teachersCombo1").val();
	if(teacher == "no") {
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert("선생님을 선택해 주세요.");
		return false;
	}
	
	var textValidation = validateText(commentSelector.val());
	if(textValidation !== null) {
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert(textValidation);
		return false;
	}	
	if(file1.files) {
		if(file1.files.length < 1) {
			event.preventDefault? event.preventDefault(): (event.returnValue = false);
			alert("STEP1, STEP2의 사진 찾기 이루어지지 않았습니다. STEP1, STEP2 를 재 확인해 주세요.");
			return false;
		}
		if(file1.files[0].size >= IMAGE_SIZE_LIMIT) {
			event.preventDefault? event.preventDefault(): (event.returnValue = false);
			alert("업로드 이미지 파일 크기는 최대 10MB 이하로 제한 됩니다.");
			return false;
		}
	}
	if(file2.files) {
		if(file2.files.length < 1) {
			event.preventDefault? event.preventDefault(): (event.returnValue = false);
			alert("STEP1, STEP2의 사진 찾기 이루어지지 않았습니다. STEP1, STEP2를 재 확인해 주세요.");
			return false;
		}
		if(file2.files[0].size >= IMAGE_SIZE_LIMIT) {
			event.preventDefault? event.preventDefault(): (event.returnValue = false);
			alert("업로드 이미지 파일 크기는 최대 10MB 이하로 제한 됩니다.");
			return false;
		}
	}

	var result = confirm("지금 선택한 사진 2장과 메시지로 신고 등록 하시겠습니까?");
	if(!result) { event.preventDefault? event.preventDefault(): (event.returnValue = false); }

	return result;
}

function validateArrest(form, event) {
	var selector = $(form);
	var file1 = $("#file3").get(0);
	var file2 = $("#file4").get(0);
	 //$("#teacherSeq2").val($("#teachersCombo2").val());
	if(cProcessState != 1) {	
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert("현재 이벤트 기간이 아닙니다.\n이벤트 기간:  " + getUploadPeriodStr());
		return;
	}
	
	
	if(!isCookies) {
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert("로그인 후 이용 가능합니다.");
		redirectToGojls();
		return false;
	}
	if(!signedInAsStudent) {
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert("이벤트 대상이 아닙니다. 중학교 1학년 이상 재원생만 이용 가능합니다.");
		return false;
	}
	var teacher = $("#teachersCombo2").val();
	if(teacher == "no") {
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert("선생님을 선택해 주세요.");
		return false;
	}
	if(file1.files) {
		if(file1.files.length < 1) {
			event.preventDefault? event.preventDefault(): (event.returnValue = false);
			alert("STEP1, STEP2의 사진 찾기 이루어지지 않았습니다. STEP1, STEP2를 재 확인해 주세요.");
			return false;
		}
		if(file1.files[0].size >= IMAGE_SIZE_LIMIT) {
			event.preventDefault? event.preventDefault(): (event.returnValue = false);
			alert("업로드 이미지 파일 크기는 최대 10MB 이하로 제한 됩니다.");
			return false;
		}
	}
	if(file2.files) {
		if(file2.files.length < 1) {
			event.preventDefault? event.preventDefault(): (event.returnValue = false);
			alert("STEP1, STEP2의 사진 찾기 이루어지지 않았습니다. STEP1, STEP2를 재 확인해 주세요.");
			return false;
		}
		if(file2.files[0].size >= IMAGE_SIZE_LIMIT) {
			event.preventDefault? event.preventDefault(): (event.returnValue = false);
			alert("업로드 이미지 파일 크기는 최대 10MB 이하로 제한 됩니다.");
			return false;
		}
	}	var result = confirm("지금 선택한 사진 2장과 메시지로 검거 등록 하시겠습니까?");
	if(!result) { event.preventDefault? event.preventDefault(): (event.returnValue = false); }

	return result;
}

function validateText(text) {
	
	var consecutive = false;
	
	if(text.length < 10)
	{
		return "최소 10글자 이상 입력해 주세요.";
	}
	
	for(var i = 0; i < text.length; i++) {
		var character = text[i];
		if($.inArray(character, REPEATABLE_CHARACTERS)) {
			if(REPEATABLE_CHARACTERS.indexOf(character) >= 0) { continue; }
		}
				
		if( i > 3 && text[i-1] == character && text[i-2] == character && text[i-3] == character)
		{
			return "ㅋㅋㅋ,ㅎㅎㅎ,~~~ 등의 반복 문자는 3개까지 사용 가능 합니다."; 
		}		
	}
	return null;
}


function showTextLengthIndicator(object, indicatorObjectSelection) {
	var objectSelection = $(object);
	var textLength = objectSelection.val().length;
	var maximumTextLength = objectSelection.prop("maxlength");
	indicatorObjectSelection.html("<b>" + textLength + "</b>/" + maximumTextLength);
}


function renderReports(reports, totalCount) {
	resetReportBoard();
	
	if(reports && reports.length > 0) {
		$.each(reports, function(index, report) {
			
			var ordinal = (index + 1);
			var selector = $("#report" + ordinal);
			var leftSelector = selector.find(".left");
			var rightSelector = selector.find(".right");

			leftSelector.find("div").text((report.schoolName? report.schoolName: "") + " " + (report.grade? report.grade: "") + " [" + report.userId + "]");
			leftSelector.find("img").prop("src", report.pathToImage1);
			leftSelector.find("a").prop("href", report.pathToImage1.replace("_", ""));

			if(report.comment) { rightSelector.find("div").text(report.comment); }
			rightSelector.find("img").prop("src", report.pathToImage2);
			rightSelector.find("a").prop("href", report.pathToImage2.replace("_", ""));

			if(report.isMine && rightSelector.find("span.delete").length < 1) {
				var span = document.createElement("span");
				rightSelector.append(span);

				$(span).addClass("delete").text("X").click(function() { deleteContent(report); });
			} else {
				rightSelector.remove("span.delete");
			}
		});
	}
	
	var pagecontroll = $("#report_abroad");
	if(currentReportPage == 1) {
		pagecontroll.find("#abroad_prev").css("visibility", "hidden");
	} else if(currentReportPage > 1) {
		pagecontroll.find("#abroad_prev").css("visibility", "visible");
	}
	
	var numberOfPages = Math.ceil(totalCount / NUMBER_OF_CONTENTS_PER_PAGE);
	if(currentReportPage >= numberOfPages) {
		pagecontroll.find("#abroad_next").css("visibility", "hidden");
	} else {
		pagecontroll.find("#abroad_next").css("visibility", "visible");
	}
	
}


function renderArrests(arrests, totalCount) {
	resetArrestBoard();
	
	if(arrests && arrests.length > 0) {
		$.each(arrests, function(index, arrest) {
			var ordinal = (index + 1);
			var selector = $("#arrest" + ordinal);
			var leftSelector = selector.find(".left");
			var rightSelector = selector.find(".right");

			leftSelector.find("div").text((arrest.schoolName? arrest.schoolName: "") + " " + (arrest.grade? arrest.grade: "") + " [" + arrest.userId + "]");
			leftSelector.find("img").prop("src", arrest.pathToImage1);
			leftSelector.find("a").prop("href", arrest.pathToImage1.replace("_", ""));

			rightSelector.find("div").text((arrest.schoolName? arrest.schoolName: "") + " " + (arrest.grade? arrest.grade: "") + " [" + arrest.userId + "]");
			rightSelector.find("img").prop("src", arrest.pathToImage2);
			rightSelector.find("a").prop("href", arrest.pathToImage2.replace("_", ""));

			if(arrest.isMine && rightSelector.find("span.delete").length < 1) {
				var span = document.createElement("span");
				rightSelector.append(span);

				$(span).addClass("delete").text("X").click(function() { deleteContent(arrest); });
			} else {
				rightSelector.remove("span.delete");
			}
		});
	}
	
	
	var pagecontroll = $("#arrest_abroad");
	if(currentArrestPage == 1) {
		pagecontroll.find("#abroad_prev").css("visibility", "hidden");
	} else if(currentArrestPage > 1) {
		pagecontroll.find("#abroad_prev").css("visibility", "visible");
	}

	var numberOfPages = Math.ceil(totalCount / NUMBER_OF_CONTENTS_PER_PAGE);
	if(currentArrestPage >= numberOfPages) {
		pagecontroll.find("#abroad_next").css("visibility", "hidden");
	} else {
		pagecontroll.find("#abroad_next").css("visibility", "visible");
	}
	

}


function resetReportBoard() {
	for(var i = 1; i <= NUMBER_OF_CONTENTS_PER_PAGE; i++) {
		var selector = $("#report" + i);
		var leftSelector = selector.find(".left");
		var rightSelector = selector.find(".right");

		leftSelector.find("div").text("");
		leftSelector.find("img").prop("src", "//image.gojls.com/newjls/img/event/20170825_event/pic01.gif");
		leftSelector.find("a").prop("href", "javascript:");

		rightSelector.find("div").text("");
		rightSelector.find("img").prop("src", "//image.gojls.com/newjls/img/event/20170825_event/pic01.gif");
		rightSelector.find("a").prop("href", "javascript:");
		rightSelector.find("span.delete").remove();
	}
}

function resetArrestBoard() {
	
	for(var i = 1; i <= NUMBER_OF_CONTENTS_PER_PAGE; i++) {
		var selector = $("#arrest" + i);
		var leftSelector = selector.find(".left");
		var rightSelector = selector.find(".right");

		leftSelector.find("div").text("");
		leftSelector.find("img").prop("src", "//image.gojls.com/newjls/img/event/20170825_event/pic02.gif");
		leftSelector.find("a").prop("href", "javascript:");

		rightSelector.find("div").text("");
		rightSelector.find("img").prop("src", "//image.gojls.com/newjls/img/event/20170825_event/pic02.gif");
		rightSelector.find("a").prop("href", "javascript:");
		rightSelector.find("span.delete").remove();
	}
}

function renderTeacherRanking(teacherlist)
{
	
	for(var i = 1; i <= 11; i++) {
		var selector =  $("#tranking" + i);  
		selector.addClass("ranking_you");
		selector.removeClass("ranking_me");
		
		$("span#td" + i).text("");
		$("span#tu" + i).text("");
	}

			
	if(teacherlist && teacherlist.length > 0) {
		$.each(teacherlist, function(index, teacher) {		
			
			var ordinal = (index + 1);
			var selector =  $("#tranking" + ordinal);
			
			var selUserSeq = null;
			if(signedInAsStudent == 1)
				selUserSeq= $("#selUserSeq").val();
			
			if(selUserSeq && selUserSeq ==  teacher.userSequence)
			{
				selector.addClass("ranking_me");
				selector.removeClass("ranking_you");
			}
						
			$("span#td" + ordinal).text(teacher.departmentName);
			$("span#tu" + ordinal).text(teacher.userName + "/" + teacher.totalCount + "건" );
		});
	}
	
	
}

function renderUserRanking(userlist)
{
	for(var i = 1; i <= 100; i++) {
		
		var selector =  $("#uranking" + i); 
		selector.addClass("ranking_you");
		selector.removeClass("ranking_me");
		
		$("span#ud" + i).text("");
		$("span#uu" + i).text("");
		
	}
	
	if(userlist && userlist.length > 0) {
		$.each(userlist, function(index, user) {
			
			var ordinal = (index + 1);
			var selector =  $("#uranking" + ordinal);
			
			var selUserSeq = null;
			if(signedInAsStudent == 1)
				selUserSeq= $("#selUserSeq").val();
			
			if(selUserSeq && selUserSeq ==  user.userSequence)
			{
				selector.addClass("ranking_me");
				selector.removeClass("ranking_you");
			}
			
			selector.find("span.yellowscore").text(user.userName);
			$("span#ud" + ordinal).text(user.departmentName);
			$("span#uu" + ordinal).text(user.userName);
		});
	} 
}


function alertMessages(messages) {
	if(messages && messages.length > 0) {
		var messageToShow = "";
		$.each(messages, function(key, value) {
			messageToShow += value;
			messageToShow += "\n";
		});

		if(messageToShow && messageToShow.length > 0) { alert(messageToShow); }
	}
}

function showOrHidePageButtons() {
	$("#abroad_prev").css("visibility", (currentReportPage <= 1? "hidden": "visible"));
	$("#abroad_prev").css("visibility", (currentArrestPage <= 1? "hidden": "visible"));
}

function resetInputs() {
	var form = $("form");
	form.find("select").prop("selectedIndex", 0);
	form.find("input[type=file]").val("");
	form.find("#preview1").prop("src", "//image.gojls.com/gojls/img_ad/event/170427/step1_01.jpg");
	form.find("#preview2").prop("src", "//image.gojls.com/gojls/img_ad/event/170427/step1_02.jpg");
	form.find("#preview3").prop("src", "//image.gojls.com/gojls/img_ad/event/170427/step2_01.jpg");
	form.find("#preview4").prop("src", "//image.gojls.com/gojls/img_ad/event/170427/step2_02.jpg");
	form.find("textarea").val("");
}

function onClickBrowse(fileSelector) {
	
	if(cProcessState != 1) {					
		alert("현재 이벤트 기간이 아닙니다.\n이벤트 기간:  " + getUploadPeriodStr());
		return;
	}
	
	
	if(!isCookies) {
		alert("로그인 후 이용 가능합니다.");
		redirectToGojls();
		return;
	}
	if(!signedInAsStudent) {
		alert("이벤트 대상이 아닙니다. 중학교 1학년 이상 재원생만 이용 가능합니다.");
		return;
	}

	fileSelector.click();
	
}

function onFileChange(element, idOfElementPreview) {
	var filePath = element.value;
	if(!isItGodDamnOldenIE()) {
		if(filePath) {
			var file = element.files[0];
			if(file) {
				if(file.type.indexOf("image") === 0) {
					var fileReader = new FileReader();

					fileReader.onload = function(event) { $("#" + idOfElementPreview).prop("src", event.target.result); };
					fileReader.readAsDataURL(file);
				} else {
					element.value = null;
					idOfElementPreview.src = URL_TO_DUMMY_IMAGE;

					alert("이미지 파일을 선택해 주세요.");
				}
			} else {
				console.warn("filePath exists but file doesn't...?");

				element.value = null;
				idOfElementPreview.src = URL_TO_DUMMY_IMAGE;
			}
		}
	}
}

function onUploadResult(iframe) {
	var text = $(iframe).contents().text();
	if(text) {
		var messageToShow = "";

		try {
			var jsonObject = JSON.parse(text);
			if(jsonObject.messages && jsonObject.messages.length > 0) {
				$.each(jsonObject.messages, function(key, value) {
					messageToShow += value;
					messageToShow += "\n";
				});
			}
		} catch(error) {
			console.error(error);

			if(text.indexOf("MaxUploadSizeExceededException") >= 0) {
				messageToShow = "업로드 이미지 파일 크기는 최대 10MB 이하로 제한 됩니다.";
			} else {
				messageToShow = "문제가 발생하여 인증에 실패하였습니다.\n만약 Internet Explorer 7 또는 8을 사용하고 계시다면, Google Chrome 등을 이용해 주세요.";
			}
		}

		if(messageToShow.length > 0) { alert(messageToShow); }
	}

	loadContents();
	loadRanking();
	
}


function redirectToGojls() {
	
	if(opener) {
		opener.location.href = URL_TO_GOJLS_SIGN_IN;
		self.close();
	} else {
		window.location.href = URL_TO_GOJLS_SIGN_IN;
	}	
}


function isItGodDamnOldenIE() { return ieVersion && (ieVersion < 9); }
