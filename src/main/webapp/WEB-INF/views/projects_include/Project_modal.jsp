<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
	
</script>
<style type="text/css">
	.Main_name{
		font-size: 12px;
		color:gray;
	}
	.btn-primary{
		background-color:#7BE66D;
		border-style: none;
	}
	.btn-primary:hover{
		background-color:#C2F347;
	}
	#message-text{
	 resize: none;
	 }
</style>
</head>
<body>
	<c:set var="dto" value="${cont }"/>
	<c:set var="main" value="${main }"/>
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
      	  <h5 class="modal-title"><img src="resources/image/project_title.png" width="20" height="20">&nbsp;${dto.getProject_name() }
	      	  <c:forEach items="${main }" var="mdto">
				<c:if test="${mdto.getMain_no() == dto.getProject_main() }">
				<p class="Main_name">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${mdto.getMain_name() }</p>
				</c:if>
			  </c:forEach>
		  </h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <h5 class="modal-title"><img src="resources/image/project_description.png" width="20" height="20">&nbsp;상세내용</h5>
	        <br>
	         <textarea class="form-control" id="message-text" placeholder="작업 상세내용을 추가해 주세요."></textarea>
	      </div>
	      <div class="modal-body">
	      	 <h5 class="modal-title"><img src="resources/image/project_comment.png" width="20" height="20">&nbsp;코멘트</h5>
	      	 <br>
	         <img src="resources/image/project_man.png" width="35" height="30">${dto.getProject_giver() } 님
	         <div class="control">
	         <textarea class="form-control" id="message-text"  cols="100%" rows="1"></textarea>
	         <input type="button" class="btn btn-primary" value="저장">
	         </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save</button>
	      </div>
	    </div>
	  </div>
</body>
</html>