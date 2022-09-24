<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>
<%
    request.setCharacterEncoding("utf-8");
    String commentText = request.getParameter("comment-text");
    String boardNum = request.getParameter("currentNum");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework2","dongho","1234");

    // session 에 저장된 id 키값으로 usernum을 불러올것임 누가 댓글을 작성했는지 받아올것이고
    String userNumSql = "SELECT usernum FROM user WHERE id=?";
    PreparedStatement userNumQuery = connect.prepareStatement(userNumSql);
    userNumQuery.setString(1,(String)session.getAttribute("idValue"));
    ResultSet result = userNumQuery.executeQuery();
    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>();
    while(result.next()) {
        ArrayList<String> tmpData = new ArrayList<String>();
        tmpData.add(result.getString(1));
        data.add(tmpData);
    }
    Boolean isData = false;
    if(data.size() > 0) {
        isData = true;
    }
    // usernum 으로 boardNum을 가져올 것임
    String boardNumSql = "SELECT boardNum FROM board WHERE boardNum=?";
    PreparedStatement boardNumQuery = connect.prepareStatement(boardNumSql);
    boardNumQuery.setString(1, boardNum);
    ResultSet boardNumResult = boardNumQuery.executeQuery();
    ArrayList<ArrayList<String>> boardNumData = new ArrayList<ArrayList<String>>();
    while(boardNumResult.next()) {
        ArrayList<String> boardTmpData = new ArrayList<String>();
        boardTmpData.add(boardNumResult.getString(1));
        boardNumData.add(boardTmpData);
    }

// 댓글이 글번호 어디에 저장 되었는지, 그 글에 누가 작성했는지 구분해줘야 하기 때문

    String commentsql = "INSERT INTO comment(usernum,content,boardnum) VALUES(?,?,?)";
    PreparedStatement commentquery = connect.prepareStatement(commentsql);
    commentquery.setString(1,data.get(0).get(0)); 
    commentquery.setString(2,commentText);
    commentquery.setString(3,boardNumData.get(0).get(0));
    commentquery.executeUpdate();  
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>

<script>
    window.onload = function() {
        alert("댓글작성 완료")
        if(<%=isData%> == true){ //유저넘을 가져오는데 성공했을때만 
            var formTag = document.createElement("form")
            var inputArry = []
            for(var i = 0; i < 2; i++){
                var inputTag = document.createElement("input")
                inputArry.push(inputTag)
                inputArry[i].setAttribute("type","hidden")
                formTag.appendChild(inputArry[i])
                //console.log(inputArry[i]) inputArry index 0 번째 1번째에 name value 값 들어가있는지 확인
            }
            inputArry[0].setAttribute("name","currentNum")//게시글번호
            inputArry[0].setAttribute("value","<%=boardNumData.get(0).get(0)%>")
            inputArry[1].setAttribute("name","usernum") 
            inputArry[1].setAttribute("value","<%=data.get(0).get(0)%>") //유저번호
            document.body.appendChild(formTag)
            formTag.action = "homework_ItemPage.jsp"
            formTag.submit()
            console.log("<%=data.get(0).get(0)%>") //105 유저넘
        }
    }
</script>
</body>
