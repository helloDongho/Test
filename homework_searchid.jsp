<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="homework/searchuser/searchid.css" type="text/css">
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
        <nav id="right-side-nav">
            <p class="nav-text" onclick="goLogin()">로그인</p>
        </nav>
    </header>
    <main>
        <section id="top-section">
            <a href="homework_searchid.jsp">
            <article id="left-select-search">
                <p class="top-text">아이디 찾기</p>
            </article>
            </a>
            <a href="homework_searchpw.jsp">
                <article id="right-select-search">
                    <p class="top-text">비밀번호 찾기</p>
                </article>
            </a>
        </section>
        <section id="middle-secion">
            <h3>아이디찾기</h3>
        </section>
        <section id="bottom-section">
            <article id="search-user-container">
                <h4>회원정보에 등록한 휴대전화로 인증</h4>
                <p>회원정보에 등록한 휴대전화와 입력한 휴대전화가 같아야 합니다.</p>
                <form name="searchform">
                    <div id="left-user-container">
                        <p class="text-guide">이름</p>
                        <input class="input-data" type="text" placeholder="이름을 입력해주세요" maxlength="13" name="username">
                    </div>
                    <div id="right-user-container">
                        <p class="text-guide">휴대전화</p>
                        <input class="input-data" type="text" placeholder="전화번호를 입력해주세요" maxlength="11" name="phone">
                    </div>
                    <div id="select-btn">
                        <button type="button" onclick="idSearchEvent()">확인</button>
                        <button type="button" onclick="backEvent()">취소</button>
                    </div>
                </form>
            </article>
        </section>
    </main>
    <script>
        function idSearchEvent() {
            var idSearchForm = document.searchform
            if (idSearchForm.username.value.length == 0) {
                alert("이름을 입력해주세요")
                return;
            }
            else if (idSearchForm.phone.value.length != 11) {
                alert("핸드폰번호를 정확하게 입력해주세요")
                return;
            }
            idSearchForm.action = "homework_resultid.jsp"
            idSearchForm.submit()
        }

        function backEvent() {
            location.href = "homework_login.jsp"
        }

        function goLogin() {
            location.href = "homework_login.jsp"
        }
    </script>
</body>