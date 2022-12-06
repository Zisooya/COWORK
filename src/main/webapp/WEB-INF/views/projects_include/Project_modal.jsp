<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script type="text/javascript">
	/* 자동으로 TextArea 크기 늘리기 */
	function resize(obj) {
		  obj.style.height = "2px";
		  obj.style.height = (12+obj.scrollHeight)+"px";
		}
	
	$(function(){
		$(".hide").hide();
		$("#child").hide();
		$("#project_end").hide();
		$("#project_start").hide();
		
		/* 코멘트 창 클릭시 활성화 */
		$("#comment").click(function(){
			$("#control").css({'border':'1px solid gray'});
			$("#comment").css({'border-style':'none'});
			$("#comment").css({})
			$("#child").show(100);
			
		});
		
		/* 다른 곳 클릭 하면 코멘트 창 비활성화  */
		$(document).mouseup(function (e){ 
		    var container = $("#control")
		    if(container.has(e.target).length == 0){ 
		    	$("#comment").css({'border':'1px solid gray'});
		    	$("#control").css({'border-color':'lightgray'})
				$("#control").css({'border-style':'none'});
				$("#child").hide(100); 
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
		
		/* 프로젝트 멤버 추가하기 */
		$("#project_taker").change(function(){
			let member = ($(this).val());
			let project_no = $(".project_no").val();
			console.log(member);
			console.log();
			if(confirm(member+"님을 추가하시겠습니까??")){
				$.ajax({
					type : "post",
					url : "<%=request.getContextPath()%>/project_memberinsert.do",
					data : {project_taker : member,
							project_no : project_no
							},
					datatype : "text",
					success : function(){
					},
					error : function(request,status,error){
						table = "";
						table += "<input type='button' class='btn btn-secondary' value="+member+">&nbsp;"
						$(".project_taker").append(table);
						$(".hide").hide();
					}
				})
			}else{
				$(".hide").hide();
			};
		});
		   
		$("#project_end_btn").click(function(){
			
			$("#project_end_btn").hide();
			$("#project_end").show();
			 $( "#project_end" ).datepicker({
			      dateFormat: "yy-mm-dd"
			    });
		})
		$("#project_start_btn").click(function(){
			
			$("#project_start_btn").hide();
			$("#project_start").show();
			 $( "#project_start" ).datepicker({
			      dateFormat: "yy-mm-dd"
			    });
		})
		
		if($("#project_taker5").val() != null){
			$("#asd").hide();
			$("#asd").click(function(){
				alert("멤버를 추가할 수 없습니다.");
			})
		}
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
	 #control{
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
	 #delete,#move,{
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
			<img class="img" src="resources/image/project_member.jpg" width="35" height="30">Members<br>
				<c:forEach items="${mlist }" var="memlist">
					<c:if test="${dto.getProject_taker() == memlist.getMem_name() }">
					<div class="project_taker">
						&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="btn btn-secondary" value=${memlist.getMem_name() } data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
						
						<c:if test="${!empty dto.getProject_taker2() }">
							<input type="button" class="btn btn-secondary" value=${dto.getProject_taker2() } data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
						</c:if>
						<c:if test="${!empty dto.getProject_taker3() }">
							<input type="button" class="btn btn-secondary" value=${dto.getProject_taker3() } data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
						</c:if>
						<c:if test="${!empty dto.getProject_taker4() }">
							<input type="button" class="btn btn-secondary" value=${dto.getProject_taker4() } data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
						</c:if>
						<c:if test="${!empty dto.getProject_taker5() }">
							<input id="project_taker5" type="button" class="btn btn-secondary" value=${dto.getProject_taker5() } data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
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
		      <button id="delete" type="button" class="btn btn-primary" onclick="if(confirm('정말로 프로젝트를 삭제하시겠습니까??')){
																									location.href='<%=request.getContextPath()%>/project_delete.do?num=${dto.getProject_no() }'
																									}else{ruturn;}">프로젝트 삭제</button><br>
			  <br><select id="move" class="btn btn-primary" name="project_taker">
				 <option value="none"> : : : : 이동 : : : : </option>
				 <c:forEach items="${status}" var="sdto">
				 	<c:if test="${dto.getProject_status() != sdto.getStatus_no() }">
				 		<option value="${sdto.getStatus_no()}">${sdto.getStatus_name() }</option>
				 	</c:if>
				 </c:forEach>
			  </select>
			  
	      </div>
	      <div class="modal-body">
	      <br>
	      	<h5 class="modal-title"><img src="resources/image/project_description.png" width="20" height="20">&nbsp;기간</h5>
	      		&nbsp;&nbsp;&nbsp;&nbsp;<input id="project_start_btn" class="btn btn-secondary" type="button" value="${dto.getProject_start().substring(0,10) }">
	        	<input type="text" class="btn btn-secondary" id="project_start" value="${dto.getProject_start().substring(0,10) }">
	        	~
	         	<input type="text" class="btn btn-secondary" id="project_end" value="${dto.getProject_end().substring(0,10) }">
	        	<input id="project_end_btn" class="btn btn-secondary" type="button" value="${dto.getProject_end().substring(0,10) }">
	      </div>
	      <div class="modal-body">
	        <h5 class="modal-title"><img src="resources/image/project_description.png" width="20" height="20">&nbsp;상세내용</h5>
	       	<br>
	         <textarea class="textarea" id="message-text" cols="80%" rows="2" placeholder="작업 상세내용을 추가해 주세요." onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
	      </div>
	      <div class="modal-body">
	      	 <h5 class="modal-title"><img src="resources/image/project_comment.png" width="20" height="20">&nbsp;코멘트</h5>
	      	 <br>
	         <img class="img" src="resources/image/project_man.png" width="35" height="30">
         <div id="control">
	         <textarea class="textarea" id="comment"  cols="80%" rows="2" onkeydown="resize(this)" onkeyup="resize(this)"></textarea><br>
	         <input id="child" type="button" class="btn btn-primary" value="저장">
	     
	      </div>
	      </div>
	    </div>
	        <button type="button" class="btn btn-primary">Save</button>
	    </div>
</body>
</html>