<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<meta charset="UTF-8">

	<header id="header">
		<div id="header_container">
			<div id="header_left">

				COWORK.
			</div>	
			<div id="company">
				(주)그린테크
			</div> -->
			<a href="<%=request.getContextPath() %>/">
			<img id="logo_home" src="resources/images/COWORK.png" style="height: 60%; margin: 105px 0 0 40px;"/>
			</a>
			<div id="header_center">
				<ul>
					<li> <a href="<%=request.getContextPath() %>/calendar.do"> <img id="navi01" src="resources/images/캘린더.png" width="45" height="45" /><label for="navi01" id="arrow_box01">캘린더</label></a> </li>
					<li> <a href="<%=request.getContextPath()%>/project_board.do"> <img id="navi02" src="resources/images/프로젝트.png" width="45" height="45" /><label for="navi02" id="arrow_box02">프로젝트</label></a> </li>
					<li> <a href=""> <img id="navi03"  src="resources/images/커뮤니티.png" width="45" height="45"/><label for="navi03" id="arrow_box03">커뮤니티</label></a> </li>
					<li> <a href="<%=request.getContextPath()%>/address.do"> <img id="navi04" src="resources/images/주소록.png" width="45" height="45" /><label for="navi04" id="arrow_box04">주소록</label></a> </li>
					<li> <a href=""> <img id="navi05" src="resources/images/메일.png" width="40" height="40" /><label for="navi05" id="arrow_box05">메일</label></a> </li>
					<li> <a href="<%=request.getContextPath()%>/messenger.do?mem_no=${member.mem_no}"> <img id="navi06" src="resources/images/메신저.png"width="50" height="50" /><label for="navi06" id="arrow_box06">메신저</label></a> </li>
				</ul>	
			</div>

			<!-- 이 부분 추후에 로그인 기능 완성 되면 로그인 전/ 후로 나눌 것 -->
			<div id="header_right">
				<div id="header_right_container">
						<div id="notification"><a href=""><img id="noti_img" src="resources/images/종.png" width="20" height="20" /><span id="noti_num">13</span></a></div>
						<!-- <div id="bell"> <a href=""> <img src="resources/images/종.png" width="20" height="20" /><span></span> </a> </div> -->
						<!-- <div id="alert_count"> <a href=""> 5 </a> </div> -->

						<!-- 프로필 사진 클릭 시 마이페이지(회원정보 수정(비밀번호 변경 포함), 회원 탈퇴)로 이동 예정-->
						<div id="profile_circle"> <a href="${ path }/myPage.do"> <img src="../resources/mem_upload/${member.mem_image}" width="55" height="55" /> </a> </div>
						<div id="login"> <a href="${ path }/member_logout.do">로그아웃</a> </div>
						<div id="hi"> <b>${member.mem_name}</b>님 안녕하세요!</div>
				</div>

			</div>	
		</div>	
	</header>


	

