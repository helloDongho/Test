var personNum = parseInt(prompt("인원수 입력하세요"))
var buttonTag = document.getElementById("sbmbutton")
var inputTag = document.getElementById("input-Text")
var textTag = document.getElementById("text")
var spannumberTag = document.getElementById("number")
var timerTag = document.getElementById("time")
var wordSave = []
var word //첫번째 제시어
var newWord // 첫번째 이후 제시어\
var timer
var sec = 10;
var secTag = document.getElementById("sec")
var order = parseInt(spannumberTag.innerHTML)    // 숫자로 인식하게 하기 위해서 parseInt

function clickButtonHandler() {
    if(!word) { //비어있으면 (첫번째 입력 한 사람이 제시어 제공)
        word = newWord //첫번째 사람이 제시어 입력
        textTag.innerHTML = word
        inputTag.value = ''
        wordSave.push(word) // 처음 입력했을때는 그냥 배열안에 넣어두고
        console.log(wordSave)
        if (order == personNum) {
            spannumberTag.innerHTML = 1
        }
        else {
            spannumberTag.innerHTML = order + 1
        }
    } else { // 비어있지 않으면
        if(word[word.length - 1] === newWord[0]) { 
            word = newWord //입력한 단어가 다시 제시어가 됨 ex) 1.쿵쿵따(제시어) 2.따라지(새로운제시어) 
            textTag.innerHTML = word
            inputTag.value = ''
            if(wordSave.indexOf(word) == -1) { // 턴이 돌아서 같은 단어가 있지 않을때만 배열에 넣기
                wordSave.push(word)
                console.log(wordSave)  
            } else {
                alert("이미 언급한 단어입니다.")
            }
            if (order == personNum) {
                spannumberTag.innerHTML = 1
            } else {
                spannumberTag.innerHTML = order + 1
            }
    
        } else{ //다른 단어 입력했을때 ex 가나다// 나가다 << 안됨
            alert("다시 입력 하세요")
        }
    }
}
function clickTimerHandler() {
    
    if(wordSave.length > 1) {
        timerStop()
        sec = 10
        secTag.innerHTML = 10
    }
    timer = setInterval(function(){
        sec--
        secTag.innerHTML = sec
        if(sec == 0) {
            alert("you are lose")
            timerStop()
            sec = 10
            secTag.innerHTML = 10
        }
    },1000)
}

function timerStop() {
    clearInterval(timer)
}


function inputHanlder(event) {
    newWord = event.target.value
}

    buttonTag.addEventListener("click",clickButtonHandler)
    buttonTag.addEventListener("click", clickTimerHandler)
    inputTag.addEventListener("input" , inputHanlder)
