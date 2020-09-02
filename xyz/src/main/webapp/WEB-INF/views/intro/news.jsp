<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
	
	<script type="text/javascript">
	var $grid;
	$(document).ready(function(){
		var obj_result = JSON.parse(common_ajax.inter("/service/arrtag", "json", false, "GET", ""));
		$("#container .section .tag").empty();
		if(obj_result.header.isSuccessful == true){
			var obj_data = JSON.parse(obj_result.data);
			var input_data = "<li id='' class='selected'><a href='#'>#전체</a></li> ";
			var option_sel = "";
			for(var i=0; i < obj_data.length; i++){
				input_data += "<li id='"+ obj_data[i]["tagCode"]+"'><a href='#'>#"+ obj_data[i]["tagNm"] +"</a></li> ";
			}
			$("#container .section .tag").append(input_data);
		}else{
			$("#container .section .tag").append("<li>태그정보 오류발생</li>");
		}
		
		
		getCacheNotice('');

		$('.tag li').click(function(event){
			var index = $(".tag li").index(this);
			$(".tag li").removeClass();
			$(this).addClass('selected');
			getCacheNotice($(this).attr('id'));
		});
	});
	
	var getCacheNotice = function (tagcode){
		$('.grid').empty();
		var input_div = "";
		var $items = "";
		var param_dept_seq = 130; // JLS소식 
		var item_class = "";
		$.ajax({
			type : "GET",
			dataType : "json",
			url : site_gojls_url +"/cache/cacheNotice",
			async: false,
			success : function(result){
				if(result.header.isSuccessful == true){
					var obj = eval(result.data);
					for(var i=0; i < obj.length; i++){
						if(obj[i]["deptSeq"] == param_dept_seq || obj[i]["deptSeq"] == 1){
							item_class = (obj[i]["imageUrl"] == "") ? "nothumb" : "";
							if(tagcode == ''){
								input_div += "<div class='grid-item "+ item_class +"'><a href='"+ root_url +"/intro/newsview?param_seq="+ obj[i]["noticeNo"]  +"'>";
								if(obj[i]["imageUrl"] != ''){
									input_div += "<img src='"+ obj[i]["imageUrl"] +"' />"; 
								}
								input_div += "<h3>"+ obj[i]["title"] +"</h3><p>"+ obj[i]["summary"].replace(/\n/gi, "<br>") +"</p><div class='info'><span class='category'>";
								if(obj[i]["deptSeq"] == "1" || obj[i]["deptSeq"] == param_dept_seq){ input_div += "JLS 소식"; }else{ input_div += "분원 소식"; }
								input_div += "</span><span class='date'>"+ obj[i]["registerDate"] +"</span></div></a></div>";
							}else{
								if(obj[i]["tag"].indexOf(tagcode) > -1 ){
									input_div += "<div class='grid-item "+ item_class +"'><a href='"+ root_url +"/intro/newsview?param_seq="+ obj[i]["noticeNo"]  +"'>"; 
									if(obj[i]["imageUrl"] != ''){ input_div += "<img src='"+ obj[i]["imageUrl"] +"'  />"; }
									input_div += "<h3>"+ obj[i]["title"] +"</h3><p>"+ obj[i]["summary"].replace(/\n/gi, "<br>") +"</p><div class='info'><span class='category'>";
									if(obj[i]["deptSeq"] == "1" || obj[i]["deptSeq"] == param_dept_seq){ input_div += "JLS 소식"; }else{ input_div += "분원 소식"; }
									input_div += "</span><span class='date'>"+ obj[i]["registerDate"] +"</span></div></a></div>";
								}
							}	
						}
					}
				}else{
					common_alert.big('error', result.header.resultMessage);
				}
				$(".grid").append(input_div);
			},
			error : function(xhr, ajaxOpts, thrownErr){
				common_alert.big('error', xhr+"/"+ajaxOpts+"/"+thrownErr);
			}
		});
	}
	</script>
	<div id="container">
		<jsp:include page="menu.jsp" flush="true" />
		<div class="contents">
			<div class="head">
				<div class="subimg"></div>
				<h3>학원소개</h3>
			</div>
			<div class="section tag">
				<div class="subtit left">
					<h4><b>JLS 소식</b></h4>
				</div>
				<ol class="tag"></ol>
			</div>
			<div class="section">
				<div class="news_list">
					<div class="grid"></div>
				</div>
			</div>
			
		</div>
	</div>
