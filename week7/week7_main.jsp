<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%-- 설치된 데이터베이스를 찾아주는 명령어  --%>
<%@ page import="java.sql.DriverManager" %>  
<%-- 데이터베이스를 연결해주는 라이브러리 --%>
<%@ page import="java.sql.Connection" %>  
<%-- sql을 만들때 도음을 주는 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>
<%
    // 다른 페이지로부터 오는 값들에 대한 문자 인코딩 설정
    request.setCharacterEncoding("utf-8");

    // 다른 페이지로부터 온 값 저장
    String idValue = request.getParameter("id_value");     
    String pwValue = request.getParameter("pw_value"); 

    //데이터베이스 탐색
    Class.forName("com.mysql.jdbc.Driver"); // Connector 파일을 찾아오는 역할
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydata","eliot","1234");

    // SQL문 만들기
    String sql = "SELECT * FROM account WHERE id=? AND pw=?"; //데이터베이스에 있는 조건
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);
    query.setString(2, pwValue);

    // SQL문 전송
    //query.executeUpdate(); 여기서 달라짐 값을 받아와야 한다 회원가입 이후니까 데이터베이스에서 값을 받아와야함
    ResultSet result = query.executeQuery(); // INSERT는 그냥 데이터베이스에 저장하는거고 SELECT 는 READ 해온다 데이터베이스에 대한 값을
    // 그러니 변수에 저장해야됨 result 라는 변수에
    // 근데 이거도 자료형이 있고 그 자료형을 사용하려면 라이브러리를(ResultSet) 데이터 베이스에서 값을 불러왔을때 값을 저장해주는 데이터베이스 전용 자료형을 추가해줘야함
  
    
    //값 정제
    // 자바에서 데이터베이스는 2차원 데이터 베이스를 제공안함 그렇기 때문에 값 정제를 해줌

    //ArrayList<ArrayList<String>> 이건 자료형 
    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>(); //2차원 리스트 생성 라이브러리에 저장해줌 new ArrayList<ArrayList<String>>(); 적은것이 리스트 선언하는 방법
    while(result.next()) {
        ArrayList<String> tmpData = new ArrayList<String>(); // 2차원 리스트에 넣어줄 1차원 리스트 생성
        tmpData.add(result.getString(1));
        tmpData.add(result.getString(2));
        data.add(tmpData);
        // result.next() 하면 커서가 한줄 내려와서 row을 읽을 준비가 된다
        // 그러니 맨위에는 column 이고 아래는 row니 1번째 로우부터 읽어라 하는것
        //result.getString(1);  첫 번째 row의 id값을 가져온다 라는 의미
        //result.getString(2);  첫 번째 row의 pw값을 가져온다 라는 의미 반복문이 한번 돌았으면 두번째 row id값 pw값이 저장이 될것
        // 위의과정이 반복문을 한번 돌때마다 첫번째 로우값에 id ,pw값이 저장된다. 반복문이 다돌면 next로 인해 아랫칸으로 이동해서 저장이되는게 반복
    }

    Boolean isLogin = false;
    if (data.size() >= 1) {
        isLogin = true;
    }
 
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<%-- <h1>회원가입 완료 페이지</h1>
<div><%=idValue%></div>
<div><%=pwValue%></div> --%>
    <%-- <script>
        alert("<%=idValue%>님의 회원가입 완료")
        location.href="week7_login.jsp"
    </script> 이렇게 하면 좀더 고급스럽게 바꾸어 볼수 있다.--%>

    <%-- <p>아이디 : <%=data.get(0).get(0)%></p> .get(0).get(0) << [0] [0] 같은것
    <p>비밀번호 : <%=data.get(1).get(1)%></p> 이것도 사실 필요가없다--%>

    <script>
        window.onload = function() {
            console.log("실행됨?")
            if (<%=isLogin%> == true) {
                alert("로그인 성공")
            } else {
                alert("님 누구임")
                location.href="week7_login.jsp"
            }
        }
    </script>
</body>
