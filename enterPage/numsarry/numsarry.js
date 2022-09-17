var paespaceTag = document.getElementsByClassName("pae-space")
var myPaeTag = document.getElementById("myPae")
var yourPaeTag = document.getElementById("yourpae")
var paeContainerTag = document.getElementById("pae-container")
var resultContainderTag = document.getElementById("result-container")
var tenMillisTag = document.getElementById("tenMillis")
var secondsTag = document.getElementById("seconds")
var minutesTag = document.getElementById("minutes")
var currentPae = null;
var currentTarget = null;
var tmpDivArry = []
var tmpDiv2Arry = []
var rankArry = []
var min = 0
var sec = 0
var msec = 0
var timer = 0
var correct = 0
var register = 0



function topPae() {
    for(var i = 0; i < 12; i++) {
        var tmpDiv = document.createElement("div")
        tmpDiv.className = "tmpPae"
        tmpDivArry.push(tmpDiv)
        tmpDiv.setAttribute("draggable","true")
        myPaeTag.appendChild(tmpDiv)

}
}
topPae()

function bottomPae() {
    for(var i = 0; i < 12; i++) {
        var tmpDiv2 = document.createElement("div")
        tmpDiv2.className= "tmpPae"
        tmpDiv2.setAttribute("draggable","true")
        yourPaeTag.appendChild(tmpDiv2)
        tmpDiv2Arry.push(tmpDiv2) // 패 하나의 index넘버에 접근하기 위해서 배열에넣고
        }
        // console.log(tmpDiv2Arry)
    }
bottomPae()

function startEvent() {
    var arry = []
    var numbers = [0,1,2,3,4,5,6,7,8,9,10,11]
    for(var i = 0; i < 12; i++) {
        var randomNum = Math.floor(Math.random() * numbers.length)
        arry.push(numbers[randomNum])
        numbers.splice(randomNum,1)
        var tmpDiv = document.createElement("div")
        tmpDivArry[i].style.backgroundImage = "url(JPG/pae" + arry[i] +".jpg)"
    }
    timerStart()
    // console.log(arry)//[숫자가 안에 들어가있음]
}

function submitEvent() {
    var wrongCount = 0
    for (var i = 0; i < 12; i++) {
        var originalImageNumber = 'url("JPG/pae' + i + '.jpg")'
        if (originalImageNumber != tmpDiv2Arry[i].style.backgroundImage) {
            wrongCount++
        }
        // console.log(tmpDiv2Arry[i].style.backgroundImage)
        // console.log(originalImageNumber)
    }
    
    if (wrongCount == 0) {
        alert("correct")
        timerStop()
        correct = 1
    }
    else {
        alert("당신은 틀렸습니다.! \n" + "틀린갯수:" + wrongCount)
    }
}

function resetEvent() {
    for(var i = 0; i < 12; i++) {
        tmpDiv2Arry[i].style.backgroundImage = '' //버튼 누르는 순간 옮겨놨던 결과 패 초기화
        tmpDivArry[i].style.backgroundImage = '' // 시작 패 초기화
    }
    tenMillisTag.innerHTML = "00"
    secondsTag.innerHTML = "00"
    minutes.innerHTML = "00"
    min = 0
    sec = 0
    msec = 0
    timerStop()
    register = 0
    correct = 0
}

function RankRegister() {
    var rankingUserTag = document.getElementById("ranking-user")
    var rankSystemTag = document.getElementById("rank-System")
    var newRankNum = document.createElement("span")
    var newName = document.createElement("span")
    var newTime = document.createElement("span")

    newRankNum.className = "newRankNumClass"
    newName.className = "newNameClass"
    newTime.className = "newTimeClass"


    if(correct == 0) { // 게임 클리어도 안했는데 점수 등록 하면 안됨
        alert("game is not clear")
        return;
    }
    if(register) { // 한번의 게임 점수로 인하여 중복 등록 방지 하기 위해서 
        alert("You have been registered")
        return;
    }
    register = 1;

    if(newData) {
        rankingUserTag.remove()
        var rankingUserTag = document.createElement("article")
        rankingUserTag.id = "ranking-user"
        rankSystemTag.appendChild("rankingUserTag")
    }
  
    var newData = document.createElement("div")
    newData.className = "newDataClass"
    var userName = document.getElementById("Name-input").value
    var clearTimer = min + sec + (msec /100)
    rankArry.push([userName, clearTimer])
    
    if(rankArry.length > 1) {   //정렬할 arry 안의 데이터가 2개 미만인경우에 오류가 남 < 2개 미만 인 경우에는 정렬하는게 의미가 없네
        rankArry.sort(function (a,b) {
            return a[1] - b[1]
        })
    }

    for(var i = 0; i < rankArry.length; i++) {
        if (i >= 5) {
            break;
        }
        newRankNum.innerHTML = i + 1 + "등"
        newName.innerHTML = rankArry[i][0] 
        newTime.innerHTML = rankArry[i][1]
        newData.append(newRankNum , newName , newTime)
        rankingUserTag.appendChild(newData)
        }
}

function dragStartHandler(event) {
    currentTarget = event.target
   
    currentPae = event.target.style.backgroundImage

    // console.log(currentTarget)
}

function dragOverHandler(event) {
    event.preventDefault(event)
}

function dropHandler(event) {
    if (event.target.className == "tmpPae") {
    currentTarget.style.backgroundImage = event.target.style.backgroundImage
    event.target.style.backgroundImage = currentPae
}   else {
    alert("put it straight")
}
    // console.log(currentTarget) 
}


function addEventListener() {
    paeContainerTag.addEventListener("dragstart" , dragStartHandler)
    paeContainerTag.addEventListener("dragover" , dragOverHandler)
    paeContainerTag.addEventListener("drop" , dropHandler)
}
addEventListener()


function timerStart() {
    timer = setInterval(function() {
        msec++
        tenMillisTag.innerHTML = msec
        if(msec > 99) {
            sec++
            secondsTag.innerHTML = sec
            msec = 0
            tenMillisTag.innerHTML = "00"
        }
        else if(sec > 59) {
            min++
            minutes.innerHTML = min
            sec = 0
            secondsTag.innerHTML = "00"
        }
    },10)
    // console.log(timer)
  }

function timerStop() {
    clearInterval(timer)

}


// var paespaceTag = document.getElementsByClassName("pae-space")
// var myPaeTag = document.getElementById("myPae")
// var yourPaeTag = document.getElementById("yourpae")
// var paeContainerTag = document.getElementById("pae-container")
// var currentPae = null;
// var currentTarget = null;
// var arry = []
// var numbers = [0,1,2,3,4,5,6,7,8,9,10,11]
// var tmpDiv// = document.createElement("div") //  function topPae for 문에 var안써서 전역변수에 값할당됨

// function topPae() {
//     for(var i = 0; i < 12; i++) {  
//         tmpDiv = document.createElement("div")
//         tmpDiv.className = "tmpPae"
//         tmpDiv.setAttribute("draggable","true")
//         myPaeTag.appendChild(tmpDiv)
//      }
//      console.log(myPaeTag)
// }    
// topPae()
// console.log(tmpDiv)

// 이렇게 코드를짤건 아니지만..

// 코드를 만약에 이렇게 짯다고 가정하고  보자면

// 일단 topPae for 문안에 tmpDiv는 var을 붙인게 아니니.. 전역변수의 값이 선언한 document.createElement("div") 로 바뀌고 즉 전역변수 값이 바뀜
// for 문안에서 일단 생성하라 했으니 본체 12개 생성되겠지
// 
// for문이 총 12번 다 돌고나서 console.log(tmpDiv) 해봤더니 맨 마지막 div 태그만 찍히는거 보면..
// for문 한번돌고 났을때 첫번째 만들어진건 myPaeTag에 넣어진거고 2번째 for문돌때 첫번째 만들어진 tmpDiv 값 자체가 사라지고 새로운 tmpDiv가 생성
// 되는거라고 봐야되나? 총 12번 돌면 마지막으로 11번째 tmpDiv값은 지워지고 12번째의 tmpDiv만 남는거지 << 이게 동기 처리 때매 그런건가
// 내가 생각 하는게 맞다면 어제 이미지 한장이 맨 마지막에만 찍힌 이유가 
// function topPae() 함수 내에 for문안에 var tmpDiv 안했으니까 전역변수로 값 할당 되었고
// startEvent함수 내부에 tmpDiv.style.backgroundImage이 전역변수 값 불러올수 있겠지// 전역변수로 설정되어있으니까.
// 그런데 위의 예로 컴퓨터가 기억하는건 맨 마지막에 생성된 tmpDiv값이고 그게 전역변수 tmpDiv의 값이니 startEvent함수가 호출될때 총 12번 반복하지만
// 맨마지막 이미지에 총 12번 덮어씌워지게 되니까.. 우리 눈에 보이는건 맨마지막에 덮어씌워진 이미지가 보이는거로 결과가 나온거지..


// function startEvent() {
//     for(var i = 0; i < 12; i++) {
//         var randomNum = Math.floor(Math.random() * numbers.length)
//         arry.push(numbers[randomNum])
//         numbers.splice(randomNum,1)
//         tmpDiv.style.backgroundImage = "URL(JPG/pae" + arry[1] +".jpg)"
//     }
// }


    