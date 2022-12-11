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
						<form enctype="multipart/form-data" method="post" action="">
						
								<div class="add_title"><label for="chooseFile"><img src="${path}/resources/images/로그인_전_프로필.png" width="100px"></img></label><input type="file" id="chooseFile" accept="image/*" onchange="loadFile(this)"></div>
								<div class="input_box_one">
								<button class="vip_add"></button><input type="text" placeholder="이름"> <br>
								</div>
							
							
								<div class="add_title">회사 / 소속</div> 
								<div class="input_box">
									<input type="text" placeholder="직책"> <input type="text" placeholder="직급"> 
									<input type="text" placeholder="부서"> <input type="text" placeholder="소속"> 
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
								<input type="text" placeholder="전화번호"> <span id="phone_add"></span><br>
								</div>
								
								<div class="add_title">이메일</div>
								<div class="input_box_one">
									<input type="text" placeholder="이메일">
								</div>
								<div class="add_title">공개범위</div>
								<div class="input_box_radio">
									<input type="radio" value="전체공개"><label for="전체공개">전체공개</label><input type="radio" value="멤버공개"><label for="멤버공개">멤버공개</label>
								</div>
								
								<div class="add_title">편집허용</div>
								<div class="input_box_check">
									<input type="checkbox" id="toggle" hidden> 
									<label for="toggle" class="toggleSwitch">
									  <span class="toggleButton"></span>
									</label>
								</div>

								<div class="add_btn_div">
									<button class="add_btn">취소</button>
									<input class="add_btn" type="submit" value="저장">
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
						<c:if test="${!empty deptList }">
							<c:forEach items="${deptList }" var="deptDto">
								<input type="checkbox" id="accordion_cb">
								<label class="people" for="accordion_cb">${deptDto.getDept_name() }</label>
							</c:forEach>
						</c:if>
					</div>
					<hr>
					<input type="checkbox" id="addr_menu02">
					<label class="addr_label" for="addr_menu02"><span></span>&nbsp;&nbsp;&nbsp;&nbsp;고객 / 거래처</label>					
					<br>
					<div class="accordion_cb_div">
						<input type="checkbox" id="accordion_cb">
						<label class="people" for="accordion_cb">전체 연락처</label>
					</div>	

					<hr>
				</div>
				
				<a class="vip" href="">VIP</a>
				<a class="trash" href="">휴지통</a>
				
			</div>
		</nav>
	
		<article id="content">
			<form method="post" action="addr_search.do">
				<input id="search_box" type="text" name="keyword" placeholder="연락처 검색">
				<input id="search_btn" type="submit" value="검색">
			</form>
			
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
				<table>
					<tr>
						<th>이름</th> <th>직책</th> <th>직급</th>
						<th>부서</th> <th>소속팀</th> <th>이메일</th>
						<th>전화번호</th>			
					</tr>	
					
					<tr>
						<td></td> <td></td> <td></td>
						<td></td> <td></td> <td></td>
						<td></td>
					</tr>
				</table>
		
			</div>	
			
		</article>
	
	</div>
<script type="text/javascript">

</script>
</body>
</html>