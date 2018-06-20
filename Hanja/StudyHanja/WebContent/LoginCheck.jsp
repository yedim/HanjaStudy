<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	String filePath = request.getRealPath("/txtfile/회원.txt");
	BufferedReader br= new BufferedReader(new FileReader(filePath));
	String ss=null;
	boolean isLogin=false;
	
	ArrayList<String[]> strList= new ArrayList<String[]>();
	
	String[] words;
	String[] str = new String[4];
	
	String id=request.getParameter("id");
	String pw=request.getParameter("pw");
	
	
	try{
		while(true){
			ss = br.readLine();
			if(ss==null)break;
			words = ss.split(",");
			strList.add(words);
			
		}
		br.close();
	}catch(Exception e){	
		e.getStackTrace();
	}
	
	for(int i=0; i<strList.size();i++)
	{
		str=strList.get(i);
		
		
		if(str[0]!=null && str[1]!=null && str[2]!=null && str[3]!=null)
		{
			if(str[0].contains(id) && str[1].contains(pw))
			{
				session.setAttribute("s_Name", str[2]);
				session.setAttribute("s_ID", str[0]);
				session.setAttribute("s_Level", str[3]);

				response.sendRedirect("main.jsp");//로그인성공		
				isLogin=true;
			}
		}
	}
	
	if(isLogin==false)
	{%>
		<script>
			alert("로그인 실패");
			history.go(-1);//이전페이지로
		</script>
	<%}
%>
</body>
</html>