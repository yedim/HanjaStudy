<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<title>한자공부</title>
<style>
 .btn
 {
 	padding:10%;
 	width:60%;
 	margin-bottom:2%; 
 	font-size:1.2em;
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
#loginout
{
	position:absolute;
	top:2%;
	right:5%;
}
</style>
</head>
<body>
<%
	String checkName=null;
	String checkId=null;
	String checkLevel=null;
	
	String levelPath = request.getRealPath("/txtfile/회원.txt");
	BufferedReader level_br= new BufferedReader(new FileReader(levelPath));
	String level_ss=null;
	ArrayList<String[]> level_strList= new ArrayList<String[]>();
	String[] words;
	String[] levels=new String[4];

	try{
		while(true){
			level_ss = level_br.readLine();
			if(level_ss==null)break;
			words= level_ss.split(",");
			level_strList.add(words);
		}
		level_br.close();
	}catch(Exception e){	
		e.getStackTrace();
	}
	
	checkName=(String)session.getAttribute("s_Name");
	checkId=(String)session.getAttribute("s_ID");
	
	for(int i=0; i<level_strList.size();i++)
	{
		levels=level_strList.get(i);
		if(levels[0].contains(checkId) &&checkId!=null)
		{
			checkLevel=levels[3];
		}
	}
	
	if(checkId==null || checkId.equals(""))//이름없거나null이면
	{
		%>
		<div id="loginout"><a href ="index.jsp">Login</a></div>
	<%}
	else
	{
		%>
		<div id="loginout" style="right:2%; top:3%"><a href ="Logout.jsp">LogOut</a></div>
		<div id="loginout"><h6><%=checkName%>님 안녕하세요.</h6></div>
		<div id="loginout"style="right:2%; top:5%"><h6><%=checkLevel%>레벨 입니다.</h6></div>
<% }%>
	
	
<center><img src="hanja_text.png" style="padding-top:9%;"></img></center>
 <center><img src="hanja_text06.png" style="margin-top:1%; width:10%"></img></center>
 <hr></hr>

<form method="post" action="quiz.jsp" name="fileSend">
	<input type="hidden" name="filePath" value="">
</form>
<div class="w3-row w3-container" style="margin:2.2% 30%;">
  <div class="w3-col s6 w3-center">
	  <button class="w3-button w3-white w3-border w3-round-large btn" onclick="location.href='inCorrectLook.jsp'">한자보기</button>
  </div>
  <div class="w3-col s6 w3-center">
  	<button class="w3-button w3-white w3-border w3-round-large btn" onclick="quiz();">복습퀴즈</button>
  </div>
</div>
  <center><img src="hanja_text03.png" style="margin-top:5%;"></img></center>
 
 <script>
 function quiz()
 {
	 var form = document.fileSend;
     form.filePath.value="전체틀린한자";
     form.submit();
 }
 </script>
</body>
</html>