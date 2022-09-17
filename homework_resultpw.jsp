<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>


<%
    request.setCharacterEncoding("utf-8");
    String useridValue = request.getParameter("userdata"); //입력한 이름 저장
    String phoneValue = request.getParameter("phone"); // 입력한 전화번호 저장
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework2","dongho","1234"); //db 연결
    
    // SQL문 만들기
    String sql = "SELECT pw FROM user WHERE id=? AND phone=?"; //
    PreparedStatement query = connect.prepareStatement(sql); //sql 문 작성할때 쌍따옴표 입력 안해도 되게끔 할꺼고
    query.setString(1, useridValue);
    query.setString(2, phoneValue);
    ResultSet result = query.executeQuery();
    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>(); 
    while(result.next()) {
        ArrayList<String> tmpData = new ArrayList<String>(); 
        tmpData.add(result.getString(1));
        data.add(tmpData);
    }
    Boolean issearch = false;
    if (data.size() > 0) {
        issearch = true;
    }
%>


<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="resultuser/index.css" type="text/css">
    <script src="https://kit.fontawesome.com/bec76863d9.js" crossorigin="anonymous"></script>
</head>
<body>
    <header>
        <article id="logo-container">
            <span id="logo">
                <i class="fa-brands fa-microsoft"></i>
            </span>
            <p id="logo-text">MY community</p>
        </article>
    </header>
    <main>
        <section>
            <h2>결과 페이지</h2>
                <article id="join-path">
                    <p id="join-path-stage1">비밀번호찾기</p>
                </article>
                <article id="title">
                    <h3>비밀번호 찾기 완료</h3>
                </article>
                <article id="user-container">
                    <div class="user-data">
                        <p class="text-guide">비밀번호</p>
                    </div>
                </article>
                <div id="ok-container">
                    <button class="join-btn">확인</button>
                </div>
        </section>
    </main>
    <script>
        window.onload = function() {
            var buttonTag = document.getElementsByClassName("join-btn")
            var userDataTag = document.getElementsByClassName("user-data")
            var tmpDivTag = document.createElement("div")
            if(<%=issearch%> == true) {
                tmpDivTag.innerHTML = "<%=data.get(0).get(0)%>"
                userDataTag[0].appendChild(tmpDivTag)
            } else {
                alert("입력된 정보가 잘못되었습니다.")
                location.href = "homework_login.jsp"
            }
            function clickHandler() {
            location.href = "homework_login.jsp"
            }
            buttonTag[0].addEventListener("click",clickHandler)
        }
    </script>
</body>
</html>