<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>비밀번호는 ${memberFindPwd} 입니다.</h1>
<a href="${path}/">확인</a>
</body>
</html>
