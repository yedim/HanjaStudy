<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<title>Insert title here</title>
<script type="text/javascript" src="handwriting.js"></script>
<script type="text/javascript" src="handwriting.canvas.js"></script>
<style>

.tab {
  display: none;
}
img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    width:20%;
}
.divStyle
{
    display: block;
	margin-left: auto;
    margin-right: auto;
}
.loginout
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
		if(levels[0].contains(checkId) && checkId!=null)
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
		<div class="loginout" style="right:2%; top:3%"><a href ="Logout.jsp">LogOut</a></div>
		<div class="loginout"><h6><%=checkName%>님 안녕하세요.</h6></div>
		<div id="levelText" class="loginout" style="right:2%; top:5%"><h6><%=checkLevel%>레벨 입니다.</h6>
		<button class="w3-button w3-white w3-border" onclick="hint()">힌트</button>
		</div>
		
<% }%>
		
	<center>
	<div class="article-style divStyle" itemprop="articleBody">
    <h6 id="demo" style="color:white">쓰기퀴즈</h6>
    <div id="mean" style="font-size:1.5em;margin-top:2%;font-weight:bold"></div>
    
	<div>
  <span style="display : inline-block">
    <canvas id="canvas" width="400" height="400" style="border: 2px solid grey; cursor: crosshair;"></canvas>
    <form style="display:none">
      Language:
      <select id="language">
        <option value="zh_TW" selected="selected">Chinese</option>
      </select>
    </form>
    <br>
    <button class="w3-button w3-white w3-border" onclick="canvas.erase();">지우기</button>
    <button class="w3-button w3-white w3-border" onclick="canvas.undo()">뒤로</button>
    <button class="w3-button w3-white w3-border" onclick="
      var e = document.getElementById('language');
      canvas.setOptions({language: e.options[e.selectedIndex].value});
      canvas.recognize();
    ">입력완료</button>

    <br>
     <div id="result" style="border:2px solid grey; height:30px;"></div>
     <div style="overflow:auto;">
    <div style="float:right;">
      <button class="w3-button w3-blue-grey w3-border" type="button" id="nextBtn" onclick="nextPrev(1)">Next</button>
    </div>
  </div>
  </span>
  <script type="text/javascript" src="handwriting.canvas.js"></script>
  <script type="text/javascript" defer>
    var canvas = new handwriting.Canvas(document.getElementById('canvas'), 3);
    var width = document.getElementById("demo").clientWidth
    canvas.cxt.canvas.width  = width < 400 ? width : 400;
    canvas.cxt.canvas.height = width < 400 ? width : 400;
    canvas.setCallBack(function(data, err) {
      if (err) throw err;
      else {
        var resultId=document.getElementById("result")
        while (resultId.hasChildNodes()) {
          resultId.removeChild(resultId.firstChild);
        }
        var str = data.toString();
        for(i=0;i<data.length;i+=2)
        {
           var x = document.createElement("INPUT");
           x.setAttribute("type", "button");
           var sub=str.substring(i,i+1);
           x.setAttribute("value",sub);
           x.setAttribute("id",sub);
           x.onclick=function(){
            reply_click(this.id);
           }
          resultId.appendChild(x);
        }
      }
      // else document.getElementById("result").innerHTML = data;
    });
    canvas.set_Undo_Redo(true, true);
    var penSize = document.getElementById("penSize");
    penSize.addEventListener("mousemove", function() {
      document.getElementById("lineWidth").innerHTML = penSize.value;
    });
    penSize.addEventListener("change", function(){
      canvas.setLineWidth(penSize.value);
    });
  </script>
	</div>

    </div>
	</center>
	

<%
	String filePath = request.getRealPath("/txtfile/level3.txt");
	BufferedReader br= new BufferedReader(new FileReader(filePath));
	String ss=null;
	int questionRandom[] =new int[10];//10개만
	String[] strArr = new String[3];
	ArrayList<String[]> questionlist= new ArrayList<String[]>();
		
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
		%>
		<script>
		var i=0;
		var mean= document.getElementById("mean");
		 var tab = document.createElement("div");
		 tab.className="tab";
		 tab.appendChild(document.createTextNode("<%=strArr[2]%>"));
		 var p= document.createElement("p");
		 p.setAttribute("id","pTag<%=i%>");
		 p.style.color="white";
		 p.innerHTML="<%=strArr[1]%>";
		 tab.appendChild(p);
		 mean.appendChild(tab);
		
		</script>
		<%
	}

%>
	<script>
	var mean= document.getElementById("mean");

	var currentTab = 0; // Current tab is set to be the first tab (0)
	showTab(currentTab); // Display the crurrent tab

	var isTrue=0;
	function showTab(n) {
	  var x = document.getElementsByClassName("tab");
	  x[n].style.display = "block";
	  
	  if (n == (x.length - 1)) {
	    document.getElementById("nextBtn").innerHTML = "메뉴로";
	  } else {
	    document.getElementById("nextBtn").innerHTML = "Next";
	  }
	}
	
	function nextPrev(n) {
		  var x = document.getElementsByClassName("tab");
		  x[currentTab].style.display = "none";
		  currentTab = currentTab + n;
		  if (currentTab >= x.length) {
			  location.href="main.jsp";
 		    //document.getElementById("regForm").submit();
 		    return false;
		  }
		  showTab(currentTab);
	}
	
	function reply_click(clicked_id)
	{
		var p=document.getElementById("pTag"+currentTab);
		alert(p.innerHTML);
	    //alert(clicked_id);
	    if(p.innerHTML==clicked_id)
	    {
	    	isTrue+=1;
	    	alert("정답입니다");
	    	nextPrev(1);
	 	    canvas.erase();
	    		
	    }
	    else
    	{
	    	alert("틀렸습니다. 다시 시도해주세요");    	
    	}
	   
	}
	
	function hint(clicked_id)
	{
		var p=document.getElementById("pTag"+currentTab);
		alert(p.innerHTML);
	}
	</script>
	
	 <center><img src="hanja_text03.png" id="footer"></img></center>
	
</body>
</html>