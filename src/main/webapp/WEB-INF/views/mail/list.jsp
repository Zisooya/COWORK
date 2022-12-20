<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

.hord { display: table; margin-left: auto; margin-right: auto; }


ul{
	list-style:none;
}

.liany{
  	float : left;	
}
/*
.add{
	background-size: auto;
	background-color: black;
	height: 1px;
	border: 0px;
}
*/
a{
	text-decoration-line: none;
}

.meun li a:hover{
	display: block;
	font-size: 12px;
	color: #555; 
	background: #7BE66D;
	background-size: auto;
}

</style>
</head>
<body>
	<article id="content">
		
		<div align="center">
		<table border="1" cellspacing="0" width="500">
			<tr>
				<th>No</th> <th>보낸사람</th>
				<th>제목</th> <th>받은날짜</th>
			</tr>
			<c:set var="list" value="${List }"/>
			<c:set var="paging" value="${Paging }"/>
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<tr>
						<td>${dto.getEml_no() }</td>
						<td>${dto.getEml_writer() }</td>
						<td><a href="<%=request.getContextPath() %>/mail_content.do?no=${dto.getEml_no()}&page=${paging.getPage() }">
						${dto.getEml_title() }</a></td>
						<td>${dto.getEml_writedate() }</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty list }">
				<tr>
					<td colspan="5" align="center">
					 	<h3>전체 목록이 없습니다...</h3>
					 </td>
				</tr>
			</c:if>
		</table>
		<br>
		
		<!-- 페이징 처리 부분 -->
		<div align="center" class="hord">
		<nav aria-label="Page navigation example" class="hord1">
		  <ul class="pagination">
		    <li class="page-item">
		    <c:if test="${paging.getPage() > paging.getBlock() }">
		    
		      <a class="page-link" href="mail_list.do?page=${paging.getStartBlock() - 1 }" aria-label="◀">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		      </c:if>
		    
		    <c:forEach begin="${paging.getStartBlock() }" end="${paging.getEndBlock() }" var="i">
		   
		    </li>
		    <c:if test="${i == paging.getPage() }">
		    <li class="page-item"><a class="page-link" href="mail_list.do?page=${i }">${i }</a></li>
		    </c:if>
		    <c:if test="${i != paging.getPage() }">
		    <li class="page-item"><a class="page-link" href="mail_list.do?page=${i }">${i }</a></li>
		    </c:if>
		    
		    </c:forEach>
		    	
		    <li class="page-item">
		    	<c:if test="${paging.getEndBlock() < paging.getAllPage() }">
		      <a class="page-link" href="mail_list.do?page=${paging.getEndBlock() + 1 }" aria-label="▶">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		      </c:if>
		    </li>
		  </ul>
		</nav>
		</div>
	</div>
	</article>
</body>
</html>