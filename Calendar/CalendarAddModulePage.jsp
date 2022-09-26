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

    String userNumValue = (String)session.getAttribute("userNumValue");

    String calendarDate = request.getParameter("calendar_date");
    String calendarTime = request.getParameter("calendar_time");
    String calendarContent = request.getParameter("calendar_content");

    String sql = "INSERT INTO calendar(calendardate,calendartime,claendarcomment,usernum) VALUES(?, ? ,? ,?)";
    
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, calendarDate);
    query.setString(2, calendarTime);
    query.setString(3, calendarContent);
    Query.setString(4, userNumValue);
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
            if(<%=isLogin%> == true) {
                alert("일정 추가 완료")
            }
        }
    </script>
</body>
