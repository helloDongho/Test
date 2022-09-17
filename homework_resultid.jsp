<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%-- 설치된 데이터베이스를 찾아주는 명령어  --%>
<%@ page import="java.sql.DriverManager" %>  
<%-- 데이터베이스를 연결해주는 라이브러리 --%>
<%@ page import="java.sql.Connection" %>  
<%-- sql을 만들때 도음을 주는 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>
<%
    request.setCharacterEncoding("utf-8");
    String userNameValue = request.getParameter("username"); //입력한 이름 저장
    String phoneValue = request.getParameter("phone"); // 입력한 전화번호 저장
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework2","dongho","1234"); //db 연결
    
    // SQL문 만들기
    String sql = "SELECT id FROM user WHERE name=? AND phone=?"; //
    PreparedStatement query = connect.prepareStatement(sql); //sql 문 작성할때 쌍따옴표 입력 안해도 되게끔 할꺼고
    query.setString(1, userNameValue);
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
    <script src="https://kit.fontawesome.com/bec76863d9.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="resultuser/index.css" type="text/css">
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
                    <p id="join-path-stage1">아이디찾기</p>
                </article>
                <article id="title">
                    <h3>아이디 찾기 완료</h3>
                </article>
                <article id="user-container">
                    <div class="user-data">
                        <p class="text-guide">아이디</p>
                    </div>
                </article>
                <div id="ok-container">
                    <button type="button" class="join-btn">확인</button>
                </div>
        </section>
    </main>
<script>
    window.onload = function() {
        var buttonTag = document.getElementsByClassName("join-btn")
        var tmpDiv = document.createElement("div")
        var userDataTag = document.getElementsByClassName("user-data")
        if(<%=issearch%> == true) {
            tmpDiv.innerHTML = "<%=data.get(0).get(0)%>"
            userDataTag[0].appendChild(tmpDiv)
        } else {
            alert("등록된 회원정보가 없습니다.")
            location.href = "homework_login.jsp"
            return;
        }
        function clickHandler() {
        location.href = "homework_login.jsp"
        }
        buttonTag[0].addEventListener("click",clickHandler)
}
</script>
</body>
