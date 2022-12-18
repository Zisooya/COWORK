<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
    <link href="${path}/resources/css/include.css" rel="stylesheet"/>
</head>
<body>
<div id="grid_container">

    <jsp:include page="../include.jsp" />

    <nav id="side">
        <label>주소록</label>
        <div id="side_menu" style="overflow-y: auto;">

        </div>
    </nav>

    <article id="content">
        <h1>회원탈퇴 페이지</h1>
    </article>

</div>
</body>
</html>