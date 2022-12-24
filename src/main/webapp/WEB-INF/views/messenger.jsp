<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메신저</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>
<link href="${path}/resources/css/messenger.css" rel="stylesheet"/>
<link href="${path}/resources/css/include.css" rel="stylesheet"/>

</head>
<body>
	<div id="grid_container">
	
		<jsp:include page="include.jsp" />
	
		<nav id="side">
			<label>메신저</label>
			<div id="side_menu" style="overflow-y: auto;">
				<input type="checkbox" id="popup01">
				<label class="modal_label" for="popup01"><span></span>새로운 대화</label>
				<div>
					<div class="modal_content" style="overflow-y:auto; ">
						<label class="modal_exit" for="popup01"></label>
						<h2>새로운 대화 추가</h2>
						<div id="addChatRoomDiv">
						
						<form action="<%=request.getContextPath()%>/messenger_addChatRoom.do">
							
							<div class="CRinput">
								<label for="chat_room_name">채팅방 이름 </label><br>
								<div class="input_div">
									<input class="input_text" type="text" name='chat_room_name'>
								</div>
							</div>
							
							<div class="CRinput">
								<label for="chat_kind">채팅 유형 </label><br>
								<div class="input_div">
									일대일 <input name="chat_kind" type="radio" value="one">&nbsp;&nbsp;&nbsp;
									그룹 <input name="chat_kind" type="radio" value="group">
								</div>
							</div>
								
								<div class="add_btn_div">
									<input id="add_customer" class="add_btn" type="button" value="추가">
								</div>
															
						</form>
						</div>
					</div>
					<label for="popup01"></label>
				</div>			
			
				<hr>
				<input id="messenger_chatList" name="messenger_list" type="checkbox"><label for="messenger_chatList"><span></span>대화 목록</label>
				<div id="chatList_div">
					<input type="checkbox" id="messenger_menu01">
					<label class="messenger_label" for="messenger_menu01"><span></span>&nbsp;&nbsp;&nbsp;&nbsp;일대일</label>
					<div class="accordion_cb_div">
						<c:set var="oneToOneChatList" value="${oneToOneChatList}" />
						<c:if test="${!empty oneToOneChatList }">
							<c:forEach items="${oneToOneChatList }" var="chatRoomDto" varStatus="vs">
								<input type="checkbox" id="accordion_cb_o${vs.index }" 
										name="accordion_cb_oneToOne" value="${chatRoomDto.getChat_room_no() }" 
										onclick="openChatRoom(this.value);">
								<label class="chat_room" for="accordion_cb_o${vs.index }">${chatRoomDto.getChat_room_name() }</label>
							</c:forEach>
						</c:if>
					</div>
					
					<input type="checkbox" id="messenger_menu02">
					<label class="messenger_label" for="messenger_menu02"><span></span>&nbsp;&nbsp;&nbsp;&nbsp;그룹</label>					
					<div class="accordion_cb_div">
						<c:set var="groupChatList" value="${groupChatList}" />
						<c:if test="${!empty groupChatList }">
							<c:forEach items="${groupChatList }" var="chatRoomDto2" varStatus="vs">
								<input type="checkbox" id="accordion_cb_g${vs.index }" 
										name="accordion_cb_group" value="${chatRoomDto2.getChat_room_no() }"
										onclick="openChatRoom(this.value);">
								<label class="chat_room" for="accordion_cb_g${vs.index }">${chatRoomDto2.getChat_room_name() }</label>
							</c:forEach>
						</c:if>
					</div>				
				
				</div>
			
			</div>
		</nav>
	
		<article id="content">
			<div id="chat_grid_container">
				<div id="messages">
					<button type="button" onclick="closeSocket();" style="width:200px;">대화방 나가기</button>
					
				</div>				
					<div id="bottom_input">
					<input type="hidden" id="sender" value="${member.mem_id}" >
					<input type="text" id="messageinput" onkeyup="javascript:enterMessage(event);">
					<button type="button" id="message_send_btn" onclick="send();">메세지 전송</button>
					<button type="button" onclick="javascript:clearText();">대화내용 지우기</button>	
					</div>
				<input type="checkbox" id="sideBar_btn">
				<label for="sideBar_btn"><img id="sideBar_img" alt="사이드바 버튼" src="${path}/resources/images/사이드바화살표.png"> </label>	
				<div id="right_chatRoomDetail">
				
					
					
				</div>		
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
	});	// 부서명 체크박스 하나만 선택되도록 하기.
	
	// 사이드바 숨기기/보이기
	$('#sideBar_btn').on('change',function(){
		if($('#sideBar_btn').is(':checked')){
			$('#right_chatRoomDetail').css({"width":"0","display":"none","transition":"all 0.4s"});
			$('#messages').css({"width":"133%","transition":"all 0.4s"});
			$('#bottom_input').css({"width":"82%","transition":"all 0.4s"});
		}else{
			$('#right_chatRoomDetail').css({"width":"100%","display":"block","transition":"all 0.4s"});
			$('#messages').css({"width":"100%","transition":"all 0.4s"});
			$('#bottom_input').css({"width":"61%","transition":"all 0.4s"});
        }	
	});
	

	// 모달창 오픈 시 z-index 변경.
	$('#popup01').on('change',function(){
		if($('#popup01').is(':checked')){
			$('#sideBar_img').css('z-index','-1');
			$('#right_chatRoomDetail').css('z-index','-2');
			$('#bottom_input').css('z-index','-1');
			$('#header').css('z-index','-1');
			
		}else{
			$('#sideBar_img').css('z-index','2');
			$('#right_chatRoomDetail').css('z-index','1');
			$('#bottom_input').css('z-index','1');
			$('#header').css('z-index','20');
        }	
	});
	
	// 모달창 오픈 시 이벤트 - 'DB 채팅방 번호 최댓값'과 '회사 주소록' 가져오기
	$('#popup01').on('change',function(){
		
		if($('#popup01').is(':checked')){
			
			let mem_no = $('#myNum').val();
			
			// DB 채팅방 번호 최댓값 가져오기
			$.ajax({
				type: 'POST',
			//	async : false,
				url: '<%=request.getContextPath()%>/messenger_getChatRoomNoMax.do',
				dataType:'json',
				data: {"mem_no" : mem_no},
				success: function(data){	// 정상적으로 응답 받았을 경우에는 success 콜백이 호출.
					//chatRoomNoMax
					let chatRoomNoMax = data;
					let newChatRoomNo = data + 1;
					$("#addChatRoomDiv").html("<input name='chat_room_no' type='hidden' value='"+newChatRoomNo+"'>");	
				},
				error: function(res){ // 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없을 때 error 콜백이 호출.
					alert('ajax 응답 오류');
				}
			});	// DB 채팅방 번호 최댓값 조회 $.ajax() end	
			
			// 회사 주소록 가져오기
			$.ajax({
				type: 'POST',
			//	async : false,
				dataType:"json",
				url: '<%=request.getContextPath()%>/messenger_getAllDeptList.do',
				success: function(data){	// 정상적으로 응답 받았을 경우에는 success 콜백이 호출.
				// deptList
					$('#addChatRoomDiv').append("<div class='modal_title'>대화상대 선택</div>");
				$.each(data, function(index, DepartmentDTO) {
					
					$('#addChatRoomDiv').append("<input id='dept_no"+index+"' type='checkbox' ><label class='dept_lb' for='dept_no"+index+"'>"+DepartmentDTO.dept_name+"</label><div>연락처올자리</div>");
					
									
					});
				},
				error: function(res){ // 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없을 때 error 콜백이 호출.
					alert('ajax 응답 오류');
				}
			});	// 회사 주소록 조회 $.ajax() end		

			
			
		
			
		}
		
	});	// 모달창 오픈 시 이벤트 end
	
	
	

	
});


	// 웹소켓 관련 내용
    var ws;
    var messages = document.getElementById("messages");
    //var messages_people = document.getElementById("messages_people");
    
    // 웹소켓 연결 요청(핸드쉐이크) 시 실행 함수
    function openSocket(){
    	
    	// console.log("현재 채팅방 번호는 ? "+chat_room_no);
    	
        if(ws !== undefined && ws.readyState !== WebSocket.CLOSED ){
            // writeResponse("WebSocket is already opened.");
            return;
        }
        
        //웹소켓 객체 만드는 코드
        //cowork는 프로젝트 이름
        //messanger.do 웹소켓 서버단 @ServerEndpoint에 적은 path
        ws = new WebSocket("ws://localhost:8282/cowork/chat");
        
        
        
      	//웹 소켓이 서버와 연결되었을 때 호출되는 이벤트
        ws.onopen = function(event){
            if(event.data === undefined){
          		return;
            }
            writeResponse(event.data);
        };
        
      	//웹 소켓에서 메시지가 왔을 때 호출되는 이벤트
        ws.onmessage = function(event){
            console.log('writeResponse');
            console.log(event.data)
            writeResponse(event.data);
        };
        
      	//웹 소켓이 닫혔을 때 호출되는 이벤트
        ws.onclose = function(event){
            writeResponse("대화 종료");
        }
      	
        //웹 소켓이 에러가 났을 때 호출되는 이벤트
        ws.onerror = function(event){
            alert('에러');
        };          
    }
    
    // 메세지 전송 버튼 클릭 시 실행되는 함수
    function send(){
    	
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
		
		let send_date = dateString + " " + timeString;
		
		console.log(send_date);	// 2022/12/21 15:47:29
    	
		let sender = document.getElementById("sender").value;
		let message = document.getElementById("messageinput").value;
		let chat_room_no = (document.getElementById("chat_room_no").value).toString();
		
        let text = message+","+sender+","+chat_room_no+","+send_date;
     	
        //웹소켓으로 textMessage객체의 값을 보낸다.
        ws.send(text);
        
        document.getElementById("messageinput").value="";
        
        text = "";
 
        // 자동 스크롤
        let messages = document.getElementById("messages");
        messages.scrollTop = messages.scrollHeight;
        
		// ajax로 DB에 메세지 저장하는 함수 호출
		insertChatMessage(chat_room_no, sender, message, send_date);
		
    } // send() 함수 end
    
    
	// 메세지 입력창 엔터키	
    function enterMessage(e){
        
        if(e.keyCode == 13){
        	send();
        }
    } // enterMessage() 함수 end	    
    

    //웹소켓 종료 함수
    function closeSocket(){
        ws.close();
    }
    
    // 대화방에 연결 되었습니다 => 나중에 각 회원 입장 알림으로 수정하기
    function writeResponse(text){
        messages.innerHTML += "<br/>"+text;
    }
    
    function clearText(){
        console.log(messages.parentNode);
        messages.parentNode.removeChild(messages)
  	}    
    
    function openChatRoom(chat_room_no) {
    	
    	let mem_id = document.getElementById("sender").value;
    	
    	// 채팅방 별 데이터 불러오기
    	$.ajax({
    		type: 'POST',
    		url :"<%=request.getContextPath()%>/openChatRoom.do",
    		//async : false,
    		dataType:"json",
    		data : {"chat_room_no": chat_room_no},
    		success : function(data){
    			
    			
    			$('#messages').html("");
    			$('#messages').append("<input id='chat_room_no' type='hidden' value='"+chat_room_no+"'>");
	    		$.each(data, function(index, Chat_MessageDTO) {
	    			
	    			if(Chat_MessageDTO.sender===mem_id){
	    				$("#messages").append("<div class='rightM'><div class='send_date_me'>"+Chat_MessageDTO.send_date+"</div><div class='messages_me'>" + Chat_MessageDTO.message+"</div></div>");
	    			}else{
	    				$("#messages").append("<div class='leftM'><div class='send_date_people'>"+Chat_MessageDTO.send_date+"</div><div class='sender_img'></div><div class='sender_name'>"+Chat_MessageDTO.sender+"</div><div class='messages_people'>" + Chat_MessageDTO.message+"</div></div>");
	    			}
	    			
	    		});	// $.each() 함수 end
	    		
	            let messages = document.getElementById("messages");
	            messages.scrollTop = messages.scrollHeight;
	            
	    		openSocket();
    		}, 
    		error: function(res){ 
				alert('ajax 응답 오류');
			}
    	});   // 채팅방 별 jsp 불러오기 $.ajax() end

    	
	}	// openChatRoom 함수 end

	
    function insertChatMessage(chat_room_no, sender, message, send_date) {
		
		let sendData = {"chat_room_no":chat_room_no,"sender":sender,"message":message,"send_date":send_date};
		
		// DB에 메세지 저장 $.ajax()
		$.ajax({
			type: 'POST',
			async : false,
			url: '<%=request.getContextPath()%>/messenger_insertMessage.do',
			data:sendData,
			success: function(data){	// 정상적으로 응답 받았을 경우에는 success 콜백이 호출.
				if(data>0){
					console.log('db에 메세지 저장 성공');
				}					
			},
			error: function(res){ // 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없을 때 error 콜백이 호출.
				alert('ajax 응답 오류');
			}
		});	// DB에 메세지 저장 $.ajax() end				
	}
 
</script>	
</body>
</html>