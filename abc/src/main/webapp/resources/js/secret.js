document.domain = "gojls.com";

var REPEATABLE_CHARACTERS = [" ", "\r", "\n", "\t", ".", ","];
var MINIMUM_LENGTH_FOR_TEXT = 40;
var IMAGE_SIZE_LIMIT = 10 * 1024 * 1024;
var URL_TO_GOJLS_SIGN_IN = "https://www.gojls.com/member/loginform.do?event=EVH1K01&url=http://www.gojls.com/index.do";
var URL_TO_DUMMY_IMAGE = "resources/images/null%20photo.gif";
var NUMBER_OF_CONTENTS_PER_PAGE = 15;

var isItEventPeriod;
var encryptedUserSequence;
var userName;
var signedInAsStudent;
var isAttending;

var currentPage = 16;

var isBusy;

var isItMobile = isMobile();
var ieVersion = (function() {
	var undef;
	var version = 3;
	var div = document.createElement("div");
	var all = div.getElementsByTagName("i");

	while(div.innerHTML = "<!--[if gt IE " + (++version) + "]><i></i><![endif]-->", all[0]) { }
	return version > 4? version: undef;
}());

$(document).ready(function() {
	$($(".ad_list li").eq(1)).addClass("on").siblings("li").removeClass("on").addClass("off");
	$(".banner_area").hide().eq(1).show();

	// hover
	$(".ad_list li").hover(function() {
		if(!$(this).hasClass("on")) {
			$(this).toggleClass("off");
		}
	}, function() {
		if(!$(this).hasClass("on")) {
			$(this).toggleClass("off");
		}
	});

	// click event
	$(".ad_list li").each(function(index) {
		$(this).click(function() {
			$(this).addClass("on").siblings("li").removeClass("on").addClass("off");
			$(".banner_area").hide().eq(index).show();

			if(index === 1) { loadContents(); }

			return false;
		});
	});

	$("input#inputForImage").click(function(event) {
		if(!isItEventPeriod) {
			event.preventDefault();
			alert("현재 Mission 인증기간이 아닙니다.\nMission 인증 기간: 4월 24일(월) ~ 5월 14일(일)");
			return;
		}

		if(!encryptedUserSequence) {
			event.preventDefault();
			alert("로그인 후 이용 가능합니다.");
			redirectToGojls();
			return;
		}

		if(!signedInAsStudent) {
			event.preventDefault();
			alert("로그인 된 학생 정보에 따라 영어 노출시간이 기록됩니다.\n학생 로그인으로 인증해 주세요.");
			redirectToGojls();
			return;
		}

		if(!isAttending) {
			event.preventDefault();
			alert("초등CHESS 재원생이 아닙니다. 초등CHESS 재원생만 이용 가능합니다.");
			return;
		}
	});
	$("button#buttonBrowseForImage").click(function(event) { $("input#inputForImage").click(); });

	$("textarea").keyup(function(event) {
		if(!isItEventPeriod) {
			event.preventDefault();
			alert("현재 Mission 인증기간이 아닙니다.\nMission 인증 기간: 4월 24일(월) ~ 5월 14일(일)");
			return;
		}

		if(encryptedUserSequence) {
			if(!signedInAsStudent) {
				event.preventDefault();
				alert("로그인 된 학생 정보에 따라 영어 노출시간이 기록됩니다.\n학생 로그인으로 인증해 주세요.");
				redirectToGojls();
				return;
			}
		} else {
			event.preventDefault();
			alert("로그인 후 이용 가능합니다.");
			redirectToGojls();
			return;
		}

		if(!signedInAsStudent) {
			event.preventDefault();
			alert("로그인 된 학생 정보에 따라 영어 노출시간이 기록됩니다.\n학생 로그인으로 인증해 주세요.");
			redirectToGojls();
			return;
		}

		if(!isAttending) {
			event.preventDefault();
			alert("초등CHESS 재원생이 아닙니다. 초등CHESS 재원생만 이용 가능합니다.");
			return;
		}
	});
	$("#imageDescription").focus(
		function() { showTextLengthIndicator(this, $("#imageDescriptionState")); }
	).keydown(
		function() { showTextLengthIndicator(this, $("#imageDescriptionState")); }
	).keyup(
		function() { showTextLengthIndicator(this, $("#imageDescriptionState")); }
	);

	$("#text").focus(
		function() { showTextLengthIndicator(this, $("#textState")); }
	).keydown(
		function() { showTextLengthIndicator(this, $("#textState")); }
	).keyup(
		function() { showTextLengthIndicator(this, $("#textState")); }
	);

	if(encryptedUserSequence) { getClassData(); }
});

function onFileChange(element) {
	var filePath = element.value;
	var fileNameContent = filePath.replace(/^C:\\fakepath\\/i, "");

	if(!isItGodDamnOldenIE()) {
		var img = document.getElementById("imageToUpload");
		if(filePath) {
			var file = document.getElementById("inputForImage").files[0];
			if(file) {
				var size = element.files[0].size;
				var sizeInMb = size / (1024 * 1024);
				fileNameContent += (" (" + sizeInMb.toPrecision(2) + "MB)");

				if(file.type.indexOf("image") === 0) {
					var fileReader = new FileReader();

					fileReader.onload = function(event) { img.src = event.target.result; };
					fileReader.readAsDataURL(file);
				} else {
					element.value = null;
					fileNameContent = "";
					img.src = URL_TO_DUMMY_IMAGE;

					alert("이미지 파일을 선택해 주세요.");
				}
			} else {
				console.warn("filePath exists but file doesn't...?");

				element.value = null;
				fileNameContent = "";
				img.src = URL_TO_DUMMY_IMAGE;
			}
		}
	}

	$("#fileName").val(fileNameContent);
}
function onClickUploadText() {
	if(isBusy) {
		alert("인증 저장 중 입니다.\n잠시만 기다려주세요.");
		return;
	}

	if(encryptedUserSequence) {
		if(signedInAsStudent) {
			if(isAttending) {
				var text = document.getElementById("text").value;

				var textValidationResult = validate(text, false);
				if(textValidationResult === null) {
					if(confirm("후기인증을 저장하시겠습니까?")) { uploadText(text, encryptedUserSequence, userName); }
				} else {
					alert(textValidationResult);
				}
			} else {
				alert("초등CHESS 재원생이 아닙니다. 초등CHESS 재원생만 이용 가능합니다.");
			}
		} else {
			alert("로그인 된 학생 정보에 따라 영어 노출시간이 기록됩니다.\n학생 로그인으로 인증해 주세요.");
			redirectToGojls();
		}
	} else {
		alert("로그인 후 이용 가능합니다.");
		redirectToGojls();
	}
}
function onClickUploadImage() {
	if(isBusy) {
		alert("인증 저장 중입니다.\n잠시 후에 다시 시도해 주세요.");
		return;
	}

	if(encryptedUserSequence) {
		if(signedInAsStudent) {
			if(isAttending) {
				if(isItGodDamnOldenIE()) {
					if(confirm("사진인증을 저장하시겠습니까?")) { uploadImage(); }
				} else {
					var file = $("#inputForImage").prop("files")[0];
					if(file) {
						if(file.size < IMAGE_SIZE_LIMIT) {
							var textValidationResult = validate($("#imageDescription").val(), true);
							if(textValidationResult === null) {
								if(confirm("사진인증을 저장하시겠습니까?")) { uploadImage(); }
							} else {
								alert(textValidationResult);
							}
						} else {
							alert("인증에 사용되는 사진은 10MB를 넘을 수 없습니다.");
						}
					} else {
						alert("인증에 사용할 사진을 선택해 주세요!");
					}
				}
			} else {
				alert("초등CHESS 재원생이 아닙니다. 초등CHESS 재원생만 이용 가능합니다.");
			}
		} else {
			alert("로그인 된 학생 정보에 따라 영어 노출시간이 기록됩니다.\n학생 로그인으로 인증해 주세요.");
			redirectToGojls();
		}
	} else {
		alert("로그인 후 이용 가능합니다.");
		redirectToGojls();
	}
}
function onDummyLoad(dummy) {
	isBusy = false;

	var text = $(dummy).contents().text();
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
				messageToShow = "인증에 사용되는 사진은 10MB를 넘을 수 없습니다.";
			} else {
				messageToShow = "문제가 발생하여 인증에 실패하였습니다.\nInternet Explorer 7 또는 8을 사용하고 계신다면, Google Chrome 등을 이용해 주세요.";
			}
		}

		alert(messageToShow);
	}

	loadContents();
}

function getClassData() {
	$.ajax({
		url: "/home/post-class-data",
		method: "POST",
		data: { encryptedUserSequence: encryptedUserSequence },
		success: [function(dataFromServer) {
			isAttending = dataFromServer;
		}],
		error: function(xhr, ajaxOptions, thrownError) {
			console.error("xhr: " + xhr);
			console.error("ajaxOptions: " + ajaxOptions);
			console.error("thrownError: " + thrownError);
		}
	});
}
function loadContents() {
	var datatToServer = {};
	datatToServer["encryptedUserSequence"] = encryptedUserSequence;
	datatToServer["page"] = currentPage;

	$.ajax({
		url: "/home/load-contents",
		method: "POST",
		data: datatToServer,
		success: [function(dataFromServer) {
			try {
				var contents = dataFromServer;

				var uploadCount = dataFromServer.uploadCount;
				//if(uploadCount && uploadCount >= 100) { $("#uploadCount").text("현재 " + uploadCount + "개 인증 중"); }
				$("#totalUploadCount").text("총 " + uploadCount + "건");

				renderContents(contents);
			} catch(error) {
				alert("에러가 발생하여 컨텐츠를 불러오지 못했습니다.");
			}
		}],
		error: function(xhr, ajaxOptions, thrownError) {
			console.error("xhr: " + xhr);
			console.error("ajaxOptions: " + ajaxOptions);
			console.error("thrownError: " + thrownError);
		}
	});

	resetInputs();
}
function uploadText(text, encryptedUserSequence, encryptedUserName) {
	var dataToServer = {};
	dataToServer["text"] = text;
	dataToServer["encryptedUserSequence"] = encryptedUserSequence;
	dataToServer["userName"] = encryptedUserName;

	isBusy = true;
	$.ajax({
		url: "/home/upload-text",
		method: "POST",
		data: dataToServer,
		success: [function(dataFromServer) {
			console.log(dataFromServer);

			isBusy = false;

			var messages = dataFromServer["messages"];
			var success = dataFromServer["success"];

			if(messages && messages.length > 0) {
				var messageToShow = "";
				$.each(messages, function(key, value) {
					messageToShow += value;
					messageToShow += "\n";
				});

				alert(messageToShow);
			}

			loadContents();
		}],
		error: function(xhr, ajaxOptions, thrownError) {
			console.error("xhr: " + xhr);
			console.error("ajaxOptions: " + ajaxOptions);
			console.error("thrownError: " + thrownError);

			isBusy = false;
		}
	});
}
function uploadImage() {
	$("#dummy").contents().html("");

	var inputText = $("#inputImageDescription");
	var inputUserSequence = $("#encryptedUserSequence");
	var inputUserName = $("#userName");

	inputText.val($("#imageDescription").val());
	inputUserSequence.val(encryptedUserSequence);
	inputUserName.val(userName);

	isBusy = true;
	var submit = document.getElementById("imageUploadingForm");
	try {
		submit.submit();
	} catch(error) {
		console.warn(error);

		setTimeout(function() { submit.submit(); }, 444);
	}
}

function resetInputs() {
	$("input").val(null);
	$("textarea").val(null);
	$("#imageDescriptionState").text("");
	$("#textState").text("");
	$("#imageToUpload").prop("src", URL_TO_DUMMY_IMAGE)
}
function renderContents(contents) {
	var size = contents.uploadCount;
	if(size && size > 0) {
		//var startIndex = (currentPage - 1) * NUMBER_OF_CONTENTS_PER_PAGE;

		for(var i = 0; i < NUMBER_OF_CONTENTS_PER_PAGE; i++) {
			//var index = startIndex + i;
			var listId = "list-item" + (i + 1);
			var element = document.getElementById(listId);
			var div = $(element).find("div");
			var img = $(element).find("img");
			var h5 = $(element).find("h5");

			var text;

			var content = contents[i];
			if(content) {
				text = content.text;

				img.css("width", "178px");
				img.css("height", "178px");

				if(content.hasImage && content.imageUrl && content.imageUrl.length > 0) {
					img.attr("src", content.imageUrl);

					div.addClass("description");
					div.removeClass("description_text");
				} else {
					img.attr("src", URL_TO_DUMMY_IMAGE);
					div.removeClass("description");
					div.addClass("description_text");
				}
			} else {
				img.attr("src", URL_TO_DUMMY_IMAGE);
				div.addClass("description");
				div.removeClass("description_text");
				text = null;
			}

			if(text && text.length > 0) {
				h5.text(text);
			} else {
				h5.text("");
			}
		}

		$("#abroad_prev").off("click");
		$("#abroad_next").off("click");
		if(currentPage === 1) {
			$("#abroad_prev").addClass("invisible");
		} else if(currentPage > 1) {
			$("#abroad_prev").removeClass("invisible").on("click", function() {
				currentPage--;
				loadContents();
			});
		}

		var numberOfPages = Math.ceil(size / NUMBER_OF_CONTENTS_PER_PAGE);
		if(currentPage >= numberOfPages) {
			$("#abroad_next").addClass("invisible");
		} else {
			$("#abroad_next").removeClass("invisible").on("click", function() {
				currentPage++;
				loadContents();
			});
		}
	}
}
function isItGodDamnOldenIE() { return ieVersion && (ieVersion < 9); }
function validate(text, nullable) {
	if(!nullable && (!text || text.length < MINIMUM_LENGTH_FOR_TEXT)) { return "후기는 최소한 " + MINIMUM_LENGTH_FOR_TEXT + " 글자 이상 작성해 주세요."; }

	var consecutive = false;
	var previousCharacter = null;
	for(var i = 0; i < text.length; i++) {
		var character = text[i];
		if($.inArray(character, REPEATABLE_CHARACTERS)) {
			if(REPEATABLE_CHARACTERS.indexOf(character) >= 0) { continue; }
		}

		if(character === previousCharacter) {
			if(consecutive) { return "ㅋㅋㅋ,ㅎㅎㅎ,~~~ 등의 반복 문자는 2개까지 사용가능 합니다."; }

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
	var maximumTextLength = objectSelection.attr("maxlength");
	indicatorObjectSelection.text(textLength + "/" + maximumTextLength);
}

function isMobile() {
	var userAgent = navigator.userAgent || navigator.vendor || window.opera;

	return (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series([46])0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(userAgent) ||
	/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br([ev])w|bumb|bw-([nu])|c55\/|capi|ccwa|cdm-|cell|chtm|cldc|cmd-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc-s|devi|dica|dmob|do([cp])o|ds(12|-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly([-_])|g1 u|g560|gene|gf-5|g-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd-([mpt])|hei-|hi(pt|ta)|hp( i|ip)|hs-c|ht(c([- _agpst])|tp)|hu(aw|tc)|i-(20|go|ma)|i230|iac([ -\/])|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja([tv])a|jbro|jemu|jigs|kddi|keji|kgt([ \/])|klon|kpt |kwc-|kyo([ck])|le(no|xi)|lg( g|\/([klu])|50|54|-[a-w])|libw|lynx|m1-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t([- ov])|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30([02])|n50([025])|n7(0([01])|10)|ne(([cm])-|on|tf|wf|wg|wt)|nok([6i])|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan([adt])|pdxg|pg(13|-([1-8]|c))|phil|pire|pl(ay|uc)|pn-2|po(ck|rt|se)|prox|psio|pt-g|qa-a|qc(07|12|21|32|60|-[2-7]|i-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h-|oo|p-)|sdk\/|se(c([-01])|47|mc|nd|ri)|sgh-|shar|sie([-m])|sk-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h-|v-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl-|tdg-|tel([im])|tim-|t-mo|to(pl|sh)|ts(70|m-|m3|m5)|tx-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c([- ])|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas-|your|zeto|zte-/i.test(userAgent.substr(0, 4)));
}
function redirectToGojls() {
	if(opener) {
		opener.location.href = URL_TO_GOJLS_SIGN_IN;
		self.close();
	} else {
		window.location.href = URL_TO_GOJLS_SIGN_IN;
	}
}
