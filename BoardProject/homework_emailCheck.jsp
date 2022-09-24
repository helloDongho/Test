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

    String sql = "SELECT email FROM user WHERE email=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, emailData);
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
            <p>이메일 중복 찾기</p>
            <input id="input-email" type="text" value="<%=emailData%>">
            <button onclick="clickEvent()">확인</button>
            <button onclick="cancelEvent()">취소</button>
    <article>

    <script>
        function clickEvent() {
            var emailTag = document.getElementById("input-email")
            if(<%=isCheck%> == true) {
                alert("이미 사용된 이메일 입니다.")
                window.opener.document.getElementsByClassName("input-data")[5].value=""
                window.close()
                window.opener.document.getElementsByClassName("input-data")[5].focus()
            }else{
                alert("사용 가능한 이메일 입니다.")
                window.opener.document.getElementById("check-emaildul").value="true"
                window.close()     
            }
        }
        function cancelEvent() {
            window.close()
        }
    </script>
</body>
