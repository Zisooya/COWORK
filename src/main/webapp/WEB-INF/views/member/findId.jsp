<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="container">
    <form method="post" action="${path}/member_findId_ok.do">
        <div class="input-name">
            <h5>이름</h5>
            <input type="text" class="input" id="mem_name" name="mem_name">
        </div>
        <div class="input-email">
            <h5>이메일</h5>
            <input type="text" name="mem_email">
            <span class="a">@</span>
            <input type="text" name="mail_domain">
            <select name="mail_select">
                <option value="naver">naver.com</option>
                <option value="nate">nate.com</option>
                <option value="gmail">gmail.com</option>
                <option value="self">직접입력</option>
            </select>
        </div>
        <div class="confirm_btn">
            <button type="submit" name="confirm">확인</button>
            <button type="button" name="cancel" onclick="cancel();">취소</button>
        </div>
    </form>
</div>
</body>
</html>
