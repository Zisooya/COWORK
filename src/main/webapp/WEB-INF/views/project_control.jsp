<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<c:set var="list" value="${list }"/>
	<c:set var="main" value="${main }"/>
	
	<!-- [세건] 프로젝트 Nav Bar  -->
	<jsp:include page="projects_include/project_include.jsp"/>
	<br>
	<br>
	<br>
	<!-- [세건] 프로젝트 목록 및 생성  -->
	<jsp:include page="projects_include/project_table.jsp"/>
</body>
</html>