<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html>
<head>
    <title>Title</title>
    <link href="${path}/resources/css/include.css" rel="stylesheet"/>
    <script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"/>
    <link rel="icon" href="data:;base64,=">
    <style>
        .side_menu_body {
            text-align: center;
        }

        .side_menu_body a {
            text-decoration: none;
            color: black;
        }

        .side_menu_body hr {
            margin-top: 5px;
            margin-bottom: 5px;
        }

        .side_menu_cont {
            border-radius:5px;
            padding-top: 13px;
            padding-bottom: 13px;
        }

        .side_menu_cont:hover {
            background-color: #7BE66D;
        }

        .side_menu_cont:hover > a {
            color:white;
        }

        .container {
            min-width: 960px;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 10px;
        }

        h3 {
            width: 300px;
            text-align: center;
            margin-bottom: 50px;
            color: #000000;
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
            color: #000000;
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
<div id="grid_container">

    <jsp:include page="../include.jsp" />

    <nav id="side">
        <label>???????????????</label>
        <div id="side_menu" style="overflow-y: auto;">
            <div class="side_menu_body">
                <div class="side_menu_cont">
                    <a href="${ path }/myPage_edit.do">???????????? ??????</a>
                </div>
                <hr>
                <div class="side_menu_cont">
                    <a href="${ path }/myPage_delete.do">?????? ??????</a>
                </div>
                <hr>
            </div>
        </div>
    </nav>

    <article id="content">
        <div class="container">
            <div class="page-header">
                <div class="col-md-6 col-md-offset-3">
                    <h3>???????????? ??????</h3>
                </div>
            </div>

            <div class="col-sm-6 col-md-offset-3">
                <form action="${ path }/myPage_edit_ok.do" method="post" role="form" enctype="multipart/form-data" id="user_check" name="member">
                    <div class="form-group">
                        <label for="mem_id">?????????</label>
                        <input type="text" style="background-color: #e5e3e3" class="form-control" id="mem_id" name="mem_id" value="${member.mem_id}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="mem_pwd">???????????? ??????</label>
                        <input type="password" class="form-control" id="mem_pwd" name="mem_pwd">
                        <div class="check_font" id="pwd_check"></div>
                    </div>

                    <div class="form-group">
                        <label for="mem_pwd2">???????????? ??????</label>
                        <input type="password" class="form-control" id="mem_pwd2" name="mem_pwd2">
                        <div class="check_font" id="pwd2_check"></div>
                    </div>

                    <div class="form-group">
                        <label for="mem_name">??????</label>
                        <input type="text" style="background-color: #e5e3e3" class="form-control" id="mem_name" name="mem_name" value="${member.mem_name}" readonly>
                    </div>

                    <div class="form-group">
                        <label for="mem_email">????????? ??????</label>
                        <input type="email" class="form-control" id="mem_email" name="mem_email" value="${member.mem_email}">
                        <div class="check_font" id="email_check"></div>
                    </div>

                    <div class="form-group">
                        <label for="mem_phone">????????? ??????</label>
                        <input type="tel" class="form-control" id="mem_phone" name="mem_phone" maxlength="13" placeholder="'-'?????? ????????? ??????????????????" value="${member.mem_phone}">
                        <div class="check_font" id="phone_check"></div>
                    </div>

                    <div class="form-group">
                        <label for="mem_position">?????? ??????</label>
                        <select class="form-select" id="mem_position" name="mem_position">
                            <option value="??????" ${member.mem_position == '??????' ? 'selected="selected"' : ''}>??????</option>
                            <option value="??????" ${member.mem_position == '??????' ? 'selected="selected"' : ''}>??????</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="mem_rank">?????? ??????</label>
                        <select class="form-select" id="mem_rank" name="mem_rank">
                            <option value="??????" ${member.mem_rank == '??????' ? 'selected="selected"' : ''}>??????</option>
                            <option value="??????" ${member.mem_rank == '??????' ? 'selected="selected"' : ''}>??????</option>
                            <option value="??????" ${member.mem_rank == '??????' ? 'selected="selected"' : ''}>??????</option>
                            <option value="??????" ${member.mem_rank == '??????' ? 'selected="selected"' : ''}>??????</option>
                            <option value="??????" ${member.mem_rank == '??????' ? 'selected="selected"' : ''}>??????</option>
                        </select>
                    </div>

                    <c:set var="dList" value="${deptList}"/>
                    <div class="form-group">
                        <label for="dept_name">?????? ??????</label>
                        <select class="form-select" id="dept_name" name="dept_name">
                            <c:forEach var="dept" items="${dList}">
                                <option value="${dept.dept_name}" ${member.dept_name == dept.dept_name ? 'selected="selected"' : ''}>${dept.dept_name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <c:set var="tList" value="${teamList}"/>
                    <div class="form-group">
                        <label for="team_name">?????? ??????</label>
                        <select class="form-select" id="team_name" name="team_name">
                            <c:forEach var="team" items="${tList}">
                                <option value="${team.team_name}" ${member.team_name == team.team_name ? 'selected="selected"' : ''}>${team.team_name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="mem_image">?????? ?????????</label>
                        <div id="img_box">
                            <c:choose>
                                <c:when test="${member.mem_image == null}">
                                    <img id="preview" src="resources/images/?????????_???_?????????.png" alt="?????? ?????????">
                                </c:when>
                                <c:otherwise>
                                    <img id="preview" src="${path}/resources/mem_upload/${member.mem_image}" alt="?????? ?????????">
                                </c:otherwise>
                            </c:choose>
                            <canvas id="canvas"></canvas>
                        </div>
                        <br>
                        <input type="file" class="form-control" id="mem_image" name="file" onChange="uploadImgPreview();" accept="image/*">
                    </div>

                    <div class="form-group text-center" id="btn_box">
                        <button type="submit" class="btn btn-primary">??????</button>
                        <button type="button" class="btn btn-primary" onclick="location.href='${path}/myPage.do'">??????</button>
                    </div>
                </form>
            </div>
        </div>
    </article>
</div>
</body>
<script type="text/javascript">
    // ?????? ?????? ?????? ?????????
    let memJ = /\s/g;
    // ???????????? ?????????
    let pwJ = /^[0-9a-zA-Z][0-9a-zA-Z]{3,15}$/;
    // ????????? ?????? ?????????
    let mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    // ????????? ?????? ?????????
    let phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;

    $("form").on("submit", function () {
        let in_val_arr = new Array(3).fill(false);
        // ??????????????? ?????? ?????? && ???????????? ?????????
        if ($("#mem_pwd").val() === $("#mem_pwd2").val() && pwJ.test($("#mem_pwd").val())) {
            in_val_arr[0] = true;
        } else {
            in_val_arr[0] = false;
            alert("??????????????? ???????????????.");
            return false;
        }
        // ????????? ?????????
        if (mailJ.test($("#mem_email").val())) {
            console.log(phoneJ.test($("#mem_email").val()));
            in_val_arr[1] = true;
        } else {
            in_val_arr[1] = false;
            alert("????????? ????????? ???????????????.");
            return false;
        }
        // ??????????????? ?????????
        if (phoneJ.test($("#mem_phone").val())) {
            console.log(phoneJ.test($("#mem_phone").val()));
            in_val_arr[2] = true;
        } else {
            in_val_arr[2] = false;
            alert("????????? ????????? ???????????????.");
            return false;
        }
        // ?????? ????????? ??????
        let validAll = true;
        for (let i = 0; i < in_val_arr.length; i++) {
            if (in_val_arr[i] === false) {
                validAll = false;
            }
        }
        if (validAll === true) {
            // ????????? ?????? ??????
            alert("??????????????? ?????????????????????.");
        } else {
            alert("????????? ?????? ???????????????.");
        }
    });

    $("#mem_pwd").blur(function () {
        if (pwJ.test($("#mem_pwd").val())) {
            console.log("true");
            $("#pwd_check").text("");
        } else {
            console.log("false");
            $("#pwd_check").text("4~16 ????????? ??????, ????????? ?????? ???????????????.");
            $("#pwd_check").css("color", "red");
        }
    });

    // 1 ~ 2 ???????????? ?????? ??????
    $("#mem_pwd2").blur(function () {
        if ($("#mem_pwd").val() !== $(this).val()) {
            $("#pwd2_check").text("??????????????? ???????????? ????????????.");
            $("#pwd2_check").css("color", "red");
        } else {
            $("#pwd2_check").text("");
        }
    });

    $("#mem_email").blur(function () {
        if (mailJ.test($(this).val())) {
            $("#email_check").text("");
        } else {
            $("#email_check").text("????????? ????????? ???????????????.");
            $("#email_check").css("color", "red");
        }
    });

    // ????????????
    $("#mem_phone").blur(function () {
        if (phoneJ.test($(this).val())) {
            $("#phone_check").text("");
        } else {
            $("#phone_check").text("?????????????????? ???????????????.");
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
