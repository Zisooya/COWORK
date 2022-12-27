<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>아이디 찾기</title>
    <script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"/>
    <script src="https://kit.fontawesome.com/a81368914c.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="icon" href="data:;base64,="/>
    <style>
        .btn {
            width: 150px;
        }
        .form-input {
            width: 300px;
        }

        .form-style {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .container {
            margin: 0 auto;
            margin-top: 108px;
        }

        #btn_box {
            margin-top: 30px;
        }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="row align-items-center justify-content-between">
        <span class="text-dark h2 text-center">아이디 찾기</span>
    </div>
    <form class="form-style" role="form" method="post" action="${path}/member_findId_ok.do">
        <div class="form-group form-input">
            <label for="mem_name" class="form-label mt-4">이름</label>
            <input type="text" class="form-control" id="mem_name" name="mem_name"/>
        </div>
        <div class="form-group form-input">
            <label class="form-label mt-4" for="mem_email">EMAIL</label>
            <input type="email" class="form-control" id="mem_email" name="mem_email"/>
            <div class="check_font" id="email_check"></div>
        </div>
        <div class="form-group text-center" id="btn_box">
            <button class="btn btn-primary" id="btn_confirm" type="submit">확인</button>
            <button class="btn btn-primary" type="button" onclick="location.href='${path}/'">취소</button>
        </div>
    </form>
</div>
</body>
<script>
    // 이메일 검사 정규식
    let mailJ =
        /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

    $("#mem_email").blur(function () {
        if (mailJ.test($(this).val())) {
            $("#email_check").text("");
        } else {
            $("#email_check").text("이메일 형식을 확인하세요.");
            $("#email_check").css("color", "red");
        }
    });

    $(document).ready(function () {
        $("#btn_confirm").click(function () {
            let mem_name = $("#mem_name").val();
            let mem_email = $("#mem_email").val();
            if (mem_name === "") {
                alert("이름을 입력하세요.");
                $("#mem_name").focus();
                return false;
            }
            if (mem_email === "") {
                alert("이메일을 입력하세요.");
                $("#mem_email").focus();
                return false;
            }
        });
    });
    /*$(document).ready(function () {
        $("#btn_confirm").click(function () {
            this.$("body").style.overflow = "hidden";
            $("#background_modal").show();
        });
        $("#close").on('click', function () {
            $("#background_modal").hide();
        });
        $(window).on('click', function () {
            if (event.target === $("#background_modal").get(0)) {
                $("#background_modal").hide();
            }
        });
    });*/

</script>
</html>
