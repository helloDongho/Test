<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>
<%
    request.setCharacterEncoding("utf-8");
   
    String idData = request.getParameter("idv"); 
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily","dongho","1234");

    String sql = "SELECT userid FROM user WHERE userid=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idData);
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
    <p>아이디 중복 찾기</p>
    <input id="input-id" type="text" value="<%=idData%>">
    <button onclick="clickEvent()">확인</button>
    <button onclick="cancleEvent()" type="button">취소</button>
<article>

<script>
    function clickEvent() {
        var idTag = document.getElementById("input-id")
        if(<%=isCheck%> == true) {
            alert("이미 사용된 아이디 입니다.")
            window.opener.document.getElementById("id-data").focus()
            window.opener.document.getElementById("id-data").value=""
            window.close()
        }else{
            alert("사용 가능한 아이디 입니다.")
            window.opener.document.getElementById("check-dul").value="true"
            window.opener.document.getElementById("id-data").value = idTag.value
            window.close()     
        }
    }
    function cancleEvent() {
        window.close()
    }

</script>
</body>
