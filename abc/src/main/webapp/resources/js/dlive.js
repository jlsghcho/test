//document.domain = "gojls.com";

var startSetting = 0;
var REPEATABLE_CHARACTERS = [" ", "\r", "\n", "\t", ".", ","];
var MINIMUM_LENGTH_FOR_TEXT = 40;
var IMAGE_SIZE_LIMIT = 10 * 1024 * 1024;
var URL_TO_GOJLS_SIGN_IN = "https://www.gojls.com/login?preURL=https://event.gojls.com/dlive";
var URL_TO_DUMMY_IMAGE = "//image.gojls.com/newjls/img/event/20170907_event/photo.gif";
var NUMBER_OF_CONTENTS_PER_PAGE = 15;
var NUMBER_OF_CONTENTS_PER_OWN = 5;

var currentPage = 1;
var isBusy;
var eventListClicked = 0;

var cEventSeq;
var cProcessState;
var cAnnounceDate ="";
var cStartDate ="";
var cCloseDate ="";
var userCount;
var isCookies;
var selEventSeq;
var totalUploadCount;
var isTap;


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
	
	$(window).scroll(function() {scrollEvent();	});
	$(window).resize(function() {scrollEvent();	});	
	
	// 학생 선택
	if(userCount > 1)
	{
		var checkCnt = $("input[name=userSelect]:checked").size();
		if (checkCnt == 0) {$("input[name=userSelect]").eq(0).attr("checked", true); changeuser();}
	}
	$("input[name=userSelect]").change(function() {changeuser();});
	
	
	// 이벤트 선택 버튼
	$("#eventListCombo").change(function() {changeEventList(1);});
		
	// 인증 타입 변경
	$("input[name=selectUploadType]").eq(0).attr("checked", true);
	$("input[name=selectUploadType]").change(function() {
		
		if(cProcessState != 1) {
			event.preventDefault();
			alert("현재 Mission 인증기간이 아닙니다.\nMission 인증 기간: " + getUploadPeriodStr());
			resetInputs(); 
			return;
		}

		if(userCount == 0) {
			
			if(isCookies == 1) {
				//event.preventDefault();
				alert("초등CHESS 재원생만 이용 가능합니다.");
				return;
			}
			
			event.preventDefault();
			alert("로그인 후 이용 가능합니다.");
			redirectToGojls();
			return;
		}	
		
		resetInputs();
		
	});
	
	// 입력 가능 여부 체크  :  로그인 상태 아닌 경우 로그인 페이지로 이동
	$("textarea").keyup(function(event) {checkLogin();});
	$("input#inputForImage").click(function(event) {
		
		if(cProcessState != 1) {
			event.preventDefault();
			alert("현재 Mission 인증기간이 아닙니다.\nMission 인증 기간: " + getUploadPeriodStr());
			resetInputs(); 
			return;
		}
		
		if(userCount == 0) {
			
			if(isCookies == 1) {
				//event.preventDefault();
				alert("초등CHESS 재원생만 이용 가능합니다.");
				return;
			}
			
			event.preventDefault();
			alert("로그인 후 이용 가능합니다.");
			redirectToGojls();
			return;
		}
		
	});
	$("button#buttonBrowseForImage").click(function(event) { $("input#inputForImage").click(); });
	resetInputs(); 
	
	$("#imageDescription").focus(
		function() { showTextLengthIndicator(this, $("#imageDescriptionState")); }
	).keydown(
		function() { showTextLengthIndicator(this, $("#imageDescriptionState")); }
	).keyup(
		function() { showTextLengthIndicator(this, $("#imageDescriptionState")); }
	);	
	
	// 페이지 카운트 증가	
	changeEventList(0);
	addPageCount();
	
	
	if(cProcessState > 1 )
	{
		_flash1(2); 
	}
	else if(isTap == 1)
	{
		_flash1(2); sr_nav(5);
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


//선택한 사용자으ㅟ 영어 노출 시간
function addPageCount() {
	
	var datatToServer = {};
	datatToServer["eventSeq"] = cEventSeq;
	
	$.ajax({
		url: "/dlive/addPageCount",
		method: "POST",
		data: datatToServer,
		success: [function(dataFromServer) {
			try {
				
			} catch(error) {
				alert("에러가 발생하여 콘텐츠를 불러오지 못했습니다.addPageCount");
			}
		}],
		error: function(xhr, ajaxOptions, thrownError) {
			
			console.error("addPageCount");
			console.error("xhr: " + xhr);
			console.error("ajaxOptions: " + ajaxOptions);
			console.error("thrownError: " + thrownError);
		}
	});
}


function checkLogin()
{
	if(cProcessState != 1) {
		event.preventDefault();
		alert("현재 Mission 인증기간이 아닙니다.\nMission 인증 기간: " + getUploadPeriodStr());
		resetInputs(); 
		return;
	}
	
	if(userCount == 0) {
		
		if(isCookies == 1) {
			//event.preventDefault();
			alert("초등CHESS 재원생만 이용 가능합니다.");
			return;
		}
		
		event.preventDefault();
		alert("로그인 후 이용 가능합니다.");
		redirectToGojls();
		return;
	}
}


//유저가 변경 되었을 겨우
function changeuser()
{	
	// 사용자 바뀔때
	var selUserSeq = $('input[name=userSelect]:radio:checked').val();
	var selUserName = $('input[name=userSelect]:radio:checked').next('label:first').html();
	
	$("#userName").html(selUserName+"학생 ");
	$("#selUserName").val(selUserName);
	$("#selUserSeq").val(selUserSeq);
	
	getUserTime(selUserSeq);
	loadOwnContents();
	
}

//선택한 사용자으ㅟ 영어 노출 시간
function getUserTime(selUserSeq) {
	
	var datatToServer = {};
	datatToServer["userSeq"] = selUserSeq;
	
	$.ajax({
		url: "/dlive/getUserTimeInfo",
		method: "POST",
		data: datatToServer,
		success: [function(dataFromServer) {
			try {
				var ut = dataFromServer;
				$("#userTime").html(ut);				
			} catch(error) {
				alert("에러가 발생하여 콘텐츠를 불러오지 못했습니다.getUserTime");
			}
		}],
		error: function(xhr, ajaxOptions, thrownError) {
			console.error("getUserTime");
			console.error("xhr: " + xhr);
			console.error("ajaxOptions: " + ajaxOptions);
			console.error("thrownError: " + thrownError);
		}
	});
}


//지난 이벤트 차수를 변경하였을 경우  
function changeEventList(num)
{	
	 var eventListIndex = $("#eventListCombo").val();
	 var doAct = 0;
	 
	if(num == 0) // 처음 페이지 들어 왔을 경우, dlive 탭을 선택한 경우
	{	
		if(eventListIndex != cEventSeq )
		{
			$("#eventListCombo").val(cEventSeq);
			$("#eventfinish3").hide();
			eventListClicked = 1;
			eventListIndex = cEventSeq;
			doAct = 1;
		}
	}
	else{
		doAct = 1;
	}
	
	if(doAct == 1)
	{	
		
		totalUploadCount = 0;
		loadContents();
		loadOwnContents();
		
		if(cEventSeq == eventListIndex )
		{	
			
			if( cProcessState  == 2)
			{
				var wd = cAnnounceDate.toString();
				var year = wd.substring(0,4);
				var month = wd.substring(4,6);
				var day = wd.substring(6, 8);
				$("#eventfinish3").find("h3").html("인증 시간이 만료 되었습니다.<br> 그동안 참여해 주셔서 감사합니다.<br> 당첨자발표 : " + year + "-" + month + "-" + day);
				
			}
			
			if( cProcessState  == 3)
			{
				$("#eventfinish3").find("h3").html("인증 시간이 만료 되었습니다.<br> 그동안 참여해 주셔서 감사합니다.<br>");
				$("#eventfinish3").find("h4").show(); 
				getEventInfo();
			}
			
		}
		else
		{	
			$("#eventfinish3").find("h3").html("인증 시간이 만료 되었습니다.<br> 그동안 참여해 주셔서 감사합니다.<br>");
			$("#eventfinish3").find("h4").show(); 
			getEventInfo();
		}	
		
		if(cEventSeq != eventListIndex)
		{	
			$("#balloon").show();
			$("#eventfinish3").show();
		}
		else 
		{	
			if(cProcessState > 1 )
			{
				$("#balloon").hide();
				//$("#entertop").hide();
				$("#eventfinish3").show();
			}
			else
			{
				$("#balloon").show();
				//$("#entertop").show();
				$("#eventfinish3").hide();
			}
		}
	}
}


function getEventInfo()
{
	
	var sEventSeq = $("#eventListCombo").val();
	
	if(!sEventSeq || eventListClicked == 0)
		return;
	
	
	$.ajax({
		url: "/dlive/getEventInfo",
		method: "POST",
		data: { eventSeq: sEventSeq },
		success: [function(dataFromServer) {
			
			var startDate = dataFromServer.startEventDate;
			var endDate = dataFromServer.endEventDate;
			var wurl = dataFromServer.winnerAnnURL;
			
			$("#wAnnUrl").attr("href", dataFromServer.winnerAnnURL);
			
			if(startDate &&  startDate.length > 0 && endDate && endDate.length)
			{	
				var ss = startDate.substring(4, 6)+"/"+startDate.substring(6, 8)+"/"+startDate.substring(0, 4);
				var cc = endDate.substring(4, 6)+"/"+endDate.substring(6, 8)+"/"+endDate.substring(0, 4);
				var sD = new Date(ss);
				var cD = new Date(cc);
				var week = new Array('일', '월', '화', '수', '목', '금', '토' );
				
				var period = "기간 : " +(sD.getMonth()+1) + "월 " + sD.getDate() + "일 (" + week[sD.getDay()] + ") ~ " + (cD.getMonth()+1) + "월 " + cD.getDate() + "일 (" + week[cD.getDay()] + ")";
				$("#eventPeriod").text(period);
			}			
			
		}],
		error: function(xhr, ajaxOptions, thrownError) {
			console.error("loadEventInfo");
			console.error("xhr: " + xhr);
			console.error("ajaxOptions: " + ajaxOptions);
			console.error("thrownError: " + thrownError);
		}
	});
	
	resetInputs();
}
//사진 파일  찾기
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


//인증하기 버튼
function onClickUpload() {

	if(isBusy) {
		alert("인증 저장 중입니다.\n잠시 후에 다시 시도해 주세요.");
		return;
	}

	if(userCount > 0) {
	
		var uploadType = $("input[name=selectUploadType]:radio:checked").val();
		if( uploadType == "photo") // 사진 인증
		{
			if(isItGodDamnOldenIE()) {
				if(confirm("사진인증을 저장하시겠습니까?")) { uploadImage(); }
			} else {
				
				/// 이미지
				var file = $("#inputForImage").prop("files")[0];
				if(file) {
					if(file.size < IMAGE_SIZE_LIMIT) {
						var textValidationResult = validate($("#imageDescription").val(), true);
						if(textValidationResult == null) {
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
		}
		if(uploadType == "txt")
		{	
			var text = document.getElementById("imageDescription").value;
			var textValidationResult = validate(text, false);
			if(textValidationResult === null) {
				if(confirm("후기인증을 저장하시겠습니까?")) { uploadText(text); }
			} else {
				alert(textValidationResult);
			}
		}
			
	} else {
		
		if(isCookies == 1) {
			//event.preventDefault();
			alert("초등CHESS 재원생만 이용 가능합니다.");
			return;
		}
		
		alert("로그인 후 이용 가능합니다.");
		redirectToGojls();
	}
}

Number.prototype.format = function(){
	
	if(this==0)return 0;
	var reg = /(^[+-]?\d+)(\d{3})/;
	var n = (this + '');
	while(reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
	return n;
	
}

function loadContents() {
	
	if(eventListClicked == 0)
		return;
		
	var sEventSeq = $("#eventListCombo").val();
	if(!sEventSeq )
		return;
	
	var dataToServer = {};	
	dataToServer["page"] = currentPage;	
	dataToServer["eventSeq"] = sEventSeq;
		
	$.ajax({
		url: "/dlive/load-contents",
		method: "POST",
		data: dataToServer,
		success: [function(dataFromServer) {
			try {
				var contents = dataFromServer;
				totalUploadCount = dataFromServer.uploadCount;
				
				
				$("#totalCurrentEvnetUploadCount").html(totalUploadCount.format());
				$("#totalSelectEventUploadCount").html(totalUploadCount.format());	
				
				renderContents(contents);
				
			} catch(error) {
				
				alert("에러가 발생하여 콘텐츠를 불러오지 못했습니다.loadContents");
				
			}
		}],
		error: function(xhr, ajaxOptions, thrownError) {
			
			console.error("loadContents");
			console.error("xhr: " + xhr);
			console.error("ajaxOptions: " + ajaxOptions);
			console.error("thrownError: " + thrownError);
		}
	});
	
	resetInputs();
}


function renderContents(contents) {
	
	
	for(var i = 0; i < NUMBER_OF_CONTENTS_PER_PAGE; i++) {
		
		$("#list-item" + (i + 1)).find("img").attr("src", URL_TO_DUMMY_IMAGE);
		$("#list-item" + (i + 1)).find("div").addClass("description");			
		$("#list-item" + (i + 1)).find("div").removeClass("description_text");
		$("#list-item" + (i + 1)).find("h5").text("");
	}
	
	
	var size = contents.uploadCount;
	if(size && size > 0) {
		
		for(var i = 0; i < size; i++) {
			
			var text ;
			var content = contents[i];
			
			if(content) {
				
				text = content.text;
				$("#list-item" + (i + 1)).find("img").css("width", "178px");
				$("#list-item" + (i + 1)).find("img").css("height", "178px");
	
				if(content.hasImage && content.imageUrl && content.imageUrl.length > 0) {
					$("#list-item" + (i + 1)).find("img").attr("src", content.imageUrl); 
					$("#list-item" + (i + 1)).find("div").addClass("description");			
					$("#list-item" + (i + 1)).find("div").removeClass("description_text");
				} else {
					$("#list-item" + (i + 1)).find("img").attr("src", URL_TO_DUMMY_IMAGE);
					$("#list-item" + (i + 1)).find("div").addClass("description_text");			
					$("#list-item" + (i + 1)).find("div").removeClass("description");
				}
			} 
			
			if(text && text.length > 0) {
				$("#list-item" + (i + 1)).find("h5").text(text);
			} else {
				$("#list-item" + (i + 1)).find("h5").text("");
			}
		}
	
		$("#abroad_prev").off("click");
		$("#abroad_next").off("click");
		if(currentPage == 1) {
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
		
		pagesettion();
	}	
}


function changePage(index)
{
	currentPage = index;
	loadContents();
}


function pagesettion()
{
	 
	var lastPageIndex =  parseInt(totalUploadCount / NUMBER_OF_CONTENTS_PER_PAGE);
	if(parseInt(totalUploadCount % NUMBER_OF_CONTENTS_PER_PAGE)>0){lastPageIndex++;}
	
	var startIndex = parseInt((currentPage-1)/5)*5 + 1;
	var endIndex =  startIndex+4;
	
	if(endIndex > lastPageIndex){endIndex = lastPageIndex;}
	 
	var htmlstr = "";
	if(startIndex > 1){
		htmlstr += "<a href='javascript:changePage("+ (startIndex-5)+")'><span class='previous'>이전</span></a>";
	}
	
	for(i = startIndex ;  i < endIndex+1 ; i++ )
	{	
		if(i == currentPage){
			htmlstr += " <a href='javascript:changePage(" + i +")'><span class='selected'>"+i+"</span></a>";
		}
		else{
			htmlstr += " <a href='javascript:changePage(" + i +")'><span>"+i+"</span></a>";
		}
	}
	if(endIndex < lastPageIndex){
		htmlstr += "<a href='javascript:changePage("+ (startIndex+5)+")'><span class='next'>다음</span></a>"; 
	}	
	
	$("#pagemenu").html(htmlstr);
	
}

function loadOwnContents() {
	
	var userSeq = $("#selUserSeq").val();
	var sEventSeq = $("#eventListCombo").val();
	
	if(userCount < 1 || !userSeq  || !sEventSeq )
		return;
	
	if(eventListClicked == 0)
		return;
	
	var dataToServer = {};
	dataToServer["userSeq"] = userSeq;
	dataToServer["eventSeq"] = sEventSeq;
	
	$.ajax({
		url: "/dlive/load-owncontents",
		method: "POST",
		data: dataToServer,
		success: [function(dataFromServer) {
			try {
				
				var contents = dataFromServer;
				var uploadCount = dataFromServer.uploadCount;
				loadOwnCount = uploadCount;
				renderOwnContents(contents);
				
			} catch(error) {
				
				alert("에러가 발생하여 콘텐츠를 불러오지 못했습니다.loadOwnContents");
				
			}
		}],
		error: function(xhr, ajaxOptions, thrownError) {
			
			console.error("loadOwnContents");
			console.error("xhr: " + xhr);
			console.error("ajaxOptions: " + ajaxOptions);
			console.error("thrownError: " + thrownError);
		}
	});
	
	resetInputs();
}

function renderOwnContents(contents) {
	
	var sEventSeq = $("#eventListCombo").val();
	for(var i = 0; i < NUMBER_OF_CONTENTS_PER_OWN; i++) {
			
			$("#mylist-item" + (i + 1)).find("h4").hide();			
			$("#mylist-item" + (i + 1)).find("img").attr("src", URL_TO_DUMMY_IMAGE);
			$("#mylist-item" + (i + 1)).find("div").addClass("description");			
			$("#mylist-item" + (i + 1)).find("div").removeClass("description_text");
			$("#mylist-item" + (i + 1)).find("h5").text("");
			$("#mylist-item" + (i + 1)).find("input").val("");
	}
	
	var size = contents.uploadCount;
	if(size && size > 0) {
		
			for(var i = 0; i < size; i++) {
					
					var text;
					var content = contents[i];
		
					if(content) {
						
						if(sEventSeq == cEventSeq)
						{
							$("#mylist-item" + (i + 1)).find("h4").show();
							$("#dliveseq" + (i+1)).val(content.sequence);
						}
		
						text = content.text;
						$("#mylist-item" + (i + 1)).find("img").css("width", "178px");
						$("#mylist-item" + (i + 1)).find("img").css("height", "178px");
		
						if(content.hasImage && content.imageUrl && content.imageUrl.length > 0) {
							$("#mylist-item" + (i + 1)).find("img").attr("src", content.imageUrl);
							$("#mylist-item" + (i + 1)).find("div").addClass("description");
							$("#mylist-item" + (i + 1)).find("div").removeClass("description_text");
						} else {
							$("#mylist-item" + (i + 1)).find("img").attr("src", URL_TO_DUMMY_IMAGE);
							$("#mylist-item" + (i + 1)).find("div").removeClass("description");
							$("#mylist-item" + (i + 1)).find("div").addClass("description_text");
						}
					} 
					
					if(text && text.length > 0) {
						$("#mylist-item" + (i + 1)).find("h5").text(text);
					} else {
						$("#mylist-item" + (i + 1)).find("h5").text("");
					}
					
			}
	}
}


function uploadText(text) {
	
	var dataToServer = {};
	dataToServer["text"] = text;
	dataToServer["userSeq"] = $("#selUserSeq").val();
	dataToServer["userName"] = $("#selUserName").val();
	dataToServer["eventSeq"] = $("#eventListCombo").val();

	isBusy = true;
	$.ajax({
		url: "/dlive/upload-text",
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
			loadOwnContents();
		}],
		error: function(xhr, ajaxOptions, thrownError) {
			
			console.error("uploadText");
			console.error("xhr: " + xhr);
			console.error("ajaxOptions: " + ajaxOptions);
			console.error("thrownError: " + thrownError);
			

			isBusy = false;
		}
	});
}


function uploadImage() {
	
	$("#dummy").contents().html("");
	
	 $("#inputImageDescription").val($("#imageDescription").val());
	 $("#inputUserSequence").val($("#selUserSeq").val());
	 $("#inputUserName").val($("#selUserName").val());
	 $("#inputEventSeq").val($("#eventListCombo").val());

		
	isBusy = true;
	var submit = document.getElementById("imageUploadingForm");
	try {
		submit.submit();
	} catch(error) {
		console.warn(error);
		setTimeout(function() { submit.submit(); }, 444);
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
				messageToShow = "문제가 발생하여 인증에 실패하였습니다.\nInternet Explorer 7 또는 8을 사용하고 계시다면, Google Chrome 등을 이용해 주세요.";
			}
		}

		alert(messageToShow);
	}
	
	
	loadContents();
	loadOwnContents();
}


function resetInputs() {
	
	var etype = $('input[name=selectUploadType]:radio:checked').val();
	
	$("textarea").val(null);					// id="imageDescription" , "inputImageDescription"	
	$("#fileName").val(null);					// 파일 패스	id=fileName  
	$("#inputForImage").val(null);				// 파일 인풋	id=inputForImage		
	$("#imageDescriptionState").text("");		// 문자 입력 1/50
	$("#imageToUpload").prop("src", URL_TO_DUMMY_IMAGE)	// 그림 이미지
	
	
	if(etype == "photo")
	{	
		$("#fileImageInputBox").show();
	}
	else
	{	
		$("#fileImageInputBox").hide();
	}
	
}


function deleteContent(sel)
{
	//return;
	
	var userSeq = $("#selUserSeq").val();
	var userName = $("#selUserName").val();
	var dliveseq = $("#dliveseq" + sel).val();
	
	if(userCount < 1 || !userSeq || !dliveseq)
		return;
	
	if(processState != 1)
		return;
	
	if(cEventSeq != selEventSeq)
		return;
	
	if(confirm("인증된 정보를 삭제하시겠습니까?")) { 
	
		var dataToServer = {};
		dataToServer["userSeq"] = userSeq;
		dataToServer["userName"] = userName;
		dataToServer["dliveSeq"] = dliveseq;
		 
		$.ajax({
			url: "/dlive/delete-content",
			method: "POST",
			data: dataToServer,
			success: [function(dataFromServer) {
				
				isChange = dataFromServer;				
				loadContents();
				loadOwnContents();
				
			}],
			error: function(xhr, ajaxOptions, thrownError) {
				console.error("deleteContent");
				console.error("xhr: " + xhr);
				console.error("ajaxOptions: " + ajaxOptions);
				console.error("thrownError: " + thrownError);
			}
		});
		
		resetInputs();
	}
}

function isItGodDamnOldenIE() { return ieVersion && (ieVersion < 9); }

function validate(text, nullable) {

	

	if(!text || text.length < 40)
	{
		return "후기는 최소한 " + MINIMUM_LENGTH_FOR_TEXT + " 글자 이상 작성해 주세요.";
	}
	
	var consecutive = false;
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
