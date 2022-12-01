<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8"  %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>임시 메인 페이지</h1>


깃플로우5 develop으로 가야 해


<P><a href="<%=request.getContextPath() %>/testDB.do">DB 연동 테스트</a></P>

<br><br>
<a href="<%=request.getContextPath() %>/calendar.do">📅 캘린더</a>

<br>
테스트1
</body>
</html>