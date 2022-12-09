<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(".header_textarea").hide();
	/* 프로젝트 이름 클릭시 상세보기 모달 창 생성 */
		$(".project_name").click(function(){
			let href = ($(this).attr("id"));
			let href1 = "<%=request.getContextPath()%>/content.do?num="+href;
 			let project_name = $(".project_name").text();
			 $("#Project_content").load(href1, function() {
		           $("#Project_content").modal("show");
		      });
 		})
	})
	
</script>
<link href="${path}/resources/css/include.css" rel="stylesheet"/>
<link href="${path}/resources/css/project_board.css" rel="stylesheet"/>
<style type="text/css">
body{
	background-color: #E4F7BA;
}
.status{
	display: inline-block;
	margin-left: 10%;
	border: 1px soild black;
	max-width: 300px;
}
</style>
</head>
<body class="feplat3731">
	<c:set var="list" value="${list }"/>
	<c:set var="main" value="${main }"/>
	<c:set var="status" value="${status }"/>
	<c:set var="mlist" value="${mlist }"/>
	<jsp:include page="../include.jsp" />
	<div id="grid_container">
	
		<nav id="side">
			<label>목 록</label>
			<div id="side_menu" style="overflow-y: auto;">
				
			</div>
		</nav>
		<article id="content">
			<div class="frame">
				<c:forEach items="${status }" var="sdto">
					<div class="status">
						<div class="header">
							<h2>${sdto.getStatus_name() }</h2>
							<textarea class="header_textarea" rows="1" cols="10">${sdto.getStatus_name() }</textarea>
						</div>
						<div class="body">
							<div class="project">
								<c:forEach items="${list }" var="dto">
									<c:if test="${sdto.getStatus_no() == dto.getProject_status() }">
										<a href="#" class="project_name">${dto.getProject_name() }</a>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>	
				</c:forEach>
			</div>
    	</article>
</div>
</body>
</html>