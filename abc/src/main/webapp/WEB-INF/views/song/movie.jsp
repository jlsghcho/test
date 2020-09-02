<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
		
<div class="title">
	<h3>${title}</h3>
</div>
<div class="paper">
	<div class="close">close</div>
	<div class="video-wrapper">
		<div id="studyVideo"></div>
		<div class="player_controls">
			<div id="playBtn" onclick="playYoutube();">Play</div>
	    	<div id="pauseBtn" onclick="pauseYoutube();">Pause</div>
	    	<div id="current_time"></div>
	    </div>
		<div class="frame_line"><span></span></div>
	</div>
</div>