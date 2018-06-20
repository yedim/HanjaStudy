<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String deleteData=request.getParameter("deleteData");
	String allIncorrectfilePath = request.getRealPath("/txtfile/전체틀린한자.txt");
	BufferedReader br= new BufferedReader(new FileReader(allIncorrectfilePath));
	String ss=null;
	
	ArrayList<String[]> strList= new ArrayList<String[]>();
	
	String[] words;
	String[] str = new String[3];
	
	
	if(deleteData!=null)
	{
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
		
		BufferedWriter bw;
		bw= new BufferedWriter(new FileWriter(allIncorrectfilePath));
		PrintWriter writer;
		writer= new PrintWriter(bw);
		writer.print("");
		writer.flush();
		writer.close();

		bw= new BufferedWriter(new FileWriter(allIncorrectfilePath,true));
		writer= new PrintWriter(bw,true);
		for(int i=0; i<strList.size();i++)
		{
			str = strList.get(i);
			if(str[1].contains(deleteData))
			{
				continue;
			}
			else
			{
				writer.print(str[0]+","+str[1]+","+str[2]);
				writer.println();
			}
			
		}
		writer.flush();
		writer.close();
	}
	

	
	
	
%>

</body>
</html>