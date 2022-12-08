<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(".list_header_update").hide();
		
	/* 프로젝트 이름 클릭시 상세보기 모달 창 생성 */
		$(".project_name").click(function(){
			let href = ($(this).attr("id"));
			let href1 = "<%=request.getContextPath()%>/content.do?num="+href;
 			let project_name = $(".project_name").text();
			 $("#Project_content").load(href1, function() {
		           $("#Project_content").modal("show");
		      });
 		})
	})
	
</script>
<link href="${path}/resources/css/include.css" rel="stylesheet"/>
<link href="${path}/resources/css/project_board.css" rel="stylesheet"/>
<style type="text/css">
body{
	background-color: #E4F7BA;
}

div::selection {
    background: #0000;
}
div {
    display: block;
}
.list-wrapper:first-child {
    margin-left: 12px;
}
.list-wrapper {
    box-sizing: border-box;
    display: inline-block;
    height: 100%;
    margin: 0 4px;
    vertical-align: top;
    white-space: nowrap;
    width: 272px;
}
.list {
    background-color: var(--ds-background-accent-gray-subtlest,#ebecf0);
    border-radius: 5px;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    max-height: 100%;
    position: relative;
    white-space: normal;
    width: 100%!important;
}
.list-header.is-menu-shown, .list-header.is-subscribe-shown {
    padding-right: 36px;
}
.list-header {
    flex: 0 0 auto;
    min-height: 20px;
    padding: 10px 8px;
    position: relative;
}
.u-clearfix:after {
    clear: both;
    content: "";
    display: table;
}
.list-header-target {
    bottom: 0;
    cursor: pointer;
    left: 0;
    position: absolute;
    right: 0;
    top: 0;
}
.list-header-name-assist {
    display: none;
}
h2, h3, h4, h5, h6 {
    font-weight: 600;
    margin: 0 0 8px;
}
h2 {
    font-size: 20px;
    line-height: 24px;
}
h2[속성 스타일] {
    unicode-bidi: isolate;
}
h2 {
    display: block;
    font-size: 1.5em;
    margin-block-start: 0.83em;
    margin-block-end: 0.83em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
}
.list-header textarea {
    resize: none;
    overflow: hidden;
    overflow-wrap: break-word;
    height: 28px;
}
.list-header textarea {
    resize: none;
}
textarea.mod-list-name {
    background: #0000;
    border-radius: 5px;
    box-shadow: none;
    font-weight: 600;
    height: 20px;
    margin: -4px 0;
    max-height: 256px;
    min-height: 20px;
    padding: 4px 8px;
    resize: none;
}
.list-header-name {
    width: 74%;
}
textarea {
    resize: vertical;
    width: 100%;
}
input, textarea {
    -webkit-appearance: none;
    background-color: var(--ds-background-input,#fafbfc);
    border: none;
    border-radius: 5px;
    box-shadow: inset 0 0 0 2px var(--ds-border-input,#dfe1e6);
    box-sizing: border-box;
    display: block;
    line-height: 20px;
    margin-bottom: 12px;
    outline: none;
    padding: 8px 12px;
    transition-duration: 85ms;
    transition-property: background-color,border-color,box-shadow;
    transition-timing-function: ease;
}
textarea {
    overflow: auto;
}
button, input, optgroup, select, textarea {
    color: inherit;
    font: inherit;
    margin: 0;
}
textarea[속성 스타일] {
    unicode-bidi: plaintext;
}
textarea[dir="auto" i] {
    unicode-bidi: plaintext;
}
textarea {
    writing-mode: horizontal-tb !important;
    font-family: monospace;
    text-rendering: auto;
    color: fieldtext;
    letter-spacing: normal;
    word-spacing: normal;
    line-height: normal;
    text-transform: none;
    text-indent: 0px;
    text-shadow: none;
    display: inline-block;
    text-align: start;
    appearance: auto;
    -webkit-rtl-ordering: logical;
    resize: auto;
    cursor: text;
    white-space: pre-wrap;
    overflow-wrap: break-word;
    background-color: field;
    column-count: initial !important;
    margin: 0em;
    border-width: 1px;
    border-style: solid;
    border-color: -internal-light-dark(rgb(118, 118, 118), rgb(133, 133, 133));
    border-image: initial;
    padding: 2px;
}
.list-header-extras {
    position: absolute;
    right: 4px;
    top: 4px;
    z-index: 1;
}
.view-list {
    float: left!important;
}
.hide {
    display: none;
}
.list-header-extras-menu, .list-header-extras-subscribe {
    color: var(--ds-icon-subtle,#6b778c);
    float: left;
    padding: 6px;
}
.icon-lg.mod-quiet, .icon-md.mod-quiet, .icon-sm.mod-quiet {
    color: var(--ds-icon-subtle,#6b778c);
}
.icon-lg, .icon-md, .icon-sm {
    color: var(--ds-icon,#42526e);
}
.icon-sm {
    font-size: 16px;
    height: 20px;
    line-height: 20px;
    width: 20px;
}
.icon-lg, .icon-md, .icon-sm {
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    display: inline-block;
    font-family: trellicons;
    font-style: normal;
    font-weight: 400;
    line-height: 1;
    text-align: center;
    text-decoration: none;
    vertical-align: bottom;
}
.list-header-extras-menu, .list-header-extras-subscribe {
    color: var(--ds-icon-subtle,#6b778c);
    float: left;
    padding: 6px;
}
.list-header-extras-limit-badge {
    background-color: var(--ds-background-accent-gray-subtler,#091e4214);
    border-radius: 20px;
    color: var(--ds-text-subtle,#5e6c84);
    float: left;
    font-size: 12px;
    font-weight: 700;
    font-weight: 400;
    line-height: 20px;
    margin: 4px 4px 0 0;
    padding: 2px 10px;
    text-align: center;
}
.list-header-extras-menu {
    border-radius: 3px;
}
a {
    color: var(--ds-link,#172b4d);
    background-color: initial;
}
a:-webkit-any-link {
    color: -webkit-link;
    cursor: pointer;
    text-decoration: underline;
}
.icon-overflow-menu-horizontal:before {
    content: "\e952";
}
.list-header-num-cards {
    color: var(--ds-text-subtle,#5e6c84);
    margin: 0 8px;
}
p {
    margin: 0 0 8px;
}
p {
    display: block;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
}
.u-clearfix:after {
    clear: both;
    content: "";
    display: table;
}
.list-cards {
    flex: 1 1 auto;
    margin: 0 4px;
    min-height: 0;
    overflow-x: hidden;
    overflow-y: auto;
    padding: 0 4px;
    z-index: 1;
}
.u-fancy-scrollbar {
    -webkit-overflow-scrolling: touch;
    -webkit-transform: translateZ(0);
}
.u-fancy-scrollbar::-webkit-scrollbar {
    height: 8px;
    width: 8px;
}
.u-fancy-scrollbar::-webkit-scrollbar-track-piece {
    background: var(--ds-background-accent-gray-subtlest,#091e4214);
}
.card-composer-container {
    display: flex;
    justify-content: space-between;
    max-height: 38px;
    min-height: 38px;
}
.open-card-composer {
    border-radius: 3px;
    color: var(--ds-text-subtle,#5e6c84);
    display: block;
    flex: 1 0 auto;
    margin: 2px 0 8px 8px;
    padding: 4px 8px;
    position: relative;
    text-decoration: none;
    -webkit-user-select: none;
    user-select: none;
}
.open-card-composer .icon-add {
    color: var(--ds-icon-subtle,#6b778c);
    margin-right: 2px;
}
.icon-add:before {
    content: "\e901";
}
.ZZ\+B1\+ksnEcE8d:visited, .ZZ\+B1\+ksnEcE8d:active {
    outline: none;
}
.ZZ\+B1\+ksnEcE8d {
    margin-right: 8px;
}
.ZZ\+B1\+ksnEcE8d .icon-template-card {
    margin-right: 0;
}
.card-composer-container .icon-template-card {
    color: var(--ds-icon-subtle,#6b778c);
    cursor: pointer;
    margin-right: 8px;
    margin-top: 2px;
    padding: 4px;
}

.content{
	background-color: white;
	text-align: center;
	background-color: var(--ds-surface-raised,#fff);
    border-radius: 3px;
    box-shadow: var(--ds-shadow-raised,0 1px 0 #091e4240);
    color: var(--ds-text,inherit);
    cursor: pointer;
    display: block;
    margin-bottom: 8px;
    max-width: 300px;
    min-height: 20px;
    position: relative;
    z-index: 0;
}
.list-card-title {
    word-wrap: break-word;
    clear: both;
    color: var(--ds-text,#172b4d);
    display: block;
    margin: 0 0 4px;
    overflow: hidden;
    text-decoration: none;
}
.list-card-details {
    overflow: hidden;
    padding: 6px 8px 2px;
    position: relative;
    z-index: 10;
}
.list-card-cover {
    background-position: 50%;
    background-repeat: no-repeat;
    background-size: cover;
    -webkit-user-select: none;
    user-select: none;
}
.list-card {
    background-color: var(--ds-surface-raised,#fff);
    border-radius: 3px;
    box-shadow: var(--ds-shadow-raised,0 1px 0 #091e4240);
    color: var(--ds-text,inherit);
    cursor: pointer;
    display: block;
    margin-bottom: 8px;
    max-width: 300px;
    min-height: 20px;
    position: relative;
    z-index: 0;
}
.list_body{
	flex: 1 1 auto;
    margin: 0 4px;
    min-height: 0;
    overflow-x: hidden;
    overflow-y: auto;
    padding: 0 4px;
    z-index: 1;
}
.list-header.is-menu-shown, .list-header.is-subscribe-shown {
    padding-right: 36px;
}
.list-header {
    flex: 0 0 auto;
    min-height: 20px;
    padding: 10px 8px;
    position: relative;
}
.list-header-target {
    bottom: 0;
    cursor: pointer;
    left: 0;
    position: absolute;
    right: 0;
    top: 0;
}
.list-header-name-assist {
    display: none;
}
.list-header-name{
	border-style: none;
}

	
</style>
</head>
<body class="feplat3731">
	<c:set var="list" value="${list }"/>
	<c:set var="main" value="${main }"/>
	<c:set var="status" value="${status }"/>
	<c:set var="mlist" value="${mlist }"/>
	<jsp:include page="../include.jsp" />
	<div id="grid_container">
	
		<nav id="side">
			<label>목 록</label>
			<div id="side_menu" style="overflow-y: auto;">
				
			</div>
		</nav>
		<article id="content">
			<div id="frame" class="board">
			<c:forEach items="${status }" var="sdto">
				<div class="js-list list-wrapper">
					<div class="list js-list-content">
						<div class="list_header js-list-header u-clearfix is-menu-shown ui-sortable-handle">
							<div class="list-header-target js-editing-target"></div>
							<h2 class="list-header-name-assist js-list-name-assist" dir="auto">${sdto.getStatus_name() }</h2>
							<textarea class="list-header-name mod-list-name js-list-name-input" aria-label="Doing" spellcheck="false" dir="auto" maxlength="512" data-autosize="true" style="overflow: hidden; overflow-wrap: break-word; height: 28px;">${sdto.getStatus_name() }</textarea>
							<div class="list-header-extras">
								
							</div>
						</div>
						<div class="list_body">
							<c:forEach items="${list }" var="dto">
								<c:if test="${sdto.getStatus_no() == dto.getProject_status() }">
									<div class="content">
										<p class="project_name" id="${dto.getProject_no() }">${dto.getProject_name() }</p>
									</div>											
								</c:if>
							</c:forEach>
						</div>
						<div class="card-composer-container js-card-composer-container">
							<a class="open-card-composer js-open-card-composer" href="#">
								<span class="icon-sm icon-add"></span>
								<span class="js-add-a-card">Add a card</span>
							</a>
							<div class="js-card-templates-button card-templates-button-container dark-background-hover">
								<div class="js-react-root">
									<div role="presentation">
										<a class="ZZ+B1+ksnEcE8d" data-testid="card-template-list-button" role="button" href="#" aria-label="Create from template…">
											<span class="icon-sm icon-template-card dark-background-hover"></span>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			<div class="js-add-list list-wrapper mod-add is-idle">
				<form>
					<a class="open-add-list js-open-add-list" href="#">
						<span class="placeholder"><span class="icon-sm icon-add"></span>리스트 추가</span>
					</a>
						<input class="list-name-input" type="text" name="name" placeholder="Enter list title…" autocomplete="off" dir="auto" maxlength="512">
					<div class="list-add-controls u-clearfix">
						<input class="nch-button nch-button--primary mod-list-add-button js-save-edit" type="submit" value="Add list">
							<a class="icon-lg icon-close dark-hover js-cancel-edit" href="#" aria-label="Cancel list editing"></a>
					</div>
				</form>
			</div>
			</div>
    	</article>	
    
  
</div>
</body>
</html>