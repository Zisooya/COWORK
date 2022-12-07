<%@ page session="false" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/timepicker@1.14.0/jquery.timepicker.min.css"> -->
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js"></script>
<script>
	document.addEventListener('DOMContentLoaded',function() {
		// Event 조회용 변수 : g(global variable:전역변수) + 변수명
		var gTitle;
		var gStartTime;
		var gEndTime;
		var gAllDay;
		var gMemo;
		var gPlace;
		// Event 추가용 변수 : a(add) + 변수명
		var aTitle;
		var aAllday;
		/* ------------------------------------모달창 관련------------------------------------ */
		const modal_detail = document.querySelector(".modal_detail");
		const closeBtn_detail = document.querySelector(".close_detail");
		const modal_add = document.querySelector(".modal_add");
		const closeBtn_add = document.querySelector(".close_add");

		const allDay_checkBox_add = document.querySelector(".add_allDay");
		const startTime_add = document.querySelector(".add_startTime");
		const endTime_add = document.querySelector(".add_endTime");
		//종일(allDay) 체크 시 시간선택 요소 사라짐 func
		allDay_checkBox_add.onclick = function() {
			if (allDay_checkBox_add.checked == true) {
				startTime_add.style.display = 'none';
				endTime_add.style.display = 'none';
			} else {
				startTime_add.style.display = 'inline';
				endTime_add.style.display = 'inline';
			}
		}
		//close 버튼 클릭 시 모달창 닫힘 func
		closeBtn_detail.onclick = function() {
			modal_detail.style.display = "none";
		}
		closeBtn_add.onclick = function() {
			modal_add.style.display = "none";
		}
		//빈 여백 클릭 시 모달창 닫힘 func
		window.onclick = function() {
			if (event.target == modal_detail) {
				modal_detail.style.display = "none";
			}
		}
		// 상세정보 모달창 오픈 func
		function detail() {
			const title = document.querySelector(".title");
			const startTime = document.querySelector(".startTime");
			const endTime = document.querySelector(".endTime");
			const memo = document.querySelector(".memo");
			const place = document.querySelector(".place");
			title.innerText = gTitle;
			if (gAllDay == true) {
				startTime.innerText = moment(gStartTime).format("YYYY.MM.DD (ddd)");
				if (moment(gStartTime).format("YYYY.MM.DD") == moment(gEndTime).format("YYYY.MM.DD")) {
				} else {
					endTime.innerText = moment(gEndTime).format("YYYY.MM.DD (ddd)");
				}
			} else {
				startTime.innerText = moment(gStartTime).format("YYYY.MM.DD (ddd) HH:mm");
				if (moment(gStartTime).format("YYYY.MM.DD") == moment(gEndTime).format("YYYY.MM.DD")) {
					endTime.innerText = moment(gEndTime).format("HH:mm");
				} else {
					endTime.innerText = moment(gEndTime).format("YYYY.MM.DD (ddd) HH:mm");
				}
			}
			memo.innerText = gMemo;
			place.innerText = gPlace;
			modal_detail.style.display = "block";
		}
		// 일정 추가 모달창 오픈 func
		function add() {
			modal_add.style.display = "block";
		}
		/* ------------------------------------모달창 관련 끝------------------------------------ */
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl,{
			/* initialDate: '2022-12-01', */
			locale : "ko",
			headerToolbar : {
				left : 'prev,next today',
				center : 'title',
				right : 'dayGridMonth,timeGridWeek,timeGridDay'
			},
			selectable : true,
			editable : true,
			select : function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
				add();
				/* var title_d = prompt('Event Title:');
				if (title_d) {
				  calendar.addEvent({
				    title: title_d,
				    start: arg.start,
				    end: arg.end,
				    allDay: arg.allDay
				  })
				} */
				calendar.unselect()
			},
			dayMaxEvents : true,
			events : function(info, successCallback,failureCallback) {
				// ajax 처리로 데이터를 로딩 시킨다.
				$.ajax({
					type : "get",
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					url : "calendarList.do?no=3",
					dataType : "json",
					success : function(result) {
						var events = [];
						if (result != null) {
							$.each(result,function(index,element) {
								var eId = element.cal_no;
								var eTitle = element.title;
								var eStartDate = element.start;
								var eEndDate = element.end;
								var eAllday;
								var eMemo = element.cal_memo;
								var ePlace = element.cal_place;
								if (element.allDay == "true") {
									eAllday = true;
								} else {
									eAllday = false;
								}
								if (eEndDate == null) {
									eEndDate = eStartDate;
								}
								events.push({
									id : eId,
									title : eTitle,
									start : eStartDate,
									end : eEndDate,
									allDay : eAllday,
									memo : eMemo,
									place : ePlace
								}); // push() end
							}); // each() end
						} // if() end 
						successCallback(events);
					} // success: function() end
				}); // ajax end
			}, // events: end
			/* dateClick: function() {}, */
			/* ------------------------------------이벤트 클릭------------------------------------ */
			eventClick : function(info) {
				var eventObj = info.event;
				gTitle = eventObj.title;
				gStartTime = eventObj.start;
				gEndTime = eventObj.end;
				gAllDay = eventObj.allDay;
				gMemo = eventObj.extendedProps.memo;
				gPlace = eventObj.extendedProps.place;
				detail();
			},
			/* ------------------------------------이벤트 클릭 끝------------------------------------ */
		});
		/* ------------------------------------날짜 클릭------------------------------------ */
		calendar.on('dateClick', function(info) {
			console.log(info.dateStr);
		});
		/* ------------------------------------날짜 클릭 끝------------------------------------ */
		calendar.render();
	});
	$(function(){
		$('input.timepicker').timepicker({
		    timeFormat: 'h:mm p',
		    interval: 60,
		    minTime: '10',
		    maxTime: '6:00pm',
		    defaultTime: '13',
		    startTime: '10:00',
		    dynamic: true,
		    dropdown: true,
		    scrollbar: true
		});
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
.modal_detail {
	/* 모달 뒷배경 */
	display: none;
	position: fixed;
	z-index: 10;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.5);
}

.modal_detail .modal-content_detail {
	/* 실제 모달창 부분 */
	background-color: #3f51b5;
	padding: 20px;
	border: 1px solid #fff;
	width: 60%;
	color: #fff;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	text-align: left;
}

.modal_add {
	/* 모달 뒷배경 */
	display: none;
	background-color: #fff;
	color: #000;
	position: fixed;
	z-index: 10;
	left: 0%;
	top: 0%;
	width: 100%;
	height: 100%;
	overflow: auto;
	/* background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.5); */
}

/* .modal_add .modal-content_add{
	/* 실제 모달창 부분 */
	background-color: #3f51b5;
	padding: 20px;
	border: 1px solid #fff;
	width: 60%;
	color: #fff;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	text-align: left;
} */
/* close button */
.close_detail {
	color: #fff;
	float: right;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

.close_add {
	color: #000;
	float: right;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}
#calendar {
	z-index: 0;
}

a {
	text-decoration: none;
	color: #000;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${path}/resources/css/include.css" rel="stylesheet" />
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
		<article id="content">
			<!-- 메인 기능 들어갈 부분 -->

			<!-- 일정 검색 -->
			<form method="post" action="<%=request.getContextPath()%>/calendar_search.do">
				<select name="field">
					<option value="title">제목</option>
					<option value="cont">내용</option>
					<option value="writer">작성자</option>
				</select> <input name="keyword">&nbsp;&nbsp; <input type="submit" value="검색">
			</form>

			<!-- Calendar -->
			<div id='calendar'></div>


			<!-- Modal - Detail -->
			<section class="modal_detail">
				<article class="modal-content_detail">
					<span class="close_detail">&times;</span>
					<h2 class="title"></h2>
					<span class="startTime"></span> - <span class="endTime"></span>
					<p class="memo"></p>
					<p class="place"></p>
				</article>
			</section>


			<!-- Modal - Add -->
			<section class="modal_add">
				<!-- <article class="modal-content_add"> -->
					<span class="close_add">&times;</span>
					제목 <input type="checkbox" class="add_mark"> <input class="add_title">
					<br>
					일시 <input type="date" class="add_startDate">
					<input id="add_startTime" type="text" class="timepicker" value="" maxlength="10">
					 - 
					<input type="date" class="add_endDate">
					<input id="add_endTime" type="text" class="timepicker" value="" maxlength="10">
					<!-- <p id="datepairExample">
						<input type="text" class="date start" />
						<input type="text" class="time start" /> to
						<input type="text" class="time end" />
						<input type="text" class="date end" />
					</p>
					
					<script>
						// initialize input widgets first
						$('#datepairExample .time').timepicker({
							'showDuration': true,
							'timeFormat': 'g:ia'
						});
					
						$('#datepairExample .date').datepicker({
							'format': 'yyyy-m-d',
							'autoclose': true
						});
					
						// initialize datepair
						$('#datepairExample').datepair();
					</script> -->
					<br>
					<input type="checkbox" class="add_allDay"> 종일 &nbsp;<select></select>
					<br>
					캘린더 <select></select>
					<br>
					참석자 <input> <input type="button" value="주소록">
					<br>
					장소 <input class="add_place">
					<br>
					메모 <textarea class="add_memo"></textarea>
					<br>
					파일첨부 <input type="button" value="내 PC">
					<hr>
					범주 <select></select>
					<br>
					상태 <input type="radio" name="statusRadio"> <input type="radio" name="statusRadio">
					<br><br> <input type="button" value="저장">
				<!-- </article> -->
			</section>

		</article>
		<!-- 메인 기능 들어갈 부분 끝 -->
	</div>
<!-- <script src="https://cdn.jsdelivr.net/npm/timepicker@1.14.0/jquery.timepicker.min.js"></script> -->
</body>
</html>