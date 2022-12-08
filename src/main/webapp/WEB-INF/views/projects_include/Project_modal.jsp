<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/script/project_modal.js"></script>
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
		width:140px;
	}
	.btn-primary:hover{
		background-color:#C2F347;
	}
	 #control1,#control2,#control1_1{
	 	border-style: none;
	 	width:81%;
	 	border-radius: 5px;
	 	border-color: lightgrey;
	 }
	 .textarea{
	 	outline: none;
	 	border: 1px solid lightgray;
	 	border-radius: 5px;
	 	resize: none;
	 }
	 .img{
	 	display: inline-block;
	 }
	 select option{
	 	border-radius: 5px;
	 }
	 #asd{
	 	width:74px;
	 }
	 .project_taker{
	 	display: inline-block;
	 }
	 #project_start,#project_end,#start,#end,#move,#delete{
	 	float: right;
	 }
	 #project_start_btn,#project_end_btn{
	 	float: left;
	 }
	 .card-body{
	 	width:100px;
        margin:auto;
        display:block;
	 }
	 #project_comment{
	 	border-style: none;
	 	border:1px solid white !important;
	 }
</style>
</head>
<body>
	<c:set var="dto" value="${cont }"/>
	<c:set var="main" value="${main }"/>
	<c:set var="mlist" value="${mlist }"/>
	<c:set var="status" value="${status }"/>
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		<input type="hidden" class="project_no" value="${dto.getProject_no() }">
	      <div class="modal-header">
	      <!-- 모달창 헤더 -->
      	  <h5 class="modal-title"><img src="resources/image/project_title.png" width="20" height="20">&nbsp;${dto.getProject_name() }
	      	  <c:forEach items="${main }" var="mdto">
				<c:if test="${mdto.getMain_no() == dto.getProject_main() }">
				<p class="Main_name">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${mdto.getMain_name() }</p>
				</c:if>
			  </c:forEach>
		  </h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	     
	      <div id="member" class="modal-body">
	      <!-- 멤버 -->
			<img class="img" src="resources/image/project_member.jpg" width="35" height="30">Members<br>
					<div class="project_taker">
						<!-- 멤버1 -->
						<c:if test="${!empty dto.getProject_taker() }">
							<button id="taker1" class="popoverThis btn btn-large btn-secondary">${dto.getProject_taker() }</button>
							<!-- 멤버1 popover -->
							<div id="popover-heading1" class="hide_1">
								<c:forEach items="${mlist }" var="memlist">
						    		<c:if test="${memlist.getMem_name() == dto.getProject_taker() }">
						    				<img id="member1" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
						    				<input type="hidden" id="heading1_mem" value="${memlist.getMem_name() }">
						    		</c:if>
						    	</c:forEach>
							</div>
							<div id="popover-body1" class="hide_1">
								<a href="#">회원 정보 보기</a><hr><a href="#" id="except1">프로젝트 제외하기</a>
							</div>
						</c:if>
						
						<!-- 멤버2 -->
						<c:if test="${!empty dto.getProject_taker2() }">
							<button id="taker2" class="popoverThis btn btn-large btn-secondary">${dto.getProject_taker2() }</button>
							<!-- 멤버2 popover -->
							<div id="popover-heading2" class="hide_1">
								<c:forEach items="${mlist }" var="memlist">
						    		<c:if test="${memlist.getMem_name() == dto.getProject_taker2() }">
						    				<img id="member2" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
						    				<input type="hidden" id="heading2_mem" value="${memlist.getMem_name() }">
						    		</c:if>
						    	</c:forEach>
							</div>
							<div id="popover-body2" class="hide_1">
								<a href="#">회원 정보 보기</a><hr><a href="#" id="except2">프로젝트 제외하기</a>
							</div>
						</c:if>
						
						<!-- 멤버3 -->
						<c:if test="${!empty dto.getProject_taker3() }">
							<button id="taker3" class="popoverThis btn btn-large btn-secondary">${dto.getProject_taker3() }</button>
							<!-- 멤버3 popover -->
							<div id="popover-heading3" class="hide_1">
								<c:forEach items="${mlist }" var="memlist">
						    		<c:if test="${memlist.getMem_name() == dto.getProject_taker3() }">
						    				<img id="member3" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
						    				<input type="hidden" id="heading3_mem" value="${memlist.getMem_name() }">
						    		</c:if>
						    	</c:forEach>
							</div>
							<div id="popover-body3" class="hide_1">
								<a href="#">회원 정보 보기</a><hr><a href="#" id="except3">프로젝트 제외하기</a>
							</div>
						</c:if>
						
						<!-- 멤버4 -->
						<c:if test="${!empty dto.getProject_taker4() }">
							<button id="taker4" class="popoverThis btn btn-large btn-secondary">${dto.getProject_taker4() }</button>
							<!-- 멤버4 popover -->
							<div id="popover-heading4" class="hide_1">
								<c:forEach items="${mlist }" var="memlist">
						    		<c:if test="${memlist.getMem_name() == dto.getProject_taker4() }">
						    				<img id="member4" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
						    				<input type="hidden" id="heading4_mem" value="${memlist.getMem_name() }">
						    		</c:if>
						    	</c:forEach>
							</div>
							<div id="popover-body4" class="hide_1">
								<a href="#">회원 정보 보기</a><hr><a href="#" id="except4">프로젝트 제외하기</a>
							</div>
						</c:if>
						
						<!-- 멤버5 -->
						<c:if test="${!empty dto.getProject_taker5() }">
							<button id="taker5" class="popoverThis btn btn-large btn-secondary">${dto.getProject_taker5() }</button>
							<!-- 멤버5 popover -->
							<div id="popover-heading5" class="hide_1">
								<c:forEach items="${mlist }" var="memlist">
						    		<c:if test="${memlist.getMem_name() == dto.getProject_taker5() }">
						    				<img id="member5" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
						    				<input type="hidden" id="heading5_mem" value="${memlist.getMem_name() }">
						    		</c:if>
						    	</c:forEach>
							</div>
							<div id="popover-body5" class="hide_1">
								<a href="#">회원 정보 보기</a><hr><a href="#" id="except5">프로젝트 제외하기</a>
							</div>
						</c:if>
					</div>
					<span class="hide">
						<select id="project_taker" class="btn btn-secondary" name="project_taker">
							<option value="none">:::선택::::</option>
							<c:forEach items="${mlist }" var="memlist">
								<option value="${memlist.getMem_name() }">${memlist.getMem_name() }</option>				
							</c:forEach>
						</select>
					</span>
			  <a id="plus_taker" class="btn btn-secondary"><img src="resources/image/project_taker.png" width="20" height="20"></a>
	      </div>

	      <div class="modal-body">
	        <h5 class="modal-title"><img src="resources/image/project_description.png" width="20" height="20">&nbsp;상세내용</h5>
	       	<br>
	       	<div id="date">
	       	<!-- 시작일 -->
	       		<c:if test="${empty dto.getProject_start()}">
	       			<input id="start" class="btn btn-primary" type="button" value="시작일 선택">
	       		</c:if>
	       		<c:if test="${!empty dto.getProject_start() }">
	      			<input id="start" class="btn btn-primary" type="button" value="${dto.getProject_start().substring(0,10) }">
	      		</c:if>
	        	<input id="project_start" type="text" class="btn btn-primary" value="${dto.getProject_start().substring(0,10) }">
	        	
	      <!-- 상세 내용 -->
	      <c:if test="${empty dto.getProject_comment() }">
        	<div id="control1">
		         <textarea class="textarea" id="comment1" cols="80%" rows="2" placeholder="작업 상세내용을 추가해 주세요." onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
		         <p id="insert_comment"></p>
		         <input id="child1" type="button" class="btn btn-primary" value="저장">		     
	      	</div>
	      </c:if>
	      
	      <c:if test="${!empty dto.getProject_comment() }">
	      	<div id="control1_1">
		         <p id="project_comment">${dto.getProject_comment() }</p>
		         <textarea class="textarea" id="comment1_1" cols="80%" rows="2"onkeydown="resize(this)" onkeyup="resize(this)">${dto.getProject_comment() }</textarea>      
		         <input id="child1_1" type="button" class="btn btn-primary" value="수정하기">
	      	</div>
	      </c:if>
	      					
	         <!-- 마감일 -->
	         	<input id="project_end" type="text" class="btn btn-primary" value="${dto.getProject_end().substring(0,10) }">
	        	<input id="end" class="btn btn-primary" type="button" value="${dto.getProject_end().substring(0,10) }">
	        </div>
	      </div>
					
	      
	      <div class="modal-body">
	         <!-- 이동 -->
			  <select id="move" class="btn btn-primary" name="project_taker">
			  <c:forEach items="${status}" var="sdto">
			  		<c:if test="${dto.getProject_status() == sdto.getStatus_no() }">
				 		<option value="${sdto.getStatus_no()}">${sdto.getStatus_name() }</option>
				 	</c:if>
				</c:forEach>
				 <c:forEach items="${status}" var="sdto">
				 	<c:if test="${dto.getProject_status() != sdto.getStatus_no() }">
				 		<option value="${sdto.getStatus_no()}">${sdto.getStatus_name() }</option>
				 	</c:if>
				 </c:forEach>
			  </select>
	      	 <h5 class="modal-title"><img src="resources/image/project_comment.png" width="20" height="20">&nbsp;코멘트</h5>
	      	 <br>
				      <!-- 삭제 -->
				         <button id="delete" type="button" class="btn btn-primary" onclick="if(confirm('정말로 프로젝트를 삭제하시겠습니까??')){
																											location.href='<%=request.getContextPath()%>/project_delete.do?num=${dto.getProject_no() }'
																											}else{ruturn;}">프로젝트 삭제</button>
	         <img class="img" src="resources/image/project_man.png" width="35" height="30">
			  <!-- 댓글 -->
         <div id="control2">
	         <textarea class="textarea" id="comment2"  cols="80%" rows="2" onkeydown="resize(this)" onkeyup="resize(this)"></textarea><br>
	         <input id="child2" type="button" class="btn btn-primary" value="저장">
	     </div>
	     	
	      </div>
	    </div>
	        
		
	    </div>
	    
	    <div id="a2" class="hidden">
		    <div class="popover-heading1">
		    	<c:forEach items="${mlist }" var="memlist">
		    		<c:if test="${memlist.getMem_name() == dto.getProject_taker() }">
		    				<img id="member" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
		    				<input type="hidden" id="heading1_mem" value="${memlist.getMem_name() }">
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-body1">
		    	<a href="#">회원 정보 보기</a>
		    	<hr>
		    	<a href="#" id="except1">
		    		프로젝트 제외하기
		    	</a>
		    </div>
		    
		    <div class="popover-heading2">
		    	<c:forEach items="${mlist }" var="memlist">
		    		<c:if test="${memlist.getMem_name() == dto.getProject_taker2() }">
		    				<img id="member" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
		    				<input type="hidden" id="heading2_mem" value="${memlist.getMem_name() }">
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-body2">
		    	<a href="#">회원 정보 보기</a>
		    	<hr>
		    	<a href="#" id="except2">
		    		프로젝트 제외하기
		    	</a>
		    </div>
		    
		    <div class="popover-heading3">
		    	<c:forEach items="${mlist }" var="memlist">
		    		<c:if test="${memlist.getMem_name() == dto.getProject_taker3() }">
		    				<img id="member" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
		    				<input type="hidden" id="heading3_mem" value="${memlist.getMem_name() }">
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-body3">
		    	<a href="#">회원 정보 보기</a>
		    	<hr>
		    	<a href="#" id="except3">
		    		프로젝트 제외하기
		    	</a>
		    </div>
		    
		    <div class="popover-heading4">
		    	<c:forEach items="${mlist }" var="memlist">
		    		<c:if test="${memlist.getMem_name() == dto.getProject_taker4() }">
		    				<img id="member" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
		    				<input type="hidden" id="heading4_mem" value="${memlist.getMem_name() }">
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-body4">
		    	<a href="#">회원 정보 보기</a>
		    	<hr>
		    	<a href="#" id="except4">
		    		프로젝트 제외하기
		    	</a>
		    </div>
		    
		    <div class="popover-heading5">
		    	<c:forEach items="${mlist }" var="memlist">
		    		<c:if test="${memlist.getMem_name() == dto.getProject_taker5() }">
		    				<img id="member" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
		    				<input type="hidden" id="heading5_mem" value="${memlist.getMem_name() }">
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-body5">
		    	<a href="#">회원 정보 보기</a>
		    	<hr>
		    	<a href="#" id="except5">
		    		프로젝트 제외하기
		    	</a>
		    </div>
		</div>
</body>
</html>