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
    

    String CalendarDate = request.getParameter("calendar_date");
    String CalendarTime = request.getParameter("calendar_time");
    String CalendarContent = request.getParameter("calendar_content");
    String CalendarNum = request.getParameter("content_num");


    String sql = "UPDATE calendar SET calendardate=?, calendartime=?, claendarcomment=? WHERE calendarnum=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, CalendarDate);
    query.setString(2, CalendarTime);
    query.setString(3, CalendarContent);
    query.setString(4, CalendarNum);
    query.executeUpdate();


    String userDataSql = "SELECT userid,userpw,userposition,usernum FROM user WHERE userid=?";
    PreparedStatement userDataQuery = connect.prepareStatement(userDataSql);
    userDataQuery.setString(1,(String)session.getAttribute("idValue"));

    ResultSet userresult = userDataQuery.executeQuery();
    ArrayList<ArrayList<String>> userData = new ArrayList<ArrayList<String>>();
    while(userresult.next()) {
        ArrayList<String> userTmpData = new ArrayList<String>();
        userTmpData.add(userresult.getString(1));
        userTmpData.add(userresult.getString(2));
        userTmpData.add(userresult.getString(3));
        userTmpData.add(userresult.getString(4));
        userData.add(userTmpData);
    }
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
        alert("수정 성공 하였습니다.")
        var formTag = document.createElement("form")
  
        var idInput = document.createElement("input")
        var pwInput = document.createElement("input")
        var numInput = document.createElement("input")
        var idData = "<%=userData.get(0).get(0)%>"
        var pwData = "<%=userData.get(0).get(1)%>"
        var positionData = "<%=userData.get(0).get(2)%>"
        var userNum = "<%=userData.get(0).get(3)%>"
        var tmpInputArray = []

        idInput.setAttribute("type","hidden")
        idInput.setAttribute("value",idData)
        idInput.setAttribute("name","id_value")
        
        pwInput.setAttribute("type","hidden")
        pwInput.setAttribute("value",pwData)
        pwInput.setAttribute("name","pw_value")

        numInput.setAttribute("type","hidden")
        numInput.setAttribute("value",userNum)
        numInput.setAttribute("name","user_num")
    
        document.body.appendChild(formTag)
        formTag.append(idInput,pwInput,numInput)

        if(positionData == "member") {
            formTag.action = "CalendarPage.jsp"
            formTag.submit()
        }
        else if(positionData == "leader") {
            formTag.action = "CalendarLeaderPage.jsp"
            formTag.submit()
        }
        else if(positionData == "admin") {
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
</script>
</body>    



