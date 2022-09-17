<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 
<%
    request.setCharacterEncoding("utf-8");

    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");
    String userNameValue = request.getParameter("user_name_value");
    String nickNameValue = request.getParameter("nickname_value");
    String emailValue = request.getParameter("email_value");
    String phoneValue = request.getParameter("phone_value");
    String genderValue = request.getParameter("gender");

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework2","dongho","1234");
    String sql = "INSERT INTO user(id,pw,name,nickname,email,phone,gender) VALUES(?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);
    query.setString(2, pwValue);
    query.setString(3, userNameValue);
    query.setString(4, nickNameValue);
    query.setString(5, emailValue);
    query.setString(6, phoneValue);
    query.setString(7, genderValue);
    query.executeUpdate();
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="homework/finishsignup/index.css" type="text/css">
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
            <h2>회원가입</h2>
                <article id="join-path">
                    <p id="join-path-stage1">약관동의</p>
                    <p id="join-path-stage2">회원정보입력</p>
                    <p id="join-path-stage3">회원가입 완료</p>
                </article>
                <article id="title">
                    <h3>회원가입 완료</h3>
                </article>
                <article id="user-container">
                    <div class="user-data">
                        <p class="text-guide">아이디</p>
                    </div>
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
        var btnTag = document.getElementsByClassName("join-btn")

        function createDiv() {
        var userDataTag = document.getElementsByClassName("user-data")
        var tmpDivArry = []
        for(var i = 0; i < 2; i++) {
            var tmpDiv = document.createElement("div")
            tmpDivArry.push(tmpDiv)
        }
        userDataTag[0].appendChild(tmpDivArry[0])
        userDataTag[1].appendChild(tmpDivArry[1])
        tmpDivArry[0].className = "user-result-data"
        tmpDivArry[1].className = "user-result-data"
        tmpDivArry[0].innerHTML = "<%=idValue%>"
        tmpDivArry[1].innerHTML = "<%=pwValue%>"
        console.log(userDataTag[1])  
        }
        createDiv();
        function clickHandler() {
            location.href = "homework_login.jsp"
        }
        btnTag[0].addEventListener("click",clickHandler)
    </script>
</body>
