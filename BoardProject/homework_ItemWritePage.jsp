<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="boardwrite/boardwrite.css" type="text/css">
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
    </header>
    <main>
        <article id="main-header">
            <p id="main-text">게시판</p>
        </article>
        <section>
            <article id="sub-header">
                <p id="sub-text">게시판 글쓰기 양식</p>
            </article>
            <form name = "writefrom">
                <article id="write-container">
                    <button type="button" onclick="writeFormEvent()" id="write-board">글 작성하기</button>
                    <button type="button" onclick="goBack()" id="cancel-board">취소</button>
                </article>
                <table>
                    <tbody>
                        <tr>
                            <td><input type="text" id="board-write-title" name="writetitle" maxlength="100" placeholder="글 제목"></td>
                        </tr>
                        <tr>
                            <td><textarea id="board-write-content" placeholder="글 내용" name="writecontent" maxlength="60000"></textarea></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </section>
    </main>

    <script>

         function writeFormEvent() {
            var writeForm = document.writefrom
            if (writeForm.writetitle.value.length == 0) {
                alert("제목을 입력해주세요")
                return;
            }
            else if (writeForm.writecontent.value.length == 0) {
                alert("내용을 입력해주세요")
                return;
            } 
            writeForm.action = "homework_ItemWriteModule.jsp"
            writeForm.submit()
        }
        function goBack(){
            history.back()
        }
    </script>
</body>