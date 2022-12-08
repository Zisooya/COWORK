<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
    <link href="${ path }/resources/css/login.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a81368914c.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

<div class="container">
    <div class="login-content">
        <form class="form" name="login" method="post" action="${ path }/member_login_ok.do">
            <div class="input-div one">
                <div class="i">
                    <i class="fas fa-user"></i>
                </div>
                <div class="div">
                    <h5>ID</h5>
                    <input type="text" class="input" id="mem_id" name="mem_id">
                </div>
            </div>
            <div class="input-div pass">
                <div class="i">
                    <i class="fas fa-lock"></i>
                </div>
                <div class="div">
                    <h5>PASSWORD</h5>
                    <input type="password" class="input" id="mem_pwd" name="mem_pwd">
                </div>
            </div>
            <div class="remember">
                <input type="checkbox" class="checkbox" checked id="remember_me">
                <label for="remember_me">아이디 저장</label>
            </div>
            <input type="submit" class="btn" value="로그인" id="btnLogin" name="btnLogin">
            <a href="#">아이디 찾기</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="#">비밀번호 찾기</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="#">회원가입</a>
        </form>
    </div>
</div>

</body>
<script>
    $(document).ready(function () {
        $("#btnLogin").click(function () {
            let mem_id = $("#mem_id").val();
            let mem_pwd = $("#mem_pwd").val();
            if (mem_id === "") {
                alert("아이디를 입력하세요.");
                $("#mem_id").focus();
                return false;
            }
            if (mem_pwd === "") {
                alert("비밀번호를 입력하세요.");
                $("#mem_pwd").focus();
                return false;
            }
        });
    });

    const inputs = document.querySelectorAll(".input");

    function addcl(){
        let parent = this.parentNode.parentNode;
        parent.classList.add("focus");
    }

    function remcl(){
        let parent = this.parentNode.parentNode;
        if(this.value === ""){
            parent.classList.remove("focus");
        }
    }

    inputs.forEach(input => {
        input.addEventListener("focus", addcl);
        input.addEventListener("blur", remcl);
    });
</script>
</html>