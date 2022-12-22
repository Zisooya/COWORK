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
<div style="width:100%; min-width:690px; height:auto; margin:0; padding:50px 0px; box-sizing:border-box; background:#f4f4f7; font-family: 'Noto Sans KR', sans-serif;">
    <div style="width:690px; height:auto; margin:0 auto;">
        <div align="center" style="width:548px; height:auto; margin:0; padding:60px 70px; background:#fff; border-left:1px solid #f4f4f7; border-right:1px solid #f4f4f7;"><p style="font-size:18px; font-weight:700; color:#000; line-height:1; letter-spacing:-0.075em; margin-bottom:9px;">회원님의 임시 비밀번호는&nbsp;<span style="color:#ff3c00;">VUsPCYx8RK</span>&nbsp;입니다.</p>
            <p style="font-size:15px; font-weight:400; color:#000; line-height:1.7; letter-spacing:-0.075em; margin:0;">안내드린 정보로 접속하셔서 COWORK 서비스를 이용하세요!<br>더욱 편리한 서비스를 제공하기 위해 항상 최선을 다하겠습니다.</p>
            <a href="${ path }/" target="_blank" style="font-size:15px; font-weight:500; letter-spacing:-0.075em; text-decoration:none; color:#fff; background:#3351ff; padding:13px 29px 15px; border-radius:50px; display:inline-block; margin:28px 0 0;" rel="noreferrer noopener">마이페이지로 이동하기</a>
            <div style="width:100%; height:1px; background:#e9e9eb; margin:45px 0 38px">
            </div>
            <p style="font-size:14px; font-weight:400; color:#000; line-height:1.5; letter-spacing:-0.075em; margin-bottom:8px;">본 메일은 발신전용 메일이므로, 회신을 통한 문의는 처리되지 않습니다.</p>
        </div>
    </div>
</div>

</body>
</html>
