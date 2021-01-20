<%@page import="board.BoardDao"%>
<%@page import="board.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인된 상태이기 때문에 글작성자는 session scope 에서 얻어낸다.
	String writer=(String)session.getAttribute("id");
	//1. 폼 전송되는 글제목과 내용을 읽어와서 
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	//2. DB에 저장하고
	BoardDto dto=new BoardDto();
	dto.setWriter(writer);
	dto.setTitle(title);
	dto.setContent(content);
	boolean isSuccess=BoardDao.getInstance().insert(dto);
	//3. 응답한다.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/Board/private/insert.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("새글이 추가 되었습니다.");
			location.href="${pageContext.request.contextPath}/board/list.jsp";
		</script>
	<%}else{ %>
		<script>
			alert("글 작성 실패");
			location.href="${pageContext.request.contextPath}/board/private/insertform.jsp";
		</script>
	<%} %>
</body>
</html>