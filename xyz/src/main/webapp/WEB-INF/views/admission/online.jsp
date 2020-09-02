<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
	var areaboxs = [];
	var cookieUserType = "${cookieUserType}";
	//var branch_url = "<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />";
	//var academy_url = "<spring:eval expression="@globalContext['SITE_ROOT_ACADEMY']" />";
	var cookieUserSeq = "${cookieUserSeq}";
	var paylinkurl = (cookieUserType == "US6002") ? "location.href='"+ site_branch_path +"/myjls/payment'" : "";

	var par_reserv_tf = "";
	var par_reservation_seq = "";
	var par_user_seq = "";
	var descResult = "";
	var par_reg_date = "";
	var sel_date_id = "";
	
	$(document).ready(function() {
		if("${cookieYN}" == "false"){ common_alert.comfirm_move('Notice', "로그인 후 이용하실 수 있습니다.", 'warning', "/login?preURL=${recentUrl}" , "back"); }
		
		select_user_box(); // 학생박스를 채운후에 첫번째 학생을 가져다가 피드백 함. 

		/* 펼쳐보기 버튼 */
		$('#reserve_btn').on('click',function() {
			if($(this).children().hasClass('expand')){
				$(this).children().text('예약일정 보기').removeClass('expand');
			}else{
				$(this).children().text('예약일정 닫기').addClass('expand');
			}
			$('.branch_r').slideToggle();
		});
		
		$(".map .tag li").click(function(){
			$(".map .tag li").removeClass("selected");
			$(this).addClass("selected");
			areaboxs.length = 0;
			var areabox = $(this).attr("code").split(",");
			for(var a =0; a < areabox.length; a++){
				areaboxs.push(areabox[a]);
			}
			getDeptListSort();
		});
		
		$(".section .select_user").change(function(){ select_user_event(); });
		
		$("#sort_reserve").click(function(){ getUserReservationSort($("#sort_reserve").is(":checked")); });
	});
	
	/* 자녀정보를 branch 에서 가지고 와서 목록 나열 */
	function select_user_box(){
		$(".select_user").empty();
		var select_list = "";
		var result = JSON.parse(common_ajax.inter("/service/arrUser", "json", false, "GET", ""));
		if(result.header.isSuccessful == true){
			var obj_data = JSON.parse(result.data);
			for(var i=0; i < obj_data.length; i++){
				select_list += "<option value='";
				select_list += obj_data[i]["userSeq"] +"|"+ obj_data[i]["gtUserClsCnt"] +"|"+ obj_data[i]["arrUserClsCourse"] +"|"+ obj_data[i]["gtGrade"];
				select_list += "'>";
				select_list += obj_data[i]["userNm"] ;
				select_list += "</option>";
			}
		}else{
			select_list = "<option value=''>"+ result.header.resultMessage.split(":")[1] +"</option>";
		}
		$(".select_user").append(select_list);
		$(".select_user option:eq(0)").attr("selected","selected");
		
		select_user_event();
	}
	
	/* 자녁목록에 선택이 되었다면 그 학생의 정보를 가지고예약 목록 뿌려줌 */
	function select_user_event(){
		var sel_user_arr = $(".select_user option:selected").val();
		var sel_user_seq = sel_user_arr.split("|")[0];
		if( sel_user_arr != ""){
			getDeptList(sel_user_arr);
			areaboxs.push("AR1001");
			getDeptListSort();
			
			getUserReservation(sel_user_seq);
			getUserReservationSort($("#sort_reserve").is(":checked"));
		}else{ //만약 데이터가 없다면 아래 노출하지 말아달라. 
			console.log(sel_user_seq);
		}
	}
	
	/* 
	학생이 예약한 내역 View 전체 
	정책 : [납부하기] 버튼 금액이 0 이상이고 미납일경우 부분납 포함 / [예약취소] 현재꺼이면서 미납인애들 (웹에서는 환불기능이 없음)
	*/
	function getUserReservation(param_user_seq){
		$(".section .reserve").empty();
		
		if(param_user_seq != ""){
			var obj_result = JSON.parse(common_ajax.inter("/service/reservation/"+ param_user_seq, "json", false, "GET", ""));
			if(obj_result.header.isSuccessful == true){
				var obj_data = JSON.parse(obj_result.data);
				var input_data = "";
				for(var i=0; i < obj_data.length; i++){
					var old_class = (obj_data[i]["oldYn"] == 'Y') ? 'past' : 'active';
					
					input_data += "<div class='item "+ old_class +"'><div class='tit'><div class='tag'><span class='branch'>"+ obj_data[i]["deptNm"] +"</span></div>";
					input_data += "<h4>"+ obj_data[i]["title"] +"</h4>";
					if(obj_data[i]["oldYn"] == "N"){
						if(obj_data[i]["amount"] > 0){
							if(obj_data[i]["gtChargeChk"] == "PA2001"){
								input_data += "<button type='button' onclick='userReservationAccept(false,"+ obj_data[i]["reservationSeq"] +",\""+ param_user_seq  +"\",\"\")'><span>예약취소</span></button>";
							}else{
								input_data += "<button type='button' onclick='common_alert.big(\"warning\",\"납부하신 전형료가 있어 직접 취소가 불가능 합니다. 분원에 문의 바랍니다.\");'><span>예약취소</span></button>";
							}
						}else{
							input_data += "<button type='button' onclick='userReservationAccept(false,"+ obj_data[i]["reservationSeq"] +",\""+ param_user_seq  +"\",\"\")'><span>예약취소</span></button>";
						}
					}
					input_data += "</div>";
					input_data += "<ul><li><b>일시</b><span>"+ common_date.convertType(obj_data[i]["startDt"],4) +" "+ common_time.time_set(obj_data[i]["startTime"]) + "~" + common_time.time_set(obj_data[i]["endTime"]) +"</span></li>";
					input_data += "<li><b>장소</b><span>"+ obj_data[i]["position"] +"</span></li>";
					input_data += "<li><b>전형료</b><strong>"+ common_num.moneyStr(obj_data[i]["amount"]) +"원</strong> ";
					if(obj_data[i]["amount"] > 0){
						if(obj_data[i]["gtChargeChk"] == "PA2001" || obj_data[i]["gtChargeChk"] == "PA2002"){
							if(paylinkurl == ""){
								input_data += "<button type='button' class='red xsmall' onclick=\"common_alert.big('warning','결제는 학부모만 가능합니다.');\"><span>납부하기</span></button> <span class='period'>~"+ common_date.dateToDel(obj_data[i]["startDt"],1) +"까지</span>";
							}else{
								input_data += "<button type='button' class='red xsmall' onclick=\""+ paylinkurl +"\"><span>납부하기</span></button> <span class='period'>~"+ common_date.dateToDel(obj_data[i]["startDt"],1) +"까지</span>";
							}
						}else{
							input_data += "<span class='paid'>납부완료</span>";
						}
					}
					input_data += "</li></ul></div>";
				}
				$(".section .reserve").append(input_data +"<div class='step-sizer'></div><div class='gutter-sizer'></div>");
			}
		}
	}

	/* 목록 정렬 */
	function getUserReservationSort(param_old_yn){
		$("#nodata").hide();
		$(".reserve div").removeClass("hide");
		var param_cnt = 0;
		for(var i = 0; i < $(".reserve div").length; i++){
			if(param_old_yn == false){ //현재내역만 
				if($(".reserve div").eq(i).attr("class").indexOf("past") > -1){
					$(".reserve div").eq(i).addClass("hide");
				}else if($(".reserve div").eq(i).attr("class").indexOf("active") > -1){
					param_cnt++;
				}
			}else{ //전체 내역 
				if($(".reserve div").eq(i).attr("class").indexOf("past") > -1 || $(".reserve div").eq(i).attr("class").indexOf("active") > -1){
					param_cnt++;
				}
			}
		}
		if(param_cnt == 0){ $("#nodata").show(); }
	}
	
	/* 분원목록에서 선택된 값에 맞게 소팅 */
	function getDeptListSort(){
		if(areaboxs.length > 0){
			var intRevCnt = 0;
			for(var i = 0; i < $(".com_table dd").length; i++){
				var code_st = $(".com_table dd").eq(i).attr("code");
				
				var area_res = false;
				if(areaboxs.length > 0){ for(var z = 0; z < areaboxs.length; z++){ if(code_st.indexOf(areaboxs[z]) > -1){ area_res = true; break; } } }else{ area_res = true; } 
				
				if(area_res == true){
					$(".com_table dd").eq(i).show();
					intRevCnt++;
				}else{
					$(".com_table dd").eq(i).hide();
				}
			}
			$(".list .result b").text(intRevCnt);
		}else{
			$(".com_table dd").show();
		}
	}
	
	/* 분원목록 전체 가지고 오기 */
	function getDeptList(param_user_arr){
		var obj_result = JSON.parse(common_ajax.inter("/service/arrdept", "json", false, "GET", "")); 
		if(obj_result.header.isSuccessful == true){
			var obj_data = JSON.parse(obj_result.data);
			var intRevCnt = 0;
			var deptinfo = "<dt><div class='name'>분원명/예약정보</div><div class='tel'>연락처</div><div class='area'>위치보기</div></dt>";
			var redirect_url = "";
			for(var i=0; i < obj_data.length; i++){
				if(obj_data[i]["arrReservation"] != "0,0" && obj_data[i]["arrReservation"] != "0"){
					deptinfo += "<dd code='"+ obj_data[i]["arrDeptCourse"] +","+ obj_data[i]["arrDeptType"] +","+ obj_data[i]["arrDeptAreaCode1"] +","+ obj_data[i]["arrDeptAreaCode2"] +"'>"; 
					deptinfo += "<div class='name'><b>"+ obj_data[i]["dltDeptNm"] +"</b><ul class='info'>";
					
					if(obj_data[i]["dltParentSeq"] == "130"){
						redirect_url = site_math_url + site_branch_path;
					}else{
						redirect_url = site_gojls_url + site_branch_path;
					}

					var arrDeptSeq = obj_data[i]["arrDeptSeq"].split(",");
					var arrDeptNm = obj_data[i]["arrDeptNm"].split(",");
					var arrCourse = obj_data[i]["arrDeptCourse"].split(",");
					var arrRevCnt = obj_data[i]["arrReservation"].split(",");
					var arrTel = obj_data[i]["arrDeptTel"].split(",");
					var arrDisplay = obj_data[i]["arrDisplayYn"].split(",");
					
					for(var t = 0; t < arrCourse.length; t++){ 
						if(arrRevCnt[t] != "0"){
							var liclass = common_code.get(arrCourse[t],"long", site_gojls_url +"/cache/cacheCommon").toLowerCase();
							liclass = (liclass == "(m)chess/ace") ? "mathself" : liclass;
							liclass = (liclass == "초등수학") ? "mathink" : liclass;
							if(liclass != "(m)h-group"){
								deptinfo += "<li class='"+ liclass +"'><button type='button' class='xsmall' onclick='reserv_pop("+ arrDeptSeq[t] +",\""+ arrDeptNm[t] +"\",\""+ param_user_arr +"\");'><span></span></button></li>";
							}
							// <span>예약정보 <b>"+ arrRevCnt[t] +"</b>건</span>
						}
					}
					deptinfo += "</ul></div><div class='tel'>";
					for(var t = 0; t < arrDisplay.length; t++){
						if(arrDisplay[t] == "1"){ 
							deptinfo += "<p>";
							if(obj_data[i]["arrDisplayYn"].match(/1/g).length == arrDisplay.length && arrDisplay.length > 1){ 
								deptinfo += "<span>["+ common_code.get(arrCourse[t],"item1", site_gojls_url +"/cache/cacheCommon").replace("관","") +"상담]</span> "; 
							}
							deptinfo += arrTel[t] +"</p>";
						}
					}
					deptinfo += "</div><div class='area'>";
					for(var t = 0; t < arrDisplay.length; t++){
						if(arrDisplay[t] == "1"){ 
							deptinfo += "<button type='button' class='xsmall' onclick='location.href=\""+ redirect_url +"/intro/location?"+ arrDeptSeq[t] +"\";'><span>위치보기</span></button>";
						}
					}
					deptinfo += "</div></dd>";
					intRevCnt++;
				}
			}
			$(".com_table").empty().append(deptinfo);
			$(".list .result b").text(intRevCnt);
		}else{
			common_alert.big('warning', obj_result.header.resultMessage);
		}
	}

	/* 예약팝업 */
	function reserv_pop(param_dept_seq, param_dept_nm, param_user_arr){

		var param_user_info = param_user_arr.split("|");
		var compare_rv_type = "";
		var compare_code = []; //학생의 비교 코드 
		if(param_user_info[1] == "0"){ // 비재원생 
			compare_rv_type = "RV3002";
			compare_code.push("RV3002:"+ param_user_info[3]);
		}else{ // 재원생
			compare_rv_type = "RV3001";
			var course_arr = param_user_info[2].split(",");
			for(var i = 0; i < course_arr.length; i++){ compare_code.push("RV3001:"+ course_arr[i]); compare_code.push("RV3001:"+ param_user_info[3] +":"+ course_arr[i]); }
			compare_code.push("RV3001:"+ param_user_info[3]);
		}
		console.log(compare_code +"/"+ compare_rv_type);
		
		var input_pop = "<div class='header'><h1>"+ param_dept_nm +" 예약정보</h1><div class='close'>Close</div></div><div class='content'><div class='reserve'>";
		var obj_result = JSON.parse(common_ajax.inter("/service/reservation/"+ param_user_info[0] +"/"+ param_dept_seq, "json", false, "GET", "")); 
		if(obj_result.header.isSuccessful == true){
			var total_view_cnt = 0; //보여지는 전체 카운트 없다면 nodata 뿌려주면됨 
			var obj_data = JSON.parse(obj_result.data);
			for(var i=0; i < obj_data.length; i++){
				var item_class = (obj_data[i]["userReservationSeq"] != 0) ? 'active' : 'past';
				
				/* 레벨테스트만 대상학년을 보여주고 무조건 비재원생이므로 Grade만 - 설명회 나머진 대상검색후 ViewYN  [정책 ] */
				var param_view_yn = false;
				var arrStudent = "";
				/*if(obj_data[i]["gtReservationType"] == "RV1001"){ //레벨테스트 일경우 재원생은 안보여줌
					if(compare_rv_type == "RV3002"){ 
						for(var a=0; a < compare_code.length; a++){ 
							console.log(">>"+ obj_data[i]["arrCompare"] +">>"+ compare_code[a]);
						
							if(obj_data[i]["arrCompare"].indexOf(compare_code[a]) > -1){ 
								param_view_yn = true; 
								break;  
							}
						}
						var param_grade = obj_data[i]["arrCompare"].split(",");
						for(var z=0; z < param_grade.length; z++){
							var param_grade_sub = param_grade[z].split(":");
							arrStudent += (arrStudent == "")? "" : ", "; 
							arrStudent += common_code.get(param_grade_sub[1],"long","/cache/cacheCommon");
						}
					}
				}else{
					for(var a=0; a < compare_code.length; a++){ 
						if(obj_data[i]["arrCompare"].indexOf(compare_code[a]) > -1){ 
							param_view_yn = true; 
						} 
					}
				}*/
				param_view_yn = true; 
				console.log(param_view_yn +" >>");

				if(param_view_yn){
					input_pop += "<div class='item "+ item_class +"'><div class='tit'><div class='tag'>";
					if(obj_data[i]["userReservationSeq"] != 0){ input_pop += " <span class='user'>나의 예약</span>"; }
					//input_pop += " <span></span>";
					input_pop += "</div><h4>"+ obj_data[i]["title"] +"</h4>";
					input_pop += "</div><ul><li><b>일시</b><span>"+ common_date.convertType(obj_data[i]["startDt"],4) +"~"+ common_date.convertType(obj_data[i]["endDt"],4) +" "+ common_time.time_set(obj_data[i]["startTime"]) + "~" + common_time.time_set(obj_data[i]["endTime"]) +"</span></li>";
					input_pop += "<li><b>장소</b><span>"+ obj_data[i]["position"] +"</span></li>";
					if(obj_data[i]["arrCompare"] != ""){
						input_pop += "<li><b>대상</b>"+ obj_data[i]["arrCompare"] +"</li>";					
					}else{
						input_pop += "<li><b>대상</b>제한없음</li>";						
					}
					input_pop += "<li><b>전형료</b><strong>"+ common_num.moneyStr(obj_data[i]["amount"]) +"원</strong> ";
					if(obj_data[i]["userReservationSeq"] != 0){
						if(obj_data[i]["amount"] > 0){
							if(obj_data[i]["gtChargeChk"] == "PA2001" || obj_data[i]["gtChargeChk"] == "PA2002"){
								var seldate = obj_data[i]["userReserveDt"].replace(/\./g,'');
								input_pop += "<button type='button' class='red xsmall' onclick=\""+ paylinkurl +"\"><span>납부하기</span></button> <span class='period'>~"+ common_date.dateToDel(seldate,1) +"까지</span>";
							}else{
								input_pop += "<span class='paid'>납부완료</span>";
							}
						}
					}
					input_pop += "</li>";
					if(obj_data[i]["note"] != ""){
						input_pop += "<li><b>주의사항</b>"+ obj_data[i]["note"] +"</li>";						
					}
					input_pop += "</ul><div class='tip'><ul>";
					input_pop += "<li><b>예약기간</b>"+ common_date.convertType(obj_data[i]["onlineStartDt"],4) +"~"+ common_date.convertType(obj_data[i]["onlineEndDt"],4) +"</li>";
					if(obj_data[i]["userReservationSeq"] != 0){
						input_pop += "<li class='set'><label class='period'><input type='text' class='daterange' value='"+obj_data[i]["userReserveDt"]+"' readonly disabled /><span></span></label>";
						if(obj_data[i]["amount"] > 0){					
							if(obj_data[i]["gtChargeChk"] == "PA2001"){
								input_pop += "<button type='button' class='yellow' onclick='userReservationAccept(false,"+ obj_data[i]["reservationSeq"] +",\""+ param_user_info[0]  +"\",\"\")'><span>예약취소</span></button>";
							}else{
								input_pop += "<button type='button' class='yellow' onclick='common_alert.big(\"warning\",\"납부하신 전형료가 있어 직접 취소가 불가능 합니다. 분원에 문의 바랍니다.\");'><span>예약취소</span></button>";
							}
						}else{
							input_pop += "<button type='button' class='yellow' onclick='userReservationAccept(false,"+ obj_data[i]["reservationSeq"] +",\""+ param_user_info[0]  +"\",\"\")'><span>예약취소</span></button>";
						}
					}else{
						input_pop += "<li class='set'><label class='period'><input id='dr_"+i+"' type='text' class='daterange' value='"+obj_data[i]["userReserveDt"]+"' readonly onchange=\"chkRegTime('dr_"+i+"');\" onclick=\"sel_date_id='"+i+"';\"/><span></span></label>";
						//input_pop += "<li class='set'><label class='period'><input id='dr_"+i+"' type='text' class='daterange' value='2019.10.08, 13:00' readonly/><span></span></label>";
						input_pop += "<button type='button' class='blue' onclick='userReservationAccept(true,"+ obj_data[i]["reservationSeq"] +",\""+ param_user_info[0]  +"\",\""+ i  +"\")'><span>예약하기</span></button>";
					}
					input_pop += "</li>";					
					input_pop += "</ul></div>";					
					input_pop += "<script>";
					input_pop += "$('.tip #dr_"+i+"').daterangepicker(";
					input_pop += "{autoUpdateInput: false, ";
					input_pop += "singleDatePicker: true, ";
					input_pop += "timePicker: true, ";
					input_pop += "timePicker24Hour: true, ";
					input_pop += "timePickerIncrement: 10, ";
					input_pop += "minDate:'"+common_date.convertType(obj_data[i]["startDt"],1)+", "+common_time.time_set(obj_data[i]["startTime"])+"', ";
					input_pop += "maxDate:'"+common_date.convertType(obj_data[i]["endDt"],1)+", "+common_time.time_set(obj_data[i]["endTime"])+"', ";
					input_pop += "locale: {format: 'YYYY.MM.DD, HH:mm'}}, function(start, end, label) {});";
					input_pop += "<\/script>";
					input_pop += "<input type='hidden' id='time_st_"+i+"' value='"+obj_data[i]["startTime"]+"'><input type='hidden' id='time_et_"+i+"' value='"+obj_data[i]["endTime"]+"'>";
					input_pop += "</div>";				
					//console.log(obj_data[i]["startDt"]+"|"+obj_data[i]["endDt"]);
					total_view_cnt++;
				}
			}
		}
		if(total_view_cnt == 0){ input_pop += "<div id='nodata' class='nodata'>해당 학생에 맞는 예약내역이 없습니다.</div>";	} //한개도 없을시에 노데이터 뿌려줌 
		
		input_pop += "</div></div>";
		$("#reserve").empty().append(input_pop);
		
		$('input.daterange').on('apply.daterangepicker', function(ev, picker) {	
			$(this).val(picker.startDate.format('YYYY.MM.DD, HH:mm'));
			chkRegTime($(this).val());
			console.log("check::"+$(this).val());
		});

		$('input.daterange').on('cancel.daterangepicker', function(ev, picker) {
			//$(this).val('');
		});
		
		$('input.daterange').on('showCalendar.daterangepicker', function(ev, picker) {
			if (picker.element.offset().top - $(window).scrollTop() + picker.container.outerHeight() > $(window).height()) {
				return picker.drops = 'up';
			} else {
				return picker.drops = 'down';
			}
		});
		
		showPopup();
	}

	function chkRegTime(v){
		var sel_start_time = $("#time_st_"+sel_date_id).val();
		var sel_end_time = $("#time_et_"+sel_date_id).val();
		var sel_hour, sel_minute, sel_time;
		sel_time = v.split(", ")[1].replace(":","");
		
		if(sel_time < sel_start_time||sel_time > sel_end_time){
			common_alert.big("warning",common_time.time_set(sel_start_time)+ "~" + common_time.time_set(sel_end_time)+" 범위내의 예약 시간을 선택해주세요."); 
			$("#dr_"+sel_date_id).val("");
		}
		console.log("check date id::"+sel_date_id+"|"+sel_start_time+"|"+sel_end_time+"|"+sel_time);
		
	}
	
	function showPopup(){ // 분원의 상세예약 팝업 
		$("#reserve, .black_bg").fadeIn();
		$("body").addClass("noscroll");
		//$('body .pop .content>div').slimScroll({ height: '100%', size: '5px',	allowPageScroll: false, disableFadeOut: true });
	}
	
	$(document).on('click','.close, button.cancel',function() { /* close popup layer */
		$('.black_bg, .pop').fadeOut( function() {
			$('body').removeClass('noscroll');
		});
	});

	/* 예약하기 및 예약 취소하기 */
	function userReservationAccept(param_reserv_tf, param_reservation_seq, param_user_seq, sel_id){
		if(param_reserv_tf){
			var sel_date = $("#dr_"+sel_id).val().replace(", ", ",").replace(/\./g,'').replace(/\:/g,'');
		    console.log("sel_date::"+sel_date);
		    if(sel_date == ""){
		    	par_reg_date = "0";
		    }else{
				par_reg_date = sel_date;		    	
		    }
		}else{
	    	par_reg_date = "0";			
		}
		
		if(param_reserv_tf && par_reg_date == "0" ){
			common_alert.big('warning', "예약일과 시간을 설정해주세요.");	
		}else{			
			par_reserv_tf = param_reserv_tf;
			par_reservation_seq = param_reservation_seq;
			par_user_seq = param_user_seq;
			var desc = (param_reserv_tf)? "예약을 하시겠습니까?" : "예약을 취소하시겠습니까?";
			descResult = (param_reserv_tf)? "예약이 완료되었습니다." : "예약이 취소되었습니다.";
			
			common_alert.comfirm_func('온라인 예약', desc, 'warning', userReservationAcceptTwo, "");	
		}
		
	}
	
	function userReservationAcceptTwo(){
		var obj_result = JSON.parse(common_ajax.inter("/service/reservation/"+ par_reserv_tf +"/"+ par_reg_date +"/"+ par_reservation_seq +"/"+ par_user_seq, "json", false, "GET", "")); 
		if(obj_result.header.isSuccessful == true){
			common_alert.big_func("success", descResult, userReservationAcceptResult);
		}else{
			common_alert.big('warning', "오류메세지를 확인해 주세요.["+ obj_result.header.resultMessage +"]");
		}
	}
		
	function userReservationAcceptResult(){
		$("#reserve .close").trigger("click");
		getUserReservation(par_user_seq);
		getUserReservationSort($("#sort_reserve").is(":checked"));
	}
</script>
	<div id="container">
		<jsp:include page="menu.jsp" flush="true" />
		<div class="contents">
			<div class="head">
				<div class="subimg"></div>
				<h3>입학안내</h3>
			</div>
			<div class="section">
				<div class="subtit wide">
					<h4><b>온라인 예약안내</b></h4>
					<div class="copy">
						<h5 class="small">정상수학학원에서 진행하는 입학시험, 설명회, 기타 행사 등을 예약하실 수 있습니다.</h5>
						<dl class="wrap">
							<dd>전형료가 있는 경우, 납부를 완료하셔야 예약이 최종 완료됩니다.</dd>
							<dd>전형료를 이미 납부하신 상태에서 ‘예약취소’를 원하실 경우 예약분원으로 문의해주세요.</dd>
							<dd>현재 재원중이거나 입학시험을 본 후 3개월이 지나지 않은 경우 입학 예약이 불가합니다.</dd>
						</dl>
					</div>
				</div>
			</div>
			<div class="section">
				<div class="subtit left">
					<h5>나의 예약정보</h5>
					<select class="select_user"></select>
					<button type="button" id="reserve_btn" class="blue"><span class="expand">예약일정 닫기</span></button>
				</div>
				<div class="branch_r expand">
					<div class="map">
						<ol class="tag">
							<li class="seoul selected" style="cursor:pointer;" code="AR1001"><a>서울</a></li>
							<li class="gyeonggi" style="cursor:pointer;" code="AR2101"><a>경기</a></li>
							<li class="incheon" style="cursor:pointer;" code="AR2102"><a>인천</a></li>
							<li class="gangwon" style="cursor:pointer;" code="AR2103"><a>강원</a></li>
							<li class="gyeongnam" style="cursor:pointer;" code="AR2114"><a>경남</a></li>
							<li class="busan" style="cursor:pointer;" code="AR2111"><a>부산</a></li>
							<li class="gyeongbuk" style="cursor:pointer;" code="AR2110"><a>경북</a></li>
							<li class="daegu" style="cursor:pointer;" code="AR2112"><a>대구</a></li>
							<li class="jeonnam" style="cursor:pointer;" code="AR2108"><a>전남</a></li>
							<li class="jeonbuk" style="cursor:pointer;" code="AR2109"><a>전북</a></li>
							<li class="gwangju" style="cursor:pointer;" code="AR2107"><a>광주</a></li>
							<li class="daejeon" style="cursor:pointer;" code="AR2106"><a>대전</a></li>
							<li class="chungnam" style="cursor:pointer;" code="AR2104"><a>충남</a></li>
							<li class="chungbuk" style="cursor:pointer;" code="AR2105"><a>충북</a></li>
							<li class="sejong" style="cursor:pointer;" code="AR2116"><a>세종</a></li>
						</ol>
					</div>
					<div class="list">
						<div class="result"><p>총 <b></b>건의 예약정보가 있습니다.</p></div>
						<dl class="com_table"></dl>
					</div>
				</div>
			</div>
			<div class="section">
				<div class="subtit left">
					<h5>나의 예약 내역</h5>
					<div class="sort"><label><input type="checkbox" id="sort_reserve"> <span>지난예약포함</span></label></div>
				</div>
				<div id="nodata" class="nodata">예약 내역이 없습니다.</div>
				<div class="reserve"></div>
			</div>
		</div>
	</div>

