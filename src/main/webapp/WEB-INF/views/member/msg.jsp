<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:if test="${msg == null}">
    <script>
        location.href='<c:out value="${path}/"/>${url}';
    </script>
</c:if>
<c:if test="${msg != null}">
    <script>
    alert('${msg}');
    location.href='<c:out value="${path}/"/>${url}';
    </script>
</c:if>
</body>
</html>
