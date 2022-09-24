<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");

    String userNumValue = request.getParameter("user_num"); // 관리자 혹은 팀원페이지에서 보내준 user num 받아옴
    

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily","dongho","1234");

    String sql = "SELECT username FROM user WHERE usernum=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, userNumValue);

    ResultSet result = query.executeQuery();
    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>();
    while(result.next()) {
        ArrayList<String> tmpData = new ArrayList<String>();
        tmpData.add(result.getString(1));
        data.add(tmpData);
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
    <link rel="stylesheet" href="CalendarAccessUserPage/Calendar_Access_User_Page.css" type="text/css">
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
        </article>
    </header>
    <main>
        <section id="calendar-container">
            <article id="calendar-list"></article>
        </section>
    </main>
    <script>
        var today = new Date()
        
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

                    tmpCalendar.classList.add("calendar")
                    calendarListTag.append(tmpCalendar)  
                    
                    for(var k = 0; k < twoArray[0].length; k++) {
                        var tmpPTag = document.createElement("p")
                        tmpPtagArry.push(tmpPTag)
                        tmpPTag.innerHTML = twoArray[j][k]
                        tmpCalendar.append(tmpPTag)
                    }
                    tmpPtagArry[0].classList.add("date-data")
                    tmpPtagArry[1].classList.add("calendar-data")
                    tmpPtagArry[2].classList.add("time-data")
                    tmpPtagArry[3].classList.add("display-disabled")
                }
            }
        }

        function showUserName() {
            var userNameData = "<%=data%>"
            var userName = userNameData.replace(/[\[\]']+/g,'')
            var userNameTag = document.getElementById("user-name")
            userNameTag.innerHTML = userName + "의 일정입니다."
        }
        showUserName()
    </script>
</body>
