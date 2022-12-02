<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	/* 자동으로 TextArea 크기 늘리기 */
	function resize(obj) {
		  obj.style.height = "2px";
		  obj.style.height = (12+obj.scrollHeight)+"px";
		}
	
	/* popover */
	const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
	const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl))
	
	$(function(){
		
		/* 코멘트 창 클릭시 활성화 */
		$(".hide").hide();
		$("#child").hide();
		$("#comment").click(function(){
			$("#control").css({'border':'1px solid gray'});
			$("#comment").css({'border-style':'none'});
			$("#comment").css({})
			$("#child").show(100);
		})
		
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
		
		/*  */
		$("select").change(function(){
			let member = ($(this).val());
			let project_no = $(".project_no").val();
			console.log(member);
			console.log();
			if(confirm(member+"님을 추가하시겠습니까??")){
				$.ajax({
					type : "post",
					url : "project_memberinsert.do",
					data : {project_member : member,
							project_no : project_no
							},
					datatype : "xml",
					success : function(data){
						
					},
					error : function(){
						alert("에러가 발생하였습니다.")
					}
				})
			}else{
				$(".hide").hide();
			};
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
	 
</style>
</head>
<body>
	<c:set var="dto" value="${cont }"/>
	<c:set var="main" value="${main }"/>
	<c:set var="mlist" value="${mlist }"/>
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
						&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="btn btn-secondary" value=${memlist.getMem_name() }>
					</c:if>
				</c:forEach>
							<span class="hide">
								<select id="why" class="btn btn-secondary" name="project_taker">
									<option value="none">:::선택::::</option>
									<c:forEach items="${mlist }" var="memlist">
										<c:if test="${dto.getProject_taker() != memlist.getMem_name() }">
											<option value="${memlist.getMem_name() }">${memlist.getMem_name() }</option>
										</c:if>
									</c:forEach>
								</select>
							</span>
						<a id="asd" class="btn btn-secondary"><img src="resources/image/project_taker.png" width="20" height="20"></a>
	      </div>
	      <div class="modal-body">
	        <h5 class="modal-title"><img src="resources/image/project_description.png" width="20" height="20">&nbsp;상세내용</h5>
	        <br>
	         <textarea class="textarea" id="message-text" cols="80%" placeholder="작업 상세내용을 추가해 주세요." onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
	      </div>
	      <div class="modal-body">
	      	 <h5 class="modal-title"><img src="resources/image/project_comment.png" width="20" height="20">&nbsp;코멘트</h5>
	      	 <br>
	         <img class="img" src="resources/image/project_man.png" width="35" height="30">
         <div id="control">
	         <textarea class="textarea" id="comment"  cols="80%" rows="1" onkeydown="resize(this)" onkeyup="resize(this)"></textarea><br>
	         <input id="child" type="button" class="btn btn-primary" value="저장">
         </div>
	      </div>
	      <div id="parent" class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save</button>
	      </div>
	    </div>
	  </div>
</body>
</html>