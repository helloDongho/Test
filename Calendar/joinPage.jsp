<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="JoinPage/joinPage.css" type="text/css">
    <script src="https://kit.fontawesome.com/bec76863d9.js" crossorigin="anonymous"></script>
</head>
<body>
    <header>
        <p id="header-title">Daily</p>
    </header>
    <main>
        <form name="userform">
            <section>
                <p id="section-title">회원정보입력</p>
                    <article id="user-data-container">
                        <div id= "user-data-id">
                            <input id="id-data" name="id_value" type="text" placeholder="아이디 (영문 숫자 포함 20자 이내)" maxlength="20">
                            <div id="btn-container">
                                <button type="button" onclick="idcheckEvent()"id="search-dul">중복찾기</button>
                                <input id="check-dul" type="hidden" value="false"><!-- 아이디 중복 체크 중복체크 하는순간 value는 true로 변함-->
                            </div>
                        </div>
                        <div class="user-data">
                            <input class="pw-data" name="pw_value" type="password" placeholder="비밀번호 (영문 숫자 특수 문자 포함 20자 이내)"maxlength="20">
                        </div>
                        <div class="user-data">
                            <input class="pw-data" type="password" placeholder="비밀번호 확인" maxlength="20">
                        </div>
                        <div class="user-data">
                            <input id="name-data" name="name_value" type="text" placeholder="이름">
                        </div>
                        <div class="user-data">
                            <input id="phone-data" name="phone_value" type="text" placeholder="연락처(- 없이 숫자만 입력해 주세요)" maxlength="11">
                            <div id="btn-container">
                                <button type="button" onclick="phoneCheckEvent()" id="search-dul">중복찾기</button>
                                <input id="check-phonedul" type="hidden" value="false"><!-- 이메일 중복 체크 중복체크 하는순간 value는 true로 변함-->
                            </div>
                        </div>
                        <div class="select-user-data">
                            <p id="department-title">부서</p>
                            <select id="id-department" name="department">
                                <option value="develope">개발부</option>
                                <option value="education">교육부</option>
                                <option value="management">운영부</option>
                            </select>
                        </div>
                        <div class="select-user-data">
                            <p id="position-title">직책</p>
                            <select id="id-position" name="position">
                                <option value="member">팀원</option>
                                <option value="leader">팀장</option>
                                <option value="admin">관리자</option>
                            </select>
                        </div>
                        <div id="option-btn-container">
                            <button type="button" onclick= "joinEvent()" class="option-btn">가입하기</button>
                            <button type="button" onclick= "cancelEvent()" class="option-btn">취소</button>
                        </div>
                    </article>
            </section>
        </form>
    </main>
    <script>
        function idcheckEvent() {
            var idTag = document.getElementById("id-data")
            var idValue = document.userform.id_value.value
            if(idTag.value.length <= 4) {
                alert("아이디는 5글자 이상 입력해 주세요")
                idTag.focus()
            }else {
                window.open("idCheck.jsp?idv=" + idValue, parent, "width=500,height=350" )
            }
        }

        function phoneCheckEvent() {
            var phoneTag = document.getElementById("phone-data")
            var phoneValue = document.userform.phone_value.value
            if(phoneTag.value.length != 11) {
                alert("핸드폰 정확히 입력해 주세요")
                phoneTag.focus()
            }
            else{
                window.open("phoneCheck.jsp?phv=" + phoneValue, parent, "width=500,height=350")
            }
        }
        
        function joinEvent() {
            var idTag = document.getElementById("id-data")
            var pwTag = document.getElementsByClassName("pw-data")
            var nameTag = document.getElementById("name-data")
            var phoneTag = document.getElementById("phone-data")
            var idValue = document.getElementById("check-dul")
            var phoneValue = document.getElementById("check-phonedul")
            var formTag = document.userform

            if(idTag.value == ""|| pwTag[0].value == "" || pwTag[1].value == "" || nameTag.value == "" || phoneTag == ""){
                alert("입력조건 확인 부탁드립니다.")
            }
            else if(idValue.value == "false" || phoneValue.value == "false") {
                alert("중복체크 해주세요.")
            }
            else if(pwTag[0].value != pwTag[1].value) {
                alert("비밀번호 확인 부탁드립니다.")
            }
            else {
                alert("회원가입 성공하였습니다.")
                formTag.action = "joinModulePage.jsp"
                formTag.submit()
            }
            console.log(phoneValue)
        }
        function cancelEvent() {
            location.href = "loginPage.jsp"
        }
    </script>
</body>
