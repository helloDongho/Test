<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");
    String writeTitle = request.getParameter("writetitle"); 
    String writeContent = request.getParameter("writecontent");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework2","dongho","1234");

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
        String sql = "INSERT INTO board(title,content,usernum) VALUES(?, ?, ?)";
        PreparedStatement query = connect.prepareStatement(sql);    
        query.setString(1, writeTitle); 
        query.setString(2, writeContent);
        query.setString(3, data.get(0).get(0));
        query.executeUpdate();

        String boardNum = "SELECT boardnum FROM board WHERE usernum=? ORDER BY boardnum DESC LIMIT 1";
        PreparedStatement boardNumQuery = connect.prepareStatement(boardNum);
        boardNumQuery.setString(1, data.get(0).get(0));
        ResultSet boardNumResult = boardNumQuery.executeQuery();
        ArrayList<ArrayList<String>> boardNumData = new ArrayList<ArrayList<String>>();
        while(boardNumResult.next()) {
            ArrayList<String> boardNumTmpData = new ArrayList<String>();
            boardNumTmpData.add(boardNumResult.getString(1));
            boardNumData.add(boardNumTmpData);
        }
    Boolean isBoardNum = false;
    if(boardNumData.size() > 0) {
        isBoardNum = true;       
    }
%>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
</head>
<%-- 머릿속으로 코딩금지, 오류 발생 했으면 문제가 뭔지, 값이 제대로 들어왔는지 문제의 원인이 무엇인지 파악하기위한 노력이 필요함 --%>
<%-- 초기설계를 좀더 논리를 가지고 할 필요가 있다. < 나중에 다른 생각이 나더라도 그 논리가 깨지지 않을정도로  --%>
<%-- 개발을 급하게 하려고 하지말자, 급하게 완성을 하려고 하기보단 1층을 단단하게 쌓으려고 하자 2번째 내용과 이어지는 내용 --%>
<body>

<script>
    window.onload = function() {
        if(<%=isBoardNum%> == true) {
            alert("게시글 작성 성공!")
            var formTag = document.createElement("form")
            var inputTag = document.createElement("input")
            inputTag.setAttribute("type","hidden")
            inputTag.setAttribute("name","currentNum") //게시글번호
            inputTag.setAttribute("value","<%=boardNumData.get(0).get(0)%>")
            formTag.appendChild(inputTag)
            document.body.appendChild(formTag)
            formTag.action = "homework_ItemPage.jsp"
            formTag.submit()
            console.log(formTag)

            //< Form submission canceled because the form is not connected 
            // HTML5 표준에선 Browsing contexts(document)에 form 이 연결되어 있지 않으면, form submit을 중단하도록 규정
            // 즉 form 태그를 생성하기만 햇지 html에서는 form 태그의 존재 자체를 모르니 form의 내용 자체를 전달하지 못하는것이다.
            // js배울때 마찬가지로 태그를 동적으로 생성했으면 당연히 html이 알수 있게 document에 연결지어 줘야 한다는 맥락과 동일하게 생각되어진다.
            // 다만.. body에 appendChild 하는 이유는.. 부모 태그 body 밖에 없어서.. 입력된 데이터 값을 정제 하고 정제된 값을 데이터를 띄워주는 페이지로 보내는 것인데 
            // 화면상에 보여주는 태그를 따로 만들 필요가 없으니 만들지 않았기에 body에 삽입 
            // console.log(<%=isBoardNum%>) boardNumData<< 배열에 record가 제대로 들어 가 있는지 확인 하기 위해 
            //console.log(inputTag) 값 제대로 들어갔는지 확인! << 값 제대로 들어갔음 마지막 인덱스 값< 사용자가 게시글 등록했을때의 최신의 값
           
        }
    }
</script>
</body>
