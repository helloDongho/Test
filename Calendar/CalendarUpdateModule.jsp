<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily","dongho","1234");

    String userNumValue = (String)session.getAttribute("userNumValue");
    if(userNumValue == null) {
        response.sendRedirect("loginPage.jsp");
        return;
    } 

    String CalendarDate = request.getParameter("calendar_date");
    String CalendarTime = request.getParameter("calendar_time");
    String CalendarContent = request.getParameter("calendar_content");
    String CalendarNum = request.getParameter("content_num");


    String sql = "UPDATE calendar SET calendardate=?, calendartime=?, claendarcomment=? WHERE calendarnum=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, CalendarDate);
    query.setString(2, CalendarTime);
    query.setString(3, CalendarContent);
    query.setString(4, CalendarNum);
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
        alert("수정 성공 하였습니다.")
        location.href = "CalendarPage.jsp"
        }
</script>
</body>    



