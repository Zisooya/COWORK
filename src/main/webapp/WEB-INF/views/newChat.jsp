<%@page import="com.team3.model.DepartmentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	int newChatRoomNo = Integer.parseInt(request.getParameter("newChatRoomNo"));
	String deptList = request.getParameter("deptList");
%> 


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">

	
	/* 새로운 대화 생성 관련 내용*/
	
	$("#search_box").keyup(function(){
		
		let keyword = $('#search_box').val();
		
		// 검색 내용 조회 $.ajax()
		$.ajax({
			type: 'POST',
			async : false,
			url: '<%=request.getContextPath()%>/messenger_searchMem.do',
			dataType:'json',
			data: {"keyword" : keyword},
			success: function(data){	// 정상적으로 응답 받았을 경우에는 success 콜백이 호출.
				//searchMemList
                
					if(keyword==''){ // 검색어가 입력되지 않을 경우 원본 데이터 출력.
						$("#memNoDiv").html("");
						$("#memNoDiv").html("<c:forEach items='${memList }' var='memberDto' varStatus='vs'><div class='modal_data'><input id='memNo_${vs.index }' name='mem_no' type='checkbox' value='${memberDto.getMem_no()}'><label for='memNo_${vs.index }'>${memberDto.mem_name} (${memberDto.dept_name} ${memberDto.mem_rank})</label></div></c:forEach>");
						
					}else{
						$("#memNoDiv").html("");
						$.each(data, function(index, MemberDTO) {
							$("#memNoDiv").append("<div class='modal_data'><input id='memNo_"+index+"' name='mem_no' type='checkbox' value='"+MemberDTO.mem_no+"' ><label for='memNo_" + index + "'> "+MemberDTO.mem_name+" ("+MemberDTO.dept_name+" "+MemberDTO.mem_rank+")</label></div>");
							});						
					}                	
                
			},
			error: function(res){ // 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없을 때 error 콜백이 호출.
				alert('ajax 응답 오류');
			}
		});	// 검색 내용 조회 $.ajax() end				
		
	});	// 검색창 이벤트 end	
	

		

	
	// 새로운 대화 생성 시 '확인' 버튼 클릭 이벤트
	$("#form_btn").click(function(){
		
		
		// 1. chat_room_no 담기
		let chat_room_no = $("input[name=chat_room_no]").val();
		
		// 2. chat_kind 담기
		// 체크한 대화 인원이 1명 초과이면 chat_kind : 그룹대화 
		let chekedMemCount = $('input:checkbox[name=mem_no]:checked').length;
		
		if (chekedMemCount === 1){
			$("input[name=chat_kind]").val('one');
		}else{
			$("input[name=chat_kind]").val('group');
		}
		
		let chat_kind = $("input[name=chat_kind]").val() ;
		
		// 3. regdate 담기
    	var today = new Date();
    	var year = today.getFullYear();
    	var month = ('0' + (today.getMonth() + 1)).slice(-2);
    	var day = ('0' + today.getDate()).slice(-2);
    	var dateString = year + '/' + month  + '/' + day;
    	
    	var today = new Date();   
		var hours = ('0' + today.getHours()).slice(-2); 
		var minutes = ('0' + today.getMinutes()).slice(-2);
		var seconds = ('0' + today.getSeconds()).slice(-2); 
		var timeString = hours + ':' + minutes  + ':' + seconds;
		
		let regdate = dateString + " " + timeString;
		
		$("input[name=chat_room_no]").val(regdate);
		
		console.log(regdate);	// 2022/12/21 15:47:29		
		
		// 내 회원 번호 담기
		let myNum = $('#myNum').val();
		
        // 체크된 멤버 넘기기 위해 배열 선언
        var checkedMemArr = [];
        
        $('input[name="mem_no"]:checked').each(function(i){ // 체크된 것 리스트 저장
        	checkedMemArr.push($(this).val());
        });
        
        // 마지막 인덱스에 내 회원번호도 배열에 저장
        checkedMemArr.push(myNum);
        
        var objParams = {
                "checkedMemArr" : checkedMemArr, //체크된 멤버 배열 저장
                "chat_room_no" : chat_room_no,
                "chat_kind" : chat_kind,
                "regdate" : regdate,
                "myNum" : myNum
            };
        
        // 4. 체크된 멤버들 기준으로 chat_name 구하고 채팅방 생성하는 ajax 호출
        $.ajax({
            url:"<%=request.getContextPath()%>/messenger_insertNewChatRoom.do",
            async:false,
            dataType:"json",
            type:"post",
            data:objParams,
            success:function(data){
					// newChatRoomNo
					alert("새로운 채팅이 생성되었습니다.");
            },
            error:function(request, status, error){
                console.log("AJAX 에러");
                alert(request+status+error);
            }
        });        
       
	}); // '확인' 버튼 클릭 이벤트 end





</script>
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
</head>
<body>


<div class='modal_title'>대화상대 선택</div>

	<input id="search_box" type="text" name="keyword" placeholder="이름으로 검색">


		
		<c:if test="${!empty memList }">
		<!-- mem_no -->
		<div id="memNoDiv">
			<c:forEach items="${memList }" var="memberDto" varStatus="vs">
				<div class="modal_data">
				<input id="memNo_${vs.index }" name="mem_no" type="checkbox" value="${memberDto.getMem_no()}">
				<label for="memNo_${vs.index }">${memberDto.mem_name} (${memberDto.dept_name} ${memberDto.mem_rank})</label>
				</div>
			</c:forEach>
		</div>
		</c:if>
		
	<form name="newChatRoom">	
		
		<!-- chat_room_no -->
		<input name="chat_room_no" type="hidden" value="<%=newChatRoomNo%>">
		
		<!-- chat_room_name -->
		<input name="chat_room_name" type="hidden" value="">
				
		<!-- chat_kind -->
		<input name="chat_kind" type="hidden" value="">
		
		<!-- regdate -->
		<input name="regdate" type="hidden" value="">
		
		<button id="form_btn">확인</button>
	
	</form>
	


<div id="checkedMem">
</div>



</body>
</html>