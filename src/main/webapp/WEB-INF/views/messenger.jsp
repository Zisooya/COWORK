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
						<c:set var="deptList" value="${deptList}" />
						<c:set var="myDept_no" value="${myDept_no}" />
						<c:if test="${!empty deptList }">
							<c:forEach items="${deptList }" var="deptDto" varStatus="vs">
								<input type="checkbox" id="accordion_cb_${vs.index }" name="accordion_cb_dept" value="${deptDto.getDept_name() }">
								<label class="people" for="accordion_cb_${vs.index }">${deptDto.getDept_name() }</label>
							</c:forEach>
						</c:if>
					
					</div>
					<input type="checkbox" id="messenger_menu02">
					<label class="messenger_label" for="messenger_menu02"><span></span>&nbsp;&nbsp;&nbsp;&nbsp;그룹</label>					
				</div>
			
			</div>
		</nav>
	
		<article id="content">
			<div>
				<button type="button" onclick="openSocket();">대화방 참여</button>
				<button type="button" onclick="closeSocket();">대화방 나가기</button>
				<br><br><br>
				메세지 입력 :
				<input type="text" id="sender" value="박지수" style="display: none;" >
				<input type="text" id="messageinput">
				<button type="button" onclick="send();">메세지 전송</button>
				<button type="button" onclick="javascript:clearText();">대화내용 지우기</button>	
			</div>
		
			<div id="messages">
			</div>
		</article>
	
	</div>
<script type="text/javascript">

    var ws;
    var messages = document.getElementById("messages");
    
    function openSocket(){
        if(ws !== undefined && ws.readyState !== WebSocket.CLOSED ){
            writeResponse("WebSocket is already opened.");
            return;
        }
        //웹소켓 객체 만드는 코드
        ws = new WebSocket("ws://localhost:8282/cowork/messanger.do");
        
        ws.onopen = function(event){
            if(event.data === undefined){
          		return;
            }
            writeResponse(event.data);
        };
        
        ws.onmessage = function(event){
            console.log('writeResponse');
            console.log(event.data)
            writeResponse(event.data);
        };
        
        ws.onclose = function(event){
            writeResponse("대화 종료");
        }
        
    }
    
    function send(){
       // var text=document.getElementById("messageinput").value+","+document.getElementById("sender").value;
        var text = document.getElementById("messageinput").value+","+document.getElementById("sender").value;
        ws.send(text);
        text = "";
    }
    
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
</script>	
</body>
</html>