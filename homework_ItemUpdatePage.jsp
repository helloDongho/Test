<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="updatewrite/boardwrite.css" type="text/css">
    <script src="https://kit.fontawesome.com/bec76863d9.js" crossorigin="anonymous"></script>
</head>
<%
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework2","dongho","1234");
    String boardNum = request.getParameter("currentNum");

    String boardSql = "SELECT title,content FROM board WHERE boardnum=?";
    PreparedStatement boardDataQuery = connect.prepareStatement(boardSql);
    boardDataQuery.setString(1, boardNum);
    ResultSet boardResult = boardDataQuery.executeQuery();

    ArrayList<ArrayList<String>> boardData = new ArrayList<ArrayList<String>>();
    while(boardResult.next()) {
        ArrayList<String> boardTmpData = new ArrayList<String>();
        boardTmpData.add(boardResult.getString(1));
        boardTmpData.add(boardResult.getString(2));
        boardData.add(boardTmpData);
    }
    Boolean isUpDate = false;
    if(boardData.size() > 0) {
        isUpDate = true;
    }
%>
<body>
    <header>
        <article id="logo-container">
            <span id="logo">
                <i class="fa-brands fa-microsoft"></i>
            </span>
            <p id="logo-text">MY community</p>
        </article>
        <nav id="right-side-nav">
            <p class="nav-text">내정보</p>
            <p class="nav-text">News</p>
        </nav>
    </header>
    <main>
        <article id="main-header">
            <p id="main-text">게시판</p>
        </article>
        <form name="updatewrite">
            <section>
                <article id="sub-header">
                    <p id="sub-text">내가 쓴 게시글 수정하기</p>
                </article>
                <article id="write-container">
                    <button type="button" onclick="submitEvent()" class="write-board" href="homework_write.jsp">확인</button>
                    <button type="button" onclick="cancleEvent()" class="write-board" href="homework_write.jsp">취소</button>
                </article>
                <table>
                    <tbody>
                        <tr>
                            <td><input type="text" id="board-write-title" name="writetitle" maxlength="100" placeholder="여기에는 사용자가 작성한 내용이 들어가야 할것" value="<%=boardData.get(0).get(0)%>"></td>
                        </tr>
                        <tr>
                            <td><textarea id="board-write-content" placeholder="여기에도 마찬가지임" name="writeboard" maxlength="60000"><%=boardData.get(0).get(1)%></textarea></td>
                        </tr>
                    </tbody>
                </table>
            </section>
            <input name="currentNum" type="hidden" value="<%=boardNum%>">
        </form>
        <script>
            function submitEvent() {
                var updateWriteForm = document.updatewrite
                if (updateWriteForm.writetitle.value.length == 0) {
                    alert("제목을 다시 작성해주세요")
                    return;
                }
                else if (updateWriteForm.writeboard.value.length == 0) {
                    alert("본문을 다시 작성해주세요")
                    return;
                }
                updateWriteForm.action = "homework_UpdateModule.jsp"
                updateWriteForm.submit()
            }
            function cancleEvent() {
                var formTag = document.updatewrite
                formTag.action = "homework_ItemPage.jsp"
                formTag.submit()
            }
            console.log(<%=boardNum%>)
            console.log("<%=boardData.get(0).get(1)%>")
        </script>