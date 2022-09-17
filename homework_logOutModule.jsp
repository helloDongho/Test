<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>


<%
    request.setCharacterEncoding("utf-8");

    session.invalidate();
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

<script>
    window.onload = function() {
        alert("로그아웃 하셨습니다.")
        location.href = "homework_login.jsp"

    }
</script>
</body>