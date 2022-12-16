<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="https://ssl.pstatic.net/pwe/css/deskhome_header_https_20220921.css">
<title>Insert title here</title>
<link href="${path}/resources/css/address.css" rel="stylesheet"/>
<link href="${path}/resources/css/include.css" rel="stylesheet"/>
<style type="text/css">

.hord { display: table; margin-left: auto; margin-right: auto; }


ul{
	list-style:none;
}

.liany{
	text-align: center;
}

#side_menu li a{
	padding: 5px 0px;
}


a{
	text-decoration-line: none;
	padding: 10px 10px
}

.meun li a:hover{
	display: block;
	font-size: 12px;
	color: #555; 
	background: #7BE66D;
	background-size: auto;
}

input:focus{
	outline: 1px solid blue;
}

input{
	background-color:#7BE66D;
	border-radius: 5px;
	color: #FFFFFF;
	border: none;
}

</style>
</head>
<body>
	<div id="grid_container">
	
		<jsp:include page="../include.jsp" />

		<nav id="side">
 		<div align="center">
 			<label id="side_label">전자메일</label>
 		</div>
 		<div id="side_menu" style="overflow-y: hide; height: 65%; width: 65%;">
 			<hr>
 			<input class="" type="button" value="메일쓰기" onclick="location.href='send.do'">
 			<hr>
 			<ul class="meun">
 				<li class="liany"><a href="mail_list.do">전체메일</a></li>
 				<li class="liany"><a href="receiveList.do">받은메일함</a></li>
 				<li class="liany"><a href="#">내게쓴메일함</a></li>
 				<li class="liany"><a href="sendList.do">보낸메일함</a></li>
 				<li class="liany"><a href="#">임시저장함</a></li>
 				<li class="liany"><a href="#">외부메일함</a></li>
 			</ul>
 			<!-- <hr class="add">  -->
 			<ul class="meun">
 				<li class="liany"><a href="#">스펨메일함</a></li>
 				<li class="liany"><a href="#">휴지통</a></li>
 			</ul>
 		</div>
 		</nav>
		
		<article id="content">
			<jsp:include page="send.jsp"/>
		</article>
	</div>				
</body>
</html>