<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="http://localhost:82/socket.io/socket.io.js"></script>
<script src="/webjars/jquery/3.4.1/jquery.min.js"></script>

<style>
#myCanvas {
    width: 800px;
    min-width: 800px;
    height: 500px;
    min-height: 500px;
    border: 1px solid black;
}
#msg {
    width: 700px;
}
#msg_process {
    width: 90px;
}
</style> 
</head>
<body>
	<canvas id="myCanvas" width="800" height="500"></canvas>
    <input type="text" id="msg">
    <button id="msg_process">전송</button>


</body>

<script>
	$(function() {
		var canvas = document.getElementById("myCanvas"); 
		 
		context = canvas.getContext("2d");
		 
	    context.lineWidth = 5; // 선 굵기를 2로 설정
	    context.strokeStyle = "blue";
	 
	    // 마우스 리스너 등록. e는 MouseEvent 객체
	    canvas.addEventListener("mousemove", function (e) { move(e) }, false);
	    canvas.addEventListener("mousedown", function (e) {
	    	if(e.which == 1) {
	    		down(e) 
	    	}
	    }, false);
	    canvas.addEventListener("mouseup", function (e) { up(e) }, false);
	    canvas.addEventListener("mouseout", function (e) { out(e) }, false);
	
	 
	var startX=0, startY=0; // 드래깅동안, 처음 마우스가 눌러진 좌표
	var drawing=false;
	function draw(curX, curY) {
	    context.beginPath();
	    context.moveTo(startX, startY);
	    context.lineTo(curX, curY);
	    context.stroke();
	}
	function down(e) {
	    startX = e.offsetX; startY = e.offsetY;
	    drawing = true;
	}
	function up(e) { drawing = false; }
	var idx = 0;
	function move(e) {
	    if(!drawing) return; // 마우스가 눌러지지 않았으면 리턴
	    var curX = e.offsetX, curY = e.offsetY;
	    console.log(idx + "::    " + curX + " :: " + curY);
	    idx++;
	    draw(curX, curY);
	    startX = curX; startY = curY;
	    
	}
	
	
	function out(e) { drawing = false; }

        
        //msg_process를 클릭할 때
        $("#msg_process").click(function(){
            //소켓에 send_msg라는 이벤트로 input에 #msg의 벨류를 담고 보내준다.
             socket.emit("send_msg", $("#msg").val());
            //#msg에 벨류값을 비워준다.
            $("#msg").val("");
        });
        
        socket.on('send_msg', function(msg) {
        	$('<div></div>').text(msg).appendTo("#chat_box");
        });
	});
</script>
</html>