<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

				<div class="report_table">
					<table id="entranttable" class="tablesorter" style="width:100%">
				        <thead>
				            <tr>
				                <th>번호</th>				                
				                <th>분원</th>				                
				                <th>회원SID</th>
				                <th>회원ID</th>				                
				                <th>회원이름</th>
				                <th>회원구분</th>
				                <th>재원여부</th>				                
				                <th>Level</th>				                
				                <th>참여횟수</th>
				                <th>부모연락처</th>
				                <th>자녀정보</th>
				            </tr>
				        </thead>
				        <tbody id="entrant_tbody">
				        	<c:forEach var="list" items="${dliveList}" varStatus="i">
							<tr id="${list.RN}">
								<td>${list.RN }</td>								
								<td>${list.deptNm }</td>								
								<td>${list.userSeq }</td>
								<td>${list.userId }</td>								
								<td>${list.userNm }</td>
								<td>${list.gtUserType }</td>
								<td>${list.useYn }</td>
								<td>${list.level }</td>
								<td>${list.cnt }</td>
								<td>${list.parentMobile }</td>				
								<td>${list.chidrenInfo }</td>
							</tr>
						</c:forEach>
				        </tbody>
				    </table>
				    
				</div>
				