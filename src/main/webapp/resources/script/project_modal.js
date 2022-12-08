/* 자동으로 TextArea 크기 늘리기 */
function resize(obj) {
	  obj.style.height = "2px";
	  obj.style.height = (12+obj.scrollHeight)+"px";
	}
$(function(){
	$(".hide").hide();
	$(".hide_1").hide();
	$("#child1").hide();
	$("#child1_1").hide();
	$("#child2").hide();
	$("#project_start").hide();
	$("#project_end").hide();
	$(".hidden").hide();
	$("#comment1_1").hide();
	
	/* 상세내용 div 클릭시 활성화 */
	$("#comment1").click(function(){
		$("#control1").css({'border':'1px solid gray'});
		$("#comment1").css({'border-style':'none'});
		$("#child1").show(100);
	});
	
	/* 상세내용 비활성화  */
	$(document).mouseup(function (e){ 
	    var container = $("#control1")
	    if(container.has(e.target).length == 0){ 
	    	$("#comment1").css({'border':'1px solid gray'});
	    	$("#control1").css({'border-color':'lightgray'})
			$("#control1").css({'border-style':'none'});
			$("#child1").hide();
	    }
	});
	
	/* 상세내용(수정본) div 클릭시 활성화 */
	$("#project_comment").click(function(){
		$("#control1_1").css({'border':'1px solid gray'});
		$("#project_comment").css({'border-style':'none'});
		$("#comment1_1").css({'border-style':'none'});
		$("#child1_1").show(100);
		$("#comment1_1").show();
		$("#project_comment").hide();
		
	});
	
	/* 상세내용(수정본) 비활성화  */
	$(document).mouseup(function (e){ 
	    var container = $("#control1_1")
	    if(container.has(e.target).length == 0){ 
	    	$("#project_comment").css({'border':'1px solid gray'});
	    	$("#control1_1").css({'border-color':'lightgray'})
			$("#control1_1").css({'border-style':'none'});
			$("#child1_1").hide(); 
			$("#comment1_1").hide();
			$("#project_comment").show();
	    }
	});
	
	/* 상세내용 추가하기 */
	$("#child1").click(function(){
		let project_comment = $("#comment1").val();
		let project_no = $(".project_no").val();
		table = "";
		$.ajax({
			type : "post",
			url : "project_InsertComment.do",
			data : {project_comment : project_comment,
					project_no : project_no
					},
			datatype : "text",
			success : function(){
				$("#comment1").text(project_comment);
				$("#comment1").css({'border':'1px solid gray'});
		    	$("#control1").css({'border-color':'lightgray'})
				$("#control1").css({'border-style':'none'});
				$("#child1").hide();
			},
			error : function(request,status,error){
				alert('데이터 통신 에러');
			}
		})
	})
	
	/* 상세내용 수정하기 */
	$("#child1_1").click(function(){
		let project_comment = $("#comment1_1").val();
		let project_no = $(".project_no").val();
		$.ajax({
			type : "post",
			url : "project_InsertComment.do",
			data : {project_comment : project_comment,
					project_no : project_no
					},
			datatype : "text",
			success : function(){
				$("#comment1_1").text(project_comment);
				$("#comment1_1").css({'border':'1px solid gray'});
		    	$("#control1_1").css({'border-color':'lightgray'})
				$("#control1_1").css({'border-style':'none'});
		    	$("comment1").text(project_comment);
				$("#child1_1").hide();
				$("#project_comment").text(project_comment);
			},
			error : function(request,status,error){
				alert('데이터 통신 에러');
			}
		})
	})
	
	
	/* 코멘트창 클릭시 활성화 */
	$("#comment2").click(function(){
		$("#control2").css({'border':'1px solid gray'});
		$("#comment2").css({'border-style':'none'});
		$("#child2").show(100);
		
	});
	
	/* 코멘트창 비활성화  */
	$(document).mouseup(function (e){
	    var container = $("#control2")
	    if(container.has(e.target).length == 0){ 
	    	$("#comment2").css({'border':'1px solid gray'});
	    	$("#control2").css({'border-color':'lightgray'})
			$("#control2").css({'border-style':'none'});
			$("#child2").hide(100); 
	    }
	});
	
	/* select창 숨기기 */
	$("#plus_taker").click(function(){
		$(".hide").show();
	})
	$(document).mouseup(function (e){
	    var container = $("#member")
	    if(container.has(e.target).length == 0){ 
	    	$(".hide").hide();
	    }
	});
	
	/* 모달창 닫으면 리로딩 */
	$(".btn-close").click(function(){
		$(".hide").hide();
		location.reload();
	});
	
	/* 프로젝트 status 이동 */
	$("#move").change(function(){
		let project_status = $(this).val();
		let project_no = $(".project_no").val();
		if(confirm(project_status+"로 이동시키시겠습니까??")){
			$.ajax({
				type : "post",
				url : "project_move.do",
				data : {project_status : project_status,
						project_no : project_no
						},
				datatype : "text",
				success : function(){
					alert('변경 완료!')
				},
				error : function(request,status,error){
					alert('데이터 통신 에러')
				}
			})
		}else{
			$(".hide").hide();
		};
	});
	
	/* 프로젝트 멤버 추가하기 */
	$("#project_taker").change(function(){
		$(".hide").hide();
		$(".hide_1").hide();
		let member = ($(this).val());
		let project_no = $(".project_no").val();
		if(confirm(member+"님을 추가하시겠습니까??")){
			$.ajax({
				type : "post",
				url : "project_memberinsert.do",
				data : {project_taker : member,
						project_taker2 : member,
						project_taker3 : member,
						project_taker4 : member,
						project_taker5 : member,
						project_no : project_no
						},
				datatype : "text",
				success : function(dto){
					table = "";
					var isVisible = false;
				 	var clickedAway = false;
					console.log("text: "+$("#taker1").text());
					console.log(dto.taker);
					if($("#taker1").text() == ""){
						table += "<button id='taker1' class='popoverThis btn btn-large btn-secondary'>&nbsp;"+dto.taker+"</button>";
						table += "<div id='popover-heading1' class='hide_1'>";
					    table += "<img id='member1' class='img' src='resources/image/project_man.png' width='60' height='50'>"+dto.taker;
					    table += "<input type='hidden' id='heading1_mem' value="+dto.taker+"></div><div id='popover-body1' class='hide_1'>";
						table += "<a href='#'>회원 정보 보기</a><hr><a href='#' id='except1'>프로젝트 제외하기</a></div>";
					}else if($("#taker2").text() == ""){
						table += "<button id='taker2' class='popoverThis btn btn-large btn-secondary'>&nbsp;"+dto.taker+"</button>";
						table += "<div id='popover-heading2' class='hide_1'>";
					    table += "<img id='member2' class='img' src='resources/image/project_man.png' width='60' height='50'>"+dto.taker;
					    table += "<input type='hidden' id='heading2_mem' value="+dto.taker+"></div><div id='popover-body2' class='hide_1'>";
						table += "<a href='#'>회원 정보 보기</a><hr><a href='#' id='except2'>프로젝트 제외하기</a></div>";
					}else if($("#taker3").text() == ""){
						table += "<button id='taker3' class='popoverThis btn btn-large btn-secondary'>&nbsp;"+dto.taker+"</button>";
						table += "<div id='popover-heading3' class='hide_1'>";
					    table += "<img id='member3' class='img' src='resources/image/project_man.png' width='60' height='50'>"+dto.taker;
					    table += "<input type='hidden' id='heading3_mem' value="+dto.taker+"></div><div id='popover-body3' class='hide_1'>";
						table += "<a href='#'>회원 정보 보기</a><hr><a href='#' id='except3'>프로젝트 제외하기</a></div>";
					}else if($("#taker4").text() == ""){
						table += "<button id='taker4' class='popoverThis btn btn-large btn-secondary'>&nbsp;"+dto.taker+"</button>";
						table += "<div id='popover-heading4' class='hide_1'>";
					    table += "<img id='member4' class='img' src='resources/image/project_man.png' width='60' height='50'>"+dto.taker;
					    table += "<input type='hidden' id='heading4_mem' value="+dto.taker+"></div><div id='popover-body4' class='hide_1'>";
						table += "<a href='#'>회원 정보 보기</a><hr><a href='#' id='except4'>프로젝트 제외하기</a></div>";
					}else if($("#taker5").text() == ""){
						table += "<button id='taker5' class='popoverThis btn btn-large btn-secondary'>&nbsp;"+dto.taker+"</button>";
						table += "<div id='popover-heading5' class='hide_1'>";
					    table += "<img id='member5' class='img' src='resources/image/project_man.png' width='60' height='50'>"+dto.taker;
					    table += "<input type='hidden' id='heading5_mem' value="+dto.taker+"></div><div id='popover-body5' class='hide_1'>";
						table += "<a href='#'>회원 정보 보기</a><hr><a href='#' id='except5'>프로젝트 제외하기</a></div>";
					}
					$(".project_taker").append(table);
					$(".hide").hide();
					$(".hide_1").hide();
					$('#taker1').popover({
				 	    html: true,
				 	    title: function () {
				 	    	return $('#popover-heading1').html();
				 	    },
				 	    content: function () {
				 	        return $('#popover-body1').html();
				 	    }
				 	});
					$('#taker2').popover({
				 	    html: true,
				 	    title: function () {
				 	    	return $('#popover-heading2').html();
				 	    },
				 	    content: function () {
				 	        return $('#popover-body2').html();
				 	    }
				 	});
				 	$('#taker3').popover({
				 	    html: true,
				 	    title: function () {
				 	    	return $('#popover-heading3').html();
				 	    },
				 	    content: function () {
				 	        return $('#popover-body3').html();
				 	    }
				 	});
				 	$('#taker4').popover({
				 	    html: true,
				 	    title: function () {
				 	    	return $('#popover-heading4').html();
				 	    },
				 	    content: function () {
				 	        return $('#popover-body4').html();
				 	    }
				 	});
				 	$('#taker5').popover({
				 	    html: true,
				 	    title: function () {
				 	    	return $('#popover-heading5').html();
				 	    },
				 	    content: function () {
				 	        return $('#popover-body5').html();
				 	    }
				 	});

					$('.popoverThis').popover({
				 	    html: true,
				 	    trigger: 'manual'
				 	}).click(function (e) {
				 	    $(this).popover('show');
				 	    $('.popover-content').append('<a class="close" style="position: absolute; top: 0; right: 6px;">&times;</a>');
				 	    clickedAway = false
				 	    isVisible = true
				 	    e.preventDefault()
				 	});
				 	$(document).click(function (e) {
				 	    if (isVisible & clickedAway) {
				 	        $('.popoverThis').popover('hide')
				 	        isVisible = clickedAway = false
				 	    } else {
				 	        clickedAway = true
				 	    }
				 	});
				},
				error : function(){
					alert('데이터 통신 에러');
				}
			})
		}else{
			$(".hide").hide();
		};
	});

	  
	/* 프로젝트 마감일 수정 */
	$("#end").click(function(){
		$("#end").hide();
		$("#project_end").show();
		 $( "#project_end" ).datepicker({
		      dateFormat: "yy-mm-dd"
		    });
		 $("#project_end").change(function(){
				let project_end = ($(this).val());
				let project_no = $(".project_no").val();
				if(confirm(project_end+"로 마감일을 변경하시겠습니까??")){
					$.ajax({
						type : "post",
						url : "project_Updateend.do",
						data : {project_end : project_end,
								project_no : project_no
								},
						datatype : "text",
						success : function(){
							alert('변경 완료!');
						},
						error : function(request,status,error){
							alert('데이터 통신 에러');
						}
					})
				}else{
					$(".hide").hide();
				};
			 })
	})
	
	/* 프로젝트 시작일 수정 */
	$("#start").click(function(){
		$("#start").hide();
		$("#project_start").show();
		 $( "#project_start" ).datepicker({
		      dateFormat: "yy-mm-dd"
		    });
		 $("#project_start").change(function(){
			let project_start = ($(this).val());
			let project_no = $(".project_no").val();
			if(confirm(project_start+"로 시작일을 변경하시겠습니까??")){
				$.ajax({
					type : "post",
					url : "project_UpdateStart.do",
					data : {project_start : project_start,
							project_no : project_no
							},
					datatype : "text",
					success : function(){
						alert('변경 완료!');
					},
					error : function(request,status,error){
						alert('데이터 통신 에러');
					}
				})
			}else{
				$(".hide").hide();
			};
		 })
	})
	
	/* 멤버 5인 이상 추가 불가능 */
	if($("#taker5").val() != null){
		$("#asd").hide();
		$("#asd").click(function(){
			alert("멤버를 추가할 수 없습니다.");
		})
	}
	
	/* 프로젝트 멤버 제외하기 */
 	$(document).on("click","#except1",function(){
 		let project_taker = ($("#heading1_mem").attr("value"));
 		let project_no = $(".project_no").val();
 		let taker1 = $("#taker1").text();
 		$.ajax({
			type : "post",
			url : "project_Deletetaker1.do",
			data : {project_taker : project_taker,
					project_no : project_no
					},
			datatype : "text",
			success : function(){
				$("#taker1").remove();
				$("#popover-heading1").remove();
				$("#popover-body1").remove();
			},
			error : function(request,status,error){
				alert('데이터 통신 에러');
			}
		})
 	})
 	$(document).on("click","#except2",function(){
 		let project_taker2 = ($("#heading2_mem").attr("value"));
 		let project_no = $(".project_no").val();
 		let taker2 = $("#taker2").text();
 		$.ajax({
			type : "post",
			url : "project_Deletetaker2.do",
			data : {project_taker2 : project_taker2,
					project_no : project_no
					},
			datatype : "text",
			success : function(){
				$("#taker2").remove();
				$("#popover-heading2").remove();
				$("#popover-body2").remove();
			},
			error : function(request,status,error){
				alert('데이터 통신 에러');
			}
		})
 	})
 	$(document).on("click","#except3",function(){
 		let project_taker3 = ($("#heading3_mem").attr("value"));
 		let project_no = $(".project_no").val();
 		let taker3 = $("#taker3").text();
 		$.ajax({
			type : "post",
			url : "project_Deletetaker3.do",
			data : {project_taker3 : project_taker3,
					project_no : project_no
					},
			datatype : "text",
			success : function(){
				$("#taker3").remove();
				$("#popover-heading3").remove();
				$("#popover-body3").remove();
			},
			error : function(request,status,error){
				alert('데이터 통신 에러');
			}
		})
 	})
 	$(document).on("click","#except4",function(){
 		let project_taker4 = ($("#heading4_mem").attr("value"));
 		let project_no = $(".project_no").val();
 		let taker2 = $("#taker2").text();
 		$.ajax({
			type : "post",
			url : "project_Deletetaker4.do",
			data : {project_taker4 : project_taker4,
					project_no : project_no
					},
			datatype : "text",
			success : function(){
				$("#taker4").remove();
				$("#popover-heading4").remove();
				$("#popover-body4").remove();
			},
			error : function(request,status,error){
				alert('데이터 통신 에러');
			}
		})
 	})
 	$(document).on("click","#except5",function(){
 		let project_taker5 = ($("#heading5_mem").attr("value"));
 		let project_no = $(".project_no").val();
 		let taker2 = $("#taker2").text();
 		$.ajax({
			type : "post",
			url : "project_Deletetaker5.do",
			data : {project_taker5 : project_taker5,
					project_no : project_no
					},
			datatype : "text",
			success : function(){
				$("#taker5").remove();
				$("#popover-heading5").remove();
				$("#popover-body5").remove();
			},
			error : function(request,status,error){
				alert('데이터 통신 에러');
			}
		})
 	})
 	/* 프로젝트 멤버 popover */
 	var isVisible = false;
 	var clickedAway = false;
 	$('#taker1').popover({
 	    html: true,
 	    title: function () {
 	    	return $('#popover-heading1').html();
 	    },
 	    content: function () {
 	        return $('#popover-body1').html();
 	    }
 	});
 	$('#taker2').popover({
 	    html: true,
 	    title: function () {
 	    	return $('#popover-heading2').html();
 	    },
 	    content: function () {
 	        return $('#popover-body2').html();
 	    }
 	});
 	$('#taker3').popover({
 	    html: true,
 	    title: function () {
 	    	return $('#popover-heading3').html();
 	    },
 	    content: function () {
 	        return $('#popover-body3').html();
 	    }
 	});
 	$('#taker4').popover({
 	    html: true,
 	    title: function () {
 	    	return $('#popover-heading4').html();
 	    },
 	    content: function () {
 	        return $('#popover-body4').html();
 	    }
 	});
 	$('#taker5').popover({
 	    html: true,
 	    title: function () {
 	    	return $('#popover-heading5').html();
 	    },
 	    content: function () {
 	        return $('#popover-body5').html();
 	    }
 	});

 	$('.popoverThis').popover({
 	    html: true,
 	    trigger: 'manual'
 	}).click(function (e) {
 	    $(this).popover('show');
 	    $('.popover-content').append('<a class="close" style="position: absolute; top: 0; right: 6px;">&times;</a>');
 	    clickedAway = false
 	    isVisible = true
 	    e.preventDefault()
 	});
 	$(document).click(function (e) {
 	    if (isVisible & clickedAway) {
 	        $('.popoverThis').popover('hide')
 	        isVisible = clickedAway = false
 	    } else {
 	        clickedAway = true
 	    }
 	});
})
