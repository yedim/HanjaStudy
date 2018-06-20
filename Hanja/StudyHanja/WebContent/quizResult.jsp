<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="quizResult.css">
<style type="text/css">
.loginout
{
	position:absolute;
	top:1%;
	right:6%;
	font-size:1.5em;
}
</style>
</head>
<body>
<%
	String checkName=null;
	String checkId=null;
	String checkLevel=null;
	
	String levelfilePath = request.getRealPath("/txtfile/회원.txt");
	BufferedReader level_br= new BufferedReader(new FileReader(levelfilePath));
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
		<div id="loginout" class="loginout" style="right:2%; top:4%"><a href ="Logout.jsp">LogOut</a></div>
		<div id="loginout" class="loginout" style="right:7%; "><h6><%=checkName%>님 안녕하세요.</h6></div>
		<div id="loginout" class="loginout" style="right:2%; top:5%"><h6><%=checkLevel%>레벨 입니다.</h6></div>
<% }%>
	

 <center><img src="hanja_text05.png" style="margin-top:2%;width:10%"></img></center>
 <hr></hr>
 <button id="button" onclick="location.href='main.jsp'" >메뉴로</button>
 
<%
	request.setCharacterEncoding("UTF-8");
	String level =request.getParameter("level");

	String allIncorrectfilePath = request.getRealPath("/txtfile/전체틀린한자.txt");
	String correctfilePath = request.getRealPath("/txtfile/맞춘한자.txt");
	String incorrectfilePath = request.getRealPath("/txtfile/틀린한자.txt");
	String memberfilePath = request.getRealPath("/txtfile/회원.txt");

	BufferedReader incorrect_br= new BufferedReader(new FileReader(incorrectfilePath));
	String incorrect_ss=null;
	ArrayList<String[]> incorrect_strList= new ArrayList<String[]>();
	
	BufferedReader correct_br= new BufferedReader(new FileReader(correctfilePath));
	String correct_ss=null;
	ArrayList<String[]> correct_strList= new ArrayList<String[]>();
	
	BufferedReader member_br= new BufferedReader(new FileReader(memberfilePath));
	String member_ss=null;
	ArrayList<String[]> member_strList= new ArrayList<String[]>();
	
	BufferedWriter bw= new BufferedWriter(new FileWriter(allIncorrectfilePath,true));
	PrintWriter writer = new PrintWriter(bw,true);

	BufferedWriter member_bw;
	PrintWriter member_writer;

	String[] str = new String[3];
	String memberStr[] = new String[4];

	try{
		while(true){
			incorrect_ss = incorrect_br.readLine();
			if(incorrect_ss==null)break;
			words= incorrect_ss.split(",");
			incorrect_strList.add(words);
		}
		incorrect_br.close();
	}catch(Exception e){	
		e.getStackTrace();
	}
	
	try{
		while(true){
			correct_ss = correct_br.readLine();
			if(correct_ss==null)break;
			words = correct_ss.split(",");
			correct_strList.add(words);
		}
		correct_br.close();
	}catch(Exception e){	
		e.getStackTrace();
	}
	
	try{
		while(true){
			member_ss = member_br.readLine();
			if(member_ss==null)break;
			words = member_ss.split(",");
			member_strList.add(words);
		}
		member_br.close();
	}catch(Exception e){	
		e.getStackTrace();
	} 
	
	try //전체 틀린 한자에 쓰기
	{
		for(int i=0; i<incorrect_strList.size(); i++)
		{
			str=incorrect_strList.get(i);
			writer.print(str[0]+","+str[1]+","+str[2]);
			writer.println();
		}		
		writer.flush();
		writer.close();
		
	}catch(Exception e){	
		e.getStackTrace();
	}
	
	if(correct_strList.size()>=15 && level!=null &&Integer.parseInt(level.substring(5))>Integer.parseInt(checkLevel))//Integer.parseInt(level.substring(5))>Integer.parseInt(checkLevel)
	{
		member_bw= new BufferedWriter(new FileWriter(levelfilePath));
		member_writer= new PrintWriter(member_bw);
		member_writer.print("");
		member_writer.flush();
		member_writer.close();
		
		member_bw= new BufferedWriter(new FileWriter(levelfilePath,true));
		member_writer= new PrintWriter(member_bw,true);	
		for(int i=0; i<member_strList.size();i++)
		{
			memberStr=member_strList.get(i);
			if(memberStr[0].contains(checkId))
			{
				member_writer.print(memberStr[0]+","+memberStr[1]+","+memberStr[2]+","+level.substring(5));
				%>
				<script>
				var levelText= document.getElementById("levelText");
				alert("<%=level.substring(5)%>"+"레벨로 Level Up!");
				levelText.innerHTML="<%=level.substring(5)%>"+"레벨입니다.";
				</script>
				<%
			}
			else
			{
				member_writer.print(memberStr[0]+","+memberStr[1]+","+memberStr[2]+","+memberStr[3]);
			}
		}
		member_writer.flush();
		member_writer.close();
	}
%>
	<table id="correctTable">
	  <tr>
	    <th>맞은 한자</th>
	  </tr>
	</table>
	 <center><img src="hanja_text03.png" id="footer" style="top:90%;"></img></center>
	
	<table id="incorrectTable">
	  <tr>
	    <th>틀린 한자</th>
	  </tr>
	</table>

<%
	String[] strArr = new String[3];
	String[] strArr2 = new String[3];

	for(int i=0; i<correct_strList.size(); i+=2)	
	{
		strArr=correct_strList.get(i);
	%>
		<script>
		var correctTable = document.createElement("tr"); 
		var hanja_text = document.createElement("td");
		hanja_text.appendChild(document.createTextNode("<%=strArr[1]%>"));
		var hanja_mean = document.createElement("td");
		hanja_mean.appendChild(document.createTextNode("<%=strArr[2]%>"));

		correctTable.appendChild(hanja_text);
		correctTable.appendChild(hanja_mean);
	
		 document.getElementById("correctTable").appendChild(correctTable);
		</script>
		<%
		if(i+1<correct_strList.size())
		{
			strArr2=correct_strList.get(i+1);
			%>
			<script>
			var hanja_text2 = document.createElement("td");
			hanja_text2.appendChild(document.createTextNode("<%=strArr2[1]%>"));
			var hanja_mean2 = document.createElement("td");
			hanja_mean2.appendChild(document.createTextNode("<%=strArr2[2]%>"));
			
			correctTable.appendChild(hanja_text2);
			correctTable.appendChild(hanja_mean2);
			document.getElementById("correctTable").appendChild(correctTable);
			</script>
		<%
		}
	}
		
	for(int ii=0; ii<incorrect_strList.size(); ii+=2)	
	{
		strArr=incorrect_strList.get(ii);
		
	%>
		<script>
		var incorrectTable = document.createElement("tr"); 
		var hanja_text = document.createElement("td");
		hanja_text.appendChild(document.createTextNode("<%=strArr[1]%>"));
		var hanja_mean = document.createElement("td");
		hanja_mean.appendChild(document.createTextNode("<%=strArr[2]%>"));
		
		incorrectTable.appendChild(hanja_text);
		incorrectTable.appendChild(hanja_mean);
		document.getElementById("incorrectTable").appendChild(incorrectTable);
		</script>
	<%
		if(ii+1<incorrect_strList.size())
		{
			strArr2=incorrect_strList.get(ii+1);
			%>
			<script>
			var hanja_text2 = document.createElement("td");
			hanja_text2.appendChild(document.createTextNode("<%=strArr2[1]%>"));
			var hanja_mean2 = document.createElement("td");
			hanja_mean2.appendChild(document.createTextNode("<%=strArr2[2]%>"));
			
			incorrectTable.appendChild(hanja_text2);
			incorrectTable.appendChild(hanja_mean2);
			document.getElementById("incorrectTable").appendChild(incorrectTable);
			</script>
		<%
		}		
	}
%>

</body>
</html>