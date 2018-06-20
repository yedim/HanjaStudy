<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="grid.css">
<link rel="stylesheet" href="quizStyle.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
img{
	position:absolute;
	top:20%;
	left:40%;
	display:none;
}
#footer {
	position:absolute;
    display: block;
    margin: auto;
    width:20%;
    top:70%;
}
.hidden
{
	width:1px;
	height:1px;
	border:0;
}

#layer
{
	margin:auto;
	margin-top:10%;
	width:50%;
}

#regform
{
	margin:auto;
	margin-top:10%;
	width:50%;
}
input[type=button] {
    background-color: white;
    border: 1px solid grey;
    color: black;
    padding: 16px 32px;
    text-decoration: none;
    margin: 4px 2px;
    cursor: pointer;
}
input[type=button]:hover {    
	background-color: grey;
	color:white;
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
	
	request.setCharacterEncoding("UTF-8");
	String txtfilePath=request.getParameter("filePath");


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
		<div id="loginout" style="right:6%; "><h6><%=checkName%>님 안녕하세요.</h6></div>
		<div id="loginout"style="right:2%; top:5%"><h6><%=checkLevel%>레벨 입니다.</h6></div>
<% }%>

	<img src="correct.png" id="correct"></img>
	<img src="incorrect.png" id="incorrect"></img>
		
		
	<form id="regForm" method="post" name="fileSend" action="result.jsp" >
	<div class="w3-container" >
		  <div class="w3-light-grey">
		    <div id="myBar" class="w3-container w3-blue-grey" style="height:24px;width:0%">   <p id="myP"> <span id="demo">0</span> </p></div>
		  </div>
		</div>
		<input type="hidden" name="num" value="">
		<input type="hidden" name="lineNumber" value=""><!-- 파일에서 몇번째 한자인지 -->
		<input type="hidden" name="hanja" value="">
		<input type="hidden" name="meaning" value="">
	    <input type="hidden" name="isCorrect" value=""> 	    
	</form>
	<iframe class="hidden" name="hiddenifr" src="result.jsp"></iframe>
	
	<form id="regForm" method="post" name="noneClickFileSend" action="noneClickResult.jsp" >
		<input type="hidden" name="data" value="">
	</form>
	
	<iframe class="hidden" name="hiddenNoneClickifr" src="noneClickResult.jsp"></iframe>
	
	<form id="regForm" method="post" name="quizResult" action="quizResult.jsp" >
		<input type="hidden" name="level" value="">
	</form>
	
	<h1 id="width"></h1>

<script>

var regForm= document.getElementById("regForm");
var i=0;
var j=0;
for( i =0;i<20; i++)
{
  var tab = document.createElement("div");
  tab.className="tab";
  regForm.appendChild(tab);

  var gridContainer =document.createElement("div");
  gridContainer.className="grid-container";
  tab.appendChild(gridContainer);

  var gridItemTop = document.createElement("div");
  gridItemTop.className="grid-item itemTop";
  gridContainer.appendChild(gridItemTop);

   var gridItemMain = document.createElement("div");
   gridItemMain.className="grid-item itemMain";
   gridItemMain.setAttribute("id","gridItemMain"+i);
   gridContainer.appendChild(gridItemMain);

    for(j=0; j<4; j++)
    {
      var gridItem = document.createElement ("div");
      gridItem.className="grid-item";
      gridItem.setAttribute("id",i+"gridItem"+j);
      gridContainer.appendChild(gridItem);
    }

    var div =  document.createElement("div");
    div.style.overflow="auto";
    tab.appendChild(div);


}
</script>
<script>

var currentTab = 0; // Current tab is set to be the first tab (0)
showTab(currentTab); // Display the crurrent tab

function showTab(n) {
  var x = document.getElementsByClassName("tab");
  x[n].style.display = "block";

}

function nextPrev(n) {
  var x = document.getElementsByClassName("tab");

  if (currentTab >= x.length-1) {
	  location.href="quizResult.jsp";   
	  var form = document.quizResult;
      form.level.value="<%=txtfilePath%>";
	  form.submit();
	  
	  return false;
	}
  
  x[currentTab].style.display = "none";//탭 숨기기
  currentTab = currentTab + n;
   move();

  showTab(currentTab);
}

window.onload = move;

var width;
var id;
var isTimeUp=false;
var g_i=0;
function move() {
	  var elem = document.getElementById("myBar");
	  var correctImg = document.getElementById("correct");
      var incorrectImg = document.getElementById("incorrect");

	  width= 0;
 	  id = setInterval(frame, 50);
 	  function frame() {
	    if (width >= 100) {
	      clearInterval(id);
	      document.getElementById("demo").className = "w3-animate-opacity";
	      document.getElementById("demo").innerHTML = "Times' up";
		  document.getElementById("demo").style.color = "orange";
		  incorrectImg.style.display="block";
		  
		  //시간초과된 한자도 틀린한자로
		  var str=document.getElementById("correctBtn"+g_i);
		  g_i++;
		  var form = document.noneClickFileSend;
	      form.data.value=str.name;
		  form.target = "hiddenNoneClickifr";   
		  form.submit();
		  
	      setTimeout(function() {
		      nextPrev(1);
		  	  correctImg.style.display="none";
		  	  incorrectImg.style.display="none";
		  	 document.getElementById("demo").style.color = "white";
	    	}, 700);
  
	      
	    } else {
	      width++;
	      elem.style.width = width + '%';
	      var num = width * 1 / 10;
	      num = num.toFixed(0);
	      document.getElementById("demo").innerHTML = num;
	    }
	  }
}

function correct(correct, num,lineNumber,hanja,meaning)
{
	var correctImg = document.getElementById("correct");
	var incorrectImg = document.getElementById("incorrect");
	
	if(correct==true)
	{
		g_i++;
		correctImg.style.display="block";

		setTimeout(function() {
			correctImg.style.display="none";
			width=0;
		    clearInterval(id);
			nextPrev(1);

		}, 400);
	}
	else if(correct==false)
	{		
		g_i++;
		incorrectImg.style.display="block";
		setTimeout(function() {
			incorrectImg.style.display="none";
			width=0;
		    clearInterval(id);
			nextPrev(1);

		}, 400);
	}
	
      var form = document.fileSend;
      form.num.value=num;
	  form.lineNumber.value= lineNumber;
	  form.hanja.value=hanja;
	  form.meaning.value=meaning;
	  form.isCorrect.value = correct;
	  form.target = "hiddenifr";   
	  form.submit();
	
}


</script>


<%
	//음훈 퀴즈
	String filePath = request.getRealPath("/txtfile/"+txtfilePath+".txt");
	BufferedReader br= new BufferedReader(new FileReader(filePath));
	String ss=null;
	int questionRandom[] =new int[20];
	String[] strArr = new String[3];
	ArrayList<String[]> questionlist= new ArrayList<String[]>();

	int tmpRandom[] =new int[3];
	String[] tmpArr = new String[3];
	
	try{
		while(true){
			ss = br.readLine();
			if(ss==null)break;
			words = ss.split(",");
			questionlist.add(words);
		}
		br.close();
	}catch(Exception e){	
		e.getStackTrace();
	}
	
	for(int i=0; i<questionRandom.length;i++)
	{
		questionRandom[i]=(int)(Math.random() * questionlist.size()); 
		 for(int j=0;j<i;j++) //중복제거를 위한 for문 
         {
			 if(questionRandom[i]==questionRandom[j])  
             {
                 i--;
             }
         }
	}

	
	for(int i=0; i<questionRandom.length;i++){
		strArr=questionlist.get(questionRandom[i]);
		//System.out.println(Arrays.toString(strArr));
		
		for(int rand =0; rand<3; rand++)
		{
			tmpRandom[rand]=(int)(Math.random() * questionlist.size()); 
			if(tmpRandom[rand]==questionRandom[i])//중복제거
			{
				rand--;
			}
		}  
		
		%>
		<script>
		var hanjaDiv = document.createElement("div");
		hanjaDiv.appendChild(document.createTextNode("<%=strArr[1]%>"));/* 한자주입 */
		hanjaDiv.style.fontSize="4em";

		document.getElementById("gridItemMain<%=i%>").appendChild(hanjaDiv);
	
		</script>
		<%
		int r = (int)(Math.random()*4);
		int tt=0;
		for(int j=0; j<4; j++)
		{
			if(j==r)
			{
				%>
				<script>
				var strBtn = document.createElement("input");
				strBtn.setAttribute("type", "button");
				strBtn.setAttribute("id","correctBtn<%=i%>");
				strBtn.setAttribute("name","<%=strArr[0]%>"+","+"<%=strArr[1]%>"+","+"<%=strArr[2]%>");
				strBtn.setAttribute("value", "<%=strArr[2]%>");
 				strBtn.appendChild(document.createTextNode("<%=strArr[2]%>"));/* 한자주입 */
 				strBtn.onclick = function() { correct(true,"<%=i%>","<%=strArr[0]%>","<%=strArr[1]%>","<%=strArr[2]%>") };
				document.getElementById("<%=i%>gridItem<%=j%>").appendChild(strBtn);
				</script>
				<%
			}
			else
			{
				tmpArr=questionlist.get(tmpRandom[tt]);
				%>
				<script>
				var strBtn = document.createElement("input");
				strBtn.setAttribute("type", "button");
				strBtn.setAttribute("value", "<%=tmpArr[2]%>");
				strBtn.onclick = function() { correct(false,"<%=i%>","<%=strArr[0]%>","<%=strArr[1]%>","<%=strArr[2]%>") };
				document.getElementById("<%=i%>gridItem<%=j%>").appendChild(strBtn);
				</script>
				<%
				tt++;
			}	
		}
 	}
%>
 <center><img src="hanja_text03.png" id="footer"></img></center>

</body>
</html>