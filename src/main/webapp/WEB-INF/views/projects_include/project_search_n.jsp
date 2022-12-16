<%@ page session="false" pageEncoding="UTF-8"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Home</title>

<jsp:include page="link.jsp"/>
<script src="resources/script/project/project_table.js"></script>
<link href="${path}/resources/css/project/project_ss.css" rel="stylesheet"/>
<link href="${path}/resources/css/bootstrap_include.css" rel="stylesheet"/>

</head>
<body>
	<div id="grid_container">
		<jsp:include page="../include.jsp" />
		<nav id="side">
			<label>목 록</label>
			<div id="side_menu" style="overflow-y: auto;">
				<label class="modal_label" for="popup01"><a href="project_board.do">보 드</a></label>
				<label class="modal_label" for="popup01"><a href="project_control.do">전체보기</a></label><br>
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
			<c:set var="list" value="${list }"/>
			<c:set var="main" value="${main }"/>
			<c:set var="status" value="${status }"/>
			<c:set var="mlist" value="${mlist }"/>
			<c:set var="paging" value="${Paging }" />
			<form id="project_create" method="post" action="<%=request.getContextPath()%>/project_insert.do">
				<table class="table table-striped" >
					<tr>
						<th>Main</th>
						<th>Project</th>
						<th>Due Date</th>
						<th>Member</th>
						<th>Status</th>
					</tr>
					<c:forEach items="${list }" var="dto">
						<tr>
								<c:forEach items="${main }" var="mdto">
									<c:if test="${mdto.getMain_no() == dto.getProject_main() }">
										<td><b>${mdto.getMain_name() }</b></td>
									</c:if>
								</c:forEach>
							<td class="project_name" id="${dto.getProject_no() }">${dto.getProject_name() }</td>
							<td>${dto.getProject_end().substring(0,10) }</td>
							<td>${dto.getProject_taker() }</td>
							<td>
								<c:forEach items="${status }" var="sdto">
									<c:if test="${dto.getProject_status() == sdto.getStatus_no() }">${sdto.getStatus_name() }</c:if>
								</c:forEach>
							</td>
						</tr>
					</c:forEach>
						<tr class="project_create">
							<td class="main_select">
								<select name="project_main" class="form-select" aria-label="Default select example">
									<option value="none">:::메인 프로젝트:::</option>
									<c:forEach items="${main }" var="mdto">
										<option value="${mdto.getMain_no() }">${mdto.getMain_name() }</option>
									</c:forEach> 
								</select>
							</td>
							<td class="project_create1">
							</td>
							<td class="project_create2">
							</td>
							<td class="member">
								<select name="project_taker" class="form-select" aria-label="Default select example">
									<option value="none">:::선택:::</option>
									<c:forEach items="${mlist }" var="memlist">
										<option value=${memlist.getMem_name() }>${memlist.getMem_name() }</option>
									</c:forEach>
								</select>
							</td>
							<td class="status">
								<select name="project_status" class="form-select" aria-label="Default select example">
									<option value="none">:::선택:::</option>
									<c:forEach items="${status }" var="sdto">
										<option value=${sdto.getStatus_no() }>${sdto.getStatus_name() }</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr id="insert_projects_tr">
							<td colspan="5" align="center">
								<input class="submit btn btn-primary insert_projects_btn" style="background-color: #C2F347; color:white;" type="button" value="추가하기">
								<a href="#" class="project_btn insert_projects_a"><input class="btn btn-primary insert_projects_btn" style="background-color: #C2F347; color:white;" type="button" value="추가하기"></a>
							</td>
						</tr>
				</table>
			</form>
			<div class="paging_div">
			<nav class="paging">
				<ul class="pagination">
					<li class="page-item"><a class="page-link paging_btn"
						href="project_search.do?page=1&field=${paging.getField() }&keyword=${paging.getKeyword()}">First</a></li>
					<c:if test="${paging.getPage() == 1 }">
				    <li>
				      <a class="page-link paging_btn" 
				      		href="project_search.do?page=1&field=${paging.getField() }&keyword=${paging.getKeyword()}">Previous</a>
				    </li>
				    </c:if>
				    <c:if test="${paging.getPage() != 1 }">
				    <li>
				      <a class="page-link paging_btn" 
				      		href="project_search.do?page=${paging.getPage() - 1 }&field=${paging.getField() }&keyword=${paging.getKeyword()}">Previous</a>
				    </li>
				    </c:if>
					<c:forEach begin="${paging.getStartBlock() }" end="${paging.getEndBlock() }" var="i">
		
						<c:if test="${i == paging.getPage() }">
							<li class="page-item active" aria-current="page"><a
								class="page-link paging_btn" style="background-color: #C2F347; border-style:none;"  href="project_search.do?page=${i }&field=${paging.getField() }&keyword=${paging.getKeyword()}">${i }</a></li>
						</c:if>
		
						<c:if test="${i != paging.getPage() }">
							<li class="page-item"><a class="page-link paging_btn" 
								href="project_search.do?page=${i }&field=${paging.getField() }&keyword=${paging.getKeyword()}">${i }</a></li>
						</c:if>
					</c:forEach>
		
					<c:if test="${paging.getEndBlock() < paging.getAllPage() }">
						<li class="page-item"><a class="page-link paging_btn"
							href="project_search.do?page=${paging.getEndBlock() + 1 }&field=${paging.getField() }&keyword=${paging.getKeyword()}">Next</a></li>
						<li class="page-item"><a class="page-link paging_btn"
							href="project_search.do?page=${paging.getAllPage() }&field=${paging.getField() }&keyword=${paging.getKeyword()}">End</a></li>
					</c:if>
				</ul>
			</nav>
			</div>
			<div id="Project_content" class="modal" tabindex="-1">
			</div>
		</article>
	
	</div>
</body>
</html>