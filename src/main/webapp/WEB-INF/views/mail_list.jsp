<%@ page session="false" pageEncoding="UTF-8"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%
%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>Home</title>
<link href="${path}/resources/css/include.css" rel="stylesheet"/>
</head>
<body>
	<div id="grid_container">
	
		<jsp:include page="include.jsp" />
	
		<nav id="side">
			<label>전자메일</label>
			<div id="side_menu" style="overflow-y: auto;">
	
			</div>
		</nav>
	
		<article id="content">
	
		<h1>임시 페이지</h1>
	
		<br>
		
		<a href="#"></a>
		
		</article>
	
	</div>
</body>
</html>