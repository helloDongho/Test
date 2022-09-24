<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%
    request.setCharacterEncoding("utf-8");
    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");
    String nameValue = request.getParameter("name_value");
    String PhoneValue = request.getParameter("phone_value");
    String departmentValue = request.getParameter("department");
    String positionValue = request.getParameter("position");

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily","dongho","1234");

    String sql = "INSERT INTO user(userid,userpw,username,userphone,userdepartment,userposition) VALUES(?, ?, ?, ?, ?, ?)";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);
    query.setString(2, pwValue);
    query.setString(3, nameValue);
    query.setString(4, PhoneValue);
    query.setString(5, departmentValue);
    query.setString(6, positionValue);
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
        location.href = "loginPage.jsp"
    </script>
</body>
