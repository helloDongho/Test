<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>
<%
    request.setCharacterEncoding("utf-8");
    String emailData = request.getParameter("emv");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework2","dongho","1234");
    
    String userNum = request.getParameter("usernum");
    String boardNum = request.getParameter("currentnum");
    String commentNum = request.getParameter("commentnum");
    
    String sql = "DELETE FROM comment WHERE usernum=? AND boardnum=? AND commentnum=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, userNum);
    query.setString(2, boardNum);
    query.setString(3, commentNum);
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
        alert("댓글 삭제 성공")
        location.href = "homework_ItemPage.jsp?currentNum=" + <%=boardNum%>
    }
</script>
</body>