/* textarea 창 자동 늘리기 */
	function resize(obj) {
		  obj.style.height = "4px";
		  obj.style.height = (12+obj.scrollHeight)+"px";
		}
	
	$(function(){
		$(".add_card").hide();
		$(".list_header_update").hide();
 		$(".list-name-input").hide();
 		$(".plus_card").hide();
 		$(".status_div").hide();
 		$(".member_div").hide();
		$(".mod-list-add-button").click(function(){
			$(".list-name-input").show();
			$(".mod-list-add-button").hide();
		})
		
		
		/* 추가하기 창 닫기 */
		$(document).mouseup(function (e){
		    var container = $(".plus")
		    if(container.has(e.target).length == 0){ 
		    	$(".plus_card").hide(100);
		    	$(".board_insert").val('');
		    }
		});
		$(document).mouseup(function (e){
		    var container = $(".add_card")
		    if(container.has(e.target).length == 0){ 
		    	$(".add_card").hide(100);
		    	$(".add_card_main").val('');
		    	$(".add_card_content").text('');
		    }
		});
		
		
		/* 프로젝트 이름 클릭시 상세보기 모달 창 생성 */
		$(".project_name").click(function(){
			let href = ($(this).attr("id"));
			let href1 = "content.do?num="+href;
 			let project_name = $(".project_name").text();
			 $("#Project_content").load(href1, function() {
		            $("#Project_content").modal("show");
		            $('#form-control').focus();
		      });
 		})
		
		
 		$(".insert_card").click(function(){
			$(".plus_card").toggle(100);
		})
		
		/* 카드 추가하기 창 활성화 */
		$(".card-footer").click(function(){
			$(this).find(".add_card").show();
		})
		
		/* div 드래그 및 db저장 */
		var no = [];
		var i = [];
		var asd = 0;
		$( ".column" ).sortable({
		      connectWith: ".column",
		      handle: ".portlet-header",
		      placeholder: "portlet-placeholder ui-corner-all",
		      start:function(){
		    	  no = $(this).sortable("toArray");
		      },
		      update:function(){
		    	  no1 = $(this).sortable("toArray");
		    	  i = (no.filter(x => !no1.includes(x)));
		    	  asd = i[0];
		      },
		      receive:function(){
		    	  var status = $(this).attr("id");
		    	  console.log(asd);
		    	  console.log(status);
		    	  $.ajax({
		  			type : "post",
		  			url : "project_UpdateStatus.do",
		  			data : {status_name : status,
		  				 	project_no : asd
		  					},
		  			datatype : "text",
		  			success : function(){
		  			},
		  			error : function(request,status,error){
		  				alert('데이터 통신 에러');
		  			}
		  		})
		      }
		});
		
		/* 스테이터스별로 필터링 */
		$(".status_list").click(function(){
			let status_no = $(this).attr("id");
			let lastNum = $(".status_count").val();
			$(".col").each(function(){
				if($(this).attr("id") == status_no){
					$(this).toggle();
				}
			})
		})
		$(".status_oc").click(function(){
			$(".status_div").toggle(50);
		})
		
		
		/* 멤버별로 필터링  */
		$(".member_list").click(function(){
			let mem_name = $(this).attr("id");
			if($(this).is(":checked")){
				$(".portlet").each(function(){
					$(this).find(".taker").each(function(){
						if($(this).val() == mem_name){
							$(this).parent().show();
						}
					})
				})
			}else{
				$(".portlet").each(function(){
					$(this).find(".taker").each(function(){
						if($(this).val() == mem_name){
							$(this).parent().hide();
						}
					})
				})
			}
		})
		$(".member_oc").click(function(){
			$(".member_div").toggle(50);
		})
	})