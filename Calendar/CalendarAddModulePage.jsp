<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily","dongho","1234");

    
    String userSql = "SELECT usernum,userid,userpw,userposition FROM user WHERE userid=?";
    PreparedStatement userQuery = connect.prepareStatement(userSql);
    userQuery.setString(1,(String)session.getAttribute("idValue")); // session 에서 usernum 을 가져옴 맨위 상단에 


// session 에서 가져왔기에 데이터베이스에서 꺼내서 값을 정재할 필요성 x
    ResultSet result = userQuery.executeQuery();
    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>(); 
    while(result.next()) {
        ArrayList<String> tmpData = new ArrayList<String>(); 
        tmpData.add(result.getString(1));
        tmpData.add(result.getString(2));
        tmpData.add(result.getString(3));
        tmpData.add(result.getString(4));
        data.add(tmpData);
    }

    Boolean isLogin = false;
    if (data.size() >= 1) {
        isLogin = true;
    }
    String calendarDate = request.getParameter("calendar_date");
    String calendarTime = request.getParameter("calendar_time");
    String calendarContent = request.getParameter("calendar_content");

    String sql = "INSERT INTO calendar(calendardate,calendartime,claendarcomment,usernum) VALUES(?, ? ,? ,?)";
    
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, calendarDate);
    query.setString(2, calendarTime);
    query.setString(3, calendarContent);
    query.setString(4, data.get(0).get(0));
    query.executeUpdate();

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
            if(<%=isLogin%> == true) {
                alert("일정 추가 완료")
                var formTag = document.createElement("form")
                var userNum = "<%=data.get(0).get(0)%>"
                var userId = "<%=data.get(0).get(1)%>"
                var userPw = "<%=data.get(0).get(2)%>"
                var userPosition = "<%=data.get(0).get(3)%>"
                var userNumTag = document.createElement("input")
                var userIdTag = document.createElement("input")
                var userPwTag = document.createElement("input")
                var tmpInputArray = []

                userNumTag.setAttribute("type","hidden")
                userNumTag.setAttribute("name","user_num")
                userNumTag.setAttribute("value",userNum)

                userIdTag.setAttribute("type","hidden")
                userIdTag.setAttribute("name","id_value")
                userIdTag.setAttribute("value",userId)

                userPwTag.setAttribute("type","hidden")
                userPwTag.setAttribute("name","pw_value")
                userPwTag.setAttribute("value",userPw)


                document.body.appendChild(formTag)
                formTag.append(userNumTag,userIdTag,userPwTag)

                if(userPosition == "member") {
                    formTag.action = "CalendarPage.jsp"
                    formTag.submit()
                }
                else if(userPosition == "leader") {
                    formTag.action = "CalendarLeaderPage.jsp"
                    formTag.submit()
                }
                else if(userPosition == "admin") {

                    for(var j = 0; j < 3; j++) {
                        var tmpInput = document.createElement("input")
                        tmpInput.setAttribute("type","hidden")
                        tmpInputArray.push(tmpInput)
                        formTag.appendChild(tmpInput)
                    }

                    formTag.action = "CalendarAdminPage.jsp"
                    formTag.submit()
                    // ----------관리자 일 경우 각 부서 조회를 위해서 로그인할때 부서 정보를 같이 보내기---------------
                    tmpInputArray[0].setAttribute("name","develope_value")
                    tmpInputArray[0].setAttribute("value","develope") 
                    tmpInputArray[1].setAttribute("name","education_value")
                    tmpInputArray[1].setAttribute("value","education")
                    tmpInputArray[2].setAttribute("name","management_value")
                    tmpInputArray[2].setAttribute("value","management")
                    formTag.action = "CalendarAdminPage.jsp"
                    formTag.submit()
                }
            }
        }
    </script>
</body>
