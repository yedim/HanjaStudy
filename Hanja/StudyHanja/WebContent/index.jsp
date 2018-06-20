<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="index.css">
<title>한자공부</title>
<style>
body, html {
    height: 100%;
    margin: 0;
}
img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    width:20%;
}
hr{
	display: block;
    margin-left: auto;
    margin-right: auto;
	width:5%;
	margin-top:1%;
	border:1px solid black;
}
#button:hover {background-color: #e7e7e7;}

#button
{
 	border: 1px solid grey;
 	background-color: white;
 	color:black;
 	display: block;
    margin-left: auto;
    margin-right: auto;
    width:5%;
    margin-top:3%;
    cursor: pointer;
    border-radius:10px;
    padding:10px;
}
</style>
</head>
<body>

 <center><img src="hanja_text.png" style="padding-top:10%;"></img></center>
 <center><img src="hanja_text02.png" style="margin-top:1%; width:10%"></img></center>
 <hr></hr>
<button id="button" onclick="document.getElementById('id01').style.display='block'" >Login</button>
 <center><img src="hanja_text03.png" style="margin-top:8%;"></img></center>
 
	<div id="id01" class="modal">
	
	  <form class="modal-content animate" method="post" action="LoginCheck.jsp">
	    <div class="imgcontainer">
	      <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
	    </div>
	
	    <div class="container">
	      <label for="uname"><b>Id</b></label>
	      <input type="text" placeholder="Enter Id" name="id" required>
	
	      <label for="psw"><b>Password</b></label>
	      <input type="password" placeholder="Enter Password" name="pw" required>
	        
	      <button type="submit">Login</button>
	    </div>
	
	    <div class="container" style="background-color:#f1f1f1;padding:20px">
	    </div>
	  </form>
	</div>
 
<script>
var modal = document.getElementById('id01');

window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>
</body>
</html>