<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework2","dongho","1234");
    
    String boardSql = "SELECT boardTable.boardnum, boardTable.title, boardTable.regdate, boardTable.views,userTable.nickname FROM board AS boardTable JOIN user AS userTable ON boardTable.usernum = userTable.usernum"; 
    PreparedStatement boardQuery = connect.prepareStatement(boardSql);

    ResultSet boardresult = boardQuery.executeQuery();
    ArrayList<ArrayList<String>> boardData = new ArrayList<ArrayList<String>>();
    while(boardresult.next()) {
        ArrayList<String> boardTmpData = new ArrayList<String>();
        boardTmpData.add(boardresult.getString(1));  //첫번째 열에 있는 결과를 문자열로 받아와서 TmpData안에 추가 할거고
        boardTmpData.add(boardresult.getString(2));
        boardTmpData.add(boardresult.getString(3));
        boardTmpData.add(boardresult.getString(4));
        boardTmpData.add(boardresult.getString(5));
        boardData.add(boardTmpData);
    }

    Boolean isLoad = false;
    if (boardData.size() > 0) {
        isLoad = true;
    }

    String userSql = "SELECT id,pw FROM user WHERE id=?";
    PreparedStatement userQuery = connect.prepareStatement(userSql);
    userQuery.setString(1,(String)session.getAttribute("idValue"));

    ResultSet userresult = userQuery.executeQuery();
    ArrayList<ArrayList<String>> userData = new ArrayList<ArrayList<String>>();
    while(userresult.next()) {
        ArrayList<String> userTmpData = new ArrayList<String>();
        userTmpData.add(userresult.getString(1));
        userTmpData.add(userresult.getString(2));
        userData.add(userTmpData);
    }
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="board/board.css?after" type="text/css">
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
            <p class="nav-text" onclick ="GoMyDataEvent()">내정보</p>
            <p class="nav-text" onclick ="logOutEvent()">로그아웃</p>
        </nav>
    </header>
    <main>
        <article id="main-header">
            <p id="main-text" onclick="goToMain()">메인</p>
        </article>
        <section>
            <article id="sub-header">
                <p id="sub-text">자유게시판</p>
            </article>
            <article id="write-container">
                <a id="write-board" href="homework_ItemWritePage.jsp">글 작성하기</a>
            </article>
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성일</th>
                        <th>조회수</th>
                        <th>작성자</tr>
                    </tr>
                </thead>
                <tbody id="data-container"></tbody>
            </table>
        </section>
    </main>

    <script>
        window.onload = function() {
            var BodyTag = document.getElementById("data-container")
            var list = "<%=boardData%>"
            var String = list.replace(/[\[\]']+/g,'')
            var array = String.split(',')
            var twoArray = [];

            for(var i = 0; i < array.length; i++) {
                array[i] = array[i].trim();
            }
            while (array.length > 0) {
                twoArray.push(array.splice(0,5))
            }
    
            if(<%=isLoad%> == true) { //Load 가 true 이면 데이터 베이스 테이블 안에 있는 내용들을 브라우저에 뿌려줌 
                for(var j =0; j < twoArray.length; j++) {
                    var tmpTrTag = document.createElement("tr") 
                    tmpTrTag.classList.add("trTag")
                    BodyTag.append(tmpTrTag)    
                    for(var k = 0; k < twoArray[0].length; k++) {
                        var tmpTdTag = document.createElement("td")
                        tmpTdTag.innerHTML = twoArray[j][k]
                        tmpTdTag.classList.add("tdTag")
                        tmpTrTag.append(tmpTdTag)
               
                    }
                }
            } 
            function enterItems() { // Board에서 원하는 게시글을 클릭하면 그 게시글의 내용을 볼수있도록
                var readTrTag = document.getElementsByClassName("trTag")
                for(var l = 0; l < twoArray.length; l++) {
                    readTrTag[l].addEventListener("click",function(e){   
                        alert("성공!")
                        var boardNumTag = e.currentTarget.children[0] // 이벤트를 추가시킨 객체의 1번째 태그를 불러오도록 readTrTag의 0번째 자식태그
                        var boardNumText = boardNumTag.textContent // 0번째 자식태그의 text를 추출 
                        var formTag = document.createElement("form")
                        var inputTag = document.createElement("input")
                        
                        inputTag.setAttribute("type","hidden")
                        inputTag.setAttribute("name","currentNum")
                        inputTag.setAttribute("value",boardNumText)
                        document.body.appendChild(formTag)
                        formTag.appendChild(inputTag)
                        formTag.action = "homework_ItemPage.jsp"
                        formTag.submit()
                        // console.log(boardNumTag)
                        // console.log(boardNumText)
                    })
                }
            }
            enterItems()
        }         

        function goToMain() {
            var idValue = "<%=userData.get(0).get(0)%>" // 현재 접속한 유저를 받아옴 
            var pwValue = "<%=userData.get(0).get(1)%>" // 현재 접속한 유저의 비밀번호를 받아옴 
            var idInput = document.createElement("input")
            var pwInput = document.createElement("input")
            var formTag = document.createElement("form")

            idInput.setAttribute("type","hidden")
            idInput.setAttribute("name","id_value")
            idInput.setAttribute("value",idValue)

            pwInput.setAttribute("type","hidden")
            pwInput.setAttribute("name","pw_value")
            pwInput.setAttribute("value",pwValue)

            document.body.appendChild(formTag)
            formTag.appendChild(idInput)
            formTag.appendChild(pwInput)
            formTag.action = "homework_main.jsp"
            formTag.submit()
        }
        function GoMyDataEvent() {
            location.href = "homework_checkmydata.jsp"
        }
        function logOutEvent() {
            location.href = "homework_logOutModule.jsp"
        }
    </script>
<body>

