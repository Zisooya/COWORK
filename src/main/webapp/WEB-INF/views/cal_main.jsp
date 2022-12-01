<%@ page session="false" pageEncoding="UTF-8"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<!-- <meta charset="UTF-8"> -->
<title>Insert title here</title>
<link href="${path}/resources/css/include.css" rel="stylesheet"/>
</head>
<body>
	<div id="grid_container">
		<jsp:include page="include.jsp" />
		<nav id="side">
			<input type="button" value="일정쓰기">
		</nav>
		<article id="content">
			<!-- 일정 검색 -->
			<form method="post" action="<%=request.getContextPath()%>/calendar_search.do">
				<select name="field">
					<option value="title">제목</option>
					<option value="cont">내용</option>
					<option value="writer">작성자</option>
				</select>
				
				<input name="keyword">&nbsp;&nbsp;
				<input type="submit" value="검색">
			</form>
		
		
		
		
		
		
		
		</article>
	</div>
</body>
</html>