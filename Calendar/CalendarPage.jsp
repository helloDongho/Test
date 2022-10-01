<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>





<%-- // 자바스크립트에서 문자열로 만들어주려면 쌍따옴표 혹은 곁따옴표를 붙여줘야 한다
// 그래야만 문자열로 인식하고 숫자도 양옆에 쌍따옴표 혹은 곁따옴표를 붙여주면 문자로 만들수 있다
// 근데 자바(서버에서) 자바스크립트로 보내주면
// getString으로 데이터를 불러와서 정제 해주는데 그때는 문자로만 값을 데이터베이스에서 받아온다
// 이게 무슨말이냐면 "김팀원" 이런식으로 불러오는게 아닌 김팀원 << 이렇게 불러온다.
// 그렇기 때문에 이 그대로 자바스크립트에 <%=data%> 이런식으로 넣으면 자바스크립트에서는 인식할수가 없는것
// getString으로 데이터를 받아올때에 애초에 받아올때 "김팀원" 이런식으로 받아와서 저장해줘야 한다
// " < 이 쌍따옴표를 붙이는 방법은 escape chracter 문자를 사용해줘야한다. 
// 그 방법은 \" 이런식으로 써줘야 하는데 이것도 escape chracter 형이므로 \ < 이 역슬래시를 문자로 인식해줘야함
// 그렇기에 문자열 형식이 아닌이상 "\"" 이런식으로 역슬래시를 먼저 문자열로 만들어준뒤에 그 뒤에 쌍따옴표를 붙여줘야함--%>

<%
    request.setCharacterEncoding("utf-8");
    
    String idValue = request.getParameter("id_value"); // loginPage에서 받아옴
    String pwValue = request.getParameter("pw_value"); // loginPage에서 받아옴 
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily","dongho","1234");


    String sql = "SELECT usernum,username,userposition,userdepartment FROM user WHERE userid=? AND userpw=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);
    query.setString(2, pwValue);

    ResultSet result = query.executeQuery();
    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>(); 
    while(result.next()) {
        ArrayList<String> tmpData = new ArrayList<String>(); 
        tmpData.add(result.getString(1));
        tmpData.add("\"" + result.getString(2) + "\"");
        tmpData.add("\"" + result.getString(3) + "\"");
        tmpData.add(result.getString(4));
        data.add(tmpData);
    }
    
    Boolean isLogin = false;
    if (data.size() > 0) {
        isLogin = true;
        session.setAttribute("userNumValue",data.get(0).get(0));
        session.setAttribute("userNameValue",data.get(0).get(1));
        session.setAttribute("userPositionValue",data.get(0).get(2));
        session.setAttribute("userDepartValue",data.get(0).get(3));
    }

    String userNumSession = (String)session.getAttribute("userNumValue");
    String userName = (String)session.getAttribute("userNameValue");
    String UserDepart = (String)session.getAttribute("userDepartValue");
    String userPosition = (String)session.getAttribute("userPositionValue");

    Boolean isSession = false;
    if(userNumSession != null) {
        isSession = true;
    }

    Date today = new Date();
    SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
    String now = sf.format(today);
    
    Calendar cal = Calendar.getInstance(); // 현재 실시간 데이터 서버에서 받아옴
    int year = cal.get(Calendar.YEAR); // cal 객체에서 해당 데이터 년도만 받아옴 
    int month = cal.get(Calendar.MONTH)+1; // cal 객체에서 해당 데이터 월만 받아옴
    

    String sYear = request.getParameter("year"); // 년 받아옴
    String sMonth = request.getParameter("month"); // 월 받아옴 

    if(sYear != null && sMonth != null) {
        year = Integer.parseInt(sYear);
        month = Integer.parseInt(sMonth);
    }

    cal.set(year, month-1,1);
    year = cal.get(Calendar.YEAR);
    month = cal.get(Calendar.MONTH)+1;

    String calendarSql = "SELECT calendardate,claendarcomment,calendartime,calendarnum FROM calendar WHERE usernum=? AND DATE_FORMAT(calendardate,'%Y')=? AND DATE_FORMAT(calendardate, '%c')=? ORDER BY calendardate,calendartime";
    PreparedStatement calendarQuery = connect.prepareStatement(calendarSql);
    calendarQuery.setString(1, userNumSession);
    calendarQuery.setString(2, sYear);
    calendarQuery.setString(3, sMonth);

    ResultSet calendarResult = calendarQuery.executeQuery();
    ArrayList<ArrayList<String>> calendarData = new ArrayList<ArrayList<String>>(); 
    while(calendarResult.next()) {
        ArrayList<String> calendarTmpData = new ArrayList<String>(); 
        calendarTmpData.add("\"" + calendarResult.getString(1) + "\"");
        calendarTmpData.add("\"" + calendarResult.getString(2) + "\"");
        calendarTmpData.add("\"" + calendarResult.getString(3) + "\"");
        calendarTmpData.add("\"" + calendarResult.getString(4) + "\"");
        calendarData.add(calendarTmpData);
    }

    Boolean isLoad = false;
    if(calendarData.size() > 0){
        isLoad = true;
    }
        
    // ---------------------------------------------------팀장으로 로그인 했을경우에 데이터 정제 ---------------------------------------------------
    String userDataSql = "SELECT username,usernum FROM user WHERE userdepartment=?";
    PreparedStatement userDataQuery = connect.prepareStatement(userDataSql);
    userDataQuery.setString(1, UserDepart);

    ResultSet userDataResult = userDataQuery.executeQuery();
    ArrayList<ArrayList<String>> userData = new ArrayList<ArrayList<String>>(); 
    while(userDataResult.next()) {
        ArrayList<String> userTmpData = new ArrayList<String>(); 
        userTmpData.add("\"" + userDataResult.getString(1) + "\"");
        userTmpData.add("\"" + userDataResult.getString(2) + "\"");
        userData.add(userTmpData);
    }

    Boolean loadData = false;
    if(userData.size() > 0) {
        loadData = true;
    }

    // ---------------------------------------------------관리자로 로그인 했을경우에 데이터 정제 ------------------------------------------

    String develope = "develope";
    String education = "education";
    String management = "management";

    //--------------------------------------------------- 1. 개발부 팀원 이름 불러오기 ------------------------------------------

    String devUserSql = "SELECT username,usernum FROM user WHERE userdepartment=?";
    PreparedStatement devUserQuery = connect.prepareStatement(devUserSql);
    devUserQuery.setString(1, develope);

    ResultSet devUserResult = devUserQuery.executeQuery();
    ArrayList<ArrayList<String>> devUserData = new ArrayList<ArrayList<String>>(); 
    while(devUserResult.next()) {
        ArrayList<String> devUsertmpData = new ArrayList<String>(); 
        devUsertmpData.add("\"" + devUserResult.getString(1) + "\"");
        devUsertmpData.add("\"" + devUserResult.getString(2) + "\"");
        devUserData.add(devUsertmpData);
    }

    Boolean devDataLoad = false;
    if(devUserData.size() > 0) {
        devDataLoad = true;
    }

    //--------------------------------------------------- 2. 교육부 팀원 이름 불러오기 ------------------------------------------
    String eduUserSql = "SELECT username,usernum FROM user WHERE userdepartment=?";
    PreparedStatement eduUserQuery = connect.prepareStatement(eduUserSql);
    eduUserQuery.setString(1, education);

    ResultSet eduUserResult = eduUserQuery.executeQuery();
    ArrayList<ArrayList<String>> eduUserData = new ArrayList<ArrayList<String>>(); 
    while(eduUserResult.next()) {
        ArrayList<String> eduUsertmpData = new ArrayList<String>(); 
        eduUsertmpData.add("\"" + eduUserResult.getString(1) + "\"");
        eduUsertmpData.add("\"" + eduUserResult.getString(2) + "\"");
        eduUserData.add(eduUsertmpData);
    }

    Boolean eduDataLoad = false;
    if(eduUserData.size() > 0) {
        eduDataLoad = true;
    }

    //--------------------------------------------------- 3. 운영부 팀원 이름 불러오기 ------------------------------------------
    String manageUserSql = "SELECT username,usernum FROM user WHERE userdepartment=?";
    PreparedStatement manageUserSqlUserQuery = connect.prepareStatement(manageUserSql);
    manageUserSqlUserQuery.setString(1, management);

    ResultSet manageUserResult = manageUserSqlUserQuery.executeQuery();
    ArrayList<ArrayList<String>> manageUserData = new ArrayList<ArrayList<String>>(); 
    while(manageUserResult.next()) {
        ArrayList<String> manageUsertmpData = new ArrayList<String>(); 
        manageUsertmpData.add("\"" + manageUserResult.getString(1) + "\"");
        manageUsertmpData.add("\"" + manageUserResult.getString(2) + "\"");
        manageUserData.add(manageUsertmpData);
    }

    Boolean manageDataLoad = false;
    if(manageUserData.size() > 0) {
        manageDataLoad = true;
    }

    //--------------------------------------------------- 불러온 팀원 이름 클릭 했을때 조회 하기 ------------------------------------------

    String userNumValue = request.getParameter("user_num");
    String userCalendarLoadSql = "SELECT calendardate,claendarcomment, calendartime FROM calendar WHERE usernum=? ORDER BY calendardate,calendartime";
    PreparedStatement userCalendarLoadQuery = connect.prepareStatement(userCalendarLoadSql);
    userCalendarLoadQuery.setString(1, userNumValue);

    ResultSet userCalendarLoadResult = userCalendarLoadQuery.executeQuery();
    ArrayList<ArrayList<String>> userCalendarData = new ArrayList<ArrayList<String>>(); 
    while(userCalendarLoadResult.next()) {
        ArrayList<String> userCalendartmpData = new ArrayList<String>(); 
        userCalendartmpData.add("\"" + userCalendarLoadResult.getString(1) + "\"");
        userCalendartmpData.add("\"" + userCalendarLoadResult.getString(2) + "\"");
        userCalendartmpData.add("\"" + userCalendarLoadResult.getString(3) + "\"");
        userCalendarData.add(userCalendartmpData);
    }

    Boolean userCalendarLoad = false;
    if(userCalendarData.size() > 0) {
        userCalendarLoad = true;
    }
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/CalendarPage/Calendar_page.css" type="text/css">
    <script src="https://kit.fontawesome.com/bec76863d9.js" crossorigin="anonymous"></script>
</head>
<body>
    <header>
        <p id="header-project-name" onclick="refreshEvent()">Daily</p>
        <article id="header-date-container">
                <button type="button" class="arrow-button" onclick="previousEvent()">
                    <i class="fa-solid fa-caret-left"></i>
                </button>
            <p id="header-date"></p>
                <button type="button" class="arrow-button" onclick="nextEvent()">
                    <i class="fa-solid fa-caret-right"></i>
                </button>
        </article>
        <article id="user-container">
            <p id="user-name"></p>
            <button id="user-logout" onclick="logout()">로그아웃</button>
            <button id="nav-button" onclick="showUserListEvent()">
                <span>
                    <i class="fa-solid fa-bars"></i>
                <span>
            </button>
        </article>
    </header>
    <nav class="right-side-nav"></nav>
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

        function falutAccess() {
            if(<%=isSession%> == false) {
                location.href = "loginPage.jsp"
            }
        }
        falutAccess()

        function login() {
            var jspUserName = <%=userName%>
            var userNameTag = document.getElementById("user-name")
            if(<%=isLogin%> == true){
                userNameTag.innerHTML = jspUserName
            }
            else if(<%=isSession%> == true){
                userNameTag.innerHTML = jspUserName
            }
            else{
                location.href = "loginPage.jsp"
            }        
        }
        login()

        function refreshEvent() {
            location.href = "CalendarPage.jsp"
        }

        function logout() {
            var logoutConfirm = confirm("정말로 로그아웃 하시겠습니까?")
            if(logoutConfirm == true) {
                alert("로그아웃 완료")
                location.href = "LogOutModule.jsp"
            }
        }

        function previousEvent() {
            var form = document.createElement("form")
            var yearValue = document.createElement("input")
            var MonthValue = document.createElement("input")

            console.log()

            yearValue.setAttribute("type","hidden")
            yearValue.setAttribute("value",<%=year%>)
            yearValue.setAttribute("name","year")

            MonthValue.setAttribute("type","hidden")
            MonthValue.setAttribute("value",<%=month-1%>)
            MonthValue.setAttribute("name","month")

            document.body.appendChild(form)

            form.append(yearValue,MonthValue)

            form.action="CalendarPage.jsp"
            form.submit()
        
        }

        function makeDate() {
            var todayY = <%=year%>
            var todayM = '<%=month%>'
            var headerDateTag = document.getElementById("header-date")
            headerDateTag.innerHTML = todayY + "/" +  todayM
        }
        makeDate()

        function nextEvent() {
            var form = document.createElement("form")
            var yearValue = document.createElement("input")
            var MonthValue = document.createElement("input")

            yearValue.setAttribute("type","hidden")
            yearValue.setAttribute("value",<%=year%>)
            yearValue.setAttribute("name","year")

            MonthValue.setAttribute("type","hidden")
            MonthValue.setAttribute("value",<%=month+1%>)
            MonthValue.setAttribute("name","month")

            document.body.appendChild(form)

            form.append(yearValue,MonthValue)

            form.action="CalendarPage.jsp"
            form.submit()
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

        window.onload = function(){
            
            if(<%=isLoad%> == true){

                var jspList = <%=calendarData%>
                var calendarListTag = document.getElementById("calendar-list")

                for(var j =0; j < jspList.length; j++) {
                    var tmpPtagArry = []
                    var btnArray = []
                    var tmpCalendar = document.createElement("div") 
                    var optionBtnTag = document.createElement("div")

                    tmpCalendar.classList.add("calendar")
                    optionBtnTag.classList.add("option-btn-container")
                    calendarListTag.append(tmpCalendar)  
                    
                    for(var k = 0; k < jspList[0].length; k++) {
                        var tmpPTag = document.createElement("p")
                        tmpPtagArry.push(tmpPTag)
                        tmpPTag.innerHTML = jspList[j][k]
                        tmpCalendar.append(tmpPTag)
                    }

                    tmpCalendar.append(optionBtnTag)
                    tmpPtagArry[0].classList.add("date-data")
                    tmpPtagArry[1].classList.add("calendar-data")
                    tmpPtagArry[2].classList.add("time-data")
                    tmpPtagArry[3].classList.add("display-disabled")

                    
                    function lineThroughEvent() {
                        var now = "<%=now%>"
                        var dateDataTag = document.getElementsByClassName("date-data")
                        var dateDataText = dateDataTag[j].textContent
                        var calendarTag = document.getElementsByClassName("calendar")
                        console.log(now > dateDataText)
                        if(now > dateDataText) {
                            calendarTag[j].style.textDecoration = "line-through"
                        }
                    }
                    lineThroughEvent()
                    
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

        // 직책이 leader 이거나 admin 일 경우에만 nav 버튼 보이게 
        function showNavButton() {
            var navButtonTag = document.getElementById("nav-button")
            var userPosition =  <%=userPosition%>
            if(userPosition == "leader" || userPosition == "admin") {
                navButtonTag.style.display = "inline-block"
                
            }
        }
        showNavButton()

        // nav버튼 을 클릭했을때 side 버튼 display 보였다 안보였다 변하게 

        function showUserListEvent() {
            var rightNavTag = document.getElementsByClassName("right-side-nav")
            rightNavTag[0].classList.toggle("nav-display")
        }

        function LeaderUserDataLoad() {
            var rightNavTag = document.getElementsByClassName("right-side-nav") // nav 펼첬을때 공간 불러오기 
            var userPosition =  <%=userPosition%>
            if(userPosition == "leader") {
                var userDepart = "<%=UserDepart%>"
                var navHeaderTag = document.createElement("p") // 제목 공간 만들기 
                navHeaderTag.classList.add("nav-header")
                rightNavTag[0].appendChild(navHeaderTag)
           
                if(userDepart == "develope") { // 로그인한 팀장이 개발부 팀장일때
                    navHeaderTag.innerHTML = "개발부"
                }
                else if(userDepart == "education") { // 로그인한 팀장이 교육부 팀장일때
                    navHeaderTag.innerHTML = "교육부"
                }
                else if(userDepart == "management") { // 로그인한 팀장이 운영부 팀장일때 
                    navHeaderTag.innerHTML = "운영부"
                }

                if(<%=loadData%> == true){
                    var userData = <%=userData%>
                    for(var j = 0; j < userData.length; j++){
                        var tmpdivTag = document.createElement("div")
                        var tmpPtagArrayArray = []
                        tmpdivTag.classList.add("user-name-data-container")
                        rightNavTag[0].appendChild(tmpdivTag)
                        
                        for(var k = 0; k < userData[0].length; k++){ 
                            var tmpPTag = document.createElement("p")
                            var tmpPtagArray = []
                            tmpPtagArray.push(tmpPTag)
                            tmpPtagArrayArray.push(tmpPtagArray)
                            tmpPTag.innerHTML = userData[j][k]
                            tmpPTag.classList.add("user-name-data")
                            tmpdivTag.appendChild(tmpPTag)
                        }
                        tmpPtagArrayArray[1][0].style.display = "none" // usernum 안보이게 이름만 표시 되게 할거임 
                    }
                }
            }
        }
        LeaderUserDataLoad()

        function adminUserDataLoad() {
            var rightNavTag = document.getElementsByClassName("right-side-nav")
            var userPosition = <%=userPosition%>
            
            //---------------------- admin 일때 Nav Container 구성 만들기 // ex 각 부서 제목칸이나 사원 들어갈 공간 ------------------------------------------
            if(userPosition == "admin"){
                var departContainerArray = [] // 3개의 부서공간에 각각에 접근할수 있도록 배열로 만듬
                var navHeaderArray = []
                for(var i = 0; i < 3; i++){
                    var departContainer = document.createElement("article") //부서공간 3개 생성
                    departContainer.classList.add("depart-Container")
                    departContainerArray.push(departContainer) // 배열에 집어넣고
                    rightNavTag[0].appendChild(departContainer) // nav공간에 3개 부서 공간 집어넣기 
                }
                for(var j = 0; j < departContainerArray.length; j++) {
                    var navHeader = document.createElement("p")
                    navHeader.classList.add("nav-header")
                    navHeaderArray.push(navHeader)
                    departContainerArray[j].appendChild(navHeader)
                }
                navHeaderArray[0].innerHTML = "개발부"
                navHeaderArray[1].innerHTML = "교육부"
                navHeaderArray[2].innerHTML = "운영부"
            
            //------------------------------------------------------------------개발부 사원 불러오기 -------------------------------------------------------
                if(<%=devDataLoad%> == true) {
                    var devUserData = <%=devUserData%>
                    for(var k = 0; k < devUserData.length; k++){
                        var tmpdivTag = document.createElement("div")
                        var tmpPtagArrayArray = []
                        tmpdivTag.classList.add("user-name-data-container")
                        departContainerArray[0].appendChild(tmpdivTag)

                        for(var l = 0; l < devUserData[0].length; l++){
                            var tmpPtag = document.createElement("p")
                            var tmpPtagArray = []
                            tmpPtag.innerHTML = devUserData[k][l]
                            tmpPtag.classList.add("user-name-data")
                            tmpPtagArray.push(tmpPtag)
                            tmpPtagArrayArray.push(tmpPtagArray)    
                            tmpdivTag.appendChild(tmpPtag)
                        }
                    }
                }
            // ------------------------------------------------------------------교육부 사원 불러오기-----------------------------------------------------------
                if(<%=eduDataLoad%> == true) {
                    var eduUserData = <%=eduUserData%>
                    for(var m = 0; m < eduUserData.length; m++){
                        var eduTmpdivTag = document.createElement("div")
                        var eduTmpPtagArrayArray = []
                        eduTmpdivTag.classList.add("user-name-data-container")
                        departContainerArray[1].appendChild(eduTmpdivTag)

                        for(var n = 0; n < eduUserData[0].length; n++){
                            var edutmpPtag = document.createElement("p")
                            var edutmpPtagArray = []
                            edutmpPtag.innerHTML = eduUserData[m][n]
                            edutmpPtag.classList.add("user-name-data")
                            edutmpPtagArray.push(edutmpPtag)
                            eduTmpPtagArrayArray.push(edutmpPtagArray)    
                            eduTmpdivTag.appendChild(edutmpPtag)
                        }
                    }
                }
            //------------------------------------------------------------------운영부 사원 불러오기--------------------------------------------------------
                if(<%=manageDataLoad%> == true) {
                    var manageUserData = <%=manageUserData%>
                    for(var o = 0; o < manageUserData.length; o++){
                        var manTmpdivTag = document.createElement("div")
                        var manTmpPtagArrayArray = []
                        manTmpdivTag.classList.add("user-name-data-container")
                        departContainerArray[2].appendChild(manTmpdivTag)

                        for(var p = 0; p < manageUserData[0].length; p++){
                            var mantmpPtag = document.createElement("p")
                            var mantmpPtagArray = []
                            mantmpPtag.innerHTML = manageUserData[o][p]
                            mantmpPtag.classList.add("user-name-data")
                            mantmpPtagArray.push(mantmpPtag)
                            manTmpPtagArrayArray.push(mantmpPtagArray)    
                            manTmpdivTag.appendChild(mantmpPtag)
                        }
                    }
                }
            }
        }
        adminUserDataLoad()


        function accessUser() {
            var userNameDataContainerTag = document.getElementsByClassName("user-name-data-container")
             // 팀장혹은 관리자 가 팀원 클릭했을때, 자신의 일정 목록 데이터 담긴 공간 불러오기 
         
            for(var i = 0; i < userNameDataContainerTag.length; i++){
                userNameDataContainerTag[i].addEventListener("click",function(e){

                    var userNumTag = e.currentTarget.children[1]
                    var userNumValue = userNumTag.textContent
                    var inputTag = document.createElement("input")
                    var formTag = document.createElement("form")

                    inputTag.setAttribute("type","hidden")
                    inputTag.setAttribute("name","user_num")
                    inputTag.setAttribute("value",userNumValue)
                    console.log(userNumValue)
                    document.body.appendChild(formTag)
                    formTag.append(inputTag)
                    formTag.action = "CalendarPage.jsp"
                    formTag.submit()
                    })
                    
                }
            }
        accessUser()

        //클릭한 팀원 일정 보여주기 
        function loadUserCalendarData() {
            if(<%=userCalendarLoad%> == true) {
                var jspList = <%=userCalendarData%>
                var calendarListTag = document.getElementById("calendar-list")
            
                for(var j =0; j < jspList.length; j++) {
                    var tmpPtagArry = []
                    var tmpCalendar = document.createElement("div") 

                    tmpCalendar.classList.add("AccessUsercalendar")
                    calendarListTag.append(tmpCalendar)  
                    
                    for(var k = 0; k < jspList[0].length; k++) {
                        var tmpPTag = document.createElement("p")
                        tmpPtagArry.push(tmpPTag)
                        tmpPTag.innerHTML = jspList[j][k]
                        tmpCalendar.append(tmpPTag)
                    }

                    tmpPtagArry[0].classList.add("date-data")
                    tmpPtagArry[1].classList.add("calendar-data")
                    tmpPtagArry[2].classList.add("time-data")

                    function lineThrough() {
                        var now = "<%=now%>"
                        var dateDataTag = document.getElementsByClassName("date-data")
                        var dateDataText = dateDataTag[j].textContent
                        var calendarTag = document.getElementsByClassName("AccessUsercalendar")
                        console.log(now > dateDataText)
                        if(now > dateDataText) {
                            calendarTag[j].style.textDecoration = "line-through"
                        }
                    }
                    lineThrough()
                    
                }
            }
        }
        loadUserCalendarData()

        function hideCalendar() {
            var userNameDataContainerTag = document.getElementsByClassName("user-name-data-container")
            
            for(var i = 0; i < userNameDataContainerTag.length; i++){
                userNameDataContainerTag[i].addEventListener("click",function(e){
                    var calendarTag = document.getElementsByClassName("calendar")
                    var myCalendarData = <%=calendarData%>  // 자기 자신 일정목록 데이터 
                    for(var j = 0; j < myCalendarData.length; j++) {
                        calendarTag[j].style.display = "none"
                    }
                })
            }
        }
        hideCalendar()

    </script>
</body>

