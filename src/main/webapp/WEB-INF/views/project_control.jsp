<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="projects_include/link.jsp"/>
</head>
<body>
	<c:set var="list" value="${list }"/>
	<c:set var="main" value="${main }"/>
	
	<!-- 인클루드 -->	
	<jsp:include page="include.jsp"/>
	
	<!-- [세건] 프로젝트 Nav Bar  -->
	<jsp:include page="projects_include/project_include.jsp"/>
	<br><br><br>
	
	<!-- [세건] 프로젝트 목록 및 생성  -->
	<jsp:include page="projects_include/project_table.jsp"/>
</body>
</html>