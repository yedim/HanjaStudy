<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
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
	

<%
	request.setCharacterEncoding("UTF-8");
	String num =request.getParameter("num") ;
	String lineNumber = request.getParameter("lineNumber");
	String hanja = request.getParameter("hanja");
	String meaning = request.getParameter("meaning");
	String isCorrect = request.getParameter("isCorrect");

	String incorrectfilePath = request.getRealPath("/txtfile/틀린한자.txt");
	String correctfilePath = request.getRealPath("/txtfile/맞춘한자.txt");

	BufferedWriter correct_bw;
	BufferedWriter incorrect_bw;

	PrintWriter correct_writer;
	PrintWriter incorrect_writer;

	try{
		if(isCorrect!=null && lineNumber!=null)
		{
			if(Integer.parseInt(num)==0){
				correct_bw= new BufferedWriter(new FileWriter(correctfilePath));
				correct_writer = new PrintWriter(correct_bw);
				correct_writer.print("");
				correct_writer.flush();
				correct_writer.close();

				incorrect_bw= new BufferedWriter(new FileWriter(incorrectfilePath));
				incorrect_writer = new PrintWriter(incorrect_bw);
				incorrect_writer.print("");
				incorrect_writer.flush();
				incorrect_writer.close();
				System.out.println("초기화");
			}
			
			if(isCorrect.contains("true")) //맞춘한자
			{
				correct_bw= new BufferedWriter(new FileWriter(correctfilePath,true));
				correct_writer = new PrintWriter(correct_bw,true);
				correct_writer.print(lineNumber+","+hanja+","+meaning);
				correct_writer.println();
				correct_writer.flush();
				correct_writer.close();
			}
			else if(isCorrect.contains("false"))
			{
				incorrect_bw= new BufferedWriter(new FileWriter(incorrectfilePath,true));
				incorrect_writer = new PrintWriter(incorrect_bw,true);
			
				incorrect_writer.print(lineNumber+","+hanja+","+meaning);
				incorrect_writer.println();
				incorrect_writer.flush();
				
				incorrect_writer.close();
			}
		}
	}
	catch(Exception e){
		e.getStackTrace();
	}
	
%>
	
</body>
</html>