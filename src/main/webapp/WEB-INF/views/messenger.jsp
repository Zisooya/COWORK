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
						<!--  
						<c:set var="partiCountArr" value="${partiCountArr}" />
						<c:set var="messageDto" value="${messageDto}" />
						<c:set var="unreadCountArr" value="${unreadCountArr}" />
						-->
						<c:if test="${!empty oneToOneChatList }">
													
							<c:forEach items="${oneToOneChatList }" var="chatRoomDto" varStatus="vs">
								<div class="chatRoom_grid_container">
									<input type="checkbox" id="accordion_cb_o${vs.index }" 
											name="accordion_cb_oneToOne" value="${chatRoomDto.getChat_room_no() }" >
									<label class="chat_room" for="accordion_cb_o${vs.index }">${oneToOneChatList[vs.index].getChat_room_name() }</label>
									<!--  
									<div class="chatMemCount"><%-- ${partiCount} --%></div>
									<div class="lastMessage">안녕하세요 안녕안녕 마케팅 부서예용</div>
									<div class="lastDate">2022/12/29</div>
									<div class="unreadCount"><%-- ${unreadCount} --%></div>
									-->
								</div>
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
										>
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
					<!-- <button type="button" onclick="closeSocket();" style="width:200px;">대화방 나가기</button> -->
	
				</div>				
					<div id="bottom_input">
					<input type="hidden" id="sender" value="${member.mem_id}" >
					<input type="text" id="messageinput" onkeyup="javascript:enterMessage(event);">
					<button type="button" id="message_send_btn" onclick="send();">메세지 전송</button>
					<!-- <button type="button" onclick="javascript:clearText();">대화내용 지우기</button>	 -->
					</div>
				<input type="checkbox" id="sideBar_btn">
				<label for="sideBar_btn"><img id="sideBar_img" alt="사이드바 버튼" src="${path}/resources/images/M사이드바화살표.png"> </label>	
				
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
			$('#messages').css({"width":"128%","transition":"all 0.4s"});
			$('#bottom_input').css({"width":"82%","transition":"all 0.4s"});
		}else{
			$('#right_chatRoomDetail').css({"width":"100%","display":"block","transition":"all 0.4s"});
			$('#messages').css({"width":"97.6%","transition":"all 0.4s"});
			$('#bottom_input').css({"width":"62.8%","transition":"all 0.4s"});
        }	
	});
	

	// 모달창 오픈 시 z-index 변경.
	$('#popup01').on('change',function(){
		if($('#popup01').is(':checked')){
			$('#sideBar_img').css('z-index','-1');
			$('#right_chatRoomDetail').css('z-index','-2');
			$('#bottom_input').css('z-index','-1');
			$('#header').css('z-index','-1');
			$('#messages').css('z-index','-1');
			
		}else{
			$('#sideBar_img').css('z-index','2');
			$('#right_chatRoomDetail').css('z-index','1');
			$('#bottom_input').css('z-index','1');
			$('#header').css('z-index','20');
			$('#messages').css('z-index','1');
        }	
	});
	
	// 모달창 오픈 시 이벤트 - 'DB 채팅방 번호 최댓값'과 '회사 주소록' 가져오기
	$('#popup01').on('change',function(){
		
		if($('#popup01').is(':checked')){
			
			let mem_no = $('#myNum').val();
			// DB 채팅방 번호 최댓값 가져오기
			$.ajax({
				type: 'POST',
				async : false,
				url: '<%=request.getContextPath()%>/messenger_getChatRoomNoMax.do',
				dataType:'json',
				data: {"mem_no" : mem_no},
				success: function(data){	// 정상적으로 응답 받았을 경우에는 success 콜백이 호출.
					//chatRoomNoMax
					let chatRoomNoMaxPlus = data + 1;
					$("#addChatRoomDiv").html("<input id='newChatRoomNo' name='chat_room_no' type='hidden' value='"+chatRoomNoMaxPlus+"'>");	
				},
				error: function(res){ // 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없을 때 error 콜백이 호출.
					alert('ajax 응답 오류');
				}
			});	// DB 채팅방 번호 최댓값 조회 $.ajax() end	
			
			let newChatRoomNo = $('#newChatRoomNo').val();
			
			// 회사 주소록은 컨트롤러에서 넘겨줌.
			$.ajax({
				url:"http://"+location.host+"/cowork/newChat.do",
				type:"post",
				async : false,
				datatype:"html",
				data: {"newChatRoomNo" : newChatRoomNo},
				success:function(data){
					$("#addChatRoomDiv").append(data);
				}	
			});		
			
		}
		
	});	// 모달창 오픈 시 이벤트 end
	
	// 각 채팅방 클릭 시 이벤트
	$("input[name *= 'accordion_cb_oneToOne']").click(function(){
		
		// 클릭한 input의 value
		var chat_room_no = $(this).attr('value');
		
		openChatRoom(chat_room_no);
		
    	openSocket();
    	
    	// 1초마다 채팅방 데이터 불러오기
    	//setInterval(openChatRoom(click_value), 1000); 
    	//setInterval(openChatRoom, 1000, chat_room_no);    	
    	
	});
	
	
	


	
});


	// 웹소켓 관련 내용
    var ws;
    var messages = document.getElementById("messages");
    //var messages_people = document.getElementById("messages_people");
    
    // 웹소켓 연결 요청(핸드쉐이크) 시 실행 함수
    function openSocket(){
    	
    	console.log('소켓 오픈');
    	
    	// 3초마다 메시지알림 읽음 처리
    	setInterval(readNoti, 3000);    	
    	
    	// console.log("현재 채팅방 번호는 ? "+chat_room_no);
    	
        if(ws !== undefined && ws.readyState !== WebSocket.CLOSED ){
            // writeResponse("WebSocket is already opened.");
            return;
        }
        
        //웹소켓 객체 만드는 코드
        //cowork는 프로젝트 이름
        //messanger.do 웹소켓 서버단 @ServerEndpoint에 적은 path
        // location.host => localhost:8282 (현재 내 pc에서)
        ws = new WebSocket("ws://"+location.host+"/cowork/chat");
        
        
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
            //console.log(event.data)
            writeResponse(event.data);
            autoScroll();
            
        };
        
      	//웹 소켓이 닫혔을 때 호출되는 이벤트
        ws.onclose = function(event){
            writeResponse("대화 종료");
        }
      	
        //웹 소켓이 에러가 났을 때 호출되는 이벤트
        ws.onerror = function(event){
            alert('에러');
        };          
    } // openSocket() 함수 end
    
    // 메세지 전송 버튼 클릭 시 실행되는 함수
    function send(){
    	
		// 현재 날짜 구하는 함수 호출
		let send_date = getPresentDate();
		
		console.log(send_date);	// 2022/12/21 15:47:29
    	
		let sender = document.getElementById("sender").value;
		let message = document.getElementById("messageinput").value;
		let chat_room_no = (document.getElementById("chat_room_no").value).toString();

		// ajax로 DB에 메세지 저장하는 함수 호출=> 저장한 message_no값 반환
		let message_no = insertChatMessage(chat_room_no, sender, message, send_date);		
		
		// 채팅방 숨겨진 input에 message_no 값 넣어두기
		document.getElementById("message_no").value = message_no;
		
		// 저장된 메세지를 message_noti 테이블에도 저장하는 함수 호출
		insertNoti();
		
        let text = message+","+sender+","+chat_room_no+","+send_date+","+message_no;
     	
        //웹소켓으로 textMessage객체의 값을 보낸다.
        ws.send(text);
        
        document.getElementById("messageinput").value="";
        
        text = "";
        
        // 1초 후에 자동스크롤
        setTimeout(autoScroll, 1000);
 
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
    //const openChatRoom = function(chat_room_no){	
    	console.log('채팅방 데이터 출력');
    	let mem_id = document.getElementById("sender").value;
    	
    	// 채팅방 별 데이터 불러오기
    	$.ajax({
    		type: 'POST',
    		url :"<%=request.getContextPath()%>/openChatRoom.do",
    		async : false,
    		dataType:"json",
    		data : {"chat_room_no": chat_room_no},
    		success : function(data){
    			
    			$('#messages').html("");
    			$('#messages').append("<input id='chat_room_no' type='hidden' value='"+chat_room_no+"'><input id='message_no' type='hidden' value=''>");
	    		$.each(data, function(index, Chat_MessageDTO) {
	    			
	    			if(Chat_MessageDTO.sender===mem_id){
	    				$("#messages").append("<div class='rightM'><div class='send_date_me'>"+Chat_MessageDTO.send_date+"</div><div class='messages_me'>" + Chat_MessageDTO.message+"</div></div>");
	    			}else{
	    				$("#messages").append("<div class='leftM'><div class='send_date_people'>"+Chat_MessageDTO.send_date+"</div><div class='sender_img'></div><div class='sender_name'>"+Chat_MessageDTO.sender+"</div><div class='messages_people'>" + Chat_MessageDTO.message+"</div></div>");
	    			}
	    			
	    		});	// $.each() 함수 end
	    		
	            let messages = document.getElementById("messages");
	            messages.scrollTop = messages.scrollHeight;
	            
    		}, 
    		error: function(res){ 
				alert('ajax 응답 오류');
			}
    	});   // 채팅방 별 jsp 불러오기 $.ajax() end
    	
    	// 우측 사이드바 채팅방 상세 정보 불러오기
    	// 1. 채팅방 이름 불러오기  	
    	$.ajax({
    		type: 'POST',
    		url :"<%=request.getContextPath()%>/messenger_getChatRoomName.do",
    		async : false,
    		dataType:"text",
    		data : {"chat_room_no": chat_room_no},
    		success : function(data){
    			// chatRoomName
    			let chatRoomName = data;
    			$('#right_chatRoomDetail').html("");
    			$('#right_chatRoomDetail').append("<div class='detail_div'><div id='detailTitle'>채팅방 이름<button class='detail_btn' id='edit_btn'><img alt='exit' src='${path}/resources/images/수정.png' style='width:25px; height:25px; '></button></div><div class='detailChatRoomName'>"+chatRoomName+"</div></div>");
    			
    		}, 
    		error: function(res){ 
				alert('ajax 응답 오류');
			}
    	});   // 1. 채팅방 이름 불러오기 $.ajax() end 

    	// 2. 내 정보 불러오기
    	let myNum = $('#myNum').val(); 
    	
    	$.ajax({
    		type: 'POST',
    		url :"<%=request.getContextPath()%>/messenger_getMyDTO.do",
    		async : false,
    		dataType:"json",
    		data : {"mem_no": myNum},
    		success : function(data){
    			// myDTO
    			let myDTO = data;
    			$('#right_chatRoomDetail').append("<div class='detail_div'><div id='detailTitle'>채팅 참여자<button class='detail_btn' id='addParticipant_btn'><img alt='addParticipant' src='${path}/resources/images/추가.png' style='width:28px; height:28px; '></button></div><div class='detailCont'><img class='detailMemImg' src='${path}/resources/mem_upload/"+myDTO.mem_image+"'><div class='detailMemName'>(나) "+myDTO.mem_name+"</div></div>");
	            
    		}, 
    		error: function(res){ 
				alert('ajax 응답 오류');
			}
    	});   // 2. 내 정보 불러오기 $.ajax() end     	

    	// 3. 참여자 정보 불러오기
    	$.ajax({
    		type: 'POST',
    		url :"<%=request.getContextPath()%>/messenger_getParticipantList.do",
    		async : false,
    		dataType:"json",
    		data : {
    			"chat_room_no" : chat_room_no,
    			"myNum" : myNum
    			},
    		success : function(data){
    			// participantList
    			
	    		$.each(data, function(index, MemberDTO) {
	    			
	    			$('#right_chatRoomDetail').append("<div class='detailCont'><img class='detailMemImg' src='${path}/resources/mem_upload/"+MemberDTO.mem_image+"'><div class='detailMemName'>"+MemberDTO.mem_name+"("+MemberDTO.mem_id+")<div class='detailRank'>"+MemberDTO.dept_name+" "+MemberDTO.mem_rank+"</div></div></div></div><button id='exit_btn'><img alt='exit' src='${path}/resources/images/나가기.png'></button>");
	    			
	    		});	// $.each() 함수 end
	            
    		}, 
    		error: function(res){ 
				alert('ajax 응답 오류');
			}
    	});   // 3. 참여자 정보 불러오기 $.ajax() end         	

    	
	}	// openChatRoom 함수 end

	
    function insertChatMessage(chat_room_no, sender, message, send_date) {
		
		let sendData = {"chat_room_no":chat_room_no,"sender":sender,"message":message,"send_date":send_date};
		
		let message_no;
		
		// DB에 메세지 저장 $.ajax()
		$.ajax({
			type: 'POST',
			async : false,
			url: '<%=request.getContextPath()%>/messenger_insertMessage.do',
			data:sendData,
			dataType:"json",
			success: function(data){	// 정상적으로 응답 받았을 경우에는 success 콜백이 호출.
				// message_no
				message_no = data;
			},
			error: function(res){ // 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없을 때 error 콜백이 호출.
				alert('ajax 응답 오류');
			}
		});	// DB에 메세지 저장 $.ajax() end	
		
		return message_no;
		
	} // insertChatMessage() 함수 end
	
	function insertNoti() {
		
		// 현재 날짜 구하는 함수 호출
		let regdate = getPresentDate();
		let mem_no = $('#myNum').val(); 
		let chat_room_no = $('#chat_room_no').val(); 
		let message_no = $('#message_no').val();		
		
		let sendData = {
				"mem_no":mem_no,
				"chat_room_no":chat_room_no,
				"message_no":message_no,
				"message_status":"unread",
				"noti_cont":"메세지가 도착했습니다.",
				"regdate":regdate
				}
		
		// 저장된 메세지를 message_noti 테이블에도 저장하는 $.ajax()
  		
		$.ajax({
			type: 'POST',
			async : false,
			url: '<%=request.getContextPath()%>/messenger_insertNoti.do',
			contentType: "application/json",
			data: JSON.stringify(sendData),
			dataType:"json",
			success: function(data){	// 정상적으로 응답 받았을 경우에는 success 콜백이 호출.
				// check
				if(data>0){
					console.log('성공');
				}
			},
			error: function(res){ // 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없을 때 error 콜백이 호출.
				alert('ajax 응답 오류');
			}
		});	// DB에 메세지 저장 $.ajax() end			
 		 		
	} // insertNoti() 함수 end
	
	function getPresentDate() {
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
		
		let present = dateString + " " + timeString;
		
		return present;
	}

    // 메세지 읽음 처리하는 함수
   	function readNoti() {
    	
    	let myNum = $('#myNum').val();
    	let chat_room_no = $('#chat_room_no').val();
		let sendData = {"mem_no": myNum, "chat_room_no":chat_room_no}
		
    	$.ajax({
    		type: 'POST',
    		url :"<%=request.getContextPath()%>/messenger_readNoti.do",
    		async : false,
    		contentType: "application/json",
    		dataType:"json",
    		data: JSON.stringify(sendData),
    		success : function(data){
    			// check
    		}, 
    		error: function(res){ 
				alert('ajax 응답 오류');
			}
    	});   // 알림 숫자 영역 새로고침 $.ajax() end 
	} // readNoti() 함수 end	
	
 	// 자동 스크롤
    function autoScroll() {
        let messages = document.getElementById("messages");
        messages.scrollTop = messages.scrollHeight;		
	}	



 
</script>	
</body>
</html>