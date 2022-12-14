<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	
	$(function(){
		$(".main_select").hide();
		$(".status").hide();
		$(".member").hide();
		$(".project_create1").hide();
		$(".project_create2").hide();
		$(".submit").hide();
		
		/* 프로젝트 추가 창 닫기 */
		$(document).mouseup(function (e){
		    var container = $("#insert_projects_tr,.project_create")
		    if(container.has(e.target).length == 0){ 
		    	$(".project_create").hide(1000);
		    	$(".submit").hide();
				$(".project_btn").show();
		    }
		});
		
		/* 프로젝트 목록 생성 함수 */
		$(".project_btn").click(function(){
			if($("input[name='project_name']").val() != ""){
				$(".project_btn").hide();
				$(".project_create1").show();
				$(".project_create2").show();
				$(".submit").show();
				let i = 0;
				table = "";
				table1 = "";
				table2 = "";
				table += $(".main_select").show();
				table1 += "<input class='form-control' placeholder='프로젝트 명' aria-label='Username' name='project_name'>";
				table2 += "<input type='date' class='form-control' aria-label='Username' name='project_end'>";
				table += $(".status").show();
				table += $(".member").show();
				$(".project_create1").append(table1);
				$(".project_create2").append(table2);
			}else{
				$(".project_create").show(1000);
			}
			
		})
		
		/* '+'아이콘 클릭시 'check'아이콘 변경 */
		$(".project_check").click(function(){
			$(".submit").hide();
			$(".project_btn").show();
		})
		
		/* 프로젝트 이름 클릭시 상세보기 모달 창 생성 */
		$(".project_name").click(function(){
			let href = ($(this).attr("id"));
			let href1 = "<%=request.getContextPath()%>/content.do?num="+href;
 			let project_name = $(".project_name").text();
 			console.log($(this).text())
			 $("#Project_content").load(href1, function() {
		            $("#Project_content").modal("show");
		      });
 		})
 		
 		$(".submit").click(function(){
 			console.log("project_main : "+$("select[name='project_main']").val());
 			
 			if($("select[name='project_main']").val() == "none"){
 				alert("메인 프로젝트를 선택해 주세요.")
 			}else if($("select[name='project_status']").val() == "none"){
 				alert("프로젝트의 상태를 선택해 주세요.")
 			}else if($("select[name='project_taker']").val() == "none"){
 				alert("프로젝트 멤버를 선택해 주세요.")
 			}else{
 				$("form").submit();
 			}
 		})
	})
</script>
<style type="text/css">
	
	.project_name:hover{
		cursor:pointer;
		font-weight: bold;
	}
	#project_create{
		max-width: 75vw;
		align-self: center;
	}
	table{
		border-radius: 5px;
	}
	.paging_btn:hover{
		background-color:#C2F347;
		color:white;
 	}
 	.paging_btn{
		color:green;
	 }
	.insert_projects_btn{
		background-color:#7BE66D;
		border-style: none;
		width:140px;
		margin-right: 10.5vw;
	}
	.insert_projects_btn:hover{
		background-color:#C2F347;
	}
</style>
</head>
<body>
	<c:set var="list" value="${list }"/>
	<c:set var="main" value="${main }"/>
	<c:set var="status" value="${status }"/>
	<c:set var="mlist" value="${mlist }"/>
	<c:set var="paging" value="${Paging }" />
	<form id="project_create" method="post" action="<%=request.getContextPath()%>/project_insert.do">
		<table class="table table-striped" >
			<tr>
				<th>Main</th>
				<th>Project</th>
				<th>Due Date</th>
				<th>Member</th>
				<th>Status</th>
			</tr>
			<c:forEach items="${list }" var="dto">
				<tr>
						<c:forEach items="${main }" var="mdto">
							<c:if test="${mdto.getMain_no() == dto.getProject_main() }">
								<td><b>${mdto.getMain_name() }</b></td>
							</c:if>
						</c:forEach>
					<td class="project_name" id="${dto.getProject_no() }">${dto.getProject_name() }</td>
					<td>${dto.getProject_end().substring(0,10) }</td>
					<td>${dto.getProject_taker() }</td>
					<td>
						<c:forEach items="${status }" var="sdto">
							<c:if test="${dto.getProject_status() == sdto.getStatus_no() }">${sdto.getStatus_name() }</c:if>
						</c:forEach>
					</td>
				</tr>
			</c:forEach>
				<tr class="project_create">
					<td class="main_select">
						<select name="project_main" class="form-select" aria-label="Default select example">
							<option value="none">:::메인 프로젝트:::</option>
							<c:forEach items="${main }" var="mdto">
								<option value="${mdto.getMain_no() }">${mdto.getMain_name() }</option>
							</c:forEach> 
						</select>
					</td>
					<td class="project_create1">
					</td>
					<td class="project_create2">
					</td>
					<td class="member">
						<select name="project_taker" class="form-select" aria-label="Default select example">
							<option value="none">:::선택:::</option>
							<c:forEach items="${mlist }" var="memlist">
								<option value=${memlist.getMem_name() }>${memlist.getMem_name() }</option>
							</c:forEach>
						</select>
					</td>
					<td class="status">
						<select name="project_status" class="form-select" aria-label="Default select example">
							<option value="none">:::선택:::</option>
							<c:forEach items="${status }" var="sdto">
								<option value=${sdto.getStatus_no() }>${sdto.getStatus_name() }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr id="insert_projects_tr">
					<td colspan="5" align="center">
						<input class="submit btn btn-primary insert_projects_btn" style="background-color: #C2F347; color:white;" type="button" value="추가하기">
						<a href="#" class="project_btn insert_projects_a"><input class="btn btn-primary insert_projects_btn" style="background-color: #C2F347; color:white;" type="button" value="추가하기"></a>
					</td>
				</tr>
		</table>
	</form>
	<br>
	<div class="paging_div">
	<nav class="paging">
		<ul class="pagination">
			<li class="page-item"><a class="page-link paging_btn"
				href="project_control.do?page=1">First</a></li>
			<c:if test="${paging.getPage() == 1 }">
		    <li>
		      <a class="page-link paging_btn" 
		      		href="project_control.do?page=1">Previous</a>
		    </li>
		    </c:if>
		    <c:if test="${paging.getPage() != 1 }">
		    <li>
		      <a class="page-link paging_btn" 
		      		href="project_control.do?page=${paging.getPage() - 1 }">Previous</a>
		    </li>
		    </c:if>
			<c:forEach begin="${paging.getStartBlock() }" end="${paging.getEndBlock() }" var="i">

				<c:if test="${i == paging.getPage() }">
					<li class="page-item active" aria-current="page"><a
						class="page-link paging_btn" style="background-color: #C2F347; border-style:none;"  href="project_control.do?page=${i }">${i }</a></li>
				</c:if>

				<c:if test="${i != paging.getPage() }">
					<li class="page-item"><a class="page-link paging_btn" 
						href="project_control.do?page=${i }">${i }</a></li>
				</c:if>
			</c:forEach>

			<c:if test="${paging.getEndBlock() < paging.getAllPage() }">
				<li class="page-item"><a class="page-link paging_btn"
					href="project_control.do?page=${paging.getEndBlock() + 1 }">Next</a></li>
				<li class="page-item"><a class="page-link paging_btn"
					href="project_control.do?page=${paging.getAllPage() }&">End</a></li>
			</c:if>
		</ul>
	</nav>
	</div>
	<div id="Project_content" class="modal" tabindex="-1">
	</div>
</body>
</html>