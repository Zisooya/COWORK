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
				<input id="messenger_newChat" name="messenger_list" type="checkbox"><label for="messenger_newChat"><span></span>새로운 대화</label>
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
				<div id="messages" style="overflow-y: scroll;">
					<button type="button" onclick="closeSocket();" style="width:200px;">대화방 나가기</button>
				</div>				
					<div id="bottom_input">
					<input type="text" id="sender" value="${member.mem_id}" style="display: none;" >
					<input type="text" id="messageinput">
					<button type="button" id="message_send_btn" onclick="send();">메세지 전송</button>
					<button type="button" onclick="javascript:clearText();">대화내용 지우기</button>	
					</div>
				<div id="right_chatRoomDetail">
					사이드바
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
	
	// 각 채팅방 클릭 시 이벤트
	$("input[id *= 'accordion_cb_']").click(function() {
		$('#content').load('chatRoom.html #test');
	}); // 각 채팅방 클릭 시 이벤트 end
	
	
});


	// 웹소켓 관련 내용
    var ws;
    var messages = document.getElementById("messages");
    
    // 웹소켓 연결 요청(핸드쉐이크) 시 실행 함수
    function openSocket(chat_room_no){
    	
    	console.log("현재 채팅방 번호는 ? "+chat_room_no);
    	
    	
    	
        if(ws !== undefined && ws.readyState !== WebSocket.CLOSED ){
            // writeResponse("WebSocket is already opened.");
            return;
        }
        
        //웹소켓 객체 만드는 코드
        //cowork는 프로젝트 이름
        //messanger.do 웹소켓 서버단 @ServerEndpoint에 적은 path
        ws = new WebSocket("ws://localhost:8282/cowork/messanger.do");
        
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
        var text = document.getElementById("messageinput").value+","+document.getElementById("sender").value;
     	
        //웹소켓으로 textMessage객체의 값을 보낸다.
        ws.send(text);
        
        text = "";
    }

    //웹소켓 종료 함수
    function closeSocket(){
        ws.close();
    }
    
    
    function writeResponse(text){
        messages.innerHTML += "<br/>"+text;
    }
    
    function clearText(){
        console.log(messages.parentNode);
        messages.parentNode.removeChild(messages)
  	}    
    
<%-- 
    function openChatRoom(chat_room_no) {
    	// 채팅방 별 jsp 불러오기
    	$.ajax({
    		url :"<%=request.getContextPath()%>/stomp.jsp",
    		async : false,
    		datatype:"html",
    		data : {"chat_room_no": chat_room_no},
    		success : function(data){
    			alert(data);
    			//$('#content').html(data);
    		} 
    	});   // 채팅방 별 jsp 불러오기 $.ajax() end	  	
    	
	}

 --%>    
</script>	
</body>
</html>