<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div style="width:100%; min-width:690px; height:auto; margin:0; padding:50px 0; box-sizing:border-box; font-family: 'Noto Sans KR', sans-serif;">
    <div style="width:690px; height:auto; margin:0 auto;">
        <div align="center" style="width:548px; height:auto; margin:0; padding:60px 70px; background:#fff;">
            <p style="font-size:28px; font-weight:700; color:#000; line-height:1; letter-spacing:-0.075em; margin-bottom:9px;">회원님의 아이디는&nbsp;<span style="color:#0b64b7;">${memberFindId}</span>&nbsp;입니다.</p>
            <a href="${ path }/member_findPwd.do" style="font-size:18px; font-weight:500; letter-spacing:-0.075em; text-decoration:none; color:#fff; background:#7BE66D; padding:13px 29px 15px; border-radius:50px; display:inline-block; margin:28px 0 0;" rel="noreferrer noopener">비밀번호 찾기</a>&nbsp;&nbsp;
            <a href="${ path }/" style="font-size:18px; font-weight:500; letter-spacing:-0.075em; text-decoration:none; color:#fff; background:#7BE66D; padding:13px 29px 15px; border-radius:50px; display:inline-block; margin:28px 0 0;" rel="noreferrer noopener">로그인</a>
        </div>
    </div>
</div>
</body>
</html>
