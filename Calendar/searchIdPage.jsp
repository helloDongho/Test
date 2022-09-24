<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="SearchIdPage/searchIdPage.css" type="text/css">
    <script src="https://kit.fontawesome.com/bec76863d9.js" crossorigin="anonymous"></script>
</head>
<body>
    <header>
        <p id="header-title">Daily</p>
    </header>
    <main>
        <section>
            <p id="section-header">아이디 찾기</p>
            <form name="userForm">
                <article id="user-container">
                    <div id="data-container">
                        <div class="input-data">
                            <input type="text" placeholder="이름을 입력해 주세요" id="name-data" name="name_value">
                        </div>
                        <div class="input-data">
                            <input type="text" placeholder="연락처(- 없이 숫자만 입력해 주세요)"" id="phone-data" name="phone_value" maxlength =11>
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

            if(userFormTag.name_value.value == ""){
                alert("이름을 입력해주세요")
            } 
            else if(userFormTag.phone_value.value.length != 11){
                alert("전화번호를 제대로 입력해주세요")
            }
            else {
                userFormTag.action = "resultIdPage.jsp"
                userFormTag.submit()
            }
        }
        function cancelEvent() {
            location.href = "loginPage.jsp"
        }
    </script>
</body>
