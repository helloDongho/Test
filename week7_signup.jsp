<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%-- 설치된 데이터베이스를 찾아주는 명령어  --%>
<%@ page import="java.sql.DriverManager" %>  <%-- 설치된 데이터베이스를 찾아주는것, 말그대로 드라이버에 대한 매니저이다. --%>
<%-- 데이터베이스를 연결해주는 라이브러리 --%>
<%@ page import="java.sql.Connection" %>   <%-- 데이터베이스를 연결해주는 라이브러리 이다.--%>
<%-- sql을 만들때 도음을 주는 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement" %> <%-- sql을 만들때 도움을 주는 라이브러리 이다. sql문 쓸수 있게 해줌 string 연산 방지 해줌--%>
<%
    // 다른 페이지로부터 오는 값들에 대한 문자 인코딩 설정
    request.setCharacterEncoding("utf-8");

    // 다른 페이지로부터 온 값 저장
    String idValue = request.getParameter("id_value"); // 이전 페이지에서 id pw 값 받아오는데 문자열로 받으니까 String 나머지는 다른페이지로 부터 온 값을 저장
    String pwValue = request.getParameter("pw_value");

    //데이터베이스 탐색
    Class.forName("com.mysql.jdbc.Driver"); // 우리가 사용할 mysql에 대한 코드네임("com.mysql.jdbc.Driver") 이거도 외워야함 Connector 파일을 찾아오는 역할
    
    // Connection는 자료형 connect 변수 자료형을 위쪽에서 임폴트한 connection 자료형으로 사용할것
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydata","eliot","1234");

    //여기까지 데이터베이스를 연결해 준것 


    // 그다음에 sql문 만들어서 데이터베이스에 저장 해줘야 겠지? -sql 문 만들기-
    String sql = "INSERT INTO account(id,pw) VALUES(?, ?)";
    PreparedStatement query = connect.prepareStatement(sql);
     //preparedStatement는 string 연산 을 방지해주는 라이브러리 이다. PreparedStatement를 자료형으로 가지는 query 변수를 만들고 
     // 보통 query로 짓는데 전송되고 있는 sql을 query라고 부르기 때문
     // connect< 데이터베이스 연결 위에 쓴것 connect.prepareStatement(sql); sql을 집어넣어서 라이브러리를 사용가능하게 만들어줌
    query.setString(1, idValue); // 첫번째 물음표에 idValue 값을 넣어줄수 있다. 알아서 작은 따옴표까지 찍어서 넣어줌 setInt는 작은 따옴표 안찍어서 넣어줌
    query.setString(2, pwValue);

    // SQL문 전송 query.executeUpdate(); 하면 db에 데이터들이 잘 들어간다.
    query.executeUpdate();

    //여기까지가 데이터베이스 연결해서 회원 가입 하는 방법
    // update나 delete 는 방법이 다 똑같다
    // 대신에 어떤값을 받아올지 그리고 sql문을 어떻게 작성할지 빼고는 나머지과정이 다 똑같다.
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<%-- <h1>회원가입 완료 페이지</h1>
<div><%=idValue%></div> // 변수를 가져올때는 =까지 해야한다.
<div><%=pwValue%></div> --%>
    <%-- <script>
        alert("<%=idValue%>님의 회원가입 완료")
        location.href="week7_login.jsp"
    </script> 이렇게 하면 좀더 고급스럽게 바꾸어 볼수 있다.--%>

</body>
