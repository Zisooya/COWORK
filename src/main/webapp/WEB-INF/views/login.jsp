<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div align="center">
    <h2>로그인</h2>
    <br>
    <a href="<%=request.getContextPath() %>/admin_login.do">관리자로 로그인</a>
    <a href="<%=request.getContextPath() %>/member_login.do">사원으로 로그인</a>

    <fieldset>
        <table>
            <tr>
                <td><input type="text" placeholder="아이디"></td>
                <td><input type="text" placeholder="비밀번호"></td>
            </tr>
        </table>
        <br>
        <input type="button" value="로그인" onclick="location.href='main.jsp'">
    </fieldset>

    <a href="#">비밀번호 찾기</a> | <a href="#">아이디 찾기</a> | <a href="#">회원가입</a>
</div>

</body>
</html>
