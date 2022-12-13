<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<link href="${path}/resources/css/bootstrap_include.css" rel="stylesheet"/>
<jsp:include page="projects_include/link.jsp"/>
</head>
<body>
	<div id="grid_container">
	
		<jsp:include page="include.jsp" />
	
		<nav id="side">
			<label>주소록</label>
			<div id="side_menu" style="overflow-y: auto;">
				<a href="project_board.do">보드</a>
			</div>
		</nav>
	
		<article id="content">
			<jsp:include page="projects_include/project_table.jsp"/>
		</article>
	
	</div>
</body>
</html>