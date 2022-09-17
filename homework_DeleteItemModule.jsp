<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>
<%
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework2","dongho","1234");
    String boardNum = request.getParameter("currentNum");

    String boardSql = "DELETE FROM board WHERE boardnum=?";
    PreparedStatement boardDataQuery = connect.prepareStatement(boardSql);
    boardDataQuery.setString(1, boardNum);
    boardDataQuery.executeUpdate();
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="updatewrite/boardwrite.css" type="text/css">
    <script src="https://kit.fontawesome.com/bec76863d9.js" crossorigin="anonymous"></script>
</head>
<body>
<script>
    function createElement() {
        alert("게시글 삭제 성공!")
        location.href = "homework_BoardPage.jsp"
    }
    createElement()
</script>
</body>    
