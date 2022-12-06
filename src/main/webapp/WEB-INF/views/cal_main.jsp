<%@ page session="false" pageEncoding="UTF-8"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.js"></script>
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
	
	var cTitle;
	var startTime;
	var endTime;
	var allDay;
	var memo;
	
	/* ------------------------------------모달창 관련------------------------------------ */
	const modal = document.querySelector(".modal");
	const closeBtn = document.querySelector(".close");
	//close button func
	closeBtn.onclick = function(){
	  modal.style.display = "none";
	}
	//빈 여백 클릭 시 모달창 닫힘 func
	window.onclick = function(){
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
	//모달창 오픈 func
	function explain(){
	  const title = document.querySelector(".title");
	  const description = document.querySelector(".description");
	  title.innerText = cTitle;
	  description.innerText = memo;
	  modal.style.display = "block";
	}
	/* ------------------------------------모달창 관련 끝------------------------------------ */
	
	  var calendarEl = document.getElementById('calendar');
	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    /* initialDate: '2022-12-01', */
	    /* locale : "ko", */
	    headerToolbar: {
	      left: 'prev,next today',
	      center: 'title',
	      right: 'dayGridMonth,timeGridWeek,timeGridDay'
	    },
	    selectable: true,
	    select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
          var title_d = prompt('Event Title:');
          if (title_d) {
            calendar.addEvent({
              title: title_d,
              start: arg.start,
              end: arg.end,
              allDay: arg.allDay
            })
          }
          calendar.unselect()
        },
        dayMaxEvents: true,
	    events: function(info, successCallback, failureCallback){
	    	  // ajax 처리로 데이터를 로딩 시킨다.
			$.ajax({
				type:"get",
				contentType:"application/x-www-form-urlencoded; charset=UTF-8",
				url:"calendarList.do?no=3",
				dataType:"json",
				success: 
					function (result) {
					var events = [];
					if(result!=null){
						$.each(result, function(index, element) {
							var eTitle = element.title
							var eStartDate = element.start;
							var eEndDate = element.end;
							var eAllday;
							if(element.allDay == "true"){
								eAllday = true;
							}else {
								eAllday = false;
							}
                            if(eEndDate == null){
                            	eEndDate = eStartDate;
                            }
                            events.push({
                                title: eTitle,
                                start: eStartDate,
                                end: eEndDate,
                                allDay: eAllday
                             }); // push() end
						}); // each() end
					} // if() end 
					successCallback(events);
				} // success: function() end
			});
		}, // events: end
		/* dateClick: function() {}, */
		/* ------------------------------------이벤트 클릭------------------------------------ */
		eventClick: function(info) {
		      var eventObj = info.event;
		        cTitle = eventObj.title;
		        startTime = eventObj.start;
		        endTime = eventObj.end;
		        allDay = eventObj.allDay;
		        memo = eventObj.cal_memo;
		        explain();
		    },
		/* ------------------------------------이벤트 클릭 끝------------------------------------ */
	  });
		/* ------------------------------------날짜 클릭------------------------------------ */
		calendar.on('dateClick', function(info) {
			alert('Clicked ' + info.dateStr);
			explain();
		});
		/* ------------------------------------날짜 클릭 끝------------------------------------ */
	  calendar.render();
	});
</script>
<style type="text/css">
	
	.add-button {
		top: 1px;
		right: 230px;
		background: #2C3E50;
		border: 0;
		color: white;
		height: 35px;
		border-radius: 3px;
		width: 157px;
	}
	
	/* modal style */
	.modal{
	  /* 모달 뒷배경 */
	  display: none; 
	  position: fixed; 
	  z-index: 10; 
	  left: 0;
	  top: 0;
	  width: 100%; 
	  height: 100%;
	  overflow: auto; 
	  background-color: rgb(0,0,0); 
	  background-color: rgba(0, 0, 0, 0.5); 
	}
	.modal .modal-content{
	  /* 실제 모달창 부분 */
	  background-color : #3f51b5;
	  padding: 20px;
	  border: 1px solid #fff;
	  width: 60%;
	  color : #fff;
	  position: absolute;
	  top : 50%;
	  left : 50%;
	  transform: translate(-50%, -50%);
	  text-align: center;
	}
	/* close button */
	.close {
	  color: #fff;
	  float: right;
	  font-size: 28px;
	  font-weight: bold;
	  cursor:pointer;
	}
</style>
<!-- <meta charset="UTF-8"> -->
<title>Insert title here</title>
<link href="${path}/resources/css/include.css" rel="stylesheet"/>
</head>
<body>
	<div id="grid_container">
		<jsp:include page="include.jsp" />
		<nav id="side">
			<div id="side_menu" style="overflow-y: auto;">
			
			<!-- <input type="button" value="일정쓰기"> -->
			<input class="add-button" type="button" onclick="click_add();" value="일정 추가">
			
			</div>
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
		
			<!-- Calendar -->
			<div id='calendar'></div>
			
			
			<!-- Modal -->
			<section class="modal">
			  <article class="modal-content">
			    <span class="close">&times;</span>
			    <h2 class="title"></h2>
			    <p class="description"></p>
			  </article>
			</section>

		
		
		</article>	<!-- 메인 기능 들어갈 부분 끝 -->
	</div>
</body>
</html>