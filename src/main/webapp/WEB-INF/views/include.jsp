<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<meta charset="UTF-8">
   <header id="header">
      <div id="header_container">
         <div id="header_left">
            <a href="<%=request.getContextPath() %>/main.do"><img id="logo_home" src="resources/images/COWORK.png" style="width:45%; height:45%; margin: 20px 10px 5px 10px; "/></a>
         </div>   
         <div id="company">
            
         </div>
         <a href="<%=request.getContextPath() %>/">
         
         </a>
         <div id="header_center">
            <ul>
            <!-- 커뮤니티는 추후 추가되면 주석 제거해주세요 -->
               <!-- <li> <a href=""> <img id="navi03"  src="resources/images/커뮤니티.png" width="45" height="45"/><label for="navi03" id="arrow_box03">커뮤니티</label></a> </li> -->

               <li> <a href="<%=request.getContextPath()%>/messenger.do?mem_no=${member.mem_no}"> <img id="navi01" src="resources/images/메신저.png"width="40" height="40" /><label for="navi01" id="arrow_box01">메신저</label></a> </li>
               <li> <a href="<%=request.getContextPath()%>/mail_list.do"> <img id="navi02" src="resources/images/메일.png" width="30" height="30" /><label for="navi02" id="arrow_box02">메일</label></a> </li>
               <li> <a href="<%=request.getContextPath() %>/calendar.do"> <img id="navi03" src="resources/images/캘린더.png" width="35" height="35" /><label for="navi03" id="arrow_box03">캘린더</label></a> </li>
               <li> <a href="<%=request.getContextPath()%>/address.do"> <img id="navi04" src="resources/images/주소록.png" width="35" height="35" /><label for="navi04" id="arrow_box04">주소록</label></a> </li>
               <li> <a href="<%=request.getContextPath()%>/project_board.do"> <img id="navi05" src="resources/images/프로젝트.png" width="35" height="35" /><label for="navi05" id="arrow_box05">프로젝트</label></a> </li>

            </ul>   
         </div>

         <!-- 이 부분 추후에 로그인 기능 완성 되면 로그인 전/ 후로 나눌 것 -->
         <div id="header_right">
            <div id="header_right_container">
                  <div id="notification"><a href=""><img id="noti_img" src="resources/images/종.png" width="18" height="18" /><span id="noti_num">${notiCount }</span></a></div>
                  <input id="myNum" type="hidden" value="${member.mem_no}">

                  <!-- 프로필 사진 클릭 시 마이페이지(회원정보 수정(비밀번호 변경 포함), 회원 탈퇴)로 이동 예정-->
               <c:choose>
                  <c:when test="${member.mem_image == null}">
                     <div id="profile_circle"> <a href="${ path }/myPage.do"> <img src="${path}/resources/images/로그인_전_프로필.png" width="40" height="40" /> </a> </div>
                  </c:when>
                  <c:otherwise>
                     <div id="profile_circle"> <a href="${ path }/myPage.do"> <img src="${path}/resources/mem_upload/${member.mem_image}" width="45" height="45" /> </a> </div>
                  </c:otherwise>
               </c:choose>

                  <div id="login"> <a href="${ path }/member_logout.do">로그아웃</a> </div>
                  <div id="hi"> <b>${member.mem_name}</b>님 안녕하세요!</div>
            </div>
         </div>
      </div>
   </header>
<!-- <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.js"></script>  -->  
<script type="text/javascript">

// 1초마다 알림 숫자 영역에 새로운 값 주기
$(document).ready(function(){
	setInterval(updateNotiNum, 1000);
});

function updateNotiNum() {
    // 알림 숫자 영역에 새로운 값 주기
    let myNum = $('#myNum').val();
    
	$.ajax({
		type: 'POST',
		url :"<%=request.getContextPath()%>/messenger_getNotiCount.do",
		async : false,
		dataType:"json",
		data : {"myNum": myNum},
		success : function(data){
			// notiCount
			//$('#noti_num').html("${notiCount }");
			$('#noti_num').html(data);
		}, 
		error: function(res){ 
			alert('ajax 응답 오류');
		}
	});   // 알림 숫자 영역 새로고침 $.ajax() end  			
}
</script>


   
