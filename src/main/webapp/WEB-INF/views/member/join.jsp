<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>회원가입</title>
    <script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"/>
    <link rel="icon" href="data:;base64,=">
    <style>
        .container {
            min-width: 960px;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 150px;
        }

        h3 {
            width: 300px;
            text-align: center;
            margin-bottom: 50px;
            color: #999;
        }

        .form-group {
            margin-bottom: 15px;
        }

        #img_box {
            width: 100%;
            height: 200px;
            display: flex;
            align-items: center;
        }

        #preview {
            width: 200px;
            height: 200px;
            margin-top: 20px;
            border-radius: 50%;
            border: solid 1px #ced4da;
        }

        #canvas {
            margin-top: 20px;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            border: solid 1px #ced4da;
            display: none;
        }

        label {
            padding-bottom: 5px;
            color: #999;
        }

        .btn {
            display: block;
            width: 120px;
            height: 38px;
            border-radius: 5px;
            outline: none;
            border: none;
            background-size: 200%;
            font-size: 1.2rem;
            color: #fff;
            font-family: "Poppins", sans-serif;
            text-transform: uppercase;
            cursor: pointer;
            transition: 0.5s;
        }

        #btn_box {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
            padding-left: 20%;
            padding-right: 20%;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page-header">
        <div class="col-md-6 col-md-offset-3">
            <h3>회원가입</h3>
        </div>
    </div>

    <div class="col-sm-6 col-md-offset-3">
        <form action="${ path }/member_join_ok.do" method="post" role="form" enctype="multipart/form-data" id="user_check" name="member">
            <div class="form-group">
                <label for="mem_id">아이디</label>
                <input type="text" class="form-control" id="mem_id" name="mem_id">
                <div class="check_font" id="id_check"></div>
            </div>

            <div class="form-group">
                <label for="mem_pwd">비밀번호</label>
                <input type="password" class="form-control" id="mem_pwd" name="mem_pwd">
                <div class="check_font" id="pwd_check"></div>
            </div>

            <div class="form-group">
                <label for="mem_pwd2">비밀번호 확인</label>
                <input type="password" class="form-control" id="mem_pwd2" name="mem_pwd2">
                <div class="check_font" id="pwd2_check"></div>
            </div>

            <div class="form-group">
                <label for="mem_name">이름</label>
                <input type="text" class="form-control" id="mem_name" name="mem_name">
            </div>

            <div class="form-group">
                <label for="mem_email">이메일 주소</label>
                <input type="email" class="form-control" id="mem_email" name="mem_email">
                <div class="check_font" id="email_check"></div>
            </div>

            <div class="form-group">
                <label for="mem_phone">휴대폰 번호</label>
                <input type="tel" class="form-control" id="mem_phone" name="mem_phone" maxlength="13" placeholder="'-'없이 번호만 입력해주세요">
                <div class="check_font" id="phone_check"></div>
            </div>

            <div class="form-group">
                <label for="mem_position">직책 선택</label>
                <select class="form-select" id="mem_position" name="mem_position">
                    <option selected>-</option>
                    <option>팀장</option>
                    <option>팀원</option>
                </select>
            </div>

            <div class="form-group">
                <label for="mem_rank">직급 선택</label>
                <select class="form-select" id="mem_rank" name="mem_rank">
                    <option selected>-</option>
                    <option>부장</option>
                    <option>차장</option>
                    <option>과장</option>
                    <option>대리</option>
                    <option>사원</option>
                </select>
            </div>

            <c:set var="dList" value="${deptList}"/>
            <div class="form-group">
                <label for="dept_name">부서 선택</label>
                <select class="form-select" id="dept_name" name="dept_name">
                    <option selected>-</option>
                    <c:forEach var="dept" items="${dList}">
                        <option value="${dept.dept_name}">${dept.dept_name}</option>
                    </c:forEach>
                </select>
            </div>

            <c:set var="tList" value="${teamList}"/>
            <div class="form-group">
                <label for="team_name">소속 선택</label>
                <select class="form-select" id="team_name" name="team_name">
                    <option selected>-</option>
                    <c:forEach var="team" items="${tList}">
                    <option value="${team.team_name}">${team.team_name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="mem_image">대표 이미지</label>
                <div id="img_box">
                    <img id="preview" src="resources/images/로그인_전_프로필.png" alt="기본 이미지">
                    <canvas id="canvas"></canvas>
                </div>
                <br>
                <input type="file" class="form-control" id="mem_image" name="file" onChange="uploadImgPreview();" accept="image/*">
            </div>

            <div class="form-group text-center" id="btn_box">
                <button type="submit" class="btn btn-primary">회원가입</button>
                <button type="button" class="btn btn-primary" onclick="history.go(-1);">취소</button>
            </div>
        </form>
    </div>
</div>
</body>
<script type="text/javascript">
    // 모든 공백 체크 정규식
    let memJ = /\s/g;
    // 아이디 정규식
    let idJ = /^[0-9a-zA-Z][0-9a-zA-Z]{5,19}$/;
    // 비밀번호 정규식
    let pwJ = /^[0-9a-zA-Z][0-9a-zA-Z]{3,15}$/;
    // 이메일 검사 정규식
    let mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    // 휴대폰 번호 정규식
    let phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;

    // 아이디 중복확인
    $("#mem_id").blur(function () {
        if ($("#mem_id").val() === "") {
            $("#id_check").text("아이디를 입력하세요.");
            $("#id_check").css("color", "red");
        } else if (idJ.test($("#mem_id").val()) !== true) {
            $("#id_check").text("6~20 자리의 영문, 숫자만 사용 가능합니다.");
            $("#id_check").css("color", "red");
        } else if ($("#mem_id").val() !== "") {
            let mem_id = $("#mem_id").val();

            $.ajax({
                async: true,
                type: "get",
                data: "mem_id=" + mem_id,
                url: "${path}/member_idCheck.do",
                dateType: "json",
                contentType: "application/json; charset=UTF-8",
                success: function (data) {
                    if (data > 0) {
                        $("#id_check").text("중복된 아이디 입니다.");
                        $("#id_check").css("color", "red");
                        $("#user_check").attr("disabled", true);
                    } else {
                        if (idJ.test(mem_id)) {
                            $("#id_check").text("사용가능한 아이디 입니다.");
                            $("#id_check").css("color", "blue");
                            $("#user_check").attr("disabled", false);
                        } else if (mem_id === "") {
                            $("#id_check").text("아이디를 입력하세요.");
                            $("#id_check").css("color", "red");
                            $("#user_check").attr("disabled", true);
                        } else {
                            $("#id_check").text(
                                "6~20 자리의 영문, 숫자만 사용 가능합니다."
                            );
                            $("#id_check").css("color", "red");
                            $("#user_check").attr("disabled", true);
                        }
                    }
                },
                error: function () {
                    alert("데이터 통신 오류");
                }
            });
        }
    });

    $("form").on("submit", function () {
        let in_val_arr = new Array(4).fill(false);
        if (idJ.test($("#mem_id").val())) {
            in_val_arr[0] = true;
        } else {
            in_val_arr[0] = false;
            alert("아이디를 확인하세요.");
            return false;
        }
        // 비밀번호가 같은 경우 && 비밀번호 정규식
        if ($("#mem_pwd").val() === $("#mem_pwd2").val() && pwJ.test($("#mem_pwd").val())) {
            in_val_arr[1] = true;
        } else {
            in_val_arr[1] = false;
            alert("비밀번호를 확인하세요.");
            return false;
        }
        // 이메일 정규식
        if (mailJ.test($("#mem_email").val())) {
            console.log(phoneJ.test($("#mem_email").val()));
            in_val_arr[2] = true;
        } else {
            in_val_arr[2] = false;
            alert("이메일 양식을 확인하세요.");
            return false;
        }
        // 휴대폰번호 정규식
        if (phoneJ.test($("#mem_phone").val())) {
            console.log(phoneJ.test($("#mem_phone").val()));
            in_val_arr[3] = true;
        } else {
            in_val_arr[3] = false;
            alert("휴대폰 번호를 확인하세요.");
            return false;
        }
        // 전체 유효성 검사
        let validAll = true;
        for (let i = 0; i < in_val_arr.length; i++) {
            if (in_val_arr[i] === false) {
                validAll = false;
            }
        }
        if (validAll === true) {
            // 유효성 모두 통과
            alert("회원가입이 완료되었습니다.");
        } else {
            alert("정보를 다시 확인하세요.");
        }
    });

    $("#mem_id").blur(function () {
        if (idJ.test($("#mem_id").val())) {
            console.log("true");
            $("#id_check").text("");
        } else {
            console.log("false");
            $("#id_check").text("6~20 자리의 영문, 숫자만 사용 가능합니다.");
            $("#id_check").css("color", "red");
        }
    });

    $("#mem_pwd").blur(function () {
        if (pwJ.test($("#mem_pwd").val())) {
            console.log("true");
            $("#pwd_check").text("");
        } else {
            console.log("false");
            $("#pwd_check").text("4~16 자리의 영문, 숫자만 사용 가능합니다.");
            $("#pwd_check").css("color", "red");
        }
    });

    // 1 ~ 2 패스워드 일치 확인
    $("#mem_pwd2").blur(function () {
        if ($("#mem_pwd").val() !== $(this).val()) {
            $("#pwd2_check").text("비밀번호가 일치하지 않습니다.");
            $("#pwd2_check").css("color", "red");
        } else {
            $("#pwd2_check").text("");
        }
    });

    $("#mem_email").blur(function () {
        if (mailJ.test($(this).val())) {
            $("#email_check").text("");
        } else {
            $("#email_check").text("이메일 양식을 확인하세요.");
            $("#email_check").css("color", "red");
        }
    });

    // 휴대전화
    $("#mem_phone").blur(function () {
        if (phoneJ.test($(this).val())) {
            $("#phone_check").text("");
        } else {
            $("#phone_check").text("휴대폰 번호를 확인하세요.");
            $("#phone_check").css("color", "red");
        }
    });

    function uploadImgPreview() {
        let fileInfo = document.getElementById("mem_image").files[0];
        let reader = new FileReader();

        reader.onload = function () {
            document.getElementById("preview").src = reader.result;
            $("#preview").hide();

            let tempImage = new Image();

            tempImage.src = reader.result;

            tempImage.addEventListener("load", function () {
                $("#canvas").show();

                let canvas = document.getElementById("canvas");
                let canvasContext = canvas.getContext("2d");

                canvas.width = 240;
                canvas.height = 300;

                canvasContext.drawImage(this, -10, -10, 270, 330);

                canvasContext.stroke();
            });
        };

        if (fileInfo) {
            reader.readAsDataURL(fileInfo);
        }
    }
</script>
</html>