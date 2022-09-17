var navTag = document.getElementById("nav")
var navMenuTextTag = document.getElementsByClassName("nav-menu-text")
var ulTag = document.getElementsByClassName("ul")



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


// function showNavMenu() {
//     function showMenu(i) {
//         navMenuTextTag[i].addEventListener("click" , function(){
//             ulTag[i].classList.toggle("active")
//         })
//     }
//     for(var i = 0; i < navMenuTextTag.length; i++) {
//         showMenu(i)
//     }
// }
// showNavMenu()




// function showNavMenu() {
//     function showMenu(i) {
//         navMenuTextTag[i].addEventListener("click" , menu(i))
//     }
//     function menu(i) {
//         return function() {
//             ulTag[i].classList.toggle("active")
//         }
//     }
//     for(var i = 0; i < navMenuTextTag.length; i++) {
//         showMenu(i)
//     }
// }
// showNavMenu()







// function showNavMenu() {
//     for(let i = 0; i < navMenuTextTag.length; i++) {                 
//         navMenuTextTag[i].addEventListener("click", function(){
//             ulTag[i].classList.toggle("active")
//         })
//     }
// }

// showNavMenu()

//변수 scope가 블록 스코프 즉 블록 단위이므로 fot문이 시작될때마다 새로운 블록스코프가 생성됨 let i = 0 일때 블록 스코프 i = 1 일때 블록스코프 i = 2 일때 블록스코프 
// 그럼 콜백 함수 내에서 ulTag[i]의 i가 값을 참조할때 처음에 콜백함수 내에서 i값을 찾아보고 없으면 for 태그를 참조하게됨 

// ---------------------------------------2번-----------------------------------------------
// function showNavMenu() {                                             
//     for(var i = 0; i < navMenuTextTag.length; i++) {
//         navMenuTextTag[i].addEventListener("click", function(){
//             ulTag[i].classList.toggle("active")
//         })
//     }
// }

// showNavMenu()

// 2번 처럼 하면 실행이 안된다
//  그 이유는 변수 scope가 function scope라서 그렇다 
// showNavMenu를 실행하게 되면 for문을 돌면서 i가 0일때 부터 navMenuTextTag.length만큼 돌면서 클릭 이벤트를 달음 
// 2번 코드만 봤을때 스코프는 showNavMenu 하나이고 그 안에 var i = 0 이 들어가 있다.
// 즉 i = 0 부터 TextTag.length까지 click이벤트를 달아주고 for문이 끝나는순간은 i 값에 끝나는번째 숫자 조건값이 할당이 될것이다.
// 그 다음에 무슨일이 일어나냐면.. navMenuTextTag를 클릭했을때 ulTag[i]의 i가 값을 찾게 되는데 
// var 자체는 function scope니 for문을 빠져나간 뒤 생성된 마지막 var 를 가르키게 된다.
// 그래서 모든 ulTag[i] 값은 9를(navMenuTextTag가 8개니 ) 가르키게 된다.
//  scope가 무엇이냐면.. 딱 정리해서 말하자면 변수의 유효범위, 변수의 생존범위 라고 말한다.
//  var은 scope가 function scope인데 같은 함수 내에서 선언된 변수는 그 함수내 어디서든지 간에 그 변수를 참조할수 있다.
 
//  예를들어

//  function ex() {
//     var a = 1
//     console.log(a)  << 이러면 로그에 a값이 찍히겠지만
//  }
// console.log(a) < 여기선 a값이 찍히지 않는다.  < 변수의 생존 범위가 function scope라서 생존범위를 벗어났기 때문에 그 변수는 죽어버린것. 

// 또다른 예를 들어보자


// var b = 2

// function ex2() {
//     var a = 1
//     console.log(a)
// }
// console.log(b)

// 위와 같은 예로는 콘솔에 a값이 제대로 찍히고 console.log(b)에 정확히 b값이 찍힌다. 

// 변수 b는 global scope 이며 전역 변수로 선언 되었기 때문에 어디서 든지 간에 접근이 가능하다. 
// 하지만 전역변수는 메모리를 계속적으로 차지 하고 있기 때문에 낭비가 될수가 있고 코드 량이 길어지면 길어질수록, 위에 선언했던 변수를 또 선언할경우
// 변수의값이 바뀌어질 가능성이 있기 때문에 전역변수를 되도록이면 선언하지 말자.

// 이번엔 또다른 예 이다.

// var a = 1 
// function ex1() {
//     var b = 2
//     function ex2() {
//         var c =3
//         console.log(b)
//     }
//     ex2()
// }
// ex1()

// 위와 같은 예를 보자 함수 ex1 안에 함수 ex2가 선언되어 있는 상태이다.

// 함수 ex1을 실행시키면 변수 b에 2의 값을 할당하고 ex2()를 실행한다.
// 이때 ex2함수에서  b의 변수 값에 접근할수 있다.
// 왜냐면 ex1함수 내부에서 ex2 함수가 선언되었기 때문이다.

// 스코프 관점에서 말하자면

// 크게 전역으로 봤을때는 전역스코프에는 a = 1 과 함수 ex1() 이 들어가 있을것이고 
// ex1 스코프에는 b = 2 와 ex2() 함수가 들어가 있을것이다.
// 즉 ex2의 상위 스코프는 ex1이니 ex2에서 로그에 b값을 출력하라는 명령을 하게 되면 먼저 ex2() 함수 내부를 찾고 그 상위 스코프인 ex1()을 찾고 거기도 없으면 전역 스코프를(global-scope) 찾는다
// 위와 같은 과정을 말하는것을 스코프 체인이라고 부른다고 한다.

// 마지막으로 예를 하나 더 들어보자 

// function ex1() {
//     var ex = 20
//     function print() {
//         console.log(ex)
//     }
//     return print
// }
// var result = ex1()
// console.log(result)

// 자 함수 ex1을 호출하면 하는 일은 변수 ex를 생성하고 20 값을 할당한뒤에, print 함수를 리턴 한뒤에 함수는 종료된다.
// 그러면 함수가 종료 되었으면 ex = 20 이라는 값 자체는 사라지게 되고 print함수에서 ex라는 변수를 참조할수 없어야 하는게 정상이지 않나 싶다.
// 근데 위 코드를 콘솔에 찍어보면 정상적으로 콘솔에 ex값인 20이 찍힌다. 
// 위와 같은 이상한 현상을 클로저라고 부른다.

// 즉 자신이 선언되었을때의 환경(스코프 즉 ex1내부에 선언되었다는걸)을 기억하고 만일 자신이 선언되었던 환경 외부에서 호출되더라도 선언되었을때의 스코프에 접근할수 있는것




