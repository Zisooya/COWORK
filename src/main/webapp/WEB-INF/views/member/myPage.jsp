<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html>
<head>
  <title>Title</title>
  <link href="${path}/resources/css/include.css" rel="stylesheet"/>
  <link rel="icon" href="data:;base64,=">
  <style>
    .side_menu_body {
      text-align: center;
    }

    .side_menu_body a {
      text-decoration: none;
      color: black;
    }

    .side_menu_body hr {
      margin-top: 5px;
      margin-bottom: 5px;
    }

    .side_menu_cont {
      border-radius:5px;
      padding-top: 13px;
      padding-bottom: 13px;
    }

    .side_menu_cont:hover {
      background-color: #7BE66D;
    }

    .side_menu_cont:hover > a {
      color:white;
    }
  </style>
</head>
<body>
<div id="grid_container">

  <jsp:include page="../include.jsp" />

  <nav id="side">
    <label>마이페이지</label>
    <div id="side_menu" style="overflow-y: auto;">
      <div class="side_menu_body">
        <div class="side_menu_cont">
          <a href="${ path }/myPage_edit.do">회원정보 수정</a>
        </div>
        <hr>
        <div class="side_menu_cont">
          <a href="${ path }/myPage_delete.do">회원 탈퇴</a>
        </div>
        <hr>
      </div>
    </div>
  </nav>

  <article id="content">

  </article>

</div>
</body>
</html>
