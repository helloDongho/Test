<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>
<%
    request.setCharacterEncoding("utf-8");
    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework2","dongho","1234");//지정된 데이터베이스의 url에 접속시도

    String sql = "SELECT nickname FROM user WHERE id=? AND pw=?";
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
    if (data.size() >= 1) {
        isLogin = true;
        session.setAttribute("idValue",idValue);
    }
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="enterPage/index.css" type="text/css">
    <script src="https://kit.fontawesome.com/bec76863d9.js" crossorigin="anonymous"></script>
</head>
<body>
     <nav id="nav">
        <header id="logo-header">
            <div id="logo-container">
                <button type="button" id="logbutton">
                    <img id="headerlogo" src="enterPage/stageuslogo.png"
                </button>
            </div>
        </header>
        <article class="nav-menu-container">
            <div class="nav-menu">
                <span class="number">
                    <i class="fa-solid fa-1"></i>
                </span>
                <p class="nav-menu-text">CAPABLE DEVELOPER</p>
            </div>
                <ul class="ul">
                    <li class="li-text">Get a Computer Quote</li>
                </ul>
        </article>
        <article class="nav-menu-container">
            <div class="nav-menu">
                <span class="number">
                    <i class="fa-solid fa-2"></i>
                </span>
                <p class="nav-menu-text">HTML&CSS</p>
            </div>
            <a href="/enterPage/youtube/index.html" class="link-html">
                <ul class="ul">
                    <li class="li-text">Youtube Clone</li>
                </ul>
            </a>
        </article>
        <article class="nav-menu-container">
            <div class="nav-menu">
                <span class="number">
                    <i class="fa-solid fa-3"></i>
                </span>
                <p class="nav-menu-text">JAVASCRIPT-1</p>
            </div>
            <a href="/enterPage/baseball/index.html" class="link-html">
                <ul class="ul">
                    <li class="li-text">Bulls&Cows</li>
                </ul>
            </a>
        </article>
        <article class="nav-menu-container">
            <div class="nav-menu">
                <span class="number">
                    <i class="fa-solid fa-4"></i>
                </span>
                <p class="nav-menu-text">JAVASCRIPT-2</p>
            </div>
            <a href="/enterPage/numsarry/index.html" class="link-html">
                <ul class="ul">
                    <li class="li-text">Drag&Drop</li>
                </ul>
            </a>
        </article>
        <article class="nav-menu-container">
            <div class="nav-menu">
                <span class="number">
                    <i class="fa-solid fa-5"></i>
                </span>
                <p class="nav-menu-text">BACKEND-0</p>
            </div>
            <a href="#" class="link-html">
                <ul class="ul">
                    <li class="li-text">Sum</li>
                </ul>
            </a>
        </article>
        <article class="nav-menu-container">
            <div class="nav-menu">
                <span class="number">
                    <i class="fa-solid fa-6"></i>
                </span>
                <p class="nav-menu-text">PERSONAL1</p>
            </div>
            <a href="/enterPage/kongkong/index.html" class="link-html">
                <ul class="ul">
                    <li class="li-text">KoongKoongDda</li>
                </ul>
            </a>
        </article>
        <article class="nav-menu-container">
            <div class="nav-menu">
                <span class="number">
                    <i class="fa-solid fa-7"></i>
                </span>
                <p class="nav-menu-text">PERSONAL2</p>
            </div>
            <a href="/enterPage/canvas/index.html" class="link-html">
                <ul class="ul">
                    <li class="li-text">SomeThing</li>
                </ul>
            </a>
        </article>
        <article class="nav-menu-container">
            <div class="nav-menu">
                <span class="number">
                    <i class="fa-solid fa-8"></i>
                </span>
                <p class="nav-menu-text">UNDEFINED</p>
            </div>
            <a href="#" class="link-html">
                <ul class="ul">
                    <li class="li-text">SomeThing</li>
                </ul>
            </a>
        </article>
    </nav>
    <main>
        <header id="mainheader">
            <article id="left-header">
                <a href="homework_BoardPage.jsp">
                    <p id="left-board">게시판</p>
                </a>
            </article>
            <article id="right-header">
                <div id="searchbar">
                    <input type="text" id="searchtext" placeholder="input text">
                </div>
                <div id="logoicon">
                    <p id="logo">
                        <i class="fa-brands fa-microsoft"></i>
                    </p>
                </div>
                <a id="user-data" href="homework_checkmydata.jsp"></a>
            </article>
        </header>
        <section class="assignment-container">
            <article class="toy-project">
                <div class="project">
                    <p class="project-detail">1주차</p>
                    <p class="project-detail">Signature</p>
                    <p class="project-detail">Get a Computer Quote</p>
                </div>
                <div class="detail-icon">
                    <i class="fa-brands fa-apple"></i>
                </div>
            </article>
            <article class="toy-project">
                <div class="project">
                    <p class="project-detail">2주차</p>
                    <p class="project-detail">HTML&CSS</p>
                    <p class="project-detail">Youtube Clone</p>
                </div>
                <a href="/enterPage/youtube/index.html" target="blank" title="이동">
                    <div class="detail-icon">
                        <i class="fa-brands fa-youtube"></i>
                    </div>
                </a>
            </article>
            <article class="toy-project">
                <div class="project">
                    <p class="project-detail">3주차</p>
                    <p class="project-detail">JAVASCRIPT-1</p>
                    <p class="project-detail">Bulls&Cows</p>
                </div>
                <a href="/enterPage/baseball/index.html" target="blank" title="이동">
                    <div class="detail-icon">
                        <i class="fa-solid fa-baseball"></i>
                    </div>
                </a>
            </article>
            <article class="toy-project">
                <div class="project">
                    <p class="project-detail">4주차</p>
                    <p class="project-detail">JAVASCRIPT-2</p>
                    <p class="project-detail">Drag&Drop</p>
                </div>
                <a href="/enterPage/numsarry/index.html" target="blank" title="이동">
                    <div class="detail-icon">
                        <i class="fa-brands fa-dropbox"></i>
                    </div>
                </a>
            </article>
            <article class="toy-project">
                <div class="project">
                    <p class="project-detail">5주차</p>
                    <p class="project-detail">BACKEND-0</p>
                    <p class="project-detail">SUM</p>
                </div>
                <div class="detail-icon">
                    <i class="fa-brands fa-windows"></i>
                </div>
            </article>
        </section>
        <section class="assignment-container">
            <article class="toy-project">
                <div class="project">
                    <p class="project-detail">personal1</p>
                    <p class="project-detail">JAVASCRIPT-3</p>
                    <p class="project-detail">KoongKoongDda</p>
                </div>
                <a href="/enterPage/kongkong/index.html" target="blank" title="이동">
                    <div class="detail-icon">
                        <i class="fa-brands fa-windows"></i>
                    </div>
                </a>
            </article>
            <article class="toy-project">
                <div class="project">
                    <p class="project-detail">personal2</p>
                    <p class="project-detail">JAVASCRIPT-4</p>
                    <p class="project-detail">canvas</p>
                </div>
                <a href="/enterPage/canvas/index.html" target="blank" title="이동">
                    <div class="detail-icon">
                        <i class="fa-brands fa-windows"></i>
                    </div>
                </a>
            </article>
            <article class="toy-project">
                <div class="project">
                    <p class="project-detail">None</p>
                    <p class="project-detail">None</p>
                    <p class="project-detail">None</p>
                </div>
                <div class="detail-icon">
                    <i class="fa-brands fa-windows"></i>
                </div>
            </article>
            <article class="toy-project">
                <div class="project">
                    <p class="project-detail">None</p>
                    <p class="project-detail">None</p>
                    <p class="project-detail">None</p>
                </div>
                <div class="detail-icon">
                    <i class="fa-brands fa-windows"></i>
                </div>
            </article>
            <article class="toy-project">
                <div class="project">
                    <p class="project-detail">None</p>
                    <p class="project-detail">None</p>
                    <p class="project-detail">None</p>
                </div>
                <div class="detail-icon">
                    <i class="fa-brands fa-windows"></i>
                </div>
            </article>
        </section>
        <section id="introduce-container">
            <header id="introduce-header">introduce</header>
            <article id="introduces">
                <p class="introduce">이름: 신동호</p>
                <p class="introduce">나이: 28세</p>
                <p class="introduce">전공: 기계설계</p>
                <p class="introduce">더이상 할말이 생각안나네요</p>
            </article>
        </section>
    </main>
    <script>
        window.onload = function() {
            if (<%=isLogin%> == true) {
                var userNick = "<%=data%>" // 데이터 베이스에 저장되어 있는 닉네임 문자열 형태로 불러옴
                var String = userNick.replace(/[\[\]']+/g,'') // 2차원 배열 형태인것을 순수한 문자열 형태로 변환
                var aTag = document.getElementById("user-data")
                var tmpDiv = document.createElement("div")
                
                alert("로그인 성공")
                tmpDiv.innerHTML = String
                aTag.appendChild(tmpDiv)
                console.log("로그인 성공")
                console.log(String)
            }
            else {
                alert("아이디 혹은 비밀번호를 확인해주세요")
                console.log("로그인 실패")
                location.href = "homework_login.jsp"
            }
        }

        function showNavMenu() {
            var navMenuTextTag = document.getElementsByClassName("nav-menu-text")
            var ulTag = document.getElementsByClassName("ul")

            function showMenu(i) {
                navMenuTextTag[i].addEventListener("click" , function(){
                ulTag[i].classList.toggle("active")
                })
            }
            for(var i = 0; i < navMenuTextTag.length; i++) {
                showMenu(i)
            }
        }
        showNavMenu()
    </script>
</body>
