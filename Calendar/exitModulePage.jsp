<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");
    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");
    

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily","dongho","1234");


    String sql = "SELECT usernum FROM user WHERE userid=? AND userpw=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);
    query.setString(2, pwValue);


    ResultSet result = query.executeQuery();
    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>(); 
    while(result.next()) {
        ArrayList<String> tmpData = new ArrayList<String>(); 
        tmpData.add(result.getString(1));
        data.add(tmpData);
    }

    Boolean issearch = false;
    if (data.size() >= 1) {
        issearch = true;
    }

    if(issearch == true) {
        String rmsql = "DELETE FROM user WHERE usernum=?";
        PreparedStatement rmquery = connect.prepareStatement(rmsql);
        rmquery.setString(1, data.get(0).get(0));
        rmquery.executeUpdate();
    }
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
            if(<%=issearch%> == true) {
                alert("회원탈퇴 완료")
                location.href = "loginPage.jsp"
            }
            else {
                alert("회원탈퇴 실패")
                location.href = "exitPage.jsp"
            }
        }
    </script>
</body>
