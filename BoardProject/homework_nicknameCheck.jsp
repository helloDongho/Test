<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>
<%
    request.setCharacterEncoding("utf-8");
    String nincknameData = request.getParameter("nickval");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework2","dongho","1234");

    String sql = "SELECT nickname FROM user WHERE nickname=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, nincknameData);
    ResultSet result = query.executeQuery();

    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>();
    while(result.next()) {
        ArrayList<String> tmpData = new ArrayList<String>();
        tmpData.add(result.getString(1));
        data.add(tmpData);
    }
    Boolean isCheck = false;
    if (data.size() >= 1) {
        isCheck = true;
    }
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <article>   
            <p>닉네임 중복 찾기</p>
            <input id="input-email" type="text" value="<%=nincknameData%>">
            <button onclick="clickEvent()">확인</button>
            <button onclick="cancelEvent()">취소</button>
    <article>
    <script>
        function clickEvent() {
            var emailTag = document.getElementById("input-email")
            if(<%=isCheck%> == true) {
                alert("이미 사용된 닉네임 입니다.")
                window.opener.document.getElementsByClassName("input-data")[4].value=""
                window.close()
                window.opener.document.getElementsByClassName("input-data")[4].focus()
            }else{
                alert("사용 가능한 닉네임 입니다.")
                window.opener.document.getElementById("check-nicknamedul").value="true"
                window.close()     
            }
        }
        function cancelEvent() {
            window.close()
        }
    </script>