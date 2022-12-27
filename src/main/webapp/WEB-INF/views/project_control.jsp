<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<jsp:include page="projects_include/link.jsp"/>
<link href="${path}/resources/css/include.css" rel="stylesheet"/>
<link href="${path}/resources/css/project/project_control.css" rel="stylesheet"/>

</head>
<body>
	<c:set var="status" value="${status }"/>
	<div id="grid_container">
	
		<jsp:include page="include.jsp" />
	
		<nav id="side">
			<label>목 록</label>
			<div id="side_menu" style="overflow-y: auto;">
				<label class="modal_label" for="popup01"><a href="project_board.do">보 드</a></label><br>
				<div class="side_menu_body">
					<c:forEach items="${status }" var="sdto">
						<div class="status_div"><a href="project_status_table.do?project_status=${sdto.getStatus_no() }">${sdto.getStatus_name() }</a></div>
					</c:forEach>
				</div>
			</div>
		</nav>
	
		<article id="content">
			<form method="post" action="project_search.do">
				<select id="search_select" name="field">
					<option value="name">이 름</option>
					<option value="project_name">프로젝트</option>
				</select>
				<input id="search_box" type="text" name="keyword" placeholder="검색">
				<input id="search_btn" type="submit" value="검색">
			</form>
			<br>
			<jsp:include page="projects_include/project_table.jsp"/>
		</article>
	
	</div>
</body>
</html>