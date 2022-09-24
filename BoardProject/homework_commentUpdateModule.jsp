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
</head>
<%
    request.setCharacterEncoding("utf-8");
    String commentcontent = request.getParameter("updateCon");
    String commentNum = request.getParameter("commentnum");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/homework2","dongho","1234");
    String sql = "UPDATE comment SET content=? WHERE commentnum=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, commentcontent);
    query.setString(2, commentNum);
    query.executeUpdate();

    String boardSql = "SELECT boardnum FROM comment WHERE commentnum=?";
    PreparedStatement boardQuery = connect.prepareStatement(boardSql);
    boardQuery.setString(1,commentNum);
    ResultSet result = boardQuery.executeQuery();
  
    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>();
    while(result.next()) {
        ArrayList<String> tmpData = new ArrayList<String>();
        tmpData.add(result.getString(1));
        data.add(tmpData);
    }

%>
<body>
    <script>
        window.onload = function() {
            alert("댓글 수정완료")
            var formTag = document.createElement("form")
            var currentNumInput = document.createElement("input")
            var commentNumVal = "<%=data.get(0).get(0)%>"
            currentNumInput.setAttribute("type","hidden")
            currentNumInput.setAttribute("value",commentNumVal)
            currentNumInput.setAttribute("name","currentNum")
            formTag.appendChild(currentNumInput)
            document.body.appendChild(formTag)
            formTag.action = "homework_ItemPage.jsp"
            formTag.submit()
        }
    </script>
</body>