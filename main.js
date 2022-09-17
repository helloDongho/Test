var navTag = document.getElementById("nav")
var navMenuTextTag = document.getElementsByClassName("nav-menu-text")
var ulTag = document.getElementsByClassName("ul")
var JsVar = '<%=isLogin%>';
window.onload = function() {
    if (JsVar == true) {
        alert("로그인 성공")
        console.log("로그인 성공")
    }else {
        alert("로그인 실패")
        console.log(JsVar)
        location.href = "homework_login.jsp"
    }
}



function showNavMenu() {
    function menu(i) {
        navMenuTextTag[i].addEventListener("click" , showMenu(i))
    }
    function showMenu(i) {
        return function() {
            if(ulTag[i].classList.contains("active")) {
                ulTag[i].classList.remove("active")
            }
            else {
                ulTag[i].classList.add("active")
            }
        }
    }
    for(var i = 0; i < navMenuTextTag.length; i++) {
        menu(i)
    }
}
showNavMenu()

