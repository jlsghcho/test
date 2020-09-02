<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>


				<div id="report_table" class="report_table">
					<table id="dlivetable" class="tablesorter" style="width:100%">
				        <thead>
				            <tr>
				                <th>번호</th>
				                <th>분원타입</th>
				                <th>분원</th>
				                <th>학생SID</th>
				                <th>학생ID</th>
				                <th>학생이름</th>
				                <th>반이름 / 선생님이름</th>				                
				                <th>인증타입</th>
				                <th style="display:none;">이미지URL</th>
				                <th>인증이미지</th>
				                <th>인증글</th>
				                <th>제출일</th>
				                <th>업로드차수</th>
				            </tr>
				        </thead>
				        <tbody id="dlive_tbody">
				        	<c:forEach var="list" items="${dliveList}" varStatus="i">
							<tr id="${list.RN}">
								<td>${list.RN }</td>
								<td>${list.deptType }</td>
								<td>${list.deptNm }</td>
								<td>${list.userSeq }</td>
								<td>${list.userId }</td>
								<td>${list.userNm }</td>
								<td>${list.clsTman }</td>		
								<td>${list.dliveType }</td>
								<td style="display:none;">
									<c:choose>
									<c:when test="${list.dliveImgPath != null}"><spring:eval expression="@globalContext['ROOT_DIRECTORY_TO_DOWNLOAD']" />${list.dliveImgPath}}</c:when>
									<c:otherwise>-</c:otherwise>
									</c:choose>
								</td>
								<td>
								<c:choose>
									<c:when test="${list.dliveImgPath != null}">
										<img src="<spring:eval expression="@globalContext['ROOT_DIRECTORY_TO_DOWNLOAD']" />${list.dliveImgPath}" width="120px" height="120px"/>
																
									</c:when>
									<c:otherwise>-</c:otherwise>
								</c:choose>
								</td>
								<td>${list.dliveText}</td>
								<td>${list.uploadeDate}</td>
								<td>${list.uploadCount}</td>
							</tr>
						</c:forEach>
				        </tbody>
				    </table>
				    
				</div>
				
				
            
            
            