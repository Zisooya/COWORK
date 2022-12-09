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
<script type="text/javascript">
	$(function(){
		$(".list_header_update").hide();
 		$(".list-name-input").hide();
 		$(".plus_card").hide();
		$(".mod-list-add-button").click(function(){
			$(".list-name-input").show();
			$(".mod-list-add-button").hide();
		})
		$(document).mouseup(function (e){
		    var container = $(".plus")
		    if(container.has(e.target).length == 0){ 
		    	$(".plus_card").hide(100);
		    }
		});
	/* 프로젝트 이름 클릭시 상세보기 모달 창 생성 */
		$(".project_name").click(function(){
			let href = ($(this).attr("id"));
			let href1 = "<%=request.getContextPath()%>/content.do?num="+href;
 			let project_name = $(".project_name").text();
			 $("#Project_content").load(href1, function() {
		            $("#Project_content").modal("show");
		            $('#form-control').focus();
		      });
 		})
		
		
 		$(".insert_card").click(function(){
			$(".plus_card").toggle(100);
		})
	})
	
</script>
<link href="${path}/resources/css/include.css" rel="stylesheet"/>
<style type="text/css">
body{
	background-color: #E4F7BA;
	height: 100%;
}
#content{
	height:100%;
	outline: none;
    position: relative;
    display: flex;
    flex-direction: column;
    height: 100%;
    margin-right: 0;
    position: relative;
    transition: margin .1s ease-in;
    overflow-x: auto;
    overflow-y: hidden;
    position: relative;
    z-index: 0;
}
.row:first-child{
	margin-left: 10px;
}
.col{
	max-width: 300px;
	height:100%;
	padding-left: 5px;
	padding-right: 5px;
	min-width: 300px;
}
.border-success{
	box-shadow: var(--ds-shadow-raised,0 1px 0 #091e4240);
}
.plus{
	display: inline-block;
}
.card{
	margin-bottom: 10px !important;
	max-height: 95%;
	z-index: 1;
}
.card-body,.card-header{
	padding: 8px;
	font-size: 13px;
}
.plus_card{
	padding-top: 16px;
	padding-bottom: 0;
}

.u-fancy-scrollbar::-webkit-scrollbar {
    height: 8px;
    width: 8px;
}

.list-cards {
    flex: 1 1 auto;
    margin: 0 4px;
    min-height: 0;
    padding: 0 4px;
    z-index: 1;
    overflow: auto;
    max-height: 775px;
    min-width: 239px;
}
.card_title_hr{
	margin-top: 5px;
	margin-bottom: 0;
}
</style>
</head>
<body class="feplat3731">
	<c:set var="list" value="${list }"/>
	<c:set var="main" value="${main }"/>
	<c:set var="status" value="${status }"/>
	<c:set var="mlist" value="${mlist }"/>
	<%-- <jsp:include page="../include.jsp" />  --%>
	<div id="grid_container">
		<nav id="side">
			<label>목 록</label>
			<div id="side_menu" style="overflow-y: auto;">
				
			</div>
		</nav>
		<article id="content">
			<div class="row row-cols-1 row-cols-md-3 g-4 d-flex flex-nowrap ">
				<c:forEach items="${status }" var="sdto">
				<c:set var="count1" value="${count1 +1 }"/>
				<!-- borad -->
				  <div class="col">
				    <div class="card">
				      <div class="card-body">
			        	<h5 class="card-title">${sdto.getStatus_name() }</h5>
			        	<hr class="card_title_hr">
						    <div class="list-cards u-fancy-scrollbar u-clearfix js-list-cards js-sortable ui-sortable">
						        <p class="card-text">
						        	<c:forEach items="${list }" var="dto">
						        	<c:if test="${sdto.getStatus_no() == dto.getProject_status() }">
						        	<!-- card -->					        	  	
						        	 <c:set var="count" value="${count +1 }"/>
										<div style="cursor:pointer" id="${dto.getProject_no() }" class="card border-light mb-3 shadow p-3 mb-5 bg-body rounded project_name"style="max-width: 18rem;">
							        	  <c:forEach items="${main }" var="mdto">
							        	  <c:if test="${mdto.getMain_no() == dto.getProject_main() }">
							        	  <c:if test="${mdto.getMain_name().length() > 15 }">
											  <div id="${dto.getProject_no() }" class="card-header">${mdto.getMain_name().substring(0,15) }...</div>
										  </c:if>
										  <c:if test="${mdto.getMain_name().length() <= 14 }">
											  <div id="${dto.getProject_no() }" class="card-header">${mdto.getMain_name() }</div>
										  </c:if>
											  <div class="card-body">
											  	<c:if test="${dto.getProject_name().length() > 15 }">
											    	<b class="card-title">${dto.getProject_name().substring(0,15) }...</b>
											    </c:if>
											    <c:if test="${dto.getProject_name().length() <= 14 }">
											    	<b class="card-title">${dto.getProject_name() }</b>
											    </c:if>
											  </div>
										  </c:if>
										  </c:forEach>
										</div>
									</c:if>
									</c:forEach>
						        </p>
						      </div>
					      <div class="card-footer">
					        <small class="text-muted">${count }</small>
					      </div>
					    </div>
				    </div>
				 <input type="hidden" class="project_count" value="${count }">
				  </div>
				 </c:forEach>
				<div class="plus">
					<form method="post" action="insert_status.do">
						<div id="plus" class="card text-bg-light" style="max-width: 18rem;">
						  <div style="cursor:pointer" class="card-header insert_card">추가하기</div>
						  <div class="card-body plus_card">
						    <div class="input-group mb-3">
							  <input type="text" class="form-control" name="status_name" aria-label="Recipient's username" aria-describedby="button-addon2" >
							  <button class="btn btn-outline-secondary" type="submit" id="button-addon2">ADD</button>
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
<script type="text/javascript">

</script>
</html>