<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="quizResult.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
.hidden
{
	width:1px;
	height:1px;
	border:0;
}
table
{
width:88%;
}
#footer
{
position:relative;
left:0%;
}
.btn
{
	border: 1px solid grey;
 	background-color: white;
    cursor: pointer;
    border-radius:1px;
    margin-left:5px;
}
.btn:hover {background-color: #e7e7e7;}
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
	
	checkName=(String)session.getAttribute("s_Name");
	checkId=(String)session.getAttribute("s_ID");
	
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
<% }%>
	
 <center><img src="hanja_text07.png" style="margin-top:5%;width:10%"></img></center>
 <hr></hr>
 <button id="button" onclick="location.href='main.jsp'" >메뉴로</button>
 <form id="form" method="post" name="deleteIncorrectFileSend" action="deleteIncorrect.jsp" >
		<input type="hidden" name="deleteData" value="">
 </form>
 <iframe class="hidden" name="hiddenifr" src="deleteIncorrect.jsp"></iframe>
	
<%
	request.setCharacterEncoding("UTF-8");

	String allIncorrectfilePath = request.getRealPath("/txtfile/전체틀린한자.txt");
	
	BufferedReader br= new BufferedReader(new FileReader(allIncorrectfilePath));
	String ss=null;
	ArrayList<String[]> strList= new ArrayList<String[]>();
	

	String[] words;
	String[] str = new String[3];
	try{
		while(true){
			ss = br.readLine();
			if(ss==null)break;
			words= ss.split(",");
			strList.add(words);
		}
		br.close();
	}catch(Exception e){	
		e.getStackTrace();
	}
	
%>
	<table id="table">
	  <tr>
	    <th>맞은 한자</th>
	  </tr>
	</table>
	 <center><img src="hanja_text03.png" id="footer"></img></center>
<%
	String[] strArr = new String[3];
	String[] strArr2 = new String[3];
	String[] strArr3 = new String[3];
	String[] strArr4 = new String[3];

	for(int i=0; i<strList.size(); i+=4)	
	{
		strArr=strList.get(i);
	%>
		<script>
		
		var table = document.createElement("tr"); 
		var hanja_text = document.createElement("td");
		hanja_text.appendChild(document.createTextNode("<%=strArr[1]%>"));
		var btn = document.createElement("button");
		btn.className="btn";
		btn.onclick= function() { deleteStr("<%=strArr[1]%>") };
		btn.appendChild(document.createTextNode("x"));
		
		var hanja_mean = document.createElement("td");
		hanja_mean.appendChild(document.createTextNode("<%=strArr[2]%>"));
		
		
		table.appendChild(hanja_text);
		table.appendChild(hanja_mean);
		hanja_text.appendChild(btn);
		 document.getElementById("table").appendChild(table);
		</script>
		<%
		if(i+1<strList.size())
		{
			strArr2=strList.get(i+1);
			%>
			<script>
			var hanja_text2 = document.createElement("td");
			hanja_text2.appendChild(document.createTextNode("<%=strArr2[1]%>"));
			var hanja_mean2 = document.createElement("td");
			hanja_mean2.appendChild(document.createTextNode("<%=strArr2[2]%>"));
			
			var btn = document.createElement("button");
			btn.className="btn";
			btn.onclick= function() { deleteStr("<%=strArr2[1]%>") };
			btn.appendChild(document.createTextNode("x"));
			
			table.appendChild(hanja_text2);
			table.appendChild(hanja_mean2);
			hanja_text2.appendChild(btn);
			document.getElementById("table").appendChild(table);
			</script>
		<%
		}
		if(i+2<strList.size())
		{
			strArr3=strList.get(i+2);
			%>
			<script>
			var hanja_text3 = document.createElement("td");
			hanja_text3.appendChild(document.createTextNode("<%=strArr3[1]%>"));
			var hanja_mean3 = document.createElement("td");
			hanja_mean3.appendChild(document.createTextNode("<%=strArr3[2]%>"));
			
			var btn = document.createElement("button");
			btn.className="btn";
			btn.onclick= function() { deleteStr("<%=strArr3[1]%>") };
			btn.appendChild(document.createTextNode("x"));
			
			table.appendChild(hanja_text3);
			table.appendChild(hanja_mean3);
			hanja_text3.appendChild(btn);

			document.getElementById("table").appendChild(table);
			</script>
		<%
		}
		if(i+3<strList.size())
		{
			strArr4=strList.get(i+3);
			%>
			<script>
			var hanja_text4 = document.createElement("td");
			hanja_text4.appendChild(document.createTextNode("<%=strArr4[1]%>"));
			var hanja_mean4 = document.createElement("td");
			hanja_mean4.appendChild(document.createTextNode("<%=strArr4[2]%>"));
			
			var btn = document.createElement("button");
			btn.className="btn";
			btn.onclick= function() { deleteStr("<%=strArr4[1]%>") };
			btn.appendChild(document.createTextNode("x"));
			
			table.appendChild(hanja_text4);
			table.appendChild(hanja_mean4);
			hanja_text4.appendChild(btn);

			document.getElementById("table").appendChild(table);
			</script>
		<%
		}
	}
		
%>
<script>
function deleteStr(hanja)
{
	 var form = document.deleteIncorrectFileSend;
     form.deleteData.value=hanja;
	 form.target = "hiddenifr";   
	 form.submit();	
	 
	 alert(hanja+"를 삭제합니다.");
	 location.reload();//새로고침
}
</script>
</body>
</html>