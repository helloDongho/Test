<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>  
<%@ page import="java.sql.Connection" %>  
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.ArrayList" %>
<%
    request.setCharacterEncoding("utf-8");

    String idValue = request.getParameter("id_value"); // loginPage에서 받아옴
    String pwValue = request.getParameter("pw_value"); // loginPage에서 받아옴 


    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/daily","dongho","1234");


    String sql = "SELECT userposition,usernum FROM user WHERE userid=? AND userpw=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);
    query.setString(2, pwValue);

    ResultSet result = query.executeQuery();
    ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>(); 
    while(result.next()) {
        ArrayList<String> tmpData = new ArrayList<String>(); 
        tmpData.add(result.getString(1));
        tmpData.add(result.getString(2));
        data.add(tmpData);
    }

    Boolean isLogin = false;
    if (data.size() > 0) {
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
    <script>
        window.onload = function() {
            if(<%=isLogin%> == true){
                var jspList = "<%=data%>"
                var String = jspList.replace(/[\[\]']+/g,'')
                var array = String.split(',')
                var twoArray = [];
                
                for(var i = 0; i < array.length; i++) {
                array[i] = array[i].trim();
                
                }
                while (array.length > 0) {
                    twoArray.push(array.splice(0,2))
                }

            function checkPosition(){
                var userPosition = twoArray[0][0]
                var usernum = twoArray[0][1]
                var formTag = document.createElement("form")
                var inputArray = []
                var idValue = "<%=idValue%>"
                var pwValue = "<%=pwValue%>"
                var tmpInputArray = []

                for(var i = 0; i < 3; i++){
                    var inputTag = document.createElement("input")
                    inputTag.setAttribute("type","hidden")
                    inputArray.push(inputTag)
                    formTag.appendChild(inputTag)
                }

                inputArray[0].setAttribute("name","id_value")
                inputArray[0].setAttribute("value",idValue)
                inputArray[1].setAttribute("name","pw_value")
                inputArray[1].setAttribute("value",pwValue)
                inputArray[2].setAttribute("name","user_num")
                inputArray[2].setAttribute("value",usernum)
                
                document.body.appendChild(formTag)

                if(userPosition == "member"){
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
            checkPosition()
        }
        else if(<%=isLogin%> == false) {
            alert("로그인 실패")
            location.href = "loginPage.jsp"
        }

    }  
    </script>
</body>