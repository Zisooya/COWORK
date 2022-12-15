<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script> -->
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js"></script>
<script>
	jQuery.datetimepicker.setLocale('kr');
	const Toast = Swal.mixin({
	    toast: true,
	    position: 'top-start',
	    showConfirmButton: false,
	    timer: 3000,
	    timerProgressBar: true,
	    didOpen: (toast) => {
	        toast.addEventListener('mouseenter', Swal.stopTimer)
	        toast.addEventListener('mouseleave', Swal.resumeTimer)
	    }
	})
	 
	// 요일 구하는 함수
	function getDayOfWeek(date_str){ //ex) getDayOfWeek('2022-06-13')
	    const week = ['일','월','화','수','목','금','토'];
	    const dayOfWeek = week[new Date(date_str).getDay()];
	    return dayOfWeek;
	}
	// 몇번째 주인지 구하는 함수
	function getWeekNo(date_str) {
		 var date = new Date();
		 if(date_str){
		  date = new Date(date_str);
		 }
		 return Math.ceil(date.getDate() / 7);
	}
	
	document.addEventListener('DOMContentLoaded',function() {
		/* ------------------------------------모달창 관련------------------------------------ */
		const modal_detail = document.querySelector(".modal_detail");
		const closeBtn_detail = document.querySelector(".close_detail");
		const modal_add = document.querySelector(".modal_add");
		const closeBtn_add = document.querySelector(".close_add");

		/* const allDay_checkBox_add = document.querySelector(".add_allDay");
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
		} */
		
		//close 버튼 클릭 시 모달창 닫힘 함수
		closeBtn_detail.onclick = function() {
			modal_detail.style.display = "none";
		}
		closeBtn_add.onclick = function() {
			modal_add.style.display = "none";
		}
		//빈 여백 클릭 시 모달창 닫힘 함수
		window.onclick = function() {
			if (event.target == modal_detail) {
				modal_detail.style.display = "none";
			}
		}
		// 상세정보 모달창 오픈 함수
		function detail() {
			const title = document.querySelector(".title");
			const startTime = document.querySelector(".startTime");
			const endTime = document.querySelector(".endTime");
			const memo = document.querySelector(".memo");
			const place = document.querySelector(".place");
			const cal_name = document.querySelector(".cal_name");
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
			cal_name.innerText = gCalName;
			modal_detail.style.display = "block";
		}
		// 일정 추가 모달창 오픈 함수
		function add() {
			modal_add.style.display = "block";
		}
		/* ------------------------------------모달창 관련 끝------------------------------------ */
		
		// Event 조회용 변수 : g(global variable:전역변수) + 변수명
		var gTitle;
		var gStartTime;
		var gEndTime;
		var gAllDay;
		var gMemo;
		var gPlace;
		var gCalName;
		// Event 추가용 변수 : a(add) + 변수명
		var aTitle;
		var aAllday;
		
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
				/* 모달창 뜨자마자 시작일, 종료일 세팅(로직은 맞는데 실행안됨)
				const startTime = document.querySelector("#add_startTime");
				alert(moment(arg.start).format("YYYY-MM-DD HH:mm"));
				startTime.innerText = moment(arg.start).format("YYYY-MM-DD HH:mm");
				*/
				const repeat_w = document.querySelector("#repeat_w");
				repeat_w.innerText = '매주 ' + getDayOfWeek(arg.start) + '요일';
				repeat_m.innerText = '매월 ' + getWeekNo(arg.start) + '번째 ' + getDayOfWeek(arg.start) + '요일';
				repeat_y.innerText = '매년 ' + moment(arg.start).format("MM") + '월 ' + moment(arg.start).format("DD") + '일';
				/* 원래 있던 예시 코드
				var title_d = prompt('Event Title:');
				if (title_d) {
				  calendar.addEvent({
				    title: title_d,
				    start: arg.start,
				    end: arg.end,
				    allDay: arg.allDay
				  })
				}
				*/
				calendar.unselect()
			},
			dayMaxEvents : true,
			events : function (info, successCallback,failureCallback) {
				// ajax 처리로 데이터를 로딩 시킨다.
				$.ajax({
					type : "get",
					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
					url : "calendarList.do?no=${member.mem_no}",
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
								var eCalName = element.cal_type_name;
								var eColor;
								if (element.cal_category != null) {
									eColor = element.cal_category;
								} else {
									eColor = element.cal_type_color;
								}
								if (element.allDay == "true") {
									eAllday = true;
								} else {
									eAllday = false;
								}
								if (eEndDate == null) {
									eEndDate = eStartDate;
								}
								events.push({
									color : eColor,
									id : eId,
									title : eTitle,
									start : eStartDate,
									end : eEndDate,
									allDay : eAllday,
									memo : eMemo,
									place : ePlace,
									cal_name : eCalName
								}); // push() end
							}); // each() end
						} // if() end 
						successCallback(events);
					} // success: function() end
				}); // ajax end
			}, // events : function end
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
				gCalName = eventObj.extendedProps.cal_name;
				detail();
			},
			/* ------------------------------------이벤트 클릭 끝------------------------------------ */
		});
		/* calendar.on('dateClick', function(info) {
			console.log(info.dateStr);
		}); */
		let allday_check = document.getElementById("allday_check");
		allday_check.onclick = function() {
			if (allday_check.checked == true){
				$(".datetimepicker").datetimepicker({ 
					timepicker:false
				});
				const origin_startTime_val = document.getElementById("add_startTime").value;
				const origin_endTime_val = document.getElementById("add_endTime").value;
				const final_startTime_val = origin_startTime_val.substr(0, 11);
				const final_endTime_val = origin_endTime_val.substr(0, 11);
				if(origin_startTime_val != ""){
					$("#add_startTime").val(final_startTime_val + "00:00");
				}else {
					$("#add_startTime").val();
				}
				if(origin_endTime_val != ""){
					$("#add_endTime").val(final_endTime_val + "00:00");
				}else {
					$("#add_endTime").val();
				}
			} else {
				$(".datetimepicker").datetimepicker({ 
					timepicker:true
				});
			}
		}
		
		$("#save_btn").click( function() {
			/* var formData = new FormData();
			var inputFile = $("input[id='formFileSm']");
			var files = inputFile[0].files;
			console.log(files);
			// add fileData to formData
			for(var i=0; i<files.length; i++) {
				formData.append("uploadFile", files[i]);
			} */
			var form = $('#add_form')[0];
	        var formData = new FormData(form);
			$.ajax({
				type : 'POST',
				enctype: "multipart/form-data",
				url : 'upload_ok.do',
				cache: false, // 필수
				processData : false, // 필수 
				contentType : false, // 필수 
				data : formData,
				success : function(result) {
					alert(result);
				},
				error : function() {
					alert("파일 첨부 도중 에러 발생");
				}
			});
		});
		calendar.render();
	});
	$(function(){
		let add_startTime_val;
		let start_date_select;
		let add_endTime_val;
		let end_date_select;
		const save_btn = document.getElementById('save_btn');
		function end_must_more() { // 시작일 > 종료일 이면 나오는 알림창, 저장 버튼도 비활성화
			if(start_date_select > end_date_select) {
				save_btn.disabled = true;
				Toast.fire({
					showCloseButton: true,
					width: '27%',
				    icon: 'error',
				    title: '종료일은 시작일 이후여야 합니다.'
				})
			}else {
				save_btn.disabled = false;
			}
		}
		$("#add_startTime").change(function(){ // 시작일 변경 시 : 요일 글자(ex:(금)) 추가, 반복 select 글자 변경
			add_startTime_val = document.getElementById("add_startTime").value;
			start_date_select = new Date(add_startTime_val.substr(0, 16));
			$("#add_startTime").val(add_startTime_val + " ("+getDayOfWeek(start_date_select)+")");
			
			const repeat_w = document.querySelector("#repeat_w");
			repeat_w.innerText = '매주 ' + getDayOfWeek(start_date_select) + '요일';
			repeat_m.innerText = '매월 ' + getWeekNo(start_date_select) + '번째 ' + getDayOfWeek(start_date_select) + '요일';
			repeat_y.innerText = '매년 ' + moment(start_date_select).format("MM") + '월 ' + moment(start_date_select).format("DD") + '일';
			
			end_must_more();
		});
		$("#add_endTime").change(function(){ // 종료일 변경 시 : 요일 글자(ex:(금)) 추가
			add_endTime_val = document.getElementById("add_endTime").value;
			end_date_select = new Date(add_endTime_val.substr(0, 16));
			$("#add_endTime").val(add_endTime_val + " ("+getDayOfWeek(end_date_select)+")");
			
			end_must_more();
		});
		
		$(".datetimepicker").datetimepicker({ 
			format: "Y-m-d H:i",
			step : 30,
			timepicker:true
		});
		/* // timepicker 위젯 30분 단위 올림 처리
		var start_time_minute = moment().format("mm");
		var remainder_start_time_minute;
		if(start_time_minute <= 30) {
			remainder_start_time_minute = 30 - start_time_minute;
		}else {
			remainder_start_time_minute = 60 - start_time_minute;
		}
		var	start_time = moment().add(remainder_start_time_minute, "m").format("HH:mm");
		var remainder_end_time_minute = remainder_start_time_minute + 60;
		var end_time = moment().add(remainder_end_time_minute, "m").format("HH:mm");
		// timepicker 위젯 func
		$('#add_startTime').timepicker({
		    timeFormat: 'h:mm p',
		    interval: 30,
		    minTime: '0:00am',
		    maxTime: '11:30pm',
		    defaultTime: start_time,
		    startTime: '00:00',
		    dynamic: true,
		    dropdown: true,
		    scrollbar: true
		});
		$('#add_endTime').timepicker({
		    timeFormat: 'h:mm p',
		    interval: 30,
		    minTime: '0:00am',
		    maxTime: '11:30pm',
		    defaultTime: end_time,
		    startTime: '00:00',
		    dynamic: true,
		    dropdown: true,
		    scrollbar: true
		}); */
	});
</script>
<style type="text/css">
/* bootstrap fullcalendar에 적용안하기 */
a {
	text-decoration: none;
	color: #000;
}

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
/* close button 끝*/
/* modal창 관련 */
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
	padding: 2%;
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
	/* 모달창(add는 뒷배경없음)) */
	display: none;
	padding: 2%;
	background-color: #fff;
	color: #000;
	position: fixed;
	z-index: 10;
	left: 0%;
	top: 0%;
	width: 100%;
	height: 100%;
	overflow: auto;
}
/* modal창 관련 끝 */
/* 검색창 관련 */
.form-select {
	width: 7%;
}
.form-control{
	width: 15%;
}
.search-form {
	display: flex;
}
/* 검색창 관련 끝 */
/* 일정 추가 창 관련 */
.add_mark {
    visibility:hidden;
    cursor:pointer;
    transform: scale(.04);
    position: relative;
    top: -10px;
    left: -10px;
}
.add_mark:before {
   content: url("https://cdn-icons-png.flaticon.com/512/149/149220.png");
   position: absolute;
   visibility:visible;
}
.add_mark:checked:before {
   content: url("https://cdn-icons-png.flaticon.com/512/148/148839.png");
   position: absolute;
}

#my_setting {
	font-size: 12px;
	color: gray;
	position: relative;
	top: -10px;
}
/* 일정 추가 창 관련 끝 */
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
				<input class="btn btn-success" type="button" onclick="click_add();" value="일정 추가">
			</div>
		</nav>
		<article id="content">
			<!-- 메인 기능 들어갈 부분 -->

			<!-- 일정 검색 -->
			<form method="post" action="<%=request.getContextPath()%>/calendar_search.do" class="search-form" id="search_form">
				<select name="field" class="form-select">
					<option value="title">제목</option>
					<option value="cont">내용</option>
					<option value="writer">작성자</option>
				</select>&nbsp;
				<input name="keyword" class="form-control" type="text" placeholder="검색어를 입력하세요.">&nbsp;&nbsp;
				<input type="button" value="검색" class="btn btn-primary" id="search_btn">
			</form>

			<br>
			<!-- Calendar -->
			<div id='calendar'></div>


			<!-- Modal - Detail -->
			<section class="modal_detail">
				<article class="modal-content_detail">
					<span class="close_detail">&times;</span>
					<h2 class="title"></h2>
					일시 <span class="startTime"></span> - <span class="endTime"></span>
					<br>
					메모 <span class="memo"></span>
					<br>
					장소 <span class="place"></span>
					<br>
					캘린더 <span class="cal_name"></span>
				</article>
			</section>


			<!-- Modal - Add -->
			<section class="modal_add">
				<form id="add_form" method="post" enctype="multipart/form-data">
				<!-- <article class="modal-content_add"> -->
					<span class="close_add">&times;</span>
					<input type="hidden" name="mem_no" value="${member.mem_no}">
					제목
					<input type="checkbox" class="add_mark" name="cal_mark">
					<input class="add_title" name="title" placeholder="제목을 입력하세요.">
					<br>
					일시
					<input id="add_startTime" type="text" class="datetimepicker" name="startTime" placeholder="시작일을 선택하세요.">
					<!-- <input type="date" class="add_startDate" name="start">
					<input id="add_startTime" type="text" class="timepicker" value="" maxlength="10" name="startTime"> -->
					 - 
					<input id="add_endTime" type="text" class="datetimepicker" name="endTime" placeholder="종료일을 선택하세요.">
					<!-- <input type="date" class="add_endDate" name="end">
					<input id="add_endTime" type="text" class="timepicker" value="" maxlength="10"> -->
					<br>
					<input type="checkbox" class="add_allDay" name="allDay" id="allday_check"> 종일 &nbsp;
					<select>
						<option value="no_repeat">반복 안 함</option>
						<option value="cycle_d_1">매일</option>
						<option value="cycle_d_weekday">주중 매일(월-금)</option>
						<option value="cycle_w_1" id="repeat_w"></option>
						<option value="cycle_m_1" id="repeat_m"></option>
						<option value="cycle_y_1" id="repeat_y"></option>
					</select>
					<br>
					캘린더
					<select name="cal_type_name">
						<c:if test="${!empty member.mem_cal1}">
							<option value="${member.mem_cal1}" value2="${member.mem_cal1_color}">
							<c:choose>
								<c:when test="${member.mem_cal1_color eq 'red'}">
									🔴
								</c:when>
								<c:when test="${member.mem_cal1_color eq 'yellow'}">
									🟡
								</c:when>
								<c:when test="${member.mem_cal1_color eq 'green'}">
									🟢
								</c:when>
								<c:when test="${member.mem_cal1_color eq 'blue'}">
									🔵
								</c:when>
								<c:when test="${member.mem_cal1_color eq 'purple'}">
									🟣
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							[기본] ${member.mem_cal1}</option>
						</c:if>
						<c:if test="${!empty member.mem_cal2}">
							<option value="${member.mem_cal2}" value2="${member.mem_cal2_color}">
							<c:choose>
								<c:when test="${member.mem_cal2_color eq 'red'}">
									🔴
								</c:when>
								<c:when test="${member.mem_cal2_color eq 'yellow'}">
									🟡
								</c:when>
								<c:when test="${member.mem_cal2_color eq 'green'}">
									🟢
								</c:when>
								<c:when test="${member.mem_cal2_color eq 'blue'}">
									🔵
								</c:when>
								<c:when test="${member.mem_cal2_color eq 'purple'}">
									🟣
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							${member.mem_cal2}</option>
						</c:if>
						<c:if test="${!empty member.mem_cal3}">
							<option value="${member.mem_cal3}" value2="${member.mem_cal3_color}">
							<c:choose>
								<c:when test="${member.mem_cal3_color eq 'red'}">
									🔴
								</c:when>
								<c:when test="${member.mem_cal3_color eq 'yellow'}">
									🟡
								</c:when>
								<c:when test="${member.mem_cal3_color eq 'green'}">
									🟢
								</c:when>
								<c:when test="${member.mem_cal3_color eq 'blue'}">
									🔵
								</c:when>
								<c:when test="${member.mem_cal3_color eq 'purple'}">
									🟣
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							${member.mem_cal3}</option>
						</c:if>
					</select>
					<br>
					참석자
					<input name="cal_attendee1" placeholder="이름을 입력하세요.">
					<input type="button" value="주소록">
					<br>
					장소
					<input class="add_place" name="cal_place" placeholder="장소를 입력하세요.">
					<br>
					메모
					<textarea class="add_memo" name="cal_memo" placeholder="메모를 작성하세요"></textarea>
					<br>
					파일첨부
					<input class="form-control form-control-sm" id="formFileSm" type="file" name="file1">
					<hr>
					<span id="my_setting">내 설정</span>
					<br>
					범주
					<select name="cal_category">
						<option value="none">없음</option>
						<option value="red">🟥</option>
						<option value="orange">🟧</option>
						<option value="yellow">🟨</option>
						<option value="green">🟩</option>
						<option value="blue">🟦</option>
						<option value="purple">🟪</option>
					</select>
					<br>
					상태
					<input type="radio" name="cal_status" value="바쁨" checked>바쁨 <input type="radio" name="cal_status" value="한가함">한가함
					<br><br> <input type="button" value="저장" id="save_btn">
				<!-- </article> -->
				</form>
			</section>

		</article>
		<!-- 메인 기능 들어갈 부분 끝 -->
	</div>
</body>
</html>