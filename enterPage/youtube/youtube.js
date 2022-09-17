var navTag = document.getElementById("menu")
var categoryTextTag = document.getElementsByClassName("category-text")
var navButtonTag = document.getElementsByClassName("nav-button")
var categoryTag = document.getElementsByClassName("category")
var videoContentsTag = document.getElementById("video-contents")

function createIframeTag() {
    var videoArry = []
    var videoTag = document.getElementsByClassName("video")
    var videoFiles = [
        "https://www.youtube.com/embed/V6xoexG91wU",
        "https://www.youtube.com/embed/NoHvWxfKcyU",
        "https://www.youtube.com/embed/sKCnQ6NFLEU",
        "https://www.youtube.com/embed/oVB1WqJwuXA",
        "https://www.youtube.com/embed/BcbmFxbdsJ0",
        "https://www.youtube.com/embed/kJYg7FrWvbQ",
        "https://www.youtube.com/embed/AggGDj_IVTU",
        "https://www.youtube.com/embed/7El2tW2-lq8",
        "https://www.youtube.com/embed/ykaSCAp9ysw",
        "https://www.youtube.com/embed/XfX6_IX_oQ8",
        "https://www.youtube.com/embed/yvLCK04KGdc",
        "https://www.youtube.com/embed/CDE-nfZULw0",
        "https://www.youtube.com/embed/Upv_qByoUc0",
        "https://www.youtube.com/embed/aXTkswSxmQs",
        "https://www.youtube.com/embed/PXcw20h7_0c",
        "https://www.youtube.com/embed/PNG5fJ22CBk"
    ]
    for(var i = 0; i < videoFiles.length; i++) {
        videoArry[i] = document.createElement("iframe")
        videoArry[i].src = videoFiles[i]
        videoTag[i].appendChild(videoArry[i])
    }
    // console.log(videoArry)
}
createIframeTag()

function createImgTag() {
    var imgArry = []
    var imgTag = document.createElement("logo")
    var imgFiles = [
        "junst.jpg",
        "mancar.jpg",
        "BBEJJU.jpg",
        "tastesangmu.jpg",
        "monkeybgm.jpg",
        "jjambbong.jpg",
        "sukaworld.jpg",
        "hogusave.jpg",
        "adult.jpg",
        "hogusave.jpg",
        "YoiKi.jpg",
        "itsub.jpg",
        "junst.jpg",
        "shotbox.jpg",
        "BDNS.jpg",
        "Ens.jpg"
    ]
    for(var i = 0; i < imgFiles.length; i++) {
        var divTag = document.getElementsByClassName("channel-logo")
        imgArry[i] = document.createElement("img")
        imgArry[i].className = "logo"
        imgArry[i].src = imgFiles[i]
        divTag[i].appendChild(imgArry[i])
    }
}
createImgTag()

function menuClickEvent() {
    if (navTag.style.width != "240px") {
        openMenu()
    }
    else {
        closeMenu()
    }
}

function openMenu() {
    navTag.style.width = "240px"
    videoContentsTag.style.marginLeft = "240px"
    

    for(var i = 0; i < categoryTextTag.length; i++) {
        categoryTextTag[i].style.fontSize = ("18px")
    }
    for(var i = 0; i <navButtonTag.length; i++) {
        navButtonTag[i].style.width = ("30px")
        navButtonTag[i].style.marginLeft = ("15px")
    }
    for(var i = 0; i < categoryTag.length; i++) {
        categoryTag[i].style.display = ("flex")
        categoryTag[i].style.marginTop = ("10px")
    }
}

function closeMenu() {
    videoContentsTag.style.marginLeft = "60px"
    navTag.style.width = ("60px")
    navTag.style.display = ("flex")
    navTag.style.justifyContent = ("column")
    for(var i = 0; i < categoryTag.length; i++) {
        categoryTag[i].style.display = ("block")
    }
    for(var i = 0; i < categoryTextTag.length; i++) {
        categoryTextTag[i].style.fontSize = ("13px")
    }
}