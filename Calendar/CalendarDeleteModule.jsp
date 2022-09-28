<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>
<%
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily","dongho","1234");
    
    String calendarNum = request.getParameter("content_num");

    String sql = "DELETE FROM calendar WHERE calendarnum=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, calendarNum);
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
        alert("삭제 성공 하였습니다.")
        location.href = "CalendarPage.jsp"
    }
</script>
</body>    
