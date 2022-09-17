<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="homework/user/userSign.css?after" type="text/css">
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
            <p class="nav-text">게시판</p>
            <p class="nav-text">내정보</p>
            <p class="nav-text">News</p>
        </nav>
    </header>
    <main>
        <section>
            <h2>회원가입</h2>
            <article class="join-path">
                <div id="join-path-stage1">약관동의</div>
                <div id="join-path-stage2">회원정보입력</div>
                <div id="join-path-stage3">회원가입 완료</div>
            </article>
            <article id="title">
                <h3>회원정보 입력</h3>
            </article>
            <form name="myform">
                <article id="user-container">
                    <div class="user-data">
                        <p class="text-guide">아이디</p>
                        <input class="input-data" type="text" placeholder="최소: 5글자이상 최대: 13글자" maxlength="13" name="id_value">
                        <button type="button" class="check-btn" onclick="idCheckEvent()">중복확인</button>
                        <input id="check-dul" type="hidden" value="false"><!-- 아이디 중복 체크 중복체크 하는순간 value는 true로 변함-->
                    </div>
                    <div class="user-data">
                        <p class="text-guide">비밀번호</p>
                        <input class="input-data" type="password" placeholder="영문,숫자,특수문자 포함 최소 5글자 최대 13글자" maxlength="13" name="pw_value">
                    </div>
                    <div class="user-data">
                        <p class="text-guide">비밀번호확인</p>
                        <input class="input-data" type="password" placeholder="영문,숫자,특수문자 포함 최소 5글자 최대 13글자" maxlength="13">
                    </div>
                    <div class="user-data">
                        <p class="text-guide">이름</p>
                        <input class="input-data" type="text" placeholder="이름을 입력해 주세요" name="user_name_value">
                    </div>
                    <div class="user-data">
                        <p class="text-guide">닉네임</p>
                        <input class="input-data" type="text" placeholder="ex:동쪽의호랑이" name="nickname_value">
                        <button type="button" class="check-btn" onclick="nickNameCheckEvent()">중복확인</button>
                        <input id="check-nicknamedul" type="hidden" value="false"><!-- 아이디 중복 체크 중복체크 하는순간 value는 true로 변함-->
                    </div>
                    <div class="user-data">
                        <p class="text-guide">이메일</p>
                        <input class="input-data" type="text" placeholder="ex: abc123@example.com" name="email_value">
                        <button type="button" class="check-btn" onclick="emailCheckEvent()">중복확인</button>
                        <input id="check-emaildul" type="hidden" value="false"><!-- 이메일 중복 체크 중복체크 하는순간 value는 true로 변함-->
                    </div>
                    <div class="user-data">
                        <p class="text-guide">전화번호</p>
                        <input class="input-data" type="text" placeholder="ex:01012345678"name="phone_value" maxlength="11">
                    </div>
                    <div class="user-data">
                        <p class="text-guide">성별</p>
                        <input class="check-data" type="radio" name="gender" value="남" checked="checked">
                        <p class="gender-guide">남</p>
                        <input class="check-data" type="radio" name="gender" value="여">
                        <p class="gender-guide">여</p>
                        <input class="check-data" type="radio" name="gender" value="선택안함">
                        <p class="gender-guide">선택안함</p>
                    </div>
                    <div id="join-container">
                        <button type="button" class="join-btn" onclick="joinEvent()">가입하기</button>
                    </div>
                </article>
            </form>
        </section>
    </main>
<script>

    var myForm = document.myform  
    var inputDataTag = document.getElementsByClassName("input-data") 

    function joinEvent() {
        var dulIdCheck = document.getElementById("check-dul")
        var dulEmailCheck = document.getElementById("check-emaildul") 
        var dulNicknameCheck = document.getElementById("check-nicknamedul")

        if
        (
            inputDataTag[0].value == "" || inputDataTag[1].value == "" || inputDataTag[2].value == "" || inputDataTag[3].value == "" 
            || inputDataTag[4].value =="" || inputDataTag[5].value =="" || inputDataTag[6].value == ""
        ) 
        {
            alert("입력되지 않은 정보가 존재 합니다.!")
            return;
        }
        else if(inputDataTag[1].value != inputDataTag[2].value) {
            alert("비밀번호를 다시 확인 부탁드립니다.")
            return;
        }
        else if(inputDataTag[6].value.length != 11){
            alert("핸드폰 번호 다시 한번 확인 부탁드립니다.")
            return;
        }
        else if(dulIdCheck.value == "false" || dulEmailCheck.value == "false" || dulNicknameCheck.value == "false" ) {
            alert("중복체크 확인 부탁드립니다.")
            return;
        }
        else if(dulIdCheck.value == "true" || dulEmailCheck.value == "true" || dulNicknameCheck.value == "true"){
            alert("회원가입 성공!")
            myForm.action = "homework_finishsignup.jsp"
            myForm.submit()
        }
    }

    function idCheckEvent() {

        var idValue = document.myform.id_value.value

        if(idValue.length <= 4) {
             alert("아이디는 최소 5글자 이상")
        }
        else if(idValue != "") {
            window.open("homework_idCheck.jsp?idv=" + idValue, parent, "width=450,height=350")
        }
        else {
            alert("아이디를 입력해 주세요")
            myForm.id_value.focus();
            return;
        } 
    }

    function nickNameCheckEvent() {
        var nickNameValue = document.myform.nickname_value.value
        if(nickNameValue != ""){
            window.open("homework_nicknameCheck.jsp?nickval=" + nickNameValue, parent, "width=450,height=350")
        }
        else {
            alert("닉네임을 입력해 주세요")
            myform.nickname_value.focus()
        }
    }

    function emailCheckEvent() {
        var emailValue = document.myform.email_value.value
       
        if(emailValue != "") {
            window.open("homework_emailCheck.jsp?emv=" + emailValue, parent, "width=450,height=350")  
        }

        else {
            alert("이메일 주소를 입력해 주세요") 
            myform.email_value.focus()
        }
    }
     
        
    function changeEvent() {

        for(var i = 0; i < 3; i++){
            if(inputDataTag[i].value.length > 4){
                if(inputDataTag[1].value == inputDataTag[2].value){
                    inputDataTag[i].classList.add("active")
                }
            } 
        }
      
        for(var j = 3; j < 6; j++) {
            if(inputDataTag[j].value.length > 0){
                inputDataTag[j].classList.add("active")
            }
        }

        if(inputDataTag[6].value.length == 11) {
            inputDataTag[6].classList.add("active")
        }

        for(var k = 0; k < inputDataTag.length; k++){
            if(inputDataTag[k].value.length == 0){
                inputDataTag[k].classList.remove("active")
            }
        }
    }

    function addEventListenerEvent() {

        for(var i = 0; i < 3; i++){  
            inputDataTag[i].addEventListener("change",changeEvent)
        }   
        for(var j = 3; j < 6; j++) {
            inputDataTag[j].addEventListener("change",changeEvent)
        }
        
        for(var k = 0; k < inputDataTag.length; k++) {
            inputDataTag[k].addEventListener("change",changeEvent)
        }

        inputDataTag[6].addEventListener("change",changeEvent)
    }
    addEventListenerEvent()

   
</script>
</body>

