<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>DB 연동 테스트</h2>

<c:set var="dto" value="${Test }"/>
<div>${dto.getMem_no() }번 회원 아이디 : ${dto.getMem_id() }</div>

</body>
</html>