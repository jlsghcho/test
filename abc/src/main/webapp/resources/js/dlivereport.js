var currentPage = 1;
var IMAGE_SIZE_LIMIT = 10 * 1024 * 1024;
var NUMBER_OF_CONTENTS_PER_PAGE = 30;
var totalUploadCount = 0;



$(document).ready(function() {
	
	$("#eventListCombo").change(function() {changeEventList();});
	$("#deptListCombo").change(function() {changeEventList();});
	
	$("#eventListCombo").val(4);
	loadContents();
});

//지난 이벤트 차수를 변경하였을 경우  
function changeEventList()
{	
	totalUploadCount = 0;
	loadContents();
}

function changePage(index)
{
	currentPage = index;
	totalUploadCount = 0;
	loadContents();
}


function loadContents() {
	var sEventSeq = $("#eventListCombo").val();
	if(!sEventSeq )
		return;
	
	var sDeptSeq = $("#deptListCombo").val();
	if(!sDeptSeq )
		return;
	
	var dataToServer = {};	
	dataToServer["page"] = currentPage;	
	dataToServer["eventSeq"] = sEventSeq;
	dataToServer["deptSeq"] = sDeptSeq;
		
	$.ajax({
		url: "/report/dlive_loadreport",
		method: "POST",
		data: dataToServer,
		success: [function(dataFromServer) {
			try {
				
				totalUploadCount = dataFromServer.uploadCount;
				renderContents(dataFromServer.reports);
				
			} catch(error) {
				
				alert("에러가 발생하여 콘텐츠를 불러오지 못했습니다.loadContents");
				
			}
		}],
		error: function(xhr, ajaxOptions, thrownError) {
			console.error("loadreport");
			console.error("xhr: " + xhr);
			console.error("ajaxOptions: " + ajaxOptions);
			console.error("thrownError: " + thrownError);
		}
	});
}



function renderContents(contents) {

	for(var i = 1; i <= NUMBER_OF_CONTENTS_PER_PAGE; i++) {
		var selector = $("#report" + i);
		
		selector.find(".no").text("");
		selector.find(".dept").text("");
		selector.find(".user_seq").text("");
		selector.find(".user_id").text("");
		selector.find(".user_name").text("");
		selector.find(".type").text("");
		selector.find("img").prop("src", "//image.gojls.com/newjls/img/event/20170907_event/photo.gif");
		selector.find(".comment").text("");
		selector.find(".date").text("");
		
	}
	
	if(contents && contents.length > 0) {
	
		$.each(contents, function(index, report) {
			var ordinal = (index + 1);
			var selector = $("#report" + ordinal);
			selector.find(".no").text(report.sequence);
			selector.find(".dept").text(report.departmentName );
			selector.find(".user_seq").text(report.uploaderSequence);
			selector.find(".user_id").text(report.uploaderID);
			selector.find(".user_name").text(report.uploaderName);
			
			selector.find(".type").text(report.type);
			if(report.type == "사진인증")
			{
				selector.find("img").prop("src", report.imageUrl);
			}
			selector.find(".comment").text(report.text);
			selector.find(".date").text(report.date);
			
		});
	
		pagesettion();
		
	}	
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
		htmlstr += "<a href='javascript:changePage("+ (startIndex-5)+")'><span>이전</span></a>";
	}
	
	for(i = startIndex ;  i < endIndex+1 ; i++ )
	{	
		if(i == currentPage){
			htmlstr += " <a href='javascript:changePage(" + i +")'><span>"+i+"</span></a>";
		}
		else{
			htmlstr += " <a href='javascript:changePage(" + i +")'><span>"+i+"</span></a>";
		}
	}
	if(endIndex < lastPageIndex){
		htmlstr += "<a href='javascript:changePage("+ (startIndex+5)+")'><span >다음</span></a>"; 
	}	
	
	$("#pagemenu").html(htmlstr);
	
}


