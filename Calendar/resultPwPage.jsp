<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");
    String idValue = request.getParameter("id_value"); //입력한 이름 저장
    String phoneValue = request.getParameter("phone_value"); // 입력한 전화번호 저장
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily","dongho","1234"); //db 연결

    String sql = "SELECT userpw FROM user WHERE userid=? AND userphone=?"; //
    PreparedStatement query = connect.prepareStatement(sql); //sql 문 작성할때 쌍따옴표 입력 안해도 되게끔 할꺼고
    query.setString(1, idValue);
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
    <link rel="stylesheet" href="resultPwPage/resultPwPage.css" type="text/css">
    <script src="https://kit.fontawesome.com/bec76863d9.js" crossorigin="anonymous"></script>
</head>
<body>
    <header>
        <p id="header-title">Daily</p>
    </header>
    <main>
        <section>
            <p id="section-header">비밀번호 찾기 결과</p>
                <article id="user-container">
                    <div id="data-container">
                        <p id="result-userpw"></p>
                    </div>
                </article>
                <div id="button-container">
                    <button type="button" onclick="goToLoginEvent()">확인</button>
                </div>
        </section>
    </main>
    <script>
        function resultPwShow(){
            var resultUserPwTag = document.getElementById("result-userpw")
            
                if(<%=issearch%> == true){
                    var jspUserPw = "<%=data%>"
                    var userPw = jspUserPw.replace(/[\[\]']+/g,'')
                    alert("비밀번호 찾기 성공")
                    resultUserPwTag.innerHTML = "비밀번호는" + "&nbsp" + userPw + "&nbsp" + "입니다."
                    console.log(userPw)
            }else {
                alert("비밀번호 찾기 실패.")
                location.href = "searchPwPage.jsp"
            }

        }
        resultPwShow()
        function goToLoginEvent() {
            location.href = "loginPage.jsp"
        }
    </script>
</body>
