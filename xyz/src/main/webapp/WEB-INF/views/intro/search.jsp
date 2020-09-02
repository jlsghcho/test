<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

	<script type="text/javascript">
	var areaboxs = [];
	var checkboxs = [];
	var checkem = [];
	//var branch_url = "<spring:eval expression="@globalContext['SITE_ROOT_BRANCH']" />";
	
	$(document).ready(function(){
		$.when(getDeptList()).done(eventCheckbox());
		
		$(".branch_s .list .sort input").change(function(){ eventCheckbox(); });	
		
		$(".branch_s .tag li").click(function(){
			$(".branch_s .tag li").removeClass("selected");
			$(this).addClass("selected");
			areaboxs.length = 0;
			var areabox = $(this).attr("code").split(",");
			for(var a =0; a < areabox.length; a++){
				areaboxs.push(areabox[a]);
			}
			getDeptListSort();
		});
	});
	
	function eventCheckbox(){
		checkboxs.length = 0;
		checkem.length = 0;
		for(var i = 0; i < 5; i++){ 
			if($(".branch_s .list .sort :checkbox").eq(i).is(":checked") == true){
				if($(".branch_s .list .sort :checkbox").eq(i).val().indexOf("DP2") > -1){
					checkboxs.push($(".branch_s .list .sort :checkbox").eq(i).val()); 
				}else{
					checkem.push($(".branch_s .list .sort :checkbox").eq(i).val()); 
				}
			}
		}
		if($.inArray("DP2001", checkboxs) > -1){ checkboxs.push("DP2009"); }
		if($.inArray("DP2002", checkboxs) > -1){ checkboxs.push("DP2003"); }
		getDeptListSort();
	}
	
	function getDeptListSort(){
		if(checkboxs.length > 0 || areaboxs.length > 0 || checkem.length > 0){
			for(var i = 0; i < $(".com_table dd").length; i++){
				var code_st = $(".com_table dd").eq(i).attr("code");
				
				var code_res = false;
				var area_res = false;
				var code_em = false;
				if(areaboxs.length > 0){ for(var z = 0; z < areaboxs.length; z++){ if(code_st.indexOf(areaboxs[z]) > -1){ area_res = true; break; } } }else{ area_res = true; } 
				if(checkboxs.length > 0){ for(var z = 0; z < checkboxs.length; z++){ if(code_st.indexOf(checkboxs[z]) > -1){ code_res = true; break; } } }else{ code_res = true; }
				if(checkem.length > 0){ for(var z = 0; z < checkem.length; z++){ if(code_st.indexOf(checkem[z]) > -1){ code_em = true; break; } } }else{ code_em = true; }
				
				console.log(i +"/"+ area_res +"/"+ code_res +"/"+ code_em +"...."+ code_st);
				
				if(area_res == true && code_res == true && code_em == true){
					$(".com_table dd").eq(i).show();
				}else{
					$(".com_table dd").eq(i).hide();
				}
			}
		}else{
			$(".com_table dd").show();
		}
	}
	
	function getDeptList(){
		var redirect_url = "";
		var obj_result = JSON.parse(common_ajax.inter("/service/arrdept", "json", false, "GET", "")); 
		if(obj_result.header.isSuccessful == true){
			var obj_data = JSON.parse(obj_result.data);
			var deptinfo = "<dt><div class='name'>분원명</div><div class='tel'>연락처</div><div class='area'>위치보기</div></dt>";
			for(var i=0; i < obj_data.length; i++){
				deptinfo += "<dd code='"+ obj_data[i]["arrDeptCourse"] +","+ obj_data[i]["arrDeptType"] +","+ obj_data[i]["arrDeptAreaCode1"] +","+ obj_data[i]["arrDeptAreaCode2"] +"'>"; 
				if(obj_data[i]["dltParentSeq"] == "130"){
					redirect_url = site_math_url + site_branch_path;
				}else{
					redirect_url = site_gojls_url + site_branch_path;
				}
				deptinfo += "<div class='name'><a href='"+ redirect_url +"?"+ obj_data[i]["dltDeptSeq"] +"'><b>"+ obj_data[i]["dltDeptNm"] +"</b></a><p>";
				
				var arrCourse = obj_data[i]["arrDeptCourse"].split(",");
				var arrType = obj_data[i]["arrDeptType"].split(",");
				var arrTel = obj_data[i]["arrDeptTel"].split(",");
				var arrDeptSeq = obj_data[i]["arrDeptSeq"].split(",");
				var arrDisplay = obj_data[i]["arrDisplayYn"].split(",");

				for(var t = 0; t < arrCourse.length; t++){ deptinfo += "#"+ common_code.get(arrCourse[t],"item1", site_gojls_url +"/cache/cacheCommon") +" "; }
				for(var t = 0; t < arrType.length; t++){ deptinfo += "#"+ common_code.get(arrType[t],"item1", site_gojls_url +"/cache/cacheCommon") +" "; }
				
				deptinfo += "</p></div><div class='tel'>";
				for(var t = 0; t < arrDisplay.length; t++){
					if(arrDisplay[t] == "1"){ 
						deptinfo += "<p>";
						if(obj_data[i]["arrDisplayYn"].match(/1/g).length == arrDisplay.length && arrDisplay.length > 1){ 
							deptinfo += "<span>["+ common_code.get(arrCourse[t],"item1", site_gojls_url +"/cache/cacheCommon").replace("관","") +"상담]</span> "; 
						}
						if(param_mobile_yn){
							deptinfo += "<a href='tel:"+ arrTel[t] +"'>"+ arrTel[t] +"</a></p>";
						}else{
							deptinfo += arrTel[t] +"</p>";
						}
					}
				}
				deptinfo += "</div><div class='area'>";
				for(var t = 0; t < arrDisplay.length; t++){
					if(arrDisplay[t] == "1"){ 
						deptinfo += "<button type='button' class='xsmall' onclick='location.href=\""+ redirect_url +"/intro/location?"+ arrDeptSeq[t] +"\";'><span>위치보기</span></button>";
					}
				}
				deptinfo += "</div></dd>";
			}
			$(".com_table").empty().append(deptinfo); 
		}else{
			common_alert.big('warning', result.header.resultMessage);
		}
	}
	</script>
	
	<div id="container">
		<jsp:include page="menu.jsp" flush="true" />
		<div class="contents">
			<div class="head">
				<div class="subimg"></div>
				<h3>학원소개</h3>
			</div>
			<div class="section">
				<div class="subtit left">
					<h4>분원찾기</h4>
					<div class="copy">
						<p>원하시는 지역을 선택해 주세요.</p>
					</div>
				</div>
				<div class="branch_s">
					<div class="map">
						<ol class="tag">
							<li class="all selected" style="cursor:pointer;" code=""><a>전국</a></li>
							<li class="seoul" style="cursor:pointer;" code="AR1001"><a>서울</a></li>
							<li class="gyeonggi" style="cursor:pointer;" code="AR2101"><a>경기</a></li>
							<li class="incheon" style="cursor:pointer;" code="AR2102"><a>인천</a></li>
							<li class="gangwon" style="cursor:pointer;" code="AR2103"><a>강원</a></li>
							<li class="gyeongnam" style="cursor:pointer;" code="AR2111,AR2114"><a>부산/경남</a></li>
							<li class="gyeongbuk" style="cursor:pointer;" code="AR2112,AR2110"><a>대구/경북</a></li>
							<li class="jeonla" style="cursor:pointer;" code="AR2107,AR2108,AR2109"><a>광주/전남/전북</a></li>
							<li class="chungcheong" style="cursor:pointer;" code="AR2106,AR2104,AR2105,AR2116"><a>대전/충남/충북/세종</a></li>
						</ol>
					</div>
					<div class="list">
						<div class="sort">
							<label><input type="checkbox" name="sort_branch" value="DP2001" /> <span>초등관</span></label>
							<label><input type="checkbox" name="sort_branch" value="DP2002" /> <span>중등관</span></label>
							<label><input type="checkbox" name="sort_branch" value="DP2004" /> <span>고등관</span></label>
							<label><input type="checkbox" name="sort_branch" value="DP3001" /> <span>영어</span></label>
							<label><input type="checkbox" name="sort_branch" value="DP3002" checked /> <span>수학</span></label>
						</div>
						<dl class="com_table"></dl>
					</div>
				</div>
			</div>
		</div>
	</div>
