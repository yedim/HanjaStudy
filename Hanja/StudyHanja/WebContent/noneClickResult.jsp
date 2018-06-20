<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String data =request.getParameter("data") ;
	String incorrectfilePath = request.getRealPath("/txtfile/틀린한자.txt");
	BufferedWriter incorrect_bw;
	PrintWriter incorrect_writer;
	try{
		if(data!=null)
		{
			incorrect_bw= new BufferedWriter(new FileWriter(incorrectfilePath,true));
			incorrect_writer = new PrintWriter(incorrect_bw,true);
		
			incorrect_writer.print(data);
			incorrect_writer.println();
			incorrect_writer.flush();
			incorrect_writer.close();
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>
</body>
</html>