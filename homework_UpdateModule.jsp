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
    String ItemTitle = request.getParameter("writetitle");
    String ItemMain = request.getParameter("writeboard");

    String boardSql = "UPDATE board SET title=?, content=? WHERE boardnum=?";
    PreparedStatement boardDataQuery = connect.prepareStatement(boardSql);
    boardDataQuery.setString(1, ItemTitle);
    boardDataQuery.setString(2, ItemMain);
    boardDataQuery.setString(3, boardNum);
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
        alert("수정 성공 하였습니다.")
        var formTag = document.createElement("form")
        var inputTag = document.createElement("input")
        document.body.appendChild(formTag)
        inputTag.setAttribute("type","hidden")
        inputTag.setAttribute("value","<%=boardNum%>")
        inputTag.setAttribute("name","currentNum")
        formTag.appendChild(inputTag)
        formTag.action = "homework_ItemPage.jsp"
        formTag.submit()
    }
    createElement()
        
</script>
</body>    

