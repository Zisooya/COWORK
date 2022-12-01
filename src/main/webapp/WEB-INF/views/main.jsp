
<%@ page session="false" pageEncoding="UTF-8"  %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>Home</title>
<link href="${path}/resources/css/include.css" rel="stylesheet"/>
</head>
<body>
<div id="grid_container">

	<jsp:include page="include.jsp" />


	<nav id="side">
		<label>주소록</label>
	</nav>

	<article id="content">

	<h1>임시 메인 페이지</h1>


	<P><a href="<%=request.getContextPath() %>/testDB.do">DB 연동 테스트</a></P>

	<br><br>
	<a href="<%=request.getContextPath() %>/calendar.do">📅 캘린더</a>

	<br>
	테스트1
	<a href="<%=request.getContextPath() %>/member_login.do">[로그인 페이지 테스트]</a>
	</article>

<a href="<%=request.getContextPath() %>/project_control.do">[프로젝트 관리]</a>

</div>
</body>
</html>