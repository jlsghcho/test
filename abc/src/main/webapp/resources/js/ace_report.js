var table = $('#table').DataTable();


function selfevaltableheader() {
	
	return "<thead><tr><th>순번</th>" +
		"<th>분원이름</th>" +
		"<th>타입</th>" +
		"<th>학생시퀀스</th>" +
		"<th>문제번호</th>" +
		"<th>학년 학교</th>" +
		"<th>회원ID</th>" +
		"<th>이미지1</th>" +
		"<th>이미지2</th>" +
		"<th>Comment</th>" +
		"<th>제출일</th></tr></thead>";
	
}


function updateFields() {
	
	var selectedIndex;
	var selectvar;
	var selYear;
	var selOrdinal;

	if($("#departmentName").length == 0) {
		
		selectvar = "10000585";
		
	} else {
		
		selectvar = $("#departmentName").val();
		if(selectvar == undefined) {
			selectvar = "10000585";
		}
	}

	var url;
	if(selOrdinal > 0) {
		
		url = "/ace/acereport/" + selectvar ;
		
	}
	

	table.destroy();
	$("#table").empty();

	document.getElementById("table").innerHTML = selfevaltableheader();

	table = $('#table').DataTable({
		dom: 'Bfrtip',
		buttons: [{ extend: 'excel', text: '엑셀로 저장하기' }],
		bPaginate: false,
		bAutoWidth: false,
		bScrollCollapse: true,
		bLengthChange: false,
		fnInitComplete: function() { this.css("visibility", "visible"); },
		fnRowCallback: function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
			$(nRow).addClass("nonHeader");
			$(nRow).css("height", "35px");
		},
		ajax: { url: url, dataSrc: "" },
		columns: [{ data: "no", defaultContent: "", bSortable: false },
			{ data: "departmentNM", defaultContent: "" },
			{ data: "userSequence", defaultContent: "" },
			{ data: "userID", defaultContent: "" },
			{ data: "questionType", defaultContent: "" },
			{ data: "questionNumber", defaultContent: "" },
			{ data: "schoolName", defaultContent: "" },
			{ data: "grade", defaultContent: "" },
			{ data: "imagePath1", defaultContent: "" },
			{ data: "imagePath2", defaultContent: "" },
			{ data: "comment", defaultContent: "" },
			{ data: "regDate", defaultContent: "" }
		]
	});
	
}
