<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>비밀번호 찾기</title>
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
        <span class="text-dark h2 text-center">비밀번호 찾기</span>
    </div>
    <form class="form-style" role="form">
        <div class="form-group form-input">
            <label class="form-label mt-4" for="mem_id">ID</label>
            <input type="text" class="form-control" id="mem_id" name="mem_id"/>
            <div class="check_font" id="id_check"></div>
        </div>
        <div class="form-group form-input">
            <label class="form-label mt-4" for="mem_email">EMAIL</label>
            <input type="email" class="form-control" id="mem_email" name="mem_email"/>
            <div class="check_font" id="email_check"></div>
        </div>
        <div class="form-group text-center" id="btn_box">
            <button class="btn btn-primary" type="button" id="pwdConfirm_btn">확인</button>
            <button class="btn btn-primary" type="button" onclick="location.href='${path}/'">취소</button>
        </div>
    </form>
</div>
</body>
<script>
    // 아이디 정규식
    let idJ = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
    // 이메일 검사 정규식
    let mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

    $("#mem_id").blur(function () {
        if (idJ.test($("#mem_id").val())) {
            $("#id_check").text("");
        } else {
            $("#id_check").text("아이디 형식을 확인하세요.");
            $("#id_check").css("color", "red");
        }
    });

    $("#mem_email").blur(function () {
        if (mailJ.test($(this).val())) {
            $("#email_check").text("");
        } else {
            $("#email_check").text("이메일 형식을 확인하세요.");
            $("#email_check").css("color", "red");
        }
    });

    $(document).ready(function () {
        $("#pwdConfirm_btn").click(function () {
            let mem_id = $("#mem_id").val();
            let mem_email = $("#mem_email").val();
            if (mem_id === "") {
                alert("아이디를 입력하세요.");
                $("#mem_id").focus();
                return false;
            }
            if (mem_email === "") {
                alert("이메일을 입력하세요.");
                $("#mem_email").focus();
                return false;
            }
            if (mem_id !== "" && mem_email !== "") {
                $.ajax({
                    url: "${ path }/member_findPwd_ok.do",
                    type: "post",
                    dataType: "text",
                    data: {mem_id : $("#mem_id").val(), mem_email : $("#mem_email").val()},
                    success: function (data) {
                        if (data > 0) {
                            alert('임시 비밀번호가 발급되었습니다. 등록된 이메일을 확인해주세요.');
                            location.replace("${path}/");
                        } else {
                            alert('등록되지 않은 회원입니다.');
                        }
                    },
                    error: function () {
                        alert('데이터 통신 오류');
                        location.replace("${path}/");
                    }
                });
            }
        });
    });
</script>
</html>
