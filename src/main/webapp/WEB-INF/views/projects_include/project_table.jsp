<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	$(function(){
		$(".main_select").hide();
		$(".status").hide();
		$(".project_create1").hide();
		$(".project_create2").hide();
		$(".project_create3").hide();
		$(".submit").hide();
		$(".project_btn").click(function(){
			$(".project_btn").hide();
			$(".project_create1").show();
			$(".project_create2").show();
			$(".project_create3").show();
			$(".submit").show();
			let i = 0;
			table = "";
			table1 = "";
			table2 = "";
			table3 = "";
			table += $(".main_select").show();
			table1 += "<input class='form-control' placeholder='프로젝트 명' aria-label='Username' name='project_name'>";
			table2 += "<input type='date' class='form-control' aria-label='Username' name='project_end'>";
			table3 += "<input class='form-control' placeholder='멤버' aria-label='Username' name='project_taker'>";
			table += $(".status").show();
			$(".project_create1").append(table1);
			$(".project_create2").append(table2);
			$(".project_create3").append(table3);
		})
		$(".project_check").click(function(){
			$(".submit").hide();
			$(".project_btn").show();
		})	
	})
</script>
<style type="text/css">
	.submit{
		width:50px; height:50px;
		background-image: url('resources/image/Project_check.png');
		background-repeat: no-repeat;
		background-color:white;
		background-size: 50px;
		background-position: 10px left;
		border-style: none;
	}
}
</style>
</head>
<body>
	<c:set var="list" value="${list }"/>
	<c:set var="main" value="${main }"/>
	<c:set var="status" value="${status }"/>
	<form method="post" action="<%=request.getContextPath()%>/project_insert.do">
		<table class="table table-striped" id="project_create">
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
					
					<td>${dto.getProject_name() }</td>
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
					<td class="project_create3">
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
				<tr>
					<td colspan="5" align="center">
						<input class="submit" type="submit" value="">
						<a href="#" class="project_btn"><img src="resources/image/Project_btn.png" width="50" height="50"></a>
					</td>
				</tr>
		</table>
	</form>
</body>
</html>