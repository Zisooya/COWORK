<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/script/project_modal.js"></script>
<script type="text/javascript">
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
	$(".comment3").hide();
	$(".child3").hide();
	
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
	
	/* 프로젝트 status 이동 */
	$("#move").change(function(){
		let project_status = $(this).val();
		let project_no = $(".project_no").val();
		$.ajax({
			type : "post",
			url : "project_move.do",
			data : {project_status : project_status,
					project_no : project_no
					},
			datatype : "text",
			success : function(){
			},
			error : function(request,status,error){
				alert('데이터 통신 에러')
			}
		})
	});
	
	/* 프로젝트 멤버 추가하기 */
	$("#project_taker").change(function(){
		$(".hide").hide();
		$(".hide_1").hide();
		let member = ($(this).val());
		console.log(member);
		let project_no = $(".project_no").val();
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
				console.log("member : "+member);
				console.log("cat : " +dto.cat);
				if($("#taker1").text() == ""){
					table += "&nbsp;<button id='taker1' class='popoverThis btn btn-large btn-secondary'>"+member+"</button>";
					table += "<div id='popover-heading1' class='hide_1'>";
				    table += "<img id='member1' class='img' src='resources/image/project_man.png' width='60' height='50'>"+member;
				    table += "<input type='hidden' id='heading1_mem' value="+member+"></div><div id='popover-body1' class='hide_1'>";
					table += "<a href='#' id='except1'>프로젝트 제외하기</a></div>";
				}else if($("#taker2").text() == ""){
					table += "&nbsp;<button id='taker2' class='popoverThis btn btn-large btn-secondary'>"+member+"</button>";
					table += "<div id='popover-heading2' class='hide_1'>";
				    table += "<img id='member2' class='img' src='resources/image/project_man.png' width='60' height='50'>"+member;
				    table += "<input type='hidden' id='heading2_mem' value="+member+"></div><div id='popover-body2' class='hide_1'>";
					table += "<a href='#' id='except2'>프로젝트 제외하기</a></div>";
				}else if($("#taker3").text() == ""){
					table += "&nbsp;<button id='taker3' class='popoverThis btn btn-large btn-secondary'>"+member+"</button>";
					table += "<div id='popover-heading3' class='hide_1'>";
				    table += "<img id='member3' class='img' src='resources/image/project_man.png' width='60' height='50'>"+member;
				    table += "<input type='hidden' id='heading3_mem' value="+member+"></div><div id='popover-body3' class='hide_1'>";
					table += "<a href='#' id='except3'>프로젝트 제외하기</a></div>";
				}else if($("#taker4").text() == ""){
					table += "&nbsp;<button id='taker4' class='popoverThis btn btn-large btn-secondary'>"+member+"</button>";
					table += "<div id='popover-heading4' class='hide_1'>";
				    table += "<img id='member4' class='img' src='resources/image/project_man.png' width='60' height='50'>"+member;
				    table += "<input type='hidden' id='heading4_mem' value="+member+"></div><div id='popover-body4' class='hide_1'>";
					table += "<a href='#' id='except4'>프로젝트 제외하기</a></div>";
				}else if($("#taker5").text() == ""){
					table += "&nbsp;<button id='taker5' class='popoverThis btn btn-large btn-secondary'>"+member+"</button>";
					table += "<div id='popover-heading5' class='hide_1'>";
				    table += "<img id='member5' class='img' src='resources/image/project_man.png' width='60' height='50'>"+member;
				    table += "<input type='hidden' id='heading5_mem' value="+member+"></div><div id='popover-body5' class='hide_1'>";
					table += "<a href='#' id='except5'>프로젝트 제외하기</a></div>";
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
			error : function(dto){
				alert('데이터 통신 에러');
			}
		})
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
				$.ajax({
					type : "post",
					url : "project_Updateend.do",
					data : {project_end : project_end,
							project_no : project_no
							},
					datatype : "text",
					success : function(){
					},
					error : function(request,status,error){
						alert('데이터 통신 에러');
					}
				})
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
			$.ajax({
				type : "post",
				url : "project_UpdateStart.do",
				data : {project_start : project_start,
						project_no : project_no
						},
				datatype : "text",
				success : function(){
				},
				error : function(request,status,error){
					alert('데이터 통신 에러');
				}
			})
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
 	
 	/* 댓글 달기 */
 	$("#child2").click(function(){
 		let project_no = $(".project_no").val();
 		let comment = $("#comment2").val();
 		let mem_name = $("#img_mem_name").val();
 		let session_name = $(".mem_name").val();
 		let no = $(".comment_no").val();
 		let comment_no = parseInt(no)+1;
 		$("#comment2").val('');
 		$.ajax({
			type : "post",
			url : "project_CommentPlus.do",
			data : {comment_comment : comment,
					mem_name : mem_name,
					project_no : project_no
					},
			datatype : "text",
			success : function(dto){
	         table = "";
	         	table += "<div class='asdasd'> <div class='comment_header'>";
		        table += "<b>"+mem_name+"님 &nbsp;&nbsp; 방금 </b></div>";
		        table += "<div class='comment_body'> <p class='comment_comment'>"+comment+"</p>";
		        table += "<div class='control3'> <textarea class='textarea comment3' cols='80%' rows='2' onkeydown='resize(this)' onkeyup='resize(this)''>"+comment+"</textarea>";
     			table += "<input type='button' id="+comment_no+" class='btn btn-primary child3' value='저장'> </div>";
				table += "<div class='comment_edit'> <a href='#' class='comment_edit' id="+comment_no+">수정하기</a> &nbsp; <a class='comment_remove' href='#' id="+comment_no+" >삭제하기</a>";
				table += "<br>";
				$(".project_comments").prepend(table);
				console.log("asd");
				$(".comment3").css({'border':'1px solid gray'});
				$(".comment3").css({'border-style':'none'});
		    	$(".control3").css({'border-color':'lightgray'})
				$(".control3").css({'border-style':'none'});
				$(".child3").hide(100); 
				$(".comment3").hide();
			},
			error : function(dto){
				alert('데이터 통신 오류');
			}
		})
 	})
 	
 	/* 댓글 삭제 */
 	$(document).on("click",".comment_remove",function(){
 		let comment_no = $(this).attr("id");
 		let div_no1 = $(this).parents(".asdasd");
 		$.ajax({
			type : "post",
			url : "project_Commentdelete.do",
			data : {comment_no : comment_no
					},
			datatype : "text",
			success : function(){
				div_no1.remove();
			},
			error : function(){
				alert('데이터 통신 에러');
			}
		})
 	})
 	
 	/* 댓글 수정창 활성화 */
 	$(document).on("click",".comment_edit",function(){
 		let comment_no = $(this).attr("id");
 		let control3 = $(this).parents(".asdasd").find(".control3");
 		let comment3 = $(this).parents(".asdasd").find(".comment3");
 		let child3 = $(this).parents(".asdasd").find(".child3");
 		let comment_comment = $(this).parents(".asdasd").find(".comment_comment");
 		control3.css({'border':'1px solid gray'});
		comment3.css({'border-style':'none'});
		comment3.show();
		child3.show(100);
		comment_comment.hide();
		/* $(".control3").css({'border':'1px solid gray'}); */
 	})
 	
 	/* 댓글 수정창 비활성화  */
	$(document).mouseup(function (e){
	    var container = $(".control3")
	    if(container.has(e.target).length == 0){ 
	    	$(".comment3").css({'border':'1px solid gray'});
			$(".comment3").css({'border-style':'none'});
	    	$(".control3").css({'border-color':'lightgray'})
			$(".control3").css({'border-style':'none'});
			$(".child3").hide(100); 
			$(".comment3").hide();
			$(".comment_comment").show();
	    }
	});
 	
 	/* 댓글 수정 */
 	$(document).on("click",".child3",function(){
 		let comment_no = $(this).attr("id");
 		let comment_comment = $(this).parents(".asdasd").find(".comment3").val();
 		$(this).parents(".asdasd").find(".comment_comment").text(comment_comment);
 		$.ajax({
			type : "post",
			url : "project_CommentUpdate.do",
			data : {comment_no : comment_no,
					comment_comment : comment_comment
					},
			datatype : "text",
			success : function(){
				$(".comment3").css({'border':'1px solid gray'});
				$(".comment3").css({'border-style':'none'});
		    	$(".control3").css({'border-color':'lightgray'})
				$(".control3").css({'border-style':'none'});
				$(".child3").hide(100); 
				$(".comment3").hide();
				$(".comment_comment").show();
			},
			error : function(){
				alert('데이터 통신 에러');
			}
		})
 	})
 	
 	/* 프로젝트 삭제 */
 	$("#delete").click(function(){
 		let mt = $(this).parents("#Project_content").attr("alt");
 		let no = $(".project_no").val();
 		let project_no= parseInt(no);
 		table = "";
 		table += "<input type='hidden' name='mt' value="+mt+">";
 		$("#delete_form").append(table);
 		if(confirm('정말로 프로젝트를 삭제하시겠습니까??')){
			$("#delete_form").submit();
		}else{ruturn;}
 	})
})

</script>
<style type="text/css">
	
	.Main_name{
		font-size: 12px;
		color:gray;
	}
	.btn-primary{
		background-color:#7BE66D;
		border-style: none;
		width:140px;
	}
	.btn-primary:hover{
		background-color:#C2F347;
	}
	 #control1,#control2,#control1_1,.control3{
	 	border-style: none;
	 	width:81%;
	 	border-radius: 5px;
	 	border-color: lightgrey;
	 }
	 .textarea{
	 	outline: none;
	 	border: 1px solid lightgray;
	 	border-radius: 5px;
	 	resize: none;
	 }
	 .img{
	 	display: inline-block;
	 }
	 select option{
	 	border-radius: 5px;
	 }
	 #asd{
	 	width:74px;
	 }
	 .project_taker{
	 	display: inline-block;
	 }
	 #project_start,#project_end,#start,#end,#move,#delete{
	 	float: right;
	 }
	 #project_start_btn,#project_end_btn{
	 	float: left;
	 }
	 #project_comment{
	 	border-style: none;
	 	border:1px solid white !important;
	 }
	 .comment_header{
	 	background-color: lightgray;
	 	border-radius: 5px;
	 	padding: 10px;
	 	margin-top: 5px;
	 }
	 .contorl3{
	 	margin-top: 5px;
	 }
	 .comment_comment{
	 	margin-top: 10px;
	 	margin-bottom: 10px;
	 	margin-left: 10px;
	 }
	 .comment_edit{
	 	font-size: 11px;
	 	margin-left: 10px;
	 }
	 .comment_edit a{
	 	color: var(--ds-text-subtle,#5e6c84);
	 }
</style>
</head>
<body>
	<c:set var="dto" value="${cont }"/>
	<c:set var="main" value="${main }"/>
	<c:set var="mlist" value="${mlist }"/>
	<c:set var="status" value="${status }"/>
	<c:set var="clist" value="${clist }"/>
	<c:set var="max" value="${max }"/>
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
		<input type="hidden" class="project_no" value="${dto.getProject_no() }">
		<input type="hidden" class="mem_name" value="${member.mem_name }">
		<input type="hidden" class="comment_no" value="${max }">
	      <div class="modal-header">
	      <!-- 모달창 헤더 -->
      	  <h5 class="modal-title"><img src="resources/image/project_title.png" width="20" height="20">&nbsp;${dto.getProject_name() }
	      	  <c:forEach items="${main }" var="mdto">
				<c:if test="${mdto.getMain_no() == dto.getProject_main() }">
				<p class="Main_name">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${mdto.getMain_name() }</p>
				</c:if>
			  </c:forEach>
		  </h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	     
	      <div id="member" class="modal-body">
	      <!-- 멤버 -->
			<img class="img" src="resources/image/project_member.jpg" width="35" height="30">Members<br>
					<div class="project_taker">
						<!-- 멤버1 -->
						<c:if test="${!empty dto.getProject_taker() }">
							<button id="taker1" class="popoverThis btn btn-large btn-secondary">${dto.getProject_taker() }</button>
							<!-- 멤버1 popover -->
							<div id="popover-heading1" class="hide_1">
								<c:forEach items="${mlist }" var="memlist">
						    		<c:if test="${memlist.getMem_name() == dto.getProject_taker() }">
						    				<img id="member1" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
						    				<input type="hidden" id="heading1_mem" value="${memlist.getMem_name() }">
						    		</c:if>
						    	</c:forEach>
							</div>
							<div id="popover-body1" class="hide_1">
								<a href="#" id="except1">프로젝트 제외하기</a>
							</div>
						</c:if>
						
						<!-- 멤버2 -->
						<c:if test="${!empty dto.getProject_taker2() }">
							<button id="taker2" class="popoverThis btn btn-large btn-secondary">${dto.getProject_taker2() }</button>
							<!-- 멤버2 popover -->
							<div id="popover-heading2" class="hide_1">
								<c:forEach items="${mlist }" var="memlist">
						    		<c:if test="${memlist.getMem_name() == dto.getProject_taker2() }">
						    				<img id="member2" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
						    				<input type="hidden" id="heading2_mem" value="${memlist.getMem_name() }">
						    		</c:if>
						    	</c:forEach>
							</div>
							<div id="popover-body2" class="hide_1">
								<a href="#" id="except2">프로젝트 제외하기</a>
							</div>
						</c:if>
						
						<!-- 멤버3 -->
						<c:if test="${!empty dto.getProject_taker3() }">
							<button id="taker3" class="popoverThis btn btn-large btn-secondary">${dto.getProject_taker3() }</button>
							<!-- 멤버3 popover -->
							<div id="popover-heading3" class="hide_1">
								<c:forEach items="${mlist }" var="memlist">
						    		<c:if test="${memlist.getMem_name() == dto.getProject_taker3() }">
						    				<img id="member3" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
						    				<input type="hidden" id="heading3_mem" value="${memlist.getMem_name() }">
						    		</c:if>
						    	</c:forEach>
							</div>
							<div id="popover-body3" class="hide_1">
								<a href="#" id="except3">프로젝트 제외하기</a>
							</div>
						</c:if>
						
						<!-- 멤버4 -->
						<c:if test="${!empty dto.getProject_taker4() }">
							<button id="taker4" class="popoverThis btn btn-large btn-secondary">${dto.getProject_taker4() }</button>
							<!-- 멤버4 popover -->
							<div id="popover-heading4" class="hide_1">
								<c:forEach items="${mlist }" var="memlist">
						    		<c:if test="${memlist.getMem_name() == dto.getProject_taker4() }">
						    				<img id="member4" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
						    				<input type="hidden" id="heading4_mem" value="${memlist.getMem_name() }">
						    		</c:if>
						    	</c:forEach>
							</div>
							<div id="popover-body4" class="hide_1">
								<a href="#" id="except4">프로젝트 제외하기</a>
							</div>
						</c:if>
						
						<!-- 멤버5 -->
						<c:if test="${!empty dto.getProject_taker5() }">
							<button id="taker5" class="popoverThis btn btn-large btn-secondary">${dto.getProject_taker5() }</button>
							<!-- 멤버5 popover -->
							<div id="popover-heading5" class="hide_1">
								<c:forEach items="${mlist }" var="memlist">
						    		<c:if test="${memlist.getMem_name() == dto.getProject_taker5() }">
						    				<img id="member5" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
						    				<input type="hidden" id="heading5_mem" value="${memlist.getMem_name() }">
						    		</c:if>
						    	</c:forEach>
							</div>
							<div id="popover-body5" class="hide_1">
								<a href="#" id="except5">프로젝트 제외하기</a>
							</div>
						</c:if>
					</div>
					<span class="hide">
						<select id="project_taker" class="btn btn-secondary" name="project_taker">
							<option value="none">:::선택::::</option>
							<c:forEach items="${mlist }" var="memlist">
								<option value="${memlist.getMem_name() }">${memlist.getMem_name() }</option>				
							</c:forEach>
						</select>
					</span>
			  <a id="plus_taker" class="btn btn-secondary"><img src="resources/image/project_taker.png" width="20" height="20"></a>
	      </div>

	      <div class="modal-body">
	        <h5 class="modal-title"><img src="resources/image/project_description.png" width="20" height="20">&nbsp;상세내용</h5>
	       	<br>
	       	<div id="date">
	       	<!-- 시작일 -->
	       		<c:if test="${empty dto.getProject_start()}">
	       			<input id="start" class="btn btn-primary" type="button" value="시작일 선택">
	       		</c:if>
	       		<c:if test="${!empty dto.getProject_start() }">
	      			<input id="start" class="btn btn-primary" type="button" value="${dto.getProject_start().substring(0,10) }">
	      		</c:if>
	        		<input id="project_start" type="text" class="btn btn-primary" value="${dto.getProject_start().substring(0,10) }">
	        	
	      <!-- 상세 내용 -->
	      <c:if test="${empty dto.getProject_comment() }">
        	<div id="control1">
		         <textarea class="textarea" id="comment1" cols="80%" rows="2" placeholder="작업 상세내용을 추가해 주세요." onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
		         <p id="insert_comment"></p>
		         <input id="child1" type="button" class="btn btn-primary" value="저장">		     
	      	</div>
	      </c:if>
	      
	      <c:if test="${!empty dto.getProject_comment() }">
	      	<div id="control1_1">
		         <p id="project_comment">${dto.getProject_comment() }</p>
		         <textarea class="textarea" id="comment1_1" cols="80%" rows="2"onkeydown="resize(this)" onkeyup="resize(this)">${dto.getProject_comment() }</textarea>      
		         <input id="child1_1" type="button" class="btn btn-primary" value="수정하기">
	      	</div>
	      </c:if>
	      					
	         <!-- 마감일 -->
	        	<c:if test="${empty dto.getProject_end()}">
	       			<input id="end" class="btn btn-primary" type="button" value="마감일 선택">
	       		</c:if>
	       		<c:if test="${!empty dto.getProject_end() }">
	      			<input id="end" class="btn btn-primary" type="button" value="${dto.getProject_end().substring(0,10) }">
	      		</c:if>
	         	<input id="project_end" type="text" class="btn btn-primary" value="${dto.getProject_end().substring(0,10) }">
	        </div>
	      </div>
					
	      
	      <div class="modal-body">
	         <!-- 이동 -->
			  <select id="move" class="btn btn-primary" name="project_taker">
			  <c:forEach items="${status}" var="sdto">
			  		<c:if test="${dto.getProject_status() == sdto.getStatus_no() }">
				 		<option value="${sdto.getStatus_no()}">${sdto.getStatus_name() }</option>
				 	</c:if>
				</c:forEach>
				 <c:forEach items="${status}" var="sdto">
				 	<c:if test="${dto.getProject_status() != sdto.getStatus_no() }">
				 		<option value="${sdto.getStatus_no()}">${sdto.getStatus_name() }</option>
				 	</c:if>
				 </c:forEach>
			  </select>
	      	 <h5 class="modal-title"><img src="resources/image/project_comment.png" width="20" height="20">&nbsp;코멘트</h5>
	      	 <br>
			 <!-- 삭제 -->
	      	 <form id="delete_form"action="project_delete.do" method="post">
	      		 <input type="hidden" class="project_no" name="num" value="${dto.getProject_no() }">
		         <button id="delete" type="button" class="btn btn-primary">프로젝트 삭제</button>
			</form>
	         <img class="img" src="resources/image/project_man.png" class="img_mem_name" width="35" height="30">${member.mem_name}님
	         <input type="hidden" id="img_mem_name" value="${member.mem_name}">
			  <!-- 댓글 -->
			  <br>
         <div id="control2">
	         <textarea class="textarea" id="comment2"  cols="80%" rows="2" onkeydown="resize(this)" onkeyup="resize(this)"></textarea><br>
	         <input id="child2" type="button" class="btn btn-primary" value="저장">
	         <br>
	     </div>
         <div class="project_comments" id="${cdto.getComment_no() }">
         	<c:forEach items="${clist }" var="cdto">
         		<c:if test="${dto.getProject_no() == cdto.getProject_no() }">
         		<div class="asdasd" id="${cdto.getComment_comment() }">
         			<div class="comment_header">
	         			<b>${cdto.getMem_name() }님 &nbsp;&nbsp; ${cdto.getComment_date().substring(0,10) }</b>
	         		</div>
	         		<div class="comment_body">
	         			<p class="comment_comment">${cdto.getComment_comment() }</p>
	         			<div class="control3">
		         			<textarea class="textarea comment3" id=""  cols="80%" rows="2" onkeydown="resize(this)" onkeyup="resize(this)">${cdto.getComment_comment() }</textarea>
		         			<input type="button" id="${cdto.getComment_no() }" class="btn btn-primary child3" value="저장">
	         			</div>
					</div>
					<c:if test="${cdto.getMem_name() == member.mem_name }">
					<div class="comment_edit">
						<a href="#" class="comment_edit" id="${cdto.getComment_no() }">수정하기</a>
						&nbsp; 
						<a class="comment_remove" href="#" id="${cdto.getComment_no() }" >삭제하기</a>
					</div>
					</c:if>
				</div>
         		</c:if>      	
         	</c:forEach>
         	<br>
         </div>
	     	
	      </div>
	    </div>
	        
		
	    </div>
	    
	    <div id="a2" class="hidden">
		    <div class="popover-heading1">
		    	<c:forEach items="${mlist }" var="memlist">
		    		<c:if test="${memlist.getMem_name() == dto.getProject_taker() }">
		    				<img id="member" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
		    				<input type="hidden" id="heading1_mem" value="${memlist.getMem_name() }">
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-body1">
		    	<a href="#" id="except1">
		    		프로젝트 제외하기
		    	</a>
		    </div>
		    
		    <div class="popover-heading2">
		    	<c:forEach items="${mlist }" var="memlist">
		    		<c:if test="${memlist.getMem_name() == dto.getProject_taker2() }">
		    				<img id="member" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
		    				<input type="hidden" id="heading2_mem" value="${memlist.getMem_name() }">
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-body2">
		    	<a href="#" id="except2">
		    		프로젝트 제외하기
		    	</a>
		    </div>
		    
		    <div class="popover-heading3">
		    	<c:forEach items="${mlist }" var="memlist">
		    		<c:if test="${memlist.getMem_name() == dto.getProject_taker3() }">
		    				<img id="member" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
		    				<input type="hidden" id="heading3_mem" value="${memlist.getMem_name() }">
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-body3">
		    	<a href="#" id="except3">
		    		프로젝트 제외하기
		    	</a>
		    </div>
		    
		    <div class="popover-heading4">
		    	<c:forEach items="${mlist }" var="memlist">
		    		<c:if test="${memlist.getMem_name() == dto.getProject_taker4() }">
		    				<img id="member" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
		    				<input type="hidden" id="heading4_mem" value="${memlist.getMem_name() }">
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-body4">
		    	<a href="#" id="except4">
		    		프로젝트 제외하기
		    	</a>
		    </div>
		    
		    <div class="popover-heading5">
		    	<c:forEach items="${mlist }" var="memlist">
		    		<c:if test="${memlist.getMem_name() == dto.getProject_taker5() }">
		    				<img id="member" class="img" src="resources/image/project_man.png" width="60" height="50">${memlist.getMem_name() } ${memlist.getMem_rank() }
		    				<input type="hidden" id="heading5_mem" value="${memlist.getMem_name() }">
		    		</c:if>
		    	</c:forEach>
		    </div>
		    <div class="popover-body5">
		    	<a href="#" id="except5">
		    		프로젝트 제외하기
		    	</a>
		    </div>
		</div>
</body>
</html>