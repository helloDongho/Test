<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 

<%
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework2","dongho","1234");
    String idValue = request.getParameter("id_value"); 
    String sql = "DELETE FROM user WHERE id=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1,idValue);
    query.executeUpdate();
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
        alert("회원탈퇴 완료")
        location.href = "homework_login.jsp"
    }
</script>
</body>
