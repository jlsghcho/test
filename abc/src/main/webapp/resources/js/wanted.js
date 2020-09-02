var REPEATABLE_CHARACTERS = [" ", "\r", "\n", "\t", ".", ","];
var IMAGE_SIZE_LIMIT = 10 * 1024 * 1024;
//var URL_TO_GOJLS_SIGN_IN = "https://www.gojls.com/member/loginform.do?event=EVH1K01&url=http://www.gojls.com/index.do";
var URL_TO_DUMMY_IMAGE = "resources/images/null%20photo.gif";
var NUMBER_OF_CONTENTS_PER_PAGE = 5;
var REFERRERS_TO_HEAD_FOR_THE_BOARD = ["event1.gojls.com", "event-os.gojls.com"];

var listenerForIframsAdded;

var areFormsEnabled = false;
var isItEventPeriod;
var encryptedUserSequence;
var userName;
var signedInAsStudent;
var isAttending;

var currentReportPage = 1;
var currentArrestPage = 1;

var ieVersion = (function() {
	var undef;
	var version = 3;
	var div = document.createElement("div");
	var all = div.getElementsByTagName("i");

	while(div.innerHTML = "<!--[if gt IE " + (++version) + "]><i></i><![endif]-->", all[0]) { }
	return version > 4? version: undef;
}());

$(document).ready(function() {
	$(window).scroll(function() { scrollEvent(); });
	$(window).resize(function() { scrollEvent(); });

	$("#previousReports").click(function() {
		currentReportPage--;
		if(currentReportPage <= 0) { currentReportPage = 1; }

		loadContents();
	});
	$("#previousArrests").click(function() {
		currentArrestPage--;
		if(currentArrestPage <= 0) { currentArrestPage = 1; }

		loadContents();
	});
	$("#nextReports").click(function() {
		currentReportPage++;
		loadContents();
	});
	$("#nextArrests").click(function() {
		currentArrestPage++;
		loadContents();
	});

	$("button#buttonBrowseForImage").click(function(event) { $("input#inputForImage").click(); });

	if(areFormsEnabled) {
		$("#memo").focus(
			function() {
				if(!encryptedUserSequence) {
					this.blur();
					alert("로그인 후 이용 가능합니다.");
					return;
				}
				if(!isAttending || !signedInAsStudent) {
					this.blur();
					alert("이벤트 대상이 아닙니다. 중학교 1학년 이상 재원생만 이용 가능합니다.");
					return;
				}

				showTextLengthIndicator(this, $("#memoState"));
			}
		).keydown(
			function() {
				if(!encryptedUserSequence) {
					alert("로그인 후 이용 가능합니다.");
					return;
				}
				if(!isAttending || !signedInAsStudent) {
					alert("이벤트 대상이 아닙니다. 중학교 1학년 이상 재원생만 이용 가능합니다.");
					return;
				}

				showTextLengthIndicator(this, $("#memoState"));
			}
		).keyup(
			function() {
				if(!encryptedUserSequence) {
					alert("로그인 후 이용 가능합니다.");
					return;
				}
				if(!isAttending || !signedInAsStudent) {
					alert("이벤트 대상이 아닙니다. 중학교 1학년 이상 재원생만 이용 가능합니다.");
					return;
				}

				showTextLengthIndicator(this, $("#memoState"));
			}
		).on("paste", function() {
			if(!encryptedUserSequence) {
				alert("로그인 후 이용 가능합니다.");
				return;
			}
			if(!isAttending || !signedInAsStudent) {
				alert("이벤트 대상이 아닙니다. 중학교 1학년 이상 재원생만 이용 가능합니다.");
				return;
			}

			showTextLengthIndicator(this, $("#memoState"));
		});
	} else {
		$("#reportingForm").find("*").prop("disabled", true);
		$("#arrestingForm").find("*").prop("disabled", true);
	}

	$("input.userSequenceContainer").val(encryptedUserSequence);

	if(REFERRERS_TO_HEAD_FOR_THE_BOARD.indexOf(document.referrer >= 0)) {
		_flash1(2);
		sr_nav(5);
	} else {
		loadContents();
	}
});

function loadContents() {
	if(!listenerForIframsAdded) {
		$("iframe").load(function() { onUploadResult(this); });
		listenerForIframsAdded = true;
	}

	var dataToServer = {};
	dataToServer["encryptedUserSequence"] = encryptedUserSequence;
	dataToServer["reportPage"] = currentReportPage;
	dataToServer["arrestPage"] = currentArrestPage;

	$.ajax({
		url: "/ace/load-contents",
		method: "POST",
		data: dataToServer,
		success: [function(dataFromServer) {
			try {
				if(dataFromServer.user) {
					isAttending = dataFromServer.user.isAttending;
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

				if(encryptedUserSequence) {
					$("#myReportCountArea").css("visibility", "visible");
					$("#myArrestCountArea").css("visibility", "visible");
					$("#myReportCount").text(dataFromServer.myReportCount);
					$("#myArrestCount").text(dataFromServer.myArrestCount);
				} else {
					$("#myReportCountArea").css("visibility", "hidden");
					$("#myArrestCountArea").css("visibility", "hidden");
				}

				try {
					$("#reportingRegion1").html("<b>1위</b> " + dataFromServer.regionReportCountPair[0].regionName);
					$("#reportingRegion2").html("<b>2위</b> " + dataFromServer.regionReportCountPair[1].regionName);
					$("#reportingRegion3").html("<b>3위</b> " + dataFromServer.regionReportCountPair[2].regionName);
				} catch(ignored) { }
				try {
					$("#arrestingRegion1").html("<b>1위</b> " + dataFromServer.regionArrestCountPair[0].regionName);
					$("#arrestingRegion2").html("<b>2위</b> " + dataFromServer.regionArrestCountPair[1].regionName);
					$("#arrestingRegion3").html("<b>3위</b> " + dataFromServer.regionArrestCountPair[2].regionName);
				} catch(ignored) { }

				renderReports(dataFromServer.reports);
				renderArrests(dataFromServer.arrests);

				showOrHidePageButtons();

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

function deleteContent(content) {
	if(confirm("컨텐츠를 삭제하시겠습니까?")) {
		var dataToServer = {};
		dataToServer["encryptedUserSequence"] = encryptedUserSequence;
		dataToServer["sequence"] = content.sequence;

		$.ajax({
			url: "/ace/delete",
			method: "POST",
			data: dataToServer,
			success: [function(dataFromServer) {
				try {
					loadContents();

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

	if(!encryptedUserSequence) {
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert("로그인 후 이용 가능합니다.");
		return false;
	}
	if(!isAttending || !signedInAsStudent) {
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert("이벤트 대상이 아닙니다. 중학교 1학년 이상 재원생만 이용 가능합니다.");
		return false;
	}
	var textValidation = validateText(commentSelector.val());
	if(textValidation !== null) {
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert(textValidation);
		return false;
	}
	if(selector.find("select[name=region]").prop("selectedIndex") < 1) {
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert("접수지역이 선택되지 않았습니다.");
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

	if(!encryptedUserSequence) {
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert("로그인 후 이용 가능합니다.");
		return false;
	}
	if(!isAttending || !signedInAsStudent) {
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert("이벤트 대상이 아닙니다. 중학교 1학년 이상 재원생만 이용 가능합니다.");
		return false;
	}
	if(selector.find("select[name=region]").prop("selectedIndex") < 1) {
		event.preventDefault? event.preventDefault(): (event.returnValue = false);
		alert("검거지역이 선택되지 않았습니다.");
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
	}

	var result = confirm("지금 선택한 사진 2장과 메시지로 검거 등록 하시겠습니까?");
	if(!result) { event.preventDefault? event.preventDefault(): (event.returnValue = false); }

	return result;
}

function validateText(text) {
	var consecutive = false;
	var previousCharacter = null;
	for(var i = 0; i < text.length; i++) {
		var character = text[i];
		if($.inArray(character, REPEATABLE_CHARACTERS)) {
			if(REPEATABLE_CHARACTERS.indexOf(character) >= 0) { continue; }
		}

		if(character === previousCharacter) {
			if(consecutive) { return "반복문자는 2개까지 사용가능 합니다. [예시 : oo,~~.. 등]"; }

			consecutive = true;
		} else {
			consecutive = false;
		}

		previousCharacter = character;
	}

	return null;
}

function showTextLengthIndicator(object, indicatorObjectSelection) {
	var objectSelection = $(object);
	var textLength = objectSelection.val().length;
	var maximumTextLength = objectSelection.prop("maxlength");
	indicatorObjectSelection.html("<b>" + textLength + "</b>/" + maximumTextLength);
}

function renderReports(reports) {
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
}
function renderArrests(arrests) {
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
}
function resetReportBoard() {
	for(var i = 1; i <= NUMBER_OF_CONTENTS_PER_PAGE; i++) {
		var selector = $("#report" + i);
		var leftSelector = selector.find(".left");
		var rightSelector = selector.find(".right");

		leftSelector.find("div").text("");
		leftSelector.find("img").prop("src", "//image.gojls.com/gojls/img_ad/event/170427/pic01.gif");
		leftSelector.find("a").prop("href", "javascript:");

		rightSelector.find("div").text("");
		rightSelector.find("img").prop("src", "//image.gojls.com/gojls/img_ad/event/170427/pic01.gif");
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
		leftSelector.find("img").prop("src", "//image.gojls.com/gojls/img_ad/event/170427/pic02.gif");
		leftSelector.find("a").prop("href", "javascript:");

		rightSelector.find("div").text("");
		rightSelector.find("img").prop("src", "//image.gojls.com/gojls/img_ad/event/170427/pic02.gif");
		rightSelector.find("a").prop("href", "javascript:");
		rightSelector.find("span.delete").remove();
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
	$("#previousReports").css("visibility", (currentReportPage <= 1? "hidden": "visible"));
	$("#previousArrests").css("visibility", (currentArrestPage <= 1? "hidden": "visible"));
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
	if(!encryptedUserSequence) {
		alert("로그인 후 이용 가능합니다.");
		return;
	}
	if(!isAttending || !signedInAsStudent) {
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
}

function isItGodDamnOldenIE() { return ieVersion && (ieVersion < 9); }

//  퀵메뉴
$(function() {
	var wsTop;
	var aSide;
	var aSideOffSet;

	aSide = $("#quick_rg");
	aSideOffSet = aSide.offset();

	if(aSide.length !== 0) {
		$(window).off("scroll").on("scroll", function() {
			wsTop = $(this).scrollTop() + 150;
			if(aSideOffSet.top < wsTop) {
				aSide.addClass("fixed")
			} else {
				aSide.removeClass("fixed")
			}
		});
	}
});

/* scroll */
function scrollEvent() {
	var location = $(window).scrollTop();
	//$(".pos_txt").text(locate);
	if(location == 0) {
		sr_nav(0, "scroll");
	} else if(location > $("#s1").offset().top && location < $("#s2").offset().top) {
		sr_nav(1, "scroll");
	} else if(location > $("#s2").offset().top && location < $("#s3").offset().top) {
		sr_nav(2, "scroll");
	} else if(location > $("#s3").offset().top && location < $("#s4").offset().top) {
		sr_nav(3, "scroll");
	}
}

/* global navigation */
function sr_nav(n, scroll) {
	if(n === 5 || n === 6) { loadContents(); }

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

function _flash1(id) {
	var max = 2;		//맥스숫자
	for(var i = 1; i <= max; i++) {
		var obj = document.getElementById("flash1_" + i);
		var img = document.getElementById("flash" + i);
		if(i === id) {
			obj.style.display = "";
			img.src = "//image.gojls.com/gojls/img_ad/event/170427/tab_study_flash" + i + "_over.gif";	//원본
		} else {
			obj.style.display = "none";
			img.src = "//image.gojls.com/gojls/img_ad/event/170427/tab_study_flash" + i + ".gif";	//변할꺼
		}
	}
}
