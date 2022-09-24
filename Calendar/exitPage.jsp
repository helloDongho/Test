<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="exitPage/exitPage.css" type="text/css">
    <script src="https://kit.fontawesome.com/bec76863d9.js" crossorigin="anonymous"></script>
</head>
<body>
    <header>
        <p id="header-title">Daily</p>
    </header>
    <main>
        <section>
            <p id="section-header">회원탈퇴</p>
            <form name="userForm">
                <article id="user-container">
                    <div id="data-container">
                        <div class="input-data">
                            <input type="text" placeholder="아이디를 입력해 주세요" id="id-data" name="id_value">
                        </div>
                        <div class="input-data">
                            <input type="password" placeholder="비밀번호를 입력해 주세요" id="pw-data" name="pw_value" maxlength=11>
                        </div>
                    </div>
                </article>
                <div id="button-container">
                    <button type="button" onclick="confirmEvent()">확인</button>
                    <button type="button" onclick="cancelEvent()">취소</button>
                </div>
            </form>
        </section>
    </main>
    <script>
        function confirmEvent() {
            var userFormTag = document.userForm

            if(userFormTag.id_value.value == ""){
                alert("아이디를 입력해주세요")
            } 
            else if(userFormTag.pw_value.value == ""){
                alert("비밀번호를 입력해주세요")
            }
            else {
                var result = confirm("정말로 회원탈퇴 하시겠습니까?")
                if(result == true) {
                    userFormTag.action = "exitModulePage.jsp"
                    userFormTag.submit()
                }
            }
        }
        function cancelEvent() {
            location.href = "loginPage.jsp"
        }
    </script>
</body>
