<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
    <link href="${ path }/resources/css/include.css" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <script>
        $(document).ready(function () {
            $("#btnLogin").click(function () {
                let mem_id = $("#mem_id").val();
                let mem_pwd = $("#mem_pwd").val();
                if (mem_id === "") {
                    alert("아이디를 입력하세요.");
                    $("#mem_id").focus();
                    return;
                }
                if (mem_pwd === "") {
                    alert("비밀번호를 입력하세요.");
                    $("#mem_pwd").focus();
                }
                document.login.action="${ path }/member_login_ok.do"
                document.login.submit();
            });
        });
    </script>
</head>
<body>

<div id="grid_container">

    <jsp:include page="include.jsp" />

    <nav id="side">
        <div id="side_menu" style="overflow-y: auto">

        </div>
    </nav>

    <article id="content">
    <form name="login" method="post">
        <h2>로그인</h2>
        <br>
        <a href="<%=request.getContextPath() %>/admin_login.do">관리자로 로그인</a>
        <a href="<%=request.getContextPath() %>/member_login.do">사원으로 로그인</a>
        <br>

        <fieldset>
            <br>
            <input type="text" id="mem_id" name="mem_id" placeholder="아이디">
            <br>
            <input type="password" id="mem_pwd" name="mem_pwd" placeholder="비밀번호">
            <br><br>
            <button type="button" id="btnLogin" name="btnLogin">로그인</button>
        </fieldset>

        <a href="#">비밀번호 찾기</a> | <a href="#">아이디 찾기</a> | <a href="#">회원가입</a>
    </form>
    </article>
</div>

</body>
</html>
