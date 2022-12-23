<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta charset="UTF-8">
<title>주소록</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<link href="${path}/resources/css/address.css" rel="stylesheet"/>
<link href="${path}/resources/css/include.css" rel="stylesheet"/>
</head>
<body>
	<div id="grid_container">
	
		<jsp:include page="include.jsp" />
	
	
		<nav id="side">
			<label id="side_label">주소록</label>
			<div id="side_menu" style="overflow-y: auto;">
				<input type="checkbox" id="popup01">
				<label class="modal_label" for="popup01">연락처 추가</label>
				<div>
					<div class="modal_content" style="overflow-y:auto; ">
						<label class="modal_exit" for="popup01"></label>
						<h2>고객 / 거래처 연락처 추가</h2>
						<form id="form" enctype="multipart/form-data" method="post" action="<%=request.getContextPath()%>/add_customer.do">
								<input type="hidden" value="${member.mem_no}" name="mem_no">
								<div class="add_title"><label for="chooseFile"><img id="img" src="${path}/resources/images/로그인_전_프로필.png" width="100px"></img></label><input name="multi_image" type="file" id="chooseFile" accept="image/*"></div>
								<div class="input_box_one">
								<input id="vip_add" type="checkbox" hidden><label for="vip_add"></label>
								<input name="customer_name" type="text" placeholder="이름"> <br>
								</div>
							
							
								<div class="add_title">회사 / 소속</div> 
								<div class="input_box">
									<input name="customer_position" type="text" placeholder="직급"> <input name="customer_rank" type="text" placeholder="직책"> 
									<input name="customer_dept" type="text" placeholder="부서"> <input name="customer_team" type="text" placeholder="소속"> 
								</div>
							
								<div class="add_title">전화번호</div>
								<div class="input_box">
								<select>
									<option>휴대폰</option>
									<option>회사</option>
									<option>집</option>
									<option>회사FAX</option>
									<option>집FAX</option>
									<option>기타</option>
									<option>직접입력</option>
								</select>  
								<input name="customer_phone" type="text" placeholder="전화번호"> <span id="phone_add"></span><br>
								</div>
								
								<div class="add_title">이메일</div>
								<div class="input_box_one">
									<input name="customer_email" type="text" placeholder="이메일">
								</div>
								
								<div class="add_title">편집허용</div>
								<div class="input_box_check">
									<input name="customer_edit" type="checkbox" id="toggle" value="edit_yes" hidden> 
									<label for="toggle" class="toggleSwitch">
									  <span class="toggleButton"></span>
									</label>
								</div>
								
								<div class="add_btn_div">
									<input id="add_customer" class="add_btn" type="button" value="저장">
								</div>
						</form>
						
					</div>
					<label for="popup01"></label>
				</div>
				
				<input type="checkbox" id="popup02">
				<label class="modal_label" for="popup02">구성원 초대</label>	
				<div>
					<div class="modal_content">
						<label class="modal_exit" for="popup02"></label>
						<h2>구성원 초대</h2>
						<div>초대 메일을 받은 구성원이 자신의 계정 정보를 직접 입력하여 COWORK에 가입합니다.</div>
						<input class="email_input" type="text" placeholder="이메일">
						<button id="send_email_btn">초대 메일 보내기</button>
						
					</div>
					<label for="popup02"></label>
				</div>
											
				<br>
				

				<div class="accordion">
					<hr>
					<input type="checkbox" id="addr_menu01">
					<label class="addr_label" for="addr_menu01"><span></span>&nbsp;&nbsp;&nbsp;&nbsp;조직도</label>
					<br>
					<div class="accordion_cb_div">
						<c:set var="deptList" value="${deptList}" />
						<c:set var="myDept_no" value="${myDept_no}" />
						<c:if test="${!empty deptList }">
							<c:forEach items="${deptList }" var="deptDto" varStatus="vs">
								<input type="checkbox" id="accordion_cb_${vs.index }" name="accordion_cb_dept" value="${deptDto.getDept_name() }">
								<label class="people" for="accordion_cb_${vs.index }">${deptDto.getDept_name() }</label>
							</c:forEach>
						</c:if>
					</div>
					<hr>
					<input type="checkbox" id="addr_menu02">
					<label class="addr_label" for="addr_menu02"><span></span>&nbsp;&nbsp;&nbsp;&nbsp;고객 / 거래처</label>					
					<br>
					<div class="accordion_cb_div">
						<input type="checkbox" id="accordion_cb_customer" name="accordion_cb_customer">
						<label class="people" for="accordion_cb_customer">전체 연락처</label>
					</div>	
					<hr>
				</div>
				
				<a class="vip" href="">VIP</a>
				<a class="trash" href="">휴지통</a>
				
			</div>
		</nav>
	
		<article id="content">
				<input id="search_box" type="text" name="keyword" placeholder="이름으로 검색">
				<input id="search_btn" type="button" value="검색" >
			<br>
			<br>
			<button>삭제</button><button>이동</button><button>메일</button><button>메시지</button>
			<br>
			<br>
			<div class="alph">
				<a>전체</a>
				<a>ㄱ</a>
				<a>ㄴ</a>
				<a>ㄷ</a>
				<a>ㄹ</a>
				<a>ㅁ</a>
				<a>ㅂ</a>
				<a>ㅅ</a>
				<a>ㅇ</a>
				<a>ㅈ</a>
				<a>ㅊ</a>
				<a>ㅋ</a>
				<a>ㅌ</a>
				<a>ㅍ</a>
				<a>ㅎ</a>
				<a>A~Z</a>
				<a>기타</a>
			</div>
			
			<hr width="90%" align="left">
			
			<div class="subject">
				<table id="addr_table">
					<tr>
						<th><th>이름</th> <th>직책</th> <th>직급</th>
						<th>부서</th> <th>소속팀</th> <th>이메일</th>
						<th>전화번호</th>			
					</tr>	
					
					<c:set var="myMemList" value="${myDeptMemberList}" />
					<c:if test="${!empty myMemList }">
						<c:forEach items="${myMemList }" var="myMemDto" varStatus="vs">
							<tr>
								<td><input id="addr_check_${vs.index }" type="checkbox" ><input id="addr_vip_${vs.index }" type="checkbox"><label for="addr_vip_${vs.index }"><span></span></label></td>
								<td><b>${myMemDto.getMem_name() }</b></td> <td>${myMemDto.getMem_position() }</td> <td>${myMemDto.getMem_rank() }</td>
								<td>${myMemDto.getDept_name() }</td> <td>${myMemDto.getTeam_name() }</td> <td>${myMemDto.getMem_email() }</td>
								<td>${myMemDto.getMem_phone() }</td>
							</tr>
						</c:forEach>
					</c:if>
					
				</table>
		
			</div>	
			
		</article>
	
	</div>
<script type="text/javascript">

$(function(){
	
	// 부서명 체크박스 하나만 선택되도록 하기.
	$("input[name *= 'accordion_cb']").click(function(){
		
	    if(this.checked) {
	        const checkboxes = $("input[name *= 'accordion_cb']");
	        for(let i = 0; i < checkboxes.length; i++){
	            checkboxes[i].checked = false;
	        }
	        this.checked = true;
	    } else {
	        this.checked = false;
	    }		
	});

	// 모달창 오픈 시 z-index 변경.
	$('#popup01').on('change',function(){
		if($('#popup01').is(':checked')){
			$('#header').css('z-index','-1');
			
		}else{
			$('#header').css('z-index','20');
        }	
	});	
	
	// 모달창 오픈 시 z-index 변경.
	$('#popup02').on('change',function(){
		if($('#popup02').is(':checked')){
			$('#header').css('z-index','-1');
			
		}else{
			$('#header').css('z-index','20');
        }	
	});		
	
	// 부서 별 주소록 클릭 시 이벤트
	$("input[name = 'accordion_cb_dept']").click(function(){
		
		let dept_name = $("input:checkbox[name=accordion_cb_dept]:checked").val();
		
		console.log('체크한 부서명은?' + dept_name);
		
		$.ajax({
			type: 'POST',
		//	async : false,
			url: '<%=request.getContextPath()%>/getAddrList_dept.do',
			dataType:'json',
			data: {"dept_name" : dept_name},
			success: function(data){	// 정상적으로 응답 받았을 경우에는 success 콜백이 호출.
				//addrList_dept
				$("#addr_table").html("<tr><th>이름</th> <th>직책</th> <th>직급</th><th>부서</th> <th>소속팀</th> <th>이메일</th><th>전화번호</th></tr>");	
				
			$.each(data, function(index, MemberDTO) {
				$("#addr_table").append("<tr><td><input id='addr_check_"+index+"' type='checkbox' ><input id='addr_vip_"+index+"' type='checkbox'><label for='addr_vip_"+index+"'><span></span></label></td><td><b>"+MemberDTO.mem_name+"</b></td><td>"+MemberDTO.mem_position+"</td><td>"+MemberDTO.mem_rank+"</td><td>"+MemberDTO.dept_name+"</td><td>"+MemberDTO.team_name+"</td><td>"+MemberDTO.mem_email+"</td><td>"+MemberDTO.mem_phone+"</td></tr>");
				});	
								
			},
			error: function(res){ // 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없을 때 error 콜백이 호출.
				alert('ajax 응답 오류');
			}
		});	// 부서 별 연락처 조회 $.ajax() end		
		
	});	// 부서 별 주소록 클릭 시 이벤트 end
	
	
	// 고객 / 거래처 주소록 클릭 시 이벤트
	$('#accordion_cb_customer').click(function(){
		
		// 로그인 기능 완성 시 세션 값으로 변경 할 예정.
		let mem_no = 1;
		
		$.ajax({
			type: 'POST',
		//	async : false,
			url: '<%=request.getContextPath()%>/getAddrList_customer.do',
			dataType:'json',
			data: {"mem_no" : mem_no},
			success: function(data){	// 정상적으로 응답 받았을 경우에는 success 콜백이 호출.
				//addrList_customer
				$("#addr_table").html("<tr><th>이름</th> <th>직책</th> <th>직급</th><th>부서</th> <th>소속팀</th> <th>이메일</th><th>전화번호</th></tr>");	
				
			$.each(data, function(index, CustomerDTO) {
				$("#addr_table").append("<tr><td><input id='addr_check_"+index+"' type='checkbox' ><input id='addr_vip_"+index+"' type='checkbox'><label for='addr_vip_"+index+"'><span></span></label></td><td><b>"+CustomerDTO.customer_name+"</b></td><td>"+CustomerDTO.customer_position+"</td><td>"+CustomerDTO.customer_rank+"</td><td>"+CustomerDTO.customer_dept+"</td><td>"+CustomerDTO.customer_team+"</td><td>"+CustomerDTO.customer_email+"</td><td>"+CustomerDTO.customer_phone+"</td></tr>");
				});	
								
			},
			error: function(res){ // 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없을 때 error 콜백이 호출.
				alert('ajax 응답 오류');
			}
		});	// 전체 연락처 조회 $.ajax() end		
		
	});	// 고객 / 거래처 주소록 클릭 시 이벤트 end

	
	// 검색창 엔터키 / 클릭 이벤트
	$('#search_box').on('keydown', function(e){
		  if(e.code == 'Enter'){
			  	$('#search_btn').click();
		  }
    });	
		
	$('#search_btn').click(function(){
		
		let keyword = $('#search_box').val();
		
		// 검색 내용 조회 $.ajax()
		$.ajax({
			type: 'POST',
		//	async : false,
			url: '<%=request.getContextPath()%>/address_search.do',
			dataType:'json',
			data: {"keyword" : keyword},
			success: function(data){	// 정상적으로 응답 받았을 경우에는 success 콜백이 호출.
				//addrList_search	
				$("#addr_table").html("<tr><th>이름</th> <th>직책</th> <th>직급</th><th>부서</th> <th>소속팀</th> <th>이메일</th><th>전화번호</th></tr>");	
				
				$.each(data, function(index, MemberDTO) {
					$("#addr_table").append("<tr><td><input id='addr_check_"+index+"' type='checkbox' ><input id='addr_vip_"+index+"' type='checkbox'><label for='addr_vip_"+index+"'><span></span></label></td><td><b>"+MemberDTO.mem_name+"</b></td><td>"+MemberDTO.mem_position+"</td><td>"+MemberDTO.mem_rank+"</td><td>"+MemberDTO.dept_name+"</td><td>"+MemberDTO.team_name+"</td><td>"+MemberDTO.mem_email+"</td><td>"+MemberDTO.mem_phone+"</td></tr>");
					});				
			},
			error: function(res){ // 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없을 때 error 콜백이 호출.
				alert('ajax 응답 오류');
			}
		});	// 검색 내용 조회 $.ajax() end				
		
	});	// 검색창 엔터키 / 클릭 이벤트 end
	
	// 연락처 추가 모달창 폼 페이지 이미지 미리보기 변경
	$("#chooseFile").on("change", handleImgFileSelect);
	
	// 연락처 추가 모달창 폼페이지 입력 시 이벤트
	$('#add_customer').click(function(){
        /// event.preventDefault();
        var url = $("#form").attr("action");
        var form = $('#form')[0];
        var formData = new FormData(form);
        
        $.ajax({
          url: url,
          type: 'POST',
          data: formData,
          success: function (data) {
        	 console.log(data);
        	 if(data=1){
        		 alert('고객 / 거래처 연락처 추가 성공');
        	 }else{
        		 alert('고객 / 거래처 연락처 추가 실패');
        	 }

          },
          error: function (data) {
            alert('고객 / 거래처 연락처 추가 실패');
          },
          cache: false,
          contentType: false,
          processData: false		
		
		});	// 폼페이지 ajax end
		
	});	// 연락처 추가 모달창 폼페이지 입력 시 이벤트 end

/* 	
	// 각 연락처 클릭 시 상세 정보 모달창 띄우기
	$('#addr_table tr').click(function(){

	});

 */
	
});




// 이미지 미리보기 변경 함수
function handleImgFileSelect(e) {
    var files = e.target.files;
    var filesArr = Array.prototype.slice.call(files);

    var reg = /(.*?)\/(jpg|jpeg|png|bmp)$/;

    filesArr.forEach(function(f) {
        if (!f.type.match(reg)) {
            alert("확장자는 이미지 확장자만 가능합니다.");
            return;
        }

        sel_file = f;

        var reader = new FileReader();
        reader.onload = function(e) {
            $("#img").attr("src", e.target.result);
        }
        reader.readAsDataURL(f);
    });
}	// 이미지 미리보기 변경 함수 end




</script>
</body>
</html>