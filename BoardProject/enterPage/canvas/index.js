var changeLineWidthTag = document.getElementById("change-lineWidth")
var canvasTag = document.getElementById("canvas")
var canvasDraw = canvasTag.getContext("2d")
var colorContainerTag = document.getElementById("color-container")
var drawpaint = false;
canvas.width = 1200;
canvas.height = 650;
canvasDraw.lineWidth = "5"


function mousemoveHandler(event) {
    var x = event.offsetX //이벤트 리스너는 어떠한 값들을 준다. 우리가 알아야할건 마우스를 움직일때마다 그 좌표값이 필요하니.. offsetX offsetY받아옴
    var y = event.offsetY
    if(drawpaint) {
        canvasDraw.lineTo(x , y) //선을 그리는 작업 그리긴하지만 우리 눈에 보이지는 않음
        canvasDraw.stroke() // 선을 눈으로 보이게끔. fill메서드는 채워져 있는것
        return;
    }
    else {
        canvasDraw.moveTo(x, y) // 사용자의 마우스 위치의 좌표값을 받아오기 위해서 펜을 종이 위에 붕 띄워서 옮기는 것
    }
}

function mouseDownHandler() {
    drawpaint = true
}

function mouseUpHandler() {
    drawpaint = false
    canvasDraw.beginPath()
}

function mouseLeaveHandler() {
    drawpaint = false
    canvasDraw.beginPath()
}

function changeLineWidhHandler(event) {
    canvasDraw.lineWidth = event.target.value
}

function ChangeColor(event) {
canvasDraw.strokeStyle = event.target.dataset.color
}


function addEventListener() {
canvasTag.addEventListener("mousemove" , mousemoveHandler)
canvasTag.addEventListener("mousedown" , mouseDownHandler)
canvasTag.addEventListener("mouseup" , mouseUpHandler)
canvasTag.addEventListener("mouseleave" , mouseLeaveHandler)
changeLineWidthTag.addEventListener("change" , changeLineWidhHandler)
colorContainerTag.addEventListener("click", ChangeColor)
}
addEventListener()