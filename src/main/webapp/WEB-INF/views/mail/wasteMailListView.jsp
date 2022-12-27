<%@ page pageEncoding="UTF-8"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>Home</title>
<link href="${path}/resources/css/include.css" rel="stylesheet"/>
<style type="text/css">
#pagingArea{width:fit-content;margin:auto;}
#mailList>tbody>tr:hover {
	cursor: pointer;
}
#star{
	color: blue;
}
</style>
</head>
<body>
	<div id="grid_container">
	
		<jsp:include page="../include.jsp" />
	
		<nav id="side">
			<jsp:include page="Topmenubar.jsp" />
		</nav>
	
		<article id="content">
			<c:if test="${ !empty msg }">
	<script>
		swal("${msg}")
	</script>
	<c:remove var="msg" scope="session"/>
</c:if>

<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			<div class="min-height-200px">
				<div class="page-header">
					<div class="row">
						<div class="col-md-6 col-sm-12">
							<div class="title">
								<h4>휴지통</h4>
							</div>
							<nav aria-label="breadcrumb" role="navigation">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="mail_list.do">홈</a></li>
									<li class="breadcrumb-item active" aria-current="page">휴지통</li>
								</ol>
							</nav>
						</div>
					</div>
				</div>

		<!-- basic table  Start -->
				<div class="pd-20 card-box mb-30">
					<div class="clearfix mb-20">
						<div class="pull-left">
							
						</div>
						<div class="pull-right">
					
						</div>
					</div>
					<div id="mailList">
					<table class="table table-hover mailList" id="mailList">
						<thead>
							<tr>
								<th scope="col"></th>
								<th scope="col"><i class="icon-copy ion-star" id="star"></i></th>
								<th scope="col"><i class="icon-copy ion-ios-email"></i></th>
								<th scope="col">받는사람</th>
								<th scope="col">제목</th>
								<th scope="col">날짜</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ wasteList }" var="s">
								<tr>
									<td scope="row">${ s.eml_no }</td>
									
									<c:choose>
										<c:when test="${s.importantFlag == '1'}">
											<td><i class="icon-copy ion-star" id="star"></i></td>
										</c:when>
										<c:otherwise>
											<td></td>
										</c:otherwise>
									</c:choose>
									
									<c:choose>
										<c:when test="${s.read_count == '0'}">
											<td><i class="icon-copy ion-ios-email"></i></td>
										</c:when>
										<c:otherwise>
											<td><i class="icon-copy ion-ios-email-outline"></i></td>
										</c:otherwise>
									</c:choose>
									
									<td>${s.eml_to }</td>
									
									<c:choose>
										<c:when test="${s.eml_from == member.mem_id}">
											<td><i class="icon-copy ion-android-hand"></i>   ${s.eml_title }</td>
										</c:when>
										<c:otherwise>
											<td>${s.eml_title }</td>
										</c:otherwise>
									</c:choose>
									
									<td>${s.create_date }</td>
								</tr>
							</c:forEach>
							 
							
						</tbody>
					</table>
					</div>
					
					
										
				<!-- 페이징 시작 -->							
				 <div id="pagingArea">
                <ul class="pagination">
                	<c:choose>
                		<c:when test="${ pi.currentPage ne 1 }">
                			<li class="page-item"><a class="page-link" href="waste.do?currentPage=${ pi.currentPage-1 }">이전</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item disabled"><a class="page-link" href="">이전</a></li>
                		</c:otherwise>
                	</c:choose>
                	
                    <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
                    	<c:choose>
	                		<c:when test="${ pi.currentPage ne p }">
                    			<li class="page-item"><a class="page-link" href="waste.do?currentPage=${ p }">${ p }</a></li>
	                		</c:when>
	                		<c:otherwise>
	                			<li class="page-item disabled"><a class="page-link" href="">${ p }</a></li>
	                		</c:otherwise>
	                	</c:choose>
                    </c:forEach>
                    
                    
                    <c:choose>
                		<c:when test="${ pi.currentPage ne pi.maxPage }">
                			<li class="page-item"><a class="page-link" href="waste.do?currentPage=${ pi.currentPage+1 }">다음</a></li>
                		</c:when>
                		<c:otherwise>
                			<li class="page-item disabled"><a class="page-link" href="waste.do?currentPage=${ pi.currentPage+1 }">다음</a></li>
                		</c:otherwise>
                	</c:choose>
                </ul>
            <!-- 페이징끝 -->
            
            </div>
			</div>
									
									
				<!-- basic table  End -->
				
				</div>
				</div>
				</div>
		</article>
		<script>
				$(function(){
					$(".mailList tbody tr").click(function(){
						location.href="wasteDetail.do?mno=" + $(this).children().eq(0).text();
					});
				});
		</script>
	</div>
</body>
</html>