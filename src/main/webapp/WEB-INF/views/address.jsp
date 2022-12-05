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
<link href="${path}/resources/css/include.css" rel="stylesheet"/>
<link href="${path}/resources/css/address.css" rel="stylesheet"/>
</head>
<body>
	<div id="grid_container">
	
		<jsp:include page="include.jsp" />
	
	
	
		<nav id="side">
			<label>주소록</label>
			<div id="side_menu" style="overflow-y: auto;">
				<button>연락처 추가</button>
				<button>구성원 초대</button>
				
				<hr>
				<p>조직도</p>
				<hr>
				<p>고객 / 거래처</p>
				<ul>
					<li>sdfsdf</li>
				</ul>
				
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
			
			<hr width="100%" align="left">
			
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
</body>
</html>