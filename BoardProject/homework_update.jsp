<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<%
    request.setCharacterEncoding("utf-8");
    String pwValue = request.getParameter("pw_value");
    String nickNameValue = request.getParameter("nickname_value");
    String phoneValue = request.getParameter("phone_value");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework2","dongho","1234");
    String sql = "UPDATE user SET pw=?,nickname=?,phone=? WHERE id=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, pwValue);
    query.setString(2, nickNameValue);
    query.setString(3, phoneValue);
    query.setString(4,(String)session.getAttribute("idValue"));
    query.executeUpdate();
%>
<body>
    <script>
        window.onload = function() {
            alert("회원정보 수정완료")
            location.href = "homework_login.jsp"
        }
    </script>
</body>