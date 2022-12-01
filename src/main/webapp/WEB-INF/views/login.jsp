<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div align="center">
    <form method="post" action="<%=request.getContextPath() %>/member_login_ok.do">
        <h2>로그인</h2>
        <br>
        <a href="<%=request.getContextPath() %>/admin_login.do">관리자로 로그인</a>
        <a href="<%=request.getContextPath() %>/member_login.do">사원으로 로그인</a>
        <br>

        <fieldset>
            <br>
            <input type="text" name="mem_id" placeholder="아이디"></td>
            <br>
            <input type="text" name="mem_pwd" placeholder="비밀번호"></td>
            <br><br>
            <input type="submit" value="로그인">
        </fieldset>

        <a href="#">비밀번호 찾기</a> | <a href="#">아이디 찾기</a> | <a href="#">회원가입</a>
    </form>
</div>

</body>
</html>
