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
    String commentNum = request.getParameter("commentnum");

%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form name="updateFrom">
        <article>   
                <p>댓글 수정하기</p>
                <input id="input-content" type="text" name ="commentContent" >
                <button onclick="clickEvent()">확인</button>
                <button onclick="cancelEvent()">취소</button>
        <article>
    </form>

    <script>
        function clickEvent() {
            var contentTag = document.getElementById("input-content")
            if(contentTag.value != "" ) {
                var formTag = document.updateFrom
                var commentNumInput = document.createElement("input")
                commentNumInput.setAttribute("type","hidden")
                commentNumInput.setAttribute("name","commentnum")
                commentNumInput.setAttribute("value","<%=commentNum%>")
                formTag.appendChild(commentNumInput)
                formTag.action = "homework_commentUpdateModule.jsp"
                formTag.submit()
            }else{
                alert("수정할 댓글을 입력해주세요.")
                return;
            }
        }
        function cancelEvent() {
            location.href= "homework_ItemPage.jsp"
        }
    </script>
</body>
