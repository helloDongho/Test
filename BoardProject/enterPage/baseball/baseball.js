    var NumBtnContainerTag = document.getElementById("Num-Btns-container")
    var inputNumsAry = [] 
    var optionButtonAC = document.createElement("button")
    var optionButtonEnter = document.createElement("button")
    var optionButtonStart = document.createElement("button")
    var answersAry = []
    var count = 0

function createInputElement() {
    var inputTag = document.getElementById("Input-Nums")
    for(var i = 0; i < 3; i++) {
        var inputNums = document.createElement("input")
        inputNums.className = "Number"
        inputNums.setAttribute("type","text")
        inputNumsAry.push(inputNums)       
        inputTag.appendChild(inputNumsAry[i])
    }
}
createInputElement()

function createOptionBtns() {
    var optionBtnTag = document.getElementById("Option-Btns")
    var optionButtonAry = [optionButtonAC, optionButtonEnter, optionButtonStart]
    for(var i = 0; i < optionButtonAry.length ; i++) {
        if(optionButtonAry[i] == optionButtonAC) {
            optionButtonAry[i].className = "OpBtns"
            optionButtonAry[i].innerHTML = "Ac"
        }else if(optionButtonAry[i] == optionButtonEnter) {
            optionButtonAry[i].className = "OpBtns"
            optionButtonAry[i].innerHTML = "Enter"
        }else if(optionButtonAry[i] == optionButtonStart) {
            optionButtonAry[i].className = "OpBtns"
            optionButtonAry[i].innerHTML = "Start"
        }
        optionBtnTag.appendChild(optionButtonAry[i])
    }
}
createOptionBtns()

function createTopNumBtn() {
    var NumBtnTopTag = document.getElementById("top-Btn-container")
    var TopNumBtns1 = document.createElement("button")
    var TopNumBtns2 = document.createElement("button")
    var TopNumBtns3 = document.createElement("button")
    var TopNumBtnAry = [TopNumBtns1, TopNumBtns2, TopNumBtns3]
    for(var i = 0; i < TopNumBtnAry.length; i++) {
        if(TopNumBtnAry[i] == TopNumBtns1) {
            TopNumBtnAry[i].className = "TopBtnNum"
            TopNumBtnAry[i].innerHTML = "1"
            TopNumBtnAry[i].value = "1"
        }else if(TopNumBtnAry[i] == TopNumBtns2) {
            TopNumBtnAry[i].className = "TopBtnNum"
            TopNumBtnAry[i].innerHTML = "2"
            TopNumBtnAry[i].value = "2"
        }else if(TopNumBtnAry[i] == TopNumBtns3) {
            TopNumBtnAry[i].className = "TopBtnNum"
            TopNumBtnAry[i].innerHTML = "3"
            TopNumBtnAry[i].value = "3"
        }
        NumBtnTopTag.appendChild(TopNumBtnAry[i])
    }
    // console.log(NumBtnTopTag)
}
createTopNumBtn()

function createMidBtn() {
    var NumBtnMidTag = document.getElementById("middle-Btn-container")
    var MidNumBtns4 = document.createElement("button")
    var MidNumBtns5 = document.createElement("button")
    var MidNumBtns6 = document.createElement("button")
    var MidNumBtnAry = [MidNumBtns4, MidNumBtns5, MidNumBtns6]
    for(var i = 0; i < MidNumBtnAry.length; i++ ) {
        if(MidNumBtnAry[i] == MidNumBtns4) {
            MidNumBtnAry[i].className = "MidBtnNum"
            MidNumBtnAry[i].innerHTML = "4"
            MidNumBtnAry[i].value = "4"
            
        }else if(MidNumBtnAry[i] == MidNumBtns5) {
            MidNumBtnAry[i].className = "MidBtnNum"
            MidNumBtnAry[i].innerHTML = "5"
            MidNumBtnAry[i].value = "5"
        }
        else if(MidNumBtnAry[i] == MidNumBtns6) {
            MidNumBtnAry[i].className = "MidBtnNum"
            MidNumBtnAry[i].innerHTML = "6"
            MidNumBtnAry[i].value = "6"
        }
        NumBtnMidTag.appendChild(MidNumBtnAry[i])
    }
    // console.log(NumBtnMidTag)
}
createMidBtn()

function createBotBtn() {
    var NumBtnBotTag = document.getElementById("bottom-Btn-container")
    var BotNumBtns7 = document.createElement("button")
    var BotNumBtns8 = document.createElement("button")
    var BotNumBtns9 = document.createElement("button")
    var BotNumBtnAry = [BotNumBtns7, BotNumBtns8, BotNumBtns9]
    for(var i = 0; i < BotNumBtnAry.length; i++) {
        if(BotNumBtnAry[i] == BotNumBtns7) {
            BotNumBtnAry[i].className = "BotBtnNum"
            BotNumBtnAry[i].innerHTML = "7"
            BotNumBtnAry[i].value = "7"
        }
        else if(BotNumBtnAry[i] == BotNumBtns8) {
            BotNumBtnAry[i].className = "BotBtnNum"
            BotNumBtnAry[i].innerHTML = "8"
            BotNumBtnAry[i].value = "8"
        }
        else if(BotNumBtnAry[i] == BotNumBtns9) {
            BotNumBtnAry[i].className = "BotBtnNum"
            BotNumBtnAry[i].innerHTML = "9"
            BotNumBtnAry[i].value = "9"
        }
        NumBtnBotTag.appendChild(BotNumBtnAry[i])
    }
    // console.log(NumBtnBotTag)
}
createBotBtn()


// 버튼 value 값 input에 넣기 
function btnClickHandler(event) {
    if(inputNumsAry[0].value == 0){
        inputNumsAry[0].value = event.target.value
    }
    else if(inputNumsAry[1].value == 0) {
        inputNumsAry[1].value = event.target.value
    }
    else if(inputNumsAry[2].value == 0) {
        inputNumsAry[2].value = event.target.value
}
// console.log(event.target)
}

function resetHandler(event) {
    for(var i = 0; i < inputNumsAry.length; i++) {
        inputNumsAry[i].value = ''
    }
}


function MakeRandomNumHandler() {
    var numsAry = [1,2,3,4,5,6,7,8,9]
    for(var i = 0; i < 3; i++) {
        var RandomNum = Math.floor(Math.random() * numsAry.length)
        answersAry.push(numsAry[RandomNum])
        numsAry.splice(RandomNum,1)
    }
    console.log(answersAry)
}


function compareNumHandler() {
    var inputNumsSum = inputNumsAry[0].value + inputNumsAry[1].value  + inputNumsAry[2].value 
    var strike = 0
    var ball = 0
    count++

    var tr = document.createElement("tr")
    var td1 = document.createElement("td")
    var td2 = document.createElement("td")
    var tableTag = document.getElementById("dataTable")
    // inputNumsAry= 3,1,2
    // answersAry[2,1,5]
    for(var i = 0; i < answersAry.length; i++) {
        var value = inputNumsSum.indexOf(answersAry[i])
        if(value > -1) {
            if(value == i) {
                strike++
            }
            else {
                ball++
            }
        }
    }
    if(strike == 3){
        alert('you Win')
        inputNumsAry[0].value = ''
        inputNumsAry[1].value = ''
        inputNumsAry[2].value = ''
        strike = 0
        ball = 0
        count = 0
        return;
    }
    else if(count > 9) {
        alert("you Lose")
        inputNumsAry[0].value = ''
        inputNumsAry[1].value = ''
        inputNumsAry[2].value = ''
        strike = 0
        ball = 0
        count = 0
        return;
    }
    td1.innerHTML = inputNumsSum
    td2.innerHTML = strike + "strike" + ball + "ball"
    tr.append(td1,td2)
    tableTag.appendChild(tr)
}



function addEventListener() {
    NumBtnContainerTag.addEventListener("click",btnClickHandler)
    optionButtonAC.addEventListener("click",resetHandler)
    optionButtonStart.addEventListener("click",MakeRandomNumHandler)
    optionButtonEnter.addEventListener("click",compareNumHandler)
}

addEventListener()




/* 생각을 해보자
자바스크립트에서 동적으로 태그를 만든 다음
태그에 속성을 부여 했어 
type text 그럼 input type text라는 태그가 만들어졌을것이고
그것을 classname해서 class 이름을 붙여줬어

그럼이제 해야할건 반복적으로 생성해야됨
어떻게 하면 저 생성한 inputTag를 for문을 이용해서
반복적으로 생성할수 있을까?
배열에 inputTag를 담아서 해야되나?
[inputTag, inputTag, inputTag] 이렇게 같은거 3개 담아도되나?
굳이 배열에 담을 필요는 없지 ㅋㅋㅋ 
왜 굳이 코드량을 늘여서 ㅈ같이 코드를 짜려고 하냐 ㄹㅇㅋㅋ ㅄ도아니고

두번째 문제 발생 

Btn 태그 반복 생성하고 각각의 Btn태그에다가 값을 따로 줄순 없는건가?
배열에 담으면 각각의 요소에 접근할수 있는건 알겠음 

그럼 배열에 담아서 각각의 요소에 접근하려면 3개 생성해서 배열에 하나씩 넣는방법이 있겠지?
자 그럼 배열에 하나 씩 담았어
각 요소들을 수정하려면 당연히 if else if else로 수정해야되겠지?
if 첫번째 배열의 요소에 접근
근데 그 첫번째 요소라면?

첫번째 요소가 아니라면?
*/