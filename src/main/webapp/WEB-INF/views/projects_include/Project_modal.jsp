<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<link href="resources/css/project_modal.css" rel="stylesheet"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="resources/script/project_modal.js"></script>
<script type="text/javascript">
/* 자동으로 TextArea 크기 늘리기 */
function resize(obj) {
	  obj.style.height = "2px";
	  obj.style.height = (12+obj.scrollHeight)+"px";
	}

$(function(){
	$(".hide").hide();
	$("#child1").hide();
	$("#child2").hide();
	$("#project_start").hide();
	$("#project_end").hide();
	$(".hidden").hide();
	$("#control1_1").hide();
	
	/* 상세내용 div 클릭시 활성화 */
	$("#comment1").click(function(){
		$("#control1").css({'border':'1px solid gray'});
		$("#comment1").css({'border-style':'none'});
		$("#child1").show(100);
		
	});
	
	/* 상세내용 추가하기 */
	$("#child1").click(function(){
		let project_comment = $("#comment1").val();
		let project_no = $(".project_no").val();
		$.ajax({
			type : "post",
			url : "project_InsertComment.do",
			data : {project_comment : project_comment,
					project_no : project_no
					},
			datatype : "text",
			success : function(){
				alert('데이터 통신 에러 아님');
				$("project_comment").append(project_comment);
				
			},
			error : function(request,status,error){
				alert('데이터 통신 에러');
			}
		})
	})
	
	/* 상세내용 비활성화  */
	$(document).mouseup(function (e){ 
	    var container = $("#control1")
	    if(container.has(e.target).length == 0){ 
	    	$("#comment1").css({'border':'1px solid gray'});
	    	$("#control1").css({'border-color':'lightgray'})
			$("#control1").css({'border-style':'none'});
			$("#child1").hide(100); 
	    }
	});
	
	/* 코멘트창 클릭시 활성화 */
	$("#comment2").click(function(){
		$("#control2").css({'border':'1px solid gray'});
		$("#comment2").css({'border-style':'none'});
		$("#child2").show(100);
		
	});
	
	/* 코멘트창 비활성화  */
	$(document).mouseup(function (e){ 
	    var container = $("#control2")
	    if(container.has(e.target).length == 0){ 
	    	$("#comment2").css({'border':'1px solid gray'});
	    	$("#control2").css({'border-color':'lightgray'})
			$("#control2").css({'border-style':'none'});
			$("#child2").hide(100); 
	    }
	});
	
	/* select창 숨기기 */
	$("#asd").click(function(){
		$(".hide").show();
	})
	$(document).mouseup(function (e){
	    var container = $("#member")
	    if(container.has(e.target).length == 0){ 
	    	$(".hide").hide();
	    }
	});
	
	/* 모달창 닫으면 리로딩 */
	$(".btn-close").click(function(){
		$(".hide").hide();
		location.reload();
	});
	
	/* 프로젝트 status 이동 */
	$("#move").change(function(){
		let project_status = $(this).val();
		let project_no = $(".project_no").val();
		if(confirm(project_status+"로 이동시키시겠습니까??")){
			$.ajax({
				type : "post",
				url : "project_move.do",
				data : {project_status : project_status,
						project_no : project_no
						},
				datatype : "text",
				success : function(){
					alert('변경 완료!')
				},
				error : function(request,status,error){
					alert('데이터 통신 에러')
				}
			})
		}else{
			$(".hide").hide();
		};
	});
	
	/* 프로젝트 멤버 추가하기 */
	$("#project_taker").change(function(){
		let member = ($(this).val());
		let project_no = $(".project_no").val();
		if(confirm(member+"님을 추가하시겠습니까??")){
			$.ajax({
				type : "post",
				url : "project_memberinsert.do",
				data : {project_taker : member,
						project_no : project_no
						},
				datatype : "text",
				success : function(){
					table = "";
					table += "<a id='taker5' href='#' class='btn btn-secondary' tabindex='0' data-toggle='popover' data-trigger='focus' data-popover-content='#a2'>"+member+"</a>"
					$(".project_taker").append(table);
					$(".hide").hide();
				},
				error : function(request,status,error){
					alert('데이터 통신 에러')
				}
			})
		}else{
			$(".hide").hide();
		};
	});

	  
	/* 프로젝트 마감일 수정 */
	$("#end").click(function(){
		$("#end").hide();
		$("#project_end").show();
		 $( "#project_end" ).datepicker({
		      dateFormat: "yy-mm-dd"
		    });
		 $("#project_end").change(function(){
				let project_end = ($(this).val());
				let project_no = $(".project_no").val();
				if(confirm(project_end+"로 마감일을 변경하시겠습니까??")){
					$.ajax({
						type : "post",
						url : "project_Updateend.do",
						data : {project_end : project_end,
								project_no : project_no
								},
						datatype : "text",
						success : function(){
							alert('변경 완료!');
						},
						error : function(request,status,error){
							alert('데이터 통신 에러');
						}
					})
				}else{
					$(".hide").hide();
				};
			 })
	})
	
	/* 프로젝트 시작일 수정 */
	$("#start").click(function(){
		$("#start").hide();
		$("#project_start").show();
		 $( "#project_start" ).datepicker({
		      dateFormat: "yy-mm-dd"
		    });
		 $("#project_start").change(function(){
			let project_start = ($(this).val());
			let project_no = $(".project_no").val();
			if(confirm(project_start+"로 시작일을 변경하시겠습니까??")){
				$.ajax({
					type : "post",
					url : "project_UpdateStart.do",
					data : {project_start : project_start,
							project_no : project_no
							},
					datatype : "text",
					success : function(){
						alert('변경 완료!');
					},
					error : function(request,status,error){
						alert('데이터 통신 에러');
					}
				})
			}else{
				$(".hide").hide();
			};
		 })
	})
	
	/* 멤버 5인 이상 추가 불가능 */
	if($("#taker5").val() != null){
		$("#asd").hide();
		$("#asd").click(function(){
			alert("멤버를 추가할 수 없습니다.");
		})
	}
	
	/* popover창 띄우기 */
	$(function(){
	    $("#taker1").popover({
	        html : true,
	        content: function() {
	          var content = $(this).attr("data-popover-content");
	          return $(content).children(".popover-body").html();
	        },
	        title: function() {
	          var title = $(this).attr("data-popover-content");
	          return $(title).children(".popover-heading1").html();
	        }
	    });
	    $("#taker2").popover({
	        html : true,
	        content: function() {
	          var content = $(this).attr("data-popover-content");
	          return $(content).children(".popover-body").html();
	        },
	        title: function() {
	          var title = $(this).attr("data-popover-content");
	          return $(title).children(".popover-heading2").html();
	        }
	    });
	    $("#taker3").popover({
	        html : true,
	        content: function() {
	          var content = $(this).attr("data-popover-content");
	          return $(content).children(".popover-body").html();
	        },
	        title: function() {
	          var title = $(this).attr("data-popover-content");
	          return $(title).children(".popover-heading3").html();
	        }
	    });
	    $("#taker4").popover({
	        html : true,
	        content: function() {
	          var content = $(this).attr("data-popover-content");
	          return $(content).children(".popover-body").html();
	        },
	        title: function() {
	          var title = $(this).attr("data-popover-content");
	          return $(title).children(".popover-heading4").html();
	        }
	    });
	    $("#taker5").popover({
	        html : true,
	        content: function() {
	          var content = $(this).attr("data-popover-content");
	          return $(content).children(".popover-body").html();
	        },
	        title: function() {
	          var title = $(this).attr("data-popover-content");
	          return $(title).children(".popover-heading5").html();
	        }
	    });
	});
})
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
	 #control1,#control2{
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
				<c:forEach items="${mlist }" var="memlist">
					<c:if test="${dto.getProject_taker() == memlist.getMem_name() }">
					<div class="project_taker">
						&nbsp;&nbsp;&nbsp;&nbsp;<a id="taker1" href="#" class="btn btn-secondary" tabindex="0" data-toggle="popover" data-trigger="focus" data-popover-content="#a2">${dto.getProject_taker() }</a>
						<c:if test="${!empty dto.getProject_taker2() }">
							<a id="taker2" href="#" class="btn btn-secondary" tabindex="0" data-toggle="popover" data-trigger="focus" data-popover-content="#a2">${dto.getProject_taker2() }</a>
						</c:if>
						<c:if test="${!empty dto.getProject_taker3() }">
							<a id="taker3" href="#" class="btn btn-secondary" tabindex="0" data-toggle="popover" data-trigger="focus" data-popover-content="#a2">${dto.getProject_taker3() }</a>
						</c:if>
						<c:if test="${!empty dto.getProject_taker4() }">
							<a id="taker4" href="#" class="btn btn-secondary" tabindex="0" data-toggle="popover" data-trigger="focus" data-popover-content="#a2">${dto.getProject_taker4() }</a>
						</c:if>
						<c:if test="${!empty dto.getProject_taker5() }">
							<a id="taker5" href="#" class="btn btn-secondary" tabindex="0" data-toggle="popover" data-trigger="focus" data-popover-content="#a2">${dto.getProject_taker5() }</a>
						</c:if>
					</div>
					</c:if>
				</c:forEach>
				
					<span class="hide">
						<select id="project_taker" class="btn btn-secondary" name="project_taker">
							<option value="none">:::선택::::</option>
							<c:forEach items="${mlist }" var="memlist">
								<c:if test="${dto.getProject_taker() != memlist.getMem_name() }">
									<c:if test="${dto.getProject_taker2() != memlist.getMem_name() }">
										<c:if test="${dto.getProject_taker3() != memlist.getMem_name() }">
											<c:if test="${dto.getProject_taker4() != memlist.getMem_name() }">
												<c:if test="${dto.getProject_taker5() != memlist.getMem_name() }">
													<option value="${memlist.getMem_name() }">${memlist.getMem_name() }</option>	
												</c:if>
											</c:if>
										</c:if>
									</c:if>
								</c:if>
							</c:forEach>
						</select>
					</span>
			  <a id="asd" class="btn btn-secondary"><img src="resources/image/project_taker.png" width="20" height="20"></a>
	      </div>

	      <div class="modal-body">
	        <h5 class="modal-title"><img src="resources/image/project_description.png" width="20" height="20">&nbsp;상세내용</h5>
	       	<br>
	       	<div id="date">
	       	<!-- 시작일 -->
	      		<input id="start" class="btn btn-primary" type="button" value="${dto.getProject_start().substring(0,10) }">
	        	<input id="project_start" type="text" class="btn btn-primary" value="${dto.getProject_start().substring(0,10) }">
	        	
	      <!-- 상세 내용 -->
        	<div id="control1">
		         <textarea class="textarea" id="comment1" cols="80%" rows="2" placeholder="작업 상세내용을 추가해 주세요." onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
		         <input id="child1" type="button" class="btn btn-primary" value="저장">		     
	      	</div>
	      	<div id="control1_1">
		         <span id="project_comment"></span>		         
		         <input id="child1" type="button" class="btn btn-primary" value="저장">		     
	      	</div>
	      					
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
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-heading2">
		    	<c:forEach items="${mlist }" var="memlist">
		    		<c:if test="${memlist.getMem_name() == dto.getProject_taker2() }">
		    				<img id="member" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-heading3">
		    	<c:forEach items="${mlist }" var="memlist">
		    		<c:if test="${memlist.getMem_name() == dto.getProject_taker3() }">
		    				<img id="member" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-heading4">
		    	<c:forEach items="${mlist }" var="memlist">
		    		<c:if test="${memlist.getMem_name() == dto.getProject_taker4() }">
		    				<img id="member" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-heading5">
		    	<c:forEach items="${mlist }" var="memlist">
		    		<c:if test="${memlist.getMem_name() == dto.getProject_taker5() }">
		    				<img id="member" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-body">
		    	<a href="#">회원 정보 보기</a>
		    	<hr>
		    	<a href="#">프로젝트 제외하기</a>
		    </div>
		</div>
</body>
</html>