<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#search_select{
		max-width: 7.5vw;
		height: 46px;
		border-radius: 5px;
		border: 1px solid #EAEAEA;
		background-color:#EAEAEA;
		box-sizing: border-box;
		padding: 0 40px;
		font-size: 1em;
		padding-left: 1vw;
		padding-right: 0;
	}
	#search_box {
		width: 30%;
		height: 46px;
		border-radius: 5px;
		border: 1px solid #EAEAEA;
		background-color:#EAEAEA;
		background-image: url(resources/images/검색.png);
		background-size: 25px;
		background-repeat: no-repeat;
		background-position: 5px center;
		box-sizing: border-box;
		padding: 0 40px;
		font-size: 1rem;
	}
	#search_btn {
		width: 100px;
		height: 46px;
		background-color: #C2F347;
		color: #FFF;
		font-size: 1rem;
		border: 0;
		border-radius: 5px;
		box-sizing: border-box;
		cursor: pointer;
	}
	.modal_label {
		text-align: center;
		margin: 15px 0px 10px 0px;	
		border: 0;	
		border-radius: 5px;	
		box-sizing: border-box;	
		width: 100px;
		height: 46px;
		font-size: 0.9rem;
		font-weight: bold;		
		display: inline-block;
		padding: 12px 3px;
		background: #7BE66D;
		color: #FFF;
		cursor: pointer;
	}
	.modal_label a{
		display:block;
		color: #FFF;
		text-decoration: none;
	}
	.side_menu_body{
		text-align: left;
	}
	.side_menu_body a{
		text-decoration: none;
		color: black;
	}
	.side_menu_body hr{
		margin-top: 5px;
		margin-bottom: 5px;
	}
</style>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<link href="${path}/resources/css/bootstrap_include.css" rel="stylesheet"/>
<jsp:include page="projects_include/link.jsp"/>
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
						<a href="project_status_table.do?project_status=${sdto.getStatus_no() }">${sdto.getStatus_name() }</a><br>
						<hr>
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