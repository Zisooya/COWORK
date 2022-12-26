<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<jsp:include page="link.jsp"/>
<script src="resources/script/project/project_board.js"></script>
<link href="${path}/resources/css/bootstrap_include.css" rel="stylesheet"/>
<link href="${path}/resources/css/project/project_board.css" rel="stylesheet"/>

</head>
<body id="background_board">
	<c:set var="list" value="${list }"/>
	<c:set var="main" value="${main }"/>
	<c:set var="status" value="${status }"/>
	<c:set var="mlist" value="${mlist }"/>
	<div id="grid_container">
	<jsp:include page="../include.jsp" />
		<nav id="side">
			<label>목 록</label>
			<div id="side_menu" style="overflow-y: auto;">
				<label class="modal_label" for="popup01"><a href="project_control.do">테이블</a></label><br>
				<hr>
				<b style="cursor:pointer" class="status_oc">STATUS</b><br>
				<c:forEach items="${status }" var="sdto">
					<div class="btn-group status_div" role="group" aria-label="Basic checkbox toggle button group">
					  <input type="checkbox" class="btn-check status_list" id="${sdto.getStatus_no() }" autocomplete="off" checked>
					  <label class="btn btn-outline-primary" for="${sdto.getStatus_no() }">${sdto.getStatus_name() }</label>
					</div>
				</c:forEach>
				<hr>
				<b style="cursor:pointer" class="member_oc">MEMBER</b><br>
				<c:forEach items="${mlist }" var="memlist">
					<div class="btn-group member_div" role="group" aria-label="Basic checkbox toggle button group">
					  <input type="checkbox" class="btn-check member_list" id="${memlist.getMem_name() }" autocomplete="off" checked>
					  <label class="btn btn-outline-primary" for="${memlist.getMem_name() }">${memlist.getMem_name() }</label>
					</div>
				</c:forEach>
				<hr>
			</div>
		</nav>
		<article id="content">
			<div class="row row-cols-1 row-cols-md-3 g-4 d-flex flex-nowrap ">
				<c:forEach items="${status }" var="sdto">
				<c:set var="count" value="${count +1 }"/>
				<!-- borad -->
				  <div class="col" id="${sdto.getStatus_no() }">
				    <div class="card">
				      <div class="card-body">
			        	<h5 class="card-title">${sdto.getStatus_name() }</h5>
			        	<hr class="card_title_hr">
						    <div id="${sdto.getStatus_name() }" class="list-cards u-fancy-scrollbar u-clearfix js-list-cards js-sortable ui-sortable column">
						        <p class="card-text">
						        	<c:forEach items="${list }" var="dto">
						        	<c:if test="${sdto.getStatus_no() == dto.getProject_status() }">
						        	<!-- card -->					        	  	
										<div style="cursor:pointer" id="${dto.getProject_no() }" class="card border-light mb-3 shadow p-3 mb-5 bg-body rounded project_name portlet" style="max-width: 18rem;">
							        	  <c:forEach items="${main }" var="mdto">
							        	  <c:if test="${mdto.getMain_no() == dto.getProject_main() }">
							        	  <c:if test="${mdto.getMain_name().length() > 15 }">
											  <div id="${dto.getProject_no() }" class="card-header portlet-header">${mdto.getMain_name().substring(0,15) }...</div>
										  </c:if>
										  <c:if test="${mdto.getMain_name().length() <= 14 }">
											  <div id="${dto.getProject_no() }" class="card-header portlet-header">${mdto.getMain_name() }</div>
										  </c:if>
											  <div class="card-body portlet-content">
											  	<c:if test="${dto.getProject_name().length() > 15 }">
											    	<b class="card-title">${dto.getProject_name().substring(0,15) }...</b>
											    </c:if>
											    <c:if test="${dto.getProject_name().length() <= 14 }">
											    	<b class="card-title portlet-content">${dto.getProject_name() }</b>
											    </c:if>
											  </div>
										  </c:if>
										  </c:forEach>
										<input type="hidden" class="taker" value="${dto.getProject_taker() }">
										<input type="hidden" class="taker" value="${dto.getProject_taker2() }">
										<input type="hidden" class="taker" value="${dto.getProject_taker3() }">
										<input type="hidden" class="taker" value="${dto.getProject_taker4() }">
										<input type="hidden" class="taker" value="${dto.getProject_taker5() }">
										</div>
									</c:if>
									</c:forEach>
						        </p>
						      </div>
					      <div class="card-footer" style="cursor:pointer">	
					      	추가하기
					      	
						<!-- 카드 추가하기 -->
						<form id="isert_card" method="post" action="board_project_insert.do">
						<div style="cursor:pointer" class="card border-light mb-3 shadow p-3 mb-5 bg-body rounded portlet add_card" style="max-width: 18rem;">
							  <div id="add_card_header" class="card-header portlet-header">
							  	<select id="add_card_main" name="project_main" class="form-select add_card_main" aria-label="Default select example">
									<option value="none">:::메인 프로젝트:::</option>
									<c:forEach items="${main }" var="mdto">
										<option value="${mdto.getMain_no() }">${mdto.getMain_name() }</option>
									</c:forEach>
								</select>
							  </div>
							  <div class="card-body portlet-content">
							    	<b id="add_card_body" class="card-title portlet-content">
							    		<textarea name="project_name" class="textarea card border-light mb-3 shadow p-3 mb-5 bg-body rounded portlet add_card_content" id="comment1 add_card_content" cols="24%" rows="2" placeholder="프로젝트명을 입력해주세요." onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
							    	</b>
							    	<input class="board_insert_project btn btn-primary" type="submit" value="추가">
							  </div>
							  <input type="hidden" name="project_status" value="${sdto.getStatus_no() }">
						</div>
						</form>
					      </div>
					    </div>
				    </div>
				  </div>
				 </c:forEach>
				 <!-- status 추가하기 -->
				 <input type="hidden" class="status_count" value="${count }">
				<div class="plus">
					<form id="insert_status" method="post" action="insert_status.do">
						<div id="plus" class="card text-bg-light" style="max-width: 18rem;">
						  <div style="cursor:pointer" class="card-header insert_card">추가하기</div>
						  <div class="card-body plus_card">
						    <div class="input-group mb-3">
							  <input type="text" class="form-control board_insert" name="status_name" aria-label="Recipient's username" aria-describedby="button-addon2" >
							  <button id="StatusInsert_btn" class="btn btn-outline-secondary" type="submit">ADD</button>
							</div>
						  </div>
						</div>
					</form>
				</div>
			</div>
    	</article>
	</div>
<input type="hidden" class="status_count" value="${count1 }">
<div id="Project_content" class="modal" tabindex="-1">
</div>
</body>
</html>