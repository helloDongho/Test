<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="homework/index.css" type="text/css">
</head>

<body>
    <main id="login-page">
        <section id="login-container">
            <h2>Login</h2>
            <form name ="loginfrom">
                <article class="login-detail-conatiner">
                    <input type="text" id="input-id" placeholder="Id" name="id_value">
                </article>
                <article class="login-detail-conatiner">
                    <input type="password" autocomplete="off" id="input-password" placeholder="password" name="pw_value">
                </article>
                <article id="button-conatiner">
                    <button type="button" id="submit-button" onclick ="clickEvent()">Login</button>
                    <button id="Sign-button" type="button">Sign up</button>
                </article>
            </form>
            <article id="search-user-data">
                <a href="homework_searchid.jsp">아이디찾기</a>
                <a href="homework_searchpw.jsp">비밀번호찾기</a>
            </article>
        </section>
    </main>
    <script>
        window.onload = function() {
            var signBtn = document.getElementById("Sign-button")            
            function pageEnterHandler() {
                location.href = "homework_signup.jsp"
            }
            signBtn.addEventListener("click",pageEnterHandler)
        }
        function clickEvent() {
            var idBtn = document.getElementById("input-id")
            var pwBtn = document.getElementById("input-password")
            if(idBtn.value == "" || pwBtn.value == "") {
                alert("로그인 정보를 입력해주세요")
            }else {
                var loginform = document.loginfrom
                loginform.action = "homework_main.jsp"
                loginform.submit()
            }
        }
    </script>
</body>
