<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:if test="${member != null}">
    <h1>Welcome to home ${ member.mem_name }!</h1>
    <a href="${ path }/member_logout.do">로그아웃</a>
</c:if>
</body>
</html>
