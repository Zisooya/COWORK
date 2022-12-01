<%@ page session="false" pageEncoding="UTF-8"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
	  var calendarEl = document.getElementById('calendar');

	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    headerToolbar: {
	      left: 'prev,next today',
	      center: 'title',
	      right: 'dayGridMonth,timeGridWeek'
	    },
	    initialDate: '2022-11-12',
	    events: [
	      {
	        start: '2022-11-11T10:00:00',
	        end: '2022-11-11T16:00:00',
	        display: 'background',
	        color: '#ff9f89'
	      },
	      {
	        start: '2022-11-13T10:00:00',
	        end: '2022-11-13T16:00:00',
	        display: 'background',
	        color: '#ff9f89'
	      },
	      {
	        start: '2022-11-24',
	        end: '2022-11-28',
	        overlap: false,
	        display: 'background'
	      },
	      {
	        start: '2022-11-06',
	        end: '2022-11-08',
	        overlap: false,
	        display: 'background'
	      }
	    ]
	  });

	  calendar.render();
	});
</script>
<!-- <meta charset="UTF-8"> -->
<title>Insert title here</title>
<link href="${path}/resources/css/include.css" rel="stylesheet"/>
</head>
<body>
	<div id="grid_container">
		<jsp:include page="include.jsp" />
		<nav id="side">
			<input type="button" value="일정쓰기">
		</nav>
		<article id="content">	<!-- 메인 기능 들어갈 부분 -->
			<!-- 일정 검색 -->
			<form method="post" action="<%=request.getContextPath()%>/calendar_search.do">
				<select name="field">
					<option value="title">제목</option>
					<option value="cont">내용</option>
					<option value="writer">작성자</option>
				</select>
				
				<input name="keyword">&nbsp;&nbsp;
				<input type="submit" value="검색">
			</form>
		
		<div id='calendar'></div>
		
		
		
		
		
		
		</article>	<!-- 메인 기능 들어갈 부분 끝 -->
	</div>
</body>
</html>