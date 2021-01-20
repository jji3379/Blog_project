<%@page import="users.UsersDao"%>
<%@page import="users.UsersDto"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 후 가야하는 목적지 정보
	String url=request.getParameter("url");
	//로그인 실패를 대비해서 목적지 정보를 인코딩한 결과도 준비 한다.
	
	//1. 폼전송되는 아이디와 비밀번호를 읽어온다.
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	UsersDto dto=new UsersDto();
	dto.setId(id);
	dto.setPwd(pwd);
	//2. DB 에 실제로 존재하는 (유효한) 정보인지 확인한다.
	UsersDao dao=UsersDao.getInstance();
	boolean isValid=dao.isValid(dto);
	//3. 유효한 정보이면 로그인 처리를 하고 응답 그렇지 않으면 아이디 혹은 비밀번호가 틀렸다고 응답
	
	//체크박스를 체크 하지 않았으면 null 이다. 
	String isSave=request.getParameter("isSave");
	
	if(isSave == null){//체크 박스를 체크 안했다면
		//저장된 쿠키 삭제 
		Cookie idCook=new Cookie("savedId", id);
		idCook.setMaxAge(0);//삭제하기 위해 0 으로 설정 
		response.addCookie(idCook);
		
		Cookie pwdCook=new Cookie("savedPwd", pwd);
		pwdCook.setMaxAge(0);
		response.addCookie(pwdCook);
	}else{//체크 박스를 체크 했다면 
		//아이디와 비밀번호를 쿠키에 저장
		Cookie idCook=new Cookie("savedId", id);
		idCook.setMaxAge(60*60*24);//하루동안 유지
		response.addCookie(idCook);
		
		Cookie pwdCook=new Cookie("savedPwd", pwd);
		pwdCook.setMaxAge(60*60*24);
		response.addCookie(pwdCook);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<h1>알림</h1>
	<%if(isValid){ 
		//로그인 했다는 의미에서 session scope 에 "id" 라는 키값으로 로그인된 아이디를 담는다.
		session.setAttribute("id", id);%>		
		<p>
			<strong><%=id %></strong>님 로그인 되었습니다.
			<a href="${pageContext.request.contextPath}/index.jsp">인덱스로 가기</a>
		</p>
	<%}else{ %>
		<p>
			등록된 아이디가 없습니다.
			<a href="signup_form.jsp">회원가입 하러가기</a>
		</p>
	<%} %>
</div>
</body>
</html>