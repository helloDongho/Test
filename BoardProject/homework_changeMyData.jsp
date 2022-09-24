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
    String sql = "SELECT * FROM user WHERE id=?";

    PreparedStatement query = connect.prepareStatement(sql);

    query.setString(1,(String)session.getAttribute("idValue"));
    ResultSet result = query.executeQuery();

    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>(); //2차원 리스트 생성
    while(result.next()) {
        ArrayList<String> tmpData = new ArrayList<String>(); // 2차원 리스트에 넣어줄 1차원 리스트 생성
        tmpData.add(result.getString(1));
        tmpData.add(result.getString(2));
        tmpData.add(result.getString(3));
        tmpData.add(result.getString(4));
        tmpData.add(result.getString(5));
        tmpData.add(result.getString(6));
        tmpData.add(result.getString(7));
        tmpData.add(result.getString(8));
        data.add(tmpData);
    }
    Boolean isCheck = false;
    if(data.size() >= 1) {
        isCheck = true;
    }
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="homework/user/user.css" type="text/css">
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
            <p class="nav-text">게시판</p>
            <p class="nav-text">로그인</p>
            <p class="nav-text">News</p>
        </nav>
    </header>
    <main>
        <section>
            <h2>내정보</h2>
            <article id="title">
                <h3>내정보 수정</h3>
            </article>
                <form action="homework_update.jsp">
                    <article id="user-container">
                        <div class="user-data">
                            <p class="text-guide">아이디</p>
                        </div>
                        <div class="user-data">
                            <p class="text-guide">비밀번호</p>
                            <input class="input-data" type="password" placeholder="비밀번호를 입력해주세요" name="pw_value">
                        </div>
                        <div class="user-data">
                            <p class="text-guide">이름</p>
                        </div>
                        <div class="user-data">
                            <p class="text-guide">닉네임</p>
                            <input class="input-data" type="text" placeholder="ex:동쪽의호랑이" name="nickname_value">
                        </div>
                        <div class="user-data">
                            <p class="text-guide">이메일</p>
                        </div>
                        <div class="user-data">
                            <p class="text-guide">전화번호</p>
                            <input class="input-data" type="text" placeholder="숫자만 입력해주세요"name="phone_value" maxlength="11">
                        </div>
                        <div class="user-data">
                            <p class="text-guide">성별</p>
                        </div>
                    </article>
                    <div id="join-container">
                        <button class="join-btn" onclick="changeEvent()">수정하기</button>
                        <button type="button" class="join-btn" onclick="exitEvent()">나가기</button>
                    </div>
                </form>
        </section>
    </main>
    <script>
            window.onload = function() {
            var tmpDiv = document.getElementsByClassName("user-data")
            var pArry = []
            if(<%=isCheck%> == true){
                for(var i = 0; i < tmpDiv.length; i++) {
                    var pTag = document.createElement("p")
                    pArry.push(pTag)
                    tmpDiv[i].appendChild(pArry[i])
                }
                pArry[0].innerHTML = "<%=data.get(0).get(1)%>"
                pArry[2].innerHTML = "<%=data.get(0).get(3)%>"
                pArry[4].innerHTML = "<%=data.get(0).get(5)%>"
                pArry[6].innerHTML = "<%=data.get(0).get(7)%>"
            }
        }
        function exitEvent() {
            history.go(-2)
        }
    </script>
</body>