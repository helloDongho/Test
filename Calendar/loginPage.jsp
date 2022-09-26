<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="LoginPage/loginPage.css" type="text/css">
    <script src="https://kit.fontawesome.com/bec76863d9.js" crossorigin="anonymous"></script>
</head>
<body>
 <main>
    <p id="title">Daily</p>
    <form name="userform">
        <section id="user-container">
            <article id="login-container">
                <div id="id-data-container">
                    <input id="id-data" type="text" placeholder="아이디 입력" maxlength="20" name="id_value">
                </div>
                <div id="pw-data-container">
                    <input id="pw-data" type="password" placeholder="비밀번호 입력" maxlength="20" name="pw_value">
                </div>
                <div id="login-btn-container">
                    <button type="button" id="login-btn" onclick="login()">로그인</button>
                </div>
            </article>
            <article id="join-exit-container">
                <button type="button" onclick="join()" id="join-btn">회원가입</button>
                <button type="button" onclick="exit()" id="exit-btn">회원탈퇴</button>
            </article>
            <article id="search-id-pw-container">
                <button type="button" onclick="searchid()" id="search-id-btn">아이디 찾기</button>
                <button type="button" onclick="searchpw()" id="search-pw-btn">비밀번호 찾기</button>
            </article>
        </section>
    </form>
</main>
    <script>
        function login() {
            var userForm = document.userform
            var idValue = document.getElementById("id-data")
            var pwValue = document.getElementById("pw-data")
            console.log(idValue)
            if(idValue.value == "" || pwValue.value == "") {
                alert("아이디 혹은 비밀번호를 입력해 주세요")
            }
            else {
                userForm.action = "CalendarPage.jsp"
                userForm.submit()
            }
        }
        function join() {
            location.href = "joinPage.jsp"
        }

        function exit() {
            location.href = "exitPage.jsp"
        }

        function searchid() {
            location.href = "searchIdPage.jsp"
        }

        function searchpw() {
            location.href = "searchPwPage.jsp"
        }
    </script>

</body>
