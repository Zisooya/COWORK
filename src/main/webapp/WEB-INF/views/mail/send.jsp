<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="${path}/resources/css/address.css" rel="stylesheet"/>
<link href="${path}/resources/css/include.css" rel="stylesheet"/>
<title>메일발송</title>
<link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/mail_css_js/vendors/styles/core.css?">
<link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/mail_css_js/vendors/styles/icon-font.min.css?">
<link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/mail_css_js/plugins/datatables/css/dataTables.bootstrap4.min.css?">
<link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/mail_css_js/plugins/datatables/css/responsive.bootstrap4.min.css?">
<link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/mail_css_js/vendors/styles/style.css?">
<link rel="stylesheet" type="text/css" href="${ pageContext.servletContext.contextPath }/resources/mail_css_js/plugins/sweetalert2/sweetalert2.css?">
<style type="text/css">
.mailReceiver {
	display: flex;
	flex-flow: row wrap;
	align-items: center;
	width: 100%;
	margin-bottom: 0;
}
label {
	font-weight: bold;
}
.selectReceiver{
	overflow: auto;
	min-height:500px;
}
</style>
</head>
<body>
	<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			<div class="min-height-200px">
				<div class="page-header">
					<div class="row">
						<div class="col-md-6 col-sm-12">
							<div class="title">
								<h4>메일전송</h4>
							</div>
							<nav aria-label="breadcrumb" role="navigation">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="#">홈</a></li>
									<li class="breadcrumb-item active" aria-current="page">메일 작성</li>
								</ol>
							</nav>
						</div>
					</div>
				</div>
	<!-- 메일 폼 시작 -->
	<div class="pd-20 card-box mb-30">
	<form action="" method="post" enctype="multipart/form-data" id="insertMail">
						<input type="hidden" readonly class="form-control-plaintext" name="mem_id" value="${sessionScope.loginUser.eml_from }">
						
						<div class="form-group">
							<div class="mailReceiver">
								<div class="form-group">
									<input class="form-control" type="text" data-toggle="tooltip" title="주소록에서 선택해 주세요."
										name="receiverName" required="required" placeholder="받는 사람">
									<input type="hidden" name="receiver">
								</div>
								<div class="form-group">
									<button type="button" class="btn btn-primary" data-backdrop="static" data-toggle="modal" data-target="#bd-example-modal-lg"><i class="icon-copy dw dw-agenda"></i> 주소록</button>
								</div>
								<div>
									<div class="custom-control custom-checkbox mb-5">
										<input type="checkbox" class="custom-control-input" id="customCheck1" name="importantFlag" value="1"> 
										<label class="custom-control-label" for="customCheck1">중요 메일</label>
									</div>
								</div>
								<br>
								<input class="form-control" type="text" name="title" required="required" placeholder="메일 제목을 입력해주세요.">
								<br>
								<br>
							</div>
						</div>
						<div class="form-group">
							<input type="file" class="form-control-file form-control height-auto" name="uploadFile">
						</div>

						<div class="form-group">
							<textarea class="textarea_editor form-control border-radius-0" name="content" required="required" placeholder="메일 내용을 입력해주세요."></textarea>
						</div>
						
						<div class="clearfix">
							<div class="pull-right">
								<button type="button" class="btn btn-primary" onclick="sendMail()">메일 전송</button>
							</div>
						</div>
					</form>
				</div>
			<!-- 메일 폼 끝 -->
			<div class="modal fade bs-example-modal-lg" id="bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="myLargeModalLabel">받는 사람 선택</h4>
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						</div>			
						<div class="modal-body">
							<div class="selectReceiver">
								<div class="form-group" id="deptList">
			
									
									<select id="selectDept" class="custom-select col-6">
										<option>부서 선택</option>
										<option value="D1">기획마케팅본부</option>
										<option value="D2">경영지원본부</option>
										<option value="D3">디자인본부</option>
										<option value="D4">개발본부</option>
									</select>
									
						            <button class="btn btn-primary" id="searchEmp">조회</button>
								
								</div>
								
								<div id="empList">
									<table border="1" class="table table-bordered border-primary" id="eList">
										<thead class="table-primary">
											<tr>
												<th></th>
												<th>사번</th>
												<th>이름</th>
												<th>직책</th>
												<th>직급</th>
											</tr>
										</thead>
										<tbody>
											
										</tbody>
									</table>
								</div>
							</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" onclick="selectReceiver()">선택</button>
						</div>
					 </div>
				  </div>
			   </div>
			</div>	
		</div>
	 </div>	
   </div>
<script>
 $(function(){
	$("#searchEmp").click(function(){
		
		var dept_no = $("option:selected").val();
		
		if(dept_no == "부서 선택"){
				
			swal({
                  type: 'error',
                  title: 'error...',
                  text: '부서를 선택해 주세요',
	            })
			return false;
		}
		
		$.ajax({
			url:'<%=request.getContextPath()%>empList.do',
			data:{dept_no:dept_no},
			type:"get",
			success:function(map){
				
				var $tableBody = $("#eList tbody");
				$tableBody.html("");
				
				$.each(map["jrr"], function(i, mem){
					
					var $tr = $("<tr>");
					var $ckTd = $("<td><input type='checkBox' class='checkEmp' name='checkEmp'></td>");
					var $nameTd = $("<td>").text(mem.mem_name);
					var $idTd = $("<td>").text(mem.mem_position);
					var $jobTd = $("<td>").text(mem.mem_rank);
					var $rightTd = $("<td>").text(mem.mem_email);
					
					$tr.append($ckTd);
					$tr.append($nameTd);
					$tr.append($idTd);
					$tr.append($jobTd);
					$tr.append($rightTd);
					
					$tableBody.append($tr);
					
				})
			},
			error:function(e){
				console.log("사원 리스트 조회 ajax 통신 실패");
			}
		
		})
	
	})
	
})

function selectReceiver(){
	var tr = $("input[class=checkEmp]:checked").parent().parent().eq(0);
	var td = tr.children();
	var mem_name = td.eq(1).text();
	var mem_id = td.eq(2).text();
	
	var dept_no = $("option:selected").val();
	
	if(dept_no == "부서 선택"){
			
		swal(
               {
                   type: 'error',
                   title: 'error...',
                   text: '부서를 선택해 주세요',
               }
           )
		return false;
		
	}else if(tr.val() == null){
		swal(
               {
                   type: 'error',
                   title: 'error...',
                   text: '받는 사람을 선택해 주세요',
               }
           )
		return false;
	}
	
	$("input[name=receiverName]").val(mem_name);
	$("input[name=receiver]").val(mem_id);
	$("#bd-example-modal-lg").modal("hide");	
}

function sendMail(){
	var receiver = $("#insertMail input[name=receiverName]");
	var title = $("#insertMail input[name=title]");
	var content = $("#insertMail textarea[name=content]");
	
	if(receiver.val()=="" || receiver.val()==null){
		
	 swal(
               {
                   type: 'error',
                   title: 'error...',
                   text: '받는 사람을 입력해 주세요',
               }
           )
		return false;
	 
	}else if(title.val()=="" || title.val()==null){
		
		swal(
	               {
	                   type: 'error',
	                   title: 'error...',
	                   text: '제목을 입력해 주세요',
	               }
	           )
			return false;
		
	}else if(content.val()=="" || content.val()==null){
	
		swal(
	               {
	                   type: 'error',
	                   title: 'error...',
	                   text: '내용을 입력해 주세요',
	               }
	           )
			return false;
		
	
	}else{
		$("#insertMail").attr("action", "insert.do");
		$("#insertMail").submit();
		return true;
	}
}
</script>
<script src="${ pageContext.servletContext.contextPath }/resources/mail_css_js/plugins/sweetalert2/sweetalert2.all.js"></script>	
<script src="${ pageContext.servletContext.contextPath }/resources/mail_css_js/vendors/scripts/core.js"></script>
<script src="${ pageContext.servletContext.contextPath }/resources/mail_css_js/vendors/scripts/script.min.js"></script>
<script src="${ pageContext.servletContext.contextPath }/resources/mail_css_js/vendors/scripts/process.js"></script>
<script src="${ pageContext.servletContext.contextPath }/resources/mail_css_js/vendors/scripts/layout-settings.js"></script>
<script src="${ pageContext.servletContext.contextPath }/resources/mail_css_js/plugins/datatables/js/jquery.dataTables.min.js"></script>
<script src="${ pageContext.servletContext.contextPath }/resources/mail_css_js/plugins/datatables/js/dataTables.bootstrap4.min.js"></script>
<script src="${ pageContext.servletContext.contextPath }/resources/mail_css_js/plugins/datatables/js/dataTables.responsive.min.js"></script>
<script src="${ pageContext.servletContext.contextPath }/resources/mail_css_js/plugins/datatables/js/responsive.bootstrap4.min.js"></script>
</body>
</html>