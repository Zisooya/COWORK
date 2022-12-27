<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
    <link href="${path}/resources/css/include.css" rel="stylesheet"/>
    <link rel="icon" href="data:;base64,=">
    <style>
        .side_menu_body{
            text-align: center;
        }
        .side_menu_body a{
            text-decoration: none;
            color: black;
        }
        .side_menu_body hr{
            margin-top: 5px;
            margin-bottom: 5px;
        }
        .side_menu_cont{
            border-radius:5px;
            padding-top: 13px;
            padding-bottom: 13px;
        }
        .side_menu_cont:hover{
            background-color: #7BE66D;
        }

        .side_menu_cont:hover > a{
            color:white;
        }

        @font-face {
            font-family: 'Poppins';
            src: url('https://fonts.googleapis.com/css?family=Poppins:600&display=swap');
            font-weight: normal;
            font-style: normal;
        }

        h1 { font-family: 'Poppins'; font-size: 45px; }

        .withDrawal {
            margin-top: 3%;
            display: flex;
            justify-content: center;
            height: 800px;
            padding-left: 200px;
        }

        #header1 { color: red; font-family: 'Poppins'; font-size: 25px; }

        #header1_side {
            font-family: 'Poppins';
            font-size: 15px;
            color: gray;
        }

        .content { border: 1px solid #D5D4D4; }

        #contentOne  {
            font-family: 'Poppins';
            font-size: 16px;
            padding: 10px 30px 10px 15px;
            line-height: 1.7em;
            background-color: #F3F3F3;
            letter-spacing: -0.03em;
        }

        #header_2 { color: gray; font-family: 'Poppins'; font-size: 25px; height: 25px; }

        #contentTwo {
            font-family: 'Poppins';
            font-size: 16px;
            line-height: 1.7em;
            padding: 10px 30px 10px 15px;
            background-color: #F3F3F3;
            letter-spacing: -0.03em;
        }

        #chkment{ font-size: 16px; font-family: 'Poppins'; }

        #byeBtn {
            font-family: 'Poppins';
            font-size: 20px;
            margin-top: 35px;
            border: 1px solid #7BE66D;
            border-radius: 3px;
            background-color: #7BE66D;
            color: #fff;
            width: 130px;
            height: 53px;
        }
        #byeBtn:hover {
            border: 1px solid #C2F347;
            background: linear-gradient(to right, #7BE66D, #C2F347);
            color: white;
        }

        #notByeBtn {
            font-family: 'Poppins';
            font-size: 20px;
            margin-top: 35px;
            border: 1px solid #7BE66D;
            border-radius: 3px;
            background-color: #fff;
            color: #7BE66D;
            width: 130px;
            height: 53px;
        }
        #notByeBtn:hover {
            border: 1px solid #7BE66D;
            color: #7BE66D;
        }
        #byeBtnArea { margin: 30px;}
    </style>
</head>
<body>
<div id="grid_container">

    <jsp:include page="../include.jsp" />

    <nav id="side">
        <label>마이페이지</label>
        <div id="side_menu" style="overflow-y: auto;">
            <div class="side_menu_body">
                <div class="side_menu_cont">
                    <a href="${ path }/myPage_edit.do">회원정보 수정</a>
                </div>
                <hr>
                <div class="side_menu_cont">
                    <a href="${ path }/myPage_delete.do">회원 탈퇴</a>
                </div>
                <hr>
            </div>
        </div>
    </nav>

    <article id="content">
        <form method="post" action="${path}/myPage_delete_ok.do">
        <div class="withDrawal">
            <table>
                <tr>
                    <td><h1>회원탈퇴</h1></td>
                </tr>
                <tr>
                    <td><span id="header1">회원을 탈퇴하시겠습니까?</span></td>
                </tr>
                <tr>
                    <td><span id="header1_side">
						회원탈퇴 시 개인정보 및 COWORK에서 만들어진 모든 데이터는 삭제됩니다.<br>
						(단, 아래 항목은 표기된 법률에 따라 특정 기간 동안 보관됩니다.)<br><br>
					</span>
                        <div class="content">
                            <div id="contentOne">
                                1. 계약 또는 청약청회 등에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률 / 보존 기간 : 5년<br>
                                2. 대금결제 및 재화 등의 공급에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률 / 보존 기간 : 5년<br>
                                3. 전자금융 거래에 관한 기록 보존 이유 : 전자금융거래법 보존 기간 / 보존 기간 : 5년<br>
                                4. 소비자의 불만 또는 분쟁처리에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률 보존 기간 / 보존 기간 : 3년<br>
                                5. 신용정보의 수집/처리 및 이용 등에 관한 기록 보존 이유 : 신용정보의 이용 및 보호에 관한 법률 보존 기간 / 보존 기간 : 3년<br>
                                6. 전자(세금)계산서 시스템 구축 운영하는 사업자가 지켜야 할 사항 고시(국세청 고시 제 2016-3호)(전자세금계산서 사용자에 한함) / 보존 기간 : 5년<br>
                                &nbsp;&nbsp;&nbsp;(단, (세금)계산서 내 개인식별번호는 3년 경과 후 파기)<br>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><br><span id="header_2">유의사항</span></td>
                </tr>
                <tr>
                    <td>
                        <div class="content">
                            <div id="contentTwo">
                                - 회원탈퇴 처리 후에는 회원님의 개인정보를 복원할 수 없으며, 회원탈퇴 진행 시 해당 아이디는 영구적으로 삭제되어 재가입이 불가능합니다.<br>
                                - 회사가 COWORK 내에 존재하는 경우, 회사에 귀속된 데이터에 대해서는 보관됩니다.
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><br>
                        <input type="checkbox" name="agree"><span id="chkment"> 해당 내용을 모두 확인했으며, 회원 탈퇴에 동의합니다.</span>
                    </td>
                </tr>
                <tr>
                    <th>
                        <div id="byeBtnArea">
                            <input type="submit" id="byeBtn" value="확인">
                            <input type="button" id="notByeBtn" onclick="location.href='${path}/myPage.do'" value="취소">
                        </div>
                    </th>
                </tr>
            </table>
        </div>
        </form>
    </article>

</div>
</body>
</html>