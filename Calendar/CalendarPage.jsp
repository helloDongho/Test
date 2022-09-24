<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");

    String idValue = request.getParameter("id_value"); // loginPage에서 받아옴
    String pwValue = request.getParameter("pw_value"); // loginPage에서 받아옴 
    String userNumValue = request.getParameter("user_num"); // CalendarModule Page에서 보내준 usernum 받아옴 
    

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily","dongho","1234");


    String sql = "SELECT username FROM user WHERE userid=? AND userpw=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);
    query.setString(2, pwValue);


    ResultSet result = query.executeQuery();
    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>(); 
    while(result.next()) {
        ArrayList<String> tmpData = new ArrayList<String>(); 
        tmpData.add(result.getString(1));
        data.add(tmpData);
    }

    Boolean isLogin = false;
    if (data.size() > 0) {
        isLogin = true;
        session.setAttribute("idValue",idValue);
    }

    String calendarSql = "SELECT calendardate,claendarcomment,calendartime,calendarnum FROM calendar WHERE usernum=? ORDER BY calendardate";
    PreparedStatement calendarQuery = connect.prepareStatement(calendarSql);
    calendarQuery.setString(1, userNumValue);

    ResultSet calendarResult = calendarQuery.executeQuery();
    ArrayList<ArrayList<String>> calendarData = new ArrayList<ArrayList<String>>(); 
    while(calendarResult.next()) {
        ArrayList<String> calendarTmpData = new ArrayList<String>(); 
        calendarTmpData.add(calendarResult.getString(1));
        calendarTmpData.add(calendarResult.getString(2));
        calendarTmpData.add(calendarResult.getString(3));
        calendarTmpData.add(calendarResult.getString(4));
        calendarData.add(calendarTmpData);
    }

    Boolean isLoad = false;
    if(calendarData.size() > 0){
        isLoad = true;
    }

%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="CalendarPage/Calendar_page.css" type="text/css">
    <script src="https://kit.fontawesome.com/bec76863d9.js" crossorigin="anonymous"></script>
</head>
<body>
    <header>
        <p id="header-project-name">Daily</p>
        <article id="header-date-container">
                <button class="arrow-button" onclick="minusMonth()">
                    <i class="fa-solid fa-caret-left"></i>
                </button>
            <p id="header-date"></p>
                <button class="arrow-button" onclick="plusMonth()">
                    <i class="fa-solid fa-caret-right"></i>
                </button>
        </article>
        <article id="user-container">
            <p id="user-name"></p>
            <button id="user-logout" onclick="logout()">로그아웃</button>
        </article>
    </header>
    <main>
        <section id="calendar-container">
            <form name="addform">
                <article id="create-calendar">
                    <div id="select-date-time-container">
                        <p id="date">날짜</p>
                        <input type="date" class="calendar-data-input" name="calendar_date">
                        <p id="time">시간</p>
                        <input type="time" class="calendar-data-input" name="calendar_time">
                    </div>
                    <input type="text" id="calendar-contents" placeholder="일정을 입력해 주세요" name="calendar_content">
                    <div id="btn-container">
                        <button type="button" id="calendar-add-btn" onclick="addCalendar()">추가</button>
                    </div>
                </article>
            </form>
            <article id="calendar-list"></article>
        </section>
    </main>
    <script>
        var today = new Date()
        
        function login() {
            if(<%=isLogin%> == true){
            alert("로그인 성공")
            var jspUserName = "<%=data%>"
            var userName = jspUserName.replace(/[\[\]']+/g,'')
            var userNameTag = document.getElementById("user-name")
            userNameTag.innerHTML = userName
        }
            else{
                alert("로그인 실패하였습니다.")
                location.href = "loginPage.jsp"
            }        
        }
        login()

        function logout() {
            var logoutConfirm = confirm("정말로 로그아웃 하시겠습니까?")
            if(logoutConfirm == true) {
                alert("로그아웃 완료")
                location.href = "LogOutModule.jsp"
            }

        }

        function addCalendar() {
            var addForm = document.addform
            var dateData = document.getElementsByClassName("calendar-data-input")
            var calendarContent = document.getElementById("calendar-contents")
            if(calendarContent.value == "" || dateData[0].value == "" || dateData[1].value == ""){
                alert("입력요소를 입력해 주세요")
            }
            else{
                addForm.action = "CalendarAddModulePage.jsp"
                addForm.submit()
            }
        }

        function makeDate() {
            var todayY = today.getFullYear()
            var todayM = today.getMonth() + 1
            var headerDateTag = document.getElementById("header-date")
            headerDateTag.innerHTML = todayY + "/" + todayM
        }
        makeDate()

            function minusMonth(){
                today.setMonth(today.getMonth() - 1)
                makeDate() 
            }

            function plusMonth() {
                today.setMonth(today.getMonth() + 1)
                makeDate()
            }

        window.onload = function(){
            if(<%=isLoad%> == true){
                var jspList = "<%=calendarData%>"
                var String = jspList.replace(/[\[\]']+/g,'')
                var array = String.split(',')
                var twoArray = [];
                var calendarListTag = document.getElementById("calendar-list")
                
                for(var i = 0; i < array.length; i++) {
                array[i] = array[i].trim();
                
                }
                while (array.length > 0) {
                    twoArray.push(array.splice(0,4))
                }

                for(var j =0; j < twoArray.length; j++) {
                    var tmpPtagArry = []
                    var btnArray = []
                    var tmpCalendar = document.createElement("div") 
                    var optionBtnTag = document.createElement("div")

                    tmpCalendar.classList.add("calendar")
                    optionBtnTag.classList.add("option-btn-container")
                    calendarListTag.append(tmpCalendar)  
                    
                    for(var k = 0; k < twoArray[0].length; k++) {
                        var tmpPTag = document.createElement("p")
                        tmpPtagArry.push(tmpPTag)
                        tmpPTag.innerHTML = twoArray[j][k]
                        tmpCalendar.append(tmpPTag)
                    }

                    tmpCalendar.append(optionBtnTag)
                    tmpPtagArry[0].classList.add("date-data")
                    tmpPtagArry[1].classList.add("calendar-data")
                    tmpPtagArry[2].classList.add("time-data")
                    tmpPtagArry[3].classList.add("display-disabled")
                    
                    function createOptionBtn() {
                        var optionBtnContainerTag = document.getElementsByClassName("option-btn-container")
                        
                        for(var l = 0; l < 2; l++){
                            var optionBtn = document.createElement("button")
                            btnArray.push(optionBtn)
                            optionBtn.setAttribute("type","button")
                            optionBtn.setAttribute("class","option-btn")
                            optionBtnContainerTag[j].appendChild(optionBtn) 
                        }

                        btnArray[0].innerHTML = "수정"
                        btnArray[1].innerHTML = "삭제"
                        btnArray[0].classList.add("update-btn")
                        btnArray[1].classList.add("delete-btn")
                        
                    }
                    createOptionBtn()

                    function crudEvent() {
                        var calendarTag = document.getElementsByClassName("calendar")
                        var buttonArray = []

                        calendarTag[j].addEventListener("click",function(e){
                            if(e.target.classList.contains("update-btn")) {

                                // 클릭한 요소의 컨테이너의 자식들을 불러오기 
                                var targetDate = e.currentTarget.children[0]
                                var targetTime = e.currentTarget.children[1]
                                var targetcontent = e.currentTarget.children[2]
                                var targetBtnCon = e.currentTarget.children[4]

                                // 확인 취소 버튼 컨테이너 새로 만들기
                                var buttonContainer = document.createElement("div")
                                buttonContainer.classList.add("option-btn-container")

                                // 수정 버튼 처음 눌렀을때 일정 추가 폼형식으로 바꿔주기 
                                var dateTimeContainerTag = document.getElementById("select-date-time-container")
                                var calendarContentTag = document.getElementById("calendar-contents")

                                // 요소의 하위 요소 까지 전부다 복사하기 위해서 true 라는 값 넣엇다 false는 하위요소 까지 복사 안함 
                                // 예전 브라우저에서는 default 값이 true이지만 최신버젼은 false라고 한다.
                                // 따라서 이 값은 option 값이지만 좀더 명확하게 명시 해주는것이 좋을듯 하다.
                                var cloneTag = dateTimeContainerTag.cloneNode(true)
                                var cloneContent = calendarContentTag.cloneNode(true)
                        
                                //------ 버튼 새로 만들기
                                for(var m = 0; m < 2; m++){
                                    var button = document.createElement("button")
                                    button.setAttribute("type","button")
                                    button.setAttribute("class","option-btn")
                                    buttonArray.push(button)
                                    buttonContainer.appendChild(button)
                                }
                                buttonArray[0].innerHTML = "확인"
                                buttonArray[0].classList.add("check-btn")
                                buttonArray[1].innerHTML = "취소"
                                buttonArray[1].classList.add("cancel-btn")

                                // 원래 있던 태그들 디스플레이 숨기기 
                                targetDate.classList.add("display-disabled")
                                targetTime.classList.add("display-disabled")
                                targetcontent.classList.add("display-disabled")
                                targetBtnCon.classList.add("display-disabled")
                                //클릭한것에 새로 추가 하기
                                e.currentTarget.append(cloneTag,cloneContent,buttonContainer)
                            }
                            else if(e.target.classList.contains("delete-btn")){
                                var result = confirm("정말로 삭제 하시겠습니까?")
                                if(result == true){
                                    var deleteForm = document.createElement("form")
                                    var inputNum = document.createElement("input")
                                    var targetNumTag = e.currentTarget.children[3]
                                    var contentNum = targetNumTag.textContent

                                    inputNum.setAttribute("type","hidden")
                                    inputNum.setAttribute("value",contentNum)
                                    inputNum.setAttribute("name","content_num")

                                    document.body.append(deleteForm)
        
                                    deleteForm.classList.add("display-disabled")
                                    deleteForm.appendChild(inputNum)

                                    deleteForm.action = "CalendarDeleteModule.jsp"
                                    deleteForm.submit()
                                }
                            }
                            else if(e.target.classList.contains("check-btn")) {

                                var updateForm = document.createElement("form")
                                var inputNum = document.createElement("input")
                                var targetNumTag = e.currentTarget.children[3]
                                var contentNum = targetNumTag.textContent

                                var cloneDateData = e.currentTarget.children[5]
                                var cloneContentData = e.currentTarget.children[6]
                                var dateData = cloneDateData.children[1]
                                var timeData = cloneDateData.children[3]

                                inputNum.setAttribute("type","hidden")
                                inputNum.setAttribute("name","content_num")
                                inputNum.setAttribute("value",contentNum)
                                document.body.append(updateForm)

                                if(cloneContentData.value == "" || dateData.value == "" || timeData.value == "" ){
                                    alert("입력요소를 입력해주세요")
                                    return;
                                }
                                else{
                                    updateForm.classList.add("display-disabled")
                                    updateForm.append(cloneDateData,cloneContentData,inputNum)
                                    updateForm.action = "CalendarUpdateModule.jsp"
                                    updateForm.submit()
                                }
                            }
                            else if(e.target.classList.contains("cancel-btn")) {
                                var targetData = e.currentTarget.children[0]
                                var targetContent = e.currentTarget.children[1]
                                var targetTime = e.currentTarget.children[2]
                                var targetBtnCon = e.currentTarget.children[4]
                                var cloneTag = e.currentTarget.children[5]
                                var cloneContent = e.currentTarget.children[6]
                                var cloneBtnCon = e.currentTarget.children[7]
                                console.log(targetContent)

                                targetData.classList.remove("display-disabled")
                                targetContent.classList.remove("display-disabled")
                                targetTime.classList.remove("display-disabled")
                                targetBtnCon.classList.remove("display-disabled")

                                cloneTag.style.display = "none"
                                cloneContent.classList.add("display-disabled")
                                cloneBtnCon.classList.add("display-disabled")
                            }
                        })
                    }
                    crudEvent()
                }
            }
        }
    </script>
</body>
