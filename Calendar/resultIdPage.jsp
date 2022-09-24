<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");
    String nameValue = request.getParameter("name_value"); //입력한 이름 저장
    String phoneValue = request.getParameter("phone_value"); // 입력한 전화번호 저장
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily","dongho","1234"); //db 연결

    String sql = "SELECT userid FROM user WHERE username=? AND userphone=?"; //
    PreparedStatement query = connect.prepareStatement(sql); //sql 문 작성할때 쌍따옴표 입력 안해도 되게끔 할꺼고
    query.setString(1, nameValue);
    query.setString(2, phoneValue);
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
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="resultIdPage/resultIdPage.css" type="text/css">
    <script src="https://kit.fontawesome.com/bec76863d9.js" crossorigin="anonymous"></script>
</head>
<body>
    <header>
        <p id="header-title">Daily</p>
    </header>
    <main>
        <section>
            <p id="section-header">아이디 찾기 결과</p>
                <article id="user-container">
                    <div id="data-container">
                        <p id="result-userid"></p>
                    </div>
                </article>
                <div id="button-container">
                    <button type="button" onclick="goToLoginEvent()">확인</button>
                </div>
        </section>
    </main>
    <script>
        function resultIdShow() {
            var reulstUserIdTag = document.getElementById("result-userid")

            if(<%=issearch%> == true){
                var jspUserId = "<%=data%>"
                var userID = jspUserId.replace(/[\[\]']+/g,'')
                alert("아이디 찾기 성공")
                reulstUserIdTag.innerHTML = "회원님의 아이디는"+ "&nbsp" + userID + "&nbsp" + "입니다."
                console.log(userID)
            }else {
                alert("아이디 찾기 실패.")
                location.href = "searchIdPage.jsp"
            }
        }
        resultIdShow()
        function goToLoginEvent() {
            location.href = "loginPage.jsp"
        }
    </script>
</body>
