$(function(){
		$(".main_select").hide();
		$(".status").hide();
		$(".member").hide();
		$(".project_create1").hide();
		$(".project_create2").hide();
		$(".submit").hide();
		
		/* 프로젝트 추가 창 닫기 */
		$(document).mouseup(function (e){
		    var container = $("#insert_projects_tr,.project_create")
		    if(container.has(e.target).length == 0){ 
		    	$(".project_create").hide(1000);
		    	$(".submit").hide();
				$(".project_btn").show();
		    }
		});
		
		/* 프로젝트 목록 생성 함수 */
		$(".project_btn").click(function(){
			if($("input[name='project_name']").val() != ""){
				$(".project_btn").hide();
				$(".project_create1").show();
				$(".project_create2").show();
				$(".submit").show();
				let i = 0;
				table = "";
				table1 = "";
				table2 = "";
				table += $(".main_select").show();
				table1 += "<input class='form-control' placeholder='프로젝트 명' aria-label='Username' name='project_name'>";
				table2 += "<input type='date' class='form-control' aria-label='Username' name='project_end'>";
				table += $(".status").show();
				table += $(".member").show();
				$(".project_create1").append(table1);
				$(".project_create2").append(table2);
			}else{
				$(".project_create").show(1000);
			}
			
		})
		
		/* '+'아이콘 클릭시 'check'아이콘 변경 */
		$(".project_check").click(function(){
			$(".submit").hide();
			$(".project_btn").show();
		})
		
		/* 프로젝트 이름 클릭시 상세보기 모달 창 생성 */
		$(".project_name").click(function(){
			let href = ($(this).attr("id"));
			let href1 = "content.do?num="+href;
 			let project_name = $(".project_name").text();
 			console.log($(this).text())
			 $("#Project_content").load(href1, function() {
		            $("#Project_content").modal("show");
		      });
 		})
 		
 		/* 프로젝트 추가하기 필수값 입력 후 submit */
 		$(".submit").click(function(){
 			console.log("project_main : "+$("select[name='project_main']").val());
 			
 			if($("select[name='project_main']").val() == "none"){
 				alert("메인 프로젝트를 선택해 주세요.")
 			}else if($("select[name='project_status']").val() == "none"){
 				alert("프로젝트의 상태를 선택해 주세요.")
 			}else if($("select[name='project_taker']").val() == "none"){
 				alert("프로젝트 멤버를 선택해 주세요.")
 			}else{
 				$("form").submit();
 			}
 		})
	})