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
	jQuery.datetimepicker.setLocale('kr');	// datetimepicker 한글 설정
	
	const Toast = Swal.mixin({	// toast창 설정(시작일 > 종료일 선택 시)
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
	
	// 날짜 뒤에 요일(ex:2022-12-15 (목)) 추가 시 필요한 변수
	let add_startTime_val;
	let start_date_select;
	let add_endTime_val;
	let end_date_select;
	
	// Event 조회용 변수 : g(global variable:전역변수) + 변수명
	var gTitle;
	var gStartTime;
	var gEndTime;
	var gAllDay;
	var gMemo;
	var gPlace;
	var gCalTypeNo;
	var gCalName;
	var gMark;
	// Event 추가용 변수 : a(add) + 변수명
	var aTitle;
	var aAllday;
	var calendar;
	document.addEventListener('DOMContentLoaded',function() {
		/* ------------------------------------모달창 관련------------------------------------ */
		const modal_detail = document.querySelector(".modal_detail");
		const closeBtn_detail = document.querySelector(".close_detail");
		const updateBtn_detail = document.querySelector("#update_btn");
		const deleteBtn_detail = document.querySelector("#delete_btn");
		const modal_add = document.querySelector(".modal_add");
		const closeBtn_add = document.querySelector(".close_add");
		
		const title = document.querySelector(".title");
		const startTime = document.querySelector(".startTime");
		const endTime = document.querySelector(".endTime");
		const memo = document.querySelector(".memo");
		const place = document.querySelector(".place");
		const cal_name = document.querySelector(".cal_name");
		const mark = document.querySelector("#mark_detail");
		const time_dash = document.querySelector("#time_dash");
		
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
		updateBtn_detail.onclick = function() {
			modal_detail.style.display = "none";
			add();
			$(".add_title").val(gTitle);
			
			if (gMark == "주요") {
				document.getElementById("mark_check").checked = true;
			}else {
				document.getElementById("mark_check").checked = false;
			}
			
			var startTime_to_input = moment(gStartTime).subtract(9, "h").format("YYYY-MM-DD HH:mm");
			var endTime_to_input;
			if (gAllDay == true) {
				document.getElementById("allday_check").checked = true;
				$(".datetimepicker").datetimepicker({ 
					timepicker:false
				});
				endTime_to_input = moment(gEndTime).subtract(33, "h").format("YYYY-MM-DD HH:mm");
			}else {
				document.getElementById("allday_check").checked = false;
				$(".datetimepicker").datetimepicker({ 
					timepicker:true
				});
				endTime_to_input = moment(gEndTime).subtract(9, "h").format("YYYY-MM-DD HH:mm");
			}
			//$('#add_startTime').attr("value", startTime_to_input);
			//$('#add_endTime').attr("value", endTime_to_input);
			// 날짜 뒤에 요일 추가
			start_date_select = new Date(startTime_to_input.substr(0, 16));
			end_date_select = new Date(endTime_to_input.substr(0, 16));
			$("#add_startTime").val(startTime_to_input + " ("+getDayOfWeek(start_date_select)+")");
			$("#add_endTime").val(endTime_to_input + " ("+getDayOfWeek(end_date_select)+")");
			
			// 날짜 선택에 따른 라디오 텍스트 변경
			const repeat_w = document.querySelector("#repeat_w");
			repeat_w.innerText = '매주 ' + getDayOfWeek(start_date_select) + '요일';
			repeat_m.innerText = '매월 ' + getWeekNo(start_date_select) + '번째 ' + getDayOfWeek(start_date_select) + '요일';
			repeat_y.innerText = '매년 ' + moment(start_date_select).format("MM") + '월 ' + moment(start_date_select).format("DD") + '일';
			
			var calTypeListJson = JSON.parse('${CalTypeList_Json}'); 
			for (var i = 0; i < calTypeListJson.length; i++){
				if(calTypeListJson[i].cal_type_no == gCalTypeNo) {
					var calTypeNo_matched = calTypeListJson[i].cal_type_no;
					$("#cal_type_no_select").val(calTypeNo_matched).prop("selected", true);
				}
			}
		}
		closeBtn_add.onclick = function() {
			modal_add.style.display = "none";
			gStartTime = new Date();
			$("#cal_type_no_select option:eq(0)").prop("selected",true);
		}
		//빈 여백 클릭 시 모달창 닫힘 함수
		window.onclick = function() {
			if (event.target == modal_detail) {
				modal_detail.style.display = "none";
			}
		}
		// 상세정보 모달창 오픈 함수
		function detail() {
			title.innerText = gTitle;
			if (gAllDay == true) {
				startTime.innerText = moment(gStartTime).format("YYYY.MM.DD (ddd)");
				endTime.innerText = moment(gEndTime).subtract(1, "d").format("YYYY.MM.DD (ddd)")
				if (moment(gStartTime).format("YYYY.MM.DD (ddd) HH:mm") == moment(gEndTime).subtract(1, "d").format("YYYY.MM.DD (ddd) HH:mm")) {
					time_dash.innerText = "";
					endTime.innerText = "";
				} else {
					time_dash.innerText = " - ";
				}
			} else {
				startTime.innerText = moment(gStartTime).subtract(9, "h").format("YYYY.MM.DD (ddd) HH:mm");
				time_dash.innerText = " - ";
				if (moment(gStartTime).format("YYYY.MM.DD") == moment(gEndTime).format("YYYY.MM.DD")) {
					endTime.innerText = moment(gEndTime).subtract(9, "h").format("HH:mm");
				} else {
					endTime.innerText = moment(gEndTime).subtract(9, "h").format("YYYY.MM.DD (ddd) HH:mm");
				}
			}
			memo.innerText = gMemo;
			place.innerText = gPlace;
			cal_name.innerText = gCalName;
			if(gMark != null) {
				mark.style.display = "inline";
			}else {
				mark.style.display = "none";
			}
			modal_detail.style.display = "block";
		}
		// 일정 추가 모달창 오픈 함수
		function add() {
			modal_add.style.display = "block";
		}
		/* ------------------------------------모달창 관련 끝------------------------------------ */
		
		var calendarEl = document.getElementById('calendar');
		calendar = new FullCalendar.Calendar(calendarEl,{
			/* initialDate: '2022-12-01', */
			locale : "ko",
			timeZone: 'UTC',
			/* allDay체크된 경우 +1해줘서 캘린더 상에서 제대로 보이게 해줌(근데 작동안함)
			eventDataTransform: function(event) {
				if(event.allDay) {
					event.end = moment(event.end).add(1, 'days');
				}
				return event;
			},
			*/
			headerToolbar : {
				left : 'myPrev,myNext myToday',
				center : 'title',
				right : 'dayGridMonth,timeGridWeek,timeGridDay'
			},
			customButtons: {
				myToday: {
					text: '오늘',
					click: function() {
						calendar.today();
						loadYYMM(calendar.getDate());
						init.activeDate.setTime(calendar.getDate());
						init.monForChange = calendar.getDate().getMonth();
					}
				},
				myPrev: {
					text: '◀',
					click: function() {
						calendar.prev();
						loadYYMM(calendar.getDate());
						init.activeDate.setTime(calendar.getDate());
						init.monForChange = calendar.getDate().getMonth();
					}
				},
				myNext: {
					text: '▶',
					click: function() {
						calendar.next();
						loadYYMM(calendar.getDate());
						init.activeDate.setTime(calendar.getDate());
						init.monForChange = calendar.getDate().getMonth();
					}
				}
			},
			selectable : true,
			editable : true,
			select : function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
				// 일정 추가 창 호출
				add();
				$(".add_title").val("");
				// input태그에 선택한 날짜 넣기
				const startTime_to_input = moment(arg.start).format("YYYY-MM-DD 00:00");
				const endTime_to_input = moment(arg.end).subtract(1, "d").format("YYYY-MM-DD 00:00");
				$('#add_startTime').attr("value", startTime_to_input);
				$('#add_endTime').attr("value", endTime_to_input);
				// 날짜 뒤에 요일 추가
				start_date_select = new Date(startTime_to_input.substr(0, 16));
				$("#add_startTime").val(startTime_to_input + " ("+getDayOfWeek(start_date_select)+")");
				end_date_select = new Date(endTime_to_input.substr(0, 16));
				$("#add_endTime").val(endTime_to_input + " ("+getDayOfWeek(end_date_select)+")");

				$(".datetimepicker").datetimepicker({ 
					timepicker:false
				});
				document.getElementById("mark_check").checked = false;
				document.getElementById("allday_check").checked = true;
				
				// 날짜 선택에 따른 라디오 텍스트 변경
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
								var eCalTypeNo = element.cal_type_no;
								var eCalName;
								var eColor;
								var eMark = element.cal_mark;
								
								// category값 설정되어있으면 그 색을 우선 적용
								if (element.cal_category != "none") {
									eColor = element.cal_category;
								} else {
									var calTypeListJson = JSON.parse('${CalTypeList_Json}'); 
									for (var i = 0; i < calTypeListJson.length; i++){
										if(calTypeListJson[i].cal_type_no == eCalTypeNo) {
											eColor = calTypeListJson[i].cal_type_color;
											eCalName = calTypeListJson[i].cal_type_name;
										}
									}
								}
								
								if (element.allDay == "on") {
									eAllday = true;
								} else {
									eAllday = false;
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
									cal_type_no : eCalTypeNo,
									cal_name : eCalName,
									mark : eMark
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
				gCalTypeNo = eventObj.extendedProps.cal_type_no;
				gCalName = eventObj.extendedProps.cal_name;
				gMark = eventObj.extendedProps.mark;
				detail();
			},
			/* ------------------------------------이벤트 클릭 끝------------------------------------ */
			/* ------------------------------------드래그 수정------------------------------------ */
			eventDrop: function (info){
                var eventObj = info.event;
                var obj = new Object();
                
                obj.id = eventObj.id;
                obj.start = eventObj.start;
                obj.end = eventObj.end;
                
    			$.ajax({
    				url : 'cal_update_drag.do',
    				type : 'POST',
    				data: JSON.stringify(obj),
    				contentType: 'application/json',
    				success : function(result) {
    					alert(result);
    				},
    				error : function() {
    					alert("날짜 업데이트 중 에러 발생");
    				}
    			});
                
                /* 인터넷에서 가져온 원본 코드
                $(function deleteData() {
                    $.ajax({
                        url: "/full-calendar/calendar-admin-update",
                        method: "PATCH",
                        dataType: "json",
                        data: JSON.stringify(events),
                        contentType: 'application/json',
                    })
                })
                */
            },
            /* ------------------------------------드래그 수정 끝------------------------------------ */
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
				// 날짜 뒤에 요일 추가
				add_startTime_val = document.getElementById("add_startTime").value;
				start_date_select = new Date(add_startTime_val.substr(0, 16));
				$("#add_startTime").val(add_startTime_val + " ("+getDayOfWeek(start_date_select)+")");
				add_endTime_val = document.getElementById("add_endTime").value;
				end_date_select = new Date(add_endTime_val.substr(0, 16));
				$("#add_endTime").val(add_endTime_val + " ("+getDayOfWeek(end_date_select)+")");
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
				url : 'cal_insert.do',
				cache: false, // 필수
				processData : false, // 필수 
				contentType : false, // 필수 
				data : formData,
				success : function(result) {
					console.log(result);
				},
				error : function() {
					console.log("파일 첨부 도중 에러 발생");
				}
			});
			document.location.reload();
		});
		
		// 일정 추가 버튼 클릭 시
		$("#eventAdd_btn").on("click", function() {
			add();
			$(".add_title").val("");
			let startTime_to_input_btn;
			
			if(gStartTime == new Date()) {
				startTime_to_input_btn = moment().format("YYYY-MM-DD 00:00");
			}else {
				startTime_to_input_btn = moment(gStartTime).format("YYYY-MM-DD 00:00");
			}
			//const startTime_to_input_btn = moment(gStartTime).format("YYYY-MM-DD 00:00");
			$('#add_startTime').attr("value", startTime_to_input_btn);
			$('#add_endTime').attr("value", startTime_to_input_btn);
			// 날짜 뒤에 요일 추가
			start_date_select = new Date(startTime_to_input_btn.substr(0, 16));
			$("#add_startTime").val(startTime_to_input_btn + " ("+getDayOfWeek(start_date_select)+")");
			$("#add_endTime").val(startTime_to_input_btn + " ("+getDayOfWeek(start_date_select)+")");
			
			$(".datetimepicker").datetimepicker({ 
				timepicker:false
			});
			document.getElementById("mark_check").checked = false;
			document.getElementById("allday_check").checked = true;
			
			// 날짜 선택에 따른 라디오 텍스트 변경
			const repeat_w = document.querySelector("#repeat_w");
			repeat_w.innerText = '매주 ' + getDayOfWeek(start_date_select) + '요일';
			repeat_m.innerText = '매월 ' + getWeekNo(start_date_select) + '번째 ' + getDayOfWeek(start_date_select) + '요일';
			repeat_y.innerText = '매년 ' + moment(start_date_select).format("MM") + '월 ' + moment(start_date_select).format("DD") + '일';
		});
		
		calendar.render();
		
	});
	$(function(){
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
			
			// 날짜 선택에 따른 라디오 텍스트 변경
			const repeat_w = document.querySelector("#repeat_w");
			repeat_w.innerText = '매주 ' + getDayOfWeek(start_date_select) + '요일';
			repeat_m.innerText = '매월 ' + getWeekNo(start_date_select) + '번째 ' + getDayOfWeek(start_date_select) + '요일';
			repeat_y.innerText = '매년 ' + moment(start_date_select).format("MM") + '월 ' + moment(start_date_select).format("DD") + '일';
			
			// 종일 미체크 시 시작일 변경하면 종료일은 무조건 시작일+1시간 되게
			let allday_check = document.getElementById("allday_check");
			if(allday_check.checked == false) {
				const start_add1hour = moment(add_startTime_val).add(1, 'h').format("YYYY-MM-DD HH:mm");;
				$("#add_endTime").val(start_add1hour);
				add_endTime_val = document.getElementById("add_endTime").value;
				end_date_select = new Date(add_endTime_val.substr(0, 16));
				$("#add_endTime").val(add_endTime_val + " ("+getDayOfWeek(end_date_select)+")");
			}else {
				$("#add_endTime").val(add_startTime_val);
				add_endTime_val = document.getElementById("add_endTime").value;
				end_date_select = new Date(add_endTime_val.substr(0, 16));
				$("#add_endTime").val(add_endTime_val + " ("+getDayOfWeek(end_date_select)+")");
			}
			
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
			timepicker:false
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
/* event 상세 창(modal) 관련 */
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
	top: 19%;
	width: 100%;
	height: 100%;
	overflow: auto;
}

.title {
	font-size: 20px;
	font-weight: bold;
}

#mark_detail {
	width: 2.7%;
	object-fit: cover;
	position: relative;
    top: -5px;
    padding-right: 5px;
}
/* event 상세 창(modal) 관련 끝 */
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
/* 일정 추가 창(modal) 관련 */
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
.modal_add_elements {
	padding: 0.3%;
}
/* 일정 추가 창(modal) 관련 끝 */
html, body {
  box-sizing: border-box;
  padding: 0;
  margin: 0;
}

*, *:before, *:after {
  box-sizing: inherit;
}

.clearfix:after {
  content: '';
  display: block;
  clear: both;
  float: none;
}

/* ======== Calendar ======== */
.my-calendar {
  width: 96%;
  margin: 5px;
  padding: 10px 10px 10px;
  text-align: center;
  font-weight: 800;
  border: 1px solid #ddd;
  cursor: default;
}
/* .my-calendar .clicked-date {
  border-radius: 25px;
  margin-top: 36px;
  float: left;
  width: 20%;
  padding: 20px 0 10px;
  background: #ddd;
} */
.my-calendar .calendar-box {
  /* float: right; */
  width: 45%;
  /* padding-left: 30px; */
}

/* .clicked-date .cal-day {
  font-size: 15px;
}
.clicked-date .cal-date {
  font-size: 15px;
} */

.ctr-box {
  padding: 0 16px;
  margin-bottom: 10px;
  font-size: 14px;
}
.ctr-box .btn-cal {
  position: relative;
  float: left;
  width: 25px;
  height: 25px;
  margin-top: 5px;
  font-size: 16px;
  cursor: pointer;
  border: none;
  background: none;
}
.ctr-box .btn-cal:after {
  content: '<';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  line-height: 25px;
  font-weight: bold;
  font-size: 15px;
}
.ctr-box .btn-cal.next {
  float: right;
}
.ctr-box .btn-cal.next:after {
  content: '>';
}

.cal-table {
  width: 100%;
}
.cal-table th {
  width: 14.2857%;
  padding-bottom: 5px;
  font-size: 14px;
  font-weight: 900;
}
.cal-table td {
  padding: 3px 0;
  height: 27px;
  font-size: 11px;
  vertical-align: middle;
}
.cal-table td.day {
  position: relative;
  cursor: pointer;
}
.cal-table td.today {
  background: #C2F347;
  border-radius: 50%;
  color: #fff;
}
.cal-table td.day-active {
  background: #E4F7BA;
  border-radius: 50%;
  color: #fff;
}
.cal-table td.has-event:after {
  content: '';
  display: block;
  position: absolute;
  left: 0;
  bottom: 0;
  width: 100%;
  height: 4px;
  background: #FFC107;
}
#calendar {
	height: 90%;
}
#eventAdd_btn {
	text-align: center;
	margin: 15px 0px 10px 0px;	
	border: 0;	
	border-radius: 5px;	
	box-sizing: border-box;	
	width: 86%;
	height: 46px;
	font-size: 0.9rem;
	font-weight: bold;		
	display: inline-block;
	padding: 12px 3px;
	background: #7BE66D;
	color: #FFF;
	cursor: pointer;
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
			<label id="side_label">캘린더</label>
			<div id="side_menu" style="overflow-y: auto;">
				<input type="button" id="eventAdd_btn" value="일정 추가">
				<div class="container">
					<div class="my-calendar clearfix">
						<!-- <div class="clicked-date">
							<div class="cal-day"></div>
							<div class="cal-date"></div>
						</div> -->
						<!-- <div class="calendar-box"> -->
							<div class="ctr-box clearfix">
								<button type="button" title="prev" class="btn-cal prev">
								</button>
								<span class="cal-year"></span>
								<span class="cal-month"></span>
								<button type="button" title="next" class="btn-cal next">
								</button>
							</div>
							<table class="cal-table">
								<thead>
									<tr>
										<th>일</th>
										<th>월</th>
										<th>화</th>
										<th>수</th>
										<th>목</th>
										<th>금</th>
										<th>토</th>
									</tr>
								</thead>
								<tbody class="cal-body"></tbody>
							</table>
						<!-- </div> -->
					</div>
					<!-- // .my-calendar -->
				</div>
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
				<!-- <input type="button" value=">" class="btn btn-primary" id="my-next-button"> -->
			</form>

			<br>
			<!-- Calendar -->
			<div id='calendar'></div>


			<!-- Modal - Detail -->
			<section class="modal_detail">
				<article class="modal-content_detail">
					<span class="close_detail">&times;</span>
					<img id="mark_detail" src="https://cdn-icons-png.flaticon.com/512/148/148839.png"><span class="title"></span><br>
					일시 <span class="startTime"></span><span id="time_dash"></span><span class="endTime"></span>
					<br>
					메모 <span class="memo"></span>
					<br>
					장소 <span class="place"></span>
					<br>
					캘린더 <span class="cal_name"></span>
					<br>
					<br>
					<input type="button" value="수정" id="update_btn">
					<input type="button" value="삭제" id="delete_btn">
				</article>
			</section>
			

			<!-- Modal - Add -->
			<section class="modal_add">
				<form id="add_form" method="post" enctype="multipart/form-data">
				<!-- <article class="modal-content_add"> -->
					<span class="close_add">&times;</span>
					<input type="hidden" name="mem_no" value="${member.mem_no}">
					<br>
					<div class="modal_add_elements">
						제목
						<input type="checkbox" class="add_mark" name="cal_mark" id="mark_check" value="주요">
						<input class="add_title" name="title" placeholder="제목을 입력하세요.">
					</div>
					<div class="modal_add_elements">
						일시
						<input id="add_startTime" type="text" class="datetimepicker" name="startTime" placeholder="시작일을 선택하세요.">
						<!-- <input type="date" class="add_startDate" name="start">
						<input id="add_startTime" type="text" class="timepicker" value="" maxlength="10" name="startTime"> -->
						 - 
						<input id="add_endTime" type="text" class="datetimepicker" name="endTime" placeholder="종료일을 선택하세요.">
						<!-- <input type="date" class="add_endDate" name="end">
						<input id="add_endTime" type="text" class="timepicker" value="" maxlength="10"> -->
					</div>
					<div class="modal_add_elements">
						<input type="checkbox" class="add_allDay" name="allDay" id="allday_check"> 종일
						<select name="cal_repeat">
							<option value="no_repeat">반복 안 함</option>
							<option value="cycle_d_1">매일</option>
							<option value="cycle_d_weekday">주중 매일(월-금)</option>
							<option value="cycle_w_1" id="repeat_w"></option>
							<option value="cycle_m_1" id="repeat_m"></option>
							<option value="cycle_y_1" id="repeat_y"></option>
						</select>
					</div>
					<div class="modal_add_elements">
						캘린더
						<select name="cal_type_no" id="cal_type_no_select">
							<c:forEach items="${CalTypeList}" var="dto" varStatus="i" begin="0" end="0">
								<option value="${dto.getCal_type_no()}">
								<c:choose>
									<c:when test="${dto.getCal_type_color() eq 'red'}">
										🔴
									</c:when>
									<c:when test="${dto.getCal_type_color() eq 'yellow'}">
										🟡
									</c:when>
									<c:when test="${dto.getCal_type_color() eq 'green'}">
										🟢
									</c:when>
									<c:when test="${dto.getCal_type_color() eq 'blue'}">
										🔵
									</c:when>
									<c:when test="${dto.getCal_type_color() eq 'purple'}">
										🟣
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
								[기본] ${dto.getCal_type_name()}</option>
							</c:forEach>
							<c:forEach items="${CalTypeList}" var="dto" varStatus="i" begin="1">
								<option value="${dto.getCal_type_no()}">
								<c:choose>
									<c:when test="${dto.getCal_type_color() eq 'red'}">
										🔴
									</c:when>
									<c:when test="${dto.getCal_type_color() eq 'yellow'}">
										🟡
									</c:when>
									<c:when test="${dto.getCal_type_color() eq 'green'}">
										🟢
									</c:when>
									<c:when test="${dto.getCal_type_color() eq 'blue'}">
										🔵
									</c:when>
									<c:when test="${dto.getCal_type_color() eq 'purple'}">
										🟣
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
								${dto.getCal_type_name()}</option>
							</c:forEach>
						</select>
					</div>
					<div class="modal_add_elements">
						참석자
						<input name="cal_attendee1" placeholder="이름을 입력하세요.">
						<input type="button" value="주소록">
					</div>
					<div class="modal_add_elements">
						장소
						<input class="add_place" name="cal_place" placeholder="장소를 입력하세요.">
					</div>
					<div class="modal_add_elements">
						메모
						<textarea class="add_memo" name="cal_memo" placeholder="메모를 작성하세요"></textarea>
					</div>
					<div class="modal_add_elements">
						<span>파일첨부</span> <input class="form-control form-control-sm" id="formFileSm" type="file" name="file1">
					</div>
					<hr>
					<span id="my_setting">내 설정</span>
					<div class="modal_add_elements">
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
					</div>
					<div class="modal_add_elements">
						상태
						<input type="radio" name="cal_status" value="바쁨" checked>바쁨 <input type="radio" name="cal_status" value="한가함">한가함
					</div>
					<br> <input type="button" value="저장" id="save_btn">
				<!-- </article> -->
				</form>
			</section>

		</article>
		<!-- 메인 기능 들어갈 부분 끝 -->
	</div>
	<script type="text/javascript">
	//================================
	//START YOUR APP HERE
	//================================
	const init = {
	monList: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	dayList: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
	today: new Date(),
	monForChange: new Date().getMonth(),
	activeDate: new Date(),
	getFirstDay: (yy, mm) => new Date(yy, mm, 1),
	getLastDay: (yy, mm) => new Date(yy, mm + 1, 0),
	nextMonth: function () {
	 let d = new Date();
	 d.setDate(1);
	 d.setMonth(++this.monForChange);
	 this.activeDate = d;
	 return d;
	},
	prevMonth: function () {
	 let d = new Date();
	 d.setDate(1);
	 d.setMonth(--this.monForChange);
	 this.activeDate = d;
	 return d;
	},
	addZero: (num) => (num < 10) ? '0' + num : num,
	activeDTag: null,
	getIndex: function (node) {
	 let index = 0;
	 while (node = node.previousElementSibling) {
	   index++;
	 }
	 return index;
	}
	};
	
	const $calBody = document.querySelector('.cal-body');
	const $btnNext = document.querySelector('.btn-cal.next');
	const $btnPrev = document.querySelector('.btn-cal.prev');
	
	/**
	* @param {number} date
	* @param {number} dayIn
	*/
	// 미니캘린더에서 선택한 일자가 일정추가 창에서 시작일이 되게
	function loadDate (date) {
		gStartTime = date;
	}
	/**
	* @param {date} fullDate
	*/
	function loadYYMM (fullDate) {
	let yy = fullDate.getFullYear();
	let mm = fullDate.getMonth();
	let firstDay = init.getFirstDay(yy, mm);
	let lastDay = init.getLastDay(yy, mm);
	let markToday;  // for marking today date
	
	if (mm === init.today.getMonth() && yy === init.today.getFullYear()) {
	 markToday = init.today.getDate();
	}
	
	document.querySelector('.cal-month').textContent = init.monList[mm];
	document.querySelector('.cal-year').textContent = yy+'년';
	
	let trtd = '';
	let startCount;
	let countDay = 0;
	for (let i = 0; i < 6; i++) {
	 trtd += '<tr>';
	 for (let j = 0; j < 7; j++) {
	   if (i === 0 && !startCount && j === firstDay.getDay()) {
	     startCount = 1;
	   }
	   if (!startCount) {
	     trtd += '<td>'
	   } else {
	     let fullDate = yy + '.' + init.addZero(mm + 1) + '.' + init.addZero(countDay + 1);
	     trtd += '<td class="day';
	     trtd += (markToday && markToday === countDay + 1) ? ' today" ' : '"';
	     trtd += ` data-date="${countDay + 1}" data-fdate="${fullDate}">`;
	   }
	   trtd += (startCount) ? ++countDay : '';
	   if (countDay === lastDay.getDate()) { 
	     startCount = 0; 
	   }
	   trtd += '</td>';
	 }
	 trtd += '</tr>';
	}
	$calBody.innerHTML = trtd;
	}
	
	/**
	* @param {string} val
	*/
	function createNewList (val) {
	let id = new Date().getTime() + '';
	let yy = init.activeDate.getFullYear();
	let mm = init.activeDate.getMonth() + 1;
	let dd = init.activeDate.getDate();
	const $target = $calBody.querySelector(`.day[data-date="${dd}"]`);
	
	let date = yy + '.' + init.addZero(mm) + '.' + init.addZero(dd);
	
	let eventData = {};
	eventData['date'] = date;
	eventData['memo'] = val;
	eventData['complete'] = false;
	eventData['id'] = id;
	init.event.push(eventData);
	$todoList.appendChild(createLi(id, val, date));
	}
	
	loadYYMM(init.today);
	//loadDate(init.today.getDate(), init.today.getDay());
	
	$btnNext.addEventListener('click', () => loadYYMM(init.nextMonth()));
	$btnPrev.addEventListener('click', () => loadYYMM(init.prevMonth()));
	
	$calBody.addEventListener('click', (e) => {
	if (e.target.classList.contains('day')) {
		if (init.activeDTag) {
		  init.activeDTag.classList.remove('day-active');
		}
		let day = Number(e.target.textContent);
		e.target.classList.add('day-active');
		init.activeDTag = e.target;
		init.activeDate.setDate(day);
		loadDate(init.activeDate);
		
		calendar.gotoDate(init.activeDate);
		//reloadTodo();
	}
	});
	
	</script>
</body>
</html>