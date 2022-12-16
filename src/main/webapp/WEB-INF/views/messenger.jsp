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
	
	
		
		</article>
	
	</div>
<script type="text/javascript">
$(function(){
	
	// '새로운 대화 버튼' 모달창
	$("#messenger_newChat").click(function() {
		
	});
/* 	
	// 주소록 or 대화 목록 체크박스 하나만 선택되도록 하기.
	$("input[id *= 'messenger_']").click(function(){
	    if(this.checked) {
	        const checkboxes = $("input[id *= 'messenger_']");
	        for(let i = 0; i < checkboxes.length; i++){
	            checkboxes[i].checked = false;
	        }
	        this.checked = true;
	    } else {
	        this.checked = false;
	    }		
	});
	
	// 사이드바 메뉴 주소록 / 대화 목록 선택
	$('input[name=messenger_list]').change(function(){
		
        if($("#messenger_address").is(":checked")){
		    $('#address_div').css('display', 'block');
		    $('#chatList_div').css('display', 'none');	
		    
		    
		    
        }else if($("#messenger_chatList").is(":checked")){
		     $('#address_div').css('display', 'none');
		     $('#chatList_div').css('display', 'block');
		     
		     
		     
		     
        }
	});	
	 */
	
});
</script>	
</body>
</html>