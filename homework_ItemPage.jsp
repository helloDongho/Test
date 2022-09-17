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
    
    String userNumSql = "SELECT usernum,nickname FROM user WHERE id=?";
    PreparedStatement userNumQuery = connect.prepareStatement(userNumSql);
    userNumQuery.setString(1,(String)session.getAttribute("idValue"));
    ResultSet result = userNumQuery.executeQuery();
    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>();
    while(result.next()) {
        ArrayList<String> tmpData = new ArrayList<String>();
        tmpData.add(result.getString(1));
        tmpData.add(result.getString(2));
        data.add(tmpData);
    }

    String boardNum = request.getParameter("currentNum");  //게시글번호
    String sql = "SELECT boardTable.boardnum, boardTable.title, boardTable.content, userTable.nickname FROM board AS boardTable JOIN user AS userTable ON boardTable.usernum = userTable.usernum WHERE boardnum=?";
    PreparedStatement dataquery = connect.prepareStatement(sql);
    dataquery.setString(1, boardNum); 
    ResultSet itemResult = dataquery.executeQuery();
    
    ArrayList<ArrayList<String>> resultData = new ArrayList<ArrayList<String>>();
    while(itemResult.next()) {
        ArrayList<String> resultTmpData = new ArrayList<String>();
        resultTmpData.add(itemResult.getString(1));
        resultTmpData.add(itemResult.getString(2));
        resultTmpData.add(itemResult.getString(3));
        resultTmpData.add(itemResult.getString(4));
        resultData.add(resultTmpData);
    }
    Boolean isData = false;
    if(resultData.size() > 0) {
        isData = true;
    }

    String commentSql = "SELECT commentTable.commentnum, commentTable.content, commentTable.createtime, userTable.nickname FROM comment AS commentTable JOIN user AS userTable ON commentTable.usernum = userTable.usernum WHERE boardnum=?";
    PreparedStatement commentquery = connect.prepareStatement(commentSql);
    commentquery.setString(1,resultData.get(0).get(0));
    ResultSet commentResult = commentquery.executeQuery();
    ArrayList<ArrayList<String>> commentData = new ArrayList<ArrayList<String>>();
    while(commentResult.next()) {
        ArrayList<String> commentTmpData = new ArrayList<String>();
        commentTmpData.add(commentResult.getString(4));
        commentTmpData.add(commentResult.getString(2));
        commentTmpData.add(commentResult.getString(1));
        commentTmpData.add(commentResult.getString(3));
        commentData.add(commentTmpData);
    }
    Boolean isComment = false;
    if(commentData.size() > 0){
        isComment = true;
    }
%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="bupdate/boardupdate.css?after" type="text/css">
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
            <p class="nav-text" onclick="GoMyDataEvent()">내정보</p>
            <p class="nav-text" onclick="logOutEvent()">로그아웃</p>
        </nav>
    </header>
    <main>
        <article id="main-header">
            <p id="main-text" onclick="goBoardEvent()">게시판</p>
        </article>
        <form name="updateForm">
            <section id="container">
                <article id="sub-header">
                    <p id="writer">작성자:</p>
                    <p id="user-name"><%=resultData.get(0).get(3)%></p> <!-- 게시글 작성자 이름 표시 -->
                </article>
                <article id="write-container">
                <div id="up-del-btn-container">
                    <button id="btn-write" type="button" onclick="upDateBoardEvent()">글 수정하기</button>
                    <button id="btn-delete" type="button" onclick="deleteBoardEvent()">글 삭제하기</button>
                </div>
                </article>
                <article id="board-title"></article>
                <article id="board-main"></article>
            </section>
        </form>
        <article id="comment-container">
            <div id="registered-comment"> <!-- 디스플레이 숨겨놨다가 보여줄거임 js에서 생성할 필요없음. 생성하게 된다면 댓글 작성될때마다 div이 만들어지는 대참사 발생-->
                <ul id="user-data-container"></ul>
            </div>
            <form name="commentForm">
                <div id="write-comment-container">
                    <div id="nickname-container">
                        <div id="user-nickname">
                            <input id="nickname" value="사용자 닉네임 들어가는공간" name="nickVal" disabled>
                        </div>
                    </div>
                    <div id="input-container">
                        <textarea id="input-text" placeholder="댓글을 입력해주세요" maxlength="1000" name="comment-text"></textarea>
                        <div id="reg-btn-container">
                            <button type="button" id="reg-btn" onclick="regClickEvent()">등록</button>
                        </div>
                    </div>
                </div>
            </form>
        </article>
    </main>

    <script>
        function createMain() {
            if(<%=isData%> == true) {
                // 서버 구간 ArrayList 2차원 배열 클라이언트(js)로 가져와서 2차원 배열 다시 만듬
                var list = "<%=resultData%>"
                var String = list.replace(/[\[\]']+/g,'')
                var array = String.split(',')
                var twoArray = [];

                for(var i = 0; i < array.length; i++) {
                    array[i] = array[i].trim();
                }
                while (array.length > 0) {
                    twoArray.push(array.splice(0,4))
                }

                // 태그 관련
                var titleContainer = document.getElementById("board-title")
                var title = document.createElement("p")
                var main = document.createElement("p")
                var mainContainer = document.getElementById("board-main")
                var writeContainerTag = document.getElementById("write-container")
                var hiddenInputTag = document.createElement("input")
                var userName = document.getElementById("nickname")
    
                // 정제된 값 태그 안에 넣는 과정 
                title.setAttribute("id","title-text")
                title.innerHTML = twoArray[0][1]
                titleContainer.appendChild(title)

                main.setAttribute("id","main-text")
                main.innerHTML = twoArray[0][2]
                mainContainer.appendChild(main)

                userName.value = "<%=data.get(0).get(1)%>"

                hiddenInputTag.setAttribute("type","hidden")
                hiddenInputTag.setAttribute("value",twoArray[0][0])
                hiddenInputTag.setAttribute("name","currentNum")
                writeContainerTag.appendChild(hiddenInputTag)
            }
        }
        createMain()

        function createComment() {
            if(<%=isComment%> == true){ //지금 얘가 false 상태 일때 게시글 제목이랑 내용은 불러와야 하는데 왜 안나오지? 얘떄문에 계속 ㅈ같은 오류 발생하는듯 원인파악 ㅅㅂ 못하겠다 왜 자꾸 되다가 안되다가 이지랄 나지?
                // 서버 구간 ArrayList 2차원 배열 클라이언트(js)로 가져와서 2차원 배열 다시 만듬
                var commentList = "<%=commentData%>"
                var commentString = commentList.replace(/[\[\]']+/g,'')
                var commentArray = commentString.split(',')
                var commentwoArray = [];
                var currentUser = "<%=data.get(0).get(1)%>" //현재 접속해 있는 유저 닉네임 

                var ulTag = document.getElementById("user-data-container")
                for(var i = 0; i < commentArray.length; i++) {
                    commentArray[i] = commentArray[i].trim();
                }
                while (commentArray.length > 0) {
                    commentwoArray.push(commentArray.splice(0,4))
                }
                
                for(let j = 0; j < commentwoArray.length; j++) {
                    var liTag = document.createElement("li")
                    var divContainer = document.createElement("div")
                    var commentOption = document.createElement("p")
                    var commentUpdate = document.createElement("p")
                    var commentDelete = document.createElement("p")
                    divContainer.classList.add("user-data")
                    ulTag.appendChild(liTag)
                    liTag.appendChild(divContainer)
                    liTag.classList.add("data-container")
                    commentUpdate.innerHTML = "수정"
                    commentUpdate.classList.add("comment-update")
                    commentDelete.innerHTML = "삭제"
                    commentDelete.classList.add("comment-delete")
                    commentOption.classList.add("option-container")
                    commentOption.appendChild(commentUpdate)
                    commentOption.appendChild(commentDelete)
                    divContainer.appendChild(commentOption)
            
                    for(let k = 0; k < commentwoArray[0].length; k++) {
                        var divTag = document.createElement("div")
                        divTag.innerHTML = commentwoArray[j][k] // 자바스크립트의 2차원 배열에서 0번째 index(row)에 있는값에서 인덱스 0,1,2 값을 divTag에 차례대로
                        divTag.classList.add("data")
                        divContainer.appendChild(divTag)
                    }
                    function CheckUpdateDelete() { //댓글 작성한 사용자와 현재 로그인 되어 있는 사용자 같지 않을시
                        var userDataTag = document.getElementsByClassName("user-data")
                        var userNameTag = userDataTag[j].children[1]
                        var userNameText = userNameTag.textContent
                        console.log(userNameText)
                        if(currentUser != userNameText) {
                            commentUpdate.innerHTML = ""
                            commentDelete.innerHTML = ""
                        }else {
                            return;
                        }
                    }
                    CheckUpdateDelete()
                }
            
            function commentOptionEvent() {
                var currentUserId = '<%=(String)session.getAttribute("idValue")%>'
                var userDataTag = document.getElementsByClassName("user-data")
                var formTag = document.createElement("form")
                var liTag = document.getElementsByClassName("data-container")
                for(var l = 0; l < commentwoArray.length; l++) {
                    userDataTag[l].addEventListener("click",function(e){ 
                        var commentDataContent = e.currentTarget.children[2]
                        var commentDataBNum = e.currentTarget.children[3] // Tag에 자식요소의 3번째것을 가져옴
                        var commentNum = commentDataBNum.textContent // 3번째요소의 번호만을 추출하기 위함
                        if(e.target.classList.contains("comment-update")) {
                            var commentNumInput = document.createElement("input")
                            var commentConInput = document.createElement("input")
                            var btnDiv = document.createElement("div")
                            var btnSubmit = document.createElement("input")
                            var btnCancel = document.createElement("input")

                            btnDiv.setAttribute("id","btn-div")

                            btnSubmit.setAttribute("type","button")
                            btnSubmit.setAttribute("value","확인")
                            btnSubmit.setAttribute("class","submit-btn")

                            btnCancel.setAttribute("type","button")
                            btnCancel.setAttribute("value","취소")
                            btnCancel.setAttribute("class","cancel-btn")

                            commentConInput.setAttribute("type","text") // 보내줄 댓글 데이터 내용
                            commentConInput.setAttribute("name","updateCon")
                            commentConInput.setAttribute("id","update-con")

                            commentNumInput.setAttribute("type","hidden") //보내줄 댓글 번호 내용
                            commentNumInput.setAttribute("value",commentNum)
                            commentNumInput.setAttribute("name","commentnum")

                            formTag.appendChild(commentNumInput)
                            formTag.appendChild(commentConInput)

                            commentDataContent.appendChild(formTag) 
                            commentDataContent.appendChild(btnDiv)
                            
                            btnDiv.appendChild(btnSubmit)
                            btnDiv.appendChild(btnCancel)
                           
                        }
                        else if(e.target.classList.contains("submit-btn")){
                            var loadcomConInput = document.getElementById("update-con")
                            if(loadcomConInput.value != '') {
                                formTag.action = "homework_commentUpdateModule.jsp"
                                formTag.submit()   
                            }else {
                                alert("댓글 내용을 입력해 주세요")
                            }
                        }else if(e.target.classList.contains("cancel-btn")){
                            var loadBtnDiv = document.getElementById("btn-div")
                            var loadcomConInput = document.getElementById("update-con")
                            loadBtnDiv.classList.add("hide")
                            loadcomConInput.classList.add("hide")
                            console.log(loadBtnDiv)
                        }
                        else if(e.target.classList.contains("comment-delete")){    
                            var result = confirm("정말로 삭제 하시겠습니까?")
                            if(result == true){
                                var inputArray = []
                                for(var i = 0; i < 3; i++){
                                    var inputTag = document.createElement("input")
                                    inputTag.setAttribute("type","hidden")
                                    inputArray.push(inputTag)
                                    formTag.appendChild(inputTag)
                                }
                                inputArray[0].setAttribute("name","usernum")
                                inputArray[0].setAttribute("value",<%=data.get(0).get(0)%>) //현재 접속한 유저를 가져오는것..
                                inputArray[1].setAttribute("name","currentnum")
                                inputArray[1].setAttribute("value",<%=boardNum%>)
                                inputArray[2].setAttribute("name","commentnum")
                                inputArray[2].setAttribute("value",commentNum)

                                document.body.appendChild(formTag)
                                formTag.action = "homework_commentDeleteModule.jsp"
                                formTag.submit()
                            }else {
                                return;
                            }
                        }
                    })
                }
            }
            commentOptionEvent()
            }
        }
        createComment()

        function upDateBoardEvent() {
            var formTag = document.updateForm
            formTag.action= "homework_ItemUpdatePage.jsp"
            formTag.submit()
        }

        function deleteBoardEvent() {
            var result = confirm("정말로 삭제 하시겠습니까?")
            if(result == true) {
                var formTag = document.updateForm
                formTag.action = "homework_DeleteItemModule.jsp"
                formTag.submit()
            }else if(result == false) {
                return;
            }
        }

        function goBoardEvent() {
            location.href="homework_BoardPage.jsp"
        }
          
        function regClickEvent() {
            var commentFormTag = document.commentForm
            var textAreaTag = document.getElementById("input-text")
            if(textAreaTag.value == "") {
                alert("댓글을 입력해주세요")
                return;
            }
            else {
                var hiddenInput = document.createElement("input")
                hiddenInput.setAttribute("type","hidden")
                hiddenInput.setAttribute("value",<%=boardNum%>)
                hiddenInput.setAttribute("name","currentNum")
                commentFormTag.appendChild(hiddenInput)
                commentFormTag.action = "homework_commentModule.jsp" 
                commentFormTag.submit()
                
            }
            console.log(commentFormTag)
        }
        
        function CheckUserCorrect() {
            var subHeaderTag = document.getElementById("sub-header")
            var userNickNameTag = subHeaderTag.children[1]
            var userNickName = userNickNameTag.textContent
            var currentUser = "<%=data.get(0).get(1)%>" //현재 접속해 있는 유저 닉네임 
            var writeBtn = document.getElementById("btn-write")
            var deleteBtn = document.getElementById("btn-delete")
            if(currentUser != userNickName){
                writeBtn.classList.add("Disabled")
                deleteBtn.classList.add("Disabled")
            }else{
                return;
            }
        }
        CheckUserCorrect()

        function GoMyDataEvent() {
            location.href = "homework_checkmydata.jsp"
        }

        function logOutEvent() {
            location.href = "homework_logOutModule.jsp"
        }
        //클릭할때 현재 게시글을 보내줘야함 ㅇㅇ 즉 내가 현재 접속하고 있는 게시글의 번호를 보내줘야 함 
        // 그 게시글의 번호에 유저넘버가 누구인 애가 댓글을 작성할것이다 이렇게 알려줘야 컴퓨터가 거기에 넣겠지 ㅇㅇ
        // console.log(<%=boardNum%>)
        // console.log("<%=commentData%>")
    </script>
</body>
        <%-- // function commentOptionEvnet() {
        //     var currentUserId = '<%=(String)session.getAttribute("idValue")%>'
        //     var updateComment = document.getElementById("registered-comment")
        //         updateComment.addEventListener("click",function(e){
        //             var commentDataAll = e.currentTarget.textContent //console.log(commentDataAll) 클릭한거 문자열로 가져오고
        //             var StringTrim = commentDataAll.trim() //console.log(StringTrim) 가져온 문자열 공백 제거 시켜주고
        //             var commentnum = StringTrim.substr(12,3) //console.log(commentNum) 클릭했을때 boardNum만 가져올수있도록
        //             console.log(e.currentTarget)
        //             console.log(commentDataAll)
        //             if(e.target.classList.contains("comment-update")) {
        //                 // window.open("homework_commentUpdate.jsp?commentNum=?" + commentnum,parent,"width=400,height=350")
        //                 // location.href="homework_commentUpdate.jsp?commentNum=?" + commentnum
        //             }
        //             else if(e.target.classList.contains("comment-delete")){
        //                 var formTag = document.createElement("form")
        //                 var inputArray = []
                     
        //                 for(var i = 0; i < 3; i++){
        //                     var inputTag = document.createElement("input")
        //                     inputTag.setAttribute("type","hidden")
        //                     inputArray.push(inputTag)
        //                     formTag.appendChild(inputTag)
        //                 }
        //                 inputArray[0].setAttribute("name","usernum")
        //                 inputArray[0].setAttribute("value",<%=data.get(0).get(0)%>)
        //                 inputArray[1].setAttribute("name","currentnum")
        //                 inputArray[1].setAttribute("value",<%=boardNum%>)
        //                 inputArray[2].setAttribute("name","commentnum")
        //                 inputArray[2].setAttribute("value",<%=commentData.get(0).get(2)%>)

        //                 document.body.appendChild(formTag)
        //                 formTag.action = "homework_commentDeleteModule.jsp"
        //                 formTag.submit()
        //             }
        //         })
        //     }
        // commentOptionEvnet() --%>
